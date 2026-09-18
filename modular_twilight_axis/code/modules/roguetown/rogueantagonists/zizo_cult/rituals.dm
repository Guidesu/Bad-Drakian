GLOBAL_LIST_INIT(ritualslist, build_zizo_rituals())
GLOBAL_LIST_INIT(ritual_counters, list())

/proc/build_zizo_rituals()
	. = list()
	for(var/datum/ritual/ritual as anything in subtypesof(/datum/ritual))
		if(is_abstract(ritual))
			continue
		.[initial(ritual.name)] = ritual

// RITUAL DATUMS
/datum/ritual
	abstract_type = /datum/ritual
	var/name = "DVRK AND EVIL RITVAL"
	var/desk = "" //Description of the ritual, what will be in the book. When adding a new ritual, please describe it.
	var/center_requirement
	// This is absolutely fucking terrible. I tried to do it with lists but it just didn't work and
	//kept runtiming. Something something, can't access list inside a datum.
	//I couldn't find a more efficient solution to do this, I'm sorry. -7
	var/n_req
	var/e_req
	var/s_req
	var/w_req

	//Forcibly assigns in the book what needs to be placed on the rune.
	//Useful if the ritual requires, for example, an aasimar in the north and a cultist in the center. You can appropriately write this in.
	//There will be no pictures. In theory, I can improve the method so that special pictures can also be inserted if needed.
	var/north_book
	var/east_book
	var/south_book
	var/west_book
	var/center_book

	/// If zizo followers can't perform this
	var/is_cultist_ritual = FALSE
	var/cultist_number = 0 //The minimum number of cultists in the game required to perform the ritual.
	var/ritual_limit = 0 //How many times the ritual can be performed. If 0, then an infinite number of times.
	var/number_cultist_for_add_limit = 0 //How many cultists are required to add one more unit to the ritual limit. If 0, the limit cannot be increased.

/datum/ritual/proc/invoke(mob/living/user, turf/center)
	return

/obj/effect/decal/cleanable/sigil/proc/find_ritual_ingredient(turf/target_turf, required_type)
	if(!target_turf || !required_type)
		return null
	for(var/atom/movable/found_ingredient in target_turf)
		if(found_ingredient.type == required_type)
			return found_ingredient
	for(var/atom/movable/found_ingredient in target_turf)
		if(istype(found_ingredient, required_type))
			return found_ingredient
	return null

/obj/effect/decal/cleanable/sigil/proc/consume_ritual_ingredient(atom/movable/ingredient)
	if(!ingredient || QDELETED(ingredient) || ismob(ingredient))
		return
	qdel(ingredient)

//Ritual count counter
/proc/get_ritual_count(ritual_name)
	if(!GLOB.ritual_counters[ritual_name])
		GLOB.ritual_counters[ritual_name] = 0
	return GLOB.ritual_counters[ritual_name]

/proc/increment_ritual_count(ritual_name)
	if(!GLOB.ritual_counters[ritual_name])
		GLOB.ritual_counters[ritual_name] = 0
	GLOB.ritual_counters[ritual_name]++

//Dynamic limits
/proc/get_dynamic_ritual_limit(datum/ritual/ritual, current_cultists)
	var/base_limit = ritual.ritual_limit
	var/cultists_per_additional_limit = ritual.number_cultist_for_add_limit

	if(cultists_per_additional_limit <= 0)
		return base_limit

	var/additional_limit = 0
	if(current_cultists > ritual.cultist_number)
		var/extra_cultists = current_cultists - ritual.cultist_number
		additional_limit = round(extra_cultists / cultists_per_additional_limit)

	return base_limit + additional_limit

/obj/effect/decal/cleanable/sigil/proc/show_ritual_tgui(mob/living/user)
	if(!user.client)
		return

	var/list/categories = list(
		"Servantry" = /datum/ritual/servantry,
		"Transmutation" = /datum/ritual/transmutation,
		"Fleshcrafting" = /datum/ritual/fleshcrafting,
		"Weaponary" = /datum/ritual/weaponary
	)

	var/chosen_category = tgui_input_list(user, "Choose Ritual Category:", "Ritual Categories", categories)
	if(!chosen_category || !user.Adjacent(src))
		return

	var/category_type = categories[chosen_category]
	var/list/ritual_categories = subtypesof(category_type)
	var/list/available_rituals = list()

	for(var/datum/ritual/ritual_type as anything in ritual_categories)
		if(is_abstract(ritual_type))
			continue

		var/ritual_name = initial(ritual_type.name)
		var/is_cultist_only = initial(ritual_type.is_cultist_ritual)

		if(is_cultist_only && !(is_zizocultist(user.mind) || is_zizolackey(user.mind)))
			continue

		available_rituals[ritual_name] = ritual_type

	if(!length(available_rituals))
		to_chat(user, span_warning("No available rituals in this category."))
		return

	var/chosen_ritual_name = tgui_input_list(user, "Choose Ritual:", "Rituals - [chosen_category]", available_rituals)
	if(!chosen_ritual_name || !user.Adjacent(src))
		return

	perform_ritual(user, available_rituals[chosen_ritual_name])

