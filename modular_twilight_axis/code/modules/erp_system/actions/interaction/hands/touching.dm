/datum/erp_action/other/hands/touching
	abstract = FALSE
	name = "Caress"
	required_target_organ = SEX_ORGAN_BODY
	action_tags = list("race_body")
	message_start = "{actor} touches {partner} with hands."
	message_tick = "{actor} {force} and {speed} caresses {zone} {partner}."
	message_finish =  "{actor} removes {actor_their} hands from {partner}."
