/obj/item/book/rogue/bibble
	name = "The Verses and Acts of the Ten"
	desc = "<font color='cfa446'>'TEN guide us through the darkness. TEN GODS above all.'</font> \
	</br>The sacred book of the Church of the Ten, distributed by the Holy Thrones throughout Grimoria. Divided into three Covenants in chronological order.\
	</br>LEVIT - The First Covenant, telling of the times of Formation and the Primordial Era.</br>DEKANOMICON - The Second Covenant, recounting the War in the Heavens, which shook our world to its foundations.</br>NEW DAWN - The Third Covenant, recounting the establishment of the Divine Order and the Indivisible Pantheon."
	icon_state = "bibble_0"
	base_icon_state = "bibble"
	title = "The Verses and Acts of the Ten"
	dat = "gott.json"
	possible_item_intents = list(
		/datum/intent/use,
		/datum/intent/bless,
	)

/obj/item/book/rogue/bibble/read(mob/user)
	if(!open)
		to_chat(user, span_info("Open me first."))
		return FALSE
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		return
	if(in_range(user, src) || isobserver(user))
		user.changeNext_move(CLICK_CD_MELEE)
		var/list/choices = list("LEVIT", "DEKANOMIKON", "NEW DAWN")
		var/section_choice = tgui_input_list(user, "Which Covenant shall I read from?", "DIVINE ENLIGHTENMENT", choices)
		var/chosentxt
		switch(section_choice)
			if("LEVIT")
				chosentxt = 'modular_twilight_axis/lore/strings/visage.txt'
			if("DEKANOMIKON")
				chosentxt = 'modular_twilight_axis/lore/strings/decanomicon.txt'
			if("NEW DAWN")
				chosentxt = 'modular_twilight_axis/lore/strings/newdawn.txt'
			else
				return
		var/list/verses = world.file2list(chosentxt)
		var/m = tgui_input_list(user, "Which verse shall I read?", "DIVINE ENLIGHTENMENT", verses)
		if(m)
			user.say(m)
		else
			m = pick(verses)
			user.say(m)

/obj/item/book/rogue/bibble/psy
	desc = "<font color='3bb5d3'>'And He weeps. Not for you, not for Himself, but for all of us.'</font>\
	</br>A leather-bound volume containing the teachings of the Church of the All-Father. Its four Covenants represent the principal traditions of the Psydonite faith.\
	</br>COVENANT OF PSYDON - the teachings of the Old Faith, which guided the righteous in the times before the Arch-Betrayal.\
	</br>LIFE OF PSYDON - the creation of Psydonia as we know it.\
	</br>COVENANT OF OTAVIK - the truth of the new era, told to us by the Great Master of Otavan.\
	</br>COVENANT OF FATE - the teachings of the inhabitants of Naledi, allies in the fight against the evil that has seized our sinful world."

/obj/item/book/rogue/bibble/psy/read(mob/living/carbon/human/user)
	if(!open)
		to_chat(user, span_info("Open it first."))
		return FALSE
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		return
	if(in_range(user, src) || isobserver(user))
		user.changeNext_move(CLICK_CD_MELEE)
		if(sect)
			var/list/verses = world.file2list("modular_twilight_axis/lore/strings/psy[sect].txt")
			var/m = tgui_input_list(user, "Which verse shall I read?", "DIVINE ENLIGHTENMENT", verses)
			if(m)
				if(prob(1) && sect == "sect1")
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					user.say("PSAI 66:6... +_The All-Father_+ said, \"I forgive you, for I love you as a father loves his daughter.\" And the blood ran down the blade and from the chest of e- Where did that come from?!")
				else
					user.say(m)
			else
				m = pick(verses)
				if(prob(1) && sect == "sect1")
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					user.say("PSAI 66:6... +_The All-Father_+ said, \"I forgive you, for I love you as a father loves his daughter.\" And the blood ran down the blade and from the chest of e- Where did that come from?!")
				else
					user.say(m)

/obj/item/book/rogue/bibble/psy/MiddleClick(mob/user, params)
	var/sects = list("THE COVENANT OF PSYDON", "THE LIFE OF PSYDON", "THE COVENANT OF OTAVIK", "THE COVENANT OF DESTINY")
	var/sect_choice = input(user, "Choose the covenant", "OF PSYDONIA") as anything in sects
	switch(sect_choice)
		if("THE COVENANT OF PSYDON")
			sect = "sect1"
		if("THE LIFE OF PSYDON")
			sect = "sect2"
		if("THE COVENANT OF OTAVIK")
			sect = "sect3"
		if("THE COVENANT OF DESTINY")
			sect = "sect4"
	return

/obj/item/book/rogue/bibble/zizo
	name = "Lexicon of Her Truth"
	desc = "<font color='ff0000'>'By learning Her teachings, one day we will walk in Her footsteps.'</font> \
	</br>A tome forbidden by the Holy See, containing an account of the mortal life and ascension of Zizo, Lady of Darkness—or at least the version accepted by the cultists of Salvation. It smells suspiciously of dried blood.</br>"
	icon_state = "zible_0"
	base_icon_state = "zible"
	title = "Lexicon of Her Truth"
	dat = "gott.json"

/obj/item/book/rogue/bibble/zizo/attack(mob/living/M, mob/user)
	return

/obj/item/book/rogue/bibble/zizo/MiddleClick(mob/user, params)
	return

/obj/item/book/rogue/bibble/zizo/get_mechanics_examine(mob/user)
	return

/obj/item/book/rogue/bibble/zizo/read(mob/living/carbon/human/user)
	if(!open)
		to_chat(user, span_info("Open it first."))
		return FALSE
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		return
	if(in_range(user, src) || isobserver(user))
		user.changeNext_move(CLICK_CD_MELEE)
		var/list/verses = world.file2list("modular_twilight_axis/lore/strings/zizo.txt")
		var/m = tgui_input_list(user, "Which verse shall I read?", "DIVINE ENLIGHTENMENT", verses)
		if(m)
			user.say(m)
		else
			m = pick(verses)
			user.say(m)
