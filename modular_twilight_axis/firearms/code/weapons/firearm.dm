#define LOCKTYPE_WHEELLOCK "Wheellock"
#define LOCKTYPE_MATCHLOCK "Matchlock"
#define LOCKTYPE_FUSE "Fuse"
#define LOCKTYPE_BREECH "Breech"

/obj/item/twilight_ramrod
	name = "ramrod"
	icon = 'modular_twilight_axis/firearms/icons/arquebus_items.dmi'
	desc = "A ramrod used for reloading a firearm."
	icon_state = "ramrod"
	item_state = "ramrod"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 64
	grid_height = 32

/obj/item/twilight_powderflask_empty
	name = "powderflask"
	icon = 'modular_twilight_axis/firearms/icons/arquebus_items.dmi'
	desc = "A powder flask designed for convenient reloading of firearms. Currently contains no powder."
	icon_state = "powderflask"
	item_state = "powderflask"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 64
	grid_height = 32

/obj/item/twilight_powderflask
	name = "powderflask"
	icon = 'modular_twilight_axis/firearms/icons/arquebus_items.dmi'
	desc = "A powder flask designed for convenient reloading of firearms. Contains regular black powder."
	var/gunpowder = "black gunpowder"
	var/charges = 30
	var/spec_desc //Helps with powder's unique feature upon examine
	var/pour_sound = 'modular_twilight_axis/firearms/sound/pour_powder.ogg'
	var/fire_sounds = list(
		"modular_twilight_axis/firearms/sound/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/arquefire5.ogg"
		)
	var/obj/effect/particle_effect/smoke = /obj/effect/particle_effect/smoke/arquebus
	icon_state = "powderflask_black"
	item_state = "powderflask"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 64
	grid_height = 32

/obj/item/twilight_powderflask/examine(mob/user)
	. = ..()
	if(spec_desc)
		. += span_notice(spec_desc)
	. += span_notice("There is enough powder for [charges] reloads.")

