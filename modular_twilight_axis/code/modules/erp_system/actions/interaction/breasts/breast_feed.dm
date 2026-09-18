/datum/erp_action/other/breasts/breast_feed
	name = "Force feeding"
	abstract = FALSE
	required_target_organ = SEX_ORGAN_MOUTH
	require_grab = TRUE
	inject_timing = INJECT_CONTINUOUS
	inject_source = INJECT_FROM_ACTIVE
	inject_target_mode = INJECT_ORGAN
	message_start  = "{actor} presses {partner}'s face to his chest."
	message_tick   = "{actor} {force} and {speed} move {partner}'s head across his chest."
	message_finish = "{actor} removes {partner}'s head from his chest."
	message_climax_active = "{actor} shudders with intense pleasure."
	message_climax_passive = "{partner}'s mouth is filled with taste and warmth."
