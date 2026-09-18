/datum/job/roguetown/lord/proc/apply_sovereign_name_title(mob/living/H)
	if(ishuman(H))
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/nobility = SSticker.rulertype || (H.titles_pref == TITLES_F ? "Countess" : "Count")
		H.real_name = "[nobility] [prev_real_name]"
		H.name = "[nobility] [prev_name]"

		for(var/X in peopleknowme)
			for(var/datum/mind/MF in get_minds(X))
				if(MF.known_people)
					MF.known_people -= prev_real_name
					H.mind.person_knows_me(MF)
