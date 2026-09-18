#define BLOODLOCK_AWAKEN_TIME 90 SECONDS
#define BLOODLOCK_LOSS_TIME 120 SECONDS
#define BLOODLOCK_VITAE_PER_DRINK 90
#define BLOODLOCK_PHRASE_TIME 1200 SECONDS

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock
	name = "bloodlock rifle"
	desc = "A weapon forged by dark elves, deep in the darkness of the Underdark. Looks..</br><font color='FF0000'>..alive?</font>"
	icon = 'modular_twilight_axis/firearms/icons/bloodlock.dmi'
	icon_state = "bloodlock"
	icon_state_ready = "bloodlock_r"
	default_icon_state = "bloodlock"
	item_state = "bloodlock"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/twilight_bloodlock
	load_sound = 'modular_twilight_axis/firearms/sound/musketload.ogg'
	obj_flags = CAN_BE_HIT | CLAMP_BREAK
	anvilrepair = null
	smeltresult = /obj/item/ingot/component/zizo
	damfactor = 1.1
	reload_stamina_cost = 0
	var/list/weighted_fire_sound = list(
		'modular_twilight_axis/firearms/sound/musketfire2.ogg' = 99.99,
		'modular_twilight_axis/firearms/sound/musketfire11.ogg' = 0.01
	)
	var/vitae_cost = 200
	var/mob/living/carbon/human/bloodlock_owner
	var/bloodlock_awakened = FALSE
	var/bloodlock_awaken_timer
	var/bloodlock_phrase_timer
	var/mob/living/carbon/human/bloodlock_phrase_user
	var/bloodlock_loss_timer
	var/previous_maxbloodpool = 0
	var/last_slot

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/shoot_live_shot(mob/living/user as mob|obj, pointblank = 0, mob/pbtarget = null, message = 1)
	fire_sound = pickweight(weighted_fire_sound)
	. = ..()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cursed_item, TRAIT_CABAL, "GUN")
	addtimer(CALLBACK(src, PROC_REF(bloodlock_random_phrase)), BLOODLOCK_PHRASE_TIME)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/get_examine_highlight_status()
	return list(EXAMINEHIGHLIGHT_HERESYSEVERITY_ALARMING, HERESYDESC_ZIZO_WEAPON)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/examine(mob/living/carbon/human/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/u = user
		if(HAS_TRAIT(u, TRAIT_ARCYNE) || HAS_TRAIT(u, TRAIT_VAMPBITE))
			if(cocked)
				if(chambered)
					. += span_notice("Infused with blood and ready to fire.")
				else
					. += span_notice("The lock is infused with blood, but the bullet is not loaded.")
			else
				. += span_notice("Requires blood to charge.")
		else
			. += span_notice("The design of this strange, seemingly living lock is completely unfamiliar to you.")

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/attack_self(mob/living/user)
	if(twohands_required)
		return
	if(altgripped || wielded) //Trying to unwield it
		ungrip(user)
		return
	if(!cocked)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(HAS_TRAIT(H, TRAIT_ARCYNE) && HAS_TRAIT(H, TRAIT_VAMPBITE))
				if(H.bloodpool < vitae_cost)
					to_chat(H, span_warning("The weapon needs more blood!"))
					if(prob(5))
						to_chat(H, "<span style='color:#5E2129'>The bloodlock</span> slurs, " + span_cult(pick("<i>\"I lack your blood. Find someone!\"</i>", "<i>\"I need more blood.\"</i>", "<i>\"Come on, take someone's blood for me!\"</i>", "<i>\"I have nothing to feed on...\"</i>")))
					return
				to_chat(H, span_info("The weapon begins to vibrate and feed..."))
				if(prob(5))
					to_chat(H, "<span style='color:#5E2129'>The bloodlock</span> slurs, " + span_cult(pick("<i>\"Yes, yes, YES! What bliss...\"</i>", "<i>\"This rush of power... Shoot the mutt!\"</i>", "<i>\"They will pay for raising a blade against you!\"</i>")))
				playsound(src,'modular_twilight_axis/firearms/sound/bloodlock_reload.ogg', 100, FALSE)
				var/adj_reload_time = reload_time
				if(H.mind)
					var/skill = H.get_skill_level(/datum/skill/combat/twilight_firearms)
					if(skill)
						adj_reload_time = reload_time / skill
				if(move_after(H, adj_reload_time SECONDS, target = H))
					H.adjust_bloodpool(-vitae_cost)
					H.update_action_buttons()
					playsound(H, 'modular_twilight_axis/firearms/sound/musketcock.ogg', 100, FALSE)
					cocked = TRUE
			else
				to_chat(H, span_warning("I absolutely do not understand how to use this!"))
		else
			to_chat(user, span_warning("I absolutely do not understand how to use this!"))
	else
		if(alt_grips)
			altgrip(user)
		if(gripped_intents)
			wield(user)
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/get_mechanics_examine(mob/user)
	. = ..()
	. += span_info("Arcane locks require your own blood and arcane potential to charge, after which the lock must be cocked before shooting.")

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/process_fire/(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(chambered && HAS_TRAIT(user, TRAIT_PACIFISM))
		if(chambered.harmful)
			to_chat(user, span_warning("[src] is lethally chambered! You don't want to risk harming anyone..."))
			return
	var/skill = user.get_skill_level(/datum/skill/combat/twilight_firearms)
	if(skill)
		misfire_chance = max(0, misfire_chance - (skill * 2))
	if(user.client)
		if(user.client.chargedprog >= 100)
			spread = 0
		else
			spread = 150 - (150 * (user.client.chargedprog / 100))
	else
		spread = 0
	if(prob(misfire_chance))
		to_chat(user, span_warning("The [name] misfires!"))
		explosion(src, light_impact_range = 2, heavy_impact_range = 1, smoke = FALSE, soundin = 'sound/misc/explode/bomb.ogg')
		qdel(src)
		return
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/bullet/BB = CB.BB
		BB.gunpowder_npc_critfactor *= npcdamfactor
		BB.critfactor *= critfactor
		var/per_scaling = 1 + ((min(user.STAPER, RANGED_STAT_SOFTCAP) - 10) * RANGED_STAT_MULT) + (max(0, user.STAPER - RANGED_STAT_SOFTCAP) * RANGED_STAT_CAPPEDMULT)
		BB.damage *= damfactor * per_scaling
	cocked = FALSE
	update_icon()
	var/shoot_dir = get_dir(src, target)
	new /obj/effect/temp_visual/small_smoke/gunsmoke/black(get_step(user, shoot_dir), shoot_dir)
	..()

/obj/item/ammo_box/magazine/internal/shot/twilight_bloodlock
	ammo_type = /obj/item/ammo_casing/caseless/rogue/twilight_lead
	caliber = "lead_sphere"
	max_ammo = 1
	start_empty = TRUE

/datum/intent/shoot/twilight_bloodlock/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 75
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 15)
		//per block
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 0.1
	return chargetime

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/is_blood_raider(mob/living/carbon/human/H)
	if(!H?.mind)
		return FALSE
	if(HAS_TRAIT_FROM(H, TRAIT_VAMPBITE, "bloodraider"))
		return TRUE
	return FALSE

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/can_awaken(mob/living/carbon/human/H)
	if(!H)
		return FALSE
	if(HAS_TRAIT(H, TRAIT_ARCYNE))
		return TRUE
	return FALSE

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	if(slot != ITEM_SLOT_HANDS)
		last_slot = slot
		return

	if(last_slot == ITEM_SLOT_BACK)
		last_slot = null
		if(H == bloodlock_owner && bloodlock_awakened)
			reset_loss_timer()

		return

	last_slot = null

	if(is_blood_raider(H))
		if(prob(10))
			to_chat(H, "<span style='color:#5E2129'>The bloodlock</span> slurs, " + span_cult(pick("<i>\"Hello...\"</i>", "<i>\"Greetings!\"</i>", "<i>\"I missed you...\"</i>", "<i>\"Guide me. Let me shoot!\"</i>")))
		return

	if(bloodlock_awakened)
		if(H == bloodlock_owner)
			reset_loss_timer()
			if(prob(10))
				to_chat(H, "<span style='color:#5E2129'>The bloodlock rifle</span> slurs, " + span_cult(pick("<i>\"Hello...\"</i>", "<i>\"Greetings!\"</i>", "<i>\"I missed you...\"</i>", "<i>\"Guide me. Let me shoot!\"</i>")))
		return

	if(!can_awaken(H))
		to_chat(H, span_warning(pick("The weapon is silent.", "It seems you imagined it.", "You feel nothing while holding the weapon.")))
		return

	if(bloodlock_awaken_timer)
		return

	bloodlock_owner = H

	to_chat(H, span_info(pick("You feel discomfort. The weapon seems to be trying to communicate with you...", "The weapon pulses faintly under your fingers.", "Something inside the weapon responds to your presence.", "For a moment, it seems as if the weapon is looking straight at you.", "A foreign will touches your mind.", "You feel a faint call emanating from the weapon.")))

	bloodlock_awaken_timer = addtimer(CALLBACK(src, PROC_REF(finish_bloodlock_awaken)), BLOODLOCK_AWAKEN_TIME, TIMER_STOPPABLE)
	reset_loss_timer()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/finish_bloodlock_awaken()
	bloodlock_awaken_timer = null
	if(!bloodlock_owner)
		return
	if(QDELETED(bloodlock_owner))
		bloodlock_owner = null
		return
	if(src.loc != bloodlock_owner)
		to_chat(bloodlock_owner, span_warning("The weapon falls silent. The connection is broken."))
		bloodlock_owner = null
		return
	bloodlock_awakened = TRUE
	awaken_bloodlock(bloodlock_owner)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/awaken_bloodlock(mob/living/carbon/human/H)
	if(!H)
		return

	ADD_TRAIT(H, TRAIT_NOSLEEP, "bloodlock")
	ADD_TRAIT(H, TRAIT_NOHUNGER, "bloodlock")
	ADD_TRAIT(H, TRAIT_NASTY_EATER, "bloodlock")
	ADD_TRAIT(H, TRAIT_VAMPBITE, "bloodlock")

	previous_maxbloodpool = H.maxbloodpool
	var/previous_bloodpool = H.bloodpool
	H.maxbloodpool = max(H.maxbloodpool, 1700)
	H.hud_used?.shutdown_bloodpool()
	H.hud_used?.initialize_bloodpool()
	H.hud_used?.bloodpool?.set_fill_color("#510000")
	if(previous_maxbloodpool > 0)
		H.set_bloodpool(min(previous_bloodpool, H.maxbloodpool))
	else
		H.set_bloodpool(H.maxbloodpool)

	RegisterSignal(H, COMSIG_LIVING_DRINKED_LIMB_BLOOD, PROC_REF(on_drink_blood))

	reset_loss_timer()

	to_chat(H, "<span style='color:#5E2129'>The bloodlock rifle</span> slurs, " + span_cult(pick("<i>\"Greetings to the new owner...\"</i>", "<i>\"Do you feel me?\"</i>", "<i>\"Feel my gift!\"</i>", "<i>\"My name is S'ang. Remember it.\"</i>", "<i>\"The previous owner was repulsive to me... But you..!\"</i>")))

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/bloodlock_random_phrase()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		to_chat(H, span_warning("The weapon is trying to tell you something..."))
		if(prob(40))
			to_chat(H, "<span style='color:#5E2129'>The bloodlock rifle</span> whispers, " + span_cult(pick("<i>\"Back when I was held in some alley of Menzoberranzan, a group of Anthrax came into the shop. I only remember... darkness.\"</i>", "<i>\"Rumor has it that those who imprisoned me and created one of the first shells made some kind of deal with the Inferno creatures... What do you think?\"</i>", "<i>\"It seems the smell of iron caught you off guard. Are you really suitable for me?!\"</i>", "<i>\"The House of Baenre — the rulers of Menzoberranzan. The youngest daughter took the throne, appointing her older sister and brother as advisors... Ah, the mages are closely linked with demon summoning. Do you think that huge spider was his doing?\"</i>", "<i>\"Oh, I remember the wonderful moments in the House of Graves. How often I used to get excited back then, how often we used to shoot. No-no, don't get any wrong ideas! But really, you aren't quite up to it!\"</i>", "<i>\"Look, see that freak. Should we shoot?\"</i>", "<i>\"I can't see a thing... Maybe lift the gun?\"</i>", "<i>\"I thought you were much worse when you picked me up the first time. Pleasantly surprised.\"</i>", "<i>\"When are we going to do something already?!\"</i>", "<i>\"I haven't become such a handsome guy until quite recently. Maybe... a couple of yols ago. Before, they used to carry me around in vessels.\"</i>", "<i>\"They called me S'ang. There was another one... Or even twins. But I don't remember their names at all.\"</i>", "<i>\"Pum-purum-purum-pum...\"</i>", "<i>\"And what yol is it now? Probably, the thousandth one has already come, right?\"</i>", "<i>\"Ah... Huh?! Mierda, you're here...\"</i>")))

	addtimer(CALLBACK(src, PROC_REF(bloodlock_random_phrase)), BLOODLOCK_PHRASE_TIME)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/dropped(mob/user, silent)
	. = ..()

	if(bloodlock_awaken_timer && bloodlock_owner == user)
		deltimer(bloodlock_awaken_timer)
		bloodlock_awaken_timer = null
		to_chat(user, span_warning("The weapon quiets down. The awakening is interrupted."))
		bloodlock_owner = null
		return

	if(bloodlock_awakened && bloodlock_owner == user)
		reset_loss_timer()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/reset_loss_timer()
	if(bloodlock_loss_timer)
		deltimer(bloodlock_loss_timer)
	bloodlock_loss_timer = addtimer(CALLBACK(src, PROC_REF(check_owner_loss)), BLOODLOCK_LOSS_TIME, TIMER_STOPPABLE)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/check_owner_loss()
	bloodlock_loss_timer = null
	if(!bloodlock_owner)
		return
	if(src.loc == bloodlock_owner)
		reset_loss_timer()
		return
	remove_bloodlock_power()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/remove_bloodlock_power()
	if(!bloodlock_owner)
		return

	var/mob/living/carbon/human/H = bloodlock_owner

	REMOVE_TRAIT(H, TRAIT_NOSLEEP, "bloodlock")
	REMOVE_TRAIT(H, TRAIT_NOHUNGER, "bloodlock")
	REMOVE_TRAIT(H, TRAIT_NASTY_EATER, "bloodlock")
	REMOVE_TRAIT(H, TRAIT_VAMPBITE, "bloodlock")

	UnregisterSignal(H, COMSIG_LIVING_DRINKED_LIMB_BLOOD)

	var/current_bloodpool = H.bloodpool
	H.maxbloodpool = previous_maxbloodpool
	H.hud_used?.shutdown_bloodpool()
	if(H.maxbloodpool > 0)
		H.hud_used?.initialize_bloodpool()
		H.hud_used?.bloodpool.set_fill_color("#510000")
		H.set_bloodpool(min(current_bloodpool, H.maxbloodpool))
	else
		H.set_bloodpool(0)
	previous_maxbloodpool = 0
	bloodlock_awakened = FALSE
	bloodlock_owner = null

	to_chat(H, "<span style='color:#5E2129'>The bloodlock rifle</span> slurs, " + span_cult(pick("<i>\"How dare you abandon me?!\"</i>", "<i>\"The previous owner was still better.\"</i>", "<i>\"N'wah!\"</i>", "<i>\"Progress is clearly not for a fool like you!\"</i>")))

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/Destroy()
	if(bloodlock_awaken_timer)
		deltimer(bloodlock_awaken_timer)
		bloodlock_awaken_timer = null
	if(bloodlock_loss_timer)
		deltimer(bloodlock_loss_timer)
		bloodlock_loss_timer = null
	if(bloodlock_awakened && bloodlock_owner && !QDELETED(bloodlock_owner))
		remove_bloodlock_power()
	else
		bloodlock_owner = null
	return ..()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/on_drink_blood(mob/living/drinker, mob/living/target)
	SIGNAL_HANDLER
	if(drinker != bloodlock_owner)
		return
	drinker.adjust_bloodpool(BLOODLOCK_VITAE_PER_DRINK)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/get_examine_string(mob/living/user)
	. = ..()

	if(name != "bloodlock rifle")
		return

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	var/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/own_bloodlock

	for(var/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/B in H)
		if(B.loc != H)
			continue

		if(B.bloodlock_owner == H && B.bloodlock_awakened)
			own_bloodlock = B
			break

		if(B.is_blood_raider(H))
			own_bloodlock = B
			break

	if(!own_bloodlock)
		return

	if(own_bloodlock == src)
		return

	own_bloodlock.bloodlock_second_examine(H)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/twilight_bloodlock/proc/bloodlock_second_examine(mob/living/carbon/human/H)
	if(!H)
		return

	if(bloodlock_owner != H && !is_blood_raider(H))
		return

	to_chat(H, span_warning("The weapon begins to vibrate anxiously at the sight of the twin."))
	if(prob(50))
		if(prob(50))
			to_chat(H, "<span style='color:#5E2129'>The bloodlock</span> whispers, " + span_cult(pick("<i>\"What Zizo?! Fake!\"</i>", "<i>\"Non... non... NON! KILL THE OWNER OF THIS FAKE AND DESTROY IT!\"</i>", "<i>\"Shoot the owner and destroy the fake before they notice us!\"</i>", "<i>\"KILL, KILL, KILL!!\"</i>", "<i>\"Destroy the impostors!\"</i>", "<i>\"Ha... We should finish off the fake before it does it first!\"</i>")))

#undef BLOODLOCK_AWAKEN_TIME
#undef BLOODLOCK_LOSS_TIME
#undef BLOODLOCK_VITAE_PER_DRINK
#undef BLOODLOCK_PHRASE_TIME
