import { type ReactNode, useState } from 'react';
import { Button, Input } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type OwnerStatusKey = 'commoner' | 'noble';
type VerificationResult = 'none' | 'unknown' | 'real' | 'fake';

type DocumentProfileId =
  | 'resident'
  | 'imperial'
  | 'enigma_crown'
  | 'valorian_church'
  | 'grenzelhoft_mission'
  | 'heartfelt_identity'
  | 'heartfelt_noble'
  | 'guards'
  | 'church'
  | 'craftsmen'
  | 'merchant'
  | 'mages'
  | 'commoner'
  | 'mercenary'
  | 'otava'
  | 'retinue';

type DocumentProfileTexts = {
  display_name: string;
  subtitle: string;
  description: string;
};

type ResidentManuscriptTexts = {
  window_title: string;
  title: string;
  subtitle_prefix: string;
  description: string;
  profiles: Record<string, DocumentProfileTexts>;
  labels: {
    owner: string;
    age: string;
    status: string;
    expires: string;
    issued: string;
    seals: string;
    verification: string;
    defects: string;
  };
  buttons: {
    save: string;
    inspect: string;
    stamp: string;
    claim: string;
    bind: string;
  };
  tooltips: {
    save: string;
    inspect: string;
    stamp: string;
    claim: string;
    bind: string;
  };
  placeholders: {
    owner: string;
  };
  owner_age_options: Record<string, string>;
  owner_status_options: Record<OwnerStatusKey, string>;
  states: {
    owner: string;
    other: string;
    unbound: string;
    blank_hint: string;
    fake_edit_hint: string;
    seal_missing: string;
    empty: string;
    unknown: string;
    unclear_hand: string;
  };
  verification: Record<VerificationResult, string>;
  aria: {
    seal: string;
  };
  seals: Record<string, { title: string; stamper: string }>;
  defects: Record<string, string>;
  visual_hints: {
    heretical_marginalia_lines: string[];
    misaligned_initial: string;
  };
  validation_notes: Record<string, string>;
};

type OwnerData = {
  name: string | null;
  age: string | number | null;
  status: OwnerStatusKey | null;
  status_key: OwnerStatusKey;
};

type OwnerAgeKey = 'Adult' | 'Middle-Aged' | 'Old';
type RealmKey = 'azuria' | 'rockhill';
type PersonalizationClass = 'azurian' | 'rockhill';

type SealData = {
  key: string;
  label: string;
  stamped: BooleanLike;
  stamper: string;
  visible: BooleanLike;
  suspicious: BooleanLike;
  priority: number;
  dominant: BooleanLike;
};

type VerificationData = {
  done: BooleanLike;
  result: VerificationResult;
  note_key: string | null;
  defect_note_key: string | null;
  defect_note_keys: string[];
};

type PermissionsData = {
  can_edit: BooleanLike;
  can_stamp: BooleanLike;
  can_inspect: BooleanLike;
  can_claim: BooleanLike;
  can_bind: BooleanLike;
  stamp_key: string | null;
};

type ProfileData = {
  id: DocumentProfileId | string | null;
  display_name?: string | null;
  subtitle?: string | null;
  description?: string | null;
};

type ResidentManuscriptData = {
  owner: OwnerData;
  issued_place: string | null;
  realm_key?: string | null;
  expiry_date: string | null;
  is_bound: BooleanLike;
  is_fake: BooleanLike;
  is_blank: BooleanLike;
  is_owner: BooleanLike;
  profile?: ProfileData;
  seals: SealData[];
  dominant_seal: SealData | null;
  verification: VerificationData;
  permissions: PermissionsData;
};

