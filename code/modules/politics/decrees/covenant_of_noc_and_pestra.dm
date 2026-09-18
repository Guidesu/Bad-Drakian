/datum/decree/noc_pestra_covenant
	id = DECREE_NOC_PESTRA_COVENANT
	name = "Covenant of Nok and Motley"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "Sets the upper limit of the capitation tax for representatives of the University and the Apothecary Chamber, as well as the minimum level of their salaries: court magician - 40 m, archivist - 20 m, arcane magician - 10 m, chief healer - 80 m, apothecary - 40 m."
	/// Jobs covered by the scholarly half of the covenant (Noc's mantle).
	var/static/list/university_jobs = list(
		"Court Magician",
		"Archivist",
		"Magicians Associate",
	)
	/// Jobs covered by the healing half of the covenant (Pestra's mantle).
	var/static/list/apothecary_jobs = list(
		"Apothecary",
		"Head Physician",
	)
	var/static/list/wage_floors = list(
		"Court Magician" = 40,
		"Archivist" = 20,
		"Magicians Associate" = 10,
		"Head Physician" = 80,
		"Apothecary" = 40,
	)
	flavor_text = {"This Covenant, made under the watchful eye of Nok and the merciful hand of Pestra, testifies that the learned minds of the University and the healers of the Apothecary's Chamber will bear no burden except the least possible taxes, and will receive from the treasury of the Crown the fair minimum of what is due them while this Covenant is in force.

In return, the licensed scholarly minds of the University shall commit to preserving the knowledge and wisdom of these scrolls, maintaining them, and teaching them to worthy and enlightened minds, for Nok has granted humans the gift of arcana and wisdom so that we may spread and multiply them. And the certified healers of the Apothecary Chamber, messengers of Pestr, pledge to heal the wounds of every subject of the Crown who comes to their threshold, whether beggar or townsman, and shall never refuse the wounded due to lack of coins, for Pestr is merciful and has taught us medicine so that we may care for one another.

Endorsed with the seal of the Crown, by the grace of Nok and Pestr."}
	revoke_text = "The ruler of these lands terminated the Covenant of Nok and Motley. Representatives of the University and the Apothecary Chamber are now subject to taxes and duties in full. How long will the mercy of Nok and Motley last if their servants offer prayers about the burden of their existence?"
	restore_text = "The ruler of these lands restored the Covenant of Nok and Motley. Representatives of the University and the Apothecary Chamber regained their protected status, so that wisdom and mercy would triumph in the lands under the rule of the Crown."

/datum/decree/noc_pestra_covenant/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(20, 60)

/// Returns TRUE if the payer is a member of one of the two chartered rosters.
/datum/decree/noc_pestra_covenant/proc/is_protected(mob/living/payer)
	if(!active || !payer)
		return FALSE
	if(HAS_TRAIT(payer, TRAIT_OUTLAW))
		return FALSE
	if(payer.job in university_jobs)
		return TRUE
	if(payer.job in apothecary_jobs)
		return TRUE
	return FALSE

/datum/decree/noc_pestra_covenant/apply_poll_tax_cap(mob/living/payer, poll_category, current_rate)
	if(!is_protected(payer))
		return current_rate
	return min(current_rate, NOC_PESTRA_POLL_CAP)

/datum/decree/noc_pestra_covenant/apply_wage_floor(job_title, current_floor)
	var/mandated = wage_floors[job_title] || 0
	return max(current_floor, mandated)

/datum/decree/noc_pestra_covenant/wage_floored_jobs()
	return wage_floors

/datum/decree/noc_pestra_covenant/on_restore()
	. = ..()
	SStreasury.steward_machine?.enforce_wage_floors()
