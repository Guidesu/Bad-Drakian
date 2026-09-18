/datum/erp_knot_effects

/// Sends failure feedback for knot attempt based on reason.
/datum/erp_knot_effects/proc/notify_try_knot_failed(mob/living/user, mob/living/target, reason)
	if(!istype(user))
		return

	switch(reason)
		if("too_soft")
			to_chat(user, span_notice("My knot was too soft to tie."))
		if("too_far")
			to_chat(user, span_warning("Too far away."))
		if("no_knot")
			to_chat(user, span_warning("I can't knot."))

/// Applies world-side effects when a knot starts.
/datum/erp_knot_effects/proc/on_knot_started(datum/component/erp_knotting/C, datum/erp_knot_link/L, force_level)
	if(!L || !L.is_valid())
		return

	var/mob/living/top = L.top
	var/mob/living/btm = L.btm

	if(!btm.has_status_effect(/datum/status_effect/knot_tied))
		btm.apply_status_effect(/datum/status_effect/knot_tied)
	if(!top.has_status_effect(/datum/status_effect/knotted))
		top.apply_status_effect(/datum/status_effect/knotted)

	top.visible_message(
		span_notice("[top] ties their knot inside of [btm]!"),
		span_notice("I tie my knot inside of [btm].")
	)

	var/k = C ? C.count_knots_on_target(btm) : 1
	if(btm.stat != DEAD)
		switch(k)
			if(1) to_chat(btm, span_userdanger("You have been knotted!"))
			if(2) to_chat(btm, span_userdanger("You have been double-knotted!"))
			if(3) to_chat(btm, span_userdanger("You have been triple-knotted!"))
			if(4) to_chat(btm, span_userdanger("You have been quad-knotted!"))
			if(5) to_chat(btm, span_userdanger("You have been penta-knotted!"))
			else to_chat(btm, span_userdanger("You have been ultra-knotted!"))

	if(force_level > SEX_FORCE_MID)
		var/datum/component/arousal/A = btm.GetComponent(/datum/component/arousal)
		if(force_level == SEX_FORCE_EXTREME)
			btm.apply_damage(30, BRUTE, BODY_ZONE_CHEST)
			A?.try_do_pain_effect(PAIN_HIGH_EFFECT, FALSE)
		else
			A?.try_do_pain_effect(PAIN_MILD_EFFECT, FALSE)
		btm.Stun(80)

/// Applies world-side effects when a knot is removed.
/datum/erp_knot_effects/proc/on_knot_removed(datum/component/erp_knotting/C, datum/erp_knot_link/L, forceful, who_pulled, remove_top_status, remove_btm_status)
	if(!L || !L.is_valid())
		return

	var/mob/living/top = L.top
	var/mob/living/btm = L.btm

	var/pain = L.get_pain_damage_on_removal()
	if(pain > 0)
		btm.apply_damage(pain, BRUTE, BODY_ZONE_CHEST)
		var/datum/component/arousal/A = btm.GetComponent(/datum/component/arousal)
		A?.try_do_pain_effect(PAIN_MILD_EFFECT, FALSE)
		btm.emote("painmoan", forced = TRUE)

	var/turf/T = get_turf(btm)
	if(T)
		new /obj/effect/decal/cleanable/coom(T)

	playsound(btm, 'sound/misc/mat/pop.ogg', 60, TRUE, -2, ignore_walls = FALSE)

	if(remove_btm_status)
		btm.remove_status_effect(/datum/status_effect/knot_tied)

	if(remove_top_status)
		top.remove_status_effect(/datum/status_effect/knotted)

	// A knot holds the deposit in place. Once it is removed, the receiving
	// organ begins the same reagent-backed leaking used by ordinary climax.
	var/mob/living/carbon/human/human_btm = btm
	if(istype(human_btm) && L.receiving_org?.erp_organ_type != SEX_ORGAN_MOUTH && L.receiving_org?.storage?.total_volume() > 0)
		var/is_large_load = L.penis_org?.producing?.capacity > 18
		var/datum/status_effect/erp_creampie_leak/leak = human_btm.has_status_effect(/datum/status_effect/erp_creampie_leak)
		if(!leak)
			human_btm.apply_status_effect(/datum/status_effect/erp_creampie_leak, L.receiving_org, is_large_load)
		else
			leak.add_receiving_organ(L.receiving_org, is_large_load)

/// Sends feedback when pull-out fails.
/datum/erp_knot_effects/proc/notify_pull_failed(datum/erp_knot_link/L, mob/living/actor)
	if(!L || !L.is_valid() || !istype(actor))
		return

	if(actor == L.btm)
		to_chat(L.btm, span_warning("It's stuck... it won't budge!"))
	else if(actor == L.top)
		to_chat(L.top, span_warning("My knot holds tight."))
