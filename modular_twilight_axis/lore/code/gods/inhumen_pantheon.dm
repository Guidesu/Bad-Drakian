//Graggarite shrine
/datum/crafting_recipe/roguetown/structure/zizo_shrine/graggar
	name = "Shrine of Blood"
	always_availible = FALSE	//Has unique assign for certain roles.

/obj/structure/fluff/psycross/matthios
	name = "cross of scales"
	desc = "An unholy stone cross bearing the likeness of scales, perfectly balanced in their equality."

/obj/structure/fluff/psycross/matthios/decorated
	name = "ornate cross"
	desc = "Golden scales dangle from rags and balance the scales. A monument to equality."

/datum/crafting_recipe/roguetown/structure/matthios_cross_stone
	name = "stone scales cross"

/datum/crafting_recipe/roguetown/structure/matthios_cross_meat
	name = "ornate scales cross"

/datum/faith/inhumen
	name = "Ascendents"
	translated_name = "Ascended"
	desc = "<b> The Holy Ecclesiarchy</b>, also known among the followers of the Ten as <b> Pantheon of the Despicable</b> is a collection of three religious movements centered around the ideologies of those called <b> The Ascended</b>. Once mortal, the Ascended Ones have mastered divine powers by stealing the shards of the fallen <b>eotfather</b> in the confusion <b>Voyns in Heaven</b>.\n\
		The ideologies of the Despicable are diverse and contradictory, and although in mortal life they were comrades, the followers of the Three can act both together and against each other — they are united only by hatred for the world order maintained by the Ten."
	worshippers = "Rejected by the Church of Ten, radicals, nonconformists."
	godhead = /datum/patron/inhumen/baotha

