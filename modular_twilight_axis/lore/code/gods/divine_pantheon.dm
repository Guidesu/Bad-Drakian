/datum/faith
	var/translated_name

/datum/patron
	var/translated_name
	var/list/rusgodnames = list()

/datum/faith/divine
	name = "Divine Pantheon"
	translated_name = "Pantheon of Ten"
	desc = "The dominant faith of Grimoria venerates the Ten, the gods who inherited stewardship of the world after the fall of the All-Father. Its churches teach that the Ten preserve creation against Zizo, the Ascended, and the ruin left by the War in Heaven. Only faith, righteous conduct, and Divine Order stand between mortalkind and the end of all things."
	worshippers = "Most inhabitants of the western realms and communities of the faithful throughout Psydonia."

/datum/patron/divine
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

/datum/patron/divine/undivided
	translated_name = "Indivisible Pantheon"
	rusgodnames = list("Pantheon", "of the Pantheon", "to the Pantheon", "Pantheon", "with the Pantheon",
		"in the Pantheon", "Ten", "Of Ten", "Ten", "Tens", "by ten", "Of Ten"
	)
	domain = "All is subject to the Ten."
	desc = "The Ten are worshipped as a single, indivisible expression of Divine Order. This doctrine, championed by the Valorian Holy See, teaches that each god's domain forms an inseparable part of the cycle of creation first ordained by Psydon."
	worshippers = "Clergy of the Valorian confession, Knights of the Oath, pragmatists of the Church of the Ten."
	confess_lines = list(
		"THE SACRED DECAGRAM WILL PROTECT MY SOUL!",
		"I SERVE THE DIVINE PANTHEON!",
		"TEN ETERNAL, FOREVER AND EVER!",
	)

/datum/patron/divine/astrata
	name = "Astrata"
	translated_name = "Astrata"
	rusgodnames = list(
		"Astrata", "Astrates", "Astrate", "To Astrate", "With Astrate", "Astrate",
		"Sun-faced", "To the Sun-faced", "Sun-faced",
		"Radiant", "Radiant", "Radiant", "Radiant", "Radiant",
		"Firstborn Daughter", "Firstborn Daughter", "Firstborn Daughter", "Firstborn Daughter",
		"Firstborn Daughter", "Firstborn Daughter",
		"Tyrant", "Tyrant", "Sun Tyrant", "Sun-Tyrant",
	)
	miracles = list(/datum/action/cooldown/spell/touch/orison								= CLERIC_ORI,
					/datum/action/cooldown/spell/TAignition					             	= CLERIC_T0,
					/obj/effect/proc_holder/spell/self/TAastrata_gaze						= CLERIC_T0,
					/obj/effect/proc_holder/spell/targeted/touch/summonrogueweapon/TAastratagrasp = CLERIC_T0,
					/obj/effect/proc_holder/spell/self/TAastrata_fireresist					= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/heal								= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle						= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/projectile/TAsacred_flame			= CLERIC_T1,
					///obj/effect/proc_holder/spell/self/TAastrata_sword						= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/TAastrataspark					= CLERIC_T2,
					/datum/action/cooldown/spell/miracle/fortify/astrata					= CLERIC_T2,
					/datum/action/cooldown/spell/astrata/miracle_pyre   					= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/TArevive							= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/immolation						= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/TAsunstrike						= CLERIC_T4,
	)

	domain = "Sun, order, justice, faith, tactics and strategy, fertility."
	desc = "Astrata is the radiant goddess of the sun and Psydon's firstborn daughter. In the All-Father's absence, she bears the burden of defending Grimoria against darkness and chaos, demanding order, discipline, and faith from those who live beneath her light."
	worshippers = "Priests of the Grenzelhoft confession, nobles, fanatics, officers, peasants, and farmers."
	confess_lines = list(
		"ASTRATA - MY LIGHT!",
		"ASTRATA BRINGS ORDER!",
		"I SERVE TO THE GLORY OF THE SUN!",
	)

/datum/patron/divine/noc
	name = "Noc"
	translated_name = "Noc"
	rusgodnames = list(
		"Nok",
		"Moon Maiden", "Moon Maiden's", "Moon Maiden to", "Moon Maiden",
		"Moon Maiden with", "Moon Maiden to",
		"Knowing", "Knowing", "Knowing", "Knowing", "Knowing", "Knowing"
	)

	domain = "Moon, knowledge, twilight, arcana, control, dreams."
	desc = "Noc is the goddess of knowledge, night, the moon, and guarded secrets, and the first master of the arcane arts. Astrata's twin and rival, she raises the moon over Grimoria to guide those who seek wisdom beyond the certainty of daylight."
	worshippers = "Priests of the Dvergale Patriarchy, mages, scholars, scribes, ambitious individuals, researchers."
