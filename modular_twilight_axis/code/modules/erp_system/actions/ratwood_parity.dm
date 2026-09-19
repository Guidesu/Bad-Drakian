/*
 * Ratwood SexCon interactions which did not have an equivalent in the local
 * action catalog.  These use the local controller, consent, organ reservation,
 * fluid, and knot systems instead of introducing a second runtime.
 */

/datum/erp_action/other/mouth/armpit_nuzzle
	abstract = FALSE
	name = "Nuzzle armpit"
	required_target_organ = SEX_ORGAN_BODY
	require_same_tile = FALSE
	active_arousal_coeff = 0.7
	passive_arousal_coeff = 0.7
	message_start = "{actor} nestles against {partner}'s armpit."
	message_tick = "{actor} {force} and {speed} nuzzles and kisses {partner}'s armpit."
	message_finish = "{actor} draws away from {partner}'s armpit."

/datum/erp_action/other/mouth/crotch_nuzzle
	abstract = FALSE
	name = "Nuzzle crotch"
	required_target_organ = SEX_ORGAN_BODY
	require_same_tile = FALSE
	active_arousal_coeff = 0.8
	passive_arousal_coeff = 1.1
	message_start = "{actor} presses close to {partner}'s crotch."
	message_tick = "{actor} {force} and {speed} nuzzles {partner}'s crotch."
	message_finish = "{actor} draws away from {partner}'s crotch."

/datum/erp_action/other/mouth/lick_ears
	abstract = FALSE
	name = "Lick ears"
	required_target_organ = SEX_ORGAN_BODY
	require_same_tile = FALSE
	active_arousal_coeff = 0.7
	passive_arousal_coeff = 0.9
	message_start = "{actor} leans toward {partner}'s ear."
	message_tick = "{actor} {force} and {speed} licks and teases {partner}'s ear."
	message_finish = "{actor} pulls away from {partner}'s ear."

/datum/erp_action/other/mouth/suck_testicles
	abstract = FALSE
	name = "Suck testicles"
	required_target_organ = SEX_ORGAN_PENIS
	require_same_tile = FALSE
	action_tags = list("testicles")
	active_arousal_coeff = 0.8
	passive_arousal_coeff = 1.25
	message_start = "{actor} lowers {actor_their} mouth to {partner}'s balls."
	message_tick = "{actor} {force} and {speed} sucks and laps at {partner}'s balls."
	message_finish = "{actor} releases {partner}'s balls."

/datum/erp_action/other/mouth/tongue_bath
	abstract = FALSE
	name = "Give tongue bath"
	required_target_organ = SEX_ORGAN_BODY
	require_same_tile = FALSE
	active_arousal_coeff = 0.8
	passive_arousal_coeff = 0.8
	message_start = "{actor} presses {actor_their} tongue to {partner}'s body."
	message_tick = "{actor} {force} and {speed} bathes {partner}'s body with {actor_their} tongue."
	message_finish = "{actor} finishes licking {partner}'s body."

/datum/erp_action/other/hands/crossbowjob
	abstract = FALSE
	name = "Use crossbow on penis"
	required_target_organ = SEX_ORGAN_PENIS
	required_item_tags = list("crossbow")
	require_same_tile = FALSE
	active_arousal_coeff = 0.4
	passive_arousal_coeff = 1.1
	passive_pain_coeff = 1.2
	message_start = "{actor} carefully positions a crossbow around {partner}'s penis."
	message_tick = "{actor} {force} and {speed} works the crossbow against {partner}'s penis."
	message_finish = "{actor} removes the crossbow from {partner}'s penis."

/datum/erp_action/other/penis/double_vaginal
	abstract = FALSE
	name = "Double vaginal penetration"
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("double_penis")
	init_slot_cost = 2
	active_arousal_coeff = 1.35
	passive_arousal_coeff = 1.5
	passive_pain_coeff = 1.35
	message_start = "{actor} presses both cocks into {partner}'s vagina."
	message_tick = "{actor} {force} and {speed} fucks {partner}'s vagina with both cocks."
	message_finish = "{actor} pulls both cocks out of {partner}'s vagina."
	message_climax_active = "{actor} cums deep inside {partner}'s vagina."
	message_climax_passive = "{partner} cums around {actor}'s cocks."