const TEXTS: ResidentManuscriptTexts = {
  window_title: 'Resident Certificate',
  title: 'Resident Certificate',
  subtitle_prefix: 'Certificate sealed with ink and stamp',
  profiles: {
    resident: {
      display_name: 'Resident Certificate',
      subtitle: 'At Hand of the Crown',
      description:
        'Be it known: the bearer is included in register of inhabitants of these lands. He is allowed to reside, apply to city law and pass through the city gates until the expiration of the charter.',
    },
    imperial: {
      display_name: 'Imperial Letter of Patronage',
      subtitle: 'Under Imperial Countersignature',
      description:
        'Let it be known that the bearer holds an office, dignity or service recognized by the Imperial Office of Grenzelhoft and the authority of the Duchy of Azuria. The certificate certifies his authority and is not transferred to other persons.',
    },
    enigma_crown: {
      display_name: 'Crown Letter of Enigma',
      subtitle: 'Under the Hand of the King of Rockhill',
      description:
        'Be it known: the bearer is recognized by the crown authority of the Kingdom of Enigma on Rockhill. His orders and dignity are recognized within the limits of royal law and the term of this charter.',
    },
    valorian_church: {
      display_name: 'Valorian Charter of the Holy See',
      subtitle: 'Under the Church of the Indivisible Ten',
      description:
        'Let it be known: the bearer is recognized by the Holy See of Valoria and has the right to perform church services on Rockhill. His dignity, seal and ecclesiastical orders are subject to recognition within the limits of this charter.',
    },
    grenzelhoft_mission: {
      display_name: 'Imperial Travel Certificate',
      subtitle: 'Seal of the Grenzelhoft Chancellery',
      description:
        'Let it be known that the bearer is included in the detachment sent by the Imperial Grenzelhoft Chancellery. He is allowed to go on the assigned mission, accompany the Lord Envoy and present the real paper to the authorities.',
    },
    heartfelt_identity: {
      display_name: 'Hartfelt ID Card',
      subtitle: 'Under the seal of the Hartfelt Chancery',
      description:
        "Let it be known that the bearer is certified as a resident of Hartfelt. His name, identity and right to produce this paper are recognized by Hartfelt's office.",
    },
    heartfelt_noble: {
      display_name: 'Certificate of Nobility',
      subtitle: 'Under the seal of the Hartfelt Chancery',
      description:
        'Let it be known that the bearer is certified as a noble resident of Hartfelt. His name, dignity and right to follow in the Hartfelt retinue are recognized by this paper.',
    },
    guards: {
      display_name: 'Garrison Letter',
      subtitle: 'From the garrison and the Crown',
      description:
        'Let it be known: the bearer has been accepted into the service of the city garrison. He is allowed to carry weapons while on duty, demand assistance within the limits of the order and answer to his superiors.',
    },
    church: {
      display_name: 'Church Letter of Faith',
      subtitle: 'Under the Tenfold Light',
      description:
        'Let it be known: the bearer is a member of the church and is admitted to temple services within the limits of his rank or position. His ecclesiastical position is recognized until the charter is revoked or the term expires.',
    },
    craftsmen: {
      display_name: 'Charter of the Craft Guild',
      subtitle: 'With an honest hand and bronze',
      description:
        'Let it be known: the bearer is recognized as a craftsman or employee of the craft guild. He is allowed to work at his craft, enter into orders and enjoy the protection of the guild order.',
    },
    merchant: {
      display_name: 'Valorian Trade Authorization',
      subtitle: 'Seal of the Trade Guild of Astinia di Sala',
      description:
        'Let it be known that the bearer is acting under the authority of the Valorian Trade Guild. He is allowed to conduct trade, accept goods, enter into transactions and keep trade books under the guild seal.',
    },
    mages: {
      display_name: 'Mages Guild Patent',
      subtitle: 'By the Light of the Crown, Star and Sigil',
      description:
        'Let it be known that the bearer is recognized as a permitted practitioner of the magical craft. He is allowed to carry out approved work, keep the necessary tools, and answer to the guild or court.',
    },
    commoner: {
      display_name: "Citizen's Certificate",
      subtitle: 'By the sign of the city elder',
      description:
        'Let it be known: the bearer is entered into the city register as a commoner. He is allowed to be among the legitimate people of the city without noble rights and special privileges.',
    },
    mercenary: {
      display_name: 'Hire contract',
      subtitle: 'Coin, steel and word',
      description:
        'Let it be known: the bearer has been accepted into hired service under the contract. He is allowed to carry weapons, fulfill a paid contract and be responsible for his actions before the employer and the law.',
    },
    otava: {
      display_name: 'Inquisitorial Edict',
      subtitle: 'By truth, inquiry and purifying flame',
      description:
        'Let it be known: the bearer is a member of the Inquisition of Otava. He is allowed to conduct inquiries, make demands in matters of faith and act within the limits of recognized authority.',
    },
    retinue: {
      display_name: 'Certificate of Palace Service',
      subtitle: 'Under the sovereign hand and oath',
      description:
        'Let it be known: the bearer is at the court of the Duchy of Azuria and performs personal service to the duke. His place, duties and right to be at court are confirmed by this charter.',
    },
  },
  labels: {
    owner: 'Name',
    age: 'Age',
    status: 'Caste',
    expires: 'Valid until',
    issued: 'Issued in',
    seals: 'Seals',
    verification: 'Authenticity',
    defects: 'Noted defects',
  },
  buttons: {
    save: 'Save',
    inspect: 'Inspect',
    stamp: 'Apply stamp',
    claim: 'Acknowledge residence',
    bind: 'Secure',
  },
  tooltips: {
    save: 'Save the completed forgery.',
    inspect: 'Secretly inspect the charter for signs of forgery.',
    stamp: 'Apply the official seal available to you.',
    claim: 'Use the charter as proof of residence.',
    bind: 'Attach the charter to your name.',
  },
  placeholders: {
    owner: "Owner's name",
  },
  owner_age_options: {
    Adult: 'Adult',
    'Middle-Aged': 'Middle-aged',
    Old: 'Old',
  },
  owner_status_options: {
    commoner: 'Commoner',
    noble: 'Under the Grace of Astrata',
  },
  states: {
    owner: 'This charter is secured to you.',
    other: 'This charter belongs to another.',
    unbound: 'This charter is not yet secured to an owner.',
    blank_hint: 'A blank charter needs to be filled in with a pen.',
    fake_edit_hint: 'A suspicious form awaits an inserted name.',
    seal_missing: 'not certified',
    empty: '-',
    unknown: 'Unknown',
    unclear_hand: 'Illegible hand',
  },
  verification: {
    fake: 'The charter looks forged.',
    real: 'The charter looks genuine.',
    unknown: 'The charter does not raise obvious suspicions.',
    none: 'Authenticity has not yet been verified.',
  },
  aria: {
    seal: 'Seal',
  },
  seals: {
    chancellor: { title: 'Chancellor', stamper: 'Chancellor' },
    elder: { title: 'Elder', stamper: 'Elder' },
    ruler: { title: 'Crown', stamper: 'Crown' },
    hand: { title: 'Hand', stamper: 'Hand' },
    sergeant: { title: 'Sergeant', stamper: 'Sergeant of the Guard' },
    marshal: { title: 'Marshal', stamper: 'Marshal' },
    bishop: { title: 'Bishop', stamper: 'Bishop' },
    guild_leader: { title: 'Guild Leader', stamper: 'Guild Leader' },
    inquisitor: { title: 'Inquisitor', stamper: 'Inquisitor' },
    court_magician: { title: 'Court Mage', stamper: 'Court Mage' },
    merchant_master: {
      title: 'Senior Trader',
      stamper: 'Senior Trader',
    },
    kaiser: {
      title: 'Imperial Chancellery',
      stamper: 'Grenzelhoft Chancellery',
    },
    valorian: {
      title: 'Valorian Trade Guild',
      stamper: 'Astinia di Sala Trade Guild',
    },
    valorian_holy_see: {
      title: 'Valorian Holy See',
      stamper: 'Holy See of Valoria',
    },
    royal_protection: { title: 'Royal Patronage', stamper: 'King' },
    heartfelt_chancery: {
      title: 'Heartfelt Chancery',
      stamper: 'Heartfelt Chancery',
    },
  },
  description:
    'Let it be known: this certificate certifies the name, legal status, and effect of the presented seals.',
  defects: {
    ink_blot: 'In one corner of the parchment, a faint ink blot is visible.',
    seal_smudge: 'The ink around one seal is slightly smudged.',
    owner_wobble: "One letter in the owner's name is written by the wrong hand.",
    ragged_edge: 'The edge of the parchment is cut unevenly.',
    uncertain_hand: 'The signature lacks a confident hand.',
    stale_smell: 'The parchment smells musty.',
    misaligned_initial:
      'The azure initial is misaligned from the line and has dried over the main text.',
    fresh_pricking:
      'Fresh pricks in the ruling on the lower margin do not match the written lines.',
    cut_gilding: 'The gilded edge in places lies over a fresh cut.',
    rethreaded_cord:
      'The silk-gold cord has been threaded anew: around the holes, torn fibers are visible.',
    reheated_wax:
      'One wax seal is warmer in color and shines as if it had been recently melted again.',
    blue_halo:
      'The ink gives a bluish halo in the middle of the line, as if it had been mixed with other water.',
    corrected_date:
      "One stroke in the date is crossed out too neatly for a clerk's hand.",
    heretical_marginalia:
      "Between the lines, someone else's note emerges: 'Zizo keeps the whisper, Graggar awaits blood, Mattios will weigh the debt.'",
  },
  visual_hints: {
    heretical_marginalia_lines: [
      'Zizo keeps the whisper',
      'Graggar awaits blood',
      'Mattios will weigh the debt',
    ],
    misaligned_initial: 'G',
  },
  validation_notes: {
    steady_seals:
      'The seals sit evenly, the ink is steady, and the cord shows no signs of being threaded again.',
    proper_ruling:
      'The ruling, punctures, and lines correspond with each other; this is a proper document.',
    matched_hand:
      'The hand, seals, and gilded edge align. There are no obvious reasons to doubt the document.',
    deep_wax:
      'The wax took the imprint deeply and cleanly, and the lines show no other hand.',
    proper_rite: 'The document appears to have been prepared according to official procedure.',
  },
};

