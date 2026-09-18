/**
 * Focused controller for Ratwood cursed chastity devices.
 *
 * Ratwood's full collar controller also controls speech, combat, hallucinations,
 * blood, and SexCon state. Those unrelated systems are deliberately not coupled
 * to chastity here. This component retains the cursed-device controls while
 * respecting the wearer's content preferences at every command boundary.
 */
/datum/component/collar_master
	var/datum/mind/mindparent
	var/list/my_pets = list()
	var/list/registered_pets = list()

/datum/component/collar_master/Initialize(...)
	. = ..()
	if(!istype(parent, /datum/mind))
		return COMPONENT_INCOMPATIBLE
	mindparent = parent

/datum/component/collar_master/Destroy(force, silent)
	for(var/mob/living/carbon/human/wearer as anything in my_pets.Copy())
		release_pet(wearer)
	mindparent = null
	return ..()

/datum/component/collar_master/_JoinParent()
	. = ..()
	if(mindparent?.current)
		mindparent.current.verbs += /mob/proc/cursed_chastity_controls

/datum/component/collar_master/_RemoveFromParent()
	if(mindparent?.current)
		mindparent.current.verbs -= /mob/proc/cursed_chastity_controls
	return ..()

/datum/component/collar_master/proc/get_pet_cursed_chastity(mob/living/carbon/human/wearer)
	if(!wearer || !(wearer in my_pets))
		return null
	var/obj/item/chastity/device = wearer.chastity_device
	if(!istype(device) || !device.chastity_cursed || device.chastity_master != mindparent)
		return null
	return device

/datum/component/collar_master/proc/add_pet(mob/living/carbon/human/wearer)
	if(!wearer || wearer in my_pets)
		return FALSE
	if(wearer.client?.prefs && (!wearer.client.prefs.chastenable || !wearer.client.prefs.cursed_collarable))
		return FALSE
	var/obj/item/chastity/device = wearer.chastity_device
	if(!istype(device) || !device.chastity_cursed || device.chastity_master != mindparent)
		return FALSE
	my_pets += wearer
	registered_pets += wearer
	ADD_TRAIT(device, TRAIT_NODROP, CURSED_ITEM_TRAIT)
	to_chat(wearer, span_userdanger("The cursed chastity device seals itself under its master's control."))
	return TRUE

/datum/component/collar_master/proc/remove_pet(mob/living/carbon/human/wearer)
	if(!wearer)
		return FALSE
	my_pets -= wearer
	registered_pets -= wearer
	return TRUE

/datum/component/collar_master/proc/cleanup_pet(mob/living/carbon/human/wearer)
	return remove_pet(wearer)

/datum/component/collar_master/proc/release_pet(mob/living/carbon/human/wearer)
	var/obj/item/chastity/device = get_pet_cursed_chastity(wearer)
	if(!device)
		remove_pet(wearer)
		return FALSE
	device.remove_chastity(wearer)
	device.forceMove(get_turf(wearer))
	to_chat(wearer, span_notice("The cursed device releases you and falls away."))
	log_chastity_command(wearer, mindparent, "release", "remote=TRUE", TRUE)
	return TRUE

/datum/component/collar_master/proc/set_pet_chastity_lock(mob/living/carbon/human/wearer, should_lock)
	var/obj/item/chastity/device = get_pet_cursed_chastity(wearer)
	return device?.set_cursed_lock(wearer, should_lock)

/datum/component/collar_master/proc/set_pet_chastity_front_mode(mob/living/carbon/human/wearer, mode)
	var/obj/item/chastity/device = get_pet_cursed_chastity(wearer)
	return device?.set_cursed_front_mode(wearer, mode)

/datum/component/collar_master/proc/set_pet_chastity_anal_open(mob/living/carbon/human/wearer, should_open)
	var/obj/item/chastity/device = get_pet_cursed_chastity(wearer)
	return device?.set_cursed_anal_open(wearer, should_open)

/datum/component/collar_master/proc/set_pet_chastity_spikes(mob/living/carbon/human/wearer, should_enable)
	var/obj/item/chastity/device = get_pet_cursed_chastity(wearer)
	return device?.set_cursed_spikes(wearer, should_enable)

/datum/component/collar_master/proc/set_pet_chastity_flat(mob/living/carbon/human/wearer, should_be_flat)
	var/obj/item/chastity/device = get_pet_cursed_chastity(wearer)
	return device?.set_cursed_flat(wearer, should_be_flat)

/mob/proc/cursed_chastity_controls()
	set name = "Cursed Chastity Controls"
	set category = "IC"
	if(!mind)
		return
	var/datum/component/collar_master/controller = mind.GetComponent(/datum/component/collar_master)
	if(!controller || !length(controller.my_pets))
		to_chat(src, span_warning("I control no cursed chastity devices."))
		return
	var/mob/living/carbon/human/wearer = input(src, "Choose a bound wearer.", "Cursed Chastity") as null|anything in controller.my_pets
	if(!wearer || !(wearer in controller.my_pets))
		return
	var/obj/item/chastity/device = controller.get_pet_cursed_chastity(wearer)
	if(!device)
		controller.remove_pet(wearer)
		return
	var/list/actions = list("Lock", "Unlock", "Seal front", "Open penis", "Open vagina", "Open front", "Seal anal", "Open anal", "Enable flat cage", "Disable flat cage", "Deploy spikes", "Retract spikes", "Release wearer")
	var/action = input(src, "Choose a command for [wearer].", "Cursed Chastity") as null|anything in actions
	switch(action)
		if("Lock")
			controller.set_pet_chastity_lock(wearer, TRUE)
		if("Unlock")
			controller.set_pet_chastity_lock(wearer, FALSE)
		if("Seal front")
			controller.set_pet_chastity_front_mode(wearer, 0)
		if("Open penis")
			controller.set_pet_chastity_front_mode(wearer, 1)
		if("Open vagina")
			controller.set_pet_chastity_front_mode(wearer, 2)
		if("Open front")
			controller.set_pet_chastity_front_mode(wearer, 3)
		if("Seal anal")
			controller.set_pet_chastity_anal_open(wearer, FALSE)
		if("Open anal")
			controller.set_pet_chastity_anal_open(wearer, TRUE)
		if("Enable flat cage")
			controller.set_pet_chastity_flat(wearer, TRUE)
		if("Disable flat cage")
			controller.set_pet_chastity_flat(wearer, FALSE)
		if("Deploy spikes")
			controller.set_pet_chastity_spikes(wearer, TRUE)
		if("Retract spikes")
			controller.set_pet_chastity_spikes(wearer, FALSE)
		if("Release wearer")
			controller.release_pet(wearer)
