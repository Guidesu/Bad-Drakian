/datum/advclass/janissary/sihrbaz
	name = "Janissary Sihrbaz"
	tutorial = "You are a living weapon of the Sultanate, a battle mage whose arcane power is chained in the tight grip of military discipline. \
        Unlike the inglorious Sahir-Maraduns hiding in the sands of the frontier, you have sworn a sacred oath to the Sultan and have been trained to kill in formation.\
        In your hands, the classical arcana has turned into a flawless, terrifying art of war: you are able to burn entire flanks of the enemy,\
        to hold the borders of the Sultanate with an indestructible shield and unleash devastating magical blasts that crush enemy ranks.\
        Let enemies tremble before your power, for you are a battle mage."
	maximum_possible_slots = 1
	outfit = /datum/outfit/job/roguetown/janissary/sihrbaz
	category_tags = list(CTAG_JANISSARY)
	subclass_stats = list(
		STATKEY_SPD = 1,
		STATKEY_PER = 2,
		STATKEY_INT = 3,
	)
	traits_applied = list(TRAIT_DODGEEXPERT, TRAIT_ARCYNE)
	subclass_mage_aspects = list("mastery" = TRUE, "major" = 1, "minor" = 3, "utilities" = 6, "ward" = TRUE)
	subclass_skills = list(
		/datum/skill/magic/arcane = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/misc/tracking = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/janissary/sihrbaz/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/noc
	pants = /obj/item/clothing/under/roguetown/sirwal/fancy/red
	armor = /obj/item/clothing/suit/roguetown/armor/plate/cuirass/fencer
	shirt = /obj/item/clothing/suit/roguetown/shirt/robe/bisht/red
	head = /obj/item/clothing/head/roguetown/turban/red
	r_hand = /obj/item/rogueweapon/sword/long/kriegmesser/zybantine
	l_hand = /obj/item/rogueweapon/woodstaff/implement/grand
	beltl = /obj/item/rogueweapon/scabbard/sword
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/special
	backpack_contents = list(
		/obj/item/rope/chain = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1,
		/obj/item/storage/keyring/manatarms,
		/obj/item/rogueweapon/spellbook = 1,
		/obj/item/chalk = 1,
		)
	H.adjust_blindness(-3)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/ballistic_mortar)
		H.mind.AddSpell(new /datum/action/cooldown/spell/mindlink)
		H.mind.AddSpell(new /datum/action/cooldown/spell/message)
		H.verbs |= /mob/proc/haltyell
