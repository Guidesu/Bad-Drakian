#define GRAVITY 9.81
#define BASE_AZIMUTH_ERROR 16
#define OVERHEAT_ERROR 50

/obj/item/artillery_shell
	name = "Friend, if you saw this, then the admins/mappers are fools"
	icon = 'modular_twilight_axis/awful_artillery/icons/artillery.dmi'
	icon_state = "cannonball"
	

/obj/item/artillery_shell/proc/shell_action()

/obj/structure/artillery 
	name = "Friend, if you saw this, then the server admins are idiots"
	desc = "Smiley don't steal"

	icon = 'modular_twilight_axis/awful_artillery/icons/artillery.dmi'
	icon_state = "mortar"

	anchored = 0
	density = 1
	var/azimuth = 0 
	var/elevation = 0 
	var/elevation_min = 1
	var/elevation_max = 90

	var/charge_level = 0
	var/charge_min = 0
	var/charge_max = 5

	var/base_velocity = 5
	var/charge_velocity_step = 15

	var/ammo_type = /obj/item/artillery_shell

	var/obj/item/artillery_shell/ammo

	var/associated_skill = /datum/skill/combat/twilight_firearms
	var/associated_stat = STAT_INTELLIGENCE

	var/barrel_integrity = 15
	var/last_fired = 0
	var/cooldown  = 10 SECONDS

	var/no_expert_time_multiplier = 3

/obj/structure/artillery/Initialize()
	. = ..()
	barrel_integrity = rand(6, 14)
	charge_velocity_step = rand(8, 20)

	
/obj/structure/artillery/examine(mob/user)
	. = ..()
	if((world.time - last_fired) < cooldown)
		. += span_info("The barrel feels hot, it may not be worth taking a shot right now.")
	else 
		. += span_info("The barrel feels cold, you can fire a shot without any risks.")

	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/C = user
		var/perception = C.get_stat(STAT_PERCEPTION) - 10
		if(perception > 0 || HAS_TRAIT(user, TRAIT_ARTILLERY_EXPERT))
			if(((barrel_integrity - perception) < 1) || HAS_TRAIT(user, TRAIT_ARTILLERY_EXPERT))
				. += span_danger("My attentiveness allows me to find out that the barrel will be destroyed through [barrel_integrity] shots")
			else 
				. += span_green("The gun seems reliable. It will last at least a few more shots")
		else 
			. += span_green("The gun seems reliable. It will last at least a few more shots")

/obj/structure/artillery/attackby(obj/item/used_item, mob/user)
	if(istype(used_item, ammo_type))
		if(ammo)
			to_chat(usr, span_info("There is already a charge in the barrel"))
		else
			if(do_after(user, 20, target = src))
				used_item.forceMove(src)
				ammo = used_item
				to_chat(usr, span_info("I loaded the shell in [src.name]"))
				playsound(src, 'modular_twilight_axis/awful_artillery/sound/loading.ogg', 100, 0, 1, 1, null, null, FALSE, TRUE)
				log_game("[user] loaded artillery shell into [src]")

	if(istype(used_item, /obj/item/twilight_powderflask))
		if(ammo)
			to_chat(usr, span_info("There is a shell inside, I need to pull it out before adding gunpowder"))
		else
			playsound(src, 'modular_twilight_axis/awful_artillery/sound/powder.ogg', 100, 0, 1, 1, null, null, FALSE, TRUE)
			if(do_after(user, 20, target = src))
				to_chat(usr, span_info("I loaded [src.name] with gunpowder"))
				charge_level = min(charge_level + 1, charge_max)
				log_game("[user] added gun powder into [src]")

	return ..()