const PROFILE_FALLBACK: DocumentProfileId = 'resident';
const OWNER_AGE_OPTIONS: OwnerAgeKey[] = ['Adult', 'Middle-Aged', 'Old'];
const REALM_KEYS: RealmKey[] = ['azuria', 'rockhill'];
const REALM_PERSONALIZATION_CLASSES: Record<RealmKey, PersonalizationClass> = {
  azuria: 'azurian',
  rockhill: 'rockhill',
};

const resolveProfileId = (
  profile: ProfileData | undefined,
  texts: ResidentManuscriptTexts,
): DocumentProfileId => {
  const candidate = (profile?.id as DocumentProfileId) ?? PROFILE_FALLBACK;
  return candidate in texts.profiles ? candidate : PROFILE_FALLBACK;
};

const resolveProfileTexts = (
  texts: ResidentManuscriptTexts,
  id: DocumentProfileId,
  profile: ProfileData | undefined,
): DocumentProfileTexts => {
  const fallback = texts.profiles[id] ?? texts.profiles[PROFILE_FALLBACK];
  return {
    display_name: profile?.display_name || fallback.display_name,
    subtitle: profile?.subtitle || fallback.subtitle,
    description: profile?.description || fallback.description,
  };
};

const resolveRealmKey = (
  value: string | null | undefined,
  issuedPlace: string | null,
): RealmKey => {
  const candidate =
    value ||
    (issuedPlace?.includes('Rockhill') ? 'rockhill' : 'azuria');
  return REALM_KEYS.includes(candidate as RealmKey)
    ? (candidate as RealmKey)
    : 'azuria';
};

const resolvePersonalizationClass = (realmKey: RealmKey): PersonalizationClass =>
  REALM_PERSONALIZATION_CLASSES[realmKey];

