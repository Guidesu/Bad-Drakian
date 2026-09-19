/datum/erp_action/other/penis/rubbing
	abstract = FALSE

	name = "Rubbing a dick"
	required_target_organ = SEX_ORGAN_ANUS
	require_same_tile = FALSE
	action_tags = list("inject_outside_only")
	message_start = "{actor} puts {actor_their} dick against {partner}'s skin."
	message_tick = "{actor} {force} and {speed} rubbing against {zone} {partner}."
	message_finish =  "{actor} removes {actor_their} penis from {partner}'s skin."
	message_climax_active = "{actor} cums on {partner}."
