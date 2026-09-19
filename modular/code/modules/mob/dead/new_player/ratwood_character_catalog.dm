// Ratwood catalog entries retained alongside local character options.

/datum/sprite_accessory/hair/head/bangsdiagonal
	name = "Bangs (Diagonal)"
	icon_state = "diagonalbangs"
/datum/sprite_accessory/hair/head/bedheadlongest
	name = "Bedhead (Longest)"
	icon_state = "bedhead-longest"
/datum/sprite_accessory/hair/head/bob_mane
	name = "Bob (Mane)"
	icon_state = "bob_mane"
/datum/sprite_accessory/hair/head/ponytailwitcheralt
	name = "Ponytail (Witcher Alt)"
	icon_state = "ponytail_witcheralt"
/datum/sprite_accessory/hair/head/simple
	name = "Simple"
	icon_state = "simple"
/datum/sprite_accessory/hair/head/simpleshort
	name = "Simple (Short)"
	icon_state = "simple_short"
/datum/sprite_accessory/hair/head/simplelong
	name = "Simple (Long)"
	icon_state = "simple_long"
/datum/sprite_accessory/hair/head/strict
	name = "Strict"
	icon_state = "strict"
/datum/sprite_accessory/hair/head/strictshort
	name = "Strict (Short)"
	icon_state = "strict_short"
/datum/sprite_accessory/hair/head/strictlong
	name = "Strict (Long)"
	icon_state = "strict_long"
/datum/sprite_accessory/hair/head/uncaring
	name = "Uncaring"
	icon_state = "uncaring"
/datum/sprite_accessory/hair/head/hyenamaneshort
	name = "Hyena Mane (Short)"
	icon_state = "hyenamaneshort"
/datum/sprite_accessory/hair/head/dunes
	name = "Dunes"
	icon_state = "dunes"
/datum/sprite_accessory/hair/head/lakkaribun
	name = "Lakkari Bun"
	icon_state = "lakkaribun"
/datum/sprite_accessory/hair/head/lakkaricut
	name = "Lakkari Cut"
	icon_state = "lakkaricut"
/datum/sprite_accessory/hair/head/sandcrop
	name = "Sand Crop"
	icon_state = "sandcrop"
/datum/sprite_accessory/hair/head/steward
	name = "Steward"
	icon_state = "steward"
/datum/sprite_accessory/hair/head/zaladin
	name = "Zaladin"
	icon_state = "zaladin"
/datum/sprite_accessory/hair/head/tomboy
	name = "Tomboy"
	icon_state = "tomboy_f"
/datum/sprite_accessory/hair/head/vagabond
	name = "Vagabond"
	icon_state = "vagabond"
/datum/sprite_accessory/hair/head/indigozap
	name = "Reckless"
	icon_state = "indigo_zap"
/datum/sprite_accessory/hair/head/rainbowdash
	name = "Loyal"
	icon_state = "rainbow_dash"
/datum/sprite_accessory/hair/head/renard
	name = "Renard"
	icon_state = "renard"
/datum/sprite_accessory/hair/head/willowtree
	name = "Willow Tree"
	icon_state = "willowtree"
/datum/sprite_accessory/hair/head/nimue
	name = "Nimue"
	icon_state = "nimue"
/datum/sprite_accessory/hair/head/willow
	name = "Willow"
	icon_state = "willow"
/datum/sprite_accessory/hair/head/aki
	name = "Aki"
	icon_state = "aki"

/datum/body_marking/tall_eyes
	icon = 'icons/mob/body_markings/other_markings.dmi'
	name = "Tall Eyes"
	icon_state = "tall_eyes"
	default_color = "FF0000"
	affected_bodyparts = HEAD
/datum/body_marking/outer_tall_eyes
	icon = 'icons/mob/body_markings/other_markings.dmi'
	name = "Outer Tall Eyes"
	icon_state = "outer_eyes"
	default_color = "FF0000"
	affected_bodyparts = HEAD
/datum/body_marking/blank_face
	icon = 'icons/mob/body_markings/other_markings.dmi'
	name = "Blank Face"
	icon_state = "blank_face"
	default_color = "FF0000"
	affected_bodyparts = HEAD