/obj/item/twilight_powderflask/fyre
	name = "powderflask"
	desc = "A powder flask designed for convenient reloading of firearms. Contains incendiary powder that gives bullets an incendiary effect."
	spec_desc = "Ignites the target on impact."
	icon_state = "powderflask_fyre"
	smoke = /obj/effect/particle_effect/smoke/arquebus/fyre
	gunpowder = "fyrepowder"
	pour_sound = 'modular_twilight_axis/firearms/sound/fyrepowder/pour_powder.ogg'
	fire_sounds = list(
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire5.ogg")
	charges = 16

/obj/item/twilight_powderflask/thunder
	name = "powderflask"
	desc = "Powder pouch designed for convenient reloading of firearms. Contains thunder powder, giving bullets a stunning effect."
	spec_desc = "Slows down the target on impact, and also stuns it for a short period."
	icon_state = "powderflask_thunder"
	gunpowder = "thunderpowder"
	smoke = /obj/effect/particle_effect/smoke/arquebus/thunder
	pour_sound = 'modular_twilight_axis/firearms/sound/thunderpowder/pour_powder.ogg'
	fire_sounds = list(
		"modular_twilight_axis/firearms/sound/thunderpowder/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/thunderpowder/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/thunderpowder/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/thunderpowder/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/thunderpowder/arquefire5.ogg"
		)
	charges = 16

/obj/item/twilight_powderflask/terror
	name = "powderflask"
	desc = "Powder pouch designed for convenient reloading of firearms. Contains nightmare powder, making bullets more deadly against those whose will is weak."
	spec_desc = "Deals double damage to all non-player-controlled creatures."
	icon_state = "powderflask_terror"
	gunpowder = "terrorpowder"
	smoke = /obj/effect/particle_effect/smoke/arquebus/terror
	pour_sound = 'modular_twilight_axis/firearms/sound/terrorpowder/pour_powder.ogg'
	fire_sounds = list(
		"modular_twilight_axis/firearms/sound/terrorpowder/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/terrorpowder/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/terrorpowder/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/terrorpowder/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/terrorpowder/arquefire5.ogg"
		)
	charges = 20

/obj/item/twilight_powderflask/corrosive
	name = "powderflask"
	desc = "Powder pouch designed for convenient reloading of firearms. Contains corrosive powder, giving bullets the ability to corrode the target's armor."
	spec_desc = "Covers the target with acid, dealing periodic damage to armor and health."
	icon_state = "powderflask_corrosive"
	gunpowder = "corrosive gunpowder"
	smoke = /obj/effect/particle_effect/smoke/arquebus/corrosive
	pour_sound = 'modular_twilight_axis/firearms/sound/corrpowder/pour_powder.ogg'
	fire_sounds = list(
		"modular_twilight_axis/firearms/sound/corrpowder/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/corrpowder/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/corrpowder/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/corrpowder/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/corrpowder/arquefire5.ogg"
		)
	charges = 10

/obj/item/twilight_powderflask/arcyne
	name = "powderflask"
	desc = "Powder pouch designed for convenient reloading of firearms. Contains arcane powder, making weapons significantly more effective against mages."
	spec_desc = "Inflicts numbness on the target. If the target has a magical barrier, it will be instantly destroyed."
	icon_state = "powderflask_arcyne"
	gunpowder = "arcyne gunpowder"
	smoke = /obj/effect/particle_effect/smoke/arquebus/arcyne
	pour_sound = 'modular_twilight_axis/firearms/sound/arcynepowder/pour_powder.ogg'
	fire_sounds = list(
		"modular_twilight_axis/firearms/sound/arcynepowder/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/arcynepowder/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/arcynepowder/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/arcynepowder/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/arcynepowder/arquefire5.ogg"
		)
	charges = 10

/obj/item/twilight_powderflask/holyfyre
	name = "powderflask"
	desc = "Powder flask designed for convenient reloading of firearms. Contains sacred fire powder, blessed by a shard of the Sion comet, to mercilessly strike the enemies of the All-Father."
	spec_desc = "Ignites the target with holy fire on impact. The effect is enhanced against the undead."
	icon_state = "powderflask_holyfyre"
	gunpowder = "holy fyrepowder"
	smoke = /obj/effect/particle_effect/smoke/arquebus/fyre
	pour_sound = 'modular_twilight_axis/firearms/sound/fyrepowder/pour_powder.ogg'
	fire_sounds = list(
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire5.ogg"
		)
	charges = 16

/obj/item/twilight_powderflask/volf
	name = "powderflask"
	desc = "Powder flask designed for convenient reloading of firearms. Contains powder mixed with poisonous powders specially made for wolves. It has no blessings; its existence is as repulsive as the existence of rune wolves."
	spec_desc = "Weakens and blinds the target with poisonous fumes for several seconds."
	icon_state = "powderflask_psy"
	gunpowder = "psypowder"
	pour_sound = 'modular_twilight_axis/firearms/sound/fyrepowder/pour_powder.ogg'
	fire_sounds = list(
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire2.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire3.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire4.ogg",
		"modular_twilight_axis/firearms/sound/fyrepowder/arquefire5.ogg"
		)
	charges = 20

/obj/effect/particle_effect/smoke/arquebus
	name = "smoke"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke"
	pixel_x = -32
	pixel_y = -32
	opacity = FALSE
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	animate_movement = 0
	amount = 4
	lifetime = 4
	opaque = FALSE

/obj/effect/particle_effect/smoke/arquebus/fyre
	color = "#A66945"

/obj/effect/particle_effect/smoke/arquebus/thunder
	color = "#5C355C"

/obj/effect/particle_effect/smoke/arquebus/terror
	color = "#423030"

/obj/effect/particle_effect/smoke/arquebus/corrosive
	color = "#7D905E"

/obj/effect/particle_effect/smoke/arquebus/arcyne
	color = "#C487C8"

/obj/item/gun/ballistic/twilight_firearm
	name = "gunpowder weapon"
	desc = "IF YOU ARE SEEING THIS. REPORT THIS TO A DEV. "
	icon = 'modular_twilight_axis/firearms/icons/arquebus/arquebus.dmi'
	icon_state = "arquebus"
	item_state = "arquebus"
	force = 10
	force_wielded = 15
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, INTENT_GENERIC)
	internal_magazine = TRUE
	mag_type = /obj/item/ammo_box/magazine/internal/twilight_firearm
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_LONG
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	randomspread = 1
	spread = 0
	wdefense = 3
	can_parry = TRUE
	minstr = 6
	walking_stick = TRUE
	obj_flags = CAN_BE_HIT | UNIQUE_RENAME | CLAMP_BREAK
	experimental_onback = TRUE
	cartridge_wording = "bullet"
	load_sound = 'modular_twilight_axis/firearms/sound/musketload.ogg'
	fire_sound = 'modular_twilight_axis/firearms/sound/arquefire.ogg'
	anvilrepair = /datum/skill/craft/engineering
	smeltresult = /obj/item/ingot/steel
	bolt_type = BOLT_TYPE_NO_BOLT
	casing_ejector = FALSE
	associated_skill = /datum/skill/combat/staves
	//pickup_sound = 'sound/sheath_sounds/draw_from_holster.ogg'
	//sheathe_sound = 'sound/sheath_sounds/put_back_to_holster.ogg'
	equip_delay_self = 1 SECONDS
	unequip_delay_self = 1 SECONDS
	inv_storage_delay = 1 SECONDS
	var/spread_num = 10
	var/damfactor = 1
	var/critfactor = 1
	var/npcdamfactor = 2
	var/reloaded = FALSE
	var/silenced = FALSE
	var/breech_open = FALSE
	var/load_time = 50
	var/gunpowder
	var/powder_pour_sound
	var/list/powder_fire_sounds
	var/obj/effect/particle_effect/powder_smoke
	var/powder_per_reload = 1
	var/locktype = LOCKTYPE_MATCHLOCK
	var/match_delay = 10
	var/effective_range = 5
	var/obj/item/twilight_ramrod/myrod = null
	var/ramrod_busy = FALSE

	//Advanced icon stuff
	var/advanced_icon				//Default icon
	var/advanced_icon_r				//Cocked
	var/advanced_icon_s				//Fuse spent
	var/advanced_icon_f				//Fuse lit
	var/advanced_icon_norod			//Ramrod removed
	var/advanced_icon_r_norod		//Cocked and ramrod removed

/obj/item/gun/ballistic/twilight_firearm/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 6,"nx" = 7,"ny" = 6,"wx" = -2,"wy" = 3,"ex" = 1,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -43,"sturn" = 43,"wturn" = 30,"eturn" = -30, "nflip" = 0, "sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -1,"wx" = -8,"wy" = 2,"ex" = 8,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = -45,"sturn" = 45,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/gun/ballistic/twilight_firearm/Initialize()
	. = ..()
	if(locktype == LOCKTYPE_MATCHLOCK || locktype == LOCKTYPE_WHEELLOCK)
		myrod = new /obj/item/twilight_ramrod(src)

/obj/item/gun/ballistic/twilight_firearm/shoot_live_shot(mob/living/user as mob|obj, pointblank = 0, mob/pbtarget = null, message = 1)
	if(silenced)
		fire_sound = "modular_twilight_axis/firearms/sound/umbra_fire2.ogg"
	else if(length(powder_fire_sounds))
		fire_sound = pick(powder_fire_sounds)
	. = ..()

