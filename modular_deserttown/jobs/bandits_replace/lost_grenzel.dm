/* // Lost Grenzel comment
/datum/antagonist/bandit/lost_grenzel
	name = "Lost Grenzel"
	antagpanel_category = "Lost Grenzel"
	roundend_category = "lost grenzels"
	show_name_in_check_antagonists = TRUE
	job_rank = ROLE_LOSTGRENZEL
	storyteller_antag_flags = STORYTELLER_ANTAG_VILLAIN | STORYTELLER_ANTAG_ROUNDSTART
	override_candidatereq = TRUE
	storyteller_min_players = 80
	storyteller_slot_scaling = 1
	storyteller_slot_default_cap = 0
	storyteller_maxcaps = list(
		/datum/storyteller/gamemode/guaranteed_antag = 5,
		/datum/storyteller/gamemode/guaranteed_antag/low_wretch = 5,
	)

/datum/antagonist/bandit/lost_grenzel/on_gain()
	. = ..()
	owner.special_role = name
	
/datum/antagonist/bandit/lost_grenzel/finalize_bandit()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 60, FALSE, pressure_affected = FALSE)
	var/mob/living/carbon/human/H = owner.current
	H.verbs |= /mob/proc/haltyell_exhausting
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLAW, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PSYCHOSIS, TRAIT_GENERIC)
	to_chat(H, span_alertsyndie("I AM THE LOST GRENZELHOFTZ!"))
	to_chat(H, span_boldwarning("Left alone in the middle of the bloody sands, you were united by hatred. You are united by a thirst for revenge. You are one of the lost Grenzelhoftians. Your goal is to kill, rob and take revenge."))
	H.AddComponent(/datum/component/lost_grenzel_hate)

//grenzel hatred
/datum/stressevent/lost_grenzel_hate
	desc = span_boldred("Take this Schweinehund away from me!")
	stressadd = 5
	timer = INFINITY

/datum/component/lost_grenzel_hate
	var/time_near_others = 0
	var/last_process_time = 0
	var/last_message_time = 0
	var/has_debuff = FALSE

/datum/component/lost_grenzel_hate/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	START_PROCESSING(SSprocessing, src)
	last_process_time = world.time

/datum/component/lost_grenzel_hate/Destroy()
	var/mob/living/carbon/human/L = parent
	if(istype(L) && has_debuff)
		L.remove_stress(/datum/stressevent/lost_grenzel_hate)
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/component/lost_grenzel_hate/process()
	var/mob/living/carbon/human/L = parent
	if(!istype(L) || L.stat == DEAD)
		if(istype(L) && has_debuff)
			has_debuff = FALSE
			L.remove_stress(/datum/stressevent/lost_grenzel_hate)
			time_near_others = 0
		return
		
	var/current_time = world.time
	var/delta = current_time - last_process_time
	last_process_time = current_time
	
	var/found_visible = FALSE
	for(var/mob/living/carbon/human/H in oview(10, L))
		if(H.stat == DEAD || H.alpha == 0 || H.rogue_sneaking)
			continue
		var/is_grenzel = FALSE
		if(H.GetComponent(/datum/component/lost_grenzel_hate) || (H.mind && H.mind.has_antag_datum(/datum/antagonist/bandit/lost_grenzel)))
			is_grenzel = TRUE
		if(!is_grenzel)
			found_visible = TRUE
			if(H.dna?.species?.origin == "Grenzelhoft")
				if(!H.GetComponent(/datum/component/lost_grenzel_fear))
					H.AddComponent(/datum/component/lost_grenzel_fear)
			
	if(found_visible)
		time_near_others += delta
		if(time_near_others >= 3 MINUTES)
			if(!has_debuff)
				L.add_stress(/datum/stressevent/lost_grenzel_hate)
				has_debuff = TRUE
			
			if(current_time >= last_message_time + 1 MINUTES)
				to_chat(L, span_userdanger("Take this Schweinehund away from me!"))
				last_message_time = current_time
	else
		if(time_near_others > 0)
			time_near_others = max(0, time_near_others - delta)
		if(time_near_others <= 0 && has_debuff)
			has_debuff = FALSE
			L.remove_stress(/datum/stressevent/lost_grenzel_hate)

//everyone else has fear of grensels
/datum/stressevent/lost_grenzel_fear
	desc = span_boldred("This is a crazy deserter! You need to leave while you still remember!")
	stressadd = 5
	timer = INFINITY

/datum/component/lost_grenzel_fear
	var/time_near_lg = 0
	var/last_process_time = 0
	var/last_message_time = 0
	var/has_debuff = FALSE

/datum/component/lost_grenzel_fear/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	START_PROCESSING(SSprocessing, src)
	last_process_time = world.time

/datum/component/lost_grenzel_fear/Destroy()
	var/mob/living/carbon/human/L = parent
	if(istype(L) && has_debuff)
		L.remove_stress(/datum/stressevent/lost_grenzel_fear)
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/component/lost_grenzel_fear/process()
	var/mob/living/carbon/human/L = parent
	if(!istype(L) || L.stat == DEAD)
		qdel(src)
		return
		
	var/current_time = world.time
	var/delta = current_time - last_process_time
	last_process_time = current_time
	
	var/found_lg = FALSE
	for(var/mob/living/carbon/human/H in oview(10, L))
		if(H.stat == DEAD || H.alpha == 0 || H.rogue_sneaking)
			continue
		if(H.GetComponent(/datum/component/lost_grenzel_hate) || (H.mind && H.mind.has_antag_datum(/datum/antagonist/bandit/lost_grenzel)))
			found_lg = TRUE
			break
			
	if(found_lg)
		time_near_lg = 1 MINUTES
		if(!has_debuff)
			L.add_stress(/datum/stressevent/lost_grenzel_fear)
			has_debuff = TRUE
		
		if(current_time >= last_message_time + 1 MINUTES)
			to_chat(L, span_userdanger("This is a crazy deserter! You need to leave while you still remember!"))
			last_message_time = current_time
	else
		if(time_near_lg > 0)
			time_near_lg -= delta
		else
			if(has_debuff)
				L.remove_stress(/datum/stressevent/lost_grenzel_fear)
				has_debuff = FALSE
			qdel(src)

/datum/job/roguetown/lost_grenzel
	title = "Lost Grenzel"
	flag = BANDIT
	department_flag = ANTAGONIST
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	antag_job = TRUE
	
	tutorial = "Left alone in the middle of the bloody sands, you were united by hatred. You are united by a thirst for revenge. For several years now, you have been moving from city to city and taking revenge, followed by scorched earth, blood and bones, shock and awe. You will not be spared - you will never be pardoned. The Zibantian pigs won’t even bother to bury you in peace - and will abuse your body. You will die, you will die ingloriously, but you will take a dozen or two Schweihunds with you."

	outfit = null
	outfit_female = null

	obsfuscated_job = TRUE

	display_order = JDO_BANDIT
	announce_latejoin = FALSE
	min_pq = 25
	max_pq = null
	round_contrib_points = null
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	advclass_cat_rolls = list(CTAG_LOSTGRENZEL = 20)
	PQ_boost_divider = 10

	wanderer_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = FALSE
	job_reopens_slots_on_death = FALSE
	job_traits = list(TRAIT_SELF_SUSTENANCE, TRAIT_STEELHEARTED)
	vice_restrictions = list(/datum/charflaw/mute, /datum/charflaw/limbloss/arm_r, /datum/charflaw/limbloss/arm_l)
	same_job_respawn_delay = 30 MINUTES
	cmode_music = 'sound/music/combat_lost_grenzel.ogg'
	job_subclasses = list(
		/datum/advclass/lost_grenzel/lost_halberdier,
		/datum/advclass/lost_grenzel/lost_mage,
		/datum/advclass/lost_grenzel/lost_jager,
		/datum/advclass/lost_grenzel/lost_doppelsoldner,
		/datum/advclass/lost_grenzel/lost_imperial_knight,
	)

/datum/job/roguetown/lost_grenzel/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(!H.mind)
			return
		H.ambushable = FALSE

/datum/outfit/job/roguetown/lost_grenzel/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.verbs |= /mob/proc/haltyell_exhausting

/datum/outfit/job/roguetown/lost_grenzel/post_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		var/datum/antagonist/new_antag = new /datum/antagonist/bandit/lost_grenzel()
		H.mind.add_antag_datum(new_antag)
		H.grant_language(/datum/language/thievescant)
		addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "LOST GRENZEL"), 5 SECONDS)
		var/wanted = list("I am a notorious criminal", "I am a nobody")
		var/wanted_choice = input("Are you a known criminal?") as anything in wanted
		switch(wanted_choice)
			if("I am a notorious criminal") //Extra challenge for those who want it
				bandit_select_bounty(H)
				ADD_TRAIT(H, TRAIT_KNOWNCRIMINAL, TRAIT_GENERIC)
			if("I am a nobody") //Nothing ever happens
				return

/datum/migrant_role/lost_grenzel
	name = "Lost Grenzel"
	greet_text = "Left alone in the middle of the bloody sands, you were united by hatred. You are united by a thirst for revenge. You are one of the lost Grenzelhoftians."
	outfit = /datum/outfit/job/roguetown/lost_grenzel
	antag_datum = /datum/antagonist/bandit/lost_grenzel
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	forbidden_races = list(RACES_CONSTRUCT RACES_DESPISED RACES_OOZE)
	advclass_cat_rolls = list(CTAG_LOSTGRENZEL = 20)

/datum/migrant_role/lost_grenzel/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.ambushable = FALSE

/datum/migrant_wave/lost_grenzel
	name = "Lost Grenzels"
	can_roll = FALSE
	required_roles = list(
		/datum/migrant_role/lost_grenzel = 5,
	)
	min_pop = 80
	spawn_landmark = "LostGrenzel"
	greet_text = "The lost Grenzelhoftians emerge from the blood-stained sands. The city will remember them in blood and ashes."

/datum/round_event_control/antagonist/migrant_wave/lost_grenzel/valid_for_map()
	return deserttown_antag_wave_is_desert_town()

/datum/round_event_control/antagonist/migrant_wave/lost_grenzel/New()
	..()
	if(!valid_for_map())
		typepath = null
		wave_type = null
		max_occurrences = 0
		weight = 0

/datum/round_event_control/antagonist/migrant_wave/lost_grenzel
	name = "Lost Grenzel Migration"
	typepath = /datum/round_event/migrant_wave/lost_grenzel
	wave_type = /datum/migrant_wave/lost_grenzel
	track = EVENT_TRACK_INTERVENTION
	max_occurrences = 1
	weight = 8
	earliest_start = 5 MINUTES
	min_players = 80
	tags = list(
		TAG_COMBAT,
		TAG_VILLIAN,
	)


/proc/deserttown_lost_grenzel_storyteller_slots_allowed(player_count = null)
	if(!deserttown_antag_wave_is_desert_town())
		return FALSE
	if(!SSgamemode)
		return FALSE
	if(isnull(player_count))
		player_count = SSgamemode.get_correct_popcount()
	if(!SSgamemode.story_antag_open_slots(/datum/antagonist/bandit/lost_grenzel, player_count))
		return FALSE
	var/storyteller_type = SSgamemode.story_policy_type(TRUE)
	return SSgamemode.story_antag_slot_cap(/datum/antagonist/bandit/lost_grenzel, TRUE, storyteller_type) > 0

/datum/round_event_control/antagonist/migrant_wave/lost_grenzel/canSpawnEvent(players_amt, gamemode, fake_check)
	if(!deserttown_antag_waves_enabled())
		return FALSE
	if(!deserttown_antag_wave_is_desert_town())
		return FALSE
	if(!deserttown_antag_wave_has_required_pop())
		return FALSE
	if(!deserttown_lost_grenzel_storyteller_slots_allowed(players_amt))
		return FALSE

	var/datum/job/lg_job = SSjob.GetJob("Lost Grenzel")
	if(!lg_job)
		return FALSE
	if(lg_job.total_positions >= 5)
		return FALSE

	return ..()

/datum/round_event_control/antagonist/migrant_wave/lost_grenzel/preRunEvent()
	if(!deserttown_antag_waves_enabled())
		return FALSE
	if(!deserttown_lost_grenzel_storyteller_slots_allowed())
		return EVENT_CANT_RUN
	if(!deserttown_antag_wave_is_desert_town())
		return EVENT_CANT_RUN
	if(!deserttown_antag_wave_has_required_pop())
		message_admins("Lost Grenzel Migration skipped: requires 80 active players, has [deserttown_antag_wave_player_count()].")
		return EVENT_INTERRUPTED
	if(!deserttown_lost_grenzel_storyteller_slots_allowed())
		return EVENT_CANT_RUN

	var/datum/job/lg_job = SSjob.GetJob("Lost Grenzel")
	if(!lg_job)
		return EVENT_CANT_RUN
	if(lg_job.total_positions >= 5)
		return EVENT_CANT_RUN

	return ..()

/datum/round_event/migrant_wave/lost_grenzel/start()
	if(!deserttown_antag_waves_enabled())
		return FALSE
	if(!deserttown_antag_wave_is_desert_town())
		return
	if(!deserttown_antag_wave_has_required_pop())
		log_game("Lost Grenzel Migration aborted: requires 80 active players, has [deserttown_antag_wave_player_count()].")
		return
	if(!deserttown_lost_grenzel_storyteller_slots_allowed())
		return

	var/datum/job/lg_job = SSjob.GetJob("Lost Grenzel")
	if(!lg_job)
		return
	if(lg_job.total_positions >= 5)
		return

	var/old_positions = lg_job.total_positions
	lg_job.total_positions = max(lg_job.total_positions, 5)
	lg_job.spawn_positions = max(lg_job.spawn_positions, 5)

	if(lg_job.total_positions > old_positions)
		SSmapping.retainer.bandit_goal += 1 * rand(200, 400)
		SSrole_class_handler.bandits_in_round = TRUE
		lg_job.always_show_on_latechoices = TRUE
		for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
			if(!player.client)
				continue
			to_chat(player, span_danger("The lost Grenzelhoftians emerge from the blood-stained sands. Five slots for lost Grenzelhoftians have been opened."))

	..()

/proc/update_lost_grenzel_slots()
	var/datum/job/lost_grenzel_job = SSjob.GetJob("Lost Grenzel")
	if(!lost_grenzel_job)
		return

	lost_grenzel_job.always_show_on_latechoices = FALSE
	lost_grenzel_job.total_positions = 0
	lost_grenzel_job.spawn_positions = 0

	if(!deserttown_antag_wave_is_desert_town())
		return
	if(lost_grenzel_job.admin_slot_override)
		return
	if(!SSgamemode)
		return

	var/player_count = SSgamemode.get_correct_popcount()
	if(!SSgamemode.story_antag_open_slots(/datum/antagonist/bandit/lost_grenzel, player_count))
		return

	var/slots = 0
	var/admin_slot = !SSgamemode.allow_vote ? SSgamemode.admin_slots["Lost Grenzel"] : null
	if(!isnull(admin_slot))
		slots = max(0, admin_slot)
	else
		var/storyteller_type = SSgamemode.story_policy_type(TRUE)
		var/max_slots = SSgamemode.story_antag_slot_cap(/datum/antagonist/bandit/lost_grenzel, TRUE, storyteller_type)
		if(max_slots <= 0)
			return

		var/min_players = SSgamemode.story_antag_min_players(/datum/antagonist/bandit/lost_grenzel)
		var/slot_scaling = SSgamemode.story_antag_scaling_step(/datum/antagonist/bandit/lost_grenzel)
		slots = SSgamemode.storyteller_scale_slots(
			max_slots,
			player_count,
			FALSE,
			slot_scaling,
			min_players,
			SSgamemode.hard_antag_mult(),
		)

	slots = SSgamemode.story_antag_slots(slots, /datum/antagonist/bandit/lost_grenzel, player_count)
	if(slots <= 0)
		return

	lost_grenzel_job.always_show_on_latechoices = TRUE
	lost_grenzel_job.total_positions = max(lost_grenzel_job.current_positions, slots)
	lost_grenzel_job.spawn_positions = max(lost_grenzel_job.current_positions, slots)

*/
