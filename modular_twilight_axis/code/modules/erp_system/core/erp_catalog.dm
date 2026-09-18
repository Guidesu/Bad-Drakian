/datum/erp_ui_catalog

/// Returns organ type options for UI dropdowns.
/datum/erp_ui_catalog/proc/get_organ_type_options_ui()
	return list(
		list("value" = SEX_ORGAN_PENIS, "name" = "Member"),
		list("value" = SEX_ORGAN_HANDS, "name" = "Arms"),
		list("value" = SEX_ORGAN_LEGS, "name" = "Legs"),
		list("value" = SEX_ORGAN_TAIL, "name" = "Tail"),
		list("value" = SEX_ORGAN_BODY, "name" = "Body"),
		list("value" = SEX_ORGAN_MOUTH, "name" = "Mouth"),
		list("value" = SEX_ORGAN_ANUS, "name" = "Anus"),
		list("value" = SEX_ORGAN_BREASTS, "name" = "Chest"),
		list("value" = SEX_ORGAN_VAGINA, "name" = "Vagina"),
	)
