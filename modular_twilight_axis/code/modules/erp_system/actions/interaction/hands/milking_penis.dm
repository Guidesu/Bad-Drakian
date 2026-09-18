/datum/erp_action/other/hands/milking_penis
	name = "Milking cock"
	abstract = FALSE
	required_target_organ = SEX_ORGAN_PENIS
	active_arousal_coeff  = 0.6
	passive_arousal_coeff = 1.0
	inject_timing = INJECT_ON_FINISH
	inject_source = INJECT_FROM_PASSIVE
	inject_target_mode = INJECT_CONTAINER

	message_start  = "{actor} puts his hands on {partner}'s cock."
	message_tick   = "{actor} {force} and {speed} run their hands over {partner}'s penis."
	message_finish = "{actor} removes his hands from {partner}'s penis."
	message_climax_passive = "{partner} cums in {actor}'s hands."
