/datum/job/roguetown/vanguard
	title = "Vanguard"
	flag = VANGUARDS
	department_flag = VANGUARD
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	allowed_sexes = list(MALE, FEMALE)
	forbidden_races = list(RACES_DESPISED)
	job_traits = list(TRAIT_WOODSMAN)
	tutorial = "The Vanguard guards Rockhill's distant borderlands, its villages, and the roads leading toward the city. \
	Most recruits are the sons and daughters of local farmers. Their first loyalty is often not to a sovereign or noble, but to the neighbors and childhood friends who depend upon them.\
	The city may overlook this modest force, yet the Vanguard is always the first to meet whatever emerges from the marsh."
	display_order = JDO_VANGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/vanguard
	advclass_cat_rolls = list(CTAG_VANGUARD = 20)

	give_bank_account = TRUE
	min_pq = 3
	max_pq = null
	round_contrib_points = 2
	same_job_respawn_delay = 30 MINUTES

	cmode_music = 'modular_twilight_axis/sound/music/combat/combat_vanguard.ogg'
	job_subclasses = list(
		/datum/advclass/vanguard/footsman,
		/datum/advclass/vanguard/archer,

	)

/datum/outfit/job/roguetown/vanguard
	job_bitflag = BITFLAG_VANGUARD

/datum/job/roguetown/vanguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/forrestercloak/vanguard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "vanguard's cloak ([index])"

/datum/outfit/job/roguetown/vanguard
	cloak = /obj/item/clothing/cloak/forrestercloak/vanguard
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded/warden/vanguard
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	pants = /obj/item/clothing/under/roguetown/trou/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather/black

// Melee goon
/datum/advclass/vanguard/footsman
	name = "Vanguard Footman"
	tutorial = "You are skilled with a sword and have skills useful in close combat. \
	You will stand in front. And defend."
	outfit = /datum/outfit/job/roguetown/vanguard/footsman

	category_tags = list(CTAG_VANGUARD)
	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_STR = 2,//They give +3 accuracy + 1 SPD bonus, so it’s logical to unscrew their accuracy + speed.
		STATKEY_CON = 1,
		STATKEY_WIL = 2
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/slings = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN
	)

/datum/outfit/job/roguetown/vanguard/footsman
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/vanguard_enigma = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		)
/datum/outfit/job/roguetown/vanguard/footsman/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_blindness(-3)
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_LOWER_CLASS, H, "Savings.")
		var/weapons = list("Warhammer & Shield","Axe & Shield","Sword & Shield","Spear")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Warhammer & Shield")
				beltr = /obj/item/rogueweapon/mace/warhammer
				backl = /obj/item/rogueweapon/shield/wood
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, 4, TRUE) //I hope that the fourth skills will not break the balance to the grave. We must watch.
			if("Axe & Shield")
				beltr = /obj/item/rogueweapon/stoneaxe/woodcut
				backl = /obj/item/rogueweapon/shield/wood
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, 4, TRUE)
			if("Sword & Shield")
				l_hand = /obj/item/rogueweapon/sword/iron
				beltr = /obj/item/rogueweapon/scabbard/sword
				backl = /obj/item/rogueweapon/shield/wood
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
			if("Spear")
				r_hand = /obj/item/rogueweapon/spear
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 4, TRUE)
	H.verbs |= /mob/proc/haltyell

	if(H.mind)

		var/helmets = list(
		"Volf"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/wolf,
		"Ram"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/goat,
		"Bear"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/bear,
		"Rous"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/rat,
		"None"
		)
		var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
		if(helmchoice != "None")
			head = helmets[helmchoice]

/datum/advclass/vanguard/archer
	name = "Vanguard Archer"
	tutorial = "You are good at using a bow and shoot quite accurately. \
	You will stand behind and on the heights to cover the front lines."
	outfit = /datum/outfit/job/roguetown/vanguard/archer

	category_tags = list(CTAG_VANGUARD)
	subclass_stats = list(
		STATKEY_PER = 2,
		STATKEY_SPD = 2,
		STATKEY_WIL = 2
	)
	subclass_skills = list(
		/datum/skill/combat/crossbows = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/bows = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/riding = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/vanguard/archer
	beltr = /obj/item/rogueweapon/sword/iron
	beltl = /obj/item/quiver/arrows
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/vanguard_enigma = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		)
/datum/outfit/job/roguetown/vanguard/archer/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_blindness(-3)
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_LOWER_CLASS, H, "Savings.")
		var/weapons = list("Footman archer","Light archer")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Footman archer")
				ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
				H.change_stat(STATKEY_STR, 1) //Strength to Footman.
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 3, TRUE)
			if("Light archer")
				ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
				H.change_stat(STATKEY_PER, 1) //Arrow accuracy.
				H.adjust_skillrank_up_to(/datum/skill/combat/knives, 3, TRUE)
	H.verbs |= /mob/proc/haltyell

	if(H.mind)

		var/helmets = list(
		"Volf"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/wolf,
		"Ram"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/goat,
		"Bear"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/bear,
		"Rous"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/rat,
		"None"
		)
		var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
		if(helmchoice != "None")
			head = helmets[helmchoice]

