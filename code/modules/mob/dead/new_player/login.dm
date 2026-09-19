/mob/dead/new_player/Login()
	if(client && CONFIG_GET(flag/use_exp_tracking))
		client.set_exp_from_db()
		client.set_db_player_flags()
	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	..()

	if(client)
		client.update_ooc_verb_visibility()
		ui_interact(src)

	sight |= SEE_TURFS

	addtimer(CALLBACK(src, PROC_REF(do_after_login)), 4 SECONDS)

	if(client)
		client.playtitlemusic()

/mob/dead/new_player/proc/do_after_login()
	PRIVATE_PROC(TRUE)
	if(!client)
		return

	var/motd = global.config.motd
	if(motd)
		to_chat(src, "<div class=\"motd\">[motd]</div>", handle_whitespace=FALSE)

	if(SSticker.current_state == GAME_STATE_PLAYING)
		to_chat(src, span_notice("Welcome to the [SSticker.realm_type] of [SSticker.realm_name]."))

	if(GLOB.rogue_round_id)
		to_chat(src, span_info("ROUND ID: [GLOB.rogue_round_id]"))

//		to_chat(src, span_notice("New to the server? The <a href='byond://?src=[REF(client)];open_encyclopedia=1'>Encyclopaedia Azurea</a> holds recipes, and guides - you can also find it under the OOC tab."))

	if(GLOB.admin_notice)
		to_chat(src, span_notice("<b>Admin Notice:</b>\n \t [GLOB.admin_notice]"))

	if(SSgamemode?.dnr_round)
		to_chat(src, span_danger("<b>Merciless Mode:</b> Death is permanent this round. Do not expect revival."))

	var/spc = CONFIG_GET(number/soft_popcap)
	if(spc && living_player_count() >= spc)
		to_chat(src, span_notice("<b>Server Notice:</b>\n \t [CONFIG_GET(string/soft_popcap_message)]"))

	if(SSticker.current_state < GAME_STATE_SETTING_UP)
		var/tl = SSticker.GetTimeLeft()
		var/postfix
		if(tl > 0)
			postfix = "in about [DisplayTimeText(tl)]"
		else
			postfix = "soon"
		to_chat(src, "The game will start [postfix].")

		SSvote.send_vote(client)
		var/usedkey = ckey(key)
		var/list/thinz = list("takes a seat.", "settles in.", "joins the session", "joins the table.", "becomes a player.")
		SEND_TEXT(world, span_notice("[usedkey] [pick(thinz)]"))
