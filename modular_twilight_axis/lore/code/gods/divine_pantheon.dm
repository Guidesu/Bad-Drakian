/datum/faith
	var/translated_name

/datum/patron
	var/translated_name
	var/list/rusgodnames = list()

/datum/faith/divine
	name = "Divine Pantheon"
	translated_name = "Pantheon of Ten"
	desc = "The most prevalent religion of Grimoria, centered around <b>DesyZZP0001ZZ deities who inherited the world from <b>ethefather</b>, who died at the hands of <b>archivraga</b>. \n\
		The hordes of the Archenemy, may her name remain forgotten, are drawing ever closer; the pantheon<b>of the Despised</b> threatens to destroy our world; and even the Architect of the Universe can no longer help us. Only sincere, absolute faith in the Pantheon can save us from<b>the End of Times</b>."
	worshippers = "Most of the inhabitants of the Grand Duchy of Azuria and many other states of Psydonia."

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
	desc = "Ten, united under the shadow of Divine Order. The teaching of the Indivisible Pantheon is key for the Valorian Holy See and places understanding the domains of each of the Ten as inseparable elements of the cycle of life, as conceived by the Architect of the Universe, at the forefront."
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
	desc = "Radiant Goddess of the Sun, His loving daughter and the one who has taken upon herself the heavy burden of watching over Grimoria in the absence of the Father and fighting the forces that try to plunge the world into darkness and chaos."
	worshippers = "Priests of the Grenzelhoft confession, nobles, fanatics, officers, peasants, and farmers."
	confess_lines = list(
		"ASTRATA - MY LIGHT!",
		"ASTRATA BRINGS ORDER!",
		"I SERVE TO THE GLORY OF THE SUN!",
	)

/datum/patron/divine/noc
	name = "Noc"
	translated_name = "Nok"
	rusgodnames = list(
		"Nok",
		"Moon Maiden", "Moon Maiden's", "Moon Maiden to", "Moon Maiden",
		"Moon Maiden with", "Moon Maiden to",
		"Knowing", "Knowing", "Knowing", "Knowing", "Knowing", "Knowing"
	)

	domain = "Moon, knowledge, twilight, arcana, control, dreams."
	desc = "Goddess of knowledge, night, Moon, and secrets. The first ruler of the Arcana. Nok is the twin sister of the firstborn Astrata. Upon seeing the Moon for the first time, she named it her possession, and every time she raises it to the skies above Grimoria to illuminate the dark night for those who follow her."
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
		"NOK IS THE NIGHT!",
		"NOK SEES EVERYTHING!",
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
	desc = "The youngest son of Poseidon, the one to whom a loving Father allotted green thickets, mighty beasts, and groves as his possession. Over time, he went mad from the cruelty of this world and his influence weakened, and nevertheless… the further from civilization, in forests dark with thickets, in humid jungles and mountains… you will understand how great his influence is."
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
	desc = "The wrathful sea god, raging sea element that sends storms to the seas and winds to the land. Son of Poseidon, who failed to inherit his father's throne, and yet people fear and respect his unrestrained element."
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
	desc = "A mortal who, by his unwavering will, determination, honest word, and courage, rightly earned a place in the Pantheon. A hero of the divine war and one who, in a time of need, stood to protect mortals."
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
	translated_name = "Nekra"
	rusgodnames = list(
		"Nekra", "Necra", "Necra", "Nekru", "Nekroy", "Necra",
		"Lady of the Veil", "Ladies of the Veil", "To the Lady of the Veil", "Lady of the Veil (Accusative)",
		"By the Lady of the Veil", "To the Lady of the Veil",
		"Faceless", "Faceless (Dative)", "Faceless (Dative)", "Faceless (Accusative)",
		"Faceless (Dative)", "Faceless (Dative)"
	)
	domain = "Death, life, cycle, fate."
	desc = "Mistress of the underworld, she-who-knows-everything that was and what is to come, the middle daughter of Psideon, who always remained in the shadows, tirelessly bearing the burden placed on her by her father."
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
	desc = "The many-faced god of cunning and mischief, the only one of the Ten who gained divinity solely through his own tricks, is the subject of many legends and rumors, and just as many of them are true, just as many are false."
	worshippers = "Jesters, actors, minstrels, con artists, scoundrels, thieves, lucky ones."
	confess_lines = list(
		"I SERVE THE DIVINE PANTHEON!",
		"ASTRATA - MY LIGHT!",
		"NOK IS THE NIGHT!",
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
		"BAOTA - MY JOY!",
		"JUDGE THE HERETICS - PSAIDON WILL ENDURE!",
	)

/datum/patron/divine/pestra
	name = "Pestra"
	translated_name = "Motley"
	rusgodnames = list(
		"Motley", "Pestri", "Pestre", "Pestru", "Pestraya", "Pestre",
		"Maiden-Martyr", "Maidens-Martyrs", "Maiden-Martyr", "Maiden-Martyr",
		"Maiden-Martyr", "Maiden-Martyr",
		"Merciful Sister", "Merciful Sister's", "Merciful Sister's", "Merciful Sister",
		"Merciful Sister", "Merciful Sister's"
	)

	domain = "Diseases, suffering, healing, mercy, overcoming, purification, peace."
	desc = "Patroness of diseases, medicine, and those in need, whose merciful hand seeks to rid the world of the spawn of darkness, infection, and torment."
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
	desc = "Fiery God-Smith, the first of the ascended mortals, patron of the working, the one who carries craft and creation alongside the forging of his own soul. 'Labor is already a reward.' Malum is known both for his indifference and strictness toward followers; their creations please him far more."
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
	desc = "The youngest of the gods, the one who brought an end to the strife between the gods and between mortals, uniting them under the sign of love."
	worshippers = "Painters, sculptors, writers, diplomats, orators, spouses and lovers."
	confess_lines = list(
		"EORA UNITES US!",
		"HER BEAUTY EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN WHEN YOU ENCROACH ON ME!",
	)
