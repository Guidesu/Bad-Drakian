/datum/supply_pack/rogue/blackmarket_diplomacy/fake_resident_manuscript
	name = "Suspicious letter from a resident"
	cost = 100
	contains = list(/obj/item/book/granter/resident_manuscript/fake)

/datum/supply_pack/rogue/blackmarket_diplomacy/fake_resident_manuscript/New()
	. = ..()
	if(!resident_manuscripts_enabled())
		contains = null

/datum/supply_pack/rogue/luxury/resident_manuscript_blank
	name = "Clean certificate of a resident"
	cost = 35
	contains = list(/obj/item/book/granter/resident_manuscript/blank)

/datum/supply_pack/rogue/luxury/resident_manuscript_blank/New()
	. = ..()
	if(!resident_manuscripts_enabled())
		contains = null
