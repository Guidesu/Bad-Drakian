import { useState } from 'react';
import { Box, Button, Icon, Input, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type PowerData = {
  name: string;
  level: number;
  desc: string;
};

type CovenData = {
  name: string;
  desc: string;
  icon?: string;
  powers: PowerData[];
};

type TraitData = {
  name: string;
  desc: string;
};

type LordFormData = {
  name: string;
  desc: string;
};

type ClanData = {
  id: string;
  name: string;
  desc: string;
  curse: string;
  downside: string;
  bloodPreference: string;
  covens: CovenData[];
  icon?: string;
  tagline?: string;
  isCustom?: boolean | number;
  lordTitle: string;
  lordForm: LordFormData | null;
  lordTraits: TraitData[];
  clanTraits: TraitData[];
  vitaeBonus: number;
};

type VampireClanSelectionData = {
  clans: ClanData[];
  selectedClanId: string;
  pendingCustomName: string;
  defaultClanName: string;
  language?: string;
  i18nOverrides?: Record<string, string> | null;
};

const DEFAULT_W = 1100;
const DEFAULT_H = 760;

const capFirst = (s: string | undefined | null): string => {
  if (!s) return '';
  return s.charAt(0).toUpperCase() + s.slice(1);
};

const FALLBACK_LANG = 'en';

const TRANSLATIONS: Record<string, Record<string, string>> = {
  en: {
    title: 'Clan Selection',
    subtitle: 'Choose your vampire clan',
    flavorLine1: 'The Blood remembers.',
    flavorLine2: 'Choose your lineage.',
    expand: 'Expand',
    restore: 'Restore',
    expandTip: 'Expand window',
    restoreTip: 'Restore window',
    availableClans: 'Available Clans',
    clanName: 'Clan Name',
    customNamePlaceholder: 'Name your Caitiff bloodline...',
    customNameHint: 'Leave blank to be known simply as the "Custom Clan".',
    description: 'Description',
    curseDownside: 'Curse / Downside',
    bloodPreference: 'Blood Preference',
    lordOfClan: 'Lord of the Clan',
    lordHailedAs: 'Hailed as the',
    lordFallback: 'Lord',
    lordVitae: ', endowed with an extra +{vitae} vitae',
    lordOnlyBoons: 'Lord-only Boons',
    specialClanTraits: 'Special Clan Traits',
    disciplinesPowers: 'Disciplines & Powers',
    caitiffNoDisciplines: 'A Caitiff chooses their own disciplines later.',
    none: 'None.',
    unknown: 'Unknown',
    noPowersDocumented: 'No powers documented.',
    accept: 'Accept Clan',
    close: 'Close',
    warningDefault:
      'If no clan is chosen, Crimson Fangs will be assigned by default.',
  },
  ru: {
    title: 'Clan choice',
    subtitle: 'Choose your clan',
    flavorLine1: 'Blood remembers.',
    flavorLine2: 'Choose your bloodline.',
    expand: 'Expand',
    restore: 'Restore',
    expandTip: 'Expand window',
    restoreTip: 'Restore window size',
    availableClans: 'Available clans',
    clanName: 'Clan name',
    customNamePlaceholder: 'Name your bloodline...',
    customNameHint:
      'Leave the field empty — and the clan will be called "Custom Clan".',
    description: 'Description',
    curseDownside: 'Curse and flaw',
    bloodPreference: 'Preferred blood',
    lordOfClan: 'Clan lord',
    lordHailedAs: 'Title:',
    lordFallback: 'Lord',
    lordVitae: '; vitae reserve: +{vitae}',
    lordOnlyBoons: "Lord's gifts",
    specialClanTraits: 'Special clan traits',
    disciplinesPowers: 'Disciplines and powers',
    caitiffNoDisciplines: 'The Caitiff will choose their disciplines later.',
    none: 'No.',
    unknown: 'Unknown',
    noPowersDocumented: 'Information about powers is missing.',
    accept: 'Choose a clan',
    close: 'Close',
    warningDefault:
      'If you do not make a choice, you will be assigned to the Nosferatu clan.',
  },
};

type ClanLoc = {
  name: string;
  desc: string;
  curse: string;
  downside: string;
  bloodPreference: string;
  tagline: string;
  lordTitle: string;
};

const RU_CLANS_BY_NAME: Record<string, ClanLoc> = {
  Nosferatu: {
    name: 'Nosferatu',
    desc: 'The Nosferatu bear their curse in plain sight. The embrace has monstrously twisted their bodies; they lurk on the outskirts of cities, serving as spies and information brokers. They are aided by beasts and a supernatural gift of stealth — so nothing escapes the eyes of the Nosferatu.',
    curse: 'An Appearance that Violates the Masquerade.',
    downside: 'a repulsive appearance and torment under the sun',
    bloodPreference: 'the blood of kin, dead and parasites',
    tagline: 'Spies of dungeons and broken masks',
    lordTitle: 'Nosferatu',
  },
  'Vitabella Family': {
    name: 'The Vitabella Family',
    desc: 'Eora, touched by your relentless pursuit of art and beauty, blessed your cursed bloodline. But, admiring you, she did not perceive the dark edges of your nature: a perverted understanding of love and a megalomania.',
    curse: 'Obsession with vanity and the need to be loved.',
    downside:
      'you are perfect and devoid of weaknesses — even the sun does not frighten you',
    bloodPreference: 'everything in which there is the beauty of life',
    tagline: 'Beauty, obsession, and adoration',
    lordTitle: 'Elder',
  },
  'House Thronleer': {
    name: 'House Tronleer',
    desc: 'Nok, captivated by the insatiable thirst for knowledge of your House, blessed your cursed bloodline. But Xailix dealt a bad card, and the cursed blood doomed you to fear of jesting and ill fate.',
    curse: 'Fear of jesting, thirst for knowledge, and heavy melancholy.',
    downside: 'chronic fear of jesting and severe mood swings',
    bloodPreference: 'any blood — in diversity, knowledge',
    tagline: 'Knowledge, horror, and ominous forebodings',
    lordTitle: 'Elder',
  },
  'Children of the Abyss': {
    name: 'Children of the Abyss',
    desc: 'Children of the Abyss are a bloodline of vampires who worship ancient demons. Kinship with the unholy makes them extremely vulnerable to the holiness of gods.',
    curse: 'Fear of faith.',
    downside: 'Burn under the sun and in the presence of the Ten',
    bloodPreference: 'Any blood',
    tagline: 'Demonic piety and holy magic',
    lordTitle: 'Lord',
  },
  'Crimson Fang': {
    name: 'Crimson Fang',
    desc: 'Other kindred consider the Crimson Fangs dangerous killers and diablerists. In fact, they are guardians, warriors, and scholars who avoid politics of both the vampire and mortal worlds.',
    curse: 'Dependence on the blood of kin and nobility.',
    downside: 'you burn under the sun',
    bloodPreference: 'the blood of nobility, clergy, Inquisition, and kin',
    tagline: 'Killers, warriors, and diablerists',
    lordTitle: 'Lord',
  },
};

const RU_CAITIFF: ClanLoc = {
  name: 'Your own caitiff clan',
  desc: 'Forge your own cursed bloodline outside the ancient Houses. The elders do not recognize you, but their chains will not bind you either.',
  curse: 'Unstable heritage.',
  downside: 'you have no ancient House to shelter your name',
  bloodPreference: 'your hunger is your own',
  tagline: 'Forge your own cursed bloodline',
  lordTitle: 'Overlord of the Kaitiffs',
};

const RU_LORD_FORMS_BY_NAME: Record<string, { name: string; desc: string }> = {
  'Sewer Rat Form': {
    name: 'Sewer Rat Form',
    desc: 'Shed the form of a kin and turn into a sewer rat — slip into places no mortal can reach.',
  },
  'Bat Form': {
    name: 'Bat Form',
    desc: 'Soar as a winged shadow — swift, elusive, hard to strike.',
  },
  'Gaseous Form': {
    name: 'Misty Form',
    desc: 'Dissolve into the mist — untouchable, yet barely tied to this world.',
  },
  'Cabbit Form': {
    name: 'Rabbit Form',
    desc: 'Graceful, deceptively meek form — beauty as camouflage, fangs behind a smile.',
  },
};

const RU_TRAITS_BY_NAME: Record<string, { name: string; desc: string }> = {
  'Nasty Eater': {
    name: 'Undemanding Stomach',
    desc: 'Your stomach accepts even foul food without complaint.',
  },
  'Hidden from Sight': {
    name: 'Hidden from view',
    desc: 'Divinatory charms glide past your name.',
  },
  Unseemly: {
    name: 'Repulsive appearance',
    desc: 'Distorted features disturb anyone who sees them.',
  },
  'Keen Ears': {
    name: 'Keen hearing',
    desc: 'You clearly hear sounds that escape others.',
  },
  Jesterphobia: {
    name: 'Fear of jesters',
    desc: 'Minstrels, jokers, and fools unsettle you.',
  },
  'Brooding Soul': {
    name: 'Gloomy soul',
    desc: 'Blows to your mood become a true tragedy for you.',
  },
  'Self-Sustenance': {
    name: 'Self-sufficiency',
    desc: 'Long work has taught you to make do with little.',
  },
  'Skilled writer': {
    name: 'Skillful Scribe',
    desc: 'Your handwriting is graceful and easy to read.',
  },
  'Jack of All Trades': {
    name: 'Jack of all Trades',
    desc: 'You are knowledgeable in many crafts.',
  },
  Intellectual: {
    name: 'Sharp Mind',
    desc: 'Your mind is keen: you easily judge both people and their intentions.',
  },
  'Light Step': {
    name: 'Light Footstep',
    desc: 'You move without disturbing prey or guards.',
  },
  Cicerone: {
    name: 'Experienced Taster',
    desc: 'A deft hand and sharp eye allow you to know what is poured into the cup.',
  },
  Deathsight: {
    name: 'Death Gaze',
    desc: 'You sense the dying — when and where they are destined to fall.',
  },
  Beautiful: {
    name: 'Otherworldly Beauty',
    desc: 'Your beauty is inhumanly perfect — all eyes are drawn to you in any hall.',
  },
  Empath: {
    name: 'Empath',
    desc: 'You read the moods and small lies of those around you.',
  },
  Exteroception: {
    name: 'Heightened perception',
    desc: 'You acutely sense bodies and surroundings.',
  },
  'Heavy Armor Mastery': {
    name: 'Mastery of heavy armor',
    desc: 'Plate and chainmail no longer weigh you down.',
  },
  'Infinite Stamina': {
    name: 'Unfailing endurance',
    desc: 'Work and battle do not exhaust you.',
  },
  'Uncapped Strength': {
    name: 'Boundless strength',
    desc: 'Your raw power knows no mortal limit.',
  },
  "Appraiser's Eye": {
    name: "Appraiser's eye",
    desc: 'You can determine the value of any item at first glance.',
  },
  'Deceiving Meekness': {
    name: 'Deceptive meekness',
    desc: "Enemies underestimate you until it's too late.",
  },
};

const RU_COVENS_BY_NAME: Record<string, { name: string; desc: string }> = {
  Auspex: {
    name: 'Foresight',
    desc: 'Allows you to see through walls of creatures, their auras, and health status.',
  },
  Bloodheal: {
    name: 'Blood healing',
    desc: 'Use the power of vitae to gradually restore flesh.',
  },
  Celerity: {
    name: 'Swiftness',
    desc: 'Grants speed beyond the limits of a mortal body. Breaks the Masquerade.',
  },
  Demonic: {
    name: 'Demonism',
    desc: 'Summon hellish creatures to help, resist flame, and turn into a demon. Breaks the Masquerade.',
  },
  'Eoran Embrace': {
    name: 'Embrace of Eora',
    desc: 'Blessed by the Goddess of Love, Family, and Art, these vampires strengthen bonds, inspire with beauty, and heal emotional wounds.',
  },
  'Fae Trickery': {
    name: 'Fey Tricks',
    desc: 'This discipline most often awakens in vampires born near the Daftmarsh swamps, among the fey.',
  },
  Obfuscate: {
    name: 'Concealment',
    desc: 'Makes you less noticeable to the living and the dead.',
  },
  Potence: {
    name: 'Might',
    desc: 'Increases damage in melee and unarmed combat.',
  },
  Presence: {
    name: 'Presence',
    desc: 'Invade the mortal mind — your words are stronger than any sword. Subjugate them.',
  },
  Quietus: {
    name: 'Lethalness',
    desc: 'Lurk in the shadows and strike only when necessary. Poisons, confusion, and fire.',
  },
  'Siren Blessing': {
    name: 'Blessing of the Siren',
    desc: "The gift of those who walk the seas of Enigma: the siren's voice allows you to deprive enemies of the will to move.",
  },
};

const RU_POWERS_BY_NAME: Record<string, { name: string; desc: string }> = {
  // Auspex
  'Heightened Senses': {
    name: 'Heightened Senses',
    desc: 'Your senses extend far beyond human limits.',
  },
  'An Ear For Lies': {
    name: 'Lying Sense',
    desc: 'You hear more than you should.',
  },
  "The Spirit's Touch": {
    name: 'Spirit Touch',
    desc: 'Track prey by barely noticeable traces.',
  },
  'Psychic Projection': {
    name: 'Psychic Projection',
    desc: 'Leave your body and soar above the lands.',
  },
  // Bloodheal
  'Minor Bloodheal': {
    name: 'Minor Blood Healing',
    desc: 'Slowly heal minor wounds, using vitae.',
  },
  Bloodheal: {
    name: 'Blood healing',
    desc: 'Heal wounds evenly and without haste.',
  },
  'Quick Bloodheal': {
    name: 'Rapid bloody healing',
    desc: 'Heal wounds at a visibly fast pace — this breaks the Masquerade!',
  },
  'Major Bloodheal': {
    name: 'Major bloody healing',
    desc: 'Rapidly heal even serious injuries. Breaks the Masquerade!',
  },
  'Greater Bloodheal': {
    name: 'Supreme bloody healing',
    desc: 'Heal wounds and restore damaged organs. Breaks the Masquerade!',
  },
  // Celerity
  'Celerity 1': {
    name: 'Minor swiftness',
    desc: 'Increase speed — and any task will become a bit easier.',
  },
  'Celerity 2': {
    name: 'Swiftness',
    desc: 'Significantly increases your speed and reaction.',
  },
  'Celerity 3': {
    name: 'Superhuman swiftness',
    desc: 'Move faster. React instantly. Your body obeys you perfectly.',
  },
  'Celerity 4': {
    name: 'Great swiftness',
    desc: 'Surpass the limits of a mortal body. Move like lightning.',
  },
  'Celerity 5': {
    name: 'Supernatural swiftness',
    desc: 'You are like light. Cleave your way through the world with fire.',
  },
  // Demonic
  'Deny the Mother': {
    name: 'Rejection of Nature',
    desc: 'For twenty seconds, you are invulnerable to fire.',
  },
  'Fear of the Void': {
    name: 'Fear of the Abyss',
    desc: 'Temporarily increases your speed and resilience.',
  },
  Conflagration: {
    name: 'Ignition',
    desc: 'Turn your hands into deadly claws.',
  },
  Psychomachia: {
    name: 'Power of Fire',
    desc: 'Incinerate enemies with a fireball.',
  },
  'Infernal Fireball': {
    name: 'Hellfire Ball',
    desc: 'Launch an explosive fireball at the target.',
  },
  'Wall of Fire': {
    name: 'Wall of Fire',
    desc: 'Fire arrow? Fireball? No — wall of fire!',
  },
  // Eoran
  'Empathic Bond': {
    name: 'Empathic Connection',
    desc: 'Touch the target to feel their emotions and immediate needs; for a short time, you will be overcome with obsession for them.',
  },
  'Artistic Inspiration': {
    name: 'Artistic Inspiration',
    desc: 'Inspire others with a divine creative spark, enhancing their art and lifting their spirits.',
  },
  'Familial Bond': {
    name: 'Family Bonds',
    desc: "Create a temporary spiritual connection between two people — they will be able to sense each other's location and condition.",
  },
  "Beauty's Restoration": {
    name: 'Restoration of Beauty',
    desc: "Channel Eora's power to restore beauty to the body and heal deformities.",
  },
  // Fae Trickery
  'Darkling Trickery': {
    name: 'Dark Tricks',
    desc: 'Disarm victims from a distance.',
  },
  Goblinism: {
    name: 'Goblinism',
    desc: "Summon a cunning goblin that will latch onto the enemy's face.",
  },
  'Chanjelin Ward': {
    name: "Chandelin's Sign",
    desc: 'Draw a sign at your feet. A cruel trap throws victims back, spins their heads, knocks them to the ground, and knocks the weapon out of their hands.',
  },
  'Riddle Phantastique': {
    name: 'Phantasmagorical Riddle',
    desc: 'Pose a confusing riddle to the victim — they will be unable to act until they answer.',
  },
  'Fae Wrath': {
    name: 'Fury of the Fairies',
    desc: 'Unleash a hail of strikes on enemies.',
  },
  // Obfuscate
  'Cloak of Shadows': {
    name: 'Veil of Shadows',
    desc: 'Merge with the shadows and remain unnoticed until drawing attention. Any movement will dispel the veil.',
  },
  'Unseen Presence': {
    name: 'Invisible Presence',
    desc: 'Move through the crowd unnoticed. Become invisible even while moving.',
  },
  "Vanish from the Mind's Eye": {
    name: 'Disappearance from Mental Sight',
    desc: 'Instantly vanish from view and erase your presence from recent memory.',
  },
  'Cloak the Gathering': {
    name: 'Concealment of the Gathering',
    desc: 'Cover yourself and others in a small area. All nearby allies become invisible.',
  },
  // Potence
  'Potence 1': {
    name: 'Power I',
    desc: 'Strengthen your muscles. Never hit with half force.',
  },
  'Potence 2': {
    name: 'Power II',
    desc: 'Become stronger than your own muscles. Crush people and objects.',
  },
  'Potence 3': {
    name: 'Power III',
    desc: 'Become an instrument of destruction. Lift and break what cannot be lifted or broken.',
  },
  'Potence 4': {
    name: 'Power IV',
    desc: 'Become an unstoppable machine while you have vitae.',
  },
  'Potence 5': {
    name: 'Power V',
    desc: 'Show this power to mortals — and they will begin to worship you as a god.',
  },
  // Presence
  Awe: {
    name: 'Awe',
    desc: 'Make those around you admire you. Whoever turns away will face the consequences.',
  },
  'Dread Gaze': {
    name: 'Intimidating gaze',
    desc: 'Instill fear in others with just words and a look.',
  },
  Kneel: {
    name: 'On your knees',
    desc: 'Make those around you kneel.',
  },
  Summon: {
    name: 'Summons',
    desc: 'Keep friends close, and enemies even closer. Teleport the target to yourself.',
  },
 
  // Quietus
  'Silence of Death': {
    name: 'Silence of death',
    desc: 'Create an area of complete silence around yourself, confusing everything inside it.',
  },
  "Scorpion's Touch": {
    name: "Scorpion's touch",
    desc: 'Create a powerful substance that sets enemies on fire.',
  },
  "Baal's Caress": {
    name: "Baal's caress",
    desc: 'Turn your vitae into a poison that destroys any flesh it touches. Applied to SHARP weapons.',
  },
  'Taste of Death': {
    name: 'Taste of Death',
    desc: 'Spit a clot of corrosive blood at your enemies.',
  },
  "Dagon's Call": {
    name: 'Call of Dagon',
    desc: 'Curse the last person you struck—let them drown in their own blood.',
  },
  // Siren
  'The Missing Voice': {
    name: 'Lost Voice',
    desc: 'Throw your voice to any point visible to you.',
  },
  'Phantom Speaker': {
    name: 'Phantom Voice',
    desc: 'Project your voice to anyone you have met and speak to them from afar.',
  },
  Madrigal: {
    name: 'Madrigal',
    desc: 'Sing a siren’s song—those around you will be drawn to you.',
  },
  "Siren's Beckoning": {
    name: 'Siren’s Call',
    desc: 'Sing an otherworldly song to deafen those around you.',
  },
  'Shattering Crescendo': {
    name: 'Crushing crescendo',
    desc: 'Emit a scream of unnatural pitch, tearing the bodies of enemies apart.',
  },
};

const localizeClan = (clan: ClanData, lang: string): ClanData => {
  if (lang !== 'ru') return clan;
  const next: ClanData = { ...clan };
  const loc = clan.isCustom ? RU_CAITIFF : RU_CLANS_BY_NAME[clan.name];
  if (loc) {
    next.name = loc.name;
    next.desc = loc.desc;
    next.curse = loc.curse;
    next.downside = loc.downside;
    next.bloodPreference = loc.bloodPreference;
    next.tagline = loc.tagline;
    next.lordTitle = loc.lordTitle;
  }
  if (clan.lordForm && RU_LORD_FORMS_BY_NAME[clan.lordForm.name]) {
    const f = RU_LORD_FORMS_BY_NAME[clan.lordForm.name];
    next.lordForm = { name: f.name, desc: f.desc };
  }
  const localizeTraits = (traits: TraitData[] | undefined): TraitData[] =>
    (traits || []).map((tr) => {
      const tloc = RU_TRAITS_BY_NAME[tr.name];
      return tloc ? { name: tloc.name, desc: tloc.desc } : tr;
    });
  next.lordTraits = localizeTraits(clan.lordTraits);
  next.clanTraits = localizeTraits(clan.clanTraits);
  next.covens = (clan.covens || []).map((cv) => {
    const cvloc = RU_COVENS_BY_NAME[cv.name];
    const localizedPowers: PowerData[] = (cv.powers || []).map((p) => {
      const ploc = RU_POWERS_BY_NAME[p.name];
      return ploc
        ? { name: ploc.name, level: p.level, desc: ploc.desc }
        : p;
    });
    return cvloc
      ? {
          name: cvloc.name,
          desc: cvloc.desc,
          icon: cv.icon,
          powers: localizedPowers,
        }
      : { ...cv, powers: localizedPowers };
  });
  return next;
};

const resolveLang = (raw: string | undefined): string => {
  if (raw && TRANSLATIONS[raw]) {
    return raw;
  }
  return FALLBACK_LANG;
};

const makeT =
  (lang: string, overrides?: Record<string, string> | null) =>
  (key: string, vars?: Record<string, string | number>): string => {
    let value: string | undefined = overrides ? overrides[key] : undefined;
    if (value === undefined) {
      const dict = TRANSLATIONS[lang] || TRANSLATIONS[FALLBACK_LANG];
      value = dict[key];
    }
    if (value === undefined) {
      value = TRANSLATIONS[FALLBACK_LANG][key];
    }
    if (value === undefined) {
      return key;
    }
    if (vars) {
      for (const name of Object.keys(vars)) {
        value = value.replace(`{${name}}`, String(vars[name]));
      }
    }
    return value;
  };

const setVampireClanWindowSize = (expanded: boolean) => {
  if (typeof Byond === 'undefined' || !Byond?.winset) return;
  const scale = window.devicePixelRatio || 1;
  const screenWidth = Math.floor(window.screen.availWidth * scale);
  const screenHeight = Math.floor(window.screen.availHeight * scale);
  const width = expanded ? screenWidth : Math.min(DEFAULT_W, screenWidth);
  const height = expanded ? screenHeight : Math.min(DEFAULT_H, screenHeight);
  const x = expanded ? 0 : Math.max(Math.floor((screenWidth - width) / 2), 0);
  const y = expanded ? 0 : Math.max(Math.floor((screenHeight - height) / 2), 0);
  Byond.winset(Byond.windowId, {
    pos: `${x},${y}`,
    size: `${width}x${height}`,
  });
};

export const VampireClanSelection = () => {
  const { act, data } = useBackend<VampireClanSelectionData>();
  const [expandedCovens, setExpandedCovens] = useState<Set<string>>(new Set());
  const [customName, setCustomName] = useState(data.pendingCustomName || '');
  const [windowExpanded, setWindowExpanded] = useState(false);

  const lang = resolveLang(data.language);
  const t = makeT(lang, data.i18nOverrides);

  const localizedClans = data.clans.map((clan) => localizeClan(clan, lang));
  const selectedClan =
    localizedClans.find((clan) => clan.id === data.selectedClanId) ||
    localizedClans[0];
  const isCustom = !!selectedClan?.isCustom;

  const toggleCoven = (covenName: string) => {
    setExpandedCovens((prev) => {
      const next = new Set(prev);
      if (next.has(covenName)) {
        next.delete(covenName);
      } else {
        next.add(covenName);
      }
      return next;
    });
  };

  const onCustomNameChange = (value: string) => {
    setCustomName(value);
    act('set_custom_name', { name: value });
  };

  const toggleWindow = () => {
    const nextExpanded = !windowExpanded;
    setVampireClanWindowSize(nextExpanded);
    setWindowExpanded(nextExpanded);
  };

  return (
    <Window width={DEFAULT_W} height={DEFAULT_H} theme="generic">
      <Window.Content className="VampireClanSelection" fitted>
        <Box className="VampireClanSelection__shell">
          <Box className="VampireClanSelection__header">
            <Box className="VampireClanSelection__crest">
              <Box className="VampireClanSelection__crestInner">
                <Icon name="gem" />
              </Box>
            </Box>
            <Box className="VampireClanSelection__titleBlock">
              <Box className="VampireClanSelection__title">{t('title')}</Box>
              <Box className="VampireClanSelection__subtitle">
                {t('subtitle')}
              </Box>
            </Box>
            <Box className="VampireClanSelection__windowControls">
              <Button
                color="transparent"
                icon={windowExpanded ? 'compress' : 'expand'}
                tooltip={windowExpanded ? t('restoreTip') : t('expandTip')}
                tooltipPosition="left"
                onClick={toggleWindow}
                className="VampireClanSelection__windowButton"
              >
                {windowExpanded ? t('restore') : t('expand')}
              </Button>
            </Box>
            <Box className="VampireClanSelection__flavor">
              {t('flavorLine1')}
              <br />
              {t('flavorLine2')}
            </Box>
          </Box>

          <Box className="VampireClanSelection__body">
            <Box className="VampireClanSelection__leftPanel">
              <Section title={t('availableClans')} fill scrollable>
                <Stack vertical>
                  {localizedClans.map((clan, index) => {
                    const selected = clan.id === selectedClan?.id;
                    return (
                      <Stack.Item key={clan.id}>
                        <Button
                          fluid
                          className={
                            selected
                              ? 'VampireClanSelection__clanCard VampireClanSelection__clanCard--selected'
                              : 'VampireClanSelection__clanCard'
                          }
                          onClick={() =>
                            act('select_clan', { clan_id: clan.id })
                          }
                        >
                          <Stack align="center">
                            <Stack.Item>
                              <Box className="VampireClanSelection__number">
                                {index + 1}
                              </Box>
                            </Stack.Item>
                            <Stack.Item>
                              <Box
                                className={
                                  clan.isCustom
                                    ? 'VampireClanSelection__cardSigil VampireClanSelection__cardSigil--custom'
                                    : 'VampireClanSelection__cardSigil'
                                }
                              >
                                <Icon
                                  name={clan.isCustom ? 'question' : 'gem'}
                                />
                              </Box>
                            </Stack.Item>
                            <Stack.Item grow>
                              <Box className="VampireClanSelection__clanName">
                                {clan.name}
                              </Box>
                              <Box className="VampireClanSelection__tagline">
                                {clan.tagline}
                              </Box>
                            </Stack.Item>
                          </Stack>
                        </Button>
                      </Stack.Item>
                    );
                  })}
                </Stack>
              </Section>
            </Box>

            <Box className="VampireClanSelection__rightPanel">
              <Section fill scrollable>
                {selectedClan ? (
                  <Box className="VampireClanSelection__details">
                    <Box className="VampireClanSelection__selectedName">
                      {selectedClan.name}
                    </Box>
                    <Box className="VampireClanSelection__divider" />

                    {isCustom ? (
                      <Box className="VampireClanSelection__infoBlock">
                        <Box className="VampireClanSelection__infoTitle">
                          <Icon
                            name="pen"
                            className="VampireClanSelection__infoIcon"
                          />
                          {t('clanName')}
                        </Box>
                        <Input
                          fluid
                          className="VampireClanSelection__customNameInput"
                          placeholder={t('customNamePlaceholder')}
                          value={customName}
                          onChange={onCustomNameChange}
                          maxLength={42}
                        />
                        <Box
                          className="VampireClanSelection__infoText"
                          mt={0.5}
                        >
                          {t('customNameHint')}
                        </Box>
                      </Box>
                    ) : null}

                    <InfoBlock
                      title={t('description')}
                      icon="book"
                      text={capFirst(selectedClan.desc)}
                      fallback={t('unknown')}
                    />
                    <InfoBlock
                      title={t('curseDownside')}
                      icon="skull"
                      text={capFirst(
                        selectedClan.downside || selectedClan.curse,
                      )}
                      fallback={t('unknown')}
                    />
                    <InfoBlock
                      title={t('bloodPreference')}
                      icon="tint"
                      text={capFirst(selectedClan.bloodPreference)}
                      fallback={t('unknown')}
                    />

                    <LordBlock clan={selectedClan} t={t} />

                    <ClanTraitsBlock traits={selectedClan.clanTraits} t={t} />

                    <Box className="VampireClanSelection__infoBlock">
                      <Box className="VampireClanSelection__infoTitle">
                        <Icon
                          name="fire"
                          className="VampireClanSelection__infoIcon"
                        />
                        {t('disciplinesPowers')}
                      </Box>
                      {selectedClan.covens && selectedClan.covens.length > 0 ? (
                        <Stack vertical>
                          {selectedClan.covens.map((coven) => (
                            <Stack.Item key={coven.name}>
                              <CovenCard
                                coven={coven}
                                expanded={expandedCovens.has(coven.name)}
                                onToggle={() => toggleCoven(coven.name)}
                                t={t}
                              />
                            </Stack.Item>
                          ))}
                        </Stack>
                      ) : (
                        <Box className="VampireClanSelection__infoText">
                          {isCustom ? t('caitiffNoDisciplines') : t('none')}
                        </Box>
                      )}
                    </Box>
                  </Box>
                ) : null}
              </Section>
            </Box>
          </Box>

          <Box className="VampireClanSelection__footer">
            <Box className="VampireClanSelection__warning">
              {t('warningDefault')}
            </Box>
            <Stack align="center">
              <Stack.Item grow />
              <Stack.Item>
                <Button
                  color="red"
                  icon="check"
                  onClick={() => act('accept_clan')}
                  className="VampireClanSelection__footerAccept"
                >
                  {t('accept')}
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  color="transparent"
                  icon="times"
                  onClick={() => act('close')}
                  className="VampireClanSelection__footerClose"
                >
                  {t('close')}
                </Button>
              </Stack.Item>
            </Stack>
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};

type Translator = ReturnType<typeof makeT>;

const InfoBlock = (props: {
  title: string;
  icon: string;
  text?: string;
  fallback?: string;
}) => (
  <Box className="VampireClanSelection__infoBlock">
    <Box className="VampireClanSelection__infoTitle">
      <Icon name={props.icon} className="VampireClanSelection__infoIcon" />
      {props.title}
    </Box>
    <Box className="VampireClanSelection__infoText">
      {props.text || props.fallback || ''}
    </Box>
  </Box>
);

const LordBlock = (props: { clan: ClanData; t: Translator }) => {
  const { clan, t } = props;
  const hasForm = !!clan.lordForm;
  const hasTraits = clan.lordTraits && clan.lordTraits.length > 0;
  const hasVitae = !!clan.vitaeBonus;
  if (!hasForm && !hasTraits && !hasVitae && !clan.isCustom) {
    return null;
  }
  return (
    <Box className="VampireClanSelection__infoBlock">
      <Box className="VampireClanSelection__infoTitle">
        <Icon name="crown" className="VampireClanSelection__infoIcon" />
        {t('lordOfClan')}
      </Box>
      <Box className="VampireClanSelection__lordTitleLine">
        {t('lordHailedAs')} <b>{clan.lordTitle || t('lordFallback')}</b>
        {hasVitae ? t('lordVitae', { vitae: clan.vitaeBonus }) : null}.
      </Box>

      {hasForm ? (
        <Box className="VampireClanSelection__lordFormCard">
          <Box className="VampireClanSelection__lordFormTitle">
            <Icon name="dragon" className="VampireClanSelection__formIcon" />
            {clan.lordForm!.name}
          </Box>
          <Box className="VampireClanSelection__lordFormDesc">
            {clan.lordForm!.desc}
          </Box>
        </Box>
      ) : null}

      {hasTraits ? (
        <Box className="VampireClanSelection__traitList">
          <Box className="VampireClanSelection__traitListLabel">
            {t('lordOnlyBoons')}
          </Box>
          {clan.lordTraits.map((trait) => (
            <TraitRow key={`lord-${trait.name}`} trait={trait} />
          ))}
        </Box>
      ) : null}
    </Box>
  );
};

const ClanTraitsBlock = (props: { traits: TraitData[]; t: Translator }) => {
  const { traits, t } = props;
  if (!traits || traits.length === 0) {
    return null;
  }
  return (
    <Box className="VampireClanSelection__infoBlock">
      <Box className="VampireClanSelection__infoTitle">
        <Icon name="star" className="VampireClanSelection__infoIcon" />
        {t('specialClanTraits')}
      </Box>
      <Box className="VampireClanSelection__traitList">
        {traits.map((trait) => (
          <TraitRow key={`clan-${trait.name}`} trait={trait} />
        ))}
      </Box>
    </Box>
  );
};

const TraitRow = (props: { trait: TraitData }) => (
  <Box className="VampireClanSelection__traitRow">
    <Box className="VampireClanSelection__traitName">{props.trait.name}</Box>
    <Box className="VampireClanSelection__traitDesc">{props.trait.desc}</Box>
  </Box>
);

const CovenCard = (props: {
  coven: CovenData;
  expanded: boolean;
  onToggle: () => void;
  t: Translator;
}) => {
  const { coven, expanded, onToggle, t } = props;
  return (
    <Box className="VampireClanSelection__covenCard">
      <Button
        fluid
        className="VampireClanSelection__covenHeader"
        onClick={onToggle}
      >
        <Stack align="center">
          <Stack.Item>
            <Box className="VampireClanSelection__covenChevron">
              <Icon name={expanded ? 'chevron-down' : 'chevron-right'} />
            </Box>
          </Stack.Item>
          <Stack.Item grow>
            <Box className="VampireClanSelection__covenName">{coven.name}</Box>
            <Box className="VampireClanSelection__covenDesc">
              {capFirst(coven.desc)}
            </Box>
          </Stack.Item>
        </Stack>
      </Button>
      {expanded ? (
        <Box className="VampireClanSelection__powerList">
          {coven.powers && coven.powers.length > 0 ? (
            coven.powers.map((power) => (
              <Box
                key={`${coven.name}-${power.level}-${power.name}`}
                className="VampireClanSelection__powerItem"
              >
                <Box className="VampireClanSelection__powerLevel">
                  {power.level}
                </Box>
                <Box className="VampireClanSelection__powerBody">
                  <Box className="VampireClanSelection__powerName">
                    {power.name}
                  </Box>
                  <Box className="VampireClanSelection__powerDesc">
                    {capFirst(power.desc)}
                  </Box>
                </Box>
              </Box>
            ))
          ) : (
            <Box className="VampireClanSelection__infoText">
              {t('noPowersDocumented')}
            </Box>
          )}
        </Box>
      ) : null}
    </Box>
  );
};
