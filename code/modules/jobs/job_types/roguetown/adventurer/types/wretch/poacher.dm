/datum/advclass/wretch/poacher
	name = "Poacher"
	tutorial = "You have rejected society and its laws, choosing life in the wilderness instead. Simple thieving highwayman or freedom fighter, you take from those who have and give to the have-nots. Fancy, how the latter includes yourself!"
	allowed_sexes = list(MALE, FEMALE)

	outfit = /datum/outfit/job/roguetown/wretch/poacher
	cmode_music = 'sound/music/combat_poacher.ogg'
	class_select_category = CLASS_CAT_RANGER
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_LONGSTRIDER, TRAIT_DODGEEXPERT, TRAIT_WOODSMAN, TRAIT_OUTDOORSMAN, TRAIT_SURVIVAL_EXPERT, TRAIT_EXPERT_HUNTER) // TA EDIT TRAIT_AZURENATIVE —> TRAIT_LONGSTRIDER
	// No straight upgrade to perception / speed to not stack one stat too high, but still stronger than MAA Skirm out of town.
	subclass_stats = list(
		STATKEY_PER = 3,
		STATKEY_SPD = 2,
		STATKEY_WIL = 2,
		STATKEY_CON = 1
	)
	subclass_skills = list(
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/bows = SKILL_LEVEL_MASTER,
		/datum/skill/combat/crossbows = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/slings = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/stealing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/traps = SKILL_LEVEL_EXPERT,
		//these people live in the forest so let's give them some peasant skills
		/datum/skill/craft/crafting = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/hunting = SKILL_LEVEL_APPRENTICE,
	)
	subclass_stashed_items = list(
		"Sewing Kit" =	/obj/item/repair_kit,
		"Stashed Funds" = /obj/item/roguecoin/silver/pile/wretchpile,
	)

/datum/outfit/job/roguetown/wretch/poacher/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/roguehood/darkgreen
	mask = /obj/item/clothing/mask/rogue/wildguard
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/darkgreen
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
	beltl = /obj/item/quiver/arrows
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	backpack_contents = list(
		/obj/item/bait = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/rope/chain = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	//Small health vial
		)
	if(H.mind)
		var/weapons = list("Dagger","Axe", "Cudgel", "My Bow Is Enough")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		var/fashion = list("Cunning Archer", "Ruthless Hunter", "Unrelenting Beastslayer")
		var/fashion_choice = input(H, "Choose your appearance. This choice is cosmetic.", "BE FASHIONABLE") as anything in fashion
		switch(fashion_choice)
			if("Cunning Archer")
				head = /obj/item/clothing/head/roguetown/archercap
				cloak = /obj/item/clothing/cloak/raincloak/green
			if("Ruthless Hunter")
				head = /obj/item/clothing/head/roguetown/duelhat
				cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
			if("Unrelenting Beastslayer")
				head = /obj/item/clothing/head/roguetown/roguehood/darkgreen
				cloak = /obj/item/clothing/cloak/raincloak/furcloak/darkgreen
		switch(weapon_choice)
			if("Dagger")
				H.adjust_skillrank_up_to(/datum/skill/combat/knives, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/scabbard/sheath
				r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
			if("Axe")
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			if ("Cudgel")
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/mace/cudgel
			if ("My Bow Is Enough")
				H.adjust_skillrank_up_to(/datum/skill/combat/bows, SKILL_LEVEL_LEGENDARY, TRUE)
				head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(weapon_choice != "My Bow Is Enough")
			var/ranged_weapons = list("Recurve Bow", "Crossbow", "Sling")
			var/ranged_choice = input(H, "Choose your ranged weapon.", "TAKE UP ARMS") as anything in ranged_weapons
			switch(ranged_choice)
				if("Recurve Bow")
					H.adjust_skillrank_up_to(/datum/skill/combat/bows, SKILL_LEVEL_LEGENDARY, TRUE)
					beltl = /obj/item/quiver/arrows
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
				if("Crossbow")
					H.adjust_skillrank_up_to(/datum/skill/combat/crossbows, SKILL_LEVEL_LEGENDARY, TRUE)
					beltl = /obj/item/quiver/bolt/standard
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				if("Sling")
					H.adjust_skillrank_up_to(/datum/skill/combat/slings, SKILL_LEVEL_LEGENDARY, TRUE)
					beltl = /obj/item/quiver/sling/iron
					l_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/sling
	bountychoice_poacher(H)				//TA - EDIT