/datum/body_marking/wolf
	icon = 'icons/mob/body_markings/chest_markings.dmi'
	name = "Wolf"
	icon_state = "wolf"
	affected_bodyparts = CHEST
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE
/datum/body_marking/harpy_feet_claws
	icon = 'icons/mob/body_markings/harpy_markings.dmi'
	name = "Feet Claws"
	icon_state = "hclaw"
	affected_bodyparts = LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY
/datum/body_marking/harpy_leg
	icon = 'icons/mob/body_markings/harpy_markings.dmi'
	name = "Avian Leg Color Override"
	icon_state = "hleg"
	affected_bodyparts = LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY
/datum/body_marking_set/harpy_feet_claws
	name = "Feet Claws"
	body_marking_list = list(/datum/body_marking/harpy_feet_claws)
/datum/body_marking_set/harpy_leg
	name = "Harpy Leg Color Override"
	body_marking_list = list(/datum/body_marking/harpy_leg)

// Upstream genital morphology paths, plus compatibility with existing local paths.
/obj/item/organ/penis/equine_slit
	name = "equine penis"
	icon_state = "equinepenis"
	penis_type = PENIS_TYPE_EQUINE
	sheath_type = SHEATH_TYPE_SLIT
/obj/item/organ/penis/equine_knotted_slit
	name = "equine knotted penis"
	icon_state = "hemipenis"
	penis_type = PENIS_TYPE_EQUINE_KNOTTED
	sheath_type = SHEATH_TYPE_SLIT
/obj/item/organ/penis/tapered_knotted
	parent_type = /obj/item/organ/penis/tapered_knot
/obj/item/organ/penis/tapered_knotted_mammal
	name = "tapered knotted penis"
	icon_state = "knotpenis"
	penis_type = PENIS_TYPE_TAPERED_KNOTTED
	sheath_type = SHEATH_TYPE_NORMAL
/obj/item/organ/penis/tapered_double_mammal
	name = "hemi tapered penis"
	icon_state = "hemipenis"
	penis_type = PENIS_TYPE_TAPERED_DOUBLE
	sheath_type = SHEATH_TYPE_NORMAL
/obj/item/organ/penis/tapered_double_knotted_mammal
	name = "hemi knotted tapered penis"
	icon_state = "hemiknotpenis"
	penis_type = PENIS_TYPE_TAPERED_DOUBLE_KNOTTED
	sheath_type = SHEATH_TYPE_NORMAL

/datum/sprite_accessory/penis/taperedknot
	parent_type = /datum/sprite_accessory/penis/tapered_knot
/datum/sprite_accessory/penis/taperedknot_mammal
	icon_state = "taperedknot"
	name = "Tapered, Knotted (Mammal)"
	color_key_defaults = list(null, KEY_CHEST_COLOR)
	default_colors = list("C52828", null)
/datum/sprite_accessory/penis/hemi_mammal
	icon_state = "hemi"
	name = "Hemi (Mammal)"
	color_key_defaults = list(null, KEY_CHEST_COLOR)
	default_colors = list("C52828", null)
/datum/sprite_accessory/vagina/trimmed
	icon_state = "trimmed"
	name = "Trimmed"
	color_key_defaults = list(KEY_HAIR_COLOR)

// Player-selectable Ratwood races. They inherit this fork's mature body and
// customization implementations while retaining their distinct catalog IDs.
/mob/living/carbon/human/species/lamia
	race = /datum/species/lamia
/datum/species/lamia
	parent_type = /datum/species/anthromorph
	name = "Lamia"
	id = "lamia"
	base_name = "Lamia"
	desc_title = "Lamia"
	desc = "Sea-born and serpentine peoples descended from the southern coasts: nagas, sirens, merfolk, and their many related broods."
	race_bonus = list(STAT_STRENGTH = 1, STAT_SPEED = -1)
	inherent_traits = list(TRAIT_LONGSTRIDER, TRAIT_VENOMOUS)
	allowed_taur_types = list(
		/obj/item/bodypart/taur/lamia,
		/obj/item/bodypart/taur/lamiastriped,
		/obj/item/bodypart/taur/fatlamia,
		/obj/item/bodypart/taur/mermaid,
		/obj/item/bodypart/taur/orca,
		/obj/item/bodypart/taur/tentacle,
	)
	forced_taur = TRUE
