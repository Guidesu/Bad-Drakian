/*
 * Ratwood chastity-play catalogue adapted to the canonical ERP controller.
 * Device presence, shielding, clothing bypass, spiked-device modifiers, and
 * movement sounds are enforced centrally by action tags.
 */

/datum/erp_action/other/chastity
	abstract = TRUE
	require_same_tile = TRUE
	active_arousal_coeff = 0.5
	passive_arousal_coeff = 1.0
	active_pain_coeff = 0
	passive_pain_coeff = 0.5

/datum/erp_action/self/chastity
	abstract = TRUE
	required_init_organ = SEX_ORGAN_HANDS
	active_arousal_coeff = 0.4
	passive_arousal_coeff = 1.1
	active_pain_coeff = 0
	passive_pain_coeff = 0.5

/datum/erp_action/other/chastity/lick_belt
	abstract = FALSE
	name = "Lick through their belt"
	required_init_organ = SEX_ORGAN_MOUTH
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "target_chastity", "target_vagina_chastity")
	passive_arousal_coeff = 1.8
	message_start = "{actor} kneels before {partner}'s chastity belt."
	message_tick = "{actor} {force} and {speed} works {actor_their} tongue through the slits of {partner}'s belt."
	message_finish = "{actor} draws back from {partner}'s belt."

/datum/erp_action/other/chastity/work_inverted_dildo
	abstract = FALSE
	name = "Work their inverted dildo"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "target_chastity", "target_vagina_chastity")
	passive_arousal_coeff = 2.3
	passive_pain_coeff = 1.5
	message_start = "{actor} grips the housing of {partner}'s chastity belt."
	message_tick = "{actor} {force} and {speed} rocks {partner}'s belt, working the internal toy."
	message_finish = "{actor} steadies {partner}'s belt and lets go."

/datum/erp_action/other/chastity/grind_cage_pussy
	abstract = FALSE
	name = "Grind your cage on their pussy"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity")
	active_arousal_coeff = 1.2
	passive_arousal_coeff = 1.7
	passive_pain_coeff = 1
	message_start = "{actor} presses {actor_their} cage against {partner}'s pussy."
	message_tick = "{actor} {force} and {speed} grinds {actor_their} cage against {partner}'s pussy."
	message_finish = "{actor} eases {actor_their} cage away from {partner}."

/datum/erp_action/other/chastity/grind_cage_slit
	abstract = FALSE
	name = "Grind your cage on their genital slit"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity", "target_slit")
	active_arousal_coeff = 1.2
	passive_arousal_coeff = 1.6
	message_start = "{actor} presses {actor_their} cage to {partner}'s genital slit."
	message_tick = "{actor} {force} and {speed} grinds {actor_their} cage along {partner}'s slit."
	message_finish = "{actor} breaks contact with {partner}'s slit."

/datum/erp_action/other/chastity/tug_cage
	abstract = FALSE
	name = "Tug on their cage"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "target_chastity", "target_penis_chastity")
	passive_arousal_coeff = 0.6
	passive_pain_coeff = 4
	message_start = "{actor} hooks {actor_their} fingers beneath {partner}'s cage."
	message_tick = "{actor} {force} and {speed} tugs on {partner}'s chastity cage."
	message_finish = "{actor} releases {partner}'s cage."

/datum/erp_action/other/chastity/twist_cage
	abstract = FALSE
	name = "Twist their cage"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "target_chastity", "target_penis_chastity")
	passive_arousal_coeff = 0.4
	passive_pain_coeff = 6
	message_start = "{actor} takes hold of {partner}'s cage."
	message_tick = "{actor} {force} and {speed} twists {partner}'s chastity cage against its mount."
	message_finish = "{actor} lets {partner}'s cage settle into place."

/datum/erp_action/other/chastity/cage_to_belt
	abstract = FALSE
	name = "Press cage to belt"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity", "target_chastity", "target_vagina_chastity")
	active_arousal_coeff = 1.1
	passive_arousal_coeff = 1.1
	active_pain_coeff = 1
	passive_pain_coeff = 1
	message_start = "{actor} presses {actor_their} cage against {partner}'s locked belt."
	message_tick = "{actor} {force} and {speed} grinds cage against belt with a rasp of metal."
	message_finish = "{actor} separates the two chastity devices."

