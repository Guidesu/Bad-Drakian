/datum/customizer/organ/wings
	abstract_type = /datum/customizer/organ/wings
	name = "Wings"

/datum/customizer_choice/organ/wings
	abstract_type = /datum/customizer_choice/organ/wings
	name = "Wings"
	organ_type = /obj/item/organ/wings
	organ_slot = ORGAN_SLOT_WINGS
	organ_dna_type = /datum/organ_dna/wings
	customizer_entry_type = /datum/customizer_entry/organ/wings
	allows_accessory_color_customization = FALSE
	tgui_template = "FeatureChoiceWings"
	var/allows_natural_gradient = TRUE
	var/allows_dye_gradient = TRUE

/datum/customizer_entry/organ/wings
	var/wings_color = "#FFFFFF"
	var/natural_gradient = /datum/hair_gradient/none
	var/natural_color = "#FFFFFF"
	var/dye_gradient = /datum/hair_gradient/none
	var/dye_color = "#FFFFFF"

/datum/customizer_choice/organ/wings/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/wings/wings_entry = entry
	wings_entry.wings_color = sanitize_hexcolor(wings_entry.wings_color, 6, TRUE, "#FFFFFF")
	wings_entry.natural_gradient = sanitize_hair_gradient(wings_entry.natural_gradient)
	wings_entry.natural_color = sanitize_hexcolor(wings_entry.natural_color, 6, TRUE, "#FFFFFF")
	wings_entry.dye_gradient = sanitize_hair_gradient(wings_entry.dye_gradient)
	wings_entry.dye_color = sanitize_hexcolor(wings_entry.dye_color, 6, TRUE, "#FFFFFF")

/datum/customizer_choice/organ/wings/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/wings/wings_dna = organ_dna
	var/datum/customizer_entry/organ/wings/wings_entry = entry
	var/datum/sprite_accessory/wings/wing_accessory = SPRITE_ACCESSORY(entry.accessory_type)
	if(wing_accessory.color_keys > 1)
		wings_dna.wings_color = wings_entry.accessory_colors
		return
	wings_dna.wings_color = wings_entry.wings_color
	wings_dna.wing_natural_gradient = wings_entry.natural_gradient
	wings_dna.wing_natural_color = wings_entry.natural_color
	wings_dna.wing_dye_gradient = wings_entry.dye_gradient
	wings_dna.wing_dye_color = wings_entry.dye_color

