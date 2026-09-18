/datum/decree/great_writ
	id = DECREE_GREAT_WRIT
	name = "The Great Writ of Azuria"
	category = DECREE_CATEGORY_ANCIENT
	mechanical_text = "Nobles pay no taxes nor fines."
	flavor_text = {"This Great Decree of Azuria, promulgated under the Light of Astrata and under the witness of Ravox, declares that the nobles of this land, as well as the representatives of the noble families of foreign kingdoms residing therein, being descendants of families blessed by the grace of Astrata, will not be subject to any taxes or duties either on themselves or on their possessions.

In return, the nobles of Azuria undertake to perform military service — to defend the Duchy with their own forces and those of their vassals, to respond to the Crown's call to war at any hour when it is sounded, and to maintain loyalty to the throne, as demanded by blood and oath.

Certified with the seal of the Crown, by the grace of Astrata and Ravox."}
	revoke_text = "The %RULER% has set aside the Great Writ. The nobility of Azuria shall contribute to the Crown, in both blood and gold - let no lineage be too blessed to pay."
	restore_text = "The %RULER% has renewed the Great Writ. The blue blood of Azuria is freed again from the levy, that the nobility may serve the Realm in arms, not in coin."

/datum/decree/great_writ/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(100, 200)

/datum/decree/great_writ/apply_exemption(mob/living/payer, tax_category)
	if(!active)
		return FALSE
	if(HAS_TRAIT(payer, TRAIT_NOBLE) && tax_category != TAX_CATEGORY_ESTATE_LEVY) //TA EDIT
		return TRUE
	return FALSE