/*	miracles = list(/datum/action/cooldown/spell/touch/orison				= CLERIC_ORI,
					/datum/action/cooldown/spell/noc/sight					= CLERIC_T0,
					/datum/action/cooldown/spell/darkvision/miracle			= CLERIC_T0,
					/datum/action/cooldown/spell/miracle/heal				= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle		= CLERIC_T1,
					/datum/action/cooldown/spell/noc/enlightenment			= CLERIC_T1,
					/datum/action/cooldown/spell/noc/inspiration			= CLERIC_T1,
					/datum/action/cooldown/spell/noc/invisibility			= CLERIC_T2,
					/datum/action/cooldown/spell/noc/blindness				= CLERIC_T2,
					/datum/action/cooldown/spell/noc/moonscorch				= CLERIC_T3,
					/datum/action/cooldown/spell/noc/spellpack				= CLERIC_T3,
					/datum/action/cooldown/spell/noc/grimoire				= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/resurrect/noc		= CLERIC_T4,
	)*/
	confess_lines = list(
		"NOC IS THE NIGHT!",
		"NOC SEES EVERYTHING!",
		"I SEEK THE SECRETS OF THE MOON!",
	)

/datum/patron/divine/dendor
	name = "Dendor"
	translated_name = "Dendor"
	rusgodnames = list(
		"Dendor", "Dendora", "To Dendora", "Dendor", "By Dendora", "About Dendora",
		"First Beast", "Of the First Beast", "To the First Beast", "Of the First Beast",
		"By the First Beast", "In the First Beast",
		"Loving Father", "To the Loving Father", "To the Loving Father", "To the Loving Father",
		"By the Loving Father", "About the Loving Father",
		"Keeper of the Grove", "Keeper of the Grove", "To the Keeper of the Grove", "Guardian of the Grove",
		"Guardian of the Grove", "Guardian of the Grove"
	)

	domain = "Nature, animals, hunting, fertility, madness, transformation."
	desc = "Dendor, youngest son of Psydon, was entrusted with the forests, beasts, and untamed places of the world. The cruelty of creation drove him to madness, yet his power has never vanished. Beyond roads and walls, in ancient forests, jungles, and mountains, his will remains absolute."
	worshippers = "Druids, shamans, beasts, madmen, hunters, herders, gatherers."
	confess_lines = list(
		"DENDOR PROVIDES FOOD!",
		"THE FATHER OF TREES BRINGS BOUNTY!",
		"I ANSWER THE CALL OF WILD NATURE!",
	)

/datum/patron/divine/abyssor
	name = "Abyssor"
	translated_name = "Abyssor"
	rusgodnames = list(
		"Abyssor", "Abyssora", "To Abyssora", "Abyssor", "By Abyssora", "Abissore",
		"Father of the Oceans", "Father of the Oceans'", "To the Father of the Oceans", "Father of the Oceans'",
		"By the Father of the Oceans", "About the Father of the Oceans",
		"Ruler of the Element", "The Ruler of the Element's", "To the Ruler of the Element", "The Ruler of the Element's",
		"By the Ruler of the Element", "About the Ruler of the Element",
		"Sea Lord", "Sea Lord's", "To the Sea Lord", "To the Sea Lord",
		"By the Sea Lord", "About the Sea Lord",
		"The Drowned God", "Of the Drowned God", "To the Drowned God", "Of the Drowned God",
		"By the Drowned God", "About the Drowned God"
	)

	domain = "Sea, wind, element, trade, sailing, natural magic, nightmares, mysteries."
	desc = "Abyssor is the wrathful god of the sea, master of storms, winds, and the mysteries beneath the waves. Though Psydon's son did not inherit the All-Father's throne, sailors and coastal peoples honor him because no mortal command can restrain the ocean."
	worshippers = "Sailors, pirates, fishermen, merchants."
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE FURY OF THE OCEAN IS THE WILL OF ABYSSOR!",
		"I AM DRAWN BY THE TIDE!",
	)

