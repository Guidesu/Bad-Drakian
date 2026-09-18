/datum/decree/golden_bull
	id = DECREE_GOLDEN_BULL
	name = "The Golden Bull of Kingsfield"
	category = DECREE_CATEGORY_ANCIENT
	mechanical_text = "Burghers and residents are capped at 25% balance-rate on taxes/fines, with daily fine ceiling 50m and a poll-tax cap."
	flavor_text = {"This Golden Bull of Kingsfield, sealed beneath Astrata's Sun with Ravox as witness, records the ancient compact between the Crown of %REALM% and those who make its wealth.

It is attested in the name of %RULER_NAME%, %RULER% of %REALM%, and by the duly assembled Councils of Notables and Burghers, that the Crown shall levy no more than one quarter of a Burgher's meister account, exact no more than fifty mammon in fines each day, and demand no poll tax beyond twenty mammon each day. These limits shall hold in peace, war, and necessity alike. Beyond them, no Burgher shall be taxed or deprived of wealth except by the law of the land.

In return, the citizens of the capital, Kingsfield, and the other settlements of %REALM% shall provide an annual fund for the common defense against pirates, brigands, and other enemies of the peace. Their own assembly shall collect and distribute that sum according to each member's means.

Should the Crown exceed these bounds or otherwise violate this Charter, the Burghers are released from that obligation, so that the realm may know the cost of breaking faith with those who make its wealth.

Certified with the golden seal of the Crown, by the grace of Astrata and Abissor."}
	revoke_text = "The %RULER% has suspended the Golden Bull of Kingsfield. The burghers now face the Crown's full levy, and the outraged merchants shall contribute no more to the common defense of %REALM%."
	restore_text = "The %RULER% has restored the Golden Bull of Kingsfield. The compact stands renewed, and the burghers resume their tribute to the common defense."

/datum/decree/golden_bull/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(40, 100)

/datum/decree/golden_bull/apply_rate_cap(mob/living/payer, tax_category, current_cap)
	if(!is_protected_by_bull(payer))
		return current_cap
	return min(current_cap, GOLDEN_BULL_BURGHER_CAP)

/// Per-stroke mammon ceiling for Bull-protected subjects. Combined with the realm's
/// one-fine-per-day rule this becomes an effective daily cap.
/datum/decree/golden_bull/apply_daily_fine_cap(mob/living/payer, current_remaining)
	if(!is_protected_by_bull(payer))
		return current_remaining
	return min(current_remaining, GOLDEN_BULL_DAILY_FINE_CAP)

/// Cap the Burgher poll-tax daily charge at GOLDEN_BULL_POLL_CAP.
/datum/decree/golden_bull/apply_poll_tax_cap(mob/living/payer, poll_category, current_rate)
	if(poll_category != POLL_TAX_CAT_BURGHER)
		return current_rate
	return min(current_rate, GOLDEN_BULL_POLL_CAP)

/// Returns TRUE if the payer is currently shielded by the Golden Bull.
/datum/decree/golden_bull/proc/is_protected_by_bull(mob/living/payer)
	if(!active)
		return FALSE
	if(HAS_TRAIT(payer, TRAIT_OUTLAW))
		return FALSE
	if(HAS_TRAIT(payer, TRAIT_RESIDENT))
		return TRUE
	if(payer.job in GLOB.wanderer_positions)
		return FALSE
	if(payer.job == "Mercenary")
		return FALSE
	return TRUE
