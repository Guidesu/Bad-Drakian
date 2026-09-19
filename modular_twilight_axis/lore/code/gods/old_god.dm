/datum/faith/old_god
	name = "Church of the All-Father"
	translated_name = "The Church of the All-Father"
	desc = "The Church of the Ten teaches that Psydon fell during the War in Heaven. The faithful of the All-Father reject that claim. To them, His silence is a trial rather than proof of His death, and the Comet of Zion is a sign that His power still reaches the world. They prepare for the day when the Architect returns and calls His children to account."
	worshippers = "The people of Giza and Otava, Grenzelhoftian churchmen, inquisitors, and Psydonite communities throughout Psydonia."
	godhead = /datum/patron/old_god

/datum/patron/old_god
	name = "Psydon"
	translated_name = "Psydon"
	rusgodnames = list(
		"Psydon", "Psydon", "Psydon", "Psydon", "Psydon", "Psydon",
		"Architect of the Universe", "Architect of the Universe", "To the Architect of the Universe", 
		"Architect of the Universe", "As the Architect of the Universe", "O Architect of the Universe",
		"Heavenly Father", "Of the Heavenly Father", "To the Heavenly Father", "Of the Heavenly Father", 
		"With the Heavenly Father", "In the Heavenly Father",
		"All-Father", "Of the All-Father", "To the All-Father", "Of the All-Father", 
		"With the All-Father", "AllFather"
	)
	profane_words = list(
		"Zizo", "Zizo", "Zizo", "Zizo", "Zizo", "Zizo",
		"Matthias", "Matthios", "Matthias", "Matthios", "Matthias", "Matthias",
		"Graggar", "Graggar", "Graggar", "Graggar", "Graggar", "graggare",
		"baota", "baoty", "baote", "baotu", "baotoy", "baote",
		"fuck", "dick", "dick", "with dick", "dick",
		"penis", "penis", "dick", "dick", "dick",
		"horseradish", "horseradish", "horseradish", "horseradish", "horseradish",
		"fuck", "whores", "slut", "slut", "slut", "slut",
		"pussy", "pussy", "pussy", "pussy", "pussy", "pussy",
		"ass", "ass", "ass", "ass", "ass",
		"bitch", "bitch", "bitch", "bitch", "with the bitch", "bitch",
		"asshole", "asshole", "to the asshole", "asshole", "with the asshole", "to the asshole",
		"fag", "fag", "to the fag", "with the fag", "on the fag",
		"whore", "whores", "whores", "whore", "slut", "slut",
		"dickhead", "dickhead", "to the dickhead", "dickhead", "with the dickhead", "to the dickhead",
		"freak", "freak", "freak", "freak", "with the freak", "freak",
		"jerk", "jerk", "to the jerk", "jerk", "with the jerk", "on the jerk",
		"dick sucker", "of the dick sucker", "to the dick sucker", "of the dick sucker", "with the dick sucker", "about the dick sucker",
		"whore", "whore's", "to the whore", "whore", "with the whore", "to the whore",
		"bitch", "bitches", "to the bitch", "bitch", "with the bitch", "to the bitch",
		"to fuck", "fucking", "to fuck", "to fuck", "with the fucking", "to fuck",
		"foreskin", "foreskins", "to the foreskin", "foreskin", "with the foreskin", "to the foreskin",
		"foreskin guy", "of the foreskin guy", "to the glans", "of the foreskin guy", "by the glans", "in the glans"
	)
	miracles = list()
	traits_tier = list(TRAIT_PSYDONITE = CLERIC_T0, TRAIT_PSYDONITE_2 = CLERIC_T1, TRAIT_PSYDONIC_MEDICINE = CLERIC_T2, TRAIT_PSYDONITE_3 = CLERIC_T2, TRAIT_PSYDONITE_4 = CLERIC_T3)
	domain = "Creation, humanity, sacrifice, endurance, and rightful order."
	desc = "Psydon is the Architect of Being and the wounded All-Father. The heavens have fallen silent since the War in Heaven, yet His faithful insist that silence is not death. He made the world according to His design, suffered for it, and will one day return to judge what mortalkind has made of His creation."
	worshippers = "The people of Giza and Otava, Grenzelhoftian faithful, inquisitors, engineers, soldiers, martyrs, and the desperate."
	associated_faith = /datum/faith/old_god
	confess_lines = list(
		"THERE IS ONLY ONE GOD!",
		"PSYDON LIVES! PSYDON ENDURES!",
		"JUDGE THE HERETICS - PSYDON WILL ENDURE!",
		"EXPOSE THE PAGAN, KILL THE MONSTER!",
		"MY GOD – WITH EVERY BROKEN BONE I SWEAR THAT I AM ALIVE!",
		"EVEN NOW THERE IS STILL HOPE FOR HUMANITY! GLORY TO PSYDON!",
		"BEHOLD ME, PSYDON; THE SACRIFICE HAS TAKEN FORM!"
	)
