/datum/erp_action/self/hands/tail_pet
	abstract = FALSE

	name = "Caress the tail"
	required_target_organ = SEX_ORGAN_TAIL
	message_start = "{actor} runs {actor_their} hand along {actor_their} tail."
	message_tick = "{actor} {force} and {speed} caress {actor_their} tail."
	message_finish =  "{actor} lets go of {actor_their} tail."