const resolveOwnerStatusLabel = (
  statusKey: OwnerStatusKey,
  profileId: string,
  realmKey: RealmKey,
  texts: ResidentManuscriptTexts,
): string => {
  if (profileId === 'retinue' && statusKey === 'noble') {
    return realmKey === 'rockhill'
      ? 'Royal service'
      : 'Sovereign service';
  }
  if (profileId === 'imperial') {
    return statusKey === 'noble' ? 'Imperial protection' : 'Imperial service';
  }
  if (profileId === 'enigma_crown') {
    return statusKey === 'noble' ? 'Royal power' : 'Royal court';
  }
  if (profileId === 'valorian_church') {
    return statusKey === 'noble' ? 'Holy See' : 'Church service';
  }
  if (profileId === 'grenzelhoft_mission') {
    return statusKey === 'noble'
      ? 'Imperial representative'
      : 'Imperial mandate';
  }
  if (profileId === 'heartfelt_noble') {
    return 'Noble resident of Hartfelt';
  }
  if (profileId === 'heartfelt_identity') {
    return statusKey === 'noble'
      ? 'Noble resident of Hartfelt'
      : 'Resident of Hartfelt';
  }
  if (profileId === 'otava') {
    if (realmKey === 'rockhill') {
      return statusKey === 'noble'
        ? 'Royal Patronage'
        : 'Otava mission';
    }
    return statusKey === 'noble' ? 'Otava protection' : 'Otava Inquisition';
  }
  if (profileId === 'merchant') {
    return statusKey === 'noble'
      ? 'Valorian patrician'
      : 'Valorian trade protection';
  }
  return (
    texts.owner_status_options[statusKey] || texts.owner_status_options.commoner
  );
};

const displayValue = (
  value: string | number | null | undefined,
  emptyText: string,
): string => {
  if (value === null || value === undefined || value === '') {
    return emptyText;
  }
  return String(value);
};

const classes = (...classNames: Array<string | false | null | undefined>) =>
  classNames.filter(Boolean).join(' ');

const hasDefect = (defectKeys: string[], defectKey: string): boolean =>
  defectKeys.includes(defectKey);

const toOwnerAgeKey = (
  value: string | number | null | undefined,
): OwnerAgeKey | null => {
  if (value === null || value === undefined) {
    return null;
  }
  const text = String(value);
  return OWNER_AGE_OPTIONS.includes(text as OwnerAgeKey)
    ? (text as OwnerAgeKey)
    : null;
};

const ownerAgeLabel = (
  value: string | number | null | undefined,
  texts: ResidentManuscriptTexts,
): string => {
  const key = toOwnerAgeKey(value);
  if (key) {
    return texts.owner_age_options[key] || key;
  }
  return displayValue(value, texts.states.empty);
};

const getSealTitle = (
  seal: SealData,
  texts: ResidentManuscriptTexts,
): string => seal.label || texts.seals[seal.key]?.title || seal.key;

const getSealStamper = (
  seal: SealData,
  texts: ResidentManuscriptTexts,
): string => {
  if (seal.suspicious) {
    return texts.states.unclear_hand;
  }
  return seal.stamper || texts.seals[seal.key]?.stamper || seal.key;
};

const getSealMark = (
  seal: SealData,
  texts: ResidentManuscriptTexts,
): string => {
  const title = getSealTitle(seal, texts);
  return title.trim().slice(0, 1) || seal.key.trim().slice(0, 1);
};