/datum/erp_action/other/chastity/fondle
	abstract = FALSE
	name = "Fondle their chastity device"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_BODY
	action_tags = list("chastity_action", "target_chastity")
	passive_arousal_coeff = 1.3
	passive_pain_coeff = 0.5
	message_start = "{actor} wraps {actor_their} fingers around {partner}'s chastity device."
	message_tick = "{actor} {force} and {speed} rubs and presses on {partner}'s chastity device."
	message_finish = "{actor} withdraws {actor_their} hand from {partner}'s device."

/datum/erp_action/other/chastity/force_onto_cage
	abstract = FALSE
	name = "Force them onto your cage"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_MOUTH
	require_grab = TRUE
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity")
	active_arousal_coeff = 1.3
	passive_arousal_coeff = 0.4
	passive_pain_coeff = 2
	message_start = "{actor} forces {partner}'s mouth against {actor_their} cage."
	message_tick = "{actor} {force} and {speed} grinds {actor_their} cage against {partner}'s mouth."
	message_finish = "{actor} releases {partner} from {actor_their} cage."

/datum/erp_action/other/chastity/force_lick_belt
	abstract = FALSE
	name = "Force them to lick your belt"
	required_init_organ = SEX_ORGAN_VAGINA
	required_target_organ = SEX_ORGAN_MOUTH
	require_grab = TRUE
	action_tags = list("chastity_action", "active_chastity", "active_vagina_chastity")
	active_arousal_coeff = 1.5
	passive_arousal_coeff = 0.4
	message_start = "{actor} pulls {partner}'s face against {actor_their} belt."
	message_tick = "{actor} {force} and {speed} grinds {actor_their} belt against {partner}'s tongue."
	message_finish = "{actor} lets {partner} pull away from {actor_their} belt."

/datum/erp_action/other/chastity/force_nuzzle
	abstract = FALSE
	name = "Force them to nuzzle your cage"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_MOUTH
	require_grab = TRUE
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity")
	active_arousal_coeff = 1.2
	passive_arousal_coeff = 0.4
	message_start = "{actor} pulls {partner}'s face against {actor_their} cage."
	message_tick = "{actor} {force} and {speed} makes {partner} nuzzle {actor_their} chastity cage."
	message_finish = "{actor} releases {partner} from {actor_their} cage."

/datum/erp_action/other/chastity/force_rim_shield
	abstract = FALSE
	name = "Force them to rim your shield"
	required_init_organ = SEX_ORGAN_ANUS
	required_target_organ = SEX_ORGAN_MOUTH
	require_grab = TRUE
	action_tags = list("chastity_action", "active_chastity", "active_anal_shield")
	active_arousal_coeff = 1.5
	passive_arousal_coeff = 0.4
	message_start = "{actor} presses {actor_their} rear shield against {partner}'s mouth."
	message_tick = "{actor} {force} and {speed} makes {partner} tongue the gaps in {actor_their} anal shield."
	message_finish = "{actor} lifts {actor_their} shield away from {partner}."

/datum/erp_action/other/chastity/frot_other_on_cage
	abstract = FALSE
	name = "Let them frot on your cage"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity")
	active_arousal_coeff = 1.2
	passive_arousal_coeff = 1.7
	message_start = "{actor} presses {actor_their} cage to {partner}'s cock."
	message_tick = "{actor} {force} and {speed} grinds {actor_their} cage along {partner}'s cock."
	message_finish = "{actor} draws {actor_their} cage away from {partner}."

/datum/erp_action/other/chastity/frot_cage_to_cage
	abstract = FALSE
	name = "Grind cage to cage"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity", "target_chastity", "target_penis_chastity")
	active_arousal_coeff = 1.3
	passive_arousal_coeff = 1.3
	active_pain_coeff = 1
	passive_pain_coeff = 1
	message_start = "{actor} knocks {actor_their} cage against {partner}'s cage."
	message_tick = "{actor} {force} and {speed} grinds cage against cage."
	message_finish = "{actor} separates {actor_their} cage from {partner}'s."

/datum/erp_action/other/chastity/frot_their_cage
	abstract = FALSE
	name = "Frot with their chastity device"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "target_chastity", "target_penis_chastity")
	active_arousal_coeff = 1.7
	passive_arousal_coeff = 1.2
	message_start = "{actor} presses {actor_their} cock along {partner}'s cage."
	message_tick = "{actor} {force} and {speed} frots against {partner}'s chastity cage."
	message_finish = "{actor} pulls away from {partner}'s cage."

