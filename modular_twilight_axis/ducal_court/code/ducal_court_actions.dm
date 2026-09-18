/datum/ducal_court/proc/court_action_blocker(mob/living/carbon/human/user, action)
	if(!istype(user))
		return "Only a living subject can manage the courtyard."
	if(!get_throat())
		return "Ancient magic is silent."

	var/has_crown = user_has_crown(user)
	var/has_authority = user_has_ducal_authority(user)
	var/can_announce = SScommunications.can_announce(user)
	var/obj/structure/roguethrone/throne = GLOB.king_throne
	var/datum/usurpation_rite/rite = throne?.active_rite

	switch(action)
		if("summon_crown")
			return null
		if("summon_key")
			if(!has_crown)
				return "A crown is required."
			return null
		if("make_announcement")
			if(!has_crown)
				return "A crown is required."
			if(world.time < GLOB.last_crown_announcement_time + 2 MINUTES)
				return "The time for a new announcement has not yet come."
			if(!can_announce)
				return "Ancient magic is still regaining strength."
			return null
		if("revise_charter", "restore_charter", "set_taxes", "change_colors")
			if(!has_crown)
				return "A crown is required."
			if(!has_authority)
				return "Only the ruler or regent."
			return null
		if("issue_decree", "set_laws", "make_law", "purge_laws", "purge_decrees")
			if(!has_crown)
				return "A crown is required."
			if(!has_authority)
				return "Only the ruler or regent."
			if(!can_announce)
				return "Ancient magic is still regaining strength."
			return null
		if("declare_outlaw")
			if(!has_crown)
				return "A crown is required."
			if(!has_authority)
				return "Only the ruler or regent."
			if(!user_has_lord_job(user))
				return "Only the reigning rank can declare outlawed."
			if(!can_announce)
				return "Ancient magic is still regaining strength."
			return null
		if("ascend")
			if(!throne)
				return "There is no throne to claim."
			if(rite)
				return "The succession ritual is already underway."
			if(!SSticker.had_ruler)
				return "There is no one to overthrow — there was no ruler."
			if(SSticker.rulermob == user)
				return "The throne is already yours."
			if(SSgamemode.roundvoteend)
				return "The fate of the lands is already decided."
			if(!has_available_usurpation_rite(user))
				return "No succession ritual is available to you."
			return null
		if("assent")
			if(!rite)
				return "There is no claim requiring consent."
			if(rite.stage != RITE_STAGE_GATHERING)
				return "Consent is only accepted during the gathering of votes."
			if(!user_near_throne(user))
				return "To express consent, stand by the throne."
			return null
		if("abdicate")
			if(!rite)
				return "There is no claim to renounce."
			if(rite.stage >= RITE_STAGE_CONTESTING)
				return "The ritual is already being contested."
			if(!has_authority)
				return "Only the ruler or regent may renounce."
			if(!user_near_throne(user))
				return "To abdicate, stand at the throne."
			return null
		if("stop_ascent")
			if(!rite)
				return "There is no ascension that can be stopped."
			if(rite.stage != RITE_STAGE_CONTESTING)
				return "Ascension can only be stopped at the contestation stage."
			if(rite.contester)
				return "Someone is already contesting the ritual from the throne."
			if(!throne || !(user in throne.buckled_mobs))
				return "Sit on the throne to stop the inheritance."
			return null
		if("become_regent")
			if(!has_crown)
				return "A crown is required."
			if(SSticker.rulermob == user)
				return "The throne is already yours."
			var/mob/living/current_lord = SSticker.rulermob
			if(current_lord && !QDELETED(current_lord) && current_lord.stat != DEAD)
				return "The true ruler still dwells in these lands."
			if(!HAS_TRAIT(user, TRAIT_NOBLE))
				return "Noble blood is required."
			if(!(user.job in GLOB.regency_positions))
				return "Your rank cannot bear the crown as regent."
			if(SSticker.regentday == GLOB.dayspassed)
				return "A regent has already been proclaimed today."
			if(SSticker.regentmob == user)
				return "You are already a regent."
			return null
	return "Unknown court action."

/datum/ducal_court/proc/reject_court_action(mob/living/carbon/human/user, action)
	var/reason = court_action_blocker(user, action)
	if(!reason)
		return FALSE
	to_chat(user, span_warning(reason))
	playsound(GLOB.king_throne || user, 'sound/misc/machineno.ogg', 100, FALSE, -1)
	return TRUE

/datum/ducal_court/proc/get_court_text_param(list/params, key = "text", max_len = MAX_MESSAGE_LEN)
	var/text = params[key]
	if(!istext(text))
		return null
	text = trim(text)
	if(!length(text))
		return null
	return copytext(text, 1, max_len + 1)

