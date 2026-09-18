#!/usr/bin/env python3
"""Translate Cyrillic prose in tracked text files while preserving source syntax.

This is a one-shot migration helper. It deliberately edits only quoted strings,
comments, and prose-oriented files. Run the repository CI check afterwards to
find anything that needs a manual translation.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import http.cookiejar
import json
import re
import subprocess
import threading
import time
import urllib.parse
import urllib.request
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CYRILLIC = re.compile(r"[\u0400-\u04ff]")
CYRILLIC_PHRASE = re.compile(r"[\u0400-\u04ff][\u0400-\u04ff\s,!?;:.…—–-]*")
PROSE_SUFFIXES = {".md", ".txt"}
SOURCE_SUFFIXES = {".dm", ".tsx", ".ts", ".js", ".json", ".yml", ".yaml", ".html", ".dmf"}
TOKEN = re.compile(
    r"https?://[^\s<>'\"]+|<[^>\r\n]+>|\$\{[^}\r\n]+\}|"
    r"\[[^\[\]\r\n]+\]|\\[nrt\"']|\\$|%[-+0-9.]*[a-zA-Z]"
)
CACHE_PATH = Path.home() / ".bad_drakian_translation_cache.json"
THREAD_STATE = threading.local()
BROWSER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36"
)


def tracked_files() -> list[Path]:
    output = subprocess.check_output(
        ["git", "ls-files", "-z"], cwd=ROOT
    ).decode("utf-8", errors="surrogateescape")
    return [
        ROOT / name
        for name in output.split("\0")
        if name
        and not name.endswith(".bundle.js")
        and Path(name).suffix.lower() in SOURCE_SUFFIXES | PROSE_SUFFIXES
    ]


def mask_tokens(value: str) -> tuple[str, dict[str, str]]:
    replacements: dict[str, str] = {}

    def replace(match: re.Match[str]) -> str:
        original = match.group(0)
        if CYRILLIC.search(original):
            return original
        key = f"ZZPH{len(replacements):04d}ZZ"
        replacements[key] = original
        return key

    return TOKEN.sub(replace, value), replacements


def unmask_tokens(value: str, replacements: dict[str, str]) -> str:
    for key, original in replacements.items():
        value = value.replace(key, original)
        value = value.replace(key.lower(), original)
    return value


def quoted_ranges(line: str) -> list[tuple[int, int]]:
    ranges: list[tuple[int, int]] = []
    quote: str | None = None
    start = -1
    escaped = False
    for index, char in enumerate(line):
        if escaped:
            escaped = False
            continue
        if char == "\\":
            escaped = True
            continue
        if quote is None:
            if char in {'"', "'", "`"}:
                quote = char
                start = index + 1
        elif char == quote:
            ranges.append((start, index))
            quote = None
    if quote is not None:
        ranges.append((start, len(line)))
    return ranges


def comment_range(line: str, occupied: list[tuple[int, int]]) -> tuple[int, int] | None:
    for index in range(len(line) - 1):
        if line[index : index + 2] != "//":
            continue
        if any(start <= index < end for start, end in occupied):
            continue
        return index + 2, len(line)
    stripped = line.lstrip()
    if stripped.startswith("#"):
        return len(line) - len(stripped) + 1, len(line)
    return None


def collect_segments(path: Path, text: str) -> list[str]:
    if path.suffix.lower() in PROSE_SUFFIXES:
        return [line for line in text.splitlines() if CYRILLIC.search(line)]

    segments: list[str] = []
    for line in text.splitlines():
        if not CYRILLIC.search(line):
            continue
        ranges = quoted_ranges(line)
        comment = comment_range(line, ranges)
        if comment:
            ranges.append(comment)
        found = False
        for start, end in sorted(set(ranges)):
            value = line[start:end]
            if CYRILLIC.search(value):
                segments.append(value)
                found = True
        if not found:
            segments.extend(match.group(0) for match in CYRILLIC_PHRASE.finditer(line))
    return segments


def bing_state() -> dict[str, str | int]:
    state = getattr(THREAD_STATE, "bing_state", None)
    if state:
        return state
    opener = urllib.request.build_opener(
        urllib.request.HTTPCookieProcessor(http.cookiejar.CookieJar())
    )
    request = urllib.request.Request(
        "https://www.bing.com/translator", headers={"User-Agent": BROWSER_AGENT}
    )
    with opener.open(request, timeout=60) as response:
        page = response.read().decode("utf-8")
    identity = re.search(r'IG:"([A-F0-9]+)"', page)
    prevention = re.search(r"params_AbusePreventionHelper\s*=\s*(\[[^;]+\])", page)
    if not identity or not prevention:
        raise RuntimeError("could not initialize translation session")
    key, token, _ = json.loads(prevention.group(1))
    state = {"ig": identity.group(1), "key": key, "token": token, "count": 0}
    THREAD_STATE.bing_state = state
    THREAD_STATE.bing_opener = opener
    return state


def request_translation(values: list[str]) -> list[str]:
    separators = [f"ZZXQSEP{index:04d}ZZ" for index in range(1, len(values))]
    payload_parts: list[str] = []
    for index, value in enumerate(values):
        payload_parts.append(value)
        if index < len(separators):
            payload_parts.append(f" {separators[index]} ")
    payload = "".join(payload_parts)
    state = bing_state()
    state["count"] = int(state["count"]) + 1
    params = urllib.parse.urlencode(
        {
            "fromLang": "ru",
            "to": "en",
            "text": payload,
            "key": state["key"],
            "token": state["token"],
        }
    ).encode("utf-8")
    request = urllib.request.Request(
        f"https://www.bing.com/ttranslatev3?isVertical=1&IG={state['ig']}&IID=translator.5023.{state['count']}",
        data=params,
        headers={
            "User-Agent": BROWSER_AGENT,
            "Origin": "https://www.bing.com",
            "Referer": "https://www.bing.com/translator",
        },
    )
    with THREAD_STATE.bing_opener.open(request, timeout=60) as response:
        body = json.loads(response.read().decode("utf-8"))
    if not isinstance(body, list):
        if len(values) == 1:
            words = values[0].split()
            chunks: list[str] = []
            current: list[str] = []
            for word in words:
                if current and len(" ".join(current)) + len(word) + 1 > 750:
                    chunks.append(" ".join(current))
                    current = []
                current.append(word)
            if current:
                chunks.append(" ".join(current))
            if len(chunks) <= 1:
                raise RuntimeError(f"translation failed: {body}")
            return [" ".join(request_translation([chunk])[0] for chunk in chunks)]
        midpoint = len(values) // 2
        return request_translation(values[:midpoint]) + request_translation(values[midpoint:])
    translated = body[0]["translations"][0]["text"]
    pieces = re.split(r"\s*ZZXQSEP\d{4}ZZ\s*", translated, flags=re.IGNORECASE)
    if len(pieces) != len(values):
        if len(values) == 1:
            return [translated]
        midpoint = len(values) // 2
        return request_translation(values[:midpoint]) + request_translation(values[midpoint:])
    return pieces


def translate_values(values: list[str], cache: dict[str, str]) -> None:
    pending = [
        value
        for value in dict.fromkeys(values)
        if value not in cache or CYRILLIC.search(cache[value])
    ]
    total = len(pending)
    batches: list[tuple[list[str], list[str], list[dict[str, str]]]] = []
    while pending:
        batch: list[str] = []
        masked_batch: list[str] = []
        masks: list[dict[str, str]] = []
        size = 0
        while pending and len(batch) < 25:
            candidate = pending[0]
            masked, replacements = mask_tokens(candidate)
            if batch and size + len(masked) > 900:
                break
            pending.pop(0)
            batch.append(candidate)
            masked_batch.append(masked)
            masks.append(replacements)
            size += len(masked)

        batches.append((batch, masked_batch, masks))

    def translate_batch(item: tuple[list[str], list[str], list[dict[str, str]]]) -> list[str]:
        _, masked_batch, _ = item
        for attempt in range(5):
            try:
                return request_translation(masked_batch)
            except Exception:
                if attempt == 4:
                    raise
                time.sleep(2**attempt)

    done = 0
    with concurrent.futures.ThreadPoolExecutor(max_workers=6) as executor:
        for item, translated in zip(batches, executor.map(translate_batch, batches)):
            batch, _, masks = item
            for original, result, replacements in zip(batch, translated, masks):
                cache[original] = unmask_tokens(result, replacements)
            done += len(batch)
            print(f"translated {done}/{total}", flush=True)
            CACHE_PATH.write_text(json.dumps(cache, ensure_ascii=False, indent=2), encoding="utf-8")


def replace_segments(path: Path, text: str, cache: dict[str, str]) -> str:
    newline = "\r\n" if "\r\n" in text else "\n"
    had_final_newline = text.endswith(("\n", "\r"))
    output: list[str] = []
    for line in text.splitlines():
        if not CYRILLIC.search(line):
            output.append(line)
            continue
        if path.suffix.lower() in PROSE_SUFFIXES:
            output.append(cache.get(line, line))
            continue
        ranges = quoted_ranges(line)
        comment = comment_range(line, ranges)
        if comment:
            ranges.append(comment)
        replaced = False
        for start, end in sorted(set(ranges), reverse=True):
            value = line[start:end]
            if value in cache:
                line = line[:start] + cache[value] + line[end:]
                replaced = True
        if not replaced:
            for match in reversed(list(CYRILLIC_PHRASE.finditer(line))):
                value = match.group(0)
                if value in cache:
                    line = line[: match.start()] + cache[value] + line[match.end() :]
        output.append(line)
    result = newline.join(output)
    return result + newline if had_final_newline else result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--apply", action="store_true", help="write translated files")
    args = parser.parse_args()

    documents: list[tuple[Path, str]] = []
    values: list[str] = []
    for path in tracked_files():
        try:
            text = path.read_text(encoding="utf-8")
        except (UnicodeDecodeError, OSError):
            continue
        if not CYRILLIC.search(text):
            continue
        documents.append((path, text))
        values.extend(collect_segments(path, text))

    cache: dict[str, str] = {}
    if CACHE_PATH.exists():
        cache = json.loads(CACHE_PATH.read_text(encoding="utf-8"))
    print(f"found {len(values)} segments in {len(documents)} files")
    translate_values(values, cache)
    if not args.apply:
        return
    for path, text in documents:
        updated = replace_segments(path, text, cache)
        if updated != text:
            path.write_text(updated, encoding="utf-8", newline="")


if __name__ == "__main__":
    main()