/obj/item/gun/ballistic/twilight_firearm/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	if(!(locktype == LOCKTYPE_MATCHLOCK || locktype == LOCKTYPE_WHEELLOCK))
		return
	if(ramrod_busy)
		return

	var/obj/item/twilight_ramrod/R = myrod
	if(!R || QDELETED(R) || R.loc != src)
		myrod = null
		to_chat(user, span_warning("There is no rod stowed in [src]!"))
		return

	ramrod_busy = TRUE
	myrod = null
	playsound(src, "sound/items/sharpen_short1.ogg", 100, FALSE)
	to_chat(user, span_warning("I draw the ramrod from [src]!"))
	user.put_in_hands(R)
	if(advanced_icon_norod)
		if(reloaded && advanced_icon_r_norod)
			icon = advanced_icon_r_norod
		else
			icon = advanced_icon_norod
	ramrod_busy = FALSE

/datum/intent/shoot/twilight_firearm
	ready_sound = "modular_twilight_axis/firearms/sound/musketcock.ogg"
	chargedrain = 0

/datum/intent/shoot/twilight_firearm/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 95
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		//per block
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 0.1
	return chargetime

/datum/intent/arc/twilight_firearm
	ready_sound = "modular_twilight_axis/firearms/sound/musketcock.ogg"
	chargetime = 1
	chargedrain = 0

/datum/intent/arc/twilight_firearm/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 90
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		//per block
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 1
	return chargetime

/obj/item/gun/ballistic/twilight_firearm/shoot_with_empty_chamber()
	playsound(src.loc, 'modular_twilight_axis/firearms/sound/musketcock.ogg', 100, FALSE)
	update_icon()

/obj/item/gun/ballistic/twilight_firearm/attack_self(mob/living/user)
	if(locktype == LOCKTYPE_BREECH)
		if(!reloaded)
			if(chambered)
				if(move_after(user, 1 SECONDS, target = user))
					playsound(src, "modular_twilight_axis/firearms/sound/musketcock.ogg",  100, FALSE)
					user.visible_message(span_notice("[user] has finished reloading [src]."))
					reloaded = TRUE
					breech_open = FALSE
					if(advanced_icon)
						icon = advanced_icon
			else if(breech_open == TRUE)
				if(move_after(user, 1 SECONDS, target = user))
					playsound(src, "modular_twilight_axis/firearms/sound/musketcock.ogg",  100, FALSE)
					to_chat(user, span_info("I close down the breech of [src]."))
					breech_open = FALSE
					if(advanced_icon)
						icon = advanced_icon
			else
				if(move_after(user, 1 SECONDS, target = user))
					playsound(src, "modular_twilight_axis/firearms/sound/musketcock.ogg",  100, FALSE)
					to_chat(user, span_info("I open up the breech of [src]."))
					breech_open = TRUE
					if(advanced_icon_f)
						icon = advanced_icon_f
		update_icon()
		return
	if(twohands_required)
		return
	if(altgripped || wielded) //Trying to unwield it
		ungrip(user)
		return
	if(alt_grips)
		altgrip(user)
	if(gripped_intents)
		wield(user)
	update_icon()

/obj/item/gun/ballistic/twilight_firearm/proc/handle_ramrod(obj/item/twilight_ramrod/R, mob/user, load_time_skill)
	if(!(locktype == LOCKTYPE_MATCHLOCK || locktype == LOCKTYPE_WHEELLOCK))
		return

	if(!reloaded && chambered)
		user.visible_message(span_notice("[user] begins ramming the [R.name] down the barrel of [src]."))
		playsound(src, "modular_twilight_axis/firearms/sound/ramrod.ogg", 100, FALSE)
		if(do_after(user, load_time_skill, src))
			user.visible_message(span_notice("[user] has finished reloading [src]."))
			reloaded = TRUE
			if(advanced_icon_r_norod)
				icon = advanced_icon_r_norod
		return

	if(myrod)
		to_chat(user, span_warning("There's already a [myrod.name] inside of the [name]."))
		return

	if(user.transferItemToLoc(R, src))
		myrod = R
		playsound(src, "modular_twilight_axis/firearms/sound/musketload.ogg", 100, FALSE)
		if(chambered)
			user.visible_message("<span class='notice'>[user] stows the [R.name] under the barrel of [src].</span>")
		else
			user.visible_message("<span class='notice'>[user] stows the [R.name] under the barrel of [src] without chambering it.</span>")
		if(advanced_icon)
			if(reloaded && advanced_icon_r)
				icon = advanced_icon_r
			else
				icon = advanced_icon