/datum/patron/divine/ravox
	name = "Ravox"
	translated_name = "Ravox"
	rusgodnames = list(
		"Ravox", "Ravoksa", "To Ravoksa", "Ravox", "By Ravoksa", "About Ravoksa",
		"The Strongest", "Of the Strongest", "To the Strongest", "Of the Strongest",
		"By the Strongest", "About the Strongest",
		"The Most Worthy", "To the Most Worthy", "To the Most Worthy", "To the Most Worthy",
		"To the Most Worthy", "To the Most Worthy"
	)

	domain = "War, courage, justice, strength, pride."
	desc = "Ravox was a mortal whose courage, steadfast word, and unbreakable will earned him a place among the Ten. A hero of the War in Heaven, he stood in defense of mortalkind when the gods themselves faltered."
	worshippers = "Warriors, soldiers, mercenaries, wandering knights, judges."
	miracles = list(/datum/action/cooldown/spell/touch/orison								= CLERIC_ORI,
					/obj/effect/proc_holder/spell/targeted/touch/summonrogueweapon/TAravoxgrasp = CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/TAtug_of_war					= CLERIC_T0,
					/obj/effect/proc_holder/spell/self/TAprovocation						= CLERIC_T0,
					/datum/action/cooldown/spell/miracle/heal								= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle						= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/TAdivine_strike						= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/TAbalance_immune					= CLERIC_T2,
					/obj/effect/proc_holder/spell/self/TAcall_to_arms						= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/TAchallenge						= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/TApersistence					= CLERIC_T3,
					/datum/action/cooldown/spell/ravox/TAraise_warrior_spirits			= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/resurrect/ravox					= CLERIC_T4,
	)
	confess_lines = list(
		"RAVOX IS JUSTICE!",
		"THROUGH CONFLICT - TO BLESSINGS!",
		"THROUGH PERSEVERANCE AND COURAGE - WE WILL ACHIEVE GLORY!",
	)

/datum/patron/divine/necra
	name = "Necra"
	translated_name = "Necra"
	rusgodnames = list(
		"Nekra", "Necra", "Necra", "Nekru", "Nekroy", "Necra",
		"Lady of the Veil", "Ladies of the Veil", "To the Lady of the Veil", "Lady of the Veil (Accusative)",
		"By the Lady of the Veil", "To the Lady of the Veil",
		"Faceless", "Faceless (Dative)", "Faceless (Dative)", "Faceless (Accusative)",
		"Faceless (Dative)", "Faceless (Dative)"
	)
	domain = "Death, life, cycle, fate."
	desc = "Necra is the veiled mistress of the underworld, keeper of what has passed and what must yet come. Psydon's middle daughter has always worked beyond the light, tirelessly guiding the dead and preserving the boundary between life and the afterworld."
	worshippers = "Mourners, gravediggers, the dead, philosophers."
	miracles = list(/datum/action/cooldown/spell/touch/orison						= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/necras_sight				= CLERIC_T0,
					/datum/action/cooldown/spell/touch/shroud_of_tranquility = CLERIC_T0,
					/datum/action/cooldown/spell/miracle/heal 						= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle				= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/avert						= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/locate_dead 					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/fog_ward					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/raise_spirits_vengeance	= CLERIC_T2,
					/datum/action/cooldown/spell/miracle/necra_consecrate			= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/bless_cross				= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/deaths_door				= CLERIC_T4
	)
	confess_lines = list(
		"ALL SOULS GO TO NEKRE!",
		"LADY IN A VEIL - OUR LAST REST!",
		"I AM NOT AFRAID OF DEATH, MY LADY AWAITS ME!",
	)

/datum/patron/divine/xylix
	name = "Xylix"
	translated_name = "Xylix"
	rusgodnames = list(
		"Xylix", "Ksayliksa", "Ksayliksu", "Xylix", "Ksayliksom", "Ksaylikse",
		"Master of Masks", "Masters of Masks", "Master of Masks", "Masters of Masks",
		"With the Master of Masks", "Master of Masks",
		"Many-faced", "Many-faced's", "To the Many-faced", "Many-faced's",
		"By/with the Many-faced", "In the Many-faced",
		"Jester", "of the Jester", "to the Jester", "Jester", "with the Jester", "in the Jester"
	)

	domain = "Cunning, movement, laughter, mischief, eloquence, luck."
	desc = "Xylix is the many-faced god of cunning, luck, eloquence, and mischief. He is said to be the only member of the Ten who won divinity through wit alone. Countless stories recount his exploits; appropriately, no one knows which are true."
	worshippers = "Jesters, actors, minstrels, con artists, scoundrels, thieves, lucky ones."
	confess_lines = list(
		"I SERVE THE DIVINE PANTHEON!",
		"ASTRATA - MY LIGHT!",
		"NOC IS THE NIGHT!",
		"DENDOR PROVIDES FOOD!",
		"ABYSSOR COMMANDS THE WAVES!",
		"RAVOX IS JUSTICE!",
		"ALL SOULS GO TO NEKRE!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!",
		"PESTRA CALMS ALL AILMENTS!",
		"MALUM - MY MUSE!",
		"EORA UNITES US!",
		"LONG LIVE ZIZO!",
		"GRAGGAR - THE BEAST I WORSHIP!",
		"MATTIOS - MY LORD!",
		"BAOTHA - MY JOY!",
		"JUDGE THE HERETICS - PSYDON WILL ENDURE!",
	)

