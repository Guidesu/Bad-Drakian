/datum/erp_action/other/penis/masturbation
	abstract = FALSE

	name = "Masturbate on partner"
	required_target_organ = SEX_ORGAN_BODY
	require_same_tile = FALSE
	action_tags = list("inject_outside_only")
	message_start = "{actor} grabs {actor_their} dick while looking at {partner}."
	message_tick = "{actor} {force} and {speed} moves {actor_their} hand along {actor_their} penis, pointing it at {partner}."
	message_finish =  "{actor} removes {actor_their} hands from {actor_their} penis."
	message_climax_active = "{actor} cums on {partner}."
	
