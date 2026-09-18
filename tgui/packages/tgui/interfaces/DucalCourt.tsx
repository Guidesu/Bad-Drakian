import {
  type CSSProperties,
  type ReactNode,
  useEffect,
  useRef,
  useState,
} from 'react';
import {
  Box,
  Button,
  Icon,
  NumberInput,
  Section,
  TextArea,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type StatusTone = 'good' | 'warning' | 'bad' | 'neutral';
type ViewId = 'overview' | 'commands' | 'succession' | 'laws';
type CourtLocale = 'county' | 'duchy' | 'kingdom' | 'sultanate';

type StatusCard = {
  id: string;
  label: string;
  value: string;
  detail: string;
  tone: StatusTone;
};

type DucalAction = {
  id: string;
  label: string;
  desc: string;
  requirements: string[];
  enabled: boolean;
  disabled_reason: string | null;
};

type RiteData = {
  active: boolean;
  name: string;
  stage: 'none' | 'gathering' | 'contesting' | 'resolution';
  stage_label: string;
  status: string;
  claimant: string | null;
  contester: string | null;
  supporters: number;
  supporters_required: number;
  time_remaining_seconds: number | null;
};

type ActionText = {
  label: string;
  desc: string;
};

type StatusCardText = {
  label: string;
  values?: Record<string, string>;
  details?: Record<string, string>;
};

export type CourtTexts = {
  window_title: string;
  subtitle: string;
  sections: {
    status: string;
    main: string;
    tools: string;
    succession: string;
    desk: string;
    overview: string;
    commands: string;
    public_writs: string;
    governance: string;
    law_tools: string;
    decree_tools: string;
    law_decree_tools: string;
    quick_tools: string;
    voice_commands: string;
  };
  composer: {
    placeholder: string;
    publish_announcement: string;
    publish_decree: string;
    publish_law: string;
    law_number: string;
    remove_law: string;
    clear_laws: string;
    clear_decrees: string;
    empty_text: string;
  };
  labels: {
    ruler: string;
    regent: string;
    claimant: string;
    contester: string;
    supporters: string;
    time_remaining: string;
    rite_status: string;
    no_regent: string;
    none: string;
    viewer: string;
    requirements: string;
    charter_ledger: string;
  };
  compact: {
    collapse_tooltip: string;
    restore_tooltip: string;
    restore_button: string;
    fullscreen_tooltip: string;
    windowed_tooltip: string;
  };
  viewer_statuses: Record<string, string>;
  views: Record<ViewId, ActionText>;
  actions: Record<string, ActionText>;
  requirements: Record<string, string>;
  status_cards: Record<string, StatusCardText>;
  rite_steps: string[];
  voice_command_descriptions: Record<string, string>;
};

type RealmColors = {
  primary: string;
  secondary: string;
  fallback: boolean;
};

type Data = {
  court_locale?: CourtLocale;
  realm_type: string;
  realm_name: string;
  realm_colors: RealmColors;
  ruler: string | null;
  regent: string | null;
  viewer_status: string;
  status_cards: StatusCard[];
  rite: RiteData;
  main_actions: DucalAction[];
  tool_actions: DucalAction[];
  rite_actions: DucalAction[];
  law_count: number;
  decree_count: number;
};

const REALM_TYPES_RU: Record<string, string> = {
  'Grand Duchy': 'Grand Duchy',
  Duchy: 'Duchy',
  Kingdom: 'Kingdom',
  Sultanate: 'Sultanate',
  Republic: 'Republic',
  Magocracy: 'Magocracy',
  'Sovereign Order': 'Sovereign Order',
  Dominion: 'Dominion',
  Ordinate: 'Ordinat',
  'Prince-Bishopric': 'Prince-Bishopric',
  Realm: 'State',
};

const REALM_NAMES_RU: Record<string, string> = {
  Enigma: 'Enigma',
  'Al-Ashur': 'Al-Ashur',
  'Azure Peak': 'Azure Peak',
};

const RITE_NAMES_RU: Record<string, string> = {
  None: 'No',
  'Usurpation Rite': 'Usurpation Ritual',
  'Rite of Solar Succession': 'Solar Inheritance Ritual',
  'Rite of Lunar Ascension': 'Lunar Ascension Ritual',
  'Rite of Martial Supercession': 'Martial Supremacy Ritual',
  'Rite of Golden Accord': 'Golden Concord Ritual',
  'Rite of Sacred Supercession': 'Holy Supremacy Ritual',
  'Rite of Progressive Dominion': 'Progressive Dominion Ritual',
  'Rite of Popular Acclaim': 'Popular Recognition Ritual',
  'Rite of Psydonian Tribunal': 'Psidonite Tribunal Ritual',
};

const RITE_STATUS_BASE_RU: Record<string, string> = {
  'No active succession.': 'Inheritance does not proceed.',
  'A claim is active.': 'Claim to the throne is active.',
};

const RITE_STATUS_NAMES_RU: Record<string, string> = {
  'Rite of Solar Succession': 'Solar Inheritance Ritual',
  'Rite of Lunar Ascension': 'Lunar Ascension Ritual',
  'Rite of Martial Supercession': 'Martial Supremacy Ritual',
  'Golden Accord': 'Golden Concord',
  'Rite of Sacred Supercession': 'Holy Supremacy Ritual',
  'Rite of Progressive Dominion': 'Progressive Dominion Ritual',
  'Rite of Popular Acclaim': 'Popular Recognition Ritual',
  'Psydonian Tribunal': 'Psidonite Tribunal',
};

const RITE_STATUS_GROUPS_RU: Record<string, string> = {
  nobles: 'nobles',
  warriors: 'warriors',
  burghers: 'burghers',
  mages: 'of mages',
  voices: 'votes',
};

const RITE_STATUS_COUNCILS_RU: Record<string, string> = {
  'The Council of Lords': 'The Council of Lords confirmed',
  'The Council of Magos': 'The Council of Mages confirmed',
  'The Council of Arms': 'The Council of Warriors confirmed',
  'The Council of Burghers': 'The Council of Burghers confirmed',
  'The Council of the Enlightened': 'The Council of the Enlightened confirmed',
  'The faithful': 'The Faithful confirmed',
  'The people': 'The People confirmed',
  'The Inquisition': 'The Inquisition confirmed',
};

const RITE_STATUS_TAILS_RU: Record<string, string> = {
  "The Sun's judgment approaches.": 'The judgment of the Sun is coming.',
  "The moon's judgment approaches.": 'The judgment of the Moon is coming.',
  "Ravox's judgment approaches.": 'The judgment of Ravox is coming.',
  'The Accord approaches.': 'Consent is coming.',
  'The future approaches.': 'The future is coming.',
  'The will of the people approaches.': 'The will of the people is coming.',
  "The Tribunal's verdict approaches.": "The Tribunal's verdict is coming.",
};

const GATHERING_STATUS_RE =
  /^(?:The |A )?(.+?) is underway\. (\d+)\/(\d+) (nobles|warriors|burghers|mages|voices) have spoken their assent\.$/;
const CONTESTING_STATUS_RE = /^(.+?) (?:has|have) affirmed (.+)'s claim\. (.+)$/;

const translateRiteStatus = (status?: string | null) => {
  if (!status) {
    return status;
  }
  if (RITE_STATUS_BASE_RU[status]) {
    return RITE_STATUS_BASE_RU[status];
  }
  const gathering = status.match(GATHERING_STATUS_RE);
  if (gathering) {
    const riteName = RITE_STATUS_NAMES_RU[gathering[1]] || gathering[1];
    const group = RITE_STATUS_GROUPS_RU[gathering[4]] || gathering[4];
    return `${riteName} is in progress. Consent was expressed by ${gathering[2]} from ${gathering[3]} ${group}.`;
  }
  const contesting = status.match(CONTESTING_STATUS_RE);
  if (contesting) {
    const council = RITE_STATUS_COUNCILS_RU[contesting[1]];
    const tail = RITE_STATUS_TAILS_RU[contesting[3]];
    if (council && tail) {
      return `${council}'s claim ${contesting[2]}. ${tail}`;
    }
  }
  return status;
};

const makeCourtTexts = (flavor: {
  court: string;
  subtitle: string;
  authority: string;
  commands: string;
  decreeDesc: string;
  keyDesc: string;
  colorsDesc: string;
  crownDetail: string;
  itemsDesc: string;
}): CourtTexts => ({
  window_title: flavor.court,
  subtitle: flavor.subtitle,
  sections: {
    status: 'Court position',
    main: 'Court affairs',
    tools: "Ruler's tools",
    succession: 'Inheritance and usurpation',
    desk: "Scribe's desk",
    overview: 'Court overview',
    commands: flavor.commands,
    public_writs: 'Public charters',
    governance: 'Administration',
    law_tools: 'Laws',
    decree_tools: 'Decrees',
    law_decree_tools: 'Laws and decrees',
    quick_tools: 'Quick actions',
    voice_commands: 'Voice commands',
  },
  composer: {
    placeholder: 'Draft an announcement, decree, or new law...',
    publish_announcement: 'Proclaim the announcement',
    publish_decree: 'Issue decree',
    publish_law: 'Adopt law',
    law_number: 'Law No.',
    remove_law: 'Remove law',
    clear_laws: 'Revoke all laws',
    clear_decrees: 'Revoke all decrees',
    empty_text: 'First write the text.',
  },
  labels: {
    ruler: 'Ruler',
    regent: 'Regent',
    claimant: 'Claimant',
    contester: 'Challenger',
    supporters: 'Supporters',
    time_remaining: 'Time remaining',
    rite_status: 'Ritual status',
    no_regent: 'No',
    none: 'No',
    viewer: 'Your status',
    requirements: 'Requirements',
    charter_ledger: 'Register of charters',
  },
  compact: {
    collapse_tooltip: 'Collapse into a compact court summary.',
    restore_tooltip: 'Expand full court view with command panels.',
    restore_button: 'Expand the court',
    fullscreen_tooltip: 'Expand the court to full screen.',
    windowed_tooltip: 'Return to windowed mode.',
  },
  viewer_statuses: {
    'Sovereign Authority': flavor.authority,
    'Crown Bearer': 'Crown bearer',
    Subject: 'Subject',
    Observer: 'Observer',
  },
  views: {
    overview: {
      label: 'Court overview',
      desc: 'Show current court status without commands.',
    },
    commands: {
      label: 'Commands',
      desc: 'Open charters, management, and tools for laws and decrees.',
    },
    succession: {
      label: 'Succession',
      desc: 'Current ritual, claimants, supporters, and succession actions.',
    },
    laws: {
      label: 'Laws',
      desc: 'Open the laws menu directly.',
    },
  },
  actions: {
    make_announcement: {
      label: 'Announcement',
      desc: 'Announce the news to all lands.',
    },
    revise_charter: {
      label: 'Review charters',
      desc: 'Open the charter registry.',
    },
    issue_decree: {
      label: 'Issue decree',
      desc: flavor.decreeDesc,
    },
    set_laws: {
      label: 'Set laws',
      desc: 'Rewrite the laws of the lands.',
    },
    set_taxes: {
      label: 'Set taxes',
      desc: 'Change levies and poll taxes.',
    },
    declare_outlaw: {
      label: 'Declare',
      desc: 'an outlaw Declare a subject an outlaw or pardon.',
    },
    change_colors: {
      label: 'Change colors',
      desc: flavor.colorsDesc,
    },
    summon_crown: {
      label: 'Summon the crown',
      desc: 'Return the crown if the laws allow.',
    },
    summon_key: {
      label: 'Summon the key',
      desc: flavor.keyDesc,
    },
    restore_charter: {
      label: 'Restore charters',
      desc: 'Open charters and restore suspended ones.',
    },
    purge_laws: {
      label: 'Revoke laws',
      desc: 'Delete all active laws.',
    },
    purge_decrees: {
      label: 'Revoke decrees',
      desc: 'Delete all decrees.',
    },
    become_regent: {
      label: 'Become regent',
      desc: 'Assume the regency in the absence of the ruler.',
    },
    ascend: {
      label: 'I ascend',
      desc: 'Begin the inheritance ritual.',
    },
    assent: {
      label: 'I agree',
      desc: 'Support the claim while standing at the throne.',
    },
    abdicate: {
      label: 'I abdicate',
      desc: 'Give up the throne and proceed immediately to contesting.',
    },
    stop_ascent: {
      label: 'Stop the ascension',
      desc: 'Sit on the throne and interrupt the inheritance.',
    },
  },
  requirements: {
    Crown: 'Crown',
    'Broadcast Ready': 'Magic is ready',
    'Ruler/Regent': 'Ruler/Regent',
    'Ruling Office': 'Reigning office',
    Throat: 'Throat',
    'Noble Blood': 'Noble blood',
    'Regency Office': 'Regency rank',
    'Eligible Rite': 'Available ritual',
    'Active Gathering': 'Collection in progress',
    'Near Throne': 'At the throne',
    Contesting: 'Contesting',
    Seated: 'On the throne',
  },
  status_cards: {
    throne_status: {
      label: 'Throne',
      values: {
        Occupied: 'Occupied',
        Empty: 'Empty',
      },
      details: {
        'No one is seated.': 'No one is seated.',
        'Unknown occupant': 'Unknown',
      },
    },
    crown_required: {
      label: 'Crown power',
      values: {
        'Crown Worn': 'Crown worn',
        'Crown Missing': 'No crown',
      },
      details: {
        'Sovereign commands are unlocked by the crown.': flavor.crownDetail,
        'Most commands require the crown.':
          'Most commands require a crown.',
      },
    },
    active_rite: {
      label: 'Active ritual',
      values: {
        None: 'No',
        Gathering: 'Gathering votes',
        Contesting: 'Contesting',
        'Contesting - Paused': 'Dispute — pause',
        Resolution: 'Resolution',
      },
      details: {
        None: 'No',
      },
    },
    realm_stability: {
      label: 'Land stability',
      values: {
        Stable: 'Calm',
        'Claim Gathering': 'Gathering claims',
        Contested: 'Contested',
    'Rebel Victory': "Rebels' victory",
        'Open Rebellion': 'Open rebellion',
      },
      details: {
        'No open revolt in the realm.': 'No open rebellion in the lands.',
        'The commonfolk are in open revolt.':
          'Commoners have raised an open rebellion.',
        'The people have seized the throne.': 'The people have seized the throne.',
      },
    },
    current_ruler: {
      label: 'Ruler',
      values: {
        None: 'No',
      },
      details: {
        'No active regent.': 'No regent.',
        'Regent: {name}': 'Regent: {name}',
      },
    },
  },
  rite_steps: ['Gathering votes', 'Contesting', 'Resolution'],
  voice_command_descriptions: {
    'Make Announcement': 'Announce the news to all lands.',
    'Revise Charter': 'Open the charter registry.',
    'Make Decree': flavor.decreeDesc,
    'Purge Decrees': 'Delete all decrees.',
    'Set Laws': 'Open full law menu.',
    'Make Law': 'Pass one law by vote.',
    'Remove Law (number)': 'Remove the law with the specified number.',
    'Purge Laws': 'Delete all active laws.',
    'Declare Outlaw': 'an outlaw Declare a subject an outlaw or pardon.',
    'Set Taxes': 'Change levies and poll taxes.',
    'Change Colors': flavor.colorsDesc,
    'Become Regent': 'Assume the regency in the absence of the ruler.',
    'Summon Crown / Summon Key': flavor.itemsDesc,
    'I Ascend': 'Begin the inheritance ritual.',
    'I Assent': 'Support the claim while standing at the throne.',
    'I Abdicate': 'Give up the throne and proceed immediately to contesting.',
    'Stop Ascent': 'Sit on the throne and interrupt the inheritance.',
  },
});

const COURT_TEXT_PACKS: Record<CourtLocale, CourtTexts> = {
  county: makeCourtTexts({
    court: 'Sovereign court',
    subtitle: 'Rule an independent realm from its throne',
    authority: 'Sovereign power',
    commands: "The ruler's commands",
    decreeDesc: 'Proclaim a sovereign decree.',
    keyDesc: "Summon the ruler's key.",
    colorsDesc: "Change the realm's colors.",
    crownDetail: "The crown opens the ruler's commands.",
    itemsDesc: 'Return the sovereign relics.',
  }),
  duchy: makeCourtTexts({
    court: 'Sovereign court',
    subtitle: 'Rule the lands from the realm throne',
    authority: 'Sovereign power',
    commands: "The ruler's commands",
    decreeDesc: 'Proclaim the sovereign decree.',
    keyDesc: "Summon the ruler's key.",
    colorsDesc: "Change the realm's colors.",
    crownDetail: "The crown opens the ruler's commands.",
    itemsDesc: 'Return the sovereign relics.',
  }),
  kingdom: makeCourtTexts({
    court: 'Royal court',
    subtitle: 'Rule the lands from the throne of Enigma',
    authority: 'Royal power',
    commands: "King's commands",
    decreeDesc: 'Proclaim the royal decree.',
    keyDesc: 'Summon the royal key.',
    colorsDesc: 'Change the colors of the kingdom.',
    crownDetail: "The crown opens the king's commands.",
    itemsDesc: 'Return the royal relics.',
  }),
  sultanate: makeCourtTexts({
    court: "Sultan's court",
    subtitle: 'Rule the lands from the throne of Al-Ashur',
    authority: "Sultan's power",
    commands: "Sultan's commands",
    decreeDesc: "Proclaim the Sultan's decree.",
    keyDesc: "Summon the Sultan's key.",
    colorsDesc: 'Change the colors of the Sultanate.',
    crownDetail: "The crown opens the Sultan's commands.",
    itemsDesc: "Return the Sultan's relics.",
  }),
};

const DEFAULT_WINDOW_WIDTH = 1180;
const DEFAULT_WINDOW_HEIGHT = 760;
const COMPACT_WINDOW_WIDTH = 620;
const COMPACT_WINDOW_HEIGHT = 390;

const setCourtWindowSize = (fullscreen: boolean, compact: boolean) => {
  const pixelScale = window.devicePixelRatio || 1;
  const screenWidth = Math.floor(window.screen.availWidth * pixelScale);
  const screenHeight = Math.floor(window.screen.availHeight * pixelScale);
  const baseWidth = compact ? COMPACT_WINDOW_WIDTH : DEFAULT_WINDOW_WIDTH;
  const baseHeight = compact ? COMPACT_WINDOW_HEIGHT : DEFAULT_WINDOW_HEIGHT;
  const width = fullscreen ? screenWidth : Math.min(baseWidth, screenWidth);
  const height = fullscreen ? screenHeight : Math.min(baseHeight, screenHeight);
  const x = fullscreen ? 0 : Math.max(Math.floor((screenWidth - width) / 2), 0);
  const y = fullscreen
    ? 0
    : Math.max(Math.floor((screenHeight - height) / 2), 0);
  Byond.winset(Byond.windowId, {
    pos: `${x},${y}`,
    size: `${width}x${height}`,
  });
};

const GOVERNANCE_ACTIONS = ['revise_charter', 'set_taxes', 'declare_outlaw'];

const QUICK_TOOL_ACTIONS = [
  'change_colors',
  'summon_crown',
  'summon_key',
  'restore_charter',
  'become_regent',
];
const COURT_WRIT_ACTIONS = ['make_announcement'];

const VIEW_ITEMS: Array<{
  id: ViewId;
  icon: string;
}> = [
  {
    id: 'commands',
    icon: 'crown',
  },
  {
    id: 'overview',
    icon: 'chess-rook',
  },
  {
    id: 'succession',
    icon: 'hourglass-half',
  },
  {
    id: 'laws',
    icon: 'balance-scale',
  },
];

const VOICE_COMMANDS = [
  'Make Announcement',
  'Revise Charter',
  'Make Decree',
  'Purge Decrees',
  'Set Laws',
  'Make Law',
  'Remove Law (number)',
  'Purge Laws',
  'Declare Outlaw',
  'Set Taxes',
  'Change Colors',
  'Become Regent',
  'Summon Crown / Summon Key',
  'I Ascend',
  'I Assent',
  'I Abdicate',
  'Stop Ascent',
];

const ACTION_ICONS: Record<string, string> = {
  make_announcement: 'bullhorn',
  revise_charter: 'feather-alt',
  issue_decree: 'scroll',
  set_laws: 'balance-scale',
  set_taxes: 'coins',
  declare_outlaw: 'user-slash',
  change_colors: 'palette',
  summon_crown: 'crown',
  summon_key: 'key',
  restore_charter: 'book',
  purge_laws: 'trash',
  purge_decrees: 'eraser',
  become_regent: 'chess-king',
  ascend: 'crown',
  assent: 'handshake',
  abdicate: 'sign-out-alt',
  stop_ascent: 'hand-paper',
};

const STATUS_ICONS: Record<string, string> = {
  throne_status: 'chess-rook',
  crown_required: 'crown',
  active_rite: 'hourglass-half',
  realm_stability: 'shield-alt',
  current_ruler: 'user-tie',
};

const STABILITY_ICONS: Record<string, string> = {
  'Open Rebellion': 'fire',
  'Rebel Victory': 'fire',
};

const getStatusIcon = (card: StatusCard) =>
  (card.id === 'realm_stability' && STABILITY_ICONS[card.value]) ||
  STATUS_ICONS[card.id] ||
  'circle';

const getStageIndex = (stage: RiteData['stage']) => {
  if (stage === 'gathering') return 0;
  if (stage === 'contesting') return 1;
  if (stage === 'resolution') return 2;
  return -1;
};

const actionById = (actions: DucalAction[], id: string) =>
  actions.find((action) => action.id === id);

const actionsById = (actions: DucalAction[], ids: string[]) =>
  ids
    .map((id) => actionById(actions, id))
    .filter((action): action is DucalAction => !!action);

const translateKnown = (
  map: Record<string, string> | undefined,
  value?: string | null,
) => {
  if (!value) {
    return value;
  }
  return map?.[value] || value;
};

const translatePattern = (
  map: Record<string, string> | undefined,
  value?: string | null,
) => {
  if (!value) {
    return value;
  }
  const direct = map?.[value];
  if (direct) {
    return direct;
  }
  const regent = value.match(/^Regent: (.+)$/);
  if (regent && map?.['Regent: {name}']) {
    return map['Regent: {name}'].replace('{name}', regent[1]);
  }
  return value;
};

const formatTime = (seconds?: number | null) => {
  if (seconds === null || seconds === undefined) {
    return null;
  }
  const total = Math.max(Math.round(seconds), 0);
  const minutes = Math.floor(total / 60);
  const rest = total % 60;
  return `${minutes}:${String(rest).padStart(2, '0')}`;
};

const formatSupporters = (rite: RiteData) =>
  rite.supporters_required > 0
    ? `${rite.supporters} / ${rite.supporters_required}`
    : `${rite.supporters}`;

const ruPlural = (count: number, forms: [string, string, string]) => {
  const abs = Math.abs(count) % 100;
  const last = abs % 10;
  if (abs > 10 && abs < 20) return forms[2];
  if (last > 1 && last < 5) return forms[1];
  if (last === 1) return forms[0];
  return forms[2];
};

const getActionText = (texts: CourtTexts, action?: DucalAction | null) => {
  if (!action) {
    return null;
  }
  return {
    label: texts.actions[action.id]?.label || action.label,
    desc: texts.actions[action.id]?.desc || action.desc,
    disabledReason: action.disabled_reason,
  };
};

const getRequirementText = (texts: CourtTexts, requirement: string) =>
  texts.requirements[requirement] || requirement;

const getStatusCardText = (texts: CourtTexts, card: StatusCard) => {
  const cardTexts = texts.status_cards[card.id];
  const detail =
    card.id === 'active_rite'
      ? translateKnown(RITE_NAMES_RU, card.detail)
      : translatePattern(cardTexts?.details, card.detail);
  return {
    label: cardTexts?.label || card.label,
    value: translateKnown(cardTexts?.values, card.value) || card.value,
    detail: detail || card.detail,
  };
};

const getRiteName = (texts: CourtTexts, name?: string | null) =>
  translateKnown(RITE_NAMES_RU, name) || texts.labels.none;

const getRiteStatus = (texts: CourtTexts, status?: string | null) =>
  translateRiteStatus(status) || texts.labels.none;

const getViewerStatus = (texts: CourtTexts, status?: string | null) =>
  translateKnown(texts.viewer_statuses, status) || texts.labels.none;

const buildRealmStyle = (colors: RealmColors | undefined) =>
  ({
    '--ducal-primary': colors?.primary || '#007fff',
    '--ducal-secondary': colors?.secondary || '#ffffff',
  }) as CSSProperties;

const TooltipFrame = (props: {
  content?: string | null;
  inline?: boolean;
  children: ReactNode;
}) => {
  const { content, inline, children } = props;
  const body = (
    <span
      className={
        'DucalCourt__tooltipFrame' +
        (inline ? ' DucalCourt__tooltipFrame--inline' : '')
      }
    >
      {children}
    </span>
  );

  if (!content) {
    return body;
  }

  return (
    <Tooltip
      content={<span className="DucalCourt__tooltipContent">{content}</span>}
      position="bottom"
    >
      {body}
    </Tooltip>
  );
};

const ActionCard = (props: {
  texts: CourtTexts;
  action: DucalAction;
  compact?: boolean;
  onClick: (action: DucalAction) => void;
}) => {
  const { texts, action, compact, onClick } = props;
  const actionText = getActionText(texts, action)!;
  const tooltip = action.enabled ? actionText.desc : actionText.disabledReason;

  return (
    <TooltipFrame content={tooltip || actionText.desc}>
      <Button
        className={`DucalCourt__action${compact ? ' DucalCourt__action--compact' : ''}`}
        disabled={!action.enabled}
        onClick={() => action.enabled && onClick(action)}
      >
        <span className="DucalCourt__actionIcon">
          <Icon name={ACTION_ICONS[action.id] || 'circle'} />
        </span>
        <span className="DucalCourt__actionBody">
          <span className="DucalCourt__actionTitle">{actionText.label}</span>
          {!compact && (
            <span className="DucalCourt__actionDesc">{actionText.desc}</span>
          )}
          <span className="DucalCourt__badges">
            {action.requirements.map((requirement) => (
              <span className="DucalCourt__badge" key={requirement}>
                {getRequirementText(texts, requirement)}
              </span>
            ))}
          </span>
        </span>
      </Button>
    </TooltipFrame>
  );
};

const StatusGrid = (props: { texts: CourtTexts; cards: StatusCard[] }) => (
  <div className="DucalCourt__statusGrid">
    {props.cards.map((card) => {
      const cardText = getStatusCardText(props.texts, card);

      return (
        <div
          key={card.id}
          className={`DucalCourt__statusCard DucalCourt__statusCard--${card.tone}`}
        >
          <div className="DucalCourt__statusIcon">
            <Icon name={getStatusIcon(card)} />
          </div>
          <div className="DucalCourt__statusBody">
            <div className="DucalCourt__statusLabel">{cardText.label}</div>
            <div className="DucalCourt__statusValue">{cardText.value}</div>
            <div className="DucalCourt__statusDetail">{cardText.detail}</div>
          </div>
        </div>
      );
    })}
  </div>
);

const SuccessionPanel = (props: {
  texts: CourtTexts;
  rite: RiteData;
  actions: DucalAction[];
  onAction: (action: DucalAction) => void;
}) => {
  const { texts, rite, actions, onAction } = props;
  const activeStep = getStageIndex(rite.stage);

  return (
    <Section title={texts.sections.succession}>
      <div className="DucalCourt__riteName">{getRiteName(texts, rite.name)}</div>
      <div className="DucalCourt__stepper">
        {texts.rite_steps.map((step, index) => (
          <div
            key={step}
            className={
              'DucalCourt__step' +
              (index <= activeStep ? ' DucalCourt__step--active' : '')
            }
          >
            <span>{index + 1}</span>
            {step}
          </div>
        ))}
      </div>
      <div className="DucalCourt__riteFacts">
        <div>
          <b>{texts.labels.claimant}</b>
          <span>{rite.claimant || texts.labels.none}</span>
        </div>
        <div>
          <b>{texts.labels.contester}</b>
          <span>{rite.contester || texts.labels.none}</span>
        </div>
        <div>
          <b>{texts.labels.supporters}</b>
          <span>{formatSupporters(rite)}</span>
        </div>
        <div>
          <b>{texts.labels.time_remaining}</b>
          <span>
            {formatTime(rite.time_remaining_seconds) || texts.labels.none}
          </span>
        </div>
      </div>
      <Box className="DucalCourt__riteStatus">
        {getRiteStatus(texts, rite.status)}
      </Box>
      <div className="DucalCourt__riteActionGrid">
        {actions.map((action) => (
          <ActionCard
            key={action.id}
            texts={texts}
            action={action}
            compact
            onClick={onAction}
          />
        ))}
      </div>
    </Section>
  );
};

const ActionGroup = (props: {
  texts: CourtTexts;
  title: string;
  actions: DucalAction[];
  compact?: boolean;
  onAction: (action: DucalAction) => void;
}) => {
  const { texts, title, actions, compact, onAction } = props;

  if (!actions.length) {
    return null;
  }

  return (
    <div className="DucalCourt__actionGroup">
      <div className="DucalCourt__actionGroupTitle">{title}</div>
      <div
        className={compact ? 'DucalCourt__toolGrid' : 'DucalCourt__actionGrid'}
      >
        {actions.map((action) => (
          <ActionCard
            key={action.id}
            texts={texts}
            action={action}
            compact={compact}
            onClick={onAction}
          />
        ))}
      </div>
    </div>
  );
};

const DucalDesk = (props: {
  texts: CourtTexts;
  actions: DucalAction[];
  lawCount: number;
  mode?: 'all' | 'commands' | 'laws' | 'decrees';
}) => {
  const { act } = useBackend<Data>();
  const { texts, actions, lawCount, mode = 'all' } = props;
  const [text, setText] = useState('');
  const [lawNumber, setLawNumber] = useState(1);
  const trimmed = text.trim();
  const announcement = actionById(actions, 'make_announcement');
  const decree = actionById(actions, 'issue_decree');
  const law = actionById(actions, 'set_laws');
  const purgeLaws = actionById(actions, 'purge_laws') || law;
  const purgeDecrees = actionById(actions, 'purge_decrees');
  const announcementText = getActionText(texts, announcement);
  const decreeText = getActionText(texts, decree);
  const lawText = getActionText(texts, law);
  const purgeLawsText = getActionText(texts, purgeLaws);
  const purgeDecreesText = getActionText(texts, purgeDecrees);
  const canUseText = trimmed.length > 0;
  const showAnnouncements = mode === 'all';
  const showDecrees = mode !== 'laws';
  const showLaws = mode !== 'decrees';
  const showPurgeDecrees = mode === 'commands' || mode === 'decrees';

  const textTooltip = canUseText ? undefined : texts.composer.empty_text;
  const lawBlocked = lawText?.disabledReason || undefined;
  const purgeLawBlocked = purgeLawsText?.disabledReason || lawBlocked;
  const purgeDecreeBlocked = purgeDecreesText?.disabledReason || undefined;
  const sectionTitle =
    mode === 'laws'
      ? texts.sections.law_tools
      : mode === 'decrees'
        ? texts.sections.decree_tools
        : mode === 'commands'
          ? texts.sections.law_decree_tools
          : texts.sections.desk;

  return (
    <Section title={sectionTitle}>
      <div className="DucalCourt__desk">
        <TextArea
          fluid
          height="46px"
          maxLength={500}
          placeholder={texts.composer.placeholder}
          value={text}
          onChange={(value: string) => setText(value)}
          dontUseTabForIndent
        />
        <div className="DucalCourt__deskFooter">
          <div className="DucalCourt__deskButtons">
            {showAnnouncements && (
              <TooltipFrame
                inline
                content={
                  announcementText?.disabledReason ||
                  textTooltip ||
                  announcementText?.desc
                }
              >
                <Button
                  icon="bullhorn"
                  disabled={!announcement?.enabled || !canUseText}
                  onClick={() => act('publish_announcement', { text: trimmed })}
                >
                  {texts.composer.publish_announcement}
                </Button>
              </TooltipFrame>
            )}
            {showDecrees && (
              <TooltipFrame
                inline
                content={
                  decreeText?.disabledReason || textTooltip || decreeText?.desc
                }
              >
                <Button
                  icon="scroll"
                  disabled={!decree?.enabled || !canUseText}
                  onClick={() => act('publish_decree', { text: trimmed })}
                >
                  {texts.composer.publish_decree}
                </Button>
              </TooltipFrame>
            )}
            {showLaws && (
              <TooltipFrame
                inline
                content={lawBlocked || textTooltip || lawText?.desc}
              >
                <Button
                  icon="balance-scale"
                  disabled={!law?.enabled || !canUseText}
                  onClick={() => act('publish_law', { text: trimmed })}
                >
                  {texts.composer.publish_law}
                </Button>
              </TooltipFrame>
            )}
            {showPurgeDecrees && (
              <TooltipFrame
                inline
                content={purgeDecreeBlocked || purgeDecreesText?.desc}
              >
                <Button
                  icon="eraser"
                  color="bad"
                  disabled={!purgeDecrees?.enabled}
                  onClick={() => act('purge_decrees')}
                >
                  {texts.composer.clear_decrees}
                </Button>
              </TooltipFrame>
            )}
          </div>
          {showLaws && (
            <div className="DucalCourt__lawTools">
              <span>{texts.composer.law_number}</span>
              <NumberInput
                minValue={1}
                maxValue={Math.max(lawCount, 1)}
                value={lawNumber}
                step={1}
                onChange={(value: number) => setLawNumber(value)}
              />
              <TooltipFrame inline content={lawBlocked || lawText?.desc}>
                <Button
                  icon="times"
                  disabled={!law?.enabled || lawCount < 1}
                  onClick={() => act('remove_law', { law_number: lawNumber })}
                >
                  {texts.composer.remove_law}
                </Button>
              </TooltipFrame>
              <TooltipFrame
                inline
                content={purgeLawBlocked || purgeLawsText?.desc}
              >
                <Button
                  icon="trash"
                  color="bad"
                  disabled={!purgeLaws?.enabled || lawCount < 1}
                  onClick={() => act('purge_laws')}
                >
                  {texts.composer.clear_laws}
                </Button>
              </TooltipFrame>
            </div>
          )}
        </div>
      </div>
    </Section>
  );
};

const CompactCourt = (props: {
  texts: CourtTexts;
  rite: RiteData;
  statusCards: StatusCard[];
  onRestore: () => void;
}) => {
  const { texts, rite, statusCards, onRestore } = props;
  const compactCards = statusCards.filter((card) =>
    [
      'throne_status',
      'active_rite',
      'realm_stability',
      'current_ruler',
    ].includes(card.id),
  );

  return (
    <div className="DucalCourt__compactBody">
      <StatusGrid texts={texts} cards={compactCards} />
      <div className="DucalCourt__compactSummary">
        <div>
          <b>{texts.labels.rite_status}</b>
          <span>{getRiteName(texts, rite.name)}</span>
        </div>
        <div>
          <b>{texts.labels.time_remaining}</b>
          <span>
            {formatTime(rite.time_remaining_seconds) || texts.labels.none}
          </span>
        </div>
        <Box className="DucalCourt__riteStatus">
          {getRiteStatus(texts, rite.status)}
        </Box>
        <TooltipFrame content={texts.compact.restore_tooltip}>
          <Button icon="expand" onClick={onRestore}>
            {texts.compact.restore_button}
          </Button>
        </TooltipFrame>
      </div>
    </div>
  );
};

const OverviewPanel = (props: {
  texts: CourtTexts;
  rite: RiteData;
  lawCount: number;
  decreeCount: number;
}) => {
  const { texts, rite, lawCount, decreeCount } = props;

  return (
    <Section title={texts.sections.overview}>
      <div className="DucalCourt__overviewFacts">
        <div className="DucalCourt__overviewFact">
          <b>{texts.labels.rite_status}</b>
          <span>{getRiteName(texts, rite.name)}</span>
        </div>
        <div className="DucalCourt__overviewFact">
          <b>{texts.labels.claimant}</b>
          <span>{rite.claimant || texts.labels.none}</span>
        </div>
        <div className="DucalCourt__overviewFact">
          <b>{texts.labels.contester}</b>
          <span>{rite.contester || texts.labels.none}</span>
        </div>
        <div className="DucalCourt__overviewFact">
          <b>{texts.labels.supporters}</b>
          <span>{formatSupporters(rite)}</span>
        </div>
        <div className="DucalCourt__overviewFact">
          <b>{texts.labels.time_remaining}</b>
          <span>
            {formatTime(rite.time_remaining_seconds) || texts.labels.none}
          </span>
        </div>
        <div className="DucalCourt__overviewFact">
          <b>{texts.labels.charter_ledger}</b>
          <span>
            {lawCount} {ruPlural(lawCount, ['law', 'law', 'laws'])} /{' '}
            {decreeCount} {ruPlural(decreeCount, ['decree', 'of the decree', 'decrees'])}
          </span>
        </div>
      </div>
      <Box className="DucalCourt__riteStatus">
        {getRiteStatus(texts, rite.status)}
      </Box>
    </Section>
  );
};

const LeftRail = (props: {
  texts: CourtTexts;
  activeView: ViewId;
  lawAction?: DucalAction;
  onAction: (action: DucalAction) => void;
  onView: (view: ViewId) => void;
}) => {
  const { texts, activeView, lawAction, onAction, onView } = props;
  const lawActionText = getActionText(texts, lawAction);

  return (
    <aside className="DucalCourt__leftRail">
      <div className="DucalCourt__throneEmblem">
        <Icon name="chess-rook" />
      </div>
      <nav className="DucalCourt__nav">
        {VIEW_ITEMS.map((item) => {
          const viewText = texts.views[item.id];
          const opensSetLaws = item.id === 'laws';
          const tooltip = opensSetLaws
            ? lawActionText?.disabledReason ||
              lawActionText?.desc ||
              viewText.desc
            : viewText.desc;

          return (
            <TooltipFrame key={item.id} content={tooltip}>
              <Button
                className={
                  'DucalCourt__navButton' +
                  (!opensSetLaws && activeView === item.id
                    ? ' DucalCourt__navButton--active'
                    : '')
                }
                disabled={opensSetLaws && !lawAction?.enabled}
                icon={item.icon}
                onClick={() =>
                  opensSetLaws && lawAction
                    ? onAction(lawAction)
                    : onView(item.id)
                }
              >
                {viewText.label}
              </Button>
            </TooltipFrame>
          );
        })}
      </nav>
    </aside>
  );
};

const RightRail = (props: {
  texts: CourtTexts;
  tools: DucalAction[];
  onAction: (action: DucalAction) => void;
}) => {
  const { texts, tools, onAction } = props;
  const [voiceOpen, setVoiceOpen] = useState(false);

  return (
    <aside className="DucalCourt__rightRail">
      <Section title={texts.sections.quick_tools}>
        <div className="DucalCourt__quickTools">
          {tools.map((action) => (
            <ActionCard
              key={action.id}
              texts={texts}
              action={action}
              compact
              onClick={onAction}
            />
          ))}
        </div>
      </Section>
      <Section
        title={texts.sections.voice_commands}
        buttons={
          <Button
            color="transparent"
            icon={voiceOpen ? 'chevron-up' : 'chevron-down'}
            onClick={() => setVoiceOpen(!voiceOpen)}
          />
        }
      >
        {voiceOpen && (
          <ul className="DucalCourt__voiceList">
            {VOICE_COMMANDS.map((command) => (
              <li key={command}>
                <span className="DucalCourt__voiceCommand">{command}</span>
                <span className="DucalCourt__voiceDesc">
                  {texts.voice_command_descriptions[command] || command}
                </span>
              </li>
            ))}
          </ul>
        )}
      </Section>
    </aside>
  );
};

const CourtCommands = (props: {
  texts: CourtTexts;
  deskActions: DucalAction[];
  writActions: DucalAction[];
  governanceActions: DucalAction[];
  lawCount: number;
  onAction: (action: DucalAction) => void;
}) => {
  const {
    texts,
    deskActions,
    writActions,
    governanceActions,
    lawCount,
    onAction,
  } = props;

  return (
    <>
      <Section title={texts.sections.commands}>
        <div className="DucalCourt__actionGroups">
          <ActionGroup
            texts={texts}
            title={texts.sections.public_writs}
            actions={writActions}
            onAction={onAction}
          />
          <ActionGroup
            texts={texts}
            title={texts.sections.governance}
            actions={governanceActions}
            onAction={onAction}
          />
        </div>
      </Section>
      <DucalDesk
        texts={texts}
        actions={deskActions}
        lawCount={lawCount}
        mode="commands"
      />
    </>
  );
};

type DucalCourtViewProps = {
  texts: CourtTexts;
};

export const DucalCourtView = (props: DucalCourtViewProps) => {
  const { texts } = props;
  const { act, data } = useBackend<Data>();
  const [compact, setCompact] = useState(false);
  const [fullscreen, setFullscreen] = useState(false);
  const [activeView, setActiveView] = useState<ViewId>('commands');
  const windowModeApplied = useRef(false);

  useEffect(() => {
    if (!windowModeApplied.current) {
      windowModeApplied.current = true;
      return;
    }
    setCourtWindowSize(fullscreen, compact);
  }, [fullscreen, compact]);

  const toggleCompact = () => {
    setCompact(!compact);
    setFullscreen(false);
  };
  const toggleFullscreen = () => {
    setFullscreen(!fullscreen);
    setCompact(false);
  };
  const {
    realm_type,
    realm_name,
    realm_colors,
    ruler,
    regent,
    viewer_status,
    status_cards = [],
    rite,
    main_actions = [],
    tool_actions = [],
    rite_actions = [],
    law_count = 0,
    decree_count = 0,
  } = data;

  const handleAction = (action: DucalAction) => act(action.id);
  const realmStyle = buildRealmStyle(realm_colors);
  const allActions = [...main_actions, ...tool_actions];
  const writActions = actionsById(main_actions, COURT_WRIT_ACTIONS);
  const governanceActions = actionsById(main_actions, GOVERNANCE_ACTIONS);
  const quickToolActions = actionsById(tool_actions, QUICK_TOOL_ACTIONS);
  const setLawsAction = actionById(main_actions, 'set_laws');
  const windowWidth = compact ? COMPACT_WINDOW_WIDTH : DEFAULT_WINDOW_WIDTH;
  const windowHeight = compact ? COMPACT_WINDOW_HEIGHT : DEFAULT_WINDOW_HEIGHT;
  const realmEyebrow = [
    translateKnown(REALM_TYPES_RU, realm_type) || realm_type,
    translateKnown(REALM_NAMES_RU, realm_name) || realm_name,
  ]
    .filter(Boolean)
    .join(' · ');
  const commandPanel = (
    <CourtCommands
      texts={texts}
      deskActions={allActions}
      writActions={writActions}
      governanceActions={governanceActions}
      lawCount={law_count}
      onAction={handleAction}
    />
  );
  const successionPanel = (
    <SuccessionPanel
      texts={texts}
      rite={rite}
      actions={rite_actions}
      onAction={handleAction}
    />
  );
  const overviewPanel = (
    <OverviewPanel
      texts={texts}
      rite={rite}
      lawCount={law_count}
      decreeCount={decree_count}
    />
  );
  const activeContent = (() => {
    switch (activeView) {
      case 'commands':
        return commandPanel;
      case 'succession':
        return successionPanel;
      default:
        return overviewPanel;
    }
  })();
  const windowToggle = (
    <>
      <Button
        color="transparent"
        icon={fullscreen ? 'compress-arrows-alt' : 'expand-arrows-alt'}
        tooltip={
          fullscreen
            ? texts.compact.windowed_tooltip
            : texts.compact.fullscreen_tooltip
        }
        tooltipPosition="bottom"
        onClick={toggleFullscreen}
      />
      <Button
        color="transparent"
        icon={compact ? 'expand' : 'window-minimize-o'}
        tooltip={
          compact
            ? texts.compact.restore_tooltip
            : texts.compact.collapse_tooltip
        }
        tooltipPosition="bottom"
        onClick={toggleCompact}
      />
    </>
  );

  return (
    <Window
      width={windowWidth}
      height={windowHeight}
      title={texts.window_title}
      theme="ducal_court"
      buttons={windowToggle}
    >
      <Window.Content
        fitted
        className={
          'DucalCourt' +
          (compact ? ' DucalCourt--compact' : '') +
          (fullscreen ? ' DucalCourt--fullscreen' : '')
        }
      >
        <div className="DucalCourt__board" style={realmStyle}>
          <div className="DucalCourt__titleRow">
            <div className="DucalCourt__standard DucalCourt__standard--left">
              <Icon name="crown" />
            </div>
            <div className="DucalCourt__standard DucalCourt__standard--right">
              <Icon name="chess-rook" />
            </div>
            <div>
              <div className="DucalCourt__eyebrow">{realmEyebrow}</div>
              <div className="DucalCourt__title">{texts.window_title}</div>
              <div className="DucalCourt__subtitle">{texts.subtitle}</div>
            </div>
            <div className="DucalCourt__rulerBlock">
              <div>
                <b>{texts.labels.ruler}</b>
                <span>{ruler || texts.labels.none}</span>
              </div>
              <div>
                <b>{texts.labels.regent}</b>
                <span>{regent || texts.labels.no_regent}</span>
              </div>
              <div>
                <b>{texts.labels.viewer}</b>
                <span>{getViewerStatus(texts, viewer_status)}</span>
              </div>
            </div>
          </div>

          {compact ? (
            <CompactCourt
              texts={texts}
              rite={rite}
              statusCards={status_cards}
              onRestore={() => setCompact(false)}
            />
          ) : (
            <div className="DucalCourt__courtShell">
              <LeftRail
                texts={texts}
                activeView={activeView}
                lawAction={setLawsAction}
                onAction={handleAction}
                onView={setActiveView}
              />
              <main className="DucalCourt__centerPanel">
                <StatusGrid texts={texts} cards={status_cards} />
                <div className="DucalCourt__contentStack">{activeContent}</div>
              </main>
              <RightRail
                texts={texts}
                tools={quickToolActions}
                onAction={handleAction}
              />
            </div>
          )}
        </div>
      </Window.Content>
    </Window>
  );
};

export const DucalCourt = () => {
  const { data } = useBackend<Data>();
  const texts =
    COURT_TEXT_PACKS[data.court_locale || 'county'] || COURT_TEXT_PACKS.county;
  return <DucalCourtView texts={texts} />;
};