export const ResidentManuscript = () => {
  const { act, data } = useBackend<ResidentManuscriptData>();
  const {
    owner,
    issued_place,
    realm_key,
    expiry_date,
    is_bound,
    is_blank,
    is_owner,
    profile,
    seals = [],
    verification,
    permissions,
  } = data;

  const texts = TEXTS;
  const profileId = resolveProfileId(profile, texts);
  const profileTexts = resolveProfileTexts(texts, profileId, profile);
  const realmKey = resolveRealmKey(realm_key, issued_place);
  const personalizationClass = resolvePersonalizationClass(realmKey);
  const profileClassName = `ResidentManuscript--profile-${profileId}`;
  const personalizationClassName =
    `ResidentManuscript--personalization-${personalizationClass}`;
  const ownerStatusKey: OwnerStatusKey = owner.status_key || 'commoner';
  const [ownerName, setOwnerName] = useState(owner.name ?? '');
  const [ownerAge, setOwnerAge] = useState<OwnerAgeKey>(
    toOwnerAgeKey(owner.age) || 'Adult',
  );
  const [ownerStatus, setOwnerStatus] =
    useState<OwnerStatusKey>(ownerStatusKey);

  const canEdit = !!permissions.can_edit;
  const showVerification = !is_owner;
  const defectKeys = verification.defect_note_keys ?? [];
  const defectNotes = defectKeys.map((key) => texts.defects[key] || key);
  const validationNote = verification.note_key
    ? texts.validation_notes[verification.note_key]
    : '';
  const verificationText =
    validationNote ||
    texts.verification[verification.result] ||
    texts.verification.none;
  const ownerStatusLabel = resolveOwnerStatusLabel(
    ownerStatusKey,
    profileId,
    realmKey,
    texts,
  );
  const sheetClassName = classes(
    'ResidentManuscript__sheet',
    defectKeys.length > 0 && 'ResidentManuscript__sheet--defective',
    ...defectKeys.map((key) => `ResidentManuscript__sheet--${key}`),
  );

  return (
    <Window
      width={820}
      height={760}
      title={profileTexts.display_name || texts.window_title}
      theme="grimoire"
    >
      <Window.Content className="ResidentManuscriptWindow" scrollable>
        <div
          className={classes(
            'ResidentManuscript',
            profileClassName,
            personalizationClassName,
          )}
        >
          <div className={sheetClassName}>
            <DefectOverlay defectKeys={defectKeys} texts={texts} />
            <DocumentOrnament position="top" />
            <main className="ResidentManuscript__body">
              <header className="ResidentManuscript__header">
                <DocumentCrest profileId={profileId} />
                <div className="ResidentManuscript__titleBlock">
                  <div className="ResidentManuscript__pretitle">
                    {profileTexts.subtitle}
                  </div>
                  <div className="ResidentManuscript__title">
                    {profileTexts.display_name}
                  </div>
                  <div className="ResidentManuscript__subtitle">
                    {texts.subtitle_prefix}
                  </div>
                </div>
              </header>

              <div className="ResidentManuscript__divider" />

              <section className="ResidentManuscript__recipientBlock">
                <div className="ResidentManuscript__fieldLabel">
                  {texts.labels.owner}
                </div>
                <div
                  className={classes(
                    'ResidentManuscript__recipient',
                    hasDefect(defectKeys, 'owner_wobble') &&
                      'ResidentManuscript__recipient--ownerWobble',
                  )}
                >
                  {canEdit ? (
                    <Input
                      fluid
                      placeholder={texts.placeholders.owner}
                      value={ownerName}
                      onChange={setOwnerName}
                    />
                  ) : (
                    displayValue(owner.name, texts.states.empty)
                  )}
                </div>
              </section>

              <div className="ResidentManuscript__bodyText">
                {profileTexts.description}
              </div>

              <section className="ResidentManuscript__fields">
                <ManuscriptField label={texts.labels.age}>
                  {canEdit ? (
                    <div className="ResidentManuscript__choiceButtons">
                      {OWNER_AGE_OPTIONS.map((key) => (
                        <Button
                          key={key}
                          selected={ownerAge === key}
                          onClick={() => setOwnerAge(key)}
                        >
                          {texts.owner_age_options[key] || key}
                        </Button>
                      ))}
                    </div>
                  ) : (
                    ownerAgeLabel(owner.age, texts)
                  )}
                </ManuscriptField>

                <ManuscriptField label={texts.labels.status}>
                  {canEdit ? (
                    <div className="ResidentManuscript__choiceButtons">
                      {(
                        Object.keys(
                          texts.owner_status_options,
                        ) as OwnerStatusKey[]
                      ).map((key) => (
                        <Button
                          key={key}
                          selected={ownerStatus === key}
                          onClick={() => setOwnerStatus(key)}
                        >
                          {resolveOwnerStatusLabel(
                            key,
                            profileId,
                            realmKey,
                            texts,
                          )}
                        </Button>
                      ))}
                    </div>
                  ) : (
                    displayValue(ownerStatusLabel, texts.states.empty)
                  )}
                </ManuscriptField>

                <ManuscriptField label={texts.labels.issued}>
                  {displayValue(issued_place, texts.states.empty)}
                </ManuscriptField>

                <ManuscriptField
                  label={texts.labels.expires}
                  className={
                    hasDefect(defectKeys, 'corrected_date')
                      ? 'ResidentManuscript__field--correctedDate'
                      : undefined
                  }
                >
                  {displayValue(expiry_date, texts.states.empty)}
                </ManuscriptField>
              </section>

              <div className="ResidentManuscript__notice">
                {!is_bound
                  ? texts.states.unbound
                  : is_owner
                    ? texts.states.owner
                    : texts.states.other}
              </div>

              {!!is_blank && (
                <div className="ResidentManuscript__note">
                  {texts.states.blank_hint}
                </div>
              )}

              {canEdit && (
                <div className="ResidentManuscript__note">
                  {texts.states.fake_edit_hint}
                </div>
              )}

              <section className="ResidentManuscript__sealSection">
                <div className="ResidentManuscript__sectionTitle">
                  {texts.labels.seals}
                </div>
                <div className="ResidentManuscript__seals">
                  {seals
                    .filter((seal) => !!seal.visible)
                    .map((seal) => (
                      <ResidentManuscriptSeal
                        defectKeys={defectKeys}
                        key={seal.key}
                        seal={seal}
                        texts={texts}
                      />
                    ))}
                </div>
              </section>

              {showVerification && (
                <section className="ResidentManuscript__verification">
                  <div className="ResidentManuscript__sectionTitle">
                    {texts.labels.verification}
                  </div>
                  <div
                    className={`ResidentManuscript__verificationText ResidentManuscript__verificationText--${verification.result}`}
                  >
                    {verificationText}
                  </div>
                  {verification.result === 'fake' && defectNotes.length > 0 && (
                    <div className="ResidentManuscript__defects">
                      <div className="ResidentManuscript__defectTitle">
                        {texts.labels.defects}
                      </div>
                      {defectNotes.map((note) => (
                        <div className="ResidentManuscript__defect" key={note}>
                          {note}
                        </div>
                      ))}
                    </div>
                  )}
                </section>
              )}

              <div className="ResidentManuscript__actions">
                {canEdit && (
                  <Button
                    icon="save"
                    tooltip={texts.tooltips.save}
                    onClick={() =>
                      act('save_fake', {
                        owner_name: ownerName,
                        owner_age: ownerAge,
                        owner_status_key: ownerStatus,
                      })
                    }
                  >
                    {texts.buttons.save}
                  </Button>
                )}

                {!!permissions.can_bind && (
                  <Button
                    icon="signature"
                    tooltip={texts.tooltips.bind}
                    onClick={() => act('bind')}
                  >
                    {texts.buttons.bind}
                  </Button>
                )}

                {!!permissions.can_stamp && (
                  <Button
                    icon="stamp"
                    tooltip={texts.tooltips.stamp}
                    onClick={() => act('stamp')}
                  >
                    {texts.buttons.stamp}
                  </Button>
                )}

                {!!permissions.can_inspect && (
                  <Button
                    icon="search"
                    tooltip={texts.tooltips.inspect}
                    onClick={() => act('inspect')}
                  >
                    {texts.buttons.inspect}
                  </Button>
                )}

                {!!permissions.can_claim && (
                  <Button
                    icon="key"
                    tooltip={texts.tooltips.claim}
                    onClick={() => act('claim_residence')}
                  >
                    {texts.buttons.claim}
                  </Button>
                )}
              </div>
            </main>
            <DocumentOrnament position="bottom" />
          </div>
        </div>
      </Window.Content>
    </Window>
  );
};