/datum/species/lamia/check_roundstart_eligible()
	return TRUE
/datum/species/lamia/qualifies_for_rank(rank, list/features)
	return TRUE

/mob/living/carbon/human/species/arachnid
	race = /datum/species/arachnid
/datum/species/arachnid
	parent_type = /datum/species/anthromorph
	name = "Arachnid"
	id = "arachnid"
	base_name = "Arachnid"
	desc_title = "Arachnid"
	desc = "Silk-spinning folk whose lower forms resemble spiders and other many-legged creatures."
	race_bonus = list(STAT_STRENGTH = 1, STAT_SPEED = -1)
	inherent_traits = list(TRAIT_LONGSTRIDER, TRAIT_VENOMOUS, TRAIT_WEBWALK)
	allowed_taur_types = list(
		/obj/item/bodypart/taur/spider,
		/obj/item/bodypart/taur/centipede,
		/obj/item/bodypart/taur/ant,
		/obj/item/bodypart/taur/wasp,
		/obj/item/bodypart/taur/insect,
	)
	forced_taur = TRUE
/datum/species/arachnid/check_roundstart_eligible()
	return TRUE
/datum/species/arachnid/qualifies_for_rank(rank, list/features)
	return TRUE

/mob/living/carbon/human/species/harpy
	race = /datum/species/harpy
/datum/species/harpy
	parent_type = /datum/species/anthromorph
	name = "Harpy"
	id = "harpy"
	base_name = "Harpy"
	desc_title = "Harpy"
	desc = "Nomadic songbirds from the cliffs of Etrusca, renowned as couriers, musicians, and collectors of bright treasures."
	race_bonus = list(STAT_CONSTITUTION = -3, STAT_STRENGTH = -2, STAT_PERCEPTION = 1, STAT_INTELLIGENCE = 1, STAT_SPEED = 2)
	inherent_traits = list(TRAIT_NOFALLDAMAGE1, TRAIT_STRONGBITE)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/harpy_feet_claws,
		/datum/body_marking_set/harpy_leg,
	)
/datum/species/harpy/check_roundstart_eligible()
	return TRUE
/datum/species/harpy/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/harpy/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	if(C.mind)
		if(!C.mind.has_spell(/datum/action/cooldown/spell/harpy_flight))
			C.mind.AddSpell(new /datum/action/cooldown/spell/harpy_flight)
		if(!C.mind.has_spell(/datum/action/cooldown/spell/harpy_song))
			C.mind.AddSpell(new /datum/action/cooldown/spell/harpy_song)

/datum/species/harpy/on_species_loss(mob/living/carbon/C)
	if(C.mind)
		C.mind.RemoveSpell(/datum/action/cooldown/spell/harpy_flight)
		C.mind.RemoveSpell(/datum/action/cooldown/spell/harpy_song)
	C.remove_status_effect(/datum/status_effect/debuff/harpy_flight)
	return ..()

/datum/action/cooldown/spell/harpy_flight
	name = "Harpy Flight"
	desc = "Take flight on your natural wings. Armor, restraints, or exhaustion prevent takeoff."
	button_icon = 'icons/mob/actions/roguespells.dmi'
	button_icon_state = "zad"
	click_to_activate = FALSE
	charge_required = FALSE
	cooldown_time = 1 SECONDS
	spell_requirements = SPELL_REQUIRES_HUMAN

/datum/action/cooldown/spell/harpy_flight/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/harpy = owner
	if(!istype(harpy))
		return FALSE
	if(harpy.has_status_effect(/datum/status_effect/debuff/harpy_flight))
		harpy.remove_status_effect(/datum/status_effect/debuff/harpy_flight)
		return TRUE
	if(harpy.highest_ac_worn() != ARMOR_CLASS_NONE)
		to_chat(harpy, span_warning("My armor is too heavy for flight."))
		return FALSE
	if(harpy.buckled || harpy.pulledby || harpy.restrained(ignore_grab = FALSE))
		to_chat(harpy, span_warning("I cannot take flight while restrained or held."))
		return FALSE
	if(!(harpy.mobility_flags & MOBILITY_STAND))
		to_chat(harpy, span_warning("I need firm footing before I can take flight."))
		return FALSE
	if(harpy.stamina >= harpy.max_stamina)
		to_chat(harpy, span_warning("I am too exhausted to take flight."))
		return FALSE
	harpy.visible_message(span_notice("[harpy] spreads [harpy.p_their()] wings and takes flight."), span_notice("I spread my wings and take flight."))
	harpy.apply_status_effect(/datum/status_effect/debuff/harpy_flight)
	return TRUE

