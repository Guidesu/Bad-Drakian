/datum/job/roguetown/sheriff
	title = "Town Sheriff"
	flag = SHERIFF
	department_flag = CITYWATCH
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_CITYWATCH
	forbidden_races = list(RACES_DESPISED)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	display_order = JDO_SHERIFF
	tutorial = "Crime has always been a constant in your life, and you have always chosen the side of justice. \
	You have risen through the ranks of the guards, and now lead them – ensure that they comply with the laws of this land.\
	It has already been12 years since you have been in service to the King, who declared Rockhill his base immediately after the DISAPPEARANCE of Baron Eric Ravencroft.\
	In sleepless nights, the thought constantly comes to you, giving no rest, that the King will settle here not as promised for a short time, but forever...\
	Is this a blessing for Rockhill? Did the Baron really disappear without the King’s intervention?.."
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/sheriff
	advclass_cat_rolls = list(CTAG_SHERIFF = 2)
	give_bank_account = TRUE
	min_pq = 10
	max_pq = null
	round_contrib_points = 3
	same_job_respawn_delay = 30 MINUTES

	cmode_music = 'modular_twilight_axis/sound/music/combat/combat_watchman.ogg'
	job_subclasses = list(
		/datum/advclass/sheriff,
	)

/datum/job/roguetown/sheriff/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_armor, /obj/item/clothing/suit/roguetown/armor/plate/scale/townguard/sheriff))
			var/obj/item/clothing/S = H.wear_armor
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "sheriff's armor ([index])"

/datum/advclass/sheriff
	name = "Town Sheriff"
	tutorial = "Crime has always been a constant in your life, and you have always chosen the side of justice. \
	You have risen through the ranks of the guards, and now lead them – ensure that they comply with the laws of this land.\
	It has already been12 years, you have been serving the King, who declared Rockhill his stronghold, immediately after the Baron’s DISAPPEARANCE.\
	In sleepless nights, the thought constantly comes to you, giving no rest, that the King will settle here not as promised for a short time, but forever...\
	Is this a blessing for Rockhill? Did the Baron really disappear without the King’s intervention?.."

	category_tags = list(CTAG_SHERIFF)
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_GUARDSMAN, TRAIT_STEELHEARTED)
	subclass_stats = list(
		STATKEY_STR = 3,
		STATKEY_PER = 2,
		STATKEY_CON = 2,
		STATKEY_WIL = 2,
		STATKEY_INT = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/twilight_firearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/roguetown/sheriff
	job_bitflag = BITFLAG_CITYWATCH
	head = /obj/item/clothing/head/roguetown/helmet/heavy/citywatch/sheriff
	pants = /obj/item/clothing/under/roguetown/chainlegs
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/townguard/sheriff
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/steel/tasset
	beltl = /obj/item/rogueweapon/scabbard/sword
	beltr = /obj/item/rogueweapon/mace/stunmace
	cloak = /obj/item/clothing/cloak/sheriff
	r_hand = /obj/item/rogueweapon/sword/sabre
	backpack_contents = list(/obj/item/storage/keyring/sheriff = 1, /obj/item/rogueweapon/scabbard/sheath = 1, /obj/item/rogueweapon/huntingknife/idagger/steel = 1)

/datum/outfit/job/roguetown/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_UPPER_MIDDLE_CLASS, H, "Savings.")
		H.mind.AddSpell(new /datum/action/cooldown/spell/order/movemovemove)
		H.mind.AddSpell(new /datum/action/cooldown/spell/order/takeaim)
		H.mind.AddSpell(new /datum/action/cooldown/spell/order/onfeet)
		H.mind.AddSpell(new /datum/action/cooldown/spell/order/hold)
	add_verb(H, list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders))