type ManuscriptFieldProps = {
  label: string;
  children: ReactNode;
  className?: string;
};

type DocumentOrnamentProps = {
  position: 'top' | 'bottom';
};

const DocumentOrnament = (props: DocumentOrnamentProps) => {
  const { position } = props;

  return (
    <div
      className={classes(
        'ResidentManuscript__ornament',
        `ResidentManuscript__ornament--${position}`,
      )}
      aria-hidden="true"
    >
      <svg viewBox="0 0 760 78" preserveAspectRatio="none">
        <path
          className="ResidentManuscript__ornamentGold"
          d="M30 40 C84 9 147 9 201 39 C244 63 287 63 330 39 C352 27 369 19 380 14 C391 19 408 27 430 39 C473 63 516 63 559 39 C613 9 676 9 730 40"
          fill="none"
        />
        <path
          className="ResidentManuscript__ornamentBlue"
          d="M38 52 C86 24 139 24 187 50 M573 50 C621 24 674 24 722 52"
          fill="none"
        />
        <path
          className="ResidentManuscript__ornamentBlue"
          d="M238 42 C281 16 329 16 372 42 M388 42 C431 16 479 16 522 42"
          fill="none"
        />
        <path
          className="ResidentManuscript__ornamentGold"
          d="M380 9 L390 33 L416 34 L395 49 L402 73 L380 58 L358 73 L365 49 L344 34 L370 33 Z"
        />
      </svg>
    </div>
  );
};

type DocumentCrestProps = {
  profileId: DocumentProfileId;
};