/obj/item/gun/ballistic/twilight_firearm/attackby(obj/item/A, mob/user, params)
	var/firearm_skill = (user?.mind ? user.get_skill_level(/datum/skill/combat/twilight_firearms) : 1)
	var/load_time_skill = load_time - (firearm_skill*5)

	if(istype(A, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/V = A
		if(chambered)
			to_chat(user, span_warning("There is already a [chambered.name] in [src]!"))
			return
		if(!gunpowder && !(V.breech_loaded))
			to_chat(user, span_warning("I must fill [src] with gunpowder first!"))
			return
		if(V.caliber != magazine.caliber)
			to_chat(user, span_warning("\The [V.name] doesn't fit into [src]!"))
			return
		if(V.breech_loaded && locktype != LOCKTYPE_BREECH)
			to_chat(user, span_warning("\The [V.name] can only be loaded into breech-loaded weapons!"))
			return
		if((loc == user) && (user.get_inactive_held_item() != src) && !(V.breech_loaded))
			return
		if (bolt_type == BOLT_TYPE_NO_BOLT || internal_magazine)
			if(locktype == LOCKTYPE_BREECH)
				if(breech_open == TRUE)
					if(istype(V, /obj/item/ammo_casing/caseless/rogue/twilight_lead/paper))
						playsound(src, "modular_twilight_axis/firearms/sound/puffer_reload.ogg",  100, FALSE)
					to_chat(user, span_info("I begin loading [src]..."))
					if(move_after(user, load_time_skill, target = user))
						if(chambered && !chambered.BB)
							to_chat(user, span_warning("I clear [src] and load it with a new [V.name]."))
							chambered.forceMove(drop_location())
							chambered = null
						var/num_loaded = magazine.attackby(A, user, params, TRUE)
						if (num_loaded)
							playsound(src, "modular_twilight_axis/firearms/sound/insert.ogg",  100, FALSE)
							user.visible_message(span_notice("[user] inserts [V.name] into the breech of [src]."))
							if(!gunpowder)
								gunpowder = "black gunpowder"
							if (chambered == null && bolt_type == BOLT_TYPE_NO_BOLT)
								chamber_round()
							if(advanced_icon_r)
								icon = advanced_icon_r
							A.update_icon()
							update_icon()
					else
						to_chat(user, span_warning("I fumble the reload, dropping the [V.name]!"))
						V.forceMove(drop_location())
						return
				else
					to_chat(user, span_info("I must open the breech first!"))
					return
			else
				if (chambered && !chambered.BB)
					chambered.forceMove(drop_location())
					chambered = null
				var/num_loaded = magazine.attackby(A, user, params, TRUE)
				if (num_loaded)
					playsound(src, "modular_twilight_axis/firearms/sound/insert.ogg",  100, FALSE)
					user.visible_message(span_notice("[user] forces a [V.name] down the barrel of [src]."))
					if(advanced_icon)
						if(!myrod && advanced_icon_norod)
							icon = advanced_icon_norod
						else
							icon = advanced_icon
					if (chambered == null && bolt_type == BOLT_TYPE_NO_BOLT)
						chamber_round()
					A.update_icon()
					update_icon()
			return
		user.update_inv_hands()
		return
	else if(istype(A, /obj/item/twilight_powderflask))
		var/obj/item/twilight_powderflask/W = A
		if(gunpowder)
			user.visible_message(span_notice("[name] is already filled with gunpowder!"))
			return
		else if(W.charges < powder_per_reload)
			user.visible_message(span_notice("[W.name] doesn't contain enough gunpowder to reload [src]!"))
			return
		else if(locktype == LOCKTYPE_BREECH && !(breech_open))
			to_chat(user, span_info("I must open the breech first!"))
			return
		else
			playsound(src, W.pour_sound, 100, FALSE)
			if(do_after(user, load_time_skill, src))
				user.visible_message(span_notice("[user] fills [src] with [W.gunpowder]."))
				gunpowder = W.gunpowder
				powder_pour_sound = W.pour_sound
				powder_fire_sounds = W.fire_sounds
				powder_smoke = W.smoke
				W.charges = W.charges - powder_per_reload
				if(W.charges <= 0)
					qdel(W)
					var/obj/item/twilight_powderflask_empty/E = new /obj/item/twilight_powderflask_empty(get_turf(user))
					user.put_in_hands(E)
			return
	else if(istype(A, /obj/item/twilight_ramrod))
		if(ramrod_busy)
			return
		ramrod_busy = TRUE
		handle_ramrod(A, user, load_time_skill)
		ramrod_busy = FALSE
		return
	else if(istype(A, /obj/item/natural/bundle/fibers))
		var/obj/item/natural/bundle/fibers/W = A
		if(locktype == LOCKTYPE_FUSE)
			if(!reloaded)
				if(chambered)
					user.visible_message(span_notice("[user] begins attaching the fuse to [src]."))
					playsound(src, "sound/foley/bandage.ogg",  100, FALSE)
					if(do_after(user, (load_time_skill * 0.8), src))
						user.visible_message(span_notice("[user] has finished reloading [src]."))
						W.amount = W.amount - 1
						if(W.amount == 1)
							new /obj/item/natural/fibers(get_turf(user))
							qdel(W)
						reloaded = TRUE
						if(advanced_icon_r)
							icon = advanced_icon_r
					return
	else if(istype(A, /obj/item/natural/fibers))
		if(locktype == LOCKTYPE_FUSE)
			if(!reloaded)
				if(chambered)
					user.visible_message(span_notice("[user] begins attaching the fuse to [src]."))
					playsound(src, "sound/foley/bandage.ogg",  100, FALSE)
					if(do_after(user, (load_time_skill * 0.8), src))
						user.visible_message(span_notice("[user] has finished reloading [src]."))
						qdel(A)
						reloaded = TRUE
						if(advanced_icon_r)
							icon = advanced_icon_r
					return
	else
		. = ..()

/obj/item/gun/ballistic/twilight_firearm/examine(mob/user)
	. = ..()
	if(gunpowder)
		if(chambered)
			if(reloaded)
				. += span_notice("Cocked and ready to fire.")
			else
				. += span_notice("A bullet is visible inside the weapon, but it is not cocked.")
		else
			. += span_notice("Gunpowder charge is visible through the vent, but the bullet is not set.")
	else
		. += span_notice("Not loaded.")

/obj/item/gun/ballistic/twilight_firearm/get_mechanics_examine(mob/user)
	. = ..()
	. += span_info("The aiming range of this weapon [effective_range]0 meters.")
	switch(locktype)
		if(LOCKTYPE_WHEELLOCK)
			. += span_info("Wheel locks require a gunpowder charge, a bullet, and ramming the charge with a ramrod before firing.")
		if(LOCKTYPE_MATCHLOCK)
			. += span_info("Firing locks require a gunpowder charge, a bullet, and ramming the charge with a ramrod before firing.")
		if(LOCKTYPE_FUSE)
			. += span_info("Matchlocks require a gunpowder charge, a bullet, and a lit match installed before firing.")
		if(LOCKTYPE_BREECH)
			. += span_info("Breech-loading locks require a cartridge, after which the breech must be closed and the lock cocked.")

/obj/item/gun/ballistic/twilight_firearm/proc/spawn_muzzle_smoke(mob/living/user, atom/target)
	if(silenced)
		return
	var/shoot_dir = get_dir(src, target)
	spawn()
		for(var/i=1,i<=4,i++)
			sleep(rand(0.1, 0.4))
			new /obj/effect/temp_visual/small_smoke/gunsmoke(get_step(user, shoot_dir), shoot_dir)

/obj/item/gun/ballistic/twilight_firearm/handgonne/spawn_muzzle_smoke(mob/living/user, atom/target)
	if(silenced)
		return
	var/shoot_dir = get_dir(src, target)
	new /obj/effect/temp_visual/small_smoke/gunsmoke(get_turf(user), shoot_dir, 3)
	spawn(3)
		new /obj/effect/temp_visual/small_smoke/gunsmoke(get_turf(user), shoot_dir, 2)

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/mortar/spawn_muzzle_smoke(mob/living/user, atom/target)
	if(silenced)
		return
	var/shoot_dir = get_dir(src, target)
	new /obj/effect/temp_visual/small_smoke/gunsmoke(get_turf(user), shoot_dir, 3)
	spawn(3)
		new /obj/effect/temp_visual/small_smoke/gunsmoke(get_turf(user), shoot_dir, 2)

/obj/item/gun/ballistic/twilight_firearm/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(chambered && HAS_TRAIT(user, TRAIT_PACIFISM))
		if(chambered.harmful)
			to_chat(user, span_warning("[src] is lethally chambered! You don't want to risk harming anyone..."))
			return
	var/accident_chance = 0
	var/firearm_skill = (user?.mind ? user.get_skill_level(/datum/skill/combat/twilight_firearms) : 1)
	var/turf/knockback = get_ranged_target_turf(user, turn(user.dir, 180), rand(1,2))
	spread = (spread_num - firearm_skill)
	accident_chance = max(0, (70 - 20 * firearm_skill) )
	if(user.client)
		if(user.client.chargedprog >= 100)
			spread = 0
		else
			spread = 150 - (150 * (user.client.chargedprog / 100))
	else
		spread = 0
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/bullet/BB = CB.BB
		BB.gunpowder = gunpowder
	reloaded = FALSE
	if(advanced_icon)
		if(!myrod && advanced_icon_norod)
			icon = advanced_icon_norod
		else
			icon = advanced_icon
	spark_act()
	if(locktype == LOCKTYPE_MATCHLOCK || locktype == LOCKTYPE_WHEELLOCK || locktype == LOCKTYPE_BREECH)
		..()
		spawn_muzzle_smoke(user, target)
		if(!silenced)
			var/obj/effect/particle_effect/effect_to_spawn = powder_smoke
			spawn (5)
				new effect_to_spawn(get_ranged_target_turf(user,user.dir,1))
			spawn (10)
				new effect_to_spawn(get_ranged_target_turf(user, user.dir,2))
			spawn(16)
				new effect_to_spawn(get_ranged_target_turf(user, user.dir, 1))
		for(var/mob/M in range(5, user))
			if(!M.stat)
				shake_camera(M, 3, 1)

		gunpowder = null
		powder_pour_sound = null
		powder_fire_sounds = null
		powder_smoke = null
		if(prob(accident_chance) && bigboy)
			user.flash_fullscreen("whiteflash")
			user.apply_damage(rand(5,15), BURN, pick(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_NOSE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
			user.visible_message("<span class='danger'>[user] accidentally burnt themselves while firing the [src].</span>")
			user.emote("painscream")
			if(prob(60) && firearm_skill < 4)
				user.dropItemToGround(src)
				user.Knockdown(rand(15,30))
				user.Immobilize(30)
		if(prob(accident_chance) && bigboy)
			user.visible_message("<span class='danger'>[user] is knocked back by the recoil!</span>")
			user.throw_at(knockback, rand(1,2), 7)
			if(prob(accident_chance) && firearm_skill < 4)
				user.dropItemToGround(src)
				user.Knockdown(rand(15,30))
				user.Immobilize(30)
				if(firearm_skill < 3 && prob(50))
					var/def_zone = "[(user.active_hand_index == 2) ? "r" : "l" ]_arm"
					var/obj/item/bodypart/BP = user.get_bodypart(def_zone)
					BP.add_wound(/datum/wound/dislocation)
	else if(locktype == LOCKTYPE_FUSE)
		if(advanced_icon_f)
			icon = advanced_icon_f
		playsound(src, "modular_twilight_axis/firearms/sound/fuse.ogg", 100, FALSE)
		spawn(match_delay)
			spawn_muzzle_smoke(user, target)
			..()
			if(advanced_icon_s)
				icon = advanced_icon_s

			if(!silenced)
				var/obj/effect/particle_effect/effect_to_spawn = powder_smoke
				spawn (1)
					new effect_to_spawn(get_ranged_target_turf(user, user.dir, 1))
				spawn (5)
					new effect_to_spawn(get_ranged_target_turf(user, user.dir, 2))
				spawn (12)
					new effect_to_spawn(get_ranged_target_turf(user, user.dir, 1))

			gunpowder = null
			powder_pour_sound = null
			powder_fire_sounds = null
			powder_smoke = null
			for(var/mob/M in range(5, user))
				if(!M.stat)
					shake_camera(M, 3, 1)
			if(prob(accident_chance) && bigboy)
				user.flash_fullscreen("whiteflash")
				user.apply_damage(rand(5,15), BURN, pick(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_NOSE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
				user.visible_message(span_danger("[user] accidentally burnt themselves while firing the [src]."))
				user.emote("painscream")
				if(prob(60) && firearm_skill < 4)
					user.dropItemToGround(src)
					user.Knockdown(rand(15,30))
					user.Immobilize(30)
			if(prob(accident_chance) && bigboy)
				user.visible_message(span_danger("[user] is knocked back by the recoil!"))
				user.throw_at(knockback, rand(1,2), 7)
				if(prob(accident_chance) && firearm_skill < 4)
					user.dropItemToGround(src)
					user.Knockdown(rand(15,30))
					user.Immobilize(30)
					if(firearm_skill <= 2 && prob(50))
						var/def_zone = "[(user.active_hand_index == 2) ? "r" : "l" ]_arm"
						var/obj/item/bodypart/BP = user.get_bodypart(def_zone)
						BP.add_wound(/datum/wound/dislocation)

/obj/item/gun/ballistic/twilight_firearm/can_shoot()
	if (!reloaded)
		return FALSE
	return ..()

/obj/item/ammo_box/magazine/internal/twilight_firearm
	name = "firearm internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/twilight_lead
	caliber = "lead_sphere"
	max_ammo = 1
	start_empty = TRUE

/obj/item/gun/ballistic/twilight_firearm/arquebus
	name = "arquebus rifle"
	desc = "Second-generation gunpowder weapons, firing armor-piercing lead bullets."
	icon = 'modular_twilight_axis/firearms/icons/arquebus/arquebus.dmi'
	icon_state = "arquebus"
	item_state = "arquebus"
	advanced_icon = 'modular_twilight_axis/firearms/icons/arquebus/arquebus.dmi'
	advanced_icon_norod = 'modular_twilight_axis/firearms/icons/arquebus/arquebus_norod.dmi'
	effective_range = 7

/obj/item/gun/ballistic/twilight_firearm/arquebus/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/huntingknife))
		user.visible_message(span_warning("[user] starts attaching a bayonet to [src]."))
		if(do_after(user, 6 SECONDS))
			var/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/P = new /obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
				user.put_in_hands(P)
			P.obj_integrity = src.obj_integrity
			qdel(src)
			qdel(I)
		else
			user.visible_message(span_warning("[user] stops attaching the bayonet to [src]."))
		return TRUE
	return ..()

/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet
	name = "arquebus rifle"
	desc = "Second-generation gunpowder weapons, firing armor-piercing lead bullets. Equipped with a bayonet for use in close combat."
	icon = 'modular_twilight_axis/firearms/icons/arquebus/arquebusbaoynet.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/arquebus/arquebusbaoynet.dmi'
	advanced_icon_norod = 'modular_twilight_axis/firearms/icons/arquebus/arquebusbayonet_norod.dmi'
	gripped_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, INTENT_GENERIC, /datum/intent/spear/thrust/militia)
	sharpness = IS_SHARP
	max_blade_int = 180
	wdefense = 5

/obj/item/gun/ballistic/twilight_firearm/arquebus/decorated
	name = "decorated arquebus rifle"
	desc = "A true work of art in the form of a firearm. The stock and fore-end of the arquebus are decorated with gold plates and an inlaid ruby, and on the barrel is engraved the inscription: 'Behold my deeds and tremble'."
	icon = 'modular_twilight_axis/firearms/icons/arquebus/decorated_arquebus.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/arquebus/decorated_arquebus.dmi'
	advanced_icon_norod = 'modular_twilight_axis/firearms/icons/arquebus/decorated_arquebus_norod.dmi'
	sellprice = 325

/obj/item/gun/ballistic/twilight_firearm/arquebus/decorated/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/huntingknife))
		user.visible_message(span_warning("[user] starts attaching a bayonet to [src]."))
		if(do_after(user, 6 SECONDS))
			var/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/decorated/P = new /obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/decorated(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
				user.put_in_hands(P)
			P.obj_integrity = src.obj_integrity
			qdel(src)
			qdel(I)
		else
			user.visible_message(span_warning("[user] stops attaching the bayonet to [src]."))
		return TRUE
	return ..()

/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/decorated
	name = "decorated arquebus rifle"
	desc = "A true work of art in the form of a firearm. The stock and fore-end of the arquebus are adorned with gold plates and an inlaid ruby, and the barrel is engraved with the inscription: 'Behold my deeds and tremble.' Equipped with a bayonet for close combat use."
	icon = 'modular_twilight_axis/firearms/icons/arquebus/decorated_arquebus_bayonet.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/arquebus/decorated_arquebus_bayonet.dmi'
	advanced_icon_norod = 'modular_twilight_axis/firearms/icons/arquebus/decorated_arquebus_bayonet_norod.dmi'
	sellprice = 325

/obj/item/gun/ballistic/twilight_firearm/arquebus/jagerrifle
	name = "\"Jägerbüchse\""
	desc = "A rare type of wheellock arquebus, made by Grenzelhoft masters for the Freikorps rangers who distinguished themselves in combat. Lighter and less prone to wear compared to standard models."
	icon = 'modular_twilight_axis/firearms/icons/arquebus/jagerrifle.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/arquebus/jagerrifle.dmi'
	advanced_icon_norod = 'modular_twilight_axis/firearms/icons/arquebus/jagerrifle_norod.dmi'
	locktype = LOCKTYPE_WHEELLOCK

/obj/item/gun/ballistic/twilight_firearm/arquebus/jagerrifle/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/huntingknife))
		user.visible_message(span_warning("[user] starts attaching a bayonet to [src]."))
		if(do_after(user, 6 SECONDS))
			var/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/jagerrifle/P = new /obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/jagerrifle(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
				user.put_in_hands(P)
			P.obj_integrity = src.obj_integrity
			qdel(src)
			qdel(I)
		else
			user.visible_message(span_warning("[user] stops attaching the bayonet to [src]."))
		return TRUE
	return ..()

/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/jagerrifle
	name =  "\"Jägerbüchse\""
	desc = "A rare type of wheellock arquebus, made by Grenzelhoft masters for the Freikorps rangers who distinguished themselves in combat. Lighter and less prone to wear compared to standard models. Equipped with a bayonet for close combat use."
	icon = 'modular_twilight_axis/firearms/icons/arquebus/jagerriflebayonet.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/arquebus/jagerriflebayonet.dmi'
	advanced_icon_norod = 'modular_twilight_axis/firearms/icons/arquebus/jagerrifle_bayonet_norod.dmi'
	locktype = LOCKTYPE_WHEELLOCK

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol
	name = "arquebus pistol"
	desc = "Small gunpowder weapon, firing armor-piercing lead bullets. The shorter barrel length negatively affects firepower, but the pistol design is more compact and can be worn on the hip."
	icon = 'modular_twilight_axis/firearms/icons/pistol/pistol.dmi'
	icon_state = "pistol"
	item_state = "pistol"
	pixel_y = 0
	pixel_x = 0
	force = 10
	possible_item_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, /datum/intent/mace/strike/wood)
	associated_skill = /datum/skill/combat/maces
	gripped_intents = null
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HIP
	walking_stick = FALSE
	bigboy = FALSE
	gripsprite = FALSE
	cartridge_wording = "bullet"
	effective_range = 3
	wdefense = 0
	advanced_icon = 'modular_twilight_axis/firearms/icons/pistol/pistol.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/pistol/pistol_r.dmi'
	advanced_icon_norod	= 'modular_twilight_axis/firearms/icons/pistol/pistol_norod.dmi'
	advanced_icon_r_norod = 'modular_twilight_axis/firearms/icons/pistol/pistol_r_norod.dmi'
	locktype = LOCKTYPE_WHEELLOCK

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -10,"sy" = -4,"nx" = 10,"ny" = -4,"wx" = -4,"wy" = -4,"ex" = 2,"ey" = -4, "northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 30,"sturn" = -30,"wturn" = -30,"eturn" = 30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/umbra
	name = "\"Umbra\""
	desc = "Compact firearm of Otavan manufacture. The barrel is made of blued steel, on which several simple runes are engraved. Thanks to its unusual design and runic magic, Umbra fires almost silently, making it an ideal choice for Inquisition agents."
	silenced = TRUE
	critfactor = 1
	icon = 'modular_twilight_axis/firearms/icons/umbra/pistol.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/umbra/pistol.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/umbra/pistol_r.dmi'
	advanced_icon_norod	= 'modular_twilight_axis/firearms/icons/umbra/pistol_norod.dmi'
	advanced_icon_r_norod = 'modular_twilight_axis/firearms/icons/umbra/pistol_r_norod.dmi'
	effective_range = 5

