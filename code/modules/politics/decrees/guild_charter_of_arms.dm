/datum/decree/guild_charter_of_arms
	id = DECREE_GUILD_CHARTER_OF_ARMS
	name = "Statute of the Mercenary Guild"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "The cap on the capitation tax for mercenaries is limited to 15 mammon; The Mercenary Guild contributes a daily tax towards the Citizens' Vow."
	flavor_text = {"These Mercenary Guild Statutes, negotiated under the banner of Ravox between the Crown of Azuria and the Mercenary Guild of the Western Kingdoms, indicate that the Crown recognizes the Guild as a registered foreign organization, self-governing in its affairs and answerable solely to its captains. Mercenaries who serve under the flag of the Guild will not bear any burden, except for the smallest possible taxes.

The Crown does not require an oath of loyalty from the Guild and is not obliged to provide it with any services in return. The Crown will not interfere in contracts concluded by the Guild and will protect the right of its members to bear arms, as well as to initiate battles and participate in them at their discretion, provided that this does not disturb the peace in the Duchy and is not related to piracy, robbery, or other actions directly threatening the interests of the Crown.

In recognition of this status, the Guild's treasury, funded by the contributions of its members, will daily pay a levy as part of the Citizens' Oath, as a gesture of goodwill and a contribution to the common welfare of the Duchy from the bearers of arms and agents of Ravox, ensuring the administration of justice therein. And if a criminal is found bearing the symbols of the Guild, the Guild bears no responsibility for this, and the Crown's justice concerning this person is carried out unhindered.

Certified by the seal of the Crown and the seal of the Guild of the Western Kingdoms."}
	revoke_text = "The ruler of these lands has terminated the Statute of the Mercenary Guild. Mercenaries of the Guild of the Western Kingdoms are again obliged to pay taxes and taxes in full, and the Guild, in turn, stops payments to the treasury."
	restore_text = "The ruler of these lands renewed the Statute of the Mercenaries Guild. The Guild's special tax status is restored and it rejoins the Citizens' Pledge."

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
