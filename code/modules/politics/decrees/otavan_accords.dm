/datum/decree/otavan_accords
	id = DECREE_OTAVAN_ACCORDS
	name = "The Otavan Accords"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "Inquisition members pay no taxes."
	flavor_text = {"These Otavan Accords, concluded in the name of the Ten Indivisible beneath the authority of the Almighty All-Father, grant the Holy Otavan Inquisition the right and duty to defend %REALM% from heresy. The Inquisition shall pursue servants of the Archenemy and false gods, but shall not harm subjects untainted by heresy. Without the Crown's formal sanction, its temporal judgments shall extend only to commoners and never to burghers or nobles.

In return for its recognition by the Otavan Church of the All-Father, the Inquisition and the instruments of its service shall be exempt from taxes and levies. The Crown shall not obstruct its holy duty except through a lawful appeal presented before the Church of the Ten.

Certified by the seal of the Crown, in the presence of Psydon and His Ten."}
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
