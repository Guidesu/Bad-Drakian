#define CHASTITY_HARDMODE_DISABLED 0
#define CHASTITY_HARDMODE_ENABLED 1

#define CHASTITY_MOVE_SOUND_DELAY 4
#define CHASTITY_HIGH_POP_THRESHOLD 120
#define CHASTITY_HIGH_POP_SOUND_MULT 0.4

#define TRAIT_CHASTITY_FULL "Chastity Belt"
#define TRAIT_CHASTITY_CAGE "Chastity Cage"
#define TRAIT_CHASTITY_PENIS_BLOCKED "Penis Shielded"
#define TRAIT_CHASTITY_VAGINA_BLOCKED "Vagina Shielded"
#define TRAIT_CHASTITY_ANAL "Anal Shield"
#define TRAIT_CHASTITY_SPIKED "Genital Spikes"
#define TRAIT_CHASTITY_LOCKED "Locked Chastity Device"
#define TRAIT_SOURCE_CHASTITY "chastity"

#define COMSIG_CARBON_CHASTITY_STATE_CHANGED "carbon_chastity_state_changed"
#define COMSIG_CARBON_CHASTITY_LOCK_INTERACT "carbon_chastity_lock_interact"
#define COMSIG_CARBON_CHASTITY_LOCK_CHANGED "carbon_chastity_lock_changed"
#define COMPONENT_CHASTITY_LOCK_INTERACT_BLOCK (1<<0)
#define BODYPART_FEATURE_CHASTITY "chastity"

#define COMSIG_CARBON_GAIN_COLLAR "carbon_gain_collar"
#define COMSIG_CARBON_LOSE_COLLAR "carbon_lose_collar"
#define COMSIG_CARBON_GAIN_CHASTITY "carbon_gain_chastity"
#define COMSIG_CARBON_LOSE_CHASTITY "carbon_lose_chastity"
#define COMSIG_CARBON_COLLAR_COMMAND "carbon_collar_command"
#define COMSIG_CARBON_COLLAR_RELEASED "carbon_collar_released"
#define COMSIG_CARBON_COLLAR_BIND_ATTEMPT "carbon_collar_bind_attempt"
#define COMSIG_CARBON_COLLAR_BOUND "carbon_collar_bound"
#define COMPONENT_COLLAR_COMMAND_BLOCK (1<<0)
#define COMPONENT_COLLAR_BIND_BLOCK (1<<0)
#define COLLAR_COMMAND_SHOCK "shock"
#define COLLAR_COMMAND_FORCE_STRIP "force_strip"
#define COLLAR_COMMAND_FORCE_SURRENDER "force_surrender"
#define COLLAR_COMMAND_TOGGLE_AROUSAL "toggle_arousal"
#define COLLAR_COMMAND_TOGGLE_SPEECH "toggle_speech"
#define COLLAR_COMMAND_TOGGLE_DENIAL "toggle_denial"
#define COLLAR_COMMAND_SET_CHASTITY_LOCK "set_chastity_lock"
#define COLLAR_COMMAND_SET_CHASTITY_FRONT_MODE "set_chastity_front_mode"
#define COLLAR_COMMAND_SET_CHASTITY_ANAL_OPEN "set_chastity_anal_open"
#define COLLAR_COMMAND_SET_CHASTITY_SPIKES "set_chastity_spikes"
#define COLLAR_COMMAND_SET_CHASTITY_FLAT "set_chastity_flat"

#define COLLAR_LOG_SHOCK "shock"
#define COLLAR_LOG_FORCE_STRIP "force_strip"
#define COLLAR_LOG_HALLUCINATIONS "toggle_hallucinations"
#define COLLAR_LOG_SURRENDER "force_surrender"
#define COLLAR_LOG_AROUSAL "toggle_arousal"
#define COLLAR_LOG_LOVE "toggle_love"
#define COLLAR_LOG_CLOTHING "permit_clothing"
#define COLLAR_LOG_SPEECH "toggle_speech"
#define COLLAR_LOG_DENIAL "toggle_denial"
#define CHASTITY_LOG_IMPRINT "imprint"
#define CHASTITY_LOG_LOCK "lock"
#define CHASTITY_LOG_FRONT "front"
#define CHASTITY_LOG_ANAL "anal"
#define CHASTITY_LOG_SPIKES "spikes"
#define CHASTITY_LOG_FLAT "flat"

/// Root directory for all chastity flavor-text JSON banks.
/// Used by pick_chastity_string() and anywhere a raw strings() call targets the chastity string dir.
#define CHASTITY_STRINGS_PATH "modular/code/game/objects/items/lewd/chastity/strings"

/// Picks a random entry from a chastity string bank.
/// Usage: pick_chastity_string("chastity_lock_messages.json", "chastity_lock_denial")
#define pick_chastity_string(FILE, KEY) (pick(strings(FILE, KEY, CHASTITY_STRINGS_PATH)))
