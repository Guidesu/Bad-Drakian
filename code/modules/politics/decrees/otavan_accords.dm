/datum/decree/otavan_accords
	id = DECREE_OTAVAN_ACCORDS
	name = "Otavan Treaties"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "The Inquisition is exempt from taxes."
	flavor_text = {"These Treaties of Otavan, concluded in the name of the Ten Indivisibles and under the auspices of the Almighty All-Father, testify that the Holy Otavan Inquisition, the faithful servants of Psydon and the envoys of Otavika, are endowed with the right and duty to protect this land from heresy. In fulfillment of this mission, the Inquisition undertakes to persecute the servants of the Archenemy and false gods, not to raise a hand against subjects of Azuria who are not tainted by heresy, to judge only commoners and never to persecute either citizens or nobles, except in cases of official sanction of the Crown.

In return, being recognized by the clergy of the Otavan Church of the All-Father, the Inquisition is exempt from taxes and levies regarding its members and instruments of their service; and the Crown shall not hinder their holy duty, except in the case of lawful claims presented before the Church of the Ten.

Certified by the Seal of the Crown, in the presence of Psaidon and his Ten."}
	revoke_text = "The ruler of these lands violated the Otavan agreements. The Inquisition is deprived of the protection provided for by the treaty - and Otava will not leave such an insult unanswered."
	restore_text = "The ruler of these lands renewed the Otavan agreements. The Holy Otavan Inquisition resumes its mission to cleanse the lands of heretics without any interference from the Crown."

/datum/decree/otavan_accords/roll_initial_year()
	return 1492 // Canonical year

/datum/decree/otavan_accords/apply_exemption(mob/living/payer, tax_category)
	if(!active)
		return FALSE
	if(payer.job in GLOB.inquisition_positions)
		return TRUE
	return FALSE