/obj/effect/decal/cleanable/sigil/proc/perform_ritual(mob/living/user, ritual_type)
	if(!ispath(ritual_type, /datum/ritual))
		return

	var/datum/ritual/ritual = new ritual_type()
	var/chosen_ritual_name = ritual.name
	var/current_cultists = length(SSmapping.retainer.cultists)

	//Special check for the ASCEND ritual
	var/required_cultists = ritual.cultist_number
	if(istype(ritual, /datum/ritual/fleshcrafting/ascend))
		required_cultists = SSmapping.retainer.get_cult_ascension_required_cultists()

		if(current_cultists < required_cultists)
			to_chat(user, span_danger("This ritual requires at least [required_cultists] cultists, but there are only [current_cultists]. You need [required_cultists - current_cultists] more cultists."))
			return
	//Regular check for other rituals
	else if(required_cultists > 0)
		if(current_cultists < required_cultists)
			to_chat(user, span_danger("This ritual requires at least [required_cultists] cultists, but there are only [current_cultists]. You need [required_cultists - current_cultists] more cultists."))
			return

	var/dynamic_limit = get_dynamic_ritual_limit(ritual, current_cultists)

	if(dynamic_limit > 0)
		var/current_count = get_ritual_count(chosen_ritual_name)
		if(current_count >= dynamic_limit)
			if(ritual.number_cultist_for_add_limit > 0)
				var/needed_cultists_for_more = ritual.number_cultist_for_add_limit
				var/current_extra_cultists = max(0, current_cultists - required_cultists)
				var/needed_for_next = needed_cultists_for_more - (current_extra_cultists % needed_cultists_for_more)

				to_chat(user, span_danger("This ritual can only be performed [dynamic_limit] times, and it has already been performed [current_count] times. You need [needed_for_next] more cultists to perform it again."))
			else
				to_chat(user, span_danger("This ritual can only be performed [dynamic_limit] times, and it has already been performed [current_count] times."))
			return

	var/atom/movable/east_ingredient
	var/atom/movable/south_ingredient
	var/atom/movable/west_ingredient
	var/atom/movable/north_ingredient
	var/atom/movable/center_ingredient

	if(ritual.e_req)
		east_ingredient = find_ritual_ingredient(get_step(src, EAST), ritual.e_req)
		if(!east_ingredient)
			to_chat(user, span_danger("That's not how you do it, fool."))
			user.electrocute_act(10, src)
			return

	if(ritual.s_req)
		south_ingredient = find_ritual_ingredient(get_step(src, SOUTH), ritual.s_req)
		if(!south_ingredient)
			to_chat(user, span_danger("That's not how you do it, fool."))
			user.electrocute_act(10, src)
			return

	if(ritual.w_req)
		west_ingredient = find_ritual_ingredient(get_step(src, WEST), ritual.w_req)
		if(!west_ingredient)
			to_chat(user, span_danger("That's not how you do it, fool."))
			user.electrocute_act(10, src)
			return

	if(ritual.n_req)
		north_ingredient = find_ritual_ingredient(get_step(src, NORTH), ritual.n_req)
		if(!north_ingredient)
			to_chat(user, span_danger("That's not how you do it, fool."))
			user.electrocute_act(10, src)
			return

	if(ritual.center_requirement)
		center_ingredient = find_ritual_ingredient(get_turf(src), ritual.center_requirement)
		if(!center_ingredient)
			to_chat(user, span_danger("That's not how you do it, fool."))
			user.electrocute_act(10, src)
			return

	var/list/ingredients_to_consume = list(
		east_ingredient,
		south_ingredient,
		west_ingredient,
		north_ingredient,
		center_ingredient
	)
	for(var/atom/movable/ingredient as anything in ingredients_to_consume)
		consume_ritual_ingredient(ingredient)

	user.playsound_local(user, 'modular_twilight_axis/code/modules/roguetown/rogueantagonists/zizo_cult/sounds/tesa.ogg', 25)
	user.whisper("O'vena tesa...")

	increment_ritual_count(chosen_ritual_name)
	ritual.invoke(user, loc)

// SERVANTRY
/datum/ritual/servantry
	abstract_type = /datum/ritual/servantry

/datum/ritual/servantry/convert
	name = "Summoning a minion"
	desk = "Turns the victim into a new minion!"
	center_book = "Victim"
	center_requirement = /mob/living/carbon/human
	is_cultist_ritual = TRUE

/datum/ritual/servantry/convert/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	if(target == user)
		return
	if(is_zizocultist(target.mind) || is_zizolackey(target.mind))
		to_chat(user, span_danger("He is already my minion!"))
		return
	if(target.mind.assigned_role == "Gnoll")
		to_chat(user, span_danger("This is a Graggar offspring, it does not deserve to be my servant..."))
	if(HAS_TRAIT(target, TRAIT_SILVER_WEAK))
		to_chat(user, span_danger("I need only the living..."))
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/skeleton))
		to_chat(user, span_danger("Dead servants already belong to Zizo, they do not need to be converted."))
		return
	if(istype(target.wear_neck, /obj/item/clothing/neck/roguetown/psicross/silver) || istype(target.wear_wrists, /obj/item/clothing/neck/roguetown/psicross/silver))
		to_chat(user, span_danger("He wears a silver cross! He prevents me from converting him..."))
		return

	var/datum/antagonist/zizocultist/PR = user.mind.has_antag_datum(/datum/antagonist/zizocultist)
	if(!PR)
		return
	target.Immobilize(3 SECONDS)
	to_chat(target, span_notice("Truth! She.. SHE HAS REVEALED HERSELF TO ME! They are not bad at all... I... Must help them!"))
	PR.add_cultist(target.mind)
	target.praise()
	target.playsound_local(target, 'modular_twilight_axis/code/modules/roguetown/rogueantagonists/zizo_cult/sounds/tesa.ogg', 25)
	target.whisper("O'vena tesa...")
	log_game("[key_name(target)] was converted to Zizoid Lackey by [key_name(PR.owner.current)]")
	message_admins("[key_name(target)] was converted to Zizoid Lackey by [key_name(PR.owner.current)]")

/datum/ritual/servantry/zizofication
	name = "Ritual of Enlightenment"
	desk = "A ritual for ordinary followers of Zizo who are not cultists. Allows converting someone to the faith of Zizo."
	center_requirement = /mob/living/carbon/human
	center_book = "Victim"

/datum/ritual/servantry/zizofication/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents

	if(!target)
		return

	if(target.stat == DEAD)
		to_chat(user, span_danger("He must be alive..."))
		return

	var/list/options = list(
		"Yield",
		"Resist"
	)
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/skeleton))
		to_chat(user, span_danger("In the empty eye sockets, Zizo's will already shines. They do not need enlightenment."))
		return

	var/chosen = tgui_input_list(target, "Do you yield to the darkness?", "You are shown the path of Zizo.", options)

	if(!chosen)
		convert_resist(target)
		return

	if(chosen == "Yield")
		convert_yield(target)
	else if(chosen == "Resist")
		convert_resist(target)

/datum/ritual/servantry/zizofication/proc/convert_yield(mob/living/carbon/human/target)
	target.Immobilize(3 SECONDS)
	target.set_patron(/datum/patron/inhumen/zizo)
	to_chat(target, span_notice("Zizo... She... She will now show me the right path..."))
	target.praise()
	target.playsound_local(target, 'modular_twilight_axis/code/modules/roguetown/rogueantagonists/zizo_cult/sounds/tesa.ogg', 25)
	target.whisper("O'vena tesa...")
	log_game("[key_name(target)] was converted to Zizoid by zizoid!")
	message_admins("[key_name(target)] was converted to Zizoid by zizoid!]")

/datum/ritual/servantry/zizofication/proc/convert_resist(mob/living/carbon/human/target)
	target.Immobilize(3 SECONDS)
	target.visible_message(span_danger("[target] shakes, refusing Zizo!"))
	to_chat(target, span_reallybigredtext("Accept Her path! RIGHT NOW!"))
	if(target.electrocute_act(10))
		target.emote("painscream")
	log_game("[key_name(target)] was resist to convert by zizoid")

