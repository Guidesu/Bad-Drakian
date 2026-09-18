/datum/mob_descriptor/age
	name = "Age"
	slot = MOB_DESCRIPTOR_SLOT_AGE
	verbage = "%LOOK%"

/datum/mob_descriptor/age/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	return TRUE

/datum/mob_descriptor/age/get_description(mob/living/described)
	var/mob/living/carbon/human/H = described
	if(H.age == AGE_OLD)
		return "old"
	else if (H.age == AGE_MIDDLEAGED)
		return "middle-aged"
	else
		return "adult"

/datum/mob_descriptor/penis
	name = "penis"
	slot = MOB_DESCRIPTOR_SLOT_PENIS
	verbage = "%HAVE%"
	show_obscured = TRUE

/datum/mob_descriptor/penis/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/penis/penis = H.getorganslot(ORGAN_SLOT_PENIS)
	if(!penis)
		return FALSE
	if(H.underwear)
		return FALSE
	if(!get_location_accessible(H, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return TRUE

/datum/mob_descriptor/penis/get_description(mob/living/described)
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/penis/penis = H.getorganslot(ORGAN_SLOT_PENIS)
	var/adjective
	var/arousal_modifier
	switch(penis.penis_size)
		if(1)
			adjective = "a small"
		if(2)
			adjective = "an average"
		if(3)
			adjective = "a large"
	var/list/arousal_data = list()
	SEND_SIGNAL(H, COMSIG_SEX_GET_AROUSAL, arousal_data)
	switch(arousal_data["arousal"])
		if(80 to INFINITY)
			arousal_modifier = ", throbbing violently"
		if(50 to 80)
			arousal_modifier = ", turgid and leaky"
		if(20 to 50)
			arousal_modifier = ", stiffened and twitching"
		else
			arousal_modifier = ", soft and flaccid"
	var/used_name
	if(penis.erect_state != ERECT_STATE_HARD && penis.sheath_type != SHEATH_TYPE_NONE)
		switch(penis.sheath_type)
			if(SHEATH_TYPE_NORMAL)
				if(penis.penis_size == 3)
					used_name = "a fat sheath"
				else
					used_name = "a sheath"
			if(SHEATH_TYPE_SLIT)
				used_name = "a genital slit"
	else
		used_name = "[adjective] [penis.name][arousal_modifier]"
	return "[used_name]"

/datum/mob_descriptor/testicles
	name = "balls"
	slot = MOB_DESCRIPTOR_SLOT_TESTICLES
	verbage = "%HAVE%"
	show_obscured = TRUE

/datum/mob_descriptor/testicles/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/testicles/testes = H.getorganslot(ORGAN_SLOT_TESTICLES)
	if(!testes)
		return FALSE
	if(H.underwear)
		return FALSE
	if(!get_location_accessible(H, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	var/obj/item/organ/penis/penis = H.getorganslot(ORGAN_SLOT_PENIS)
	if(penis && penis.sheath_type == SHEATH_TYPE_SLIT) //If our penis hides in a slit, dont describe testicles
		return FALSE
	return TRUE

/datum/mob_descriptor/testicles/get_description(mob/living/described)
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/testicles/testes = H.getorganslot(ORGAN_SLOT_TESTICLES)
	var/adjective
	switch(testes.ball_size)
		if(1)
			adjective = "a small"
		if(2)
			adjective = "an average"
		if(3)
			adjective = "a large"
	return "[adjective] pair of balls"

/datum/mob_descriptor/vagina
	name = "vagina"
	slot = MOB_DESCRIPTOR_SLOT_VAGINA
	verbage = "%HAVE%"
	show_obscured = TRUE

/datum/mob_descriptor/vagina/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/vagina/vagina = H.getorganslot(ORGAN_SLOT_VAGINA)
	if(!vagina)
		return FALSE
	if(H.underwear)
		return FALSE
	if(!get_location_accessible(H, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return TRUE

/datum/mob_descriptor/vagina/get_description(mob/living/described)
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/vagina/vagina = H.getorganslot(ORGAN_SLOT_VAGINA)
	var/vagina_type
	var/arousal_modifier
	switch(vagina.accessory_type)
		if(/datum/sprite_accessory/vagina/human)
			vagina_type = "plain vagina"
		if(/datum/sprite_accessory/vagina/hairy)
			vagina_type = "hairy vagina"
		if(/datum/sprite_accessory/vagina/spade)
			vagina_type = "spade vagina"
		if(/datum/sprite_accessory/vagina/furred)
			vagina_type = "furred vagina"
		if(/datum/sprite_accessory/vagina/gaping)
			vagina_type = "gaping vagina"
		if(/datum/sprite_accessory/vagina/cloaca)
			vagina_type = "cloaca"
	var/list/arousal_data = list()
	SEND_SIGNAL(H, COMSIG_SEX_GET_AROUSAL, arousal_data)
	switch(arousal_data["arousal"])
		if(80 to INFINITY)
			arousal_modifier = ", gushing with arousal"
		if(50 to 80)
			arousal_modifier = ", slickened with arousal"
		if(20 to 50)
			arousal_modifier = ", wet with arousal"
	return "a [vagina_type][arousal_modifier]"

/datum/mob_descriptor/breasts
	name = "breasts"
	slot = MOB_DESCRIPTOR_SLOT_BREASTS
	verbage = "%HAVE%"
	show_obscured = TRUE

/datum/mob_descriptor/breasts/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/breasts/breasts = H.getorganslot(ORGAN_SLOT_BREASTS)
	if(!breasts)
		return FALSE
	if(H.underwear && H.underwear.covers_breasts)
		return FALSE
	if(!get_location_accessible(H, BODY_ZONE_CHEST))
		return FALSE
	return TRUE

/datum/mob_descriptor/breasts/get_description(mob/living/described)
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/breasts/breasts = H.getorganslot(ORGAN_SLOT_BREASTS)
	var/adjective
	switch(breasts.breast_size)
		if(0)
			adjective = "a flat"
		if(1)
			adjective = "a very small"
		if(2)
			adjective = "a small"
		if(3)
			adjective = "an average"
		if(4)
			adjective = "a large"
		if(5)
			adjective = "an enormous"
	return "[adjective] pair of breasts"

/datum/mob_descriptor/pubes
	name = "pubic hair"
	slot = MOB_DESCRIPTOR_SLOT_PUBES
	verbage = "%HAVE%"
	show_obscured = TRUE

/datum/mob_descriptor/pubes/proc/get_feature(mob/living/carbon/human/human)
	if(!human.get_bodypart(BODY_ZONE_CHEST))
		return
	return human.get_bodypart_feature_of_slot(BODYPART_FEATURE_PUBES)

/datum/mob_descriptor/pubes/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/human = described
	var/datum/bodypart_feature/pubes/feature = get_feature(human)
	if(!feature?.accessory_type)
		return FALSE
	if(human.underwear || !get_location_accessible(human, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return is_human_part_visible(human, HIDEJUMPSUIT|HIDECROTCH)

/datum/mob_descriptor/pubes/can_user_see(mob/living/described, mob/user)
	return !user?.client?.prefs || user.client.prefs.show_pubic_hair

/datum/mob_descriptor/pubes/get_description(mob/living/described)
	var/mob/living/carbon/human/human = described
	var/datum/bodypart_feature/pubes/feature = get_feature(human)
	var/material = feature?.get_description_name() || "pubic hair"
	switch(feature?.accessory_type)
		if(/datum/sprite_accessory/pubes/hairy)
			return "a dense growth of [material]"
		if(/datum/sprite_accessory/pubes/trim)
			return "neatly trimmed [material]"
		if(/datum/sprite_accessory/pubes/strip)
			return "a narrow strip of [material]"
		if(/datum/sprite_accessory/pubes/heart)
			return "heart-shaped [material]"
		if(/datum/sprite_accessory/pubes/extreme)
			return "an untamed growth of [material]"
		if(/datum/sprite_accessory/pubes/cross)
			return "[material] shaped into a Psycross"
	return material

/datum/mob_descriptor/pits
	name = "armpit hair"
	slot = MOB_DESCRIPTOR_SLOT_PITS
	verbage = "%HAVE%"
	show_obscured = TRUE

/datum/mob_descriptor/pits/proc/get_feature(mob/living/carbon/human/human)
	if(!human.get_bodypart(BODY_ZONE_CHEST))
		return
	return human.get_bodypart_feature_of_slot(BODYPART_FEATURE_PITS)

/datum/mob_descriptor/pits/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/human = described
	var/datum/bodypart_feature/pits/feature = get_feature(human)
	if(!feature?.accessory_type)
		return FALSE
	if(human.underwear?.covers_breasts || !get_location_accessible(human, BODY_ZONE_CHEST))
		return FALSE
	return is_human_part_visible(human, HIDEBOOB|HIDEJUMPSUIT)

/datum/mob_descriptor/pits/can_user_see(mob/living/described, mob/user)
	return !user?.client?.prefs || user.client.prefs.show_armpit_hair

/datum/mob_descriptor/pits/get_description(mob/living/described)
	var/mob/living/carbon/human/human = described
	var/datum/bodypart_feature/pits/feature = get_feature(human)
	var/material = feature?.get_description_name() || "armpit hair"
	switch(feature?.accessory_type)
		if(/datum/sprite_accessory/pits/trim)
			return "a short, trimmed growth of [material]"
		if(/datum/sprite_accessory/pits/moderate)
			return "a few wisps of [material]"
		if(/datum/sprite_accessory/pits/hairy)
			return "a dense growth of [material]"
		if(/datum/sprite_accessory/pits/extreme)
			return "an untamed growth of [material]"
	return material