const PROFILE_EMBLEMS: Partial<Record<DocumentProfileId, ReactNode>> = {
  resident: (
    <>
      <path
        className="ResidentManuscript__crestRay"
        d="M48 28 L54 46 L72 46 L57 56 L62 74 L48 64 L34 74 L39 56 L24 46 L42 46 Z"
      />
      <rect
        className="ResidentManuscript__crestEmblem"
        x="32"
        y="76"
        width="32"
        height="6"
      />
      <circle className="ResidentManuscript__crestGem" cx="34" cy="32" r="3" />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="22" r="3.5" />
      <circle className="ResidentManuscript__crestGem" cx="62" cy="32" r="3" />
    </>
  ),
  imperial: (
    <>
      <path
        className="ResidentManuscript__crestRay"
        d="M26 72 L48 24 L70 72 L60 72 L54 60 L42 60 L36 72 Z"
      />
      <path
        className="ResidentManuscript__crestEmblem"
        d="M30 78 L66 78 L66 84 L30 84 Z"
      />
      <path
        className="ResidentManuscript__crestQuarter"
        d="M38 52 H58 M48 34 V78"
        fill="none"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="52" r="3" />
    </>
  ),
  enigma_crown: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M26 70 L30 42 L42 54 L48 34 L54 54 L66 42 L70 70 Z"
      />
      <rect
        className="ResidentManuscript__crestEmblem"
        x="28"
        y="70"
        width="40"
        height="8"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="34" r="3" />
      <circle className="ResidentManuscript__crestGem" cx="30" cy="42" r="2" />
      <circle className="ResidentManuscript__crestGem" cx="66" cy="42" r="2" />
    </>
  ),
  valorian_church: (
    <>
      <circle
        className="ResidentManuscript__crestEmblem"
        cx="48"
        cy="56"
        r="15"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M48 22 L52 44 L74 48 L54 58 L58 82 L48 68 L38 82 L42 58 L22 48 L44 44 Z"
      />
      <path
        className="ResidentManuscript__crestQuarter"
        d="M36 56 H60 M48 44 V70"
        fill="none"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="56" r="4" />
    </>
  ),
  grenzelhoft_mission: (
    <>
      <path
        className="ResidentManuscript__crestRay"
        d="M48 20 L55 42 L78 42 L59 55 L66 78 L48 64 L30 78 L37 55 L18 42 L41 42 Z"
      />
      <path
        className="ResidentManuscript__crestEmblem"
        d="M28 82 H68 V88 H28 Z"
      />
      <path
        className="ResidentManuscript__crestQuarter"
        d="M34 48 H62 M48 28 V82"
        fill="none"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="52" r="3" />
    </>
  ),
  heartfelt_identity: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M28 74 C34 58 38 42 48 28 C58 42 62 58 68 74 Z"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M34 58 C40 52 44 46 48 34 C52 46 56 52 62 58 M34 72 H62"
        fill="none"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="52" r="3" />
    </>
  ),
  heartfelt_noble: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M24 68 L30 42 L40 54 L48 28 L56 54 L66 42 L72 68 Z"
      />
      <rect
        className="ResidentManuscript__crestEmblem"
        x="28"
        y="68"
        width="40"
        height="8"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M32 84 H64"
        fill="none"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="28" r="3" />
      <circle className="ResidentManuscript__crestGem" cx="30" cy="42" r="2" />
      <circle className="ResidentManuscript__crestGem" cx="66" cy="42" r="2" />
    </>
  ),
  guards: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M48 24 L52 30 L52 78 L48 84 L44 78 L44 30 Z"
      />
      <path
        className="ResidentManuscript__crestEmblem"
        d="M30 36 L66 36 L66 42 L30 42 Z"
      />
      <path
        className="ResidentManuscript__crestQuarter"
        d="M22 56 L48 70 L74 56"
        fill="none"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="34" r="3" />
    </>
  ),
  church: (
    <>
      <circle
        className="ResidentManuscript__crestEmblem"
        cx="48"
        cy="56"
        r="14"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M48 24 L51 38 L45 38 Z M48 88 L51 74 L45 74 Z M16 56 L30 53 L30 59 Z M80 56 L66 53 L66 59 Z M26 34 L36 42 L32 46 Z M70 34 L60 42 L64 46 Z M26 78 L36 70 L32 66 Z M70 78 L60 70 L64 66 Z"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="56" r="5" />
    </>
  ),
  craftsmen: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M22 78 L74 78 L74 72 L62 68 L34 68 L22 72 Z"
      />
      <rect
        className="ResidentManuscript__crestEmblem"
        x="30"
        y="58"
        width="36"
        height="10"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M40 22 L60 22 L60 32 L52 38 L52 56 L44 56 L44 38 L40 32 Z"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="48" r="3" />
    </>
  ),
  merchant: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M22 64 Q24 48 36 42 Q40 32 46 30 L56 28 Q62 30 66 36 Q72 40 74 50 L74 60 Q72 70 60 72 L28 72 Q22 70 22 64 Z"
      />
      <path
        className="ResidentManuscript__crestEmblem"
        d="M44 30 L42 22 L48 26 Z"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M70 38 L74 30 M68 44 L74 46"
        fill="none"
      />
      <circle className="ResidentManuscript__crestGem" cx="62" cy="44" r="2" />
    </>
  ),
  mages: (
    <>
      <path
        className="ResidentManuscript__crestRay"
        d="M48 22 L54 42 L74 42 L58 54 L64 74 L48 62 L32 74 L38 54 L22 42 L42 42 Z"
      />
      <ellipse
        className="ResidentManuscript__crestEmblem"
        cx="48"
        cy="50"
        rx="11"
        ry="6"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="50" r="3" />
    </>
  ),
  commoner: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M48 26 L48 80"
        fill="none"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M48 28 Q42 32 42 38 Q44 34 48 34 Q52 34 54 38 Q54 32 48 28 Z"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M48 40 Q40 44 38 52 Q42 48 48 48 Q54 48 58 52 Q56 44 48 40 Z"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M48 52 Q38 56 34 66 Q40 62 48 62 Q56 62 62 66 Q58 56 48 52 Z"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="76" r="3" />
    </>
  ),
  mercenary: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M30 30 L48 18 L66 30 L66 50 L60 64 L72 76 L48 70 L24 76 L36 64 L30 50 Z"
      />
      <path
        className="ResidentManuscript__crestQuarter"
        d="M40 38 L42 42 L40 46 Z M56 38 L54 42 L56 46 Z"
        fill="none"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M44 54 L48 60 L52 54 L51 60 L45 60 Z"
      />
      <circle className="ResidentManuscript__crestGem" cx="42" cy="42" r="1.5" />
      <circle className="ResidentManuscript__crestGem" cx="54" cy="42" r="1.5" />
    </>
  ),
  otava: (
    <>
      <path
        className="ResidentManuscript__crestEmblem"
        d="M28 56 L36 78 L60 78 L68 56 L66 44 L30 44 Z"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M48 18 Q56 30 50 40 Q44 32 48 18 Z"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M40 24 Q46 34 42 42 Q38 34 40 24 Z"
      />
      <path
        className="ResidentManuscript__crestRay"
        d="M56 24 Q54 34 56 42 Q60 34 56 24 Z"
      />
      <circle className="ResidentManuscript__crestGem" cx="48" cy="62" r="3" />
    </>
  ),
};

const DocumentCrest = (props: DocumentCrestProps) => {
  const { profileId } = props;
  const emblem = PROFILE_EMBLEMS[profileId] ?? PROFILE_EMBLEMS.resident;

  return (
    <svg
      className={classes(
        'ResidentManuscript__crest',
        `ResidentManuscript__crest--${profileId}`,
      )}
      aria-hidden="true"
      viewBox="0 0 96 112"
    >
      <path
        className="ResidentManuscript__crestShield"
        d="M48 8 L82 20 V52 C82 76 67 94 48 104 C29 94 14 76 14 52 V20 Z"
      />
      {emblem}
    </svg>
  );
};

const ManuscriptField = (props: ManuscriptFieldProps) => {
  const { label, children, className } = props;

  return (
    <div className={classes('ResidentManuscript__field', className)}>
      <div className="ResidentManuscript__fieldLabel">{label}</div>
      <div className="ResidentManuscript__fieldValue">{children}</div>
    </div>
  );
};

type ResidentManuscriptSealProps = {
  defectKeys: string[];
  seal: SealData;
  texts: ResidentManuscriptTexts;
};

