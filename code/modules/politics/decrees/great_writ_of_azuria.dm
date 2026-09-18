/datum/decree/great_writ
	id = DECREE_GREAT_WRIT
	name = "The Great Writ"
	category = DECREE_CATEGORY_ANCIENT
	mechanical_text = "Nobles pay no taxes nor fines."
	flavor_text = {"This Great Writ of %REALM%, proclaimed beneath Astrata's light with Ravox as witness, declares that the nobles of this realm, together with resident representatives of foreign noble houses, shall owe no tax or duty upon their persons or possessions.

In return, the nobles of %REALM% shall perform military service: defending the realm with their own strength and that of their retainers, answering the Crown's call to war whenever it is sounded, and remaining loyal to the throne as blood and oath demand.

Certified with the seal of the Crown, by the grace of Astrata and Ravox."}
	revoke_text = "The %RULER% has set aside the Great Writ. The nobility of %REALM% shall contribute to the Crown in both blood and gold; no lineage is too blessed to pay."
	restore_text = "The %RULER% has renewed the Great Writ. The nobles of %REALM% are freed from the levy once more, so that they may serve the realm in arms rather than coin."

/datum/decree/great_writ/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(100, 200)

/datum/decree/great_writ/apply_exemption(mob/living/payer, tax_category)
	if(!active)
		return FALSE
	if(HAS_TRAIT(payer, TRAIT_NOBLE) && tax_category != TAX_CATEGORY_ESTATE_LEVY) //TA EDIT
		return TRUE
	return FALSE