/obj/item/gun/ballistic/twilight_firearm/handgonne
	name = "culverin"
	desc = "Heavy gunpowder weapon, firing large lead balls. The important factor is not the barrel size, but the size of the hole it makes in your opponent."
	icon = 'modular_twilight_axis/firearms/icons/handgonne/handgonne.dmi'
	icon_state = "handgonne"
	item_state = "handgonne"
	mag_type = /obj/item/ammo_box/magazine/internal/twilight_firearm/handgonne
	cartridge_wording = "cannonball"
	locktype = LOCKTYPE_FUSE
	advanced_icon = 'modular_twilight_axis/firearms/icons/handgonne/handgonne.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/handgonne/handgonne_r.dmi'
	advanced_icon_f	= 'modular_twilight_axis/firearms/icons/handgonne/handgonne_f.dmi'
	advanced_icon_s = 'modular_twilight_axis/firearms/icons/handgonne/handgonne_s.dmi'
	npcdamfactor = 3

/obj/item/ammo_box/magazine/internal/twilight_firearm/handgonne
	name = "handgonne internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/twilight_cannonball
	caliber = "cannonball"
	max_ammo = 1
	start_empty = TRUE

/obj/item/gun/ballistic/twilight_firearm/flintgonne
	name = "hakenbüchse"
	desc = "First-generation gunpowder weapon, mass-produced by Grenzelhoft. Made from cheap, quickly wearing materials, which negatively affects its lethality."
	icon = 'modular_twilight_axis/firearms/icons/flintgonne.dmi'
	icon_state = "flintgonne"
	item_state = "flintgonne"
	gripped_intents = list(/datum/intent/shoot/twilight_firearm/flintgonne, /datum/intent/arc/twilight_firearm/flintgonne, INTENT_GENERIC)
	smeltresult = /obj/item/ingot/iron
	damfactor = 0.9
	effective_range = 5