/datum/advclass/vanguard/standard_bearer
	name = "Vanguard Standard Bearer"
	tutorial = "You have performed well in numerous battles and have been given the honor of carrying the banner to inspire your comrades."
	outfit = /datum/outfit/job/roguetown/vanguard/standard_bearer

	category_tags = list(CTAG_VANGUARD)
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_STANDARD_BEARER)
	maximum_possible_slots = 1
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 1,
		STATKEY_WIL = 2
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/slings = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN
	)

/datum/outfit/job/roguetown/vanguard/standard_bearer
	beltr = /obj/item/rogueweapon/sword/iron
	backl = /obj/item/rogueweapon/scabbard/gwstrap
	r_hand = /obj/item/rogueweapon/spear/keep_standard //We need to add some buffs to the vanguard's banner for the crowd to emphasize their fighting style "Even a lion is brought down by the crowd."
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/vanguard_enigma = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		)

/datum/outfit/job/roguetown/vanguard/standard_bearer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_LOWER_CLASS, H, "Savings.")
		var/helmets = list(
		"Volf"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/wolf,
		"Ram"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/goat,
		"Bear"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/bear,
		"Rous"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/rat,
		"None"
		)
		var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
		if(helmchoice != "None")
			head = helmets[helmchoice]

// These are really hacky, but it works.
// One proc to moodbuff.
/mob/proc/standard_position_vanguard()
	set name = "PLANT"
	set category = "Standard"
	emote("standard_position", intentional = TRUE)
	stamina_add(rand(15, 35))

/datum/emote/living/standard_position_vanguard
	key = "standard_position_vanguard"
	message = "plants the standard!"
	emote_type = EMOTE_VISIBLE
	show_runechat = TRUE

/datum/emote/living/standard_position_vanguard/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(do_after(user, 8 SECONDS)) // SCORE SOME GOALS!!!
		playsound(user.loc, 'sound/combat/shieldraise.ogg', 100, FALSE, -1)
		if(.)
			for(var/mob/living/carbon/human/L in viewers(7, user))
				if(HAS_TRAIT(L, TRAIT_WOODSMAN))
					to_chat(L, span_monkeyhive("The standard calls out to me!"))
					L.add_stress(/datum/stressevent/keep_standard_lesser)

/obj/item/clothing/head/roguetown/helmet/sallet/warden/wolf/vanguard
	name = "volfskull helm"
	desc = "The large, intimidating skull of an elusive white volf, plated with steel on its inner side and given padding - paired together with a steel maille mask and worn with a linen shroud. Such trophies are associated with life-long game wardens and their descendants."

/obj/item/clothing/head/roguetown/helmet/sallet/warden/goat/vanguard
	name = "ramskull helm"
	desc = "The large, intimidating horned skull of an elusive Azurian great ram, plated with steel on its inner side and given padding - paired together with a steel maille mask and worn with a linen shroud. Such trophies are associated with life-long foresters and their descendants."

/obj/item/clothing/head/roguetown/helmet/sallet/warden/bear/vanguard
	name = "bearskull helm"
	desc = "The large, intimidating skull of a common direbear, plated with steel on its inner side and given padding - paired together with a steel maille mask and worn with a linen shroud. Such trophies are associated with life-long hunters and their descendants."

/obj/item/clothing/head/roguetown/helmet/sallet/warden/rat/vanguard
	name = "rouskull helm"
	desc = "The large, intimidating skull of the rare giant rous, plated with steel on its inner side and given padding - paired together with a steel maille mask and worn with a linen shroud. Such trophies are associated with life-long sewer dwellers and their descendants."

/obj/item/clothing/cloak/forrestercloak/vanguard
	name = "vanguard cloak"
	desc = "The cloak worn by Vanguard fighters. The collar usually has the owner's name embroidered on it. According to tradition, the cloaks of fallen Vanguard fighters are burned in the presence of the King of Enigma so that the ruler of these lands remembers each of those who first meet the blow of the evil lurking in the darkness of night."
	icon_state = "shadowcloak"
	item_state = "shadowcloak"

/obj/item/clothing/suit/roguetown/armor/leather/studded/warden/vanguard
	name = "vanguard armor"
	desc = "Multi-layered armor consisting of chainmail padding under a layer of tanned leather, over which a dark fabric is sewn to hide the fighter in the shadows. \"We die in the darkness of night so that you may live in the light of day.\""
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "shadowrobe"
