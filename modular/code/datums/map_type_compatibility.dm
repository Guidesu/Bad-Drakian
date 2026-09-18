/*
 * Compatibility paths retained for maps authored against older Azure Peak and
 * Ratwood type names. Keep these aliases narrow: maps can load without losing
 * their placed atoms while current code remains canonical.
 */

/mob/living/carbon/human/species/skeleton/npc/medium/noequip
	parent_type = /mob/living/carbon/human/species/skeleton/npc/no_equipment

/mob/living/carbon/human/species/skeleton/npc/special/vile_doctor
	parent_type = /mob/living/carbon/human/species/skeleton/npc/medium
	name = "vile doctor"

/mob/living/simple_animal/hostile/retaliate/rogue/orc/ranged
	parent_type = /mob/living/simple_animal/hostile/retaliate/rogue
	name = "orcish skirmisher"

/obj/item/rogueweapon/huntingknife/idagger/silver/elvish/drow
	parent_type = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
	name = "dark elvish dagger"
	desc = "A vicious wave-bladed dagger from the Underdark."
	force = 18
	is_silver = TRUE

/obj/item/clothing/head/roguetown/tw_d_feathers
	parent_type = /obj/item/clothing/head/roguetown/onhelm/tw_d_feathers

/obj/item/rogueweapon/chisel/assembly/hammerbronze/bronze
	parent_type = /obj/item/rogueweapon/chisel/assembly

/obj/effect/decal/cleanable/roguerune/arcyne/teleport
	parent_type = /obj/effect/decal/cleanable/roguerune/arcyne

/obj/item/rogueweapon/sword/saber/iron
	parent_type = /obj/item/rogueweapon/sword/iron
	name = "iron saber"

/obj/item/gun/ballistic/revolver/grenadelauncher/bow/classic
	parent_type = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	name = "bow"
	desc = "The bow is your life; to hold it high and draw the string is to know the path of destiny."

/obj/effect/decal/cleanable/roguerune/god/baotha
	parent_type = /obj/effect/decal/cleanable/roguerune/god

/obj/item/reagent_containers/food/snacks/egg
	parent_type = /obj/item/reagent_containers/food/snacks/rogue/egg

/obj/item/reagent_containers/food/snacks/rogue/meat/steak/wolf
	parent_type = /obj/item/reagent_containers/food/snacks/rogue/meat/wolf

/obj/item/rogueweapon/bakers_peel
	parent_type = /obj/item/storage/bag/tray/peel
