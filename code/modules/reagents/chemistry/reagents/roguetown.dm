/datum/reagent/miasmagas
	name = "miasmagas"
	description = "."
	color = "#801E28" // rgb: 128, 30, 40
	taste_description = "ugly"
	metabolization_rate = 1

/datum/reagent/miasmagas/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NOSTINK) && !physician_mask_check(M))
		M.add_nausea(15)
		M.add_stress(/datum/stressevent/miasmagas)
	return ..()

/proc/physician_mask_check(mob/living/carbon/M)
	if(!M)
		return FALSE
	if(!istype(M, /mob/living/carbon/human))
		return FALSE
	var/mob/living/carbon/human/H = M
	if(!H.wear_mask)
		return FALSE
	return istype(H.wear_mask, /obj/item/clothing/mask/rogue/physician)

/datum/reagent/rogueacid
	name = "rogueacid"
	description = "."
	reagent_state = LIQUID
	color = "#5eff00"
	taste_description = "burning"
	self_consuming = TRUE

/datum/reagent/rogueacid/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	M.adjustFireLoss(35, 0)
	..()

/// Natural venom delivered by Lamia and Arachnid bite holds.
/datum/reagent/lamia_venom
	name = "Lamia Venom"
	description = "A burning venom produced by several serpentine and arachnid peoples."
	reagent_state = LIQUID
	color = "#083b1c"
	taste_description = "liquid fire"
	metabolization_rate = 0.3 * REAGENTS_METABOLISM
	harmful = TRUE

/datum/reagent/lamia_venom/on_mob_life(mob/living/carbon/victim)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(istype(human_victim.dna?.species, /datum/species/lamia) || istype(human_victim.dna?.species, /datum/species/arachnid))
			return ..()
	if(!HAS_TRAIT(victim, TRAIT_INFINITE_STAMINA) && victim.stamina <= victim.max_stamina / 2)
		victim.stamina_add(10)
	victim.adjust_drugginess(1)
	if(prob(10))
		to_chat(victim, span_warning("My flesh burns as venom spreads through me!"))
		if(prob(1))
			victim.emote("agony")
	return ..()