/datum/ritual/servantry/skeletaljaunt
	name = "Skeletonization"
	desk = "Turns the victim into a strong and special Zizo skeleton! And if there is no soul in the body, another soul will take over its body. Does not accept cultists."
	ritual_limit = 2
	number_cultist_for_add_limit = 2
	center_book = "Victim"
	center_requirement = /mob/living/carbon/human

	n_req = /obj/item/natural/bone
	s_req = /obj/item/natural/bone
	w_req = /obj/item/natural/bone
	e_req = /obj/item/natural/bone

	is_cultist_ritual = TRUE

/datum/ritual/servantry/skeletaljaunt/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return

	if(target == user)
		return

	if(target.mind && is_zizocultist(target.mind))
		to_chat(target, span_danger("I will not let my followers become mindless brutes."))
		return

	if(!target.ckey || !target.mind)
		var/list/candidates = pollGhostCandidates("Do you want to play as skeleton?", ROLE_LICH_SKELETON, null, null, 10 SECONDS, POLL_IGNORE_LICH_SKELETON)
		if(!LAZYLEN(candidates))
			to_chat(user, span_warning("The depths are hollow."))
			return

		var/mob/dead/mob = pick(candidates)
		if(!istype(mob))
			return

		if(istype(mob, /mob/dead/new_player))
			var/mob/dead/new_player/new_player = mob
			new_player.close_spawn_windows()

		target.key = mob.key

	if(target.skills)
		target.skills.known_skills = list()
		target.skills.skill_experience = list()
		target.status_traits = list()

	while(target.mind.spell_list.len)
		var/obj/effect/proc_holder/spell/S = target.mind.spell_list[1]
		target.mind.spell_list -= S
		qdel(S)

	while(target.mob_spell_list.len)
		var/obj/effect/proc_holder/spell/S2 = target.mob_spell_list[1]
		target.mob_spell_list -= S2
		qdel(S2)

	target.unequip_everything()
	var/datum/job/summon_job = SSjob.GetJobType(/datum/job/roguetown/skeleton/zizoid)
	target.mind?.set_assigned_role(summon_job)
	summon_job.after_spawn(target, target.client)

	var/datum/advclass/cult/skeleton/zizoid/raider/class = new
	class.equipme(target)
	qdel(class)

	target.choose_name_popup("SKELETON")
	ADD_TRAIT(target, TRAIT_CABAL, TRAIT_GENERIC)

	to_chat(target, span_userdanger("I am returned to serve. I will obey, so that I may return to rest."))
	to_chat(target, span_userdanger("My master is [user]."))

/datum/ritual/servantry/thecall
	name = "Abduction"
	desk = "Allows you to abduct someone directly onto the rune, but not those who are church members or under Astrata's protection."
	ritual_limit = 2
	number_cultist_for_add_limit = 2
	center_requirement = /obj/item/bedsheet
	is_cultist_ritual = TRUE

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg
	n_req = /obj/item/alch/matricaria
	s_req = /obj/item/reagent_containers/food/snacks/grown/manabloom

/datum/ritual/servantry/thecall/invoke(mob/living/user, turf/center)

	var/input = input(user, "Who we need to kidnap?", "TELEPORT")
	if(!input)
		return
	for(var/mob/living/carbon/human/human in GLOB.human_list)
		if(human.real_name == input)
			if(!user.mind?.do_i_know(name = human.real_name))
				to_chat(user, span_warning("I didn't saw his face."))
				return
			if(!human)
				return

			if(human == SSticker.rulermob)
				return

			if(human.mind?.assigned_role in GLOB.church_positions)
				to_chat(human, span_warning("I sense an unholy presence loom near my soul."))
				to_chat(user, span_danger("They are protected..."))
				return

			if(human.mind?.assigned_role in GLOB.noble_positions)
				to_chat(human, span_warning("I sense an unholy presence loom near my soul."))
				to_chat(user, span_danger("They are protected..."))
				return

			if(human.mind?.assigned_role in GLOB.retinue_positions)
				to_chat(human, span_warning("I sense an unholy presence loom near my soul."))
				to_chat(user, span_danger("They are protected..."))
				return

			if(human.mind?.assigned_role in GLOB.regency_positions)
				to_chat(human, span_warning("I sense an unholy presence loom near my soul."))
				to_chat(user, span_danger("They are protected..."))
				return

			if(human.mind?.assigned_role in GLOB.courtier_positions)
				to_chat(human, span_warning("I sense an unholy presence loom near my soul."))
				to_chat(user, span_danger("They are protected..."))
				return

			if(istype(human.wear_neck, /obj/item/clothing/neck/roguetown/psicross/silver) || istype(human.wear_wrists, /obj/item/clothing/neck/roguetown/psicross/silver))
				to_chat(user, span_danger("They are wearing silver, it resists the dark magick!"))
				return

			if(!HAS_TRAIT(human, TRAIT_NOSLEEP))
				to_chat(human, span_userdanger("I'm so sleepy..."))
				human.SetSleeping(5 SECONDS)
			else
				to_chat(human, span_userdanger("My eyes close on their own!"))
				human.set_eyes_closed(TRUE)

			addtimer(CALLBACK(src, PROC_REF(kidnap), human, center), 3 SECONDS)

/datum/ritual/servantry/thecall/proc/kidnap(mob/living/victim, turf/to_go)
	if(QDELETED(victim))
		return
	if(to_go.is_blocked_turf(TRUE))
		return
	victim.SetSleeping(0)
	to_chat(victim, span_warning("This isn't my bed... Where am I?!"))
	victim.playsound_local(victim, pick('sound/misc/jumphumans (1).ogg','sound/misc/jumphumans (2).ogg','sound/misc/jumphumans (3).ogg'), 100)
	if (!istype(victim, /mob/living/carbon/human/dummy))
		victim.forceMove(to_go)

/datum/ritual/servantry/falseappearance
	name = "False guise"
	desk = "Changes appearance to a random one. Does not allow it to be returned."
	center_book = "Cultist"
	center_requirement = /mob/living/carbon/human

	n_req = /obj/item/bodypart/head
	s_req = /obj/item/rogueweapon/huntingknife/stoneknife
	e_req = /obj/item/rogueweapon/huntingknife/stoneknife
	w_req = /obj/item/rogueweapon/huntingknife/stoneknife

/datum/ritual/servantry/falseappearance/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	if(target.mob_biotypes & MOB_UNDEAD)
		to_chat(user, span_warning("The fruits of her work prevent me from changing my appearance..."))
		return
	target.randomize_human_appearance(include_donator = FALSE)
	target.regenerate_clothes()
	target.update_body()

/datum/ritual/servantry/heartache
	name = "Suffering"
	desk = "Summons a cursed heart, which may help in capturing victims. Will not help in battle."
	center_requirement = /obj/item/organ/heart

	s_req = /obj/item/alch/sinew
	w_req = /obj/item/alch/viscera

	is_cultist_ritual = TRUE

