/datum/decree/guild_charter_of_arms
	id = DECREE_GUILD_CHARTER_OF_ARMS
	name = "The Guild Charter of Arms"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "Mercenaries get a capped poll tax at 15m; Guild remits a daily tribute to the Burgher Pledge."
	flavor_text = {"These Mercenary Guild Statutes, negotiated beneath Ravox's banner between the Crown of %REALM% and the Mercenary Guild of the Western Kingdoms, recognize the Guild as a lawful foreign organization. It shall govern its own affairs and answer to its captains, while mercenaries serving beneath its banner shall pay only the lowest lawful taxes.

The Crown shall demand no oath of loyalty from the Guild and owes it no service in return. It shall not interfere with lawful Guild contracts and shall protect its members' right to bear arms and fight by mutual agreement, provided they neither disturb the Crown's peace nor engage in piracy, robbery, or any act directly threatening %REALM%.

In recognition of this status, the Guild's treasury shall pay a daily levy toward the Citizens' Oath as a gesture of goodwill and a contribution to the realm's common defense. The Guild bears no collective responsibility for a criminal merely wearing its colors, and the Crown may pursue justice against that individual without obstruction.

Certified by the seal of the Crown and the seal of the Guild of the Western Kingdoms."}
	revoke_text = "The %RULER% has suspended the Guild Charter of Arms. The mercenaries of %REALM% now bear the Crown's common levy in full, and the Guild's tribute to the Pledge ceases until the compact is renewed."
	restore_text = "The %RULER% has affirmed the Guild Charter of Arms. The Guild's recognition is restored, and its tribute to the Pledge resumes."

/datum/decree/guild_charter_of_arms/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(30, 80)

/// Returns TRUE if the payer is a chartered mercenary under this charter.
/datum/decree/guild_charter_of_arms/proc/is_protected(mob/living/payer)
	if(!active || !payer)
		return FALSE
	if(HAS_TRAIT(payer, TRAIT_OUTLAW))
		return FALSE
	return payer.job == "Mercenary"

/datum/decree/guild_charter_of_arms/apply_poll_tax_cap(mob/living/payer, poll_category, current_rate)
	if(poll_category != POLL_TAX_CAT_MERCENARY)
		return current_rate
	if(!is_protected(payer))
		return current_rate
	return min(current_rate, GUILD_CHARTER_OF_ARMS_POLL_CAP)