/datum/patron/divine/pestra
	name = "Pestra"
	translated_name = "Pestra"
	rusgodnames = list(
		"Motley", "Pestri", "Pestre", "Pestru", "Pestraya", "Pestre",
		"Maiden-Martyr", "Maidens-Martyrs", "Maiden-Martyr", "Maiden-Martyr",
		"Maiden-Martyr", "Maiden-Martyr",
		"Merciful Sister", "Merciful Sister's", "Merciful Sister's", "Merciful Sister",
		"Merciful Sister", "Merciful Sister's"
	)

	domain = "Diseases, suffering, healing, mercy, overcoming, purification, peace."
	desc = "Pestra is the patron of medicine, disease, mercy, and those who suffer. Her faithful study corruption and contagion not to glorify them, but to understand, contain, and overcome the afflictions that torment mortalkind."
	worshippers = "Doctors, surgeons, patients, martyrs, sorcerers, apothecaries."
	confess_lines = list(
		"PESTRA HEALS ALL AILMENTS!",
		"DECAY IS THE CONTINUATION OF LIFE!",
		"MY AILMENT IS MY LEGACY!",
	)

/datum/patron/divine/malum
	name = "Malum"
	translated_name = "Malum"
	rusgodnames = list(
		"Malum", "Maluma", "to Maluma", "Malum", "with Maluma", "Maluma (prepositional case)",
		"Fire God", "of the Fire God", "to the Fire God", "of the Fire God",
		"with the Fire God", "To the Fiery God",
		"God-Smith", "Of the God-Smith", "To the God-Smith", "Of the God-Smith",
		"By the God-Smith", "About the God-Smith"
	)
	domain = "Fire, steel, labor, craft, patience, perseverance."
	desc = "Malum is the fiery God-Smith, first among the mortals raised into the Ten and patron of labor and craft. He teaches that work is its own reward and judges followers by what they create rather than what they promise."
	worshippers = "Smiths, builders, architects, masons, workers."
	miracles = list(/datum/action/cooldown/spell/touch/orison					= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/TArestoration			= CLERIC_T0,
					/obj/effect/proc_holder/spell/self/TArepair					= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/TAmalum_inspiration	= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/heal					= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle			= CLERIC_T1,
					/datum/action/cooldown/spell/arcyne_forge/miracle			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/TAvigorousexchange	= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/TAheatmetal			= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/TAhammerfall			= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/TAcraftercovenant		= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/resurrect/malum		= CLERIC_T4,
	)
	confess_lines = list(
		"MALUM - MY MUSE!",
		"TRUE VALUE IS IN LABOR!",
		"I AM THE INSTRUMENT OF CREATION!",
	)

/datum/patron/divine/eora
	name = "Eora"
	translated_name = "Eora"
	rusgodnames = list(
		"Eora", "Eory", "Eore", "Eoru", "Eoroy", "Eore",
		"Loving Mother", "To the Loving Mother", "To the Loving Mother", "Loving Mother (accusative)",
		"With the Loving Mother", "To the Loving Mother",
		"Blooming", "Blooming (feminine, instrumental/genitive)", "Blooming (feminine, instrumental/genitive)", "Blossoming",
		"Blooming (feminine, instrumental/genitive)", "Blooming (feminine, instrumental/genitive)"
	)

	domain = "Life, family, peace, beauty, compassion."
	desc = "Eora is the youngest of the Ten, goddess of love, beauty, family, and reconciliation. She ended feuds among gods and mortals alike, teaching that compassion can bind together what violence has torn apart."
	worshippers = "Painters, sculptors, writers, diplomats, orators, spouses and lovers."
	confess_lines = list(
		"EORA UNITES US!",
		"HER BEAUTY EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN WHEN YOU ENCROACH ON ME!",
	)
