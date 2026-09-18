/obj/item/recipe_book/zizo
	name = "The Tome: ???"
	icon = 'modular_twilight_axis/lore/icons/books.dmi'
	icon_state = "zizo_guide_0"
	base_icon_state = "zizo_guide"
	wiki_name = "Book of Dark Rituals"
	types = list(
		/datum/ritual,
	)

/obj/item/recipe_book/zizo/proc/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return

/obj/item/recipe_book/zizo/attack_self(mob/user)
	if(!open)
		attack_right(user)
		return
	current_reader = user
	var/datum/recipe_wiki/wiki = get_recipe_wiki()
	wiki.show_to_user(user, types, wiki_name || name, /obj/item/recipe_book/zizo, TRUE)
	user.update_inv_hands()

/obj/item/recipe_book/zizo/rmb_self(mob/user, keybind)
	attack_right(user)
	return

/obj/item/recipe_book/zizo/read(mob/user)
	if(!open)
		to_chat(user, span_info("Open me first."))
		return FALSE

/obj/item/recipe_book/zizo/attack_right(mob/user)
	if(!open)
		slot_flags &= ~ITEM_SLOT_HIP
		open = TRUE
		playsound(loc, 'sound/items/book_open.ogg', 100, FALSE, -1)
	else
		slot_flags |= ITEM_SLOT_HIP
		open = FALSE
		playsound(loc, 'sound/items/book_close.ogg', 100, FALSE, -1)
	update_icon()
	user.update_inv_hands()

/obj/item/recipe_book/zizo/update_icon()
	icon_state = "[base_icon_state]_[open]"

/datum/ritual/proc/generate_html(mob/user)
	var/html = ""
	html += "<h2 class='recipe-title'>[name]</h2>"
	html += "<p>[desk]</p>"
	html += "<h3>Ritual Requirements:</h3>"
	html += "<ul>"

	if(center_requirement)
		if(center_book != null)
			html += "<li><b>Center:</b> [center_book]</li>"
		else if(ispath(center_requirement, /mob/living/carbon/human))
			html += "<li><b>Center:</b> Living Person</li>"
		else if(ispath(center_requirement, /mob))
			html += "<li><b>Center:</b> Living Animal</li>"
		else
			var/atom/center_item = new center_requirement()
			html += "<li><b>Center:</b> [icon2html(center_item, user)] [center_item.name]</li>"
			qdel(center_item)

	if(n_req)
		if(north_book != null)
			html += "<li><b>North:</b> [north_book]</li>"
		else if(ispath(n_req, /mob/living/carbon/human))
			html += "<li><b>North:</b> Living Person</li>"
		else if(ispath(n_req, /mob))
			html += "<li><b>North:</b> Living Animal</li>"
		else
			var/atom/n_item = new n_req()
			html += "<li><b>North:</b> [icon2html(n_item, user)] [n_item.name]</li>"
			qdel(n_item)

	if(e_req)
		if(east_book != null)
			html += "<li><b>East:</b> [east_book]</li>"
		else if(ispath(e_req, /mob/living/carbon/human))
			html += "<li><b>East:</b> Living person</li>"
		else if(ispath(e_req, /mob))
			html += "<li><b>East:</b> Living animal</li>"
		else
			var/atom/e_item = new e_req()
			html += "<li><b>East:</b> [icon2html(e_item, user)] [e_item.name]</li>"
			qdel(e_item)

	if(s_req)
		if(south_book != null)
			html += "<li><b>South:</b> [south_book]</li>"
		else if(ispath(s_req, /mob/living/carbon/human))
			html += "<li><b>South:</b> Living person</li>"
		else if(ispath(s_req, /mob))
			html += "<li><b>South:</b> Live animal</li>"
		else
			var/atom/s_item = new s_req()
			html += "<li><b>South:</b> [icon2html(s_item, user)] [s_item.name]</li>"
			qdel(s_item)

	if(w_req)
		if(west_book != null)
			html += "<li><b>West:</b> [west_book]</li>"
		else if(ispath(w_req, /mob/living/carbon/human))
			html += "<li><b>West:</b> Living person</li>"
		else if(ispath(w_req, /mob))
			html += "<li><b>West:</b> Live animal</li>"
		else
			var/atom/w_item = new w_req()
			html += "<li><b>West:</b> [icon2html(w_item, user)] [w_item.name]</li>"
			qdel(w_item)

	if(cultist_number > 0)
		html += "<li><b>Cultists required:</b> [cultist_number] (minimum)</li>"

	if(is_cultist_ritual)
		html += "<li><i>This ritual is available only to cultists.</i></li>"

	if(ritual_limit > 0)
		html += "<li><b>Limit:</b>Possible number of performed rituals: [ritual_limit]"
		if(number_cultist_for_add_limit > 0)
			html += "(+1 to the number for [number_cultist_for_add_limit] cultists)"
		html += ".</li>"

	html += "</ul>"
	html += "<p><em>Note: Place the items on the rune as specified in the requirements. The ritual will work upon activation if all requirements are met.</em></p>"
	return html