/datum/ritual/servantry/heartache/invoke(mob/user, turf/center)
	new /obj/item/corruptedheart(center)
	to_chat(user, span_notice("A corrupted heart. When used on a non-enlightened mortal their heart shall ache and they will be immobilized and too stunned to speak. Perfect for getting new soon-to-be enlightened. Now, just don't use it at the combat ready."))

/datum/ritual/servantry/luxstol
	name = "Soul fragment theft"
	desk = "A cruel ritual that takes a fragment of the victim's soul."
	center_requirement = /mob/living/carbon/human // One to be gutted.human
	center_book = "Dead body"

/datum/ritual/servantry/luxstol/invoke(mob/living/user, turf/center)
	. = ..()
	var/mob/living/carbon/human/target = locate() in center.contents
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/skeleton))
		to_chat(user, span_danger("This is a skeleton, it can no longer contain a fragment of a soul..."))
		return
	if(!target.mind)
		to_chat(user, span_danger("Zizo rejects this body."))
		return
	if(is_zizocultist(target.mind) || is_zizolackey(target.mind))
		to_chat(user, span_danger("Zizo cannot give a fragment of the soul of his own follower..."))
		return
	if(target.patron.type == /datum/patron/inhumen/zizo)
		to_chat(user, span_danger("Zizo cannot give a fragment of the soul of his own follower..."))
		return
	if(target.has_status_effect(/datum/status_effect/debuff/ritualdefiled/cult))
		to_chat(user, span_danger("Their soul is already desecrated..."))
		return
	target.Stun(30)
	target.Knockdown(30)
	target.Sleeping(60)
	new /obj/item/reagent_containers/lux(center)
	target.apply_status_effect(/datum/status_effect/debuff/ritualdefiled/cult)

/obj/item/corruptedheart
	name = "corrupted heart"
	desc = "It sparkles with forbidden magic energy. It makes all the heart aches go away."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "heart-on"
	w_class =  WEIGHT_CLASS_SMALL

/obj/item/corruptedheart/attack(mob/living/target, mob/living/user, params)
	if(!istype(user.patron, /datum/patron/inhumen/zizo))
		return
	if(istype(target.patron, /datum/patron/inhumen/zizo))
		target.blood_volume = BLOOD_VOLUME_MAXIMUM
		to_chat(target, span_notice("My elixir of life is stagnant once again."))
		qdel(src)
		return
	if(!do_after(user, 1 SECONDS, target))
		return
	if(target.cmode)
		to_chat(user, span_danger("It is impossible to use the heart when the target is tense"))
	target.Sleeping(40)
	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.silent += 80
	qdel(src)

/*/datum/ritual/servantry/darksunmark //Maybe it will need to be redone, or just fuck it
	name = "Dark Sun's Mark"
	desk = "Marks the selected creature as a cult target. Also, assassins get information about it."
	center_requirement = /obj/item/rogueweapon/huntingknife/idagger // Requires a combat dagger. Can be iron, steel or silver.

/datum/ritual/servantry/darksunmark/invoke(mob/living/user, turf/center)
	var/obj/item/rogueweapon/huntingknife/idagger/D = locate() in center.contents
	if(!D)
		to_chat(user, span_warning("A dagger is required as a sacrifice."))
		return

	var/mob/living/carbon/human/target = tgui_input_list(user, "CHOOSE TARGET", "TELEPORT", GLOB.human_list)

	if(!target)
		return

	if(!user.mind?.do_i_know(name = target.real_name))
		to_chat(user, span_warning("I didn't saw his face."))
		return

	var/assassin_found = FALSE
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HAS_TRAIT(HL, TRAIT_ASSASSIN))
			assassin_found = TRUE
			var/obj/item/rogueweapon/huntingknife/idagger/steel/profane/dagger = locate() in HL.get_all_gear()
			if(dagger)
				to_chat(HL, "profane dagger whispers, <span class='danger'>\"The terrible Zizo has called for our aid. Hunt and strike down our common foe, [target.real_name]!\"</span>")
	if(!target || !assassin_found)
		to_chat(user, span_warning("There has been no answer to your call to the Dark Sun. It seems his servants are far from here..."))
		return
	ADD_TRAIT(target, TRAIT_ZIZOID_HUNTED, TRAIT_GENERIC) // Gives the victim a trait to track that they are wanted dead.
	log_hunted("[key_name(target)] playing as [target] had the hunted flaw by Zizoid curse.")
	to_chat(target, span_danger("My hair stands on end. Has someone just said my name? I should watch my back."))
	to_chat(user, span_warning("Your target has been marked, your profane call answered by the Dark Sun. [target.real_name] will surely perish!"))
	qdel(D)
	target.playsound_local(target, 'sound/magic/marked.ogg', 100) */

/datum/ritual/servantry/devotionretrv
	name = "Restoration of enlightenment"
	desk = "Restores Zizo's holy energy for clerics."
	center_book = "Cleric"
	center_requirement = /mob/living/carbon/human
	n_req = /obj/item/natural/bone
	s_req = /obj/item/natural/bone

/datum/ritual/servantry/devotionretrv/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	target.devotion?.update_devotion(250)
// TRANSMUTATION
/datum/ritual/transmutation
	abstract_type = /datum/ritual/transmutation

/datum/ritual/transmutation/allseeingeye
	name = "All-seeing eye"
	desk = "Summons the all-seeing eye."
	center_requirement = /obj/item/organ/eyes

/datum/ritual/transmutation/allseeingeye/invoke(mob/living/user, turf/center)
	. = ..()
	new /obj/item/scrying/eye(center)
	to_chat(user, span_notice("The All-seeing Eye. To see beyond sight."))

/datum/ritual/transmutation/book
	name = "Summoning of the ritual book"
	desk = "Replaces the regular book with a book that will help new cultists with rituals."
	center_requirement = /obj/item/book/rogue

/datum/ritual/transmutation/book/invoke(mob/living/user, turf/center)
	. = ..()

	new /obj/item/recipe_book/zizo(center)

	to_chat(user, span_notice("Now you know how to make another ritual..."))

/datum/ritual/transmutation/criminalstool
	name = "Summoning of Zizo's soap"
	desk = "Summons Zizo's soap."
	center_requirement = /obj/item/natural/cloth

/datum/ritual/transmutation/criminalstool/invoke(mob/living/user, turf/center)
	new /obj/item/soap/cult(center)
	to_chat(user, span_notice("The Criminal's Tool. Could be useful for hiding tracks or getting rid of sigils."))

/obj/item/soap/cult
	name = "accursed soap"
	desc = "It is pulsating."
	color = LIGHT_COLOR_BLOOD_MAGIC
	uses = 1000

