/datum/decree/otavan_accords
	id = DECREE_OTAVAN_ACCORDS
	name = "The Otavan Accords"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "Inquisition members pay no taxes."
	flavor_text = {"These Treaties of Otavan, concluded in the name of the Ten Indivisibles and under the auspices of the Almighty All-Father, testify that the Holy Otavan Inquisition, the faithful servants of Psydon and the envoys of Otavika, are endowed with the right and duty to protect this land from heresy. In fulfillment of this mission, the Inquisition undertakes to persecute the servants of the Archenemy and false gods, not to raise a hand against subjects of Azuria who are not tainted by heresy, to judge only commoners and never to persecute either citizens or nobles, except in cases of official sanction of the Crown.

In return, being recognized by the clergy of the Otavan Church of the All-Father, the Inquisition is exempt from taxes and levies regarding its members and instruments of their service; and the Crown shall not hinder their holy duty, except in the case of lawful claims presented before the Church of the Ten.

Certified by the Seal of the Crown, in the presence of Psaidon and his Ten."}
	revoke_text = "The %RULER% has broken the Otavan Accords. The Inquisition is stripped of its treaty protections - and Otava shall not take such an insult lightly."
	restore_text = "The %RULER% has affirmed the Otavan Accords. The Holy Otavan Inquisition resumes its duty to purge the land of heretics, free from the Crown's interference."

/datum/decree/otavan_accords/roll_initial_year()
	return 1492 // Canonical year

/datum/decree/otavan_accords/apply_exemption(mob/living/payer, tax_category)
	if(!active)
		return FALSE
	if(payer.job in GLOB.inquisition_positions)
		return TRUE
	return FALSE