/datum/erp_action/other/penis/double_anal
	abstract = FALSE
	name = "Double anal penetration"
	required_target_organ = SEX_ORGAN_ANUS
	action_tags = list("double_penis")
	init_slot_cost = 2
	active_arousal_coeff = 1.35
	passive_arousal_coeff = 1.35
	passive_pain_coeff = 1.6
	message_start = "{actor} presses both cocks into {partner}'s ass."
	message_tick = "{actor} {force} and {speed} fucks {partner}'s ass with both cocks."
	message_finish = "{actor} pulls both cocks out of {partner}'s ass."
	message_climax_active = "{actor} cums deep inside {partner}'s ass."
	message_climax_passive = "{partner} cums around {actor}'s cocks."

/datum/erp_action/other/penis/double_oral
	abstract = FALSE
	name = "Double throat penetration"
	required_target_organ = SEX_ORGAN_MOUTH
	action_tags = list("double_penis", "inject_inside_only")
	init_slot_cost = 2
	active_arousal_coeff = 1.35
	passive_arousal_coeff = 0.4
	passive_pain_coeff = 1.8
	message_start = "{actor} presses both cocks into {partner}'s mouth."
	message_tick = "{actor} {force} and {speed} fucks {partner}'s throat with both cocks."
	message_finish = "{actor} pulls both cocks from {partner}'s mouth."
	message_climax_active = "{actor} cums down {partner}'s throat."

/datum/erp_action/other/penis/slit
	abstract = FALSE
	name = "Penetrate slit"
	required_target_organ = SEX_ORGAN_PENIS
	action_tags = list("target_slit")
	active_arousal_coeff = 1.1
	passive_arousal_coeff = 1.2
	passive_pain_coeff = 1.1
	message_start = "{actor} presses {actor_their} penis into {partner}'s slit."
	message_tick = "{actor} {force} and {speed} fucks {partner}'s slit."
	message_finish = "{actor} pulls {actor_their} penis from {partner}'s slit."
	message_climax_active = "{actor} cums inside {partner}'s slit."
	message_climax_passive = "{partner} cums around {actor}'s penis."

/datum/erp_action/other/penis/knot_grinding_vaginal
	abstract = FALSE
	name = "Grind knot in vagina"
	required_target_organ = SEX_ORGAN_VAGINA
	action_tags = list("active_knot")
	require_same_tile = FALSE
	allow_sex_on_move = TRUE
	active_arousal_coeff = 1.2
	passive_arousal_coeff = 1.35
	message_tick = "{actor} {force} and {speed} grinds {actor_their} knot inside {partner}'s vagina."

/datum/erp_action/other/penis/knot_grinding_anal
	abstract = FALSE
	name = "Grind knot in anus"
	required_target_organ = SEX_ORGAN_ANUS
	action_tags = list("active_knot")
	require_same_tile = FALSE
	allow_sex_on_move = TRUE
	active_arousal_coeff = 1.2
	passive_arousal_coeff = 1.2
	passive_pain_coeff = 1.2
	message_tick = "{actor} {force} and {speed} grinds {actor_their} knot inside {partner}'s ass."

/datum/erp_action/other/penis/knot_grinding_oral
	abstract = FALSE
	name = "Grind knot in mouth"
	required_target_organ = SEX_ORGAN_MOUTH
	action_tags = list("active_knot", "inject_inside_only")
	require_same_tile = FALSE
	allow_sex_on_move = TRUE
	active_arousal_coeff = 1.2
	passive_arousal_coeff = 0.3
	passive_pain_coeff = 1.4
	message_tick = "{actor} {force} and {speed} grinds {actor_their} knot in {partner}'s mouth."

/datum/erp_action/self/hands/toy_handling
	abstract = FALSE
	name = "Jerk toy off"
	required_target_organ = SEX_ORGAN_BODY
	required_item_tags = list("dildo")
	active_arousal_coeff = 0.35
	passive_arousal_coeff = 0
	message_start = "{actor} takes hold of {actor_their} toy."
	message_tick = "{actor} {force} and {speed} strokes {actor_their} toy."
	message_finish = "{actor} stops stroking {actor_their} toy."

/datum/erp_action/self/hands/vagina_container
	abstract = FALSE
	name = "Masturbate vagina into container"
	required_target_organ = SEX_ORGAN_VAGINA
	inject_timing = INJECT_ON_FINISH
	inject_source = INJECT_FROM_PASSIVE
	inject_target_mode = INJECT_CONTAINER
	active_arousal_coeff = 1.1
	passive_arousal_coeff = 1.1
	message_start = "{actor} positions a container beneath {actor_their} vagina."
	message_tick = "{actor} {force} and {speed} pleasures {actor_their} vagina over the container."
	message_finish = "{actor} draws {actor_their} hand away from the container."
