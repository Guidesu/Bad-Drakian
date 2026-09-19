/datum/erp_action/self/hands/milking_breasts
	abstract = FALSE

	name = "Breast milking"
	required_target_organ = SEX_ORGAN_BREASTS

	inject_timing      = INJECT_CONTINUOUS
	inject_source      = INJECT_FROM_PASSIVE
	inject_target_mode = INJECT_CONTAINER

	message_start = "{actor} takes {actor_their} breasts in {actor_their} palms and begins to slowly squeeze the nipples."
	message_tick = "{actor} {force} and {speed} squeeze out {actor_their} chest, feeling it fill."
	message_finish = "{actor} stops squeezing {actor_their} chest, allowing {actor_their} nipples to relax."
	message_climax_active =	"{actor} shudders, feeling the milk gushing out of {actor_their} chest profusely."
