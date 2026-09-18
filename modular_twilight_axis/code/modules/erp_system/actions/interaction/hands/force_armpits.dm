/datum/erp_action/other/hands/force_armpits
	abstract = FALSE
	name = "Press to the armpits"
	required_target_organ = SEX_ORGAN_MOUTH
	require_grab = TRUE
	message_start = "{actor} grabs the {dullahan?separated :}head of {partner}."
	message_tick = "{actor} {force} and {speed} move the face of {dullahan?separated head :}{partner} along their armpits."
	message_finish =  "{actor} removes his hand from {dullahan?separated head :}{partner}."