/obj/item/gun/ballistic/twilight_firearm/axtgonne
	name = "axtbüchse"
	desc = "A handcrafted first-generation firearm that gained popularity among the rangers of Grenzelhoft during the Twilight War. An axe blade is attached to the weapon's barrel."
	icon = 'modular_twilight_axis/firearms/icons/axtbuchse/axtbuchse.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/axtbuchse/axtbuchse.dmi'
	advanced_icon_norod	= 'modular_twilight_axis/firearms/icons/axtbuchse/axtbuchse_norod.dmi'
	icon_state = "axegun"
	item_state = "axegun"
	damfactor = 0.9
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop)
	gripped_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, /datum/intent/axe/cut/long, /datum/intent/axe/chop/long)
	sharpness = IS_SHARP
	max_blade_int = 180
	associated_skill = /datum/skill/combat/axes

/obj/item/gun/ballistic/twilight_firearm/axtgonne/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 0,"nx" = 7,"ny" = 0,"wx" = -2,"wy" = 0,"ex" = 1,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -93,"sturn" = -93,"wturn" = 90,"eturn" = 90, "nflip" = 0, "sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -1,"wx" = -8,"wy" = -2,"ex" = 8,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = -15,"sturn" = 15,"wturn" = -15,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 0,"nx" = 0,"ny" = 0,"wx" = 2,"wy" = 0,"ex" = 0,"ey" = 0,"nturn" = 45,"sturn" = -45,"wturn" = 45,"eturn" = -45,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/datum/intent/shoot/twilight_firearm/flintgonne/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		newtime = newtime + 105
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 5
	return chargetime