/datum/erp_action/other/chastity/kick
	abstract = FALSE
	name = "Kick their chastity cage"
	required_init_organ = SEX_ORGAN_LEGS
	required_target_organ = SEX_ORGAN_BODY
	action_tags = list("chastity_action", "target_chastity")
	active_arousal_coeff = 0.1
	passive_arousal_coeff = 0.2
	active_pain_coeff = 0
	passive_pain_coeff = 7
	message_start = "{actor} plants a foot against {partner}'s chastity device."
	message_tick = "{actor} {force} and {speed} kicks and grinds a foot into {partner}'s cage."
	message_finish = "{actor} lowers {actor_their} foot from {partner}'s cage."

/datum/erp_action/other/chastity/tease_anal_shield
	abstract = FALSE
	name = "Tease their anal shield"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_ANUS
	action_tags = list("chastity_action", "target_chastity", "target_anal_shield")
	passive_arousal_coeff = 1.4
	passive_pain_coeff = 0.5
	message_start = "{actor} traces the edge of {partner}'s rear shield."
	message_tick = "{actor} {force} and {speed} teases beneath {partner}'s anal shield."
	message_finish = "{actor} draws {actor_their} fingers from {partner}'s shield."

/datum/erp_action/self/chastity/tease_anal_shield
	abstract = FALSE
	name = "Rub your anal shield"
	required_target_organ = SEX_ORGAN_ANUS
	action_tags = list("chastity_action", "active_chastity", "active_anal_shield")
	passive_arousal_coeff = 1.4
	message_start = "{actor} reaches back to {actor_their} anal shield."
	message_tick = "{actor} {force} and {speed} rubs along the edge of {actor_their} anal shield."
	message_finish = "{actor} draws {actor_their} hand away from {actor_their} shield."

/datum/erp_action/other/chastity/stroke_caged_cock
	abstract = FALSE
	name = "Stroke their caged cock"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "target_chastity", "target_penis_chastity")
	passive_arousal_coeff = 1.8
	passive_pain_coeff = 0.5
	message_start = "{actor} closes a hand around {partner}'s cage."
	message_tick = "{actor} {force} and {speed} strokes along {partner}'s caged cock."
	message_finish = "{actor} releases {partner}'s cage."

/datum/erp_action/self/chastity/stroke_caged_cock
	abstract = FALSE
	name = "Stroke your caged cock"
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "active_chastity", "active_penis_chastity")
	passive_arousal_coeff = 1.6
	passive_pain_coeff = 0.5
	message_start = "{actor} closes a hand around {actor_their} cage."
	message_tick = "{actor} {force} and {speed} strokes {actor_their} caged cock."
	message_finish = "{actor} drops {actor_their} hand from {actor_their} cage."

/datum/erp_action/other/chastity/rub_locked_slit
	abstract = FALSE
	name = "Rub their locked slit"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "target_chastity", "target_vagina_chastity")
	passive_arousal_coeff = 1.8
	passive_pain_coeff = 0.5
	message_start = "{actor} finds the front slot in {partner}'s belt."
	message_tick = "{actor} {force} and {speed} rubs the locked slit through {partner}'s belt."
	message_finish = "{actor} slides {actor_their} fingers away from {partner}'s belt."

/datum/erp_action/self/chastity/rub_locked_slit
	abstract = FALSE
	name = "Rub your locked slit"
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "active_chastity", "active_vagina_chastity")
	passive_arousal_coeff = 1.6
	passive_pain_coeff = 0.5
	message_start = "{actor} presses {actor_their} fingers against {actor_their} belt."
	message_tick = "{actor} {force} and {speed} rubs {actor_their} locked slit through the belt."
	message_finish = "{actor} pulls {actor_their} hand away from {actor_their} belt."

/datum/erp_action/other/chastity/ride_cage
	abstract = FALSE
	name = "Ride their cage"
	required_init_organ = SEX_ORGAN_VAGINA
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "target_chastity", "target_penis_chastity")
	active_arousal_coeff = 2.1
	passive_arousal_coeff = 1.3
	passive_pain_coeff = 1
	message_start = "{actor} settles {actor_their} pussy against {partner}'s cage."
	message_tick = "{actor} {force} and {speed} rides the bars of {partner}'s cage."
	message_finish = "{actor} lifts away from {partner}'s cage."

/datum/erp_action/other/chastity/ride_cage_slit
	abstract = FALSE
	name = "Ride their cage with your slit"
	required_init_organ = SEX_ORGAN_PENIS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "active_slit", "target_chastity", "target_penis_chastity")
	active_arousal_coeff = 1.8
	passive_arousal_coeff = 1.2
	passive_pain_coeff = 1
	message_start = "{actor} settles {actor_their} genital slit over {partner}'s cage."
	message_tick = "{actor} {force} and {speed} works {actor_their} slit along {partner}'s cage."
	message_finish = "{actor} lifts {actor_their} slit from {partner}'s cage."

