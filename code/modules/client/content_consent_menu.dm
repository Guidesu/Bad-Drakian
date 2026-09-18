/client/verb/content_consent_menu()
	set name = "Content & Consent Toggles"
	set category = "Preferences.Options"
	set desc = "Choose which adult-content systems may affect you."

	if(!prefs)
		return
	if(!content_consent_menu)
		content_consent_menu = new(src)
	content_consent_menu.ui_interact(mob)

/datum/content_consent_menu
	var/client/owner

/datum/content_consent_menu/New(client/new_owner)
	. = ..()
	owner = new_owner

/datum/content_consent_menu/Destroy(force)
	if(owner?.content_consent_menu == src)
		owner.content_consent_menu = null
	owner = null
	return ..()

/datum/content_consent_menu/ui_state(mob/user)
	return GLOB.always_state

/datum/content_consent_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ToggleOptionsMenu", "Content & Consent")
		ui.open()

/datum/content_consent_menu/ui_data(mob/user)
	if(!owner?.prefs)
		return list("categories" = list())
	var/datum/preferences/P = owner.prefs
	var/list/content_entries = list(
		list("id" = "erp_panel", "label" = "Enable ERP Interactions", "enabled" = !!P.sexable, "desc" = "Allow consensual SexCon and ERP-panel interactions to target your character."),
		list("id" = "chastity", "label" = "Enable Chastity Content", "enabled" = !!P.chastenable, "desc" = "Allow chastity devices and related actions to affect your character."),
		list("id" = "permanent_binding", "label" = "Enable Permanent Binding", "enabled" = !!P.chastity_hardmode, "desc" = "Allow irreversible, key-only chastity locks. Chastity content must also be enabled."),
		list("id" = "extreme_erp", "label" = "Enable Extreme ERP Content", "enabled" = !!P.extreme_erp, "desc" = "Allow content explicitly categorized as extreme."),
		list("id" = "edging", "label" = "Enable Edging Content", "enabled" = !!P.edging, "desc" = "Allow edging mechanics and related actions."),
		list("id" = "facial_branding", "label" = "Enable Facial Branding", "enabled" = !!P.facial_brands, "desc" = "Allow branding interactions that affect the face."),
		list("id" = "sensitive_branding", "label" = "Enable Sensitive Branding", "enabled" = !!P.sensitive_brands, "desc" = "Allow branding interactions that affect breasts or genitals."),
		list("id" = "pubes", "label" = "Show Pubic Hair Descriptors", "enabled" = !!P.show_pubic_hair, "desc" = "Show exposed pubic-hair details when examining characters."),
		list("id" = "pits", "label" = "Show Armpit Hair Descriptors", "enabled" = !!P.show_armpit_hair, "desc" = "Show exposed armpit-hair details when examining characters."),
		list("id" = "descriptor_color", "label" = "Enable Colored Body Descriptors", "enabled" = !!P.descriptor_color, "desc" = "Color body descriptors using relevant body and arousal colors."),
		list("id" = "cursed_collars", "label" = "Enable Cursed Collars", "enabled" = !!P.cursed_collarable, "desc" = "Allow cursed collars to be equipped on your character.")
	)
	return list("categories" = list(list("name" = "Adult Content", "entries" = content_entries)))

/datum/content_consent_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..() || action != "toggle" || !owner?.prefs)
		return FALSE
	var/datum/preferences/P = owner.prefs
	switch(params["id"])
		if("erp_panel")
			P.sexable = !P.sexable
		if("chastity")
			P.chastenable = !P.chastenable
			if(!P.chastenable)
				P.chastity_hardmode = FALSE
				owner.modular_handle_chastity_toggle_disable()
		if("permanent_binding")
			if(!P.chastenable)
				to_chat(owner, span_warning("Enable chastity content before enabling permanent binding."))
				return FALSE
			P.chastity_hardmode = !P.chastity_hardmode
		if("extreme_erp")
			P.extreme_erp = !P.extreme_erp
			if(!P.extreme_erp)
				owner.modular_handle_extreme_erp_toggle_disable()
		if("edging")
			P.edging = !P.edging
		if("facial_branding")
			P.facial_brands = !P.facial_brands
		if("sensitive_branding")
			P.sensitive_brands = !P.sensitive_brands
		if("pubes")
			P.show_pubic_hair = !P.show_pubic_hair
		if("pits")
			P.show_armpit_hair = !P.show_armpit_hair
		if("descriptor_color")
			P.descriptor_color = !P.descriptor_color
		if("cursed_collars")
			P.cursed_collarable = !P.cursed_collarable
			if(!P.cursed_collarable)
				owner.modular_handle_cursed_binding_toggle_disable()
		else
			return FALSE
	P.save_preferences()
	SStgui.update_uis(src)
	return TRUE

/client/proc/modular_handle_cursed_binding_toggle_disable()
	if(!ishuman(mob))
		return
	var/mob/living/carbon/human/wearer = mob
	var/obj/item/chastity/device = wearer.chastity_device
	if(!istype(device) || !device.chastity_cursed)
		return
	device.remove_chastity(wearer)
	device.forceMove(get_turf(wearer))
	to_chat(wearer, span_notice("Your consent preference releases the cursed chastity device."))