/*/datum/ritual/transmutation/propaganda
	name = "Propaganda"
	desk = "We'll change this later"
	center_requirement = /obj/item/natural/worms/leech
	n_req = /obj/item/paper
	s_req = /obj/item/natural/feather

/datum/ritual/transmutation/propaganda/invoke(mob/living/user, turf/center)
	new /obj/item/natural/worms/leech/propaganda(center)
	to_chat(user, span_notice("A leech to make their minds wrangled. They'll be in bad spirits.")) */

/datum/ritual/transmutation/invademind
	name = "Message"
	desk = "Sends a message to a creature."
	center_requirement = /obj/item/paper

/datum/ritual/transmutation/invademind/invoke(mob/living/user, turf/center)
	var/text = tgui_input_text(user, "ENTER MESSAGE", "MESSAGE")

	if(!text)
		return

	var/input = input(user, "To whom do we send this message?", "ZIZO")
	if(!input)
		return
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.real_name == input)
			to_chat(HL, "<i>You hear a voice in your head... <b>[text]</i></b>")

// FLESH CRAFTING
/datum/ritual/fleshcrafting
	abstract_type = /datum/ritual/fleshcrafting

/datum/ritual/fleshcrafting/bunnylegs
	name = "Strong Legs"
	desk = "Allows you to jump quite high."
	cultist_number = 6
	//number_cultist_for_add_limit = 1
	//ritual_limit = 1
	center_book = "Cultist"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg
	n_req = /obj/item/alch/airdust

	is_cultist_ritual = TRUE

/datum/ritual/fleshcrafting/bunnylegs/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	ADD_TRAIT(target, TRAIT_ZJUMP, TRAIT_GENERIC)
	to_chat(target, span_notice("I feel like my legs have become stronger."))

/datum/ritual/fleshcrafting/fleshmend
	name = "Dense Healing"
	desk = "Grants the target full healing."
	center_book = "The injured"
	center_requirement = /mob/living/carbon/human
	n_req =  /obj/item/alch/viscera
	s_req = /obj/item/alch/calendula

