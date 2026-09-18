/datum/job/roguetown/watchman //This exists PURELY so the convert verb has something TO convert to
	title = "Watchman"
	flag = WATCHMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_sexes = list(MALE, FEMALE)
	forbidden_races = list(RACES_DESPISED) // same as town guard
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "You are the Crown's club in the dark, patrolling the realm's streets day and night in search of knaves and troublemakers. Obey the Sergeant, the Marshal, and the Crown; your life may depend upon it. Call upon the men-at-arms whenever you need support." // Theoretically nobody will ever see this, but it should still read well.
	display_order = JDO_WATCHMAN
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/watchman
	advclass_cat_rolls = list(CTAG_WATCH = 20)

	give_bank_account = 16
	min_pq = 1 //Introductory guard role, but still requires knowledge of escalation.
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_ManAtArms.ogg'

/datum/outfit/job/roguetown/watchman
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/watchman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/tabard/stabard/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "watchman tabard ([index])"

/datum/outfit/job/roguetown/watchman
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/tabard/stabard/guard
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	shoes = /obj/item/clothing/shoes/roguetown/boots
	saiga_shoes = /obj/item/clothing/shoes/roguetown/horseshoes
	belt = /obj/item/storage/belt/rogue/leather/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers		// Would use separate leather bracers for an archer's dodge, but bracers have no armor class.
	backr = /obj/item/storage/backpack/rogue/satchel/black