/datum/intent/arc/twilight_firearm/flintgonne/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		newtime = newtime + 100
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 1
	return chargetime

/obj/item/gun/ballistic/twilight_firearm/barker
	name = "barker"
	desc = "One of the first firearms created by Otavan masters in the early 19th century. Due to its low power and accuracy, it is now primarily used by hunters."
	icon = 'modular_twilight_axis/firearms/icons/barker.dmi'
	icon_state = "barker"
	item_state = "barker"
	gripped_intents = list(/datum/intent/shoot/twilight_firearm/flintgonne, /datum/intent/arc/twilight_firearm/flintgonne, INTENT_GENERIC)
	locktype = LOCKTYPE_FUSE
	smeltresult = /obj/item/ingot/iron
	damfactor = 0.7
	critfactor = 0.3
	npcdamfactor = 4
	effective_range = 3
	match_delay = 4

/obj/item/gun/ballistic/twilight_firearm/handgonne/purgatory
	name = "\"Purgatory\""
	desc = "Advanced firearm of the Otavan Order of Black Powder, which earned a sinister reputation on the battlefield due to its destructive power. This handheld cannon comes into play when a single measure against heresy is simply not enough."
	icon = 'modular_twilight_axis/firearms/icons/purgatory/purgatory.dmi'
	icon_state = "purgatory"
	item_state = "purgatory"
	advanced_icon = 'modular_twilight_axis/firearms/icons/purgatory/purgatory.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/purgatory/purgatory_r.dmi'
	advanced_icon_f	= 'modular_twilight_axis/firearms/icons/purgatory/purgatory_f.dmi'
	advanced_icon_s = 'modular_twilight_axis/firearms/icons/purgatory/purgatory_s.dmi'
	gripped_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, INTENT_GENERIC, /datum/intent/spear/thrust/militia)
	smeltresult = /obj/item/ingot/silver
	sharpness = IS_SHARP
	max_blade_int = 180
	is_silver = TRUE
	force = 15
	force_wielded = 20
	wdefense = 5
	match_delay = 8

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/mortar
	name = "hand mortar"
	desc = "A handheld mortar with a bronze barrel, additionally secured to the carriage with a sturdy leather strap. Fires shot and cannonballs at short distances and with less force. Such weapons were often used by privateers under the flags of Grenzelhoft."
	pixel_y = 0
	pixel_x = 0
	damfactor = 0.8
	npcdamfactor = 2
	mag_type = /obj/item/ammo_box/magazine/internal/twilight_firearm/mortar
	cartridge_wording = "cannonball"
	smeltresult = /obj/item/ingot/bronze
	icon_state = "mortar"
	item_state = "mortar"
	icon = 'modular_twilight_axis/firearms/icons/mortar/mortar.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/mortar/mortar.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/mortar/mortar_r.dmi'
	advanced_icon_norod	= 'modular_twilight_axis/firearms/icons/mortar/mortar_norod.dmi'
	advanced_icon_r_norod = 'modular_twilight_axis/firearms/icons/mortar/mortar_r_norod.dmi'
	pixel_y = 0
	pixel_x = 0