/datum/ritual/fleshcrafting/fleshmend/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	if(!target.mind)
		to_chat(user, span_warning("They are not worth saving."))
		return
	if(!target.mind.active)
		to_chat(user, span_warning("They are unresponsive to my attempts. For now."))
		return
	if(alert(target, "The Dark Lady reaches out to you. Will you take her help?", "Fleshmend", "Embrace me", "I'll be on my own") != "Embrace me")
		to_chat(user, span_notice("[target] refuses her help."))
		return
	target.playsound_local(target, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	if((!HAS_TRAIT(target, TRAIT_DNR) && !HAS_TRAIT(target, TRAIT_NECRAS_VOW)) || target.stat != DEAD)
		target.fully_heal()
		target.regenerate_limbs()
		target.heal_wounds(500)
		if(target.stat == DEAD)
			target.revive()
		target.apply_status_effect(/datum/status_effect/debuff/fleshmend_exhaustion)
		to_chat(target, span_notice("ZIZO EMPOWERS ME!"))

/datum/ritual/fleshcrafting/darkeyes
	name = "Eyes of the Night"
	desk = "Replaces the eyes with special ones that see extremely well in the dark, but there is one BUT.."
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/alch/viscera
	e_req = /obj/item/natural/bundle/bone
	n_req = /obj/item/organ/eyes

/datum/ritual/fleshcrafting/darkeyes/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	ADD_TRAIT(target, TRAIT_ZIZOEYES, TRAIT_GENERIC)
	to_chat(target, span_notice("I am no longer afraid of the dark. But now I should hide my eyes.."))

/datum/ritual/fleshcrafting/undead
	name = "Necromancer's Relic"
	desk = "By bringing gifts to Her, you can obtain a special crystal."
	ritual_limit = 2
	number_cultist_for_add_limit = 2
	center_requirement = /obj/item/natural/glass_shard

	w_req = /obj/item/organ/brain
	e_req = /obj/item/organ/brain
	n_req = /obj/item/alch/bone
	s_req = /obj/item/natural/bundle/bone

	is_cultist_ritual = TRUE

/datum/ritual/fleshcrafting/undead/invoke(mob/living/user, turf/center)

	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()
	new /obj/item/necro_relics/necro_crystal(center)
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
/*
/datum/ritual/fleshcrafting/arcane
	name = "Absorption of Arcana"
	desk = "By sacrificing a mage, it grants the cultist points for learning spells and increases his arcana skill. You need to be a mage initially..."
	cultist_number = 2
	number_cultist_for_add_limit = 3
	ritual_limit = 1
	center_book = "Cultist"
	north_book = "Mage"
	center_requirement = /mob/living/carbon/human

	n_req = /mob/living/carbon/human

	is_cultist_ritual = TRUE

/datum/ritual/fleshcrafting/arcane/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/cultist = locate() in center.contents
	var/mob/living/carbon/human/mage = locate() in get_step(center, NORTH)
	if(mage.has_status_effect(/datum/status_effect/debuff/arcynestolen))
		to_chat(cultist, span_notice("This mage is already was arcane drained..."))
		return
	mage.apply_status_effect(/datum/status_effect/debuff/arcynestolen)
	mage.Stun(30)
	mage.Knockdown(30)
	cultist.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	cultist.mind.adjust_spellpoints(16)
	to_chat(cultist, span_notice("Stolen Arcane prowess floods my mind, ZIZO empowers me."))
*/
///datum/ritual/fleshcrafting/curse
//	name = "Hollow Curse"
//	desk = "We'll change it later or delete it"
//	center_requirement = /mob/living/carbon/human

//	w_req = /obj/item/alch/sinew
//	e_req = /obj/item/alch/sinew
//	n_req = /obj/item/natural/fur/wolf
//	s_req = /obj/item/natural/fur/wolf

///datum/ritual/fleshcrafting/curse/invoke(mob/living/user, turf/center)
//	var/mob/living/carbon/human/target = locate() in center.contents
//	if(!target)
//		return
//	if(!target.mind)
//		to_chat(target, span_warning("A mindless servant is useless to me!"))
//		return
//	if(target.mob_biotypes & MOB_UNDEAD)
//		to_chat(target, span_warning("The curse doesn't take hold!"))
//		return
//	if(target.mind.has_antag_datum(/datum/antagonist/werewolf))
//		to_chat(target, span_warning("The curse doesn't take hold!"))
//		return
//	to_chat(target, span_warning("My very being, body, soul, and mind is contorted and twisted violently into a ball of flesh and fur, until I am reshaped anew as an abomination!"))
//	addtimer(CALLBACK(src, PROC_REF(get_hollowed), target, center), 5 SECONDS)

///datum/ritual/fleshcrafting/curse/proc/get_hollowed(mob/living/victim, turf/place)
//	if(QDELETED(victim))
//		return
//	if(place != get_turf(victim))
//		return
//	if(!victim.mind)
//		return
//	var/mob/living/wll = new /mob/living/carbon/human/species/demihuman(place)
//	victim.mind.transfer_to(wll)
//	victim.gib()

/datum/ritual/fleshcrafting/nopain
	name = "Painless combat"
	desk = "You will stop feeling pain due to the strong faith of your victim in Psydon"
	center_requirement = /mob/living/carbon/human
	center_book = "Cultist"
	north_book = "Believer-cleric in Psydon"
	center_requirement = /mob/living/carbon/human

	n_req = /mob/living/carbon/human

/datum/ritual/fleshcrafting/nopain/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	var/mob/living/carbon/human/victim = locate() in get_step(center, NORTH)

	if(victim.has_status_effect(/datum/status_effect/debuff/ritualdefiled/cult))
		to_chat(target, span_danger("Their soul is already desecrated..."))
		return
	if(victim.patron.type != /datum/patron/old_god)
		to_chat(target, span_danger("Someone who believes in Psydon is needed..."))
		return
	if(victim.patron.type == /datum/patron/old_god)
		ADD_TRAIT(target, TRAIT_NOPAIN, TRAIT_GENERIC)
		to_chat(target, span_notice("Thanks to his lux power, I no longer feel pain!"))
		to_chat(victim, span_danger("Oh no.. Because of the power of my faith, they have become stronger.. What should I do next.."))
		target.change_stat(STATKEY_WIL, 1)
		victim.apply_status_effect(/datum/status_effect/debuff/ritualdefiled/cult)
		victim.Stun(30)
		victim.Knockdown(30)
		victim.Sleeping(60)

/datum/ritual/fleshcrafting/immortality
	name = "Imperfect Immortality"
	desk = "By sacrificing an aasimar, you will gain many powers, but you will also pay a certain price."
	center_book = "Cultist"
	north_book = "Living Aasimar"
	center_requirement = /mob/living/carbon/human

	n_req = /mob/living/carbon/human

/datum/ritual/fleshcrafting/immortality/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	var/mob/living/carbon/human/victim = locate() in get_step(center, NORTH)
	if(!(is_species(victim, /datum/species/aasimar)))
		return
	if(victim.has_status_effect(/datum/status_effect/debuff/ritualdefiled/cult))
		to_chat(target, span_notice("This aasimar is already used in ritual..."))
		return
	victim.apply_status_effect(/datum/status_effect/debuff/ritualdefiled/cult)
	victim.Stun(30)
	victim.Knockdown(30)
	ADD_TRAIT(user, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_HARDDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_NODEATH, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_BLOODLOSS_IMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_ZOMBIE_IMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_WOUNDREGEN, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_SPELLCOCKBLOCK, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_NOSOFTCRIT, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_NOSLEEP, TRAIT_GENERIC)
	to_chat(target, span_notice("ZIZO EMPOWERS ME!! SOMETHING HAS GONE WRONG, THE RITUAL FAILED BUT WHAT IT LEFT ME WITH IS STILL POWER!!"))
	target.change_stat(STATKEY_STR, -3)
	target.change_stat(STATKEY_SPD, -3)
	target.change_stat(STATKEY_WIL, -3)
	target.Knockdown(5 SECONDS)
	target.emote("agony", forced = TRUE)
	target.mind.AddSpell(new /obj/effect/proc_holder/spell/self/zizo_regenerate)

/datum/ritual/fleshcrafting/fleshform
	name = "Combat Flesh"
	desk = "Turns the victim into a foolish living flesh."
	cultist_number = 2
	center_requirement = /mob/living/carbon/human
	center_book = "Victim"

	n_req = /obj/item/organ/heart
	is_cultist_ritual = TRUE

/datum/ritual/fleshcrafting/fleshform/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	if(is_zizocultist(target.mind))
		to_chat(target, span_danger("I'm not letting my strongest follower become a mindless brute."))
		return

	if(!target.ckey || !target.mind)
		var/list/candidates = pollGhostCandidates("Do you want to play as cultistic flesh?", null, null, null, 10 SECONDS, POLL_IGNORE_LICH_SKELETON)
		if(!LAZYLEN(candidates))
			to_chat(user, span_warning("The depths are hollow."))
			return

		var/mob/dead/mob = pick(candidates)
		if(!istype(mob))
			return

		if(istype(mob, /mob/dead/new_player))
			var/mob/dead/new_player/new_player = mob
			new_player.close_spawn_windows()

		target.key = mob.key

	to_chat(target, span_warning("SOON I WILL BECOME A HIGHER FORM!"))
	addtimer(CALLBACK(src, PROC_REF(flesh_convert), target, center), 5 SECONDS)

/datum/ritual/fleshcrafting/fleshform/proc/flesh_convert(mob/living/victim, turf/place)
	if(QDELETED(victim))
		return
	if(place != get_turf(victim))
		return
	if(!victim.mind)
		return
	var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/blood(place)
	victim.mind.transfer_to(trl)
	victim.gib()

/datum/ritual/fleshcrafting/gutted
	name = "Gutting"
	desk = "Guts the corpse, removing all organs and cutting off all limbs."
	center_requirement = /mob/living/carbon/human // One to be gutted.human
	center_book = "Dead body"

/datum/ritual/fleshcrafting/gutted/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	if(target.stat != DEAD)
		return
	target.take_overall_damage(500)
	center.visible_message(span_danger("[target] is lifted up into the air and multiple scratches, incisions and deep cuts start etching themselves into their skin as all of their internal organs spill on the floor below!"))
	var/atom/drop_location = target.drop_location()
	for(var/obj/item/organ/organ as anything in target.internal_organs)
		organ.Remove(target)
		organ.forceMove(drop_location)
	var/obj/item/bodypart/chest/cavity = target.get_bodypart(BODY_ZONE_CHEST)
	if(cavity.cavity_item)
		cavity.cavity_item.forceMove(drop_location)
		cavity.cavity_item = null
	for(var/obj/item/bodypart/part as anything in target.bodyparts)
		part.drop_limb()
	if(target.has_status_effect(/datum/status_effect/debuff/ritualdefiled/cult))
		to_chat(user, span_danger("It is already gutted"))
		return
	new /obj/item/natural/bundle/bone(center)
	new /obj/item/natural/bundle/bone(center)
	target.apply_status_effect(/datum/status_effect/debuff/ritualdefiled/cult)

/* /datum/ritual/fleshcrafting/badomen
	name = "Bad Omen"
	center_requirement = /mob/living/carbon/human
	is_cultist_ritual = TRUE

/datum/ritual/fleshcrafting/badomen/invoke(mob/living/user, turf/center)
	var/mob/living/carbon/human/target = locate() in center.contents
	if(!target)
		return
	if(target.stat == DEAD)
		target.gib(FALSE, FALSE, FALSE)
		addomen(OMEN_ROUNDSTART) */

/datum/ritual/fleshcrafting/ascend
	name = "!ASCENSION!"
	desk = "FINISH IT. COME ON!! FOR ZIZO!!!"
	center_requirement = /mob/living/carbon/human // cult leader
	n_req = /mob/living/carbon/human // the ruler
	center_book = "Leader"
	north_book = "Ascension Target"

	is_cultist_ritual = TRUE

/datum/ritual/fleshcrafting/ascend/invoke(mob/living/user, turf/center)
	//The cultists' requirement is fixed at the start of the round and no longer increases during the round.
	var/required_cultists = SSmapping.retainer.get_cult_ascension_required_cultists()
	//When changing the formula and requirement, change all of this also in /mob/living/carbon/human/proc/ascension_check() so that it matches and does not psionically affect the cultists
	var/current_cultists = length(SSmapping.retainer.cultists)

	if(current_cultists < required_cultists)
		to_chat(user, span_danger("This ritual requires at least [required_cultists] cultists, but there are only [current_cultists]. You need [required_cultists - current_cultists] more cultists."))
		return

	var/mob/living/carbon/human/cultist = locate() in center.contents
	if(!cultist || cultist != user)
		return
	if(!is_zizocultist(cultist.mind))
		return

	//Target search by priority
	var/mob/living/carbon/human/sacrifice_target = null
	var/target_role = null
	var/obj/item/clothing/head/roguetown/crown/crown_target = null

	//Priority 1: Bishop
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H.stat == DEAD)
			continue
		var/role_title
		if(H.mind && H.mind.assigned_role)
			if(istext(H.mind.assigned_role))
				role_title = H.mind.assigned_role
			else if(istype(H.mind.assigned_role))
				role_title = H.mind.assigned_role.title
			else
				role_title = null
		else
			role_title = null
		if(role_title == "Bishop")
			sacrifice_target = H
			target_role = "Bishop"
			break

	//Priority 2: Duke/King
	if(!sacrifice_target)
		if(SSticker.rulermob && istype(SSticker.rulermob, /mob/living/carbon/human))
			var/mob/living/carbon/human/ruler = SSticker.rulermob
			if(ruler.stat != DEAD)
				sacrifice_target = ruler
				target_role = "Ruler"

	//Priority 3: Right Hand
	if(!sacrifice_target)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H.stat == DEAD)
				continue
			var/role_title
			if(H.mind && H.mind.assigned_role)
				if(istext(H.mind.assigned_role))
					role_title = H.mind.assigned_role
				else if(istype(H.mind.assigned_role))
					role_title = H.mind.assigned_role.title
				else
					role_title = null
			else
				role_title = null
			if(role_title == "Hand")
				sacrifice_target = H
				target_role = "Hand"
				break

	//Priority 4: Prince or Princess
	if(!sacrifice_target)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H.stat == DEAD)
				continue
			var/role_title
			if(H.mind && H.mind.assigned_role)
				if(istext(H.mind.assigned_role))
					role_title = H.mind.assigned_role
				else if(istype(H.mind.assigned_role))
					role_title = H.mind.assigned_role.title
				else
					role_title = null
			else
				role_title = null
			if(role_title == "Prince" || role_title == "Princess")
				sacrifice_target = H
				target_role = role_title
				break

	//Priority 5: Marshal
	if(!sacrifice_target)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H.stat == DEAD)
				continue
			var/role_title
			if(H.mind && H.mind.assigned_role)
				if(istext(H.mind.assigned_role))
					role_title = H.mind.assigned_role
				else if(istype(H.mind.assigned_role))
					role_title = H.mind.assigned_role.title
				else
					role_title = null
			else
				role_title = null
			if(role_title == "Marshal")
				sacrifice_target = H
				target_role = "Marshal"
				break

	//Priority 6: Court Mage
	if(!sacrifice_target)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H.stat == DEAD)
				continue
			var/role_title
			if(H.mind && H.mind.assigned_role)
				if(istext(H.mind.assigned_role))
					role_title = H.mind.assigned_role
				else if(istype(H.mind.assigned_role))
					role_title = H.mind.assigned_role.title
				else
					role_title = null
			else
				role_title = null
			if(role_title == "Court Magician")
				sacrifice_target = H
				target_role = "Court Magician"
				break

	//Priority 7: Knight-Captain
	if(!sacrifice_target)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H.stat == DEAD)
				continue
			var/role_title
			if(H.mind && H.mind.assigned_role)
				if(istext(H.mind.assigned_role))
					role_title = H.mind.assigned_role
				else if(istype(H.mind.assigned_role))
					role_title = H.mind.assigned_role.title
				else
					role_title = null
			else
				role_title = null
			if(role_title == "Knight Captain")
				sacrifice_target = H
				target_role = "Knight Captain"
				break

	//Priority 8: Treasurer
	if(!sacrifice_target)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H.stat == DEAD)
				continue
			var/role_title
			if(H.mind && H.mind.assigned_role)
				if(istext(H.mind.assigned_role))
					role_title = H.mind.assigned_role
				else if(istype(H.mind.assigned_role))
					role_title = H.mind.assigned_role.title
				else
					role_title = null
			else
				role_title = null
			if(role_title == "Steward")
				sacrifice_target = H
				target_role = "Steward"
				break

	//Priority 9: Crown
	if(!sacrifice_target)
		for(var/obj/item/clothing/head/roguetown/crown/C in get_step(center, NORTH))
			crown_target = C
			target_role = "Crown"
			break

	if(!sacrifice_target && !crown_target)
		to_chat(user, span_danger("No suitable sacrifice found. Check ascension requirements."))
		return

	if(sacrifice_target)
		var/mob/living/carbon/human/RULER = locate() in get_step(center, NORTH)
		if(RULER != sacrifice_target)
			to_chat(user, span_danger("[sacrifice_target.real_name] ([target_role]) must stand on the northern cell of the sigil."))
			return

		if(sacrifice_target.stat == DEAD)
			to_chat(user, span_danger("[sacrifice_target.real_name] ([target_role]) must be alive for this ritual."))
			return

		sacrifice_target.gib()
		to_chat(user, span_notice("You have sacrificed [sacrifice_target.real_name], the [target_role]!"))
	else if(crown_target)
		qdel(crown_target)
		to_chat(user, span_notice("You have sacrificed the Crown!"))

	SSmapping.retainer.cult_ascended = TRUE
	addomen(OMEN_ASCEND)
	to_chat(cultist, span_userdanger("I HAVE DONE IT! I HAVE REACHED A HIGHER FORM! ZIZO SMILES UPON ME WITH MALICE IN HER EYES TOWARD THE ONES WHO LACK KNOWLEDGE AND UNDERSTANDING!"))
	var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/blood/ascended(center)
	cultist.mind?.transfer_to(trl)
	cultist.gib()
	priority_announce("The sky blackens, a dark day for Psydonia.", "Ascension", 'sound/misc/zizo.ogg')
	for(var/mob/living/carbon/human/V in GLOB.human_list)
		if(V.mind in SSmapping.retainer.cultists)
			V.add_stress(/datum/stressevent/lovezizo)
		else
			V.add_stress(/datum/stressevent/hatezizo)
	SSvote.started_time = world.time - CONFIG_GET(number/vote_delay) - 10
	SSvote.initiate_vote("endround", "AHAHAHAHAHAHAHAHAHHA")

