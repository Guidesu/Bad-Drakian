/datum/erp_action/other/hands/toy_oral
	abstract = FALSE

	name = "Oral sex toy"
	required_target_organ = SEX_ORGAN_MOUTH
	require_same_tile = FALSE
	message_start = "{actor} brings the toy to the lips of {dullahan?separated head :}{partner}."
	message_tick = "{actor} {force} and {speed} moves the toy in the mouth of {dullahan?separated head :}{partner}."
	message_finish =  "{actor} removes the toy from {dullahan?severed head :}{partner}."
	required_item_tags = list("dildo")