/datum/patron/inhumen
	profane_words = list(
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

/datum/patron/inhumen/zizo
	name = "Zizo"
	translated_name = "Zizo"
	rusgodnames = list(
		"Zizo", "Zizo", "Zizo", "Zizo", "Zizo", "Zizo",
		"Bearer of Salvation", "Bearer of Salvation", "Bearer to Salvation", "Bearing Salvation",
		"Bearer with Salvation", "Bearer in Salvation",
		"Lady of Darkness", "Ladies of Darkness", "Lady of Darkness", "Lady of Darkness",
		"Lady with Darkness", "Lady of Darkness",
		"Maiden of the Night", "Maidens of the Night", "Maiden of the Night", "Maiden of the Night",
		"Maiden with the Night", "Maiden of the Night",
		"Lady of Progress", "Ladies of Progress", "Lady of Progress", "Lady of Progress",
		"Lady with Progress", "Lady of Progress",
		"Spider Lady", "Spider Lady", "Spider Lady", "Spider Lady",
		"Spider Lady", "Spider Lady",
		"Weaving", "Weaver", "Weaver", "Weaver",
		"Weaver", "Weaver",
		"Weaver woman", "Weaver women", "To the weaver woman", "The weaver woman",
		"By the weaver woman", "To the weaver woman"
)
	domain = "Immortality, progress, blood, darkness, forbidden knowledge, ambitions."
	desc = "Goddess of unliving, vengeance, metamorphosis, and darkness. Slayer of Psyidon, Archwing of the Pantheon of Ten, despised by all except her followers, Zizo herself does not see mortals as the object of her hatred. This is wonderfully demonstrated by her main commandment, which is often sung in the prayers of her cultists: 'The last enemy shall be destroyed — death.'"
	associated_faith = /datum/faith/cult_of_salvation
	worshippers = "Drow loyalists, necromancers, sorcerers, researchers and practitioners of the dark aspects of magic, some clans of elder vampires, undead."
	confess_lines = list(
		"PRAISE ZIZO!",
		"LONG LIVE ZIZO!",
		"ZIZO WILL SAVE US FROM SUFFERING!",
	)

/datum/patron/inhumen/zizo/post_equip(mob/living/pious)
	. = ..()
	if(ishuman(pious))
		var/mob/living/carbon/human/human = pious
		if(human.mind)
			human.mind.special_items["Lexicon of Her Truth"] = /obj/item/book/rogue/bibble/zizo
			human.mind.special_items["Ritual's guide book"] = /obj/item/recipe_book/zizo

/datum/patron/inhumen/graggar
	name = "Graggar"
	translated_name = "Graggar"
	rusgodnames = list(
		"Graggar", "Graggar", "Graggar", "Graggar", "Graggar", "Graggar",
		"Blood God", "Blood God", "Blood God", "Blood God",
		"Blood God", "Blood God",
		"Beast", "Beast", "Beast", "Beast", "Beast", "Beast",
		"Black Sun", "of the Black Sun", "to the Black Sun", "Black Sun",
		"with the Black Sun", "in the Black Sun",
		"Cursed Star", "of the Cursed Star", "to the Cursed Star", "the Cursed Star",
		"with the Cursed Star", "to the Cursed Star",
		"Black Wheel", "Black Wheel", "To the Black Wheel", "Black Wheel",
		"With the Black Wheel", "In the Black Wheel"
	)

	domain = "Power, strength, superiority, conquest."
	desc = "The god of strength and power that comes with it. While other deities condemn their flock to a miserable existence in a world where power comes through their blessing and by right of birth, Graggar proclaims that anyone strong enough to take what they desire can rule. \"The weak will inherit only dirt,\" he warns, reminding of the fate of those who do not strive to become stronger."
	undead_hater = TRUE
	worshippers = "Tribal peoples, madmen, maniacs, cruel people."
	miracles = list(/datum/action/cooldown/spell/touch/orison					        = CLERIC_ORI,
					/datum/action/cooldown/spell/graggar/rush							= CLERIC_T0,
					/obj/effect/proc_holder/spell/self/heavy_stomp 		       			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_call 		       		= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/graggar_regenerate 		       	= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/heal 				        	= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle					= CLERIC_T1,
					/datum/action/cooldown/spell/graggar/hamstring						= CLERIC_T1,
					/datum/action/cooldown/spell/projectile/graggar_net					= CLERIC_T2,
					/datum/action/cooldown/spell/graggar/graggar_battlecry		 		= CLERIC_T2,
					/datum/action/cooldown/spell/graggar/exsanguinate					= CLERIC_T3,
					/datum/action/cooldown/spell/graggar/avatar							= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/resurrect/graggar				= CLERIC_T4,
	)
	confess_lines = list(
		"GRAGGAR - THE BEAST I WORSHIP!",
		"THROUGH SUPERIORITY - TO DIVINITY!",
		"THE BLACK SUN DEMANDS BLOOD!",
	)

/datum/patron/inhumen/matthios
	name = "Matthios"
	translated_name = "Matthios"
	rusgodnames = list(
		"Matthios", "Mattiosa", "To Mattiosa", "Mattiosa", "With Mattiosa", "In Mattiosa",
		"Free", "Free", "To the free", "Free",
		"With the free", "In the free",
		"Shackles-Breaker", "Of the Shackles-Breaker", "To the Shackles-Breaker",
		"Of the Shackles-Breaker", "With the Shackles-Breaker", "In the Shackles-Breaker",
		"Father of Freedom", "Of the Father of Freedom", "To the Father of Freedom", "Of the Father of Freedom",
		"With the Father of Freedom", "In the Father of Freedom",
		"Father", "Of the Father", "To the Father", "Of the Father", "With the Father", "In the Father",
		"Daddy", "Of Daddy", "To Daddy", "Daddy", "With Daddy", "To Daddy",
		"Mr. Nothing", "Mr. Nothing", "To Mr. Nothing",
		"Mr. Nothing", "With Mr. Nothing", "About Mr. Nothing",
		"Leader", "Leader", "To Leader", "Leader", "With Leader", "About Leader",
		"Torch", "Torch", "To Torch", "Torch", "With Torch", "About Torch",
		"Light Bearer", "Light Bearer", "To Light Bearer", "Light Bearer",
		"With Light Bearer", "About Light Bearer",
		"Shackles Breaker", "Shackles Breaker", "To Shackles Breaker",
		"Shackles Breaker", "With Shackles Breaker", "About Shackles Breaker"
	)

	domain = "Anarchy, freedom, revolution, equality, and brotherhood."
	desc = "God of absolute freedom, anarchy, and rebellion. \"Through discord to prosperity,\" promises his chief commandment, and his followers will do anything to make it a reality, destroying the world order as we know it."
	undead_hater = TRUE
	worshippers = "Robbers, mercenaries, revolutionaries, freedom-loving people."
	miracles = list(/datum/action/cooldown/spell/touch/orison									        = CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/twilight_shacklebreaker							= CLERIC_T0,
					/datum/action/cooldown/spell/matthios/freemans_tools								= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/twilight_weightofchains						= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/twilight_transact								= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/twilight_equalize								= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/heal 								        	= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle									= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/twilight_churnwealthy							= CLERIC_T2,
					/obj/effect/proc_holder/spell/self/twilight_amongus									= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/projectile/twilight_crownfortheking			= CLERIC_T2,
					/datum/action/cooldown/spell/matthios/barter										= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/twilight_commieflag							= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/resurrect/twilight_matthios					= CLERIC_T3,
					/obj/effect/proc_holder/spell/self/wildshape_twilight_wingsoffreedom				= CLERIC_T4,
	)
	confess_lines = list(
		"ALL TYRANTS WILL DIE IN SOLITUDE!",
		"THE PATH TO PROSPERITY LIES THROUGH DISCORD!",
		"WE LEVEL CHURCHES AND PRISONS WITH THE GROUND!",
	)

/datum/objective/hoard_mammons/update_explanation_text()
	explanation_text = "Accumulate at least [target_mammons] mammons in your possession to be used for Freedom's unstoppable march."

/datum/patron/inhumen/baotha
	name = "Baotha"
	translated_name = "Baota"
	rusgodnames = list(
		"Baota", "Baoty", "Baote", "Baotu", "Baotoy", "Baote",
		"Enjoying", "Enjoying", "Enjoying", "Enjoying",
		"Enjoying", "Enjoying",
		"Giver of Pleasure", "Giving Pleasure", "Giving Pleasure (dative/ to)",
		"Giving Pleasure (accusative)", "Giving Pleasure (instrumental)", "Giving Pleasure (prepositional)",
		"Suffering", "Suffering (genitive/dative)", "Suffering (genitive/dative)", "Suffering (accusative)",
		"Suffering (genitive/dative)", "Suffering (genitive/dative)",
		"Comforter", "Comforter (genitive)", "Comforter (dative)", "Comforter",
		"Comforter", "Comforter (dative)"
	)

	domain = "Hedonism, worldly pleasures, individualism."
	desc = "Baota is the goddess of hedonism, worldly pleasures, and passions. \"Live, love, laugh!\" she said, watching the hustle around her and the efforts of those trying to move the world somewhere."
	worshippers = "Spoiled rich people, marginals, escapists."
	undead_hater = TRUE
	miracles = list(/datum/action/cooldown/spell/touch/orison					        = CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/TAbaothavice					= CLERIC_T0,
					//obj/effect/proc_holder/spell/self/TAbless_drink					= CLERIC_T0,
					/obj/effect/proc_holder/spell/targeted/touch/TAloversruin			= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/TAbaothablessings				= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/TAinsufflation					= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/heal 						  	= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/griefflower					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/projectile/TAblowingdust		= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/TAlasthigh					= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/TAjoyride						= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/TApainkiller					= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/lux_steal                     = CLERIC_T3,
					/obj/effect/proc_holder/spell/self/mirage                           = CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/resurrect/baotha				= CLERIC_T4,
	)
	confess_lines = list(
		"BAOTA DEMANDS PLEASURE!",
		"LIVE, LAUGH, LOVE!",
		"BAOTA - MY JOY!",
	)

/////////////////////////////////
// Does God Hear Your Prayer ? //
/////////////////////////////////

/datum/patron/proc/can_pray_inhumen(mob/living/follower)
	SHOULD_CALL_PARENT(TRUE)
	// Allows death-bed prayers
	if(follower.has_status_effect(STATUS_EFFECT_UNCONSCIOUS))
		if(follower.has_status_effect(STATUS_EFFECT_SLEEPING))
			to_chat(follower, span_danger("I mustn't be sleeping to pray!"))
			return FALSE	//Stops praying just by sleeping.
	. = TRUE

// Graggar - When bleeding, near blood on ground, zchurch, bad-cross, or ritual chalk
/datum/patron/inhumen/graggar/can_pray_inhumen(mob/living/follower)
	. = ..()
	// Allows prayer in the Zzzzzzzurch(!)
	if(istype(get_area(follower), /area/rogue/indoors/shelter/mountains))
		return TRUE
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == TRUE)
			to_chat(follower, span_danger("That acursed cross interupts my prayers!"))
			return FALSE
	for(var/obj/structure/fluff/psycross/graggar/cross in view(4, get_turf(follower)))
		if(cross.divine == TRUE)
			to_chat(follower, span_danger("This altar has been corrupted by the Ten! It blocks my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer if actively bleeding.
	if(follower.bleed_rate > 0)
		return TRUE
	// Allows prayer near blood.
	for(var/obj/effect/decal/cleanable/blood in view(3, get_turf(follower)))
		return TRUE
	// Allows praying atop ritual chalk of the god.
	for(var/obj/structure/ritualcircle/graggar in view(1, get_turf(follower)))
		return TRUE
	to_chat(follower, span_danger("For Graggar to hear my prayers I must either be in the church of the abandoned, near an altar dedicated to Him, near fresh blood or draw blood of my own!"))
	return FALSE

// Matthios - Basically any way you'd like really, so long as there are comrades with you
/datum/patron/inhumen/matthios/can_pray_inhumen(mob/living/follower)
	. = ..()
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == TRUE)
			to_chat(follower, span_danger("That acursed cross interupts my prayers!"))
			return FALSE
	for(var/obj/structure/fluff/psycross/matthios/cross in view(4, get_turf(follower)))
		if(cross.divine == TRUE)
			to_chat(follower, span_danger("This altar has been corrupted by the Ten! It blocks my prayers!"))
			return FALSE
		return TRUE
	for(var/mob/living/carbon/human/comrade in view(4, get_turf(follower)))
		if(istype(comrade.patron, /datum/patron/inhumen/matthios) && comrade != follower)
			return TRUE
	for(var/obj/structure/ritualcircle/matthios in view(1, get_turf(follower)))
		return TRUE
	to_chat(follower, span_danger("Matthios will hear any prayer I offer, so long as I stand near one of my comrades or one of His altars!"))
	return FALSE

// Baotha
/datum/patron/inhumen/baotha/can_pray_inhumen(mob/living/follower)
	. = ..()
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == TRUE)
			to_chat(follower, span_danger("That acursed cross interupts my prayers!"))
			return FALSE
	for(var/obj/structure/fluff/psycross/baotha/cross in view(4, get_turf(follower)))
		if(cross.divine == TRUE)
			to_chat(follower, span_danger("This altar has been corrupted by the Ten! It blocks my prayers!"))
			return FALSE
		return TRUE
	// Allows prayers in the bath house - whore.
	if(istype(get_area(follower), /area/rogue/indoors/town/bath))
		return TRUE
	// Allows prayers if actively high on drugs.
	if(follower.has_status_effect(/datum/status_effect/buff/ozium) || follower.has_status_effect(/datum/status_effect/buff/moondust) || follower.has_status_effect(/datum/status_effect/buff/moondust_purest) || follower.has_status_effect(/datum/status_effect/buff/druqks) || follower.has_status_effect(/datum/status_effect/buff/starsugar))
		return TRUE
	// Allows prayers if the user is drunk.
	if(follower.has_status_effect(/datum/status_effect/buff/drunk))
		return TRUE
	// Allows prayers if the user is generally happy.
	if(follower.has_status_effect(/datum/status_effect/mood/vgood))
		return TRUE
	// Allows prayers during sex
	var/list/arousal_data = list()
	SEND_SIGNAL(follower, COMSIG_SEX_GET_AROUSAL, arousal_data)
	if(arousal_data["arousal"] >= 10)
		return TRUE
	// Allows praying atop ritual chalk of the god.
	for(var/obj/structure/ritualcircle/baotha in view(1, get_turf(follower)))
		return TRUE
	to_chat(follower, span_danger("For Baotha to hear my prayers I must either be in the church of the abandoned, within the town's bathhouse, or actively enjoying myself, be that through drugs, sex, or whatever it is that gets my blood pumpin'!"))
	return FALSE