/datum/ritual/weaponary
	abstract_type = /datum/ritual/weaponary

/datum/ritual/weaponary/zsteel
	name = "Steel creation"
	desk = "Ritual that allows you to create steel from simple pieces"
	center_requirement = /obj/item/scrap

	s_req = /obj/item/scrap
	w_req = /obj/item/scrap
	e_req = /obj/item/scrap

/datum/ritual/weaponary/zsteel/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

	new /obj/item/ingot/steel(center)

/datum/ritual/weaponary/zingot
	name = "Creating a cursed ingot"
	desk = "Ritual that allows you to summon ancient ingots that can be useful.."
	center_requirement = /obj/item/ingot/steel

	n_req = /obj/item/natural/bone
	s_req = /obj/item/natural/bone
	e_req = /obj/item/natural/bone
	w_req = /obj/item/natural/bone

/datum/ritual/weaponary/zingot/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

	new /obj/item/ingot/steel/zizo(center)

/datum/ritual/weaponary/cross
	name = "Summoning the Zizo amulet"
	desk = "Summons a special Zizo cross that will both protect and bestow Her alms."
	center_requirement = /obj/item/clothing/neck/roguetown/psicross

	n_req = /obj/item/natural/bone
	s_req = /obj/item/natural/bone
	w_req = /obj/item/natural/bone
	e_req = /obj/item/natural/bone