/datum/customizer_choice/organ/wings/tgui_pref_choices(datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	var/list/data = ..()
	var/datum/customizer_entry/organ/wings/wings_entry = entry
	data["wings_color"] = wings_entry.wings_color
	data["natural_gradient"] = wings_entry.natural_gradient
	data["natural_color"] = wings_entry.natural_color
	data["dye_gradient"] = wings_entry.dye_gradient
	data["dye_color"] = wings_entry.dye_color
	data["allows_natural_gradient"] = allows_natural_gradient
	data["allows_dye_gradient"] = allows_dye_gradient
	return data

/datum/customizer_choice/organ/wings/handle_tgui_act(list/params, datum/tgui/ui, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user
	var/datum/customizer_entry/organ/wings/wings_entry = entry
	switch(params["customizer_task"])
		if("wings_color", "natural_color", "dye_color")
			var/task = params["customizer_task"]
			var/current_color = wings_entry.wings_color
			if(task == "natural_color")
				current_color = wings_entry.natural_color
			else if(task == "dye_color")
				current_color = wings_entry.dye_color
			var/new_color = color_pick_sanitized(user, "Choose a wing colour:", "Character Preference", current_color)
			if(!new_color)
				return TRUE
			if(task == "wings_color")
				wings_entry.wings_color = new_color
			else if(task == "natural_color")
				wings_entry.natural_color = new_color
			else
				wings_entry.dye_color = new_color
			return TRUE
		if("natural_gradient", "dye_gradient")
			var/list/choice_list = hair_gradient_types()
			var/chosen = tgui_input_list(user, "Choose a wing gradient:", "Character Preference", choice_list)
			if(isnull(chosen))
				return TRUE
			if(params["customizer_task"] == "natural_gradient")
				wings_entry.natural_gradient = choice_list[chosen]
			else
				wings_entry.dye_gradient = choice_list[chosen]
			return TRUE

/datum/customizer/organ/wings/anthro
	customizer_choices = list(/datum/customizer_choice/organ/wings/anthro)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/organ/wings/anthro
	name = "Wings"
	organ_type = /obj/item/organ/wings/anthro
	sprite_accessories = list(
		/datum/sprite_accessory/wings/bat,
		/datum/sprite_accessory/wings/feathery,
		/datum/sprite_accessory/wings/featheryv2,
		/datum/sprite_accessory/wings/pinioned,
		/datum/sprite_accessory/wings/wide/succubus,
		/datum/sprite_accessory/wings/fairy,
		/datum/sprite_accessory/wings/bee,
		/datum/sprite_accessory/wings/wide/dragon_alt1,
		/datum/sprite_accessory/wings/wide/dragon_alt2,
		/datum/sprite_accessory/wings/wide/harpywings,
		/datum/sprite_accessory/wings/wide/harpywingsalt1,
		/datum/sprite_accessory/wings/wide/harpywingsalt2,
		/datum/sprite_accessory/wings/wide/harpywings_top,
		/datum/sprite_accessory/wings/wide/harpywingsalt1_top,
		/datum/sprite_accessory/wings/wide/harpywingsalt2_top,
		/datum/sprite_accessory/wings/wide/low_wings,
		/datum/sprite_accessory/wings/wide/low_wings_top,
		/datum/sprite_accessory/wings/wide/spider,
		/datum/sprite_accessory/wings/huge/dragon,
		/datum/sprite_accessory/wings/dragon/clipped,
		/datum/sprite_accessory/wings/large/harpyswept,
		/datum/sprite_accessory/wings/large/harpyswept_alt,
		/datum/sprite_accessory/wings/large/harpyfluff,
		/datum/sprite_accessory/wings/large/harpyfolded,
		/datum/sprite_accessory/wings/large/harpyowl,
		/datum/sprite_accessory/wings/large/harpybat_alt,
		)

/datum/customizer/organ/wings/moth
	name = "Fluvian Wings"
	allows_disabling = TRUE
	default_disabled = FALSE
	customizer_choices = list(/datum/customizer_choice/organ/wings/moth)

/datum/customizer_choice/organ/wings/moth
	name = "Fluvian Wings"
	organ_type = /obj/item/organ/wings/moth
	sprite_accessories = list(
		/datum/sprite_accessory/wings/moth/plain,
		/datum/sprite_accessory/wings/moth/monarch,
		/datum/sprite_accessory/wings/moth/luna,
		/datum/sprite_accessory/wings/moth/atlas,
		/datum/sprite_accessory/wings/moth/reddish,
		/datum/sprite_accessory/wings/moth/royal,
		/datum/sprite_accessory/wings/moth/gothic,
		/datum/sprite_accessory/wings/moth/lovers,
		/datum/sprite_accessory/wings/moth/whitefly,
		/datum/sprite_accessory/wings/moth/punished,
		/datum/sprite_accessory/wings/moth/firewatch,
		/datum/sprite_accessory/wings/moth/deathhead,
		/datum/sprite_accessory/wings/moth/poison,
		/datum/sprite_accessory/wings/moth/ragged,
		/datum/sprite_accessory/wings/moth/moonfly,
		/datum/sprite_accessory/wings/moth/snow,
		/datum/sprite_accessory/wings/moth/oakworm,
		/datum/sprite_accessory/wings/moth/jungle,
		/datum/sprite_accessory/wings/moth/witchwing,
		/datum/sprite_accessory/wings/moth/rosy,
		/datum/sprite_accessory/wings/moth/featherful,
		/datum/sprite_accessory/wings/moth/brown,
		/datum/sprite_accessory/wings/moth/plasmafire,
		)

/datum/customizer/organ/wings/dracon
	customizer_choices = list(/datum/customizer_choice/organ/wings/dracon)
	allows_disabling = FALSE
	default_disabled = FALSE

/datum/customizer_choice/organ/wings/dracon
	name = "Drake Wings"
	organ_type = /obj/item/organ/wings/dracon
	sprite_accessories = list(
		/datum/sprite_accessory/wings/bat,
		/datum/sprite_accessory/wings/wide/succubus,
		/datum/sprite_accessory/wings/wide/dragon_alt1,
		/datum/sprite_accessory/wings/wide/dragon_alt2,
		/datum/sprite_accessory/wings/huge/dragon,
		/datum/sprite_accessory/wings/dragon/clipped,
		)

/datum/customizer/organ/wings/slime
	customizer_choices = list(/datum/customizer_choice/organ/wings/slime)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/organ/wings/slime
	name = "Wings"
	organ_type = /obj/item/organ/wings
	allows_accessory_color_customization = FALSE
	sprite_accessories = list(
		/datum/sprite_accessory/wings/bat,
		/datum/sprite_accessory/wings/feathery,
		/datum/sprite_accessory/wings/featheryv2,
		/datum/sprite_accessory/wings/pinioned,
		/datum/sprite_accessory/wings/wide/succubus,
		/datum/sprite_accessory/wings/fairy,
		/datum/sprite_accessory/wings/bee,
		/datum/sprite_accessory/wings/wide/dragon_alt1,
		/datum/sprite_accessory/wings/wide/dragon_alt2,
		/datum/sprite_accessory/wings/wide/harpywings,
		/datum/sprite_accessory/wings/wide/harpywingsalt1,
		/datum/sprite_accessory/wings/wide/harpywingsalt2,
		/datum/sprite_accessory/wings/wide/harpywings_top,
		/datum/sprite_accessory/wings/wide/harpywingsalt1_top,
		/datum/sprite_accessory/wings/wide/harpywingsalt2_top,
		/datum/sprite_accessory/wings/wide/low_wings,
		/datum/sprite_accessory/wings/wide/low_wings_top,
		/datum/sprite_accessory/wings/wide/spider,
		/datum/sprite_accessory/wings/huge/dragon,
		/datum/sprite_accessory/wings/dragon/clipped,
		/datum/sprite_accessory/wings/large/harpyswept,
		/datum/sprite_accessory/wings/large/harpyswept_alt,
		/datum/sprite_accessory/wings/large/harpyfluff,
		/datum/sprite_accessory/wings/large/harpyfolded,
		/datum/sprite_accessory/wings/large/harpyowl,
		/datum/sprite_accessory/wings/large/harpybat_alt,
		)
