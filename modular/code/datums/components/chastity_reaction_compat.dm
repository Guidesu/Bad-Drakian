/// Compatibility component used until the canonical Ratwood SexCon signal payload is active.
/datum/component/intimate_reaction/chastity_receive_flavor
	var/mob/living/carbon/human/wearer

/datum/component/intimate_reaction/chastity_receive_flavor/Initialize()
	if(!istype(parent, /obj/item/chastity))
		return COMPONENT_INCOMPATIBLE

/datum/component/intimate_reaction/chastity_receive_flavor/proc/bind_to_wearer(mob/living/carbon/human/H)
	wearer = H
	return TRUE

/datum/component/intimate_reaction/chastity_receive_flavor/proc/unbind_from_wearer(mob/living/carbon/human/H)
	if(!H || H == wearer)
		wearer = null
	return TRUE