/datum/status_effect/debuff/harpy_flight
	id = "harpy_flight"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/harpy_flight
	tick_interval = 10

/datum/status_effect/debuff/harpy_flight/on_apply()
	. = ..()
	var/mob/living/carbon/human/harpy = owner
	if(!istype(harpy))
		return FALSE
	harpy.movement_type |= FLYING
	ADD_TRAIT(harpy, TRAIT_SPELLCOCKBLOCK, STATUS_EFFECT_TRAIT)
	animate(harpy, pixel_y = harpy.pixel_y + 3, time = 6, loop = -1)
	animate(pixel_y = harpy.pixel_y - 3, time = 6)
	return TRUE

/datum/status_effect/debuff/harpy_flight/tick()
	. = ..()
	var/mob/living/carbon/human/harpy = owner
	if(!istype(harpy))
		return
	var/athletics = max(harpy.get_skill_level(/datum/skill/misc/athletics), SKILL_LEVEL_NOVICE)
	harpy.stamina_add(max(3, 10 - athletics))
	if(harpy.buckled || harpy.pulledby || !(harpy.mobility_flags & MOBILITY_STAND) || harpy.stamina >= harpy.max_stamina)
		to_chat(harpy, span_warning("I can no longer remain airborne."))
		harpy.remove_status_effect(type)

/datum/status_effect/debuff/harpy_flight/on_remove()
	var/mob/living/carbon/human/harpy = owner
	if(istype(harpy))
		harpy.movement_type &= ~FLYING
		REMOVE_TRAIT(harpy, TRAIT_SPELLCOCKBLOCK, STATUS_EFFECT_TRAIT)
		animate(harpy)
		var/turf/landing_turf = get_turf(harpy)
		landing_turf?.zFall(harpy)
		harpy.visible_message(span_notice("[harpy] folds [harpy.p_their()] wings and lands."), span_notice("I fold my wings and land."))
	return ..()

/atom/movable/screen/alert/status_effect/debuff/harpy_flight
	name = "Flying"
	desc = "Your wings keep you above the ground at a steady stamina cost."
	icon_state = "muscles"

/obj/item/rogue/instrument/vocals/harpy
	name = "harpy song"
	desc = "A harpy's natural singing voice."

/datum/action/cooldown/spell/harpy_song
	name = "Harpy Song"
	desc = "Use your natural voice as an instrument."
	button_icon = 'icons/mob/actions/roguespells.dmi'
	button_icon_state = "love"
	click_to_activate = FALSE
	charge_required = FALSE
	cooldown_time = 2 SECONDS
	spell_requirements = SPELL_REQUIRES_HUMAN
	var/obj/item/rogue/instrument/vocals/harpy/vocals

/datum/action/cooldown/spell/harpy_song/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/harpy = owner
	if(!istype(harpy))
		return FALSE
	if(!vocals || QDELETED(vocals))
		vocals = new(harpy)
	vocals.attack_self(harpy)
	return TRUE

/datum/action/cooldown/spell/harpy_song/Destroy()
	QDEL_NULL(vocals)
	return ..()

/mob/living/carbon/human/species/construct/metal/porcelain
	race = /datum/species/construct/metal/porcelain
/datum/species/construct/metal/porcelain
	parent_type = /datum/species/construct/metal
	name = "Porcelain Construct"
	id = "porcelain_construct"
	base_name = "Porcelain Construct"
	desc_title = "Porcelain Construct"
	desc = "A delicate-looking artificial person whose fired shell conceals the same arcane workmanship as other constructs."
	default_color = "FFF5EE"
/datum/species/construct/metal/porcelain/check_roundstart_eligible()
	return TRUE
