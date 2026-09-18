/datum/decree/great_writ
	id = DECREE_GREAT_WRIT
	name = "Great Decree of Azuria"
	category = DECREE_CATEGORY_ANCIENT
	mechanical_text = "Nobles are not subject to taxes and penalties."
	flavor_text = {"This Great Decree of Azuria, promulgated under the Light of Astrata and under the witness of Ravox, declares that the nobles of this land, as well as the representatives of the noble families of foreign kingdoms residing therein, being descendants of families blessed by the grace of Astrata, will not be subject to any taxes or duties either on themselves or on their possessions.

In return, the nobles of Azuria undertake to perform military service — to defend the Duchy with their own forces and those of their vassals, to respond to the Crown's call to war at any hour when it is sounded, and to maintain loyalty to the throne, as demanded by blood and oath.

Certified with the seal of the Crown, by the grace of Astrata and Ravox."}
	revoke_text = "The ruler of these lands has canceled the Great Decree. The nobles of Asuria must serve the Crown with both blood and gold - let no line consider itself too blessed to pay."
	restore_text = "The ruler of these lands renewed the Great Decree. Asuria's blue blood is once again exempt from taxation so that nobles can serve the Kingdom with weapons rather than coins."

/datum/decree/great_writ/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(100, 200)

/datum/decree/great_writ/apply_exemption(mob/living/payer, tax_category)
	if(!active)
		return FALSE
	if(HAS_TRAIT(payer, TRAIT_NOBLE) && tax_category != TAX_CATEGORY_ESTATE_LEVY) //TA EDIT
		return TRUE
	return FALSE
