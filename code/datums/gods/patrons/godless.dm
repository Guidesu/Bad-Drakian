/datum/patron/godless
	name = "Godless"
	rusgodnames = list(
		"Godlessness", "Godlessness", "Godlessness", "Godlessness", "Godlessness", "Atheism"
	)
	domain = "Humanity"
	desc = "Gods exist, but you either don’t know them or don’t worship them. You follow your instincts or your mind."
	worshippers = "Animals incapable of thinking and true cynics."
	associated_faith = /datum/faith/godless
	preference_accessible = FALSE
	undead_hater = FALSE
	confess_lines = list(
		"GODS ARE NOTHING!",
		"I DON'T NEED GODS!",
		"NO GODS - NO MASTERS!",
	)

/datum/patron/godless/can_pray(mob/living/follower)
	. = ..()
	to_chat(follower, span_danger("You don't worship gods. Who do you pray to?"))
	return FALSE

/datum/patron/godless/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("Without any reason, [target] is healed!")
	*message_self = span_notice("My wounds are closing for no reason.")