/obj/structure/artillery/proc/calculate_coordinates(mob/living/carbon/user)
	if(charge_level == 0)
		return
	
	var/user_stat = user.get_stat(associated_stat)
	var/user_skill = user.get_skill_level(associated_skill)

	var/velocity = base_velocity + charge_level * charge_velocity_step
	var/range = (velocity * velocity / GRAVITY) * sin(2 * elevation)

	var/overall_artillery_skill = user_skill + (user_stat - 10) / 2

	var/target_azimuth = azimuth
	
	if(!HAS_TRAIT(user, TRAIT_ARTILLERY_EXPERT))
		if(overall_artillery_skill < 5)
			target_azimuth += rand(-BASE_AZIMUTH_ERROR, BASE_AZIMUTH_ERROR)
		else if(overall_artillery_skill < 7)
			target_azimuth += rand(-BASE_AZIMUTH_ERROR/2, BASE_AZIMUTH_ERROR/2)
		else if(overall_artillery_skill < 10)
			target_azimuth += rand(-BASE_AZIMUTH_ERROR/4, BASE_AZIMUTH_ERROR/4)

	if((world.time - last_fired) < cooldown)
		range += rand(-OVERHEAT_ERROR, OVERHEAT_ERROR)
		target_azimuth += rand(-OVERHEAT_ERROR, OVERHEAT_ERROR)

	var/dx = range * sin(target_azimuth)
	var/dy = range * cos(target_azimuth)

	var/target_x = round(loc.x + dx)
	var/target_y = round(loc.y + dy)

	var/vector/target = vector(target_x, target_y)

	return target

/obj/structure/artillery/proc/fire_artillery(mob/user)
	var/mob/living/carbon/human/H = user
	if(charge_level == 0)
		to_chat(user, span_warning("There is no charge in the barrel"))
		return

	if(!ammo)
		to_chat(user, span_warning("There is no projectile in the barrel"))
		return

	if(!HAS_TRAIT(user, TRAIT_ARTILLERY_EXPERT))
		var/user_stat = H.get_stat(associated_stat)
		var/user_skill = H.get_skill_level(associated_skill)
		var/overall_artillery_skill = user_skill + (user_stat - 10) / 2
		var/rand_roll = rand(1, 20)

		if((rand_roll + overall_artillery_skill) < 12)
			user.visible_message(span_danger("[user] made a critical error when firing! [src] destroyed"))
			explosion(src, 1, 2, 4, flame_range = 2)
			H.adjustBruteLoss(150)
			return

	var/vector/hit_coordinates = calculate_coordinates(user)
	if(!hit_coordinates)
		to_chat(user, span_warning("Something prevents me from shooting there"))
		return
	var/turf/target = locate(hit_coordinates.x, hit_coordinates.y, src.z)
	if(!target)
		to_chat(user, span_warning("Something prevents me from shooting there"))
		return

	for(var/turf/AT in get_adjacent_turfs(src.loc))
		new/obj/effect/particle_effect/smoke/arquebus(AT)
		if(rand(1,10) > 7)
			for(var/turf/BT in get_adjacent_turfs(AT))
				new/obj/effect/particle_effect/smoke/arquebus(BT)

	var/x_mid = src.x + ((target.x - src.x) * 0.5)
	var/y_mid = src.y + ((target.y - src.y) * 0.5)
	var/z_mid = src.z + ((target.z - src.z) * 0.5)
	var/turf/turf_mid = locate(floor(x_mid), floor(y_mid), floor(z_mid))

	playsound(turf_mid, 'modular_twilight_axis/awful_artillery/sound/flyby.ogg', 100, 0, 50, 1, null, null, FALSE, TRUE)

	playsound(src, 'modular_twilight_axis/awful_artillery/sound/launch.ogg', 100, 0, 20, 1, null, null, FALSE, TRUE)

	ammo.forceMove(target)

	ammo.shell_action()
	
	ammo = null

	charge_level = 0


	if((world.time - last_fired) < cooldown)
		barrel_integrity -= 2
	else 
		barrel_integrity--
	last_fired = world.time
	
	user.visible_message(span_danger("[user] fires a shot from [src]!"))
	log_game("[user] fired artillery([src]) at [target.loc.name]([target.x] [target.y] [target.z])")
	message_admins("Artillery fired at [ADMIN_VERBOSEJMP(src.loc)] by [user] to [ADMIN_VERBOSEJMP(target)]")

	for(var/mob/M in GLOB.player_list)
		if(istype(M, /mob/living))
			var/message = "The sound of an artillery shot is heard"
			var/dist = get_dist(get_turf(src), M)
			if(dist > 15)
				message += "at a distance of about [floor(dist/15)*15] meters"
			if(M.z < src.z)
				message += "from somewhere above"
			if(M.z > src.z)
				message += "from somewhere below"

			var/dir = get_dir(M, src)
			switch(dir)
				if(NORTH)
					message += "from the north"
				if(SOUTH) 
					message += "from the south"
				if(EAST) 
					message += "from the east"
				if(WEST)
					message += "from the west"
				if(NORTHEAST) 
					message += "from the northeast"
				if(NORTHWEST) 
					message += "from the northwest"
				if(SOUTHEAST)  
					message += "from the southeast"
				if(SOUTHWEST)
					message += "from the southwest"
			
			message += "."
			to_chat(M, message)

	if(barrel_integrity <= 0)
		src.visible_message(span_danger("[src] explodes due to barrel wear!"))
		explosion(src, 1, 2, 10, flame_range = 3)

