/datum/erp_action/other/mouth/breast_feed
	abstract = FALSE
	name = "Lick breasts"
	required_target_organ = SEX_ORGAN_BREASTS
	require_same_tile = FALSE
	active_arousal_coeff  = 0.3
	passive_arousal_coeff = 0.8
	inject_timing = INJECT_CONTINUOUS
	inject_source = INJECT_FROM_PASSIVE
	inject_target_mode = INJECT_ORGAN

	message_start  = "{actor} touches {partner}'s breasts with {actor_their} lips and licks them with {actor_their} tongue."
	message_tick   = "{actor} {force} and {speed} licks {partner}'s nipples."
	message_finish = "{actor} removes {actor_their} lips from {partner}'s chest."

	message_climax_active  = "{partner}'s chest in {actor}'s hands is pulsating."
	message_climax_passive = "{partner} feels {partner_their} chest pulsating in {actor}'s hands."
