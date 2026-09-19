/datum/erp_action_editor_schema

/// Exports editor UI field descriptors for this action (schema + current values + options).
/datum/erp_action_editor_schema/proc/export_editor_fields(datum/erp_action/A)
	. = list()
	. += list(_make_field("action_scope", "Direction of action", "enum", A.action_scope, "BASIC", null, null, null, _scope_options(), "This affects the list available actions and filtering.", null))
	. += list(_make_field("required_init_organ", "Initiator organ (init)", "enum", A.required_init_organ, "ORGANS", null, null, null, _organ_options()))
	. += list(_make_field("required_target_organ", "Target organ (target)", "enum", A.required_target_organ, "ORGANS", null, null, null, _organ_options()))
	. += list(_make_field("reserve_target_organ", "Reserve target organ", "bool", A.reserve_target_organ, "ORGANS"))
	. += list(_make_field("active_arousal_coeff", "Excitation of initiator", "number", A.active_arousal_coeff,  "EFFECTS", 0, 10, 0.1))
	. += list(_make_field("passive_arousal_coeff", "Target arousal", "number", A.passive_arousal_coeff, "EFFECTS", 0, 10, 0.1))
	. += list(_make_field("active_pain_coeff", "Initiator pain", "number", A.active_pain_coeff,     "EFFECTS", 0, 10, 0.1))
	. += list(_make_field("passive_pain_coeff", "Target pain", "number", A.passive_pain_coeff,    "EFFECTS", 0, 10, 0.1))
	. += list(_make_field("inject_timing", "Injection: when", "enum", A.inject_timing, "INJECTION", null, null, null, _inject_timing_options()))
	. += list(_make_field("inject_source", "Injection: source", "enum", A.inject_source, "INJECTION", null, null, null, _inject_source_options()))
	. += list(_make_field("inject_target_mode", "Injection: target", "enum", A.inject_target_mode, "INJECTION", null, null, null, _inject_target_mode_options()))
	. += list(_make_field("require_same_tile", "Only from one tile", "bool", A.require_same_tile, "RESTRICTIONS"))
	. += list(_make_field("allow_when_restrained", "Can be in shackles", "bool", A.allow_when_restrained, "RESTRICTIONS"))
	. += list(_make_field("require_grab", "Need a hornbeam", "bool", A.require_grab, "RESTRICTIONS"))
	. += list(_make_field("required_item_tags", "Needed item tags", "string_list", A.required_item_tags, "TAGS", null, null, null, null, "Ex: dildo. If the list is not empty, the action will require an item with one of the tags. The item name is also a tag.", "tag"))
	. += list(_make_field("action_tags", "Action tags", "string_list", A.action_tags, "TAGS", null, null, null, null, "Eg: spanking, testicles. For filters/logic/compatibility.", "tag"))
	. += list(_make_field("message_start", "Message: start", "text", A.message_start, "MESSAGES"))
	. += list(_make_field("message_tick", "Message: process", "text", A.message_tick, "MESSAGES"))
	. += list(_make_field("message_finish", "Message: finish", "text", A.message_finish, "MESSAGES"))
	. += list(_make_field("message_climax_active", "Orgasm: initiator", "text", A.message_climax_active, "MESSAGES"))
	. += list(_make_field("message_climax_passive", "Orgasm: receiver", "text", A.message_climax_passive, "MESSAGES"))

/// Creates a single editor field descriptor.
/datum/erp_action_editor_schema/proc/_make_field(id, label, type, value, section, min=null, max=null, step=null, options=null, desc=null, placeholder=null)
	var/list/F = list(
		"id" = id,
		"label" = label,
		"type" = type,
		"value" = value,
		"section" = section
	)

	if(!isnull(min))
		F["min"] = min
	if(!isnull(max))
		F["max"] = max
	if(!isnull(step))
		F["step"] = step
	if(islist(options))
		F["options"] = options
	if(!isnull(desc))
		F["desc"] = desc
	if(!isnull(placeholder))
		F["placeholder"] = placeholder

	return F

/// Converts ticks to seconds (UI/editor convenience).
/datum/erp_action_editor_schema/proc/_ticks_to_seconds(ticks)
	if(!isnum(ticks))
		return 0
	return ticks / 10

/// Creates an enum option entry for editor schemas.
/datum/erp_action_editor_schema/proc/_opt(value, name)
	return list("value" = value, "name" = name)

/// Builds organ enum options for editor schemas.
/datum/erp_action_editor_schema/proc/_organ_options()
	. = list()
	. += list(_opt(null, "—"))
	. += list(_opt(SEX_ORGAN_PENIS, "Member"))
	. += list(_opt(SEX_ORGAN_VAGINA, "Vagina"))
	. += list(_opt(SEX_ORGAN_ANUS, "Anus"))
	. += list(_opt(SEX_ORGAN_MOUTH, "Mouth"))
	. += list(_opt(SEX_ORGAN_BREASTS, "Chest"))
	. += list(_opt(SEX_ORGAN_HANDS, "Arms"))
	. += list(_opt(SEX_ORGAN_LEGS, "Legs"))
	. += list(_opt(SEX_ORGAN_TAIL, "Tail"))
	. += list(_opt(SEX_ORGAN_BODY, "Body"))

/// Builds inject timing enum options for editor schemas.
/datum/erp_action_editor_schema/proc/_inject_timing_options()
	. = list()
	. += list(_opt(INJECT_NONE, "No"))
	. += list(_opt(INJECT_CONTINUOUS, "In progress"))
	. += list(_opt(INJECT_ON_FINISH, "At the finish line"))

/// Builds inject source enum options for editor schemas.
/datum/erp_action_editor_schema/proc/_inject_source_options()
	. = list()
	. += list(_opt(INJECT_FROM_ACTIVE, "From the actor"))
	. += list(_opt(INJECT_FROM_PASSIVE, "From target"))

/// Builds inject target mode enum options for editor schemas.
/datum/erp_action_editor_schema/proc/_inject_target_mode_options()
	. = list()
	. += list(_opt(INJECT_ORGAN, "In the selected organ"))
	. += list(_opt(INJECT_CONTAINER, "In the container"))
	. += list(_opt(INJECT_GROUND, "on the floor"))

/// Builds action scope enum options for editor schemas.
/datum/erp_action_editor_schema/proc/_scope_options()
	. = list()
	. += list(_opt(ERP_SCOPE_OTHER, "Partner"))
	. += list(_opt(ERP_SCOPE_SELF,  "Solo"))
