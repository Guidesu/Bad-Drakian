/obj/item/organ/wings
	name = "wings"
	desc = "A pair of wings. Those may or may not allow you to fly... or at the very least flap."
	visible_organ = TRUE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS
	///Whether the wings should grant flight on insertion.
	var/unconditional_flight
	///What species get flights thanks to those wings. Important for moth wings
	var/list/flight_for_species
	///Whether a wing can be opened by the *wing emote. The sprite use a "_open" suffix, before their layer
	var/can_open
	///Whether an openable wing is currently opened
	var/is_open
	///Whether the owner of wings has flight thanks to the wings
	var/granted_flight
	var/wings_color = "#FFFFFF"
	var/wing_natural_gradient = /datum/hair_gradient/none
	var/wing_natural_color = "#FFFFFF"
	var/wing_dye_gradient = /datum/hair_gradient/none
	var/wing_dye_color = "#FFFFFF"

/obj/item/organ/wings/bodypart_overlays(mutable_appearance/standing)
	add_gradient_overlay(standing, wing_natural_gradient, wing_natural_color)
	add_gradient_overlay(standing, wing_dye_gradient, wing_dye_color)

/obj/item/organ/wings/proc/add_gradient_overlay(mutable_appearance/standing, gradient_type, gradient_color)
	if(gradient_type == /datum/hair_gradient/none || isnull(gradient_type))
		return
	var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(accessory_type)
	var/datum/hair_gradient/gradient = HAIR_GRADIENT(gradient_type)
	if(!accessory?.gradient_icon || !gradient?.icon_state)
		return
	var/icon/gradient_mask = icon(accessory.gradient_icon, gradient.icon_state)
	if(accessory.pixel_x > 0)
		gradient_mask.Shift(NORTH, accessory.pixel_x, wrap = TRUE)
	else if(accessory.pixel_x < 0)
		gradient_mask.Shift(SOUTH, abs(accessory.pixel_x), wrap = TRUE)
	var/layered_icon_state = accessory.icon_state
	var/layer_suffix = accessory.get_layer_suffix(-(standing.layer))
	if(layer_suffix)
		layered_icon_state = "[accessory.icon_state]_[layer_suffix]"
	var/icon/wing_icon = icon(accessory.icon, layered_icon_state)
	gradient_mask.Blend(wing_icon, ICON_ADD)
	var/mutable_appearance/gradient_appearance = mutable_appearance(gradient_mask)
	gradient_appearance.color = sanitize_hexcolor(gradient_color, 6, TRUE, "#FFFFFF")
	standing.overlays += gradient_appearance

//TODO: Well you know what this flight stuff is a bit complicated and hardcoded, this is enough for now

/obj/item/organ/wings/moth
	name = "fluvian wings"
	desc = "A pair of fuzzy moth wings."
	flight_for_species = list("moth")

/obj/item/organ/wings/dracon
	name = "drakian wings"
	desc = "A pair of majestic drakian wings."
//	flight_for_species = list("dracon") we'll revisit this later it's probably moth sprite only


/obj/item/organ/wings/anthro
	name = "wild-kin wings"

/obj/item/organ/wings/flight
	unconditional_flight = TRUE
	can_open = TRUE

/obj/item/organ/wings/flight/angel
	name = "angel wings"
	desc = "A pair of magnificent, feathery wings. They look strong enough to lift you up in the air."

/obj/item/organ/wings/flight/dragon
	name = "dragon wings"
	desc = "A pair of intimidating, membranous wings. They look strong enough to lift you up in the air."

/obj/item/organ/wings/flight/megamoth
	name = "megamoth wings"
	desc = "A pair of horrifyingly large, fuzzy wings. They look strong enough to lift you up in the air."

/obj/item/organ/wings/flight/night_kin
	name = "Vampire Wings"
	accessory_type = /datum/sprite_accessory/wings/large/gargoyle
	/// Flight datum
	var/datum/action/item_action/organ_action/use/flight/fly