/datum/ducal_court/proc/get_court_prompt_text(mob/living/carbon/human/user, message, title)
	var/text = tgui_input_text(user, message, title, max_length = MAX_MESSAGE_LEN, multiline = TRUE, bigmodal = TRUE)
	if(!text)
		return null
	text = trim(text)
	if(!length(text))
		return null
	return copytext(text, 1, MAX_MESSAGE_LEN + 1)

/datum/ducal_court/proc/try_summon_crown(mob/living/carbon/human/user)
	var/obj/structure/roguemachine/titan/T = get_throat()
	if(!T)
		return FALSE
	var/notlord = !user_has_ducal_authority(user)
	var/obj/item/clothing/head/roguetown/crown/serpcrown/I = SSroguemachine.crown

	if(!I)
		T.summon_crown()
		return TRUE

	var/mob/M = get_containing_mob(I)

	if(!M)
		var/area/crown_area = get_area(I)
		if(crown_area && istype(crown_area, /area/rogue/indoors/town/vault) && notlord)
			T.say("The crown is within the vault.")
			playsound(T, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			return FALSE
		T.summon_crown()
		return TRUE

	if(ishuman(M))
		var/mob/living/carbon/human/HC = M

		if(HC.stat == DEAD)
			HC.dropItemToGround(I, TRUE)
			T.summon_crown()
			return TRUE

		if(SSticker.rulermob == HC || SSticker.regentmob == HC)
			if(I in HC.held_items)
				T.say("Master [HC.real_name] holds the crown!")
			else if(HC.head == I)
				T.say("Master [HC.real_name] wears the crown!")
			else
				T.say("Master [HC.real_name] has the crown stowed away!")
			playsound(T, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			return FALSE

		if(HC.head == I)
			T.say("[HC.real_name] wears the crown!")
			playsound(T, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			return FALSE

	T.summon_crown()
	return TRUE

/datum/ducal_court/proc/announce_key_summoned()
	var/obj/structure/roguemachine/titan/T = get_throat()
	if(!T)
		return
	T.say("The key is summoned!")
	playsound(T, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
	playsound(T, 'sound/misc/hiss.ogg', 100, FALSE, -1)

/datum/ducal_court/proc/create_lord_key()
	var/obj/structure/roguemachine/titan/T = get_throat()
	if(!T)
		return
	new /obj/item/roguekey/lord(T.loc)
	announce_key_summoned()

/datum/ducal_court/proc/try_summon_key(mob/living/carbon/human/user)
	var/obj/structure/roguemachine/titan/T = get_throat()
	if(!T)
		return FALSE
	if(!user_has_crown(user))
		T.say("You need the crown.")
		playsound(T, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return FALSE
	var/obj/item/roguekey/lord/I = SSroguemachine.key
	if(!I)
		create_lord_key()
		return TRUE
	if(!ismob(I.loc))
		I.anti_stall()
		create_lord_key()
		return TRUE
	if(ishuman(I.loc))
		var/mob/living/carbon/human/HC = I.loc
		if(HC.stat != DEAD)
			T.say("[HC.real_name] holds the key!")
			playsound(T, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			return FALSE
		HC.dropItemToGround(I, TRUE)
	I.forceMove(T.loc)
	announce_key_summoned()
	return TRUE

/datum/ducal_court/proc/open_tax_menu(mob/living/carbon/human/user)
	var/datum/taxsetter/taxsetter = new("The Generous Lord Decrees")
	taxsetter.ui_interact(user)

/datum/ducal_court/proc/open_law_menu(mob/living/carbon/human/user)
	var/datum/laws_menu/lawmenu = new
	lawmenu.ui_interact(user)

/datum/ducal_court/proc/open_decree_menu(mob/living/carbon/human/user)
	var/datum/decree_setter/panel = new
	panel.ui_interact(user)

/datum/ducal_court/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return TRUE
	if(!ishuman(ui.user))
		return FALSE
	var/mob/living/carbon/human/user = ui.user
	if(!user_seated_on_throne(user))
		to_chat(user, span_warning("You no longer sit on the throne."))
		ui.close()
		return TRUE
	return handle_court_action(user, action, params)

/datum/ducal_court/proc/handle_court_action(mob/living/carbon/human/user, action, list/params)
	var/obj/structure/roguemachine/titan/T = get_throat()
	switch(action)
		if("make_announcement")
			if(reject_court_action(user, "make_announcement"))
				return TRUE
			var/text = get_court_prompt_text(user, "What will be announced to the lands?", "Announcement")
			if(text && !reject_court_action(user, "make_announcement"))
				T?.make_announcement(user, text)
			return TRUE
		if("publish_announcement")
			if(reject_court_action(user, "make_announcement"))
				return TRUE
			var/text = get_court_text_param(params)
			if(text)
				T?.make_announcement(user, text)
			return TRUE
		if("issue_decree")
			if(reject_court_action(user, "issue_decree"))
				return TRUE
			var/text = get_court_prompt_text(user, "What decree will be issued?", "Decree")
			if(text && !reject_court_action(user, "issue_decree"))
				T?.make_decree(user, text)
			return TRUE
		if("publish_decree")
			if(reject_court_action(user, "issue_decree"))
				return TRUE
			var/text = get_court_text_param(params)
			if(text)
				T?.make_decree(user, text)
			return TRUE
		if("make_law")
			if(reject_court_action(user, "make_law"))
				return TRUE
			var/text = get_court_prompt_text(user, "What law will be passed?", "New law")
			if(text && !reject_court_action(user, "make_law"))
				make_law(text)
			return TRUE
		if("publish_law")
			if(reject_court_action(user, "make_law"))
				return TRUE
			var/text = get_court_text_param(params, "text", 500)
			if(text)
				make_law(text)
			return TRUE
		if("remove_law")
			if(reject_court_action(user, "make_law"))
				return TRUE
			var/law_number = params["law_number"]
			if(istext(law_number))
				law_number = text2num(law_number)
			else if(!isnum(law_number))
				law_number = null
			if(!isnum(law_number))
				to_chat(user, span_warning("There is no law with this number."))
				return TRUE
			law_number = round(law_number)
			if(!islist(GLOB.laws_of_the_land) || law_number < 1 || law_number > length(GLOB.laws_of_the_land))
				to_chat(user, span_warning("There is no law with this number."))
				return TRUE
			remove_law(law_number)
			return TRUE
		if("revise_charter", "restore_charter")
			if(reject_court_action(user, action))
				return TRUE
			open_decree_menu(user)
			return TRUE
		if("set_laws")
			if(reject_court_action(user, "set_laws"))
				return TRUE
			open_law_menu(user)
			return TRUE
		if("set_taxes")
			if(reject_court_action(user, "set_taxes"))
				return TRUE
			open_tax_menu(user)
			return TRUE
		if("declare_outlaw")
			if(reject_court_action(user, "declare_outlaw"))
				return TRUE
			var/text = get_court_prompt_text(user, "Who should be declared outlaw or pardoned? Specify the exact name.", "Outlaw")
			if(text && !reject_court_action(user, "declare_outlaw"))
				T?.declare_outlaw(user, text)
			return TRUE
		if("change_colors")
			if(reject_court_action(user, "change_colors"))
				return TRUE
			user.lord_color_choice()
			return TRUE
		if("summon_crown")
			try_summon_crown(user)
			return TRUE
		if("summon_key")
			if(reject_court_action(user, "summon_key"))
				return TRUE
			try_summon_key(user)
			return TRUE
		if("purge_laws")
			if(reject_court_action(user, "purge_laws"))
				return TRUE
			var/confirm = tgui_alert(user, "Cancel all laws of these lands?", "Cancellation of laws", list("Cancel", "Back"))
			if(confirm == "Cancel" && !reject_court_action(user, "purge_laws"))
				purge_laws()
			return TRUE
		if("purge_decrees")
			if(reject_court_action(user, "purge_decrees"))
				return TRUE
			var/confirm = tgui_alert(user, "Cancel all decrees of these lands?", "Revocation of decrees", list("Cancel", "Back"))
			if(confirm == "Cancel" && !reject_court_action(user, "purge_decrees"))
				purge_decrees()
			return TRUE
		if("ascend")
			if(reject_court_action(user, "ascend"))
				return TRUE
			T?.start_ascension(user)
			return TRUE
		if("assent")
			if(reject_court_action(user, "assent"))
				return TRUE
			var/obj/structure/roguethrone/assent_throne = GLOB.king_throne
			var/datum/usurpation_rite/assent_rite = assent_throne ? assent_throne.active_rite : null
			if(assent_rite)
				assent_rite.try_assent(user)
			return TRUE
		if("abdicate")
			if(reject_court_action(user, "abdicate"))
				return TRUE
			var/obj/structure/roguethrone/abdicate_throne = GLOB.king_throne
			var/datum/usurpation_rite/abdicate_rite = abdicate_throne ? abdicate_throne.active_rite : null
			if(abdicate_rite)
				abdicate_rite.try_abdication(user)
			return TRUE
		if("stop_ascent")
			if(reject_court_action(user, "stop_ascent"))
				return TRUE
			var/obj/structure/roguethrone/stop_throne = GLOB.king_throne
			var/datum/usurpation_rite/stop_rite = stop_throne ? stop_throne.active_rite : null
			if(stop_rite)
				stop_rite.start_counter_claim(user)
			return TRUE
		if("become_regent")
			if(reject_court_action(user, "become_regent"))
				return TRUE
			become_regent(user)
			return TRUE
	return FALSE
