/datum/erp_action/self/hands/milking_breasts
	abstract = FALSE

	name = "Breast milking"
	required_target_organ = SEX_ORGAN_BREASTS

	inject_timing      = INJECT_CONTINUOUS
	inject_source      = INJECT_FROM_PASSIVE
	inject_target_mode = INJECT_CONTAINER

	message_start = "{actor} takes his breasts in his palms and begins to slowly squeeze the nipples."
	message_tick = "{actor} {force} and {speed} squeeze out his chest, feeling it fill."
	message_finish = "{actor} stops squeezing his chest, allowing his nipples to relax."
	message_climax_active =	"{actor} shudders, feeling the milk gushing out of her chest profusely."
