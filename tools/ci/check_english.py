#!/usr/bin/env python3
"""Reject untranslated Cyrillic and retired public server branding."""

from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
CYRILLIC = re.compile(r"[\u0400-\u04ff]")
RETIRED_BRANDS = (
    "Twilight" + " Axis",
    "Twilight" + " Fortress",
)
TEXT_SUFFIXES = {
    ".css", ".dm", ".dmf", ".dme", ".dmm", ".html", ".js", ".json",
    ".md", ".py", ".scss", ".sh", ".sql", ".ts", ".tsx", ".txt",
    ".yaml", ".yml",
}


def tracked_paths() -> list[Path]:
    raw = subprocess.check_output(["git", "ls-files", "-z"], cwd=ROOT)
    return [ROOT / item.decode("utf-8", errors="surrogateescape") for item in raw.split(b"\0") if item]


def readable_text(path: Path) -> str | None:
    try:
        data = path.read_bytes()
    except OSError:
        return None
    if b"\0" in data:
        return None
    try:
        return data.decode("utf-8-sig")
    except UnicodeDecodeError:
        return None


def main() -> int:
    failures: list[str] = []
    for path in tracked_paths():
        relative = path.relative_to(ROOT).as_posix()
        if path.exists() and CYRILLIC.search(relative):
            failures.append(f"{relative}: path contains Cyrillic text")
        if path.suffix.lower() not in TEXT_SUFFIXES:
            continue
        text = readable_text(path)
        if text is None:
            continue
        for number, line in enumerate(text.splitlines(), 1):
            if CYRILLIC.search(line):
                failures.append(f"{relative}:{number}: contains Cyrillic text")
            # Historical changelog archives are attribution records, not live branding.
            for brand in (() if relative.startswith("html/changelogs/archive/") else RETIRED_BRANDS):
                if brand.casefold() in line.casefold():
                    failures.append(f"{relative}:{number}: contains retired public brand {brand!r}")

    if failures:
        print("English/public-brand policy violations:", file=sys.stderr)
        for failure in failures:
            print(f"  {failure}", file=sys.stderr)
        return 1
    print("English translation and public-brand checks passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
