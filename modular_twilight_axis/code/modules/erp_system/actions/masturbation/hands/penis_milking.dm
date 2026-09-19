/datum/erp_action/self/hands/penis_milking
	abstract = FALSE

	name = "Cock milking"
	required_target_organ = SEX_ORGAN_PENIS
	inject_timing      = INJECT_ON_FINISH
	inject_source      = INJECT_FROM_PASSIVE
	inject_target_mode = INJECT_CONTAINER
	message_start = "{actor} takes {actor_their} cock in {actor_their} hand."
	message_tick = "{actor} masturbates {actor_their} penis with {actor_their} hand."
	message_finish =  "{actor} loosens {actor_their} grip and stops."
	message_climax_active = "I feel the seed bursting out."