/datum/erp_action/other/chastity/rim_shield
	abstract = FALSE
	name = "Rim them behind their chastity shield"
	required_init_organ = SEX_ORGAN_MOUTH
	required_target_organ = SEX_ORGAN_ANUS
	action_tags = list("chastity_action", "target_chastity", "target_anal_shield")
	passive_arousal_coeff = 2
	message_start = "{actor} presses {actor_their} face beneath {partner}'s rear shield."
	message_tick = "{actor} {force} and {speed} works {actor_their} tongue beneath {partner}'s anal shield."
	message_finish = "{actor} pulls back from {partner}'s shield."

/datum/erp_action/other/chastity/scissor_locked_to_bare
	abstract = FALSE
	name = "Scissor with your locked slit"
	required_init_organ = SEX_ORGAN_VAGINA
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "active_chastity", "active_vagina_chastity")
	active_arousal_coeff = 1.6
	passive_arousal_coeff = 1.7
	active_pain_coeff = 0.5
	passive_pain_coeff = 0.5
	message_start = "{actor} presses {actor_their} locked belt slit against {partner}."
	message_tick = "{actor} {force} and {speed} scissors {actor_their} belt against {partner}'s pussy."
	message_finish = "{actor} separates {actor_their} belt from {partner}."

/datum/erp_action/other/chastity/scissor_belt_to_belt
	abstract = FALSE
	name = "Scissor belt to belt"
	required_init_organ = SEX_ORGAN_VAGINA
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "active_chastity", "active_vagina_chastity", "target_chastity", "target_vagina_chastity")
	active_arousal_coeff = 1.3
	passive_arousal_coeff = 1.3
	active_pain_coeff = 1
	passive_pain_coeff = 1
	message_start = "{actor} presses {actor_their} belt against {partner}'s belt."
	message_tick = "{actor} {force} and {speed} scissors belt against belt."
	message_finish = "{actor} untangles from {partner}'s belt."

/datum/erp_action/other/chastity/scissor_against_belt
	abstract = FALSE
	name = "Scissor against their belt"
	required_init_organ = SEX_ORGAN_VAGINA
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("chastity_action", "target_chastity", "target_vagina_chastity")
	active_arousal_coeff = 1.8
	passive_arousal_coeff = 1.5
	passive_pain_coeff = 1
	message_start = "{actor} presses {actor_their} pussy against {partner}'s belt."
	message_tick = "{actor} {force} and {speed} scissors against {partner}'s chastity belt."
	message_finish = "{actor} lifts away from {partner}'s belt."

/datum/erp_action/other/chastity/sound_cage
	abstract = FALSE
	name = "Sound their caged urethra"
	required_init_organ = SEX_ORGAN_HANDS
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "target_chastity", "target_penis_chastity", "target_not_slit")
	passive_arousal_coeff = 0.5
	passive_pain_coeff = 8.5
	message_start = "{actor} guides a thin probe through {partner}'s cage."
	message_tick = "{actor} {force} and {speed} sounds {partner}'s caged urethra."
	message_finish = "{actor} carefully withdraws the probe from {partner}'s cage."

/datum/erp_action/other/chastity/tailprod_anal
	abstract = FALSE
	name = "Tailprod their anal shield"
	required_init_organ = SEX_ORGAN_TAIL
	required_target_organ = SEX_ORGAN_ANUS
	action_tags = list("chastity_action", "target_chastity", "target_anal_shield")
	passive_arousal_coeff = 1.1
	passive_pain_coeff = 3
	message_start = "{actor} slips {actor_their} tail beneath {partner}'s rear shield."
	message_tick = "{actor} {force} and {speed} works {actor_their} tail beneath {partner}'s anal shield."
	message_finish = "{actor} withdraws {actor_their} tail from {partner}'s shield."

/datum/erp_action/other/chastity/tailprod_cage
	abstract = FALSE
	name = "Prod their cage with your tail"
	required_init_organ = SEX_ORGAN_TAIL
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("chastity_action", "target_chastity", "target_penis_chastity")
	passive_arousal_coeff = 1.3
	passive_pain_coeff = 2
	message_start = "{actor} coils {actor_their} tail around {partner}'s cage."
	message_tick = "{actor} {force} and {speed} strokes the gaps in {partner}'s cage with {actor_their} tail."
	message_finish = "{actor} uncoils {actor_their} tail from {partner}'s cage."
