/datum/erp_action/other/hands/milking_breasts
	name = "Milking the breast"
	abstract = FALSE
	required_target_organ = SEX_ORGAN_BREASTS
	active_arousal_coeff  = 0.4
	passive_arousal_coeff = 0.9
	inject_timing = INJECT_CONTINUOUS
	inject_source = INJECT_FROM_PASSIVE
	inject_target_mode = INJECT_CONTAINER
	message_start  = "{actor} puts {actor_their} hands on {partner}'s breast."
	message_tick   = "{actor} {force} and {speed} move {actor_their} hands over {partner}'s chest."
	message_finish = "{actor} removes {actor_their} hands from {partner}'s chest."
	message_climax_passive = "{partner} feels the breasts releasing milk."
