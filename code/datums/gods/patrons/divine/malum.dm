/datum/patron/divine/malum
	name = "Malum"
	domain = "God of Fire, Destruction and Rebirth"
	desc = "Malum is the impartial god of craft. He teaches that workmanship has no morality of its own: a healer's instrument and an executioner's blade are both judged by the discipline and skill of their maker."
	worshippers = "Smiths, Miners, Engineers"
	mob_traits = list(TRAIT_FORGEBLESSED)
	miracles = list(/datum/action/cooldown/spell/touch/orison				= CLERIC_ORI,
					/datum/action/cooldown/spell/miracle/ignition/malum		= CLERIC_T0,
					/datum/action/cooldown/spell/malum/reconstruction		= CLERIC_T0,
					/datum/action/cooldown/spell/miracle/heal				= CLERIC_T1,
					/datum/action/cooldown/spell/miracle/bloodmiracle		= CLERIC_T1,
					/datum/action/cooldown/spell/malum/vigorousexchange		= CLERIC_T1,
					/datum/action/cooldown/spell/arcyne_forge/miracle		= CLERIC_T1,
					/datum/action/cooldown/spell/malum/hammerfall			= CLERIC_T2,
					/datum/action/cooldown/spell/mending/malum				= CLERIC_T2,
					/datum/action/cooldown/spell/malum/heatmetal			= CLERIC_T3,
					/datum/action/cooldown/spell/malum_blessing				= CLERIC_T3,
					/datum/action/cooldown/spell/malum/fortress				= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/resurrect/malum	= CLERIC_T4,
	)
	confess_lines = list(
		"MALUM IS MY MUSE!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)
	storyteller = /datum/storyteller/malum

	titles = list(
		"Forgefather",
		"Maker",
		"Mamuke"
		)

// Near a smelter, hearth, cross, within the smithy, or within the church
/datum/patron/divine/malum/can_pray(mob/living/follower)
	. = ..()
	// Allows prayer near psycross
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == FALSE)
			to_chat(follower, span_danger("That defiled cross interrupts my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer in the church
	if(istype(get_area(follower), /area/rogue/indoors/town/church))
		return TRUE
	// Allows prayer in the smith's building.
	if(istype(get_area(follower), /area/rogue/indoors/town/dwarfin))
		return TRUE
	// Allows prayer near hearths.
	for(var/obj/machinery/light/rogue/hearth/H in view(4, get_turf(follower)))
		return TRUE
	// Allows prayer near smelters.
	for(var/obj/machinery/light/rogue/smelter/H in view(4, get_turf(follower)))
		return TRUE
	to_chat(follower, span_danger("For Malum to hear my prayer, I must stand within the church or smithy, near a psycross, smelter, or hearth, and bask in His sacred flame."))
	return FALSE

/datum/patron/divine/malum/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("A tempering heat is discharged out of [target]!")
	*message_self = span_info("I feel the heat of a forge soothing my pains!")

	var/list/firey_stuff = list(/obj/machinery/light/rogue/torchholder, /obj/machinery/light/rogue/campfire, /obj/machinery/light/rogue/hearth, /obj/machinery/light/rogue/candle, /obj/machinery/light/rogue/forge)
	var/bonus = 0

	// extra healing for every source of fire/light near us
	for(var/obj/obj in oview(5, user))
		if(!(obj.type in firey_stuff))
			continue

		bonus = min(bonus + 0.5, 2.5)

	if(!bonus)
		return

	*situational_bonus = bonus
	*conditional_buff = TRUE