/obj/structure/artillery/proc/get_parts()
	return list()
	
/obj/structure/artillery/ui_interact(mob/user, datum/tgui/ui)
	if(!istype(user, /mob/living/carbon/human))
		return 

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Artillery", "Artillery")
		ui.open()

/obj/structure/artillery/ui_data(mob/user)
	var/list/data = list()
	data["elevation"] = elevation
	data["elevation_min"] = elevation_min
	data["elevation_max"] = elevation_max
	data["azimuth"] = azimuth
	data["charge_level"] = charge_level
	data["charge_max"] = charge_max

	var/vector/target = calculate_coordinates(user)
	if(target)
		var/turf/target_turf = locate(target.x, target.y, src.z)
		if(target_turf)
			var/velocity = base_velocity + charge_level * charge_velocity_step

			data["range"] = floor((velocity * velocity / GRAVITY) * sin(2 * elevation))

			data["area_name"] = target_turf.loc.name
		else 
			data["range"] = "UNKNOWN"
			data["area_name"] = "UNKNOWN"
	else
		data["range"] = "UNKNOWN"
		data["area_name"] = "UNKNOWN"


	return data

/obj/structure/artillery/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	switch(action)
		if("fire")
			if(charge_level == 0)
				to_chat(ui.user, span_warning("There is no charge in the barrel."))
				return
			if(!ammo)
				to_chat(ui.user, span_warning("There is no projectile in the barrel."))
				return
			if(HAS_TRAIT(ui.user, TRAIT_ARTILLERY_EXPERT))
				if(do_after(ui.user, 15, target = src))
					fire_artillery(ui.user)
			else
				if(tgui_alert(ui.user, "You do not know how to use this installation. At the moment you are relying solely on your guesses and intellect; if used incorrectly, very bad consequences can await you.", "Mortar", list("I will not shoot", "FIRE!")) == "FIRE!")
					if(do_after(ui.user, 15, target = src))
						fire_artillery(ui.user)
		if("decrease_charge")
			if(do_after(ui.user, 10, target = src))
				charge_level = max(charge_level - 1, charge_min)
				playsound(src, 'modular_twilight_axis/awful_artillery/sound/removepowder.ogg', 100, 1, 1, 1, null, null, FALSE, FALSE)
				ui.user.visible_message(span_info("[ui.user] extracts excess gunpowder from [src]."))
		if("set_elevation")
			elevation = params["value"]
			playsound(src, 'modular_twilight_axis/awful_artillery/sound/anglecorrection.ogg', 100, 1, 1, 1, null, null, FALSE, FALSE)
			ui.user.visible_message(span_info("[ui.user] rules the eminence."))
		if("set_azimuth")
			azimuth = params["value"]
			playsound(src, 'modular_twilight_axis/awful_artillery/sound/anglecorrection.ogg', 100, 1, 1, 1, null, null, FALSE, FALSE)
			ui.user.visible_message(span_info("[ui.user] corrects azimuth."))
		if("eject_ammo")
			if(do_after(ui.user, 20, target = src))
				playsound(src, 'modular_twilight_axis/awful_artillery/sound/anglecorrection.ogg', 100, 1, 1, 1, null, null, FALSE, FALSE)
				ammo.forceMove(loc)
				ammo = null
				ui.user.visible_message(span_info("[ui.user] removes ammunition from [src]."))
		if("disasseble")
			if(do_after(ui.user, 20, target = src))
				playsound(src, 'modular_twilight_axis/awful_artillery/sound/anglecorrection.ogg', 100, 1, 1, 1, null, null, FALSE, FALSE)
				var/list/parts =  get_parts()
				for(var/path in parts)
					new path(loc)
				ui.close()
				qdel(src)
				ui.user.visible_message(span_info("[ui.user] disassembled [src]."))

	SStgui.try_update_ui(ui.user, src)

/obj/item/artillery_assembly
	name = "Carriage"
	w_class = WEIGHT_CLASS_HUGE


#undef GRAVITY
#undef BASE_AZIMUTH_ERROR
#undef OVERHEAT_ERROR
