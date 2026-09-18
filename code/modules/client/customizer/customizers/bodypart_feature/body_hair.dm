GLOBAL_LIST_INIT(named_body_hair_materials, list(
	"Hair" = BODY_HAIR_MATERIAL_HAIR,
	"Fur" = BODY_HAIR_MATERIAL_FUR,
	"Feathers" = BODY_HAIR_MATERIAL_FEATHERS,
	"Fuzz" = BODY_HAIR_MATERIAL_FUZZ,
	"Braids" = BODY_HAIR_MATERIAL_BRAIDS,
))

/datum/customizer_entry/bodypart_feature/body_hair
	var/material = BODY_HAIR_MATERIAL_HAIR

/datum/customizer/bodypart_feature/pubes
	name = "Pubic Hair"
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/pubes)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/bodypart_feature/pubes
	name = "Pubic Style"
	customizer_entry_type = /datum/customizer_entry/bodypart_feature/body_hair
	feature_type = /datum/bodypart_feature/pubes
	tgui_template = "FeatureChoiceBodyHair"
	sprite_accessories = list(
		/datum/sprite_accessory/pubes/hairy,
		/datum/sprite_accessory/pubes/trim,
		/datum/sprite_accessory/pubes/strip,
		/datum/sprite_accessory/pubes/heart,
		/datum/sprite_accessory/pubes/extreme,
		/datum/sprite_accessory/pubes/cross,
	)

/datum/customizer_choice/bodypart_feature/pubes/apply_customizer_to_character(mob/living/carbon/human/human, datum/preferences/prefs, datum/customizer_entry/entry)
	. = ..()
	var/datum/bodypart_feature/pubes/feature = human.get_bodypart_feature_of_slot(BODYPART_FEATURE_PUBES)
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	feature?.set_material(body_hair_entry.material)

/datum/customizer_choice/bodypart_feature/pubes/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	. = ..()
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	body_hair_entry.material = sanitize_integer(body_hair_entry.material, BODY_HAIR_MATERIAL_HAIR, BODY_HAIR_MATERIAL_BRAIDS, BODY_HAIR_MATERIAL_HAIR)

/datum/customizer_choice/bodypart_feature/pubes/tgui_pref_choices(datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	. = ..()
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	.["material"] = find_key_by_value(GLOB.named_body_hair_materials, body_hair_entry.material)

/datum/customizer_choice/bodypart_feature/pubes/handle_tgui_act(list/params, datum/tgui/ui, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	. = ..()
	if(.)
		return
	if(params["customizer_task"] != "body_hair_material")
		return
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	var/old_material = find_key_by_value(GLOB.named_body_hair_materials, body_hair_entry.material)
	var/new_material = tgui_input_list(ui.user, "Choose the material:", "Pubic Hair", GLOB.named_body_hair_materials, old_material)
	if(isnull(new_material))
		return TRUE
	prefs.verbose_pref_log_change(ui.user, "notice", "Pubic hair material", old_material, new_material)
	body_hair_entry.material = GLOB.named_body_hair_materials[new_material]
	return TRUE

/datum/customizer/bodypart_feature/pits
	name = "Armpit Hair"
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/pits)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/bodypart_feature/pits
	name = "Armpit Style"
	customizer_entry_type = /datum/customizer_entry/bodypart_feature/body_hair
	feature_type = /datum/bodypart_feature/pits
	tgui_template = "FeatureChoiceBodyHair"
	sprite_accessories = list(
		/datum/sprite_accessory/pits/trim,
		/datum/sprite_accessory/pits/moderate,
		/datum/sprite_accessory/pits/hairy,
		/datum/sprite_accessory/pits/extreme,
	)

/datum/customizer_choice/bodypart_feature/pits/apply_customizer_to_character(mob/living/carbon/human/human, datum/preferences/prefs, datum/customizer_entry/entry)
	. = ..()
	var/datum/bodypart_feature/pits/feature = human.get_bodypart_feature_of_slot(BODYPART_FEATURE_PITS)
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	feature?.set_material(body_hair_entry.material)

/datum/customizer_choice/bodypart_feature/pits/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	. = ..()
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	body_hair_entry.material = sanitize_integer(body_hair_entry.material, BODY_HAIR_MATERIAL_HAIR, BODY_HAIR_MATERIAL_BRAIDS, BODY_HAIR_MATERIAL_HAIR)

/datum/customizer_choice/bodypart_feature/pits/tgui_pref_choices(datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	. = ..()
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	.["material"] = find_key_by_value(GLOB.named_body_hair_materials, body_hair_entry.material)

/datum/customizer_choice/bodypart_feature/pits/handle_tgui_act(list/params, datum/tgui/ui, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	. = ..()
	if(.)
		return
	if(params["customizer_task"] != "body_hair_material")
		return
	var/datum/customizer_entry/bodypart_feature/body_hair/body_hair_entry = entry
	var/old_material = find_key_by_value(GLOB.named_body_hair_materials, body_hair_entry.material)
	var/new_material = tgui_input_list(ui.user, "Choose the material:", "Armpit Hair", GLOB.named_body_hair_materials, old_material)
	if(isnull(new_material))
		return TRUE
	prefs.verbose_pref_log_change(ui.user, "notice", "Armpit hair material", old_material, new_material)
	body_hair_entry.material = GLOB.named_body_hair_materials[new_material]
	return TRUE