const ResidentManuscriptSeal = (props: ResidentManuscriptSealProps) => {
  const { defectKeys, seal, texts } = props;
  const sealClassName = classes(
    'ResidentManuscript__seal',
    !!seal.stamped && 'ResidentManuscript__seal--stamped',
    !!seal.dominant && 'ResidentManuscript__seal--dominant',
    !!seal.suspicious && 'ResidentManuscript__seal--suspicious',
    hasDefect(defectKeys, 'seal_smudge') &&
      'ResidentManuscript__seal--smudged',
    hasDefect(defectKeys, 'reheated_wax') &&
      'ResidentManuscript__seal--reheated',
    hasDefect(defectKeys, 'uncertain_hand') &&
      'ResidentManuscript__seal--uncertain',
  );

  const sealTitle = getSealTitle(seal, texts);
  const sealStamper = getSealStamper(seal, texts);

  return (
    <div
      className={sealClassName}
      aria-label={`${texts.aria.seal}: ${sealTitle}`}
    >
      <div className="ResidentManuscript__sealName">{sealTitle}</div>
      {seal.stamped ? (
        <>
          <div
            className={classes(
              'ResidentManuscript__waxSeal',
              seal.key === 'ruler' && 'ResidentManuscript__waxSeal--royal',
            )}
          >
            <span className="ResidentManuscript__waxSealMark">
              {getSealMark(seal, texts)}
            </span>
            {seal.key === 'ruler' && (
              <svg
                className="ResidentManuscript__waxSealCrown"
                aria-hidden="true"
                viewBox="0 0 80 80"
              >
                <g
                  fill="#f3c164"
                  stroke="#5c0c0c"
                  strokeLinejoin="round"
                  strokeWidth="2"
                >
                  <path d="M22 48 L25 28 L34 40 L40 24 L47 40 L56 28 L59 48 Z" />
                  <path d="M24 51 H58 V57 H24 Z" />
                  <circle cx="25" cy="27" r="3" />
                  <circle cx="40" cy="23" r="3" />
                  <circle cx="56" cy="27" r="3" />
                </g>
              </svg>
            )}
          </div>
          <div className="ResidentManuscript__sealMark">
            {displayValue(sealStamper, texts.states.unknown)}
          </div>
        </>
      ) : (
        <div className="ResidentManuscript__sealMissing">
          {texts.states.seal_missing}
        </div>
      )}
    </div>
  );
};

type DefectOverlayProps = {
  defectKeys: string[];
  texts: ResidentManuscriptTexts;
};

const FRESH_PRICKING_OFFSETS = [0, 18, 36, 54, 72, 90, 108, 126, 144];
const RETHREADED_CORD_OFFSETS = [18, 46, 74];

const DefectOverlay = (props: DefectOverlayProps) => {
  const { defectKeys, texts } = props;

  if (!defectKeys.length) {
    return null;
  }

  return (
    <div className="ResidentManuscript__defectOverlay" aria-hidden="true">
      {hasDefect(defectKeys, 'ink_blot') && (
        <div className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--inkBlot" />
      )}
      {hasDefect(defectKeys, 'stale_smell') && (
        <div className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--staleSmell" />
      )}
      {hasDefect(defectKeys, 'blue_halo') && (
        <div className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--blueHalo" />
      )}
      {hasDefect(defectKeys, 'ragged_edge') && (
        <svg
          className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--raggedEdge"
          viewBox="0 0 18 600"
          preserveAspectRatio="none"
        >
          <path
            d="M13 0 L7 38 L15 72 L5 111 L13 153 L6 196 L16 234 L7 279 L14 322 L5 366 L12 410 L6 454 L15 498 L7 548 L13 600"
            fill="none"
            stroke="rgba(138, 26, 26, 0.72)"
            strokeLinecap="round"
            strokeWidth="2.2"
          />
        </svg>
      )}
      {hasDefect(defectKeys, 'misaligned_initial') && (
        <div className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--misalignedInitial">
          {texts.visual_hints.misaligned_initial}
        </div>
      )}
      {hasDefect(defectKeys, 'fresh_pricking') && (
        <div className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--freshPricking">
          <div className="ResidentManuscript__freshPrickingLine ResidentManuscript__freshPrickingLine--top" />
          <div className="ResidentManuscript__freshPrickingLine ResidentManuscript__freshPrickingLine--bottom" />
          {FRESH_PRICKING_OFFSETS.map((left) => (
            <span key={left} style={{ left: `${left}px` }} />
          ))}
        </div>
      )}
      {hasDefect(defectKeys, 'cut_gilding') && (
        <svg
          className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--cutGilding"
          viewBox="0 0 700 28"
          preserveAspectRatio="none"
        >
          <path
            d="M12 17 L72 17 L86 7 L102 18 L190 18 L207 9 L223 19 L366 19 L382 8 L397 18 L520 18 L538 9 L554 19 L686 19"
            fill="none"
            stroke="rgba(124, 94, 26, 0.74)"
            strokeLinecap="round"
            strokeWidth="2.4"
          />
          <path
            d="M86 7 L92 21 M207 9 L213 22 M382 8 L389 22 M538 9 L545 22"
            fill="none"
            stroke="rgba(138, 26, 26, 0.58)"
            strokeLinecap="round"
            strokeWidth="1.5"
          />
        </svg>
      )}
      {hasDefect(defectKeys, 'rethreaded_cord') && (
        <div className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--rethreadedCord">
          <div className="ResidentManuscript__rethreadedCordLine" />
          {RETHREADED_CORD_OFFSETS.map((left) => (
            <span key={left} style={{ left: `${left}px` }} />
          ))}
        </div>
      )}
      {hasDefect(defectKeys, 'heretical_marginalia') && (
        <div className="ResidentManuscript__visualDefect ResidentManuscript__visualDefect--hereticalMarginalia">
          {texts.visual_hints.heretical_marginalia_lines.map((line) => (
            <div key={line}>{line}</div>
          ))}
        </div>
      )}
    </div>
  );
};