/obj/item/ammo_box/magazine/internal/twilight_firearm/mortar
	name = "mortar internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/twilight_cannonball/grapeshot
	caliber = "cannonball"
	max_ammo = 1
	start_empty = TRUE

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/mortar/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 30,"sturn" = -30,"wturn" = -30,"eturn" = 30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/gun/ballistic/twilight_firearm/barker/barker_light
	name = "barker with lamptern"
	desc = "One of the first samples of firearms, created by Otavan masters at the beginning of the 19th century. Due to low power and accuracy, it is now mainly used by hunters. This one now comes with a flashlight!"
	icon = 'modular_twilight_axis/firearms/icons/barker_light.dmi'
	icon_state = "barker_light"
	item_state = "barker_light"
	light_system = MOVABLE_LIGHT
	light_outer_range = 7
	light_power = 1
	light_color = "#f5a885"

/obj/item/gun/ballistic/twilight_firearm/barker/barker_light/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 6,"nx" = 7,"ny" = 6,"wx" = -2,"wy" = 3,"ex" = 1,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -43,"sturn" = 43,"wturn" = 30,"eturn" = -30, "nflip" = 0, "sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -1,"wx" = -8,"wy" = 2,"ex" = 8,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = -45,"sturn" = 45,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = -15,"eturn" = -70,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 6,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/gun/ballistic/twilight_firearm/hunt_arquebus
	name = "hunting arquebus"
	desc = "A fairly convenient version of a wheel-lock arquebus with a bayonet, quite thin and long to be used as a spear. The extended barrel allows shooting at long distances, but takes away a good portion of the bullet's lethal power. A frequent choice among the nobility."
	damfactor = 0.7
	critfactor = 0.4
	npcdamfactor = 4
	effective_range = 4
	wdefense = 5
	walking_stick = FALSE
	sharpness = IS_SHARP
	max_blade_int = 180
	gripped_intents = list(/datum/intent/shoot/twilight_firearm/flintgonne, /datum/intent/arc/twilight_firearm/flintgonne, /datum/intent/spear/thrust, INTENT_GENERIC)
	icon_state = "harquebus"
	item_state = "harquebus"
	icon = 'modular_twilight_axis/firearms/icons/harquebus/harquebus.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/harquebus/harquebus.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/harquebus/harquebus_r.dmi'
	advanced_icon_norod	= 'modular_twilight_axis/firearms/icons/harquebus/harquebus_norod.dmi'
	advanced_icon_r_norod = 'modular_twilight_axis/firearms/icons/harquebus/harquebus_r_norod.dmi'

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/puffer
	name = "puffer"
	desc = "Compact firearms of Otavan manufacture, designed for shooting from the saddle. Made with a non-standard breech-loading system and can be loaded with paper cartridges, allowing a rider to prepare it for firing with one hand."
	icon = 'modular_twilight_axis/firearms/icons/puffer/pistol.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/puffer/pistol.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/puffer/pistol_r.dmi'
	advanced_icon_f = 'modular_twilight_axis/firearms/icons/puffer/pistol_f.dmi'
	advanced_icon_norod	= null
	advanced_icon_r_norod = null
	effective_range = 5
	locktype = LOCKTYPE_BREECH