/datum/ritual/weaponary/cross/invoke(mob/living/user, turf/center)
	. = ..()
	new /obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy/cult(center)
	to_chat(user, span_notice("The psycross is transmuted into an amulet of Zizo."))

/datum/ritual/weaponary/repaircross
	name = "Replenish the amulet"
	desk = "Replenishes the Zizo amulet, restoring its protection."
	center_requirement = /obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy/cult

	w_req = /obj/item/natural/bone
	e_req = /obj/item/natural/bone

/datum/ritual/weaponary/repaircross/invoke(mob/living/user, turf/center)
	. = ..()
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

	new /obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy/cult(center)
	to_chat(user, span_notice("The cross can protect you again.."))

/datum/ritual/weaponary/zdagger
	name = "Creating a cursed Zizo dagger"
	desk = "Summons the Zizo dagger, which may contain poison."
	center_requirement = /obj/item/rogueweapon/huntingknife/idagger

	n_req = /obj/item/ingot/steel/zizo

/datum/ritual/weaponary/zdagger/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

	new /obj/item/rogueweapon/huntingknife/idagger/steel/cursed(center)

/datum/ritual/weaponary/summonweapon
	name = "Creating a long sword"
	desk = "Summons the Zizo long sword."
	center_requirement = /obj/item/rogueweapon/sword/long

	e_req = /obj/item/ingot/steel/zizo
	w_req = /obj/item/ingot/steel/zizo

/datum/ritual/weaponary/summonweapon/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/rogueweapon/sword/long/zizo(center)
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

/datum/ritual/weaponary/summonaxe
	name = "Creation of Battle Axe"
	desk = "Summons a specially-sharp battle axe."
	center_requirement = /obj/item/rogueweapon/stoneaxe

	n_req = /obj/item/ingot/steel/zizo

/datum/ritual/weaponary/summonaxe/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/rogueweapon/stoneaxe/battle/zizo(center)
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

/datum/ritual/weaponary/summonegreataxe
	name = "Creation of Double-Edged Two-Handed Axe"
	desk = "Summons a specially-sharp two-handed battle axe."
	center_requirement = /obj/item/rogueweapon/stoneaxe/battle/zizo

	n_req = /obj/item/ingot/steel/zizo

/datum/ritual/weaponary/summonegreataxe/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/rogueweapon/greataxe/steel/doublehead/zizo(center)
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

/datum/ritual/weaponary/summonasword
	name = "Creation of Life-Stealing Sword"
	desk = "Summons a sword that steals life energy."
	center_requirement = /obj/item/rogueweapon/sword

	n_req = /obj/item/ingot/steel/zizo

/datum/ritual/weaponary/summonasword/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/rogueweapon/sword/sabre/zizo(center)
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

/datum/ritual/weaponary/summonmace
	name = "Summoning Mace"
	desk = "Summons a special Zizo mace."
	center_requirement = /obj/item/rogueweapon/mace

	n_req = /obj/item/ingot/steel/zizo

/datum/ritual/weaponary/summonmace/invoke(mob/living/user, turf/center)

	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/rogueweapon/mace/steel/zizo(center)

	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

/datum/ritual/weaponary/summonshield
	name = "Creation of Shield"
	desk = "Summons the Zizo long sword."
	center_requirement = /obj/item/rogueweapon/shield/tower

	e_req = /obj/item/ingot/steel/zizo
	w_req = /obj/item/ingot/steel/zizo

/datum/ritual/weaponary/summonshield/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/rogueweapon/shield/tower/zizo(center)
	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

/datum/ritual/weaponary/summonneant
	name = "Summoning Scythe"
	desk = "Summons a special Zizo scythe."
	center_requirement = /obj/item/rogueweapon/scythe

	w_req = /obj/item/ingot/steel/zizo
	e_req = /obj/item/ingot/steel/zizo
	n_req = /obj/item/reagent_containers/lux
	s_req = /obj/item/natural/bone

/datum/ritual/weaponary/summonneant/invoke(mob/living/user, turf/center)

	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/rogueweapon/zizo/neant(center)

	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

/datum/ritual/weaponary/summonoutfit
	name = "Summoning Cult Robe and Rope"
	desk = "Summons cult equipment. Light robe, hood, and rope."
	center_requirement = /obj/item/natural/cloth

	n_req = /obj/item/natural/hide

/datum/ritual/weaponary/summonoutfit/invoke(mob/living/user, turf/center)
	var/datum/effect_system/spark_spread/S = new(center)
	S.set_up(1, 1, center)
	S.start()

	new /obj/item/clothing/head/roguetown/helmet/skullcap/cult(center)

	//new /obj/item/clothing/cloak/shadowcloak/cult(center)

	new /obj/item/clothing/suit/roguetown/armor/leather/studded/cult(center)

	new /obj/item/rope(center)

	playsound(get_turf(center), pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
