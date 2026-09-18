/datum/advclass/noctite_spellblade
	name = "Newmoon Spellblade"
	tutorial = "Darkmoon Spellcasters are known in radical Noctite circles as the most devoted Nok monks, most often originating from Zybanthia. \
		For some reason, you left your monastery and came here. Is it a pilgrimage or a mission to spread the word of Nok?...\
		Only you can say for sure. Although you are quite a fanatical Noktit, you have come here in peace and therefore are fairly tolerant of other gods and the established Order,\
		possibly holding distrust toward Astrate according to the radical teaching of Nok... \
		Despite the teachings of the local ministers of the Church of the Ten, you know and are deeply convinced that Nok does not demand worship; she has bestowed upon you something more unique:\
		for your faithful service and knowledge in the arcane, you have gained access to arcane weapons. Miracles are not available to you, but in return, you have gained access to the arcane, and regardless of what weapon the light of Nok would create for you, you are an expert in it."
	outfit = /datum/outfit/job/roguetown/spellblade
	category_tags = list(CTAG_TEMPLAR)
	subclass_languages = list(/datum/language/raneshi)
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_NIGHT_OWL, TRAIT_ARCYNE, TRAIT_NOC_LIGHT_BLESSING)
	subclass_mage_aspects = list("mastery" = FALSE, "major" = FALSE, "minor" = 2, "utilities" = 6)
	maximum_possible_slots = 1
	subclass_stats = list(
		STATKEY_WIL = 1,
		STATKEY_INT = 5,
	)
	subclass_skills = list(
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/magic/arcane = SKILL_LEVEL_JOURNEYMAN
	)

	subclass_stashed_items = list(
		"Darkmoon Cape" = /obj/item/clothing/cloak/half/newmoon,
	)

	allowed_patrons = list(/datum/patron/divine/noc)

/datum/outfit/job/roguetown/spellblade
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver/noc
	head = /obj/item/clothing/head/roguetown/roguehood/newmoon
	armor = /obj/item/clothing/suit/roguetown/armor/leather/newmoon_jacket
	id = /obj/item/clothing/ring/gold
	backl = /obj/item/storage/backpack/rogue/satchel
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/newmoon
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather
	mask = /obj/item/clothing/mask/rogue/ragmask/newmoon
	backpack_contents = list(
		/obj/item/lockpickring/mundane = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/storage/keyring/acolyte = 1,
		/obj/item/rogueweapon/spellbook = 1
		)

/datum/outfit/job/roguetown/spellblade/pre_equip(mob/living/carbon/human/H)
	..()

	H.cmode_music = 'modular_twilight_axis/church_classes/sound/cmode_spellblade.ogg'
	ADD_TRAIT(H, TRAIT_CLERGY_TA, TRAIT_GENERIC)
	REMOVE_TRAIT(H, TRAIT_RITUALIST, JOB_TRAIT)

	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_LOWER_MIDDLE_CLASS, H, "Church Funding.")

	var/obj/effect/proc_holder/spell/targeted/spellblade_select_weapon/select_weapon 
	select_weapon = new /obj/effect/proc_holder/spell/targeted/spellblade_select_weapon

	var/obj/effect/proc_holder/spell/invoked/spellblade_summon_weapon/summon_weapon
	summon_weapon = new /obj/effect/proc_holder/spell/invoked/spellblade_summon_weapon
	summon_weapon.weapon_select = select_weapon
	select_weapon.summon_weapon = summon_weapon
	
	H.AddSpell(select_weapon)
	H.AddSpell(summon_weapon)
	H.AddSpell(new /obj/effect/proc_holder/spell/self/noctite_fortify)
