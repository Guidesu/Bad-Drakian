GLOBAL_LIST_EMPTY(loadout_items)
GLOBAL_LIST_EMPTY(loadout_items_by_name)
GLOBAL_LIST_EMPTY(loadout_items_by_category)

/datum/loadout_item
	var/name = "Parent loadout datum"
	var/desc
	var/atom/movable/path
	var/donoritem			//autoset on new if null
	var/donatitem = FALSE
	var/donat_tier = 0
	var/list/ckeywhitelist
	var/list/donat_ignore
	var/triumph_cost = 0
	var/category = "Miscellaneous"

/datum/loadout_item/New()
	if(isnull(donoritem))
		if(ckeywhitelist)
			donoritem = TRUE

	if(!path)
		desc = desc || ""
		return

	var/obj/targetitem = path
	desc = targetitem?.desc || desc || ""
	if(triumph_cost)
		if(length(desc))
			desc += " "
		desc += "<b>Costs [triumph_cost] points.</b>"

/datum/loadout_item/proc/donator_ckey_check(key)
	key = ckey(key)
	return !!key

/datum/loadout_item/proc/donat_ignore_ckey_check(key)
	key = ckey(key)
	if(donat_ignore && donat_ignore.Find(key))
		return TRUE
	return FALSE

/datum/loadout_item/proc/get_loadout_lock_reason(mob/user)
	if(!user?.ckey)
		return "Not available."

	if(donat_ignore_ckey_check(user.ckey))
		return null

	// Legacy donation flags are intentionally non-gating. All players have level 5.

	return null

/proc/get_donator_triumph_discount(key)
	key = ckey(key)
	if(!key)
		return 0
	return 15

//Miscellaneous
/datum/loadout_item/card_deck
	name = "Card Deck"
	category = "Miscellaneous"
	path = /obj/item/toy/cards/deck

/datum/loadout_item/farkle_dice
	name = "Farkle Dice Container"
	category = "Miscellaneous"
	path = /obj/item/storage/pill_bottle/dice/farkle

/datum/loadout_item/tarot_deck
	name = "Tarot Deck"
	category = "Miscellaneous"
	path = /obj/item/toy/cards/deck/tarot

/datum/loadout_item/bibble
	name = "The Verses and Acts of the Ten"
	category = "Miscellaneous"
	path = /obj/item/book/rogue/bibble

/datum/loadout_item/bibble_psy
	name = "Psy Bible"
	category = "Miscellaneous"
	path = /obj/item/book/rogue/bibble/psy

/datum/loadout_item/custom_book
	name = "Custom Book"
	category = "Miscellaneous"
	path = /obj/item/book/rogue/loadoutbook

//TOOLS
/datum/loadout_item/paper_parasol
	name = "Paper Parasol"
	category = "Miscellaneous"
	path = /obj/item/rogueweapon/mace/parasol

/datum/loadout_item/fine_parasol
	name = "Fine Parasol"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogueweapon/mace/parasol/noble
	donatitem = TRUE

/datum/loadout_item/broom
	name = "Broom"
	category = list("Miscellaneous", "Points")
	path = /obj/item/broom
	triumph_cost = 3

/datum/loadout_item/bucket
	name = "Bucket"
	category = list("Miscellaneous", "Points")
	path = /obj/item/reagent_containers/glass/bucket
	triumph_cost = 3

/datum/loadout_item/needle
	name = "Sewing Needle"
	category = list("Miscellaneous", "Points")
	path = /obj/item/needle/thorn
	triumph_cost = 2

/datum/loadout_item/whetstone
	name = "Whetstone"
	category = list("Miscellaneous", "Points")
	path = /obj/item/natural/whetstone
	triumph_cost = 2

/datum/loadout_item/hammer
	name = "Wood Mallet"
	category = list("Miscellaneous", "Points")
	path = /obj/item/rogueweapon/hammer/wood
	triumph_cost = 4

/datum/loadout_item/axe
	name = "Stone Axe"
	category = list("Miscellaneous", "Points")
	path = /obj/item/rogueweapon/stoneaxe
	triumph_cost = 4

/datum/loadout_item/knife
	name = "Stone Knife"
	category = list("Miscellaneous", "Points")
	path = /obj/item/rogueweapon/huntingknife/stoneknife
	triumph_cost = 3

/datum/loadout_item/hoe
	name = "Stone Hoe"
	category = list("Miscellaneous", "Points")
	path = /obj/item/rogueweapon/hoe/stone
	triumph_cost = 4

/datum/loadout_item/spade
	name = "Wood Spade"
	category = list("Miscellaneous", "Points")
	path = /obj/item/rogueweapon/shovel/small
	triumph_cost = 4

/datum/loadout_item/mirror
	name = "Hand Mirror"
	category = list("Miscellaneous", "Points")
	path = /obj/item/handmirror
	triumph_cost = 6

//HATS

/datum/loadout_item/chaperon
	name = "Chaperon (Normal)"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/chaperon

/datum/loadout_item/chaperon/alt
	name = "Chaperon (Alt)"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/chaperon/greyscale

/datum/loadout_item/chaperon/burgherc
	name = "Noble's Chaperon"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/chaperon/noble
	donatitem = TRUE

/datum/loadout_item/shalal
	name = "Keffiyeh"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal

/datum/loadout_item/tricorn
	name = "Tricorn Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/helmet/tricorn

/datum/loadout_item/nurseveil
	name = "Nurse Veil"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/veiled

/datum/loadout_item/archercap
	name = "Archer's Cap"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/archercap

/datum/loadout_item/strawhat
	name = "Straw Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/strawhat

/datum/loadout_item/eaststrawhat
	name = "Worn rice hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/eaststrawhat

/datum/loadout_item/tw_d_horns
	name = "Horns Helmkleinod"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_horns
	triumph_cost = 20

/datum/loadout_item/tw_d_basic
	name = "Helm's Chaperon"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_basic

/datum/loadout_item/tw_d_castle_red
	name = "Castle Helmkleinod"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_castle_red
	triumph_cost = 20

/datum/loadout_item/tw_d_graggar
	name = "Bloodied Star Helmkleinod"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_graggar
	triumph_cost = 20

/datum/loadout_item/tw_d_efreet
	name = "Afreet Helmkleinod"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_efreet
	triumph_cost = 15

/datum/loadout_item/tw_d_feathers
	name = "Feathers Accessory"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_feathers
	triumph_cost = 15

/datum/loadout_item/tw_d_oathtaker
	name = "Oathtaker Symbol"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_oathtaker
	triumph_cost = 15

/datum/loadout_item/tw_d_windmill
	name = "Windmill Helmkleinod"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_windmill
	triumph_cost = 15

/datum/loadout_item/tw_d_swan
	name = "Swan on Lake"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_swan
	triumph_cost = 15

/datum/loadout_item/tw_d_dragon_red
	name = "Dragon's Dread"
	category = list("Hats", "Points")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_dragon_red
	triumph_cost = 15

/datum/loadout_item/antlers
	name = "Old Antlers"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/antlers

/datum/loadout_item/headscarf
	name = "Head Scarf"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/hscarf

/datum/loadout_item/tengai
	name = "Tengai"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/tengai

/datum/loadout_item/burgerhood
	name = "Noble Hood"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/roguehood/burgerhood

/datum/loadout_item/gasa
	name = "Gasa"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/gasa

/datum/loadout_item/torioigasa
	name = "Torioigasa"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/torioigasa

/datum/loadout_item/roningasa
	name = "Roningasa"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/roningasa

/datum/loadout_item/witchhat
	name = "Witch Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/witchhat

/datum/loadout_item/bardhat
	name = "Bard Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/bardhat

/datum/loadout_item/fancyhat
	name = "Fancy Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/fancyhat

/datum/loadout_item/furhat
	name = "Fur Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/hatfur

/datum/loadout_item/smokingcap
	name = "Smoking Cap"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/smokingcap

/datum/loadout_item/headband
	name = "Headband"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/headband

/datum/loadout_item/buckled_hat
	name = "Buckled Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/puritan

/datum/loadout_item/folded_hat
	name = "Folded Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/bucklehat

/datum/loadout_item/duelist_hatc
	name = "Duelist's Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/duelhat

/datum/loadout_item/hood
	name = "Hood"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/roguehood

/datum/loadout_item/hijab
	name = "Hijab"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab

/datum/loadout_item/heavyhood
	name = "Heavy Hood"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood

/datum/loadout_item/nunveil
	name = "Nun Veil"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/nun

/datum/loadout_item/papakha
	name = "Papakha"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/papakha

/datum/loadout_item/rosa_crown
	name = "Rosa Crown"
	category = "Hats"
	path = /obj/item/flowercrown/rosa

/datum/loadout_item/salvia_crown
	name = "Salvia Crown"
	category = "Hats"
	path = /obj/item/flowercrown/salvia

/datum/loadout_item/matricaria_crown
	name = "Matricaria Crown"
	category = "Hats"
	path = /obj/item/flowercrown/matricaria

/datum/loadout_item/calendula_crown
	name = "Calendula Crown"
	category = "Hats"
	path = /obj/item/flowercrown/calendula

/datum/loadout_item/manabloom_crown
	name = "Manabloom Crown"
	category = "Hats"
	path = /obj/item/flowercrown/manabloom

/datum/loadout_item/briar_crown
	name = "Briar Thorn Crown"
	category = "Hats"
	path = /obj/item/flowercrown/briar

/datum/loadout_item/briarthorns
	name = "Briar Thorns"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/briarthorns

/datum/loadout_item/loudmouth_headgear
	name = "Loudmouth's Headcover"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/veiled/loudmouth
	donat_tier = 2

//CLOAKS
/datum/loadout_item/tabard
	name = "Tabard"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard

/datum/loadout_item/surcoat
	name = "Surcoat"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard/stabard

/datum/loadout_item/jupon
	name = "Jupon"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard/stabard/surcoat

/datum/loadout_item/bandolier
	name = "Bandolier"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/bandolier

/datum/loadout_item/jupon_short
	name = "Short Jupon"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard/stabard/surcoat/short

/datum/loadout_item/cape
	name = "Cape"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/cape

/datum/loadout_item/halfcloak
	name = "Halfcloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/half

/datum/loadout_item/ridercloak
	name = "Rider Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/half/rider

/datum/loadout_item/raincloak
	name = "Rain Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/raincloak

/datum/loadout_item/furcloak
	name = "Fur Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/raincloak/furcloak

/datum/loadout_item/wickercloak
	name = "Wicker Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/wickercloak

/datum/loadout_item/direcloak
	name = "Direbear Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/darkcloak/bear

/datum/loadout_item/lightdirecloak
	name = "Light Direbear Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/darkcloak/bear/light

/datum/loadout_item/volfmantle
	name = "Volf Mantle"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/volfmantle

/datum/loadout_item/eastcloak2
	name = "Leather Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/eastcloak2

/datum/loadout_item/thief_cloakc
	name = "Rapscallion's Shawl"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/thief_cloak

/datum/loadout_item/tabardscarlet
	name = "Tabard, Scarlet"
	category = "Raincoats"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/tabardscarlet

/datum/loadout_item/shroudscarlet
	name = "Tabard Shroud, Scarlet"
	category = "Raincoats"
	path = /obj/item/clothing/head/roguetown/roguehood/shroudscarlet

/datum/loadout_item/tabardblack
	name = "Tabard, Black"
	category = "Raincoats"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/tabardblack

/datum/loadout_item/shroudblack
	name = "Tabard Shroud, Black"
	category = "Raincoats"
	path = /obj/item/clothing/head/roguetown/roguehood/shroudblack

/datum/loadout_item/tabardwhite
	name = "Tabard, White"
	category = "Raincoats"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/tabardwhite

/datum/loadout_item/shroudwhite
	name = "Tabard's Shroud, White"
	category = "Raincoats"
	path = /obj/item/clothing/head/roguetown/roguehood/shroudwhite

/datum/loadout_item/aproncook
	name = "Apron, Cooking"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/apron/cook

/datum/loadout_item/surcoatheavy
	name = "Surcoat, Overvestments"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/tabard/stabard/crusader/heavy
	triumph_cost = 3

/datum/loadout_item/surcoatgoldenorder
	name = "Surcoat, Golden Order"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/tabard/stabard/crusader
	triumph_cost = 3

/datum/loadout_item/surcoatsilverorder
	name = "Surcoat, Silver Order"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/tabard/stabard/crusader/t
	triumph_cost = 3

/datum/loadout_item/surcoatgoldenorderast
	name = "Surcoat, Golden Order, Astratan"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/tabard/stabard/crusader/astrata
	triumph_cost = 3

/datum/loadout_item/surcoatsilverorderast
	name = "Surcoat, Silver Order, Astratan"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/tabard/stabard/crusader/t/astrata
	triumph_cost = 3

/datum/loadout_item/surcoatgoldenorderuni
	name = "Surcoat, Golden Order, Undivided"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/tabard/stabard/crusader/undivided
	triumph_cost = 3

/datum/loadout_item/surcoatsilverorderuni
	name = "Surcoat, Silver Order, Undivided"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/tabard/stabard/crusader/t/undivided
	triumph_cost = 3

/datum/loadout_item/ranger_cloak
	name = "Ranger Cloak, Forest Green"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/rangercloak
	triumph_cost = 5

/datum/loadout_item/ranger_cloak_gray
	name = "Ranger Cloak, Neutral Gray"
	category = list("Raincoats", "Points")
	path = /obj/item/clothing/cloak/rangercloak/gray
	triumph_cost = 5

/datum/loadout_item/scaledcloak
	name = "Scaled Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/scaledcloak

/datum/loadout_item/sleevedtabard
	name = "Tabard, Sleeved"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/sleevedtabard

/datum/loadout_item/toga
	name = "Toga, Robed"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard/toga

/datum/loadout_item/toga_dress
	name = "Toga, Dress"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard/toga/dress

//SHOES
/datum/loadout_item/leatherboots
	name = "Leather Boots"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/boots/leather

/datum/loadout_item/classicsandals
	name = "Classical Sandals"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/sandals/toga

/datum/loadout_item/darkboots
	name = "Dark Boots"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/boots

/datum/loadout_item/babouche
	name = "Babouche"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/shalal

/datum/loadout_item/nobleboots
	name = "Noble Boots"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/boots/nobleboot

/datum/loadout_item/sandals
	name = "Sandals"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/sandals

/datum/loadout_item/shortboots
	name = "Short Boots"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/shortboots

/datum/loadout_item/gladsandals
	name = "Gladiatorial Sandals"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/gladiator

/datum/loadout_item/ridingboots
	name = "Riding Boots"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/ridingboots

/datum/loadout_item/ankletscloth
	name = "Cloth Anklets"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/boots/clothlinedanklets

/datum/loadout_item/ankletsfur
	name = "Fur Anklets"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets

/datum/loadout_item/silkanklets
	name = "Silk Anklets"
	category = list("Shoes", "Points")
	path = /obj/item/clothing/shoes/roguetown/anklets
	triumph_cost = 4

/datum/loadout_item/rumaclanshoes
	name = "Raised Sandals"
	path = /obj/item/clothing/shoes/roguetown/armor/rumaclan/shitty
	category = "Shoes"

//SHIRTS
/datum/loadout_item/longcoat
	name = "Longcoat"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/armor/longcoat

/datum/loadout_item/slit_dress
	name = "Slitted dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/slit

/datum/loadout_item/robe
	name = "Robe"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/robe

/datum/loadout_item/phys_robe
	name = "Physicker's Robe"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/phys

/datum/loadout_item/feld_robe
	name = "Feldsher's Robe"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/feld

/datum/loadout_item/formalsilks
	name = "Formal Silks"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan

/datum/loadout_item/longshirt
	name = "Shirt"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/black

/datum/loadout_item/shortshirt
	name = "Short-sleeved Shirt"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/shortshirt

/datum/loadout_item/sailorshirt
	name = "Striped Shirt"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor

/datum/loadout_item/sailorjacket
	name = "Leather Jacket"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor

/datum/loadout_item/priestrobe
	name = "Undervestments"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest

/datum/loadout_item/silkbra
	name = "Giltsilk Bra"
	category = list("Clothing", "Points")
	path = /obj/item/clothing/suit/roguetown/shirt/silkbra
	triumph_cost = 4

/datum/loadout_item/desertbra
	name = "Desert Bra"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/desertbra

/datum/loadout_item/kimono2
	name = "Long Sleeved Kimono"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/kimono2

/datum/loadout_item/haori
	name = "Haori"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/haori

/datum/loadout_item/yoroihitatare
	name = "Yoroihitatare"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/yoroihitatare

/datum/loadout_item/kamishimo
	name = "Kamishimo"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/kamishimo

/datum/loadout_item/kazengun_jacket
	name = "Kazengun Jacket"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/kazengun_jacket

/datum/loadout_item/deserthood
	name = "Desert Hood"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/deserthood

/datum/loadout_item/desertskirt
	name = "Desert Skirt"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/skirt/desert

/datum/loadout_item/explorerhat
	name = "Explorer Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/explorerhat

/datum/loadout_item/explorervest
	name = "Explorer Vest"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/explorer

/datum/loadout_item/fancycoat
	name = "Fancy Coat"
	category = "Clothing"
	path = /obj/item/clothing/cloak/poncho/fancycoat

/datum/loadout_item/explorerpants
	name = "Explorer Pants"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/tights/explorerpants

/datum/loadout_item/formaltrousers
	name = "Formal Trousers"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/under/roguetown/tights/formalfancy
	donatitem = TRUE

/datum/loadout_item/bottomtunic
	name = "Low-cut Tunic"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut

/datum/loadout_item/tunic
	name = "Tunic"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/tunic

/datum/loadout_item/stripedtunic
	name = "Striped Tunic"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/armor/workervest

/datum/loadout_item/dress
	name = "Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen

/datum/loadout_item/bardress
	name = "Bar Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress

/datum/loadout_item/chemise
	name = "Chemise"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress

/datum/loadout_item/sexydress
	name = "Sexy Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy

/datum/loadout_item/straplessdress
	name = "Strapless Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless

/datum/loadout_item/straplessdress/alt
	name = "Strapless Dress, alt"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/alt

/datum/loadout_item/gown
	name = "Spring Gown"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown

/datum/loadout_item/gown/summer
	name = "Summer Gown"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown/summergown

/datum/loadout_item/gown/fall
	name = "Fall Gown"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown/fallgown

/datum/loadout_item/gown/winter
	name = "Winter Gown"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown/wintergown

/datum/loadout_item/gown/silkydress
	name = "Silky Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkydress

/datum/loadout_item/noblecoat
	name = "Fancy Coat"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat

/datum/loadout_item/leathervest
	name = "Leather Vest"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/armor/leather/vest

/datum/loadout_item/nun_habit
	name = "Nun Habit"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/nun

/datum/loadout_item/eastshirt1
	name = "Black Foreign Shirt"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1

/datum/loadout_item/formalskirt
	name = "Knee-High Skirt"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/skirt/formal

/datum/loadout_item/eastshirt2
	name = "White Foreign Shirt"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2

/datum/loadout_item/baredrobe
	name = "Bared Robe"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/bared

/datum/loadout_item/velvetdress
	name = "Velvet Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/velvetdress
	donatitem = TRUE

/datum/loadout_item/nobledress
	name = "Noble's Pinafore"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/nobledress
	donatitem = TRUE

/datum/loadout_item/formalshirt
	name = "formal shirt"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/formal
	donatitem = TRUE

/datum/loadout_item/fancymaiddress
	name = "Valorian Maid Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/maidfancy
	donatitem = TRUE

/datum/loadout_item/wedding_dress
	name = "Wedding Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/weddingdress
	donatitem = TRUE

/datum/loadout_item/maiddress
	name = "Maid Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/maid
	donatitem = TRUE

//PANTS
/datum/loadout_item/tights
	name = "Cloth Tights"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/tights/black

/datum/loadout_item/hosen
	name = "Cloth Hosen"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/tights/hose

/datum/loadout_item/leathertights
	name = "Leather Tights"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/trou/leathertights

/datum/loadout_item/hakama
	name = "Hakama Pants"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/trou/leather/hakama

/datum/loadout_item/trou
	name = "Work Trousers"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/trou

/datum/loadout_item/belt_trousers
	name = "Belt-Buckled Trousers"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/trou/beltpants

/datum/loadout_item/leathertrou
	name = "Leather Trousers"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/trou/leather

/datum/loadout_item/leathershorts
	name = "Leather Shorts"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/heavy_leather_pants/shorts

/datum/loadout_item/sailorpants
	name = "Seafaring Pants"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/tights/sailor

/datum/loadout_item/skirt
	name = "Skirt"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/skirt

//ACCESSORIES
/datum/loadout_item/wrappings
	name = "Handwraps"
	category = "Accessories"
	path = /obj/item/clothing/wrists/roguetown/wrappings

/datum/loadout_item/allwrappings
	name = "Cloth Wrappings"
	category = "Accessories"
	path = /obj/item/clothing/wrists/roguetown/allwrappings

/datum/loadout_item/loincloth
	name = "Loincloth"
	category = "Accessories"
	path = /obj/item/clothing/under/roguetown/loincloth

/datum/loadout_item/spectacles
	name = "Spectacles"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/spectacles

/datum/loadout_item/fingerless
	name = "Fingerless Gloves"
	category = "Accessories"
	path = /obj/item/clothing/gloves/roguetown/fingerless

/datum/loadout_item/bandages
	name = "Bandages, Gloves"
	category = "Accessories"
	path = /obj/item/clothing/gloves/roguetown/bandages

/datum/loadout_item/silkbelt
	name = "Giltsilk Belt"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/silkbelt
	triumph_cost = 5

/datum/loadout_item/ragmask
	name = "Rag Mask"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/ragmask

/datum/loadout_item/halfmask
	name = "Halfmask"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/shepherd

/datum/loadout_item/dendormask
	name = "Briar Mask"
	category = "Accessories"
	path = /obj/item/clothing/head/roguetown/dendormask

/datum/loadout_item/tutorialbook
	name = "A Tutorialeer's Handbook"
	category = "Accessories"
	path = /obj/item/recipe_book/survival

/datum/loadout_item/ball
	name = "Ball"
	category = "Accessories"
	path = /obj/item/ball

/datum/loadout_item/eorahood
	name = "Opera Mask - Eoran Hood"
	category = list("Accessories", "Legacy Cosmetics")
	donatitem = TRUE
	path = /obj/item/clothing/head/roguetown/roguehood/eorahood

/datum/loadout_item/silkmask
	name = "Giltsilk Mask"
	category = list("Accessories", "Points")
	path = /obj/item/clothing/mask/rogue/silkmask
	triumph_cost = 4

/datum/loadout_item/duelmaskc
	name = "Duelist's Mask"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/duelmask

/datum/loadout_item/pipe
	name = "Pipe"
	category = "Accessories"
	path = /obj/item/clothing/mask/cigarette/pipe

/datum/loadout_item/pipewestman
	name = "Westman Pipe"
	category = "Accessories"
	path = /obj/item/clothing/mask/cigarette/pipe/westman

/datum/loadout_item/feather
	name = "Feather"
	category = "Accessories"
	path = /obj/item/natural/feather

/datum/loadout_item/collar
	name = "Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/collar/leather

/datum/loadout_item/forlon_collar
	name = "Light Forlorn Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/collar/forlorn

/datum/loadout_item/catbell_collar
	name = "Catbell Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/collar/bell/catbell

/datum/loadout_item/bell_collar
	name = "Cowbell Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/collar/bell/cowbell

/datum/loadout_item/cursed_collar
	name = "Cursed Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/gorget/cursed_collar

/datum/loadout_item/rope_leash
	name = "Rope Leash"
	category = "Accessories"
	path = /obj/item/leash

/datum/loadout_item/leather_leash
	name = "Leather Leash"
	category = "Accessories"
	path = /obj/item/leash/leather

/datum/loadout_item/chain_leash
	name = "Chain Leash"
	category = "Accessories"
	path = /obj/item/leash/chain

/datum/loadout_item/cloth_blindfold
	name = "Cloth Blindfold"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/blindfold

/datum/loadout_item/fake_blindfold
	name = "Fake Blindfold"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/blindfold/fake

/datum/loadout_item/bases
	name = "Cloth military skirt"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/battleskirt
	triumph_cost = 3

/datum/loadout_item/fauldedbelt
	name = "Belt with faulds"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/battleskirt/faulds
	triumph_cost = 3

/datum/loadout_item/doublebelt
	name = "Paired belts"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/double
	triumph_cost = 4

/datum/loadout_item/knifebelt // comes empty
	name = "Tossblade Belt"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/knifebelt/black
	triumph_cost = 4

/datum/loadout_item/psicross
	name = "Psydonian Cross"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross

/datum/loadout_item/psicross/reform
	name = "Reformist Psydonian Cross"
	path = /obj/item/clothing/neck/roguetown/psicross/reform

/datum/loadout_item/psicross/astrata
	name = "Amulet of Astrata"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/astrata

/datum/loadout_item/psicross/noc
	name = "Amulet of Noc"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/noc

/datum/loadout_item/psicross/abyssor
	name = "Amulet of Abyssor"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/abyssor

/datum/loadout_item/psicross/xylix
	name = "Amulet of Xylix"
	path = /obj/item/clothing/neck/roguetown/psicross/xylix

/datum/loadout_item/psicross/dendor
	name = "Amulet of Dendor"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/dendor

/datum/loadout_item/psicross/necra
	name = "Amulet of Necra"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/necra

/datum/loadout_item/psicross/pestra
	name = "Amulet of Pestra"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/pestra

/datum/loadout_item/psicross/ravox
	name = "Amulet of Ravox"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/ravox

/datum/loadout_item/psicross/malum
	name = "Amulet of Malum"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/malum

/datum/loadout_item/psicross/eora
	name = "Amulet of Eora"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/eora

/datum/loadout_item/psicross/undivided
	name = "Amulet of Ten"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/undivided

/datum/loadout_item/psicross/zizo
	name = "Decrepit Zcross"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy

/datum/loadout_item/zcross_iron
	name = "Iron Zcross"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/iron

/datum/loadout_item/psicross/matthios
	name = "Amulet of Matthios"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/matthios

/datum/loadout_item/psicross/graggar
	name = "Amulet of Graggar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/graggar

/datum/loadout_item/psicross/baotha
	name = "Amulet of Baotha"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/baotha

/datum/loadout_item/psicross/gronnzizo
	name = "Wolf Talisman"
	category = list("Accessories")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/gronn

/datum/loadout_item/psicross/gronnspider
	name = "Spider Talisman"
	category = list("Accessories")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/gronn/spider

/datum/loadout_item/psicross/gronnbaotha
	name = "Leopard Talisman"
	category = list("Accessories")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/baothagronn

/datum/loadout_item/psicross/gronnmatthios
	name = "Bear Talisman"
	category = list("Accessories")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/matthios/gronn

/datum/loadout_item/psicross/gronngraggar
	name = "Moose Talisman"
	category = list("Accessories")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/graggar/gronn

/datum/loadout_item/psicross/gronndendor
	name = "Volfskinned Talisman"
	category = list("Accessories")
	path = /obj/item/clothing/neck/roguetown/psicross/dendor/gronn

/datum/loadout_item/psicross/gronnabyssor
	name = "Hadal Talisman"
	category = list("Accessories")
	path = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn

/datum/loadout_item/wedding_band
	name = "silver wedding band"
	category = "Accessories"
	path = /obj/item/clothing/ring/band

/datum/loadout_item/jesterhatc
	name = "Jester's Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/jester

/datum/loadout_item/jestertunickc
	name = "Jester's Tunick"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/jester

/datum/loadout_item/jestershoess
	name = "Jester's Shoes"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/jester

/datum/loadout_item/cotehardie
	name = "Fitted Coat"
	category = "Clothing"
	path = /obj/item/clothing/cloak/cotehardie

//CAPARISONS

/datum/loadout_item/caparison
	name = "Caparison"
	category = "Miscellaneous"
	path = /obj/item/caparison

/datum/loadout_item/caparison/psy
	name = "Psydonite Caparison"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/caparison/psy
	donatitem = TRUE

/datum/loadout_item/caparison/astrata
	name = "Astratan Caparison"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/caparison/astrata
	donatitem = TRUE

/datum/loadout_item/caparison/eora
	name = "Eoran Caparison"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/caparison/eora
	donatitem = TRUE

/datum/loadout_item/caparison/fogbeast
	name = "Fogbeast Caparison"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/caparison/fogbeast
	donatitem = TRUE

//////////////////
//  TRIUMPHS !  //
//////////////////

//Everything in this section costs TRI. Very rudimentary, but it should help us gradually realign some sense of value to this otherwise-neglected system.
//When it comes to equipment, avoid adding anything that an Adventurer - or non-combative Noble - couldn't spawn with, or otherwise acquire within the first dae of the week.
//If adding more items, ensure they're a Triumph-exclusive child. If they can be smelted down, reduce the sum to one ingot. If they can be sold, blacklist it from the Stockpile.

// -3 TRI Minisection.
// Nearly all characters can comfortably earn +3-5 TRI per week, assuming they sleep ever-so-often.

/datum/loadout_item/triumph_knife
	name = "Laborer's Knife"
	path = /obj/item/rogueweapon/huntingknife/throwingknife/triumph
	category = list("Points")
	triumph_cost = 5

/datum/loadout_item/triumph_necklace
	name = "Golden Necklace, Ornate"
	path = /obj/item/clothing/neck/roguetown/ornateamulet/noble/triumph
	category = list("Points")
	triumph_cost = 7

/datum/loadout_item/triumph_ring
	name = "Golden Ring, Ornate"
	path = /obj/item/clothing/ring/gold/triumph
	category = list("Points")
	triumph_cost = 7

/datum/loadout_item/triumph_circlet
	name = "Golden Circlet, Ornate"
	path = /obj/item/clothing/head/roguetown/circlet/triumph
	category = list("Points")
	triumph_cost = 7

/datum/loadout_item/triumph_weaponkit_fancymace
	name = "Cosmetic Kit - Rungu-Shishpar Mace - Required: Iron Mace, an Iron Warhammer, a Steel Mace, a Steel Warhammer, or a Silver Mace"
	path = /obj/item/enchantingkit/triumph_weaponkit_fancymace
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_krisdagger
	name = "Cosmetic Kit - Kris - Required: Bauernwehr, a Combat Knife, an Iron Dagger, or a Steel Dagger"
	path = /obj/item/enchantingkit/triumph_weaponkit_kris
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_njoradagger
	name = "Cosmetic Kit - Njora - Required: Steel Dagger, an Iron Dagger, a Hunting Knife, or a Combat Knife"
	path = /obj/item/enchantingkit/triumph_weaponkit_njora
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_alloywhip
	name = "Cosmetic Kit - Alloytip Whip - Required: Bronze Whip, a Whip, or a Silver Whip"
	path = /obj/item/enchantingkit/triumph_weaponkit_whip
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_kaskara
	name = "Cosmetic Kit - Kaskara - Required: Iron Arming Sword, a Steel Arming Sword, or a Rapier"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_kaskara
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_ida
	name = "Cosmetic Kit - Ida - Required: Iron Shortsword or a Steel Shortsword"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_ida
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_hwi
	name = "Cosmetic Kit - Hwi - Required: Iron Hunting Sword, an Iron Dueling Messer, a Steel Messer, a Steel Hunting Sword, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_hwi
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_ngombe
	name = "Cosmetic Kit - Ngombe - Required: Iron Hunting Sword, an Iron Dueling Messer, a Steel Messer, a Steel Hunting Sword, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_ngombe
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_ada
	name = "Cosmetic Kit - Ada - Required: Iron Sabre, a Steel Sabre, a Falx, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_ada
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_sengese
	name = "Cosmetic Kit - Sengese - Required: Iron Sabre, a Steel Sabre, a Falx, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_sengese
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_clericsword
	name = "Cosmetic Kit - Clerical Longsword - Required: Long Sword"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_clericsword
	category = list("Points")
	triumph_cost = 6

// -5 TRI Minisection.

/datum/loadout_item/triumph_shortsatchel
	name = "Short Satchel"
	path = /obj/item/storage/backpack/rogue/satchel/short
	category = list("Points")
	triumph_cost = 5

/datum/loadout_item/triumph_waterskin
	name = "Waterskin"
	path = /obj/item/reagent_containers/glass/bottle/waterskin
	category = list("Points")
	triumph_cost = 5

/datum/loadout_item/triumph_messkit
	name = "Mess Kit"
	path = /obj/item/storage/gadget/messkit
	category = list("Points")
	triumph_cost = 5

/datum/loadout_item/triumph_foldtable
	name = "Folding Table"
	path = /obj/item/folding_table_stored
	category = list("Points")
	triumph_cost = 5

/datum/loadout_item/triumph_bedroll
	name = "Bedroll"
	path = /obj/item/bedroll
	category = list("Points")
	triumph_cost = 5

/datum/loadout_item/triumph_scabbardnoble
	name = "Decorated Scabbard, Silver"
	path = /obj/item/rogueweapon/scabbard/sword/noble
	category = list("Points")
	triumph_cost = 10

/datum/loadout_item/triumph_sheathnoble
	name = "Decorated Sheath, Silver"
	path = /obj/item/rogueweapon/scabbard/sheath/noble
	category = list("Points")
	triumph_cost = 10

/datum/loadout_item/triumph_psycross
	name = "Golden Psycross, Ornate"
	path = /obj/item/clothing/neck/roguetown/psicross/g/triumph
	category = list("Points")
	triumph_cost = 11

/datum/loadout_item/triumph_zcross
	name = "Golden Zizote Amulet, Ornate"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/g/triumph
	category = list("Points")
	triumph_cost = 12

/datum/loadout_item/triumph_astcross
	name = "Golden Astratan Amulet, Ornate"
	path = /obj/item/clothing/neck/roguetown/psicross/astrata/g/triumph
	category = list("Points")
	triumph_cost = 13

/datum/loadout_item/triumph_signet
	name = "Golden Signet Ring, Ornate"
	path = /obj/item/clothing/ring/signet/triumph
	category = list("Points")
	triumph_cost = 13

/datum/loadout_item/triumph_gildedshirt
	name = "Gilded Dress Shirt"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_pristinedress
	name = "Pristine Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_royalsleeves
	name = "Royal Sleeves"
	path = /obj/item/clothing/wrists/roguetown/royalsleeves
	category = list("Points")
	triumph_cost = 6

/datum/loadout_item/triumph_goldhalfmask
	name = "Golden Halfmask, Ornate"
	path = /obj/item/clothing/mask/rogue/lordmask/triumph
	category = list("Points")
	triumph_cost = 10

/datum/loadout_item/triumph_goldfullmask
	name = "Golden Mask, Ornate"
	path = /obj/item/clothing/mask/rogue/facemask/goldmask/triumph
	category = list("Points")
	triumph_cost = 13

/datum/loadout_item/triumph_goldfullmaskc
	name = "Crestless Golden Mask, Ornate"
	path = /obj/item/clothing/mask/rogue/facemask/goldmaskc/triumph
	category = list("Points")
	triumph_cost = 13

/datum/loadout_item/triumph_weaponkit_estoc
	name = "Cosmetic Kit - Azurian Estoc - Required: Estoc or Stecher"
	path = /obj/item/enchantingkit/triumph_weaponkit_estoc
	category = list("Points")
	triumph_cost = 6

//////////////////
//  PERFUMES !  //
//////////////////

/datum/loadout_item/triumph_perfume_lavender
	name = "Lavender Perfume"
	path = /obj/item/perfume/lavender
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_cherry
	name = "Cherry Perfume"
	path = /obj/item/perfume/cherry
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_rose
	name = "Rose Perfume"
	path = /obj/item/perfume/rose
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_jasmine
	name = "Jasmine Perfume"
	path = /obj/item/perfume/jasmine
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_mint
	name = "Mint Perfume"
	path = /obj/item/perfume/mint
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_vanilla
	name = "Vanilla Perfume"
	path = /obj/item/perfume/vanilla
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_pear
	name = "Pear Perfume"
	path = /obj/item/perfume/pear
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_strawberry
	name = "Strawberry Perfume"
	path = /obj/item/perfume/strawberry
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_cinnamon
	name = "Cinnamon Perfume"
	path = /obj/item/perfume/cinnamon
	category = list("Points")
	triumph_cost = 2

/datum/loadout_item/triumph_perfume_frankincense
	name = "Frankincense Perfume"
	path = /obj/item/perfume/frankincense
	category = list("Points")
	triumph_cost = 3

/datum/loadout_item/triumph_perfume_sandalwood
	name = "Sandalwood Perfume"
	path = /obj/item/perfume/sandalwood
	category = list("Points")
	triumph_cost = 3

/datum/loadout_item/triumph_perfume_myrrh
	name = "Myrrh Perfume"
	path = /obj/item/perfume/myrrh
	category = list("Points")
	triumph_cost = 3

/datum/loadout_item/triumph_fermented_crab
	name = "Fermented Crab"
	path = /obj/item/reagent_containers/glass/bottle/alchemical/fermented_crab
	category = list("Points")
	triumph_cost = 5

// -7 TRI Minisection.
/*
/datum/loadout_item/triumph_buttpack
	name = "Belted Satchel"
	path = /obj/item/storage/backpack/rogue/satchel/beltpack
	category = list("Points")
	triumph_cost = 7
*/
/datum/loadout_item/triumph_lunchpouch
	name = "Pouch of Luncheons"
	path = /obj/item/storage/belt/rogue/pouch/triumphlunch
	category = list("Points")
	triumph_cost = 8

/* /datum/loadout_item/triumph_grenzhat
	name = "Grenzelhoftian Beret"
	path = /obj/item/clothing/head/roguetown/grenzelhofthat/triumph
	category = list("Points")
	triumph_cost = 7 */

/datum/loadout_item/triumph_lordcloak
	name = "Lordly Cloak"
	path = /obj/item/clothing/cloak/lordcloak
	category = list("Points")
	triumph_cost = 10

/datum/loadout_item/triumph_ladycloak
	name = "Ladylike Cloak"
	path = /obj/item/clothing/cloak/lordcloak/ladycloak
	category = list("Points")
	triumph_cost = 12

/datum/loadout_item/triumph_gdorpelring
	name = "Golden Dorpel Ring, Ornate"
	path = /obj/item/clothing/ring/diamond/triumph
	category = list("Points")
	triumph_cost = 16


/datum/loadout_item/triumph_metalrepairkit
	name = "Repair Kit, Metal"
	path = /obj/item/repair_kit/metal/bad
	category = list("Points")
	triumph_cost = 15

/datum/loadout_item/triumph_clothrepairkit
	name = "Repair Kit, Cloth"
	path = /obj/item/repair_kit/bad
	category = list("Points")
	triumph_cost = 15

/datum/loadout_item/triumph_armorkit_valorianiron
	name = "Cosmetic Kit - Valorian Iron Armor - Required: Iron Breastplate, Iron Halfplate or Iron Plate Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_armorkit_iron
	donatitem = TRUE

/datum/loadout_item/triumph_weaponkit_classicleathers
	name = "Cosmetic Kit - Classic Leather Armor - Required: Leather Coat, Leather Armor or Hardened Leather Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_armorkit_classicleather
	donatitem = TRUE

/datum/loadout_item/triumph_weaponkit_classicironbreastplate
	name = "Cosmetic Kit - Aged Iron Breastplate - Required: Iron Breastplate"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_armorkit_classiciron
	donatitem = TRUE

/datum/loadout_item/triumph_transmutekit_armorkinis
	name = "Cosmetic Kit - Armorkinis - Required: Hide Armor, Leather Armor, Studded Leather Armor, Haubergeon or Plate Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_transmutekit_armorkinis
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/triumph_armorkit_valoriansteelhelm
	name = "Cosmetic Kit - Valorian Steel Helmet - Required: Steel Sallet, Steel Visored Sallet, Steel Kettlehelm or Steel Knight's Armet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_armorkit_oldhelmets
	donatitem = TRUE

/datum/loadout_item/triumph_armorkit_valorianironhelm
	name = "Cosmetic Kit - Valorian Iron Helmet - Required: Iron Sallet, Iron Visored Sallet, Iron Kettlehelm or Iron Knight's Armet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_armorkit_ironoldhelmets
	donatitem = TRUE

/datum/loadout_item/triumph_armorkit_agedskullcap
	name = "Cosmetic Kit - Aged Skull Cap - Required: Skull Cap"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_armorkit_agedskullcap
	donatitem = TRUE

/datum/loadout_item/triumph_shoulderguardstandalone
	name = "Standalone Decoration, Shoulderguard"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/stabard/donator_shoulderguard
	donatitem = TRUE

//Legacy cosmetic section
//Legacy cosmetic item definitions remain in donator_fluff.dm for save-path compatibility.
//All should be subtypes of existing weapons/clothes/armor/gear, whatever, to avoid balance issues I guess. Idk, I'm not your boss.

//Enchant whales
/datum/loadout_item/donator_plex
	name = "Cosmetic Kit - Rapier di Aliseo - Required: Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/plexiant
	donatitem = TRUE

/datum/loadout_item/donator_sru
	name = "Cosmetic Kit - Emerald Dress - Required: Dress(No Small Races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/srusu
	donatitem = TRUE

/datum/loadout_item/donator_strudel
	name = "Cosmetic Kit - Grenzelhoftian Mage Vest - Required: Robe(No Small Races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/strudel1
	donatitem = TRUE

/datum/loadout_item/donator_strudel2
	name = "Cosmetic Kit - Xylixian Fasching Leotard - Required: Xylixian Cloak(Only woman, no small races)"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/strudel2
	donatitem = TRUE

/datum/loadout_item/donator_bat
	name = "Cosmetic Kit - Handcarved Harp - Required: Harp"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/bat
	donatitem = TRUE

/datum/loadout_item/donator_mansa
	name = "Cosmetic Kit - Wortträger - Required: Estoc"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/ryebread
	donatitem = TRUE

/datum/loadout_item/donator_rebel
	name = "Cosmetic Kit - Gilded Sallet - Required: Visored Sallet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/rebel
	donatitem = TRUE

/datum/loadout_item/donator_bigfoot
	name = "Cosmetic Kit - Gilded Knight Helm - Required: Knight Helmet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/bigfoot
	donatitem = TRUE

/datum/loadout_item/donator_ravoxhelm_oldrw
	name = "Cosmetic Kit - Plumed Ravox Helmet - Required: Heavy Helmet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/ravoxhelm_oldrw
	donatitem = TRUE

/datum/loadout_item/donator_necranhelm_oldrw
	name = "Cosmetic Kit - Hooded Necra Helmet - Required: Heavy Helmet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/necranhelm_oldrw
	donatitem = TRUE

/datum/loadout_item/donator_eoran_helm
	name = "Cosmetic Kit - Flower Eora Helmet - Required: Heavy Helmet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/eoran_helm_resprite
	donatitem = TRUE

/datum/loadout_item/donator_astratanhelm_oldrw
	name = "Cosmetic Kit - Plumed Astrata Helmet - Required: Heavy Helmet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/astratanhelm_oldrw
	donatitem = TRUE

/datum/loadout_item/donator_dakken
	name = "Cosmetic Kit - Armoured Avantyne Barbute - Required: Armet or Hounskull Bascinet"
	path = /obj/item/enchantingkit/dakken_zizhelm
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_strudel3
	name = "Cosmetic Kit - Etruscan Design Cloak - Required: Poncho (No Small Races)"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/strudel3
	donatitem = TRUE

/datum/loadout_item/donator/ollanius_sword
	name = "Cosmetic Kit - Azurosa-Wrapped Sword - Required: Simple Sword, Sabre, Short Sword or Messer "
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/ollanius
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/spaz_helm
	name = "Cosmetic Kit - Hound-Nosed Bascinet - Required: Armet, Hounskull Or Barbute"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/spaz_helm
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/shoulderguardstandalone
	name = "Cosmetic Kit - Standalone Decoration, Shoulderguard"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/stabard/donator_shoulderguard
	donatitem = TRUE

/datum/loadout_item/donator/universal/armor_triheartfelt
	name = "Cosmetic Kit - Kit, Azurian Plate Armor - Required: Any Full Plate Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triheartfelt
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_strudel4
	name = "Cosmetic Kit - Form-fitting Padded Gambeson - Required: Padded Gambeson (Only Woman, No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/strudel4
	donatitem = TRUE

/datum/loadout_item/donator_bigfoot_axe
	name = "Cosmetic Kit - Gilded GreatAxe - Required: Steel Greataxe"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/bigfoot_axe
	donatitem = TRUE

/datum/loadout_item/donator/aisurapier
	name = "Cosmetic Kit - Crystalline Rapier - Required: Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/aisuwand
	donatitem = TRUE

/datum/loadout_item/donator/regnum
	name = "Cosmetic Kit - Regnum - Required: Longsword Or Judgement"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/regnum
	donatitem = TRUE

/datum/loadout_item/donator/aeternum
	name = "Cosmetic Kit - Aeternum - Required: Greatsword, Claymore, Or Zweihander"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/aeternum
	donatitem = TRUE

/datum/loadout_item/donator/darling
	name = "Cosmetic Kit - Darling - Required: Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/darling
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/sumquoderis
	name = "Cosmetic Kit - Sum Quod Eris - Required: Executioners sword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/sumquoderis
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/euthanasia
	name = "Cosmetic Kit - Euthanasia - Required: Dagger or Seax"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/euthanasia
	donatitem = TRUE


/*
/datum/loadout_item/donator_zydrasiconocrown
	name = "Cosmetic Kit - Iconoclast Crown - Required: Barred Helmet(Only men, no small races)"
	path = /obj/item/enchantingkit/zydrasiconocrown
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_zydrasiconopauldrons
	name = "Cosmetic Kit - Iconoclast Pauldrons - Required: Lightweight Brigandine(Only men, no small races)"
	path = /obj/item/enchantingkit/zydrasiconopauldrons
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE
*/

/datum/loadout_item/donator_eiren4
	name = "Cosmetic Kit - Darkwood's Embrace"
	path = /obj/item/clothing/suit/roguetown/armor/longcoat/eiren
	category = list("Clothing", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_eiren5
	name = "Cosmetic Kit - Glintstone Longsword - Required: Longsword"
	path = /obj/item/enchantingkit/weapon/eiren_m
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/koruu_silver_kukri
	name = "Cosmetic Kit - Psydonic Leachwhacker - Required: Psydonic Dagger"
	path = /obj/item/enchantingkit/weapon/koruu_kukri_silver
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/koruu_longsword
	name = "Cosmetic Kit - Excaliber - Required: Longsword"
	path = /obj/item/enchantingkit/weapon/koruu_longsword
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/koruu_etrusc
	name = "Cosmetic Kit - Colada - Required: Longsword Or Judgement"
	path = /obj/item/enchantingkit/weapon/koruu_etrusc
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/koruu_judgement
	name = "Cosmetic Kit - A Durthurian Tale - Required: Longsword"
	path = /obj/item/enchantingkit/weapon/koruu_judgement
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_eiren6
	name = "Cosmetic Kit - Stygian Longsword - Required: Longsword"
	path = /obj/item/enchantingkit/weapon/eirensword
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/gdhatsirdon
	name = "Cosmetic Kit - Gravedigger's Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/duelhat/pretzel
	donatitem = TRUE

/datum/loadout_item/donator/porcelainmask
	name = "Cosmetic Item - Porcelain Mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/iamcrystalclear
	donatitem = TRUE

/datum/loadout_item/donator_zydrashauberk
	name = "Cosmetic Kit - Mailled Cuirass - Required: iron plate-and-maille"
	path = /obj/item/enchantingkit/zydrashauberk
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_zydrasgreataxe
	name = "Cosmetic Kit - Bourreau - Required: Greataxe"
	path = /obj/item/enchantingkit/zydrasgreataxe
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/*
/datum/loadout_item/donator_zydrasiconosash
	name = "Cosmetic Kit - Iconoclast Sash - Required: Hauberk(Only men, no small races)"
	path = /obj/item/enchantingkit/zydrasiconosash
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE
*/
/datum/loadout_item/donator_zydras
	name = "Cosmetic Kit - Padded silky dress - Required: Silky Dress(No Small Races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/zydras
	donatitem = TRUE

/datum/loadout_item/donator_eiren
	name = "Cosmetic Kit - Regret - Required: Any Zweihander"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/eiren
	donatitem = TRUE

/datum/loadout_item/donator_eiren2
	name = "Cosmetic Kit - Lunae - Required: Sabre"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/eirensabre
	donatitem = TRUE

/datum/loadout_item/donator_eiren3
	name = "Cosmetic Kit - Cinis - Required: Sabre"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/eirensabre2
	donatitem = TRUE

/datum/loadout_item/donator_waff
	name = "Cosmetic Kit - Weeper Lathe - Required: Kriegmesser or Greatsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/waff
	donatitem = TRUE

/datum/loadout_item/donator_xenolalia
	name = "Cosmetic Kit - Xenolalia - Required: Flamberge"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/wafflamberge
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_inverserun
	name = "Cosmetic Kit - Votive Thorns - Required: Any Zweihander"
	path = /obj/item/enchantingkit/weapon/inverserun
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_zoe
	name = "Cosmetic Kit - Shroud of the Undermaiden - Required: Direbear Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/zoe
	donatitem = TRUE

/datum/loadout_item/donator/magi1138
	name = "Cosmetic Kit - Stolen Xylix Cloak"
	path = /obj/item/clothing/cloak/magi1138
	category = list("Raincoats", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/magi1138/specs
	name = "Cosmetic Kit - Modified Nocshade Lens-pair"
	path = /obj/item/clothing/mask/rogue/spectacles/magi1138
	category = list("Clothing", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_zoe_shovel
	name = "Cosmetic Kit - Silence - Required: Shovel"
	path = /obj/item/enchantingkit/zoe_shovel
	category = list("Miscellaneous", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donat_scabbardroyal
	name = "Cosmetic Kit - Decorated Scabbard, Golden"
	path = /obj/item/rogueweapon/scabbard/sword/royal/donat
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/donat_sheathroyal
	name = "Cosmetic Kit - Decorated Sheath, Golden"
	path = /obj/item/rogueweapon/scabbard/sheath/royal/donat
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/donat_gildedshirt
	name = "Gilded Dress Shirt"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
	category = list("Clothing", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donat_pristinedress
	name = "Pristine Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
	category = list("Clothing", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_willmbrink
	name = "Royal Gown"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/royal
	category = list("Clothing", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_willmbrink/sleeves
	name = "Cosmetic Item - Royal Sleeves"
	path = /obj/item/clothing/wrists/roguetown/royalsleeves
	category = list("Clothing", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator/willmbrink/padded_dress
	name = "Cosmetic Item - Padded Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/willmbrink
	category = list("Clothing", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donat_ornatesilkdress
	name = "Cosmetic Item - Ornate Silk Dress"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/steward
	category = list("Clothing", "Legacy Cosmetics")
	donat_tier = 2

/datum/loadout_item/donator_dasfox
	name = "Cosmetic Kit - Archaic Ceremonial Valkyrhelm - Required: Armet"
	path = /obj/item/enchantingkit/dasfox_helm
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_dasfox/cuirass
	name = "Cosmetic Kit - Archaic Ceremonial Cuirass - Required: Fluted Cuirass(No Small Races)"
	path = /obj/item/enchantingkit/dasfox_cuirass
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_dasfox/lance
	name = "Cosmetic Kit - Decorated Lance - Required: Lance"
	path = /obj/item/enchantingkit/dasfox_lance
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donat_armorkit
	name = "Cosmetic Kit - 'Valorian Steel Armor' - Required: Steel Cuirass, Steel Halfplate, Steel Plate Armor or Fluted Plate Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_armorkit
	donatitem = TRUE

/datum/loadout_item/donat_weaponkittri
	name = "Cosmetic Kit - 'Valorian Longsword' - Required: Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_weaponkit_tri
	donatitem = TRUE

/datum/loadout_item/donat_weaponkitwide
	name = "Cosmetic Kit - 'Wideguard Longsword' - Required: Longsword or Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_weaponkit_wide
	donatitem = TRUE

/datum/loadout_item/donat_weaponkitrock
	name = "Cosmetic Kit - 'Rockhillian Longsword' - Required: Broadsword or Executioner Sword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_rock
	donatitem = TRUE

/datum/loadout_item/donat_weaponkitsword
	name = "Cosmetic Kit - 'Valorian Sword' - Required: Iron Arming Sword, an Iron Dueling Sword, or a Maciejowski"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_sword
	donatitem = TRUE

/datum/loadout_item/donat_weaponkitgreatval
	name = "Cosmetic Kit - 'Valorian Greatsword' - Required: Greatsword, a Claymore, or a Flamberge"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_greatval
	donatitem = TRUE

/datum/loadout_item/donat_weaponkitsabre
	name = "Cosmetic Kit - 'Sabreguard Longsword' - Required: Longsword or Kriegmesser"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_weaponkit_sabre
	donatitem = TRUE

/datum/loadout_item/donat_weaponkitpsy
	name = "Cosmetic Kit - 'Psycrucifix Longsword' - Required: Psydonic or default longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/triumph_weaponkit_psy
	donatitem = TRUE
/*
/datum/loadout_item/donator_nerocavalier
	name = "Cosmetic Kit - Blacksteel Longsword - Required: Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/noire_flsword
	donatitem = TRUE
*/
/datum/loadout_item/donator/nero_sword
	name = "Cosmetic Kit - Sylvan Longsword - Required: Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/nero_lsword
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/nero_dagger
	name = "Cosmetic Kit - Sylvan Dagger - Required: Dagger"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/nero_dagger
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/nero_sabre
	name = "Cosmetic Kit - Sylvan Sabre - Required: Sabre"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/nero_sabre
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/des_gaebolg
	name = "Cosmetic Kit - Gae Bolg - Required: Spear, Partizan, Halberd, Glaive Or Eagle's Beak"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/des_gaebolg
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/sakuyzo
	name = "Cosmetic Kit - Hævatein - Required: Kriegmesser"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/sakuyzo
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/arra_amdir
	name = "Cosmetic Kit - Amdir - Required: Greataxe"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/arra_amdir
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_dasfox/periapt
	name = "Cosmetic Item - Defiled Astratan Periapt"
	path = /obj/item/clothing/neck/roguetown/psicross/astrata/dasfox
	category = list("Accessories", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_ryan
	name = "Cosmetic Item - Western Estates Caparison"
	path = /obj/item/caparison/ryan
	category = list("Miscellaneous", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_estoc
	name = "Cosmetic Kit - Azurian Estoc - Required: Estoc Or Stecher"
	path = /obj/item/enchantingkit/triumph_weaponkit_estoc
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_fancymace
	name = "Cosmetic Kit - Rungu-Shishpar Mace - Required: Iron Mace, an Iron Warhammer, a Steel Mace, a Steel Warhammer, or a Silver Mace"
	path = /obj/item/enchantingkit/triumph_weaponkit_fancymace
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_krisdagger
	name = "Cosmetic Kit - Kris - Required: Bauernwehr, a Combat Knife, an Iron Dagger, or a Steel Dagger"
	path = /obj/item/enchantingkit/triumph_weaponkit_kris
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_njoradagger
	name = "Cosmetic Kit - Njora - Required: Steel Dagger, an Iron Dagger, a Hunting Knife, or a Combat Knife"
	path = /obj/item/enchantingkit/triumph_weaponkit_njora
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_alloywhip
	name = "Cosmetic Kit - Alloytip Whip - Required: Bronze Whip, a Whip, or a Silver Whip"
	path = /obj/item/enchantingkit/triumph_weaponkit_whip
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_kaskara
	name = "Cosmetic Kit - Kaskara - Required: Iron Arming Sword, a Steel Arming Sword, or a Rapier"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_kaskara
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_ida
	name = "Cosmetic Kit - Ida - Required: Iron Shortsword or a Steel Shortsword"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_ida
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_hwi
	name = "Cosmetic Kit - Hwi - Required: Iron Hunting Sword, an Iron Dueling Messer, a Steel Messer, a Steel Hunting Sword, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_hwi
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_ngombe
	name = "Cosmetic Kit - Ngombe - Required: Iron Hunting Sword, an Iron Dueling Messer, a Steel Messer, a Steel Hunting Sword, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_ngombe
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_ada
	name = "Cosmetic Kit - Ada - Required: Iron Sabre, a Steel Sabre, a Falx, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_ada
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkit_sengese
	name = "Cosmetic Kit - Sengese - Required: Iron Sabre, a Steel Sabre, a Falx, or a Falchion"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_sengese
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_drow_armorkit
	name = "Cosmetic Kit - Drowcraft Armor - Required: Hardened Leather Armor, Studded Leather Armor, Lightweight Brigandine, Cuirass or Scalemail"
	path = /obj/item/enchantingkit/triumph_armorkit_drow
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_ryan/psy_helm
	name = "Cosmetic Kit - Unorthodoxist Psydonite Helm - Required: Psydonic Helmet(Armet,Barbute,Bucket Helmet or Sallet)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/ryan_psyhelm
	donatitem = TRUE

/datum/loadout_item/donator_kumie
	name = "Cosmetic Kit - Aristocratic Boots - Required: Heavy Leather Boots or Noble Boots"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/kumie_boots
	donatitem = TRUE

/datum/loadout_item/donator_kumie2
	name = "Cosmetic Kit - Aristocratic Gloves - Required: Fingerless Leather Gloves or Heavy Leather Gloves"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/kumie_gloves
	donatitem = TRUE

/datum/loadout_item/donator_kumie3
	name = "Cosmetic Kit - Aristocratic Shirt - Required: Gambeson or Padded Gambeson(No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/kumie_shirt
	donatitem = TRUE

/datum/loadout_item/donator/universal/armor_gothic_psydonic
	name = "Cosmetic Kit - Gothic Psydonic Cuirass - Required: Psydonic Cuirass"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/gothicpsydoniccuirass
	donatitem = TRUE

/datum/loadout_item/donator_kumie4
	name = "Cosmetic Kit - Aristocratic Coat - Required: Hardened Leather Coat or Lightweight Brigandine(No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/kumie_coat
	donatitem = TRUE

/datum/loadout_item/donator_hammerhold_robe
	name = "Cosmetic Kit - Hammerhold Robe - Required: Gambeson or Padded Gambeson(No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hammerhold_robe
	donatitem = TRUE

/datum/loadout_item/donator_hammerhold_coat
	name = "Cosmetic Kit - Hammerhold Mage Coat - Required: Hardened Leather Coat(No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hammerhold_coat
	donatitem = TRUE

/datum/loadout_item/donator_jagerrifle
	name = "Cosmetic Kit - Jägerbüchse - Required: Arquebus"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/jagerrifle
	donatitem = TRUE

/datum/loadout_item/donator_stinketh_shashka
	name = "Cosmetic Kit - Fencer's Shashka - Required: Szöréndnížine Sabre Or Aavnic Shashka"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/stinketh_shashka
	donatitem = TRUE

/datum/loadout_item/donator_stinketh_pike
	name = "Cosmetic Kit - Kindness of Ravens Standard - Required: Banner Of Szöréndnížina"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/stinketh_pike
	donatitem = TRUE

/datum/loadout_item/donator_koruu_glaive
	name = "Cosmetic Kit - Sixty Five Yils - Required: Glaive Or Naginata"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/koruu_glaive
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_drd_lsword
	name = "Cosmetic Kit - Ornate Longsword - Required: Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/drd_lsword
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_weaponkitaxe
	name = "Cosmetic Kit - Valorian Axe - Required: Iron Axe or an Iron Hatchet"
	path = /obj/item/enchantingkit/triumph_weaponkit_axe
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkitaxealt
	name = "Cosmetic Kit - Doubleheaded Axe - Required: Iron Axe, Bronze Axe, Steel Axe, Battle Axe, Silver War Axe or a Psydonic War Axe."
	path = /obj/item/enchantingkit/triumph_weaponkit_axedouble
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkitwodao
	name = "Cosmetic Kit - Wodao - Required: Sabre"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_wodao
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator/aticius_fls
	name = "Cosmetic Kit - For Love's Sake - Required: Longsword"
	path = /obj/item/enchantingkit/aticius_fls
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_athena_solace
	name = "Cosmetic Kit - Solace - Required: Rapier"
	path = /obj/item/enchantingkit/weapon/athena_solace
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_weaponkitdadao
	name = "Cosmetic Kit - Dadao - Required: Iron Hunting Sword, Iron Dueling Messer, Steel Messer, Steel Hunting Sword Or Falx"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_dadao
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkitgdadao
	name = "Cosmetic Kit - Greatdadao - Required: Kriegmesser or Rhomphaia"
	path = /obj/item/enchantingkit/weapon/triumph_weaponkit_gdadao
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/donator_weaponkitdakkenalloybsword
	name = "Cosmetic Kit - Avantyne-Threaded Sword - Required: Longsword"
	path = /obj/item/enchantingkit/dakken_alloybsword
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_eoranspike
	name = "Cosmetic Kit - Eoran Spike - Required: Steel Dagger"
	path = /obj/item/enchantingkit/shudderfly_dagger
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/sci_flamesword
	name = "Cosmetic Kit - Flametongue - Required: Shamshir"
	path = /obj/item/enchantingkit/sci_flame
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/sci_sandsword
	name = "Cosmetic Kit - Sandlash - Required: Shamshir"
	path = /obj/item/enchantingkit/sci_sand
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/dark_delight
	name = "Cosmetic Kit - Dark Delight - Required: Ssangsudo or Longsword"
	path = /obj/item/enchantingkit/weapon/nicksonessang
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

//Miscellaneous
/datum/loadout_item/donat
	name = "Music box"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/dmusicbox
	donatitem = TRUE

/datum/loadout_item/donat/lute
	name = "Musical instrument: Lute"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/lute
	donatitem = TRUE

/datum/loadout_item/donat/accord
	name = "Musical instrument: Accordion"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/accord
	donatitem = TRUE

/datum/loadout_item/donat/guitar
	name = "Musical Instrument: Guitar"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/guitar
	donatitem = TRUE

/datum/loadout_item/donat/harp
	name = "Musical Instrument: Harp"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/harp
	donatitem = TRUE

/datum/loadout_item/donat/flute
	name = "Musical Instrument: Flute"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/flute
	donatitem = TRUE

/datum/loadout_item/donat/drum
	name = "Musical Instrument: Drum"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/drum
	donatitem = TRUE

/datum/loadout_item/donat/shamisen
	name = "Musical Instrument: Shamisen"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/shamisen
	donatitem = TRUE

/datum/loadout_item/donat/vocals
	name = "Musical Instrument: Vocalist Talisman"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/vocals
	donatitem = TRUE

/datum/loadout_item/donat/viola
	name = "Musical instrument: Viola"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/viola
	donatitem = TRUE

/datum/loadout_item/donat/beer
	name = "Beer"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/reagent_containers/glass/bottle/rogue/beer/blackgoat
	donatitem = TRUE

/datum/loadout_item/donat/wine
	name = "Wine"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/reagent_containers/glass/bottle/rogue/wine
	donatitem = TRUE

//Clothing for donators

/datum/loadout_item/stargazer
	name = "Stargazer Robe"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/robe/noc/stargazer
	donatitem = TRUE

/datum/loadout_item/donator_maesune
	name = "Cosmetic Item - Mercantile Union's Garb"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/maesune
	donatitem = TRUE

/datum/loadout_item/donator_funky
	name = "Trimmed down padded dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/funkydress
	donatitem = TRUE

/datum/loadout_item/donat/corset
	name = "Corset"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/armor/corset
	donatitem = TRUE

/datum/loadout_item/donat/elven_suit
	name = "Elven Costume"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_elven
	donatitem = TRUE

/datum/loadout_item/donat/hammerhold_shirt
	name = "Hammerhold Shirt"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_hammerhold
	donatitem = TRUE

/datum/loadout_item/donat/hammerhold_dress
	name = "Hammerhold Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_hammerhold/dress
	donatitem = TRUE

/datum/loadout_item/donat/elven_coat
	name = "Elven Coat"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_elven/coat
	donatitem = TRUE

/datum/loadout_item/donat/hammerhold_coat
	name = "Boyar Coat"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_hammerhold/coat
	donatitem = TRUE

/datum/loadout_item/donat/elven_coat_alt
	name = "Elven Fur Coat"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_elven/coat/alt
	donatitem = TRUE

/datum/loadout_item/donat/hammerhold_furcoat
	name = "Hammerhold Mage Robe"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_hammerhold/dress/furcoat
	donatitem = TRUE

/datum/loadout_item/donat/hammerhold_robe
	name = "Hammerhold Mage Robe"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_hammerhold/dress/robe
	donatitem = TRUE

/datum/loadout_item/donat/shirt_formal
	name = "Formal Shirt"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/formal
	donatitem = TRUE

/datum/loadout_item/donat/tights_shorts
	name = "Formal Short Pants"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/under/roguetown/tights/shorts
	donatitem = TRUE

/datum/loadout_item/donat/tights_fancy
	name = "Formal pants"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/under/roguetown/tights/formalfancy
	donatitem = TRUE

/datum/loadout_item/donat/maid_dress_fancy
	name = "Maid dress (new)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/maidfancy
	donatitem = TRUE

/datum/loadout_item/donat/maid_servant
	name = "Servant Gown"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/maidservant
	donatitem = TRUE

/datum/loadout_item/donat/maid_dress
	name = "Maid dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/maid
	donatitem = TRUE

/datum/loadout_item/donat/nun_dress
	name = "Nun's robe (women only)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/robe/nunTA
	donatitem = TRUE

/datum/loadout_item/donat/kimono
	name = "Kimono (women only)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/kimono
	donatitem = TRUE

/datum/loadout_item/slitteddress
	name = "Slitted dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/slit
	donatitem = TRUE

//Tabards and cloaks

/datum/loadout_item/donat/matron
	name = "Matron's Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/matron
	donatitem = TRUE

/datum/loadout_item/donator/wyrd_cloak
	name = "Wyrd Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/armor/longcoat/wyrd_cloak
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donat/capeblkknight
	name = "Bloody Robe"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/cape/blkknight
	donatitem = TRUE

/datum/loadout_item/donator/longest_night
	name = "Cosmetic Item - Longest Night Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/longest_night
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donat/snowcloak
	name = "Snow Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/forrestercloak/snow
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/undivided
	name = "Tabard of Ten"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/undivided
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/undivided/alt
	name = "Cloak of Ten"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/undivided
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/astrata
	name = "Tabard of Astrata"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/astrata
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/astrata
	name = "Tabard-cloak of Astrata"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/astratan
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/noc
	name = "Tabard-cloak of Nok"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/noc
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/dendor
	name = "Tabard of Dendora"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/dendor
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/pestra
	name = "Tabard-cloak of Motley"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/pestra
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/pestra
	name = "Tabard-cloak of Motley"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/pestran
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/malum
	name = "Tabard of Maluma"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/malum
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/malum
	name = "Tabard-cloak of Maluma"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/malumite
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/abyssor
	name = "Abyssor's Tabard"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/abyssor
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/abyssor
	name = "Abyssor's Tabard Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/abyssorite
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/ravox
	name = "Ravox's Tabard"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/ravox
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/ravox
	name = "Ravox's Tabard Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/ravox
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/xilyx
	name = "Xylix's Tabard"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/xylix
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/xilyx
	name = "Xylix's Tabard Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/xylixian
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/eora
	name = "Eora's Tabard"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/eora
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/eora/resprite
	name = "Eora's Tabard Cloak (resprite)"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/eoran/alt
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/eora
	name = "Eora's Tabard Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/eoran
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/necra
	name = "Necra Tabard"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/necra
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/necra
	name = "Necra Tabard Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/necran
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/psydon
	name = "Psydon's Tabard"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/devotee/psydon
	donatitem = TRUE

/datum/loadout_item/donat/tabard/templar/psydon
	name = "Psydon's Tabard Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/psydontabard
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/poncho
	name = "Poncho"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/poncho
	donatitem = TRUE

/datum/loadout_item/donat/hammerholdcape
	name = "Hammerhold Cape"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/twilight_cape
	donatitem = TRUE

/datum/loadout_item/donat/elvencloak
	name = "Elven Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/twilight_elven
	donatitem = TRUE

/datum/loadout_item/donat/elvencloak_short
	name = "Short Elven Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/twilight_elven/short
	donatitem = TRUE

/datum/loadout_item/donat/maid_apron
	name = "Maid's Apron"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/apron/waist/maid
	donatitem = TRUE

/datum/loadout_item/donat/maid_apron_fancy
	name = "Maid apron (new)"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/apron/waist/fancymaid
	donatitem = TRUE

/datum/loadout_item/donat/elven_burka
	name = "Elven Burka"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/twilight_elven_hat

/datum/loadout_item/donat/cloak_twilight_desert
	name = "Zybanthian Cape"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/twilight_desert
	donatitem = TRUE

/datum/loadout_item/donat/cloak_etrusco
	name = "Etruscan Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/duelcape
	donatitem = TRUE

/datum/loadout_item/donat/cloak_jinbaori
	name = "Jinbaori"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/kazengun
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_vakiova
	name = "Cosmetic Item - Gravetender Coat"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/vaki_gravetender
	donatitem = TRUE
	donat_tier = 2

//Masks

/datum/loadout_item/naledimask
	name = "Naledi Mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/lordmask/naledi/decorated

/datum/loadout_item/donat/eoramask
	name = "Eoran Mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/eoramask
	donatitem = TRUE

/datum/loadout_item/donat/xylixmask
	name = "Xylixite Mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/xylixmask
	donatitem = TRUE

/datum/loadout_item/weatheredmask
	name = "Weathered Xylixian Mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/xylixmask/weathered
	donatitem = TRUE

/datum/loadout_item/donat/eyepatchfake
	name = "Right Eye Patch (fake)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/eyepatch/fake
	donatitem = TRUE

/datum/loadout_item/donat/eyepatchfakeleft
	name = "Left Eye Patch (fake)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/eyepatch/left/fake
	donatitem = TRUE

/datum/loadout_item/owlmask
	name = "Owl Mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/owlmask
	donatitem = TRUE

/datum/loadout_item/onimask
	name = "Oni mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/yoruku_oni
	donatitem = TRUE

/datum/loadout_item/kitsunemask
	name = "Kitsune mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/yoruku_kitsune
	donatitem = TRUE

/datum/loadout_item/brassbeak
	name = "Cosmetic Kit - Brass Beak Mask - Required: Head Physician's Mask Or Plague Mask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/lmwevil_brassbeak
	donatitem = TRUE

//Hats

/datum/loadout_item/stargazerhood
	name = "Stargazer Hood"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/roguehood/stargazer
	donatitem = TRUE

/datum/loadout_item/donat/grenzelhofthat_decorated
	name = "Grenzelhoft Hat (no armor, decorative)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/grenzelhofthat/decorated
	donatitem = TRUE

/datum/loadout_item/donat/wizhat
	name = "Mage Hat (blue)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/wizhat
	donatitem = TRUE

/datum/loadout_item/donat/wizhatred
	name = "Mage Hat (red)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/wizhat/red
	donatitem = TRUE

/datum/loadout_item/donat/wizhatyellow
	name = "Mage Hat (yellow)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/wizhat/yellow
	donatitem = TRUE

/datum/loadout_item/donat/wizhatgreen
	name = "Mage Hat (green)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/wizhat/green
	donatitem = TRUE

/datum/loadout_item/donat/wizhatblack
	name = "Mage Hat Maga (black)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/wizhat/black
	donatitem = TRUE

/datum/loadout_item/donat/maid_headdress
	name = "Maid's cap"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/maidhead
	donatitem = TRUE

/datum/loadout_item/donat/maidband
	name = "Maid's cap (new)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/maidband
	donatitem = TRUE

/datum/loadout_item/donat/kokoshnik
	name = "Kokoshnik"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/twilight_hammerhold_hat
	donatitem = TRUE

/datum/loadout_item/donat/hammerhold_hat
	name = "Hammerhold hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/twilight_hammerhold_hat/peasant
	donatitem = TRUE

/datum/loadout_item/donat/nun_hood
	name = "Nun's hood"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/nunTA
	donatitem = TRUE

/datum/loadout_item/donat/flowers_crown_eora
	name = "Crown of Eora flowers"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/flowercrown/rosa/resprite
	donatitem = TRUE

/datum/loadout_item/donat/etrusca_hat
	name = "Etruscan hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/duelhat/etrusca
	donatitem = TRUE

/datum/loadout_item/donat/grenzberet
	name = "Grenzelhoftian Beret"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/grenzelhofthat/triumph
	donatitem = TRUE

/datum/loadout_item/tw_d_horns_donat
	name = "Horns Helmkleinod (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_horns
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_castle_red_donat
	name = "Castle Helmkleinod (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_castle_red
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_graggar_donat
	name = "Bloodied Star Helmkleinod (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_graggar
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_efreet_donat
	name = "Afreet Helmkleinod (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_efreet
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_feathers_donat
	name = "Feathers Accessory (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_feathers
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_oathtaker_donat
	name = "Oathtaker Symbol (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_oathtaker
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_windmill_donat
	name = "Windmill Helmkleinod (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_windmill
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_swan_donat
	name = "Swan on Lake (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_swan
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/tw_d_dragon_red_donat
	name = "Dragon's Dread (Donat - T2)"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/onhelm/tw_d_dragon_red
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_koruu
	name = "Cosmetic Kit - Well-Worn Bamboo Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/mentorhat/koruu
	donatitem = TRUE

/datum/loadout_item/donator_eekasqueak
	name = "Saffira encrusted tiara"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/circlet/saffiratiara
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/ketrai
	name = "Octopus hat"
	path = /obj/item/clothing/head/roguetown/octopus
	category = list("Hats", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/shawl
	name = "Shawl"
	path = /obj/item/clothing/head/roguetown/shawl
	category = "Hats"

/datum/loadout_item/maidband
	name = "Maid Headdress"
	path = /obj/item/clothing/head/roguetown/maidhead
	category = list("Hats", "Legacy Cosmetics")
	donatitem = TRUE

/datum/loadout_item/maidbandfancy
	name = "Valorian Maid Headband"
	path = /obj/item/clothing/head/roguetown/maidband
	category = list("Hats", "Legacy Cosmetics")
	donatitem = TRUE

//Shoes

/datum/loadout_item/hammerhold_shoes
	name = "Hammerhold Boots"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/hammerhold_shoes
	donatitem = TRUE

/datum/loadout_item/hammerhold_boots
	name = "Hammerhold Boots"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/boots/hammerhold_boots
	donatitem = TRUE

/datum/loadout_item/etruscan_boots
	name = "Cosmetic Kit - Etruscan Boots - Required: Heavy Leather Boots (Only Woman)"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/etruscan_boots
	donatitem = TRUE

//Accessories

/datum/loadout_item/donat/hammerhold_sash
	name = "Hammerhold Sash"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/hammerhold_sash
	donatitem = TRUE

/datum/loadout_item/donat/suspenders
	name = "Suspenders"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/suspenders
	donatitem = TRUE

/datum/loadout_item/woolencollar
	name = "Woolen Collar"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/neck/roguetown/collar/woolen
	donatitem = TRUE

/datum/loadout_item/chess
	name = "Chess, Checkers and Backgammon Set"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/chessboard_folded
	donat_tier = 2
	donatitem = TRUE

/datum/loadout_item/donat/loveamulet
	name = "Amulet of Tears of Love"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/neck/roguetown/loveamulet
	donatitem = TRUE

/datum/loadout_item/donat/scarf
	name = "Scarf"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/twilight_scarf
	donatitem = TRUE

/datum/loadout_item/donat/matthios_moneta
	name = "Pierced Coin Amulet"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/matthios/moneta
	donatitem = TRUE
	ckeywhitelist = list("imony", "uedhighcommand")

// Aria Mrix Start

/datum/loadout_item/aria_bikini
	name = "Aria bikini"
	category = list("Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/armor/gambeson/aria
	donatitem = TRUE
	ckeywhitelist = list("mrix")

/datum/loadout_item/aria_pants
	name = "Aria pants"
	category = list("Legacy Cosmetics")
	path = /obj/item/clothing/under/roguetown/trou/leather/aria
	donatitem = TRUE
	ckeywhitelist = list("mrix")

/datum/loadout_item/aria_wrists
	name = "Aria wrists"
	category = list("Legacy Cosmetics")
	path = /obj/item/clothing/wrists/roguetown/bracers/cloth/monk/aria
	donatitem = TRUE
	ckeywhitelist = list("mrix")

/datum/loadout_item/aria_necklace
	name = "Aria necklace"
	category = list("Legacy Cosmetics")
	path = /obj/item/clothing/mask/rogue/facemask/aria
	donatitem = TRUE
	ckeywhitelist = list("mrix")

/datum/loadout_item/aria_gloves
	name = "Aria bondaged gloves"
	category = list("Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/bandages/pugilist/aria
	donatitem = TRUE
	ckeywhitelist = list("mrix")

/datum/loadout_item/aria_belt
	name = "Aria belt"
	category = list("Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/aria
	donatitem = TRUE
	ckeywhitelist = list("mrix")

/datum/loadout_item/aria_bondage
	name = "Aria feet bondage"
	category = list("Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/boots/leather/aria
	donatitem = TRUE
	ckeywhitelist = list("mrix")

// Aria Mrix End

/datum/loadout_item/donat_sheathnoble
	name = "Decorated Sheath, Silver"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/rogueweapon/scabbard/sheath/noble
	donatitem = TRUE

/datum/loadout_item/donat_scabbardnoble
	name = "Decorated Scabbard, Silver"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/rogueweapon/scabbard/sword/noble
	donatitem = TRUE

/datum/loadout_item/donator_maesune_shield
	name = "Cosmetic Kit - Silver Shield - Required: Kite Shield"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/maesune_shield
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_her_verdict
	name = "Cosmetic Kit - Her Verdict - Required: Kriegmesser or Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/herverdict
	donatitem = TRUE
	donat_tier = 2
	donat_ignore = list("uedhighcommand","imony")

/datum/loadout_item/donator_maesune_sabre
	name = "Cosmetic Kit - Decorated Sabre - Required: Falchion, Longsword, Sword, Silver Sword Or Kriegmesser"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/maesune_sabre
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_koruu_kukri
	name = "Cosmetic Kit - Leachwhacker - Required: Any Dagger"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/koruu_kukri
	donatitem = TRUE

/datum/loadout_item/donator_koruu_kukri_warden
	name = "Cosmetic Kit - Warden Leachwhacker - Required: Warden's Seax or Any Dagger"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/koruu_kukri/warden
	donatitem = TRUE

// Sanguine Set

/datum/loadout_item/sanguine_heels
	name = "Sanguine Heels"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/courtphysician/female
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_vest
	name = "Sanguine Vest"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/courtphysician
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_blouse
	name = "Sanguine Blouse"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/courtphysician/female
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_hat
	name = "Sanguine Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/courtphysician
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_cap
	name = "Sanguine Cap"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/courtphysician/female
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_gloves
	name = "Sanguine Gloves"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/courtphysician
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_sleeves
	name = "Sanguine Sleeves"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/courtphysician/female
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_trousers
	name = "Sanguine Trousers"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/under/roguetown/trou/leather/courtphysician
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_skirt
	name = "Sanguine Skirt"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/under/roguetown/skirt/courtphysician
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/sanguine_shoes
	name = "Sanguine Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/courtphysician
	donatitem = TRUE
	donat_tier = 2

// Sanguine Kits

/datum/loadout_item/donator_sanguine_vest
	name = "Cosmetic Kit - Sanguine Vest - Required: Gambeson or Padded Gambeson"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/sanguine_vest
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_sanguine_heels
	name = "Cosmetic Kit - Sanguine Heels - Required: Heavy Leather Boots"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/sanguine_heels
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_sanguine_trousers
	name = "Cosmetic Kit - Sanguine Trousers - Required: Hardened Leather Trousers or Fencing Breeches"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/sanguine_trousers
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_sanguine_jacket
	name = "Cosmetic Kit - Sanguine Jacket - Required: Hardened Leather Jacket or Fencing Jacket"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/sanguine_jacket
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_sanguine_coat
	name = "Cosmetic Kit - Sanguine Coat - Required: Hardened Leather Coat"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/sanguine_coat
	donatitem = TRUE
	donat_tier = 2

// Sanguine Kits End

// Nightmare Kit Start

/datum/loadout_item/donator_nightmare_armet
	name = "Cosmetic Kit - Nightmare Tears Helmet - Required: Armet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/nightmare_armet
	donatitem = TRUE
	ckeywhitelist = list("wrvxth", "murken4ik")

/datum/loadout_item/donator_nightmare_scales
	name = "Cosmetic Kit - Nightmare Tears Scales - Required: Scalemail (Only Woman, No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/nightmare_scales
	donatitem = TRUE
	ckeywhitelist = list("wrvxth", "murken4ik")

/datum/loadout_item/donator_nightmare_gauntlets
	name = "Cosmetic Kit - Nightmare Tears Gauntlets - Required: Plate Gauntlets (Only Woman, No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/nightmare_gauntlets
	donatitem = TRUE
	ckeywhitelist = list("wrvxth", "murken4ik")

/datum/loadout_item/donator_nightmare_chausses
	name = "Cosmetic Kit - Nightmare Tears Chausses - Required: Steel Chain Chausses (Only Woman, No Small Races)"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/nightmare_chausses
	donatitem = TRUE
	ckeywhitelist = list("wrvxth", "murken4ik")

/datum/loadout_item/donator_nightmare_boots
	name = "Cosmetic Kit - Nightmare Tears Boots - Required: Steel Boots"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/nightmare_boots
	donatitem = TRUE
	ckeywhitelist = list("wrvxth", "murken4ik")

/datum/loadout_item/donator_nightmare_crown
	name = "Cosmetic Kit - Nightmare Tears Crown"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/nightmare_crown
	donatitem = TRUE
	ckeywhitelist = list("wrvxth", "murken4ik")

// Nightmare Kit End

// COMMANDANT SET START

/datum/loadout_item/donator_commandant_helmet
	name = "Cosmetic Kit - Commandant's Helmet - Required: Heavy Helmet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/commandant_helmet
	donatitem = TRUE
	ckeywhitelist = list("alex23116571")

/datum/loadout_item/donator_commandant_cloak
	name = "Cosmetic Kit - Commandant's Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/commandant
	donatitem = TRUE
	ckeywhitelist = list("alex23116571")

/datum/loadout_item/donator_commandant_coat
	name = "Cosmetic Kit - Commandant's Coat - Required: Hardened Leather Coat/Lightweight Brigandine"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/commandant_coat
	donatitem = TRUE
	ckeywhitelist = list("alex23116571")

/datum/loadout_item/donator_commandant_belt
	name = "Cosmetic Kit - Officer's Belt"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/twilight_holsterbelt/commandant
	donatitem = TRUE
	ckeywhitelist = list("alex23116571")

/datum/loadout_item/donator_commandant_pistol
	name = "Cosmetic Kit - Elegant Pistol - Required: Arquebus Pistol"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/commandant_pistol
	donatitem = TRUE
	ckeywhitelist = list("alex23116571")

// COMMANDANT SET END

// Etruscan vol.3 Kit Start

/datum/loadout_item/etrhat
	name = "Wanderer's hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/duelhat/etrhat
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/etrdress
	name = "Low-cut dress - (only female, no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/etrdress
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/etrdress2
	name = "Embroidered dress - (only female, no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/etrdress2
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/etrshirt
	name = "Low-cut shirt - (only female, no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/etrshirt
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/etrdoublet
	name = "Wanderer's doublet - (only male, no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/etrdoublet
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/etrjacket
	name = "Wanderer's jacket - (no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/armor/leather/etrjacket
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/etrbootsm
	name = "Wanderer's boots - (only male, no small races)"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/boots/leather/etrbootsm
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/donat/etrcape
	name = "Wanderer's cape - (no small races)"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/etrcape
	donatitem = TRUE
	donat_tier = 1


/datum/loadout_item/wicker
	name = "Wicker Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/wickercloak
	donatitem = TRUE

/datum/loadout_item/donat/etrpants
	name = "Wanderer's pants - (no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/under/roguetown/trou/leather/etrpants/donat
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/donat/etrpants_enchantingkit
	name = "Cosmetic Kit - Wanderer's pants - Required: Leather Trousers, Splinted Chausses Or Brigandine Chausses (no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/etrpants
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/etrdress3
	name = "Strapless gown - (only female, no small races)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/dress/etrdress3
	donatitem = TRUE
	donat_tier = 1
// Etruscan vol.3 Kit End

//Tiara - Sprites made by G9ose and BolloTea
/datum/loadout_item/donat/tiara
	name = "Golden Tiara, Ornate"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/tiara
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/donator/bobby
	name = "Cosmetic Kit - Holy Astratan Bascinet - Required: Pigface Bascinet"
	path = /obj/item/enchantingkit/bobby_helm
	category = list("Armor", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/leathergloves
	name = "Leather Gloves"
	category = "Accessories"
	path = /obj/item/clothing/gloves/roguetown/leather

/datum/loadout_item/shadowmask
	name = "Purple Halfmask"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/shepherd/shadowmask

/datum/loadout_item/collar/collar
	name = "Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/collar

/datum/loadout_item/bell_collar/collar
	name = "Bell Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/collar/bell_collar

/datum/loadout_item/faceveil
	name = "Face Veil"
	category = "Accessories"
	path = /obj/item/clothing/mask/rogue/faceveil

/datum/loadout_item/breechclothbelt
	name = "Belt with Breechcloth"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/battleskirt/breechcloth
	triumph_cost = 3

/datum/loadout_item/greatplumestandalone
	name = "Helmet Decoration, Greatplume"
	category = list("Accessories", "Points")
	path = /obj/item/clothing/head/roguetown/decoration/greatplume
	triumph_cost = 3

/datum/loadout_item/breechclothbeltalt
	name = "Black Belt with Breechcloth"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/battleskirt/breechcloth/blackbelt
	triumph_cost = 3

/datum/loadout_item/blackbelt
	name = "Black Belt"
	category = list("Accessories", "Points")
	path = /obj/item/storage/belt/rogue/leather/black
	triumph_cost = 3

/datum/loadout_item/darkcloak
	name = "Dark Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/darkcloak

/datum/loadout_item/crusadercloak
	name = "Desert Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/cape/crusader

/datum/loadout_item/toga
	name = "Toga"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard/toga

/datum/loadout_item/cloakgoldenorder
	name = "Cloak, Golden Order"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/cape/inquisitorgold
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/cloaksilverorder
	name = "Cloak, Silver Order"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/cape/inquisitorsilver
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/azurosa
	name = "Cosmetic Item - Azurosa Flower"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/alch/rosa/azure
	donatitem = TRUE

/datum/loadout_item/donator/universal/azurosa_seeds
	name = "Cosmetic Item - Azurosa Flower, Seeds"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/pouch/azurosa_seeds
	donatitem = TRUE

/datum/loadout_item/donator/universal/azurosa_crown
	name = "Cosmetic Item - Azurosa Flowers, Crown"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/flowercrown/rosa/azure
	donatitem = TRUE

/datum/loadout_item/donator/universal/azurosa_bouquet
	name = "Cosmetic Item - Azurosa Flowers, Bouquet"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/bouquet/rosa/azure
	donatitem = TRUE

/datum/loadout_item/donator/universal/cackledagger
	name = "Cosmetic Kit - Cackledagger - Required: Steel Dagger or Decorated Dagger"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/cackledagger
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/longsword
	name = "Cosmetic Kit - Elegant Longsword - Required: Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_longsword
	donatitem = TRUE

/datum/loadout_item/donator/universal/longsword_imbued
	name = "Cosmetic Kit - Imbued Longsword - Required: Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_imbuedlongsword
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/falling_star
	name = "Cosmetic Kit - Falling Star - Required: Greatsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/falling_star
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/morto_staff
	name = "Cosmetic Kit - Frozen Vow - Required: Staff"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/morto_staff
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/cobb_conviction
	name = "Cosmetic Kit - Conviction - Required: Long Sword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/cobb_conviction
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/racobio_staff
	name = "Cosmetic Kit - Obsidian Tower - Required: Grand Staff"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/racobio_staff
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/cloak_goldmaillekini
	name = "Cosmetic Item - Golden Maillekini"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/donator_goldmaillekini
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/maille_chainkini
	name = "Cosmetic Kit - Maillekini - Required: Iron Hauberk or Steel Hauberk"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/maillekini
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/highheelshoes
	name = "Cosmetic Item - High-Heeled Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/simpleshoes/heels
	donatitem = TRUE

/datum/loadout_item/donator/universal/highheelshoes_gold
	name = "Cosmetic Item - High-Heeled Shoes, Gold"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/simpleshoes/heels/donator_gold
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/highheelshoes_silver
	name = "Cosmetic Item - High-Heeled Shoes, Silver"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/simpleshoes/heels/donator_silver
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/jadehalfmask_donator
	name = "Cosmetic Kit - Jade Halfmask - Required: Iron Mask, Steel Mask, Bronze Mask or Carved Jade Mask"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/jadehalfmask
	donatitem = TRUE

/datum/loadout_item/donator/universal/maille_cropped
	name = "Cosmetic Kit - Cropped Haubergeon - Required: Iron Haubergeon or Steel Haubergeon"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/croppedhaubergeon
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/maille_throwback
	name = "Cosmetic Kit - Elven Haubergeon - Required: Iron Haubergeon or Steel Haubergeon"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/elvenchainmail
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/cuirass_heartplate
	name = "Cosmetic Kit - Heartplate - Required: Iron Breastplate, Steel Cuirass or Leather Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/heartplate
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/cuirass_plackart
	name = "Cosmetic Kit - Plackart - Required: Iron Breastplate, Steel Cuirass or Leather Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/plackart
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/armor_gothic_iron
	name = "Cosmetic Kit - Gothic Iron Armor - Required: Iron Breastplate, Iron Halfplate or Iron Plate Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/gothicironarmor
	donatitem = TRUE

/datum/loadout_item/donator/universal/armor_gothic_steel
	name = "Cosmetic Kit - Gothic Steel Armor - Required: Steel Cuirass, Steel Halfplate or Steel Plate Armor"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/gothicsteelarmor
	donatitem = TRUE

/datum/loadout_item/donator/universal/cuirass_throwback
	name = "Cosmetic Kit - Heroic Leather Cuirass - Required: Leather Armor, Heavy Leather Armor, Studded Heavy Armor or Psyaltrist's Cuirass"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/heroicleathercuirass
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt
	name = "Cosmetic Kit - Belt of Caped Leather"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt_fur
	name = "Cosmetic Kit - Belt of Caped Fur"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_fur
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt_iron
	name = "Cosmetic Kit - Belt of Iron Maille"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_iron
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt_steel
	name = "Cosmetic Kit - Belt of Maille"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_steel
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/cloak_oathkeeperlong
	name = "Cosmetic Item - Oathtaker's Noble Longcoat"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/stabard/surcoat/donator_oathkeeper
	donatitem = TRUE

/datum/loadout_item/donator/universal/cloak_oathkeepershort
	name = "Cosmetic Item - Oathtaker's Noble Shortcoat"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/stabard/donator_oathkeeper
	donatitem = TRUE

/datum/loadout_item/donator/universal/doublet
	name = "Cosmetic Item - Doublet"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/doublet
	donatitem = TRUE
/*
/datum/loadout_item/donator/universal/doublet_apoth
	name = "Cosmetic Item - Doublet, Pale Green"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/apothshirt/donator
	donatitem = TRUE
*/
/datum/loadout_item/donator/universal/belt_bronze
	name = "Cosmetic Kit - Belt of Bronze Maille"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_bronze
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt_leathergirdle
	name = "Cosmetic Kit - Belted Girdle of Leather"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_leathergirdle
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt_bronzegirdle
	name = "Cosmetic Kit - Belted Plackart of Bronze"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_bronzegirdle
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt_irongirdle
	name = "Cosmetic Kit - Belted Plackart of Iron"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_irongirdle
	donatitem = TRUE

/datum/loadout_item/donator/universal/belt_steelgirdle
	name = "Cosmetic Kit - Belted Plackart of Steel"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/belt/rogue/leather/donator_steelgirdle
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/drd/caparison
	name = "Cosmetic Item - House Woerden Caparison"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/caparison/drd
	donatitem = TRUE

/datum/loadout_item/donator/drd/shield
	name = "Cosmetic Kit - House Woerden Shield - Required: Metal Tower Shield"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/drd_shield
	donatitem = TRUE

/datum/loadout_item/donator/pes_guitar
	name = "Cosmetic Item - Red-Stained Guitar"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/guitar/pes_guitar
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/jade_guitar
	name = "Cosmetic Item - Gilbranzed Guitar"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/rogue/instrument/guitar/jade_guitar
	donatitem = TRUE

/datum/loadout_item/donator/olygsword
	name = "Cosmetic Kit - Gre'as'anto d'Shar - Required: Greatsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/olygsword
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/ollanius_maille
	name = "Cosmetic Kit - Shoulderless Haubergeon - Required: Steel Haubergeon"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/ollanius_maille
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/crown_hat
	name = "Cosmetic Item - Crown Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/crown_hat
	donat_tier = 2

/datum/loadout_item/cap
	name = "Cap"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/cap

/datum/loadout_item/tiyon
	name = "Tiyon"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/tiyon

/datum/loadout_item/longveil
	name = "Long Veil"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/longveil

/datum/loadout_item/durag
	name = "Durag"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/durag

/datum/loadout_item/witchhat/old
	name = "Witch Hat (Old)"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/witchhat/old
	donatitem = TRUE

/datum/loadout_item/wizhat/gen
	name = "Wizard Hat (Generic)"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/wizhat/gen
	donatitem = TRUE

/datum/loadout_item/chefhat
	name = "Chef's Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/chef

/datum/loadout_item/psicross/decrepit
	name = "Decrepit Psycross"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/aalloy

/datum/loadout_item/psicross/naledi
	name = "Naledian Psy-Bracelet"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/naledi

/datum/loadout_item/psicross/tooth_necklace
	name = "Tooth Necklace"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/matthios/gronn/generic

/datum/loadout_item/wedding_band_gold
	name = "Wedding Band, Gold"
	category = "Accessories"
	path = /obj/item/clothing/ring/band/gold
	donatitem = TRUE

/datum/loadout_item/wedding_band_bronze
	name = "Wedding Band, Bronze"
	category = "Accessories"
	path = /obj/item/clothing/ring/band/bronze
	donatitem = TRUE

/datum/loadout_item/wedding_band_ancient
	name = "Wedding Band, Ancient"
	category = "Accessories"
	path = /obj/item/clothing/ring/band/paalloy
	donatitem = TRUE

/datum/loadout_item/tarot_deck_majorarcana
	name = "Tarot Deck (Major Arcana)"
	category = "Miscellaneous"
	path = /obj/item/toy/cards/deck/tarot/majorarcana
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/triumph_satchel
	name = "Satchel"
	category = list("Miscellaneous", "Points")
	path = /obj/item/storage/backpack/rogue/satchel
	triumph_cost = 7

/datum/loadout_item/triumph_satchelalt
	name = "Black Satchel"
	category = list("Miscellaneous", "Points")
	path = /obj/item/storage/backpack/rogue/satchel/black
	triumph_cost = 7

/datum/loadout_item/cloth
	name = "Cloth"
	category = list("Miscellaneous", "Points")
	path = /obj/item/natural/cloth
	triumph_cost = 2

/datum/loadout_item/psicross/noc/bronze
	name = "Bronze Amulet of Noc"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/noc/bronze
	triumph_cost = 2

/datum/loadout_item/psicross/ravox/bronze
	name = "Bronze Amulet of Ravox"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/ravox/bronze
	triumph_cost = 2

/datum/loadout_item/psicross/astrata/bronze
	name = "Bronze Amulet of Astrata"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/astrata/bronze
	triumph_cost = 2

/datum/loadout_item/psicross/malum/bronze
	name = "Bronze Amulet of Malum"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/malum/bronze
	triumph_cost = 2

/datum/loadout_item/psicross/inhumen/graggar/bronze
	name = "Bronze Amulet of Graggar"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/graggar/bronze
	triumph_cost = 2

/datum/loadout_item/psicross/bronze
	name = "Bronze Psycross"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/bronze
	triumph_cost = 2

/datum/loadout_item/psicross/inhumen/bronze
	name = "Bronze Inverted Psycross"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/bronze
	triumph_cost = 2

/datum/loadout_item/psicross/paalloy
	name = "Ancient Psycross"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/paalloy
	triumph_cost = 2

/datum/loadout_item/psicross/inhumen/paalloy
	name = "Ancient Inverted Psycross"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/paalloy
	triumph_cost = 2

/datum/loadout_item/psicross/noc/paalloy
	name = "Ancient Amulet of Noc"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/noc/paalloy
	triumph_cost = 2

/datum/loadout_item/triumph_winterdress
	name = "Winter Dress"
	category = list("Points")
	path = /obj/item/clothing/suit/roguetown/armor/armordress/winterdress
	triumph_cost = 4

/datum/loadout_item/triumph_steelbelt
	name = "Belt of Steel"
	category = list("Points")
	path = /obj/item/storage/belt/rogue/leather/steel
	triumph_cost = 5

/datum/loadout_item/triumph_plaquesilverbelt
	name = "Belt of Plaque, Silver"
	category = list("Points")
	path = /obj/item/storage/belt/rogue/leather/plaquesilver
	triumph_cost = 5

/datum/loadout_item/triumph_reformpsycross
	name = "Golden Reformist Psycross, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/reform/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_noccross
	name = "Golden Noccian Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/noc/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_abyssorcross
	name = "Golden Abyssorian Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/abyssor/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_dendorcross
	name = "Golden Dendorian Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/dendor/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_necracross
	name = "Golden Necran Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/necra/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_pestracross
	name = "Golden Pestran Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/pestra/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_ravoxcross
	name = "Golden Ravoxian Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/ravox/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_malumcross
	name = "Golden Malum Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/malum/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_eoracross
	name = "Golden Eoran Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/eora/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_xylixcross
	name = "Golden Xylixian Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/xylix/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_graggarcross
	name = "Golden Graggarite Amulet, Ornate"
	category = list("Points")
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/graggar/g/triumph
	triumph_cost = 13

/datum/loadout_item/triumph_tassetsteelbelt
	name = "Belt of Steel, Tasseted"
	category = list("Points")
	path = /obj/item/storage/belt/rogue/leather/steel/tasset
	triumph_cost = 7

/datum/loadout_item/triumph_plaquegoldenbelt
	name = "Belt of Plaque, Golden"
	category = list("Points")
	path = /obj/item/storage/belt/rogue/leather/plaquegold
	triumph_cost = 7

/datum/loadout_item/triumph_scabbardroyal
	name = "Decorated Scabbard, Golden"
	category = list("Points")
	path = /obj/item/rogueweapon/scabbard/sword/royal
	triumph_cost = 13

/datum/loadout_item/triumph_sheathroyal
	name = "Decorated Sheath, Golden"
	category = list("Points")
	path = /obj/item/rogueweapon/scabbard/sheath/royal
	triumph_cost = 13

/datum/loadout_item/donat/sagesbighat
	name = "Big Sage Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/sagesbighat
	donatitem = TRUE
	ckeywhitelist = list("somethingawful917")

/datum/loadout_item/beltshawl
	name = "Belt Shawl"
	category = "Accessories"
	path = /obj/item/storage/belt/rogue/leather/beltshawl

/datum/loadout_item/pouched_suspenders
	name = "Pouched Suspenders"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/suspenders

/datum/loadout_item/sash
	name = "Sash"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/sash

/datum/loadout_item/thorn_rosa_crown
	name = "Rosa Crown with Thorns"
	category = "Hats"
	path = /obj/item/flowercrown/rosa/thorns

/datum/loadout_item/dyeable_crown
	name = "Gray Flower Crown"
	category = "Hats"
	path = /obj/item/flowercrown/rosa/dyecrown

/datum/loadout_item/flamboyant
	name = "Flamboyant Hat"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/flamboyant
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/dhoti
	name = "Dhoti"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/tights/dhoti

/datum/loadout_item/gown/loudmouth_robes
	name = "Criers' Garb"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/loudmouth
	donatitem = TRUE

/datum/loadout_item/saree
	name = "Saree"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/saree

/datum/loadout_item/furboots
	name = "Fur Boots"
	category = "Shoes"
	path = /obj/item/clothing/shoes/roguetown/boots/furlinedboots

/datum/loadout_item/triumph_plaquegoldenbeltfancy
	name = "Belt of Plaque, Golden, Fancy"
	category = list("Points")
	path = /obj/item/storage/belt/rogue/leather/plaquegold/steward
	triumph_cost = 7

/datum/loadout_item/triumph_armorkit_slimmedsteel
	name = "Cosmetic Kit - Slimfitted Steel Armor - Required: Steel Halfplate, Fluted Halfplate, Steel Plate Armor or Fluted Plate Armor"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_armorkit_slimmedsteel
	triumph_cost = 8

/datum/loadout_item/triumph_weaponkit_classicdaggers
	name = "Cosmetic Kit - Classic Daggers - Required: Iron Dagger or Steel Dagger"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_weaponkit_classicdaggers
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_psyswords
	name = "Cosmetic Kit - Slimguarded Psydonic Longsword - Required: Psydonic Longsword or Enduring Longsword"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_weaponkit_psyswords
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_clasiscbeakhelm
	name = "Cosmetic Kit - Valorian Beak Helmet - Required: Sugarloaf Helmet or Ravoxian Templar Helmet"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_armorkit_classicbeakhelm
	triumph_cost = 6

/datum/loadout_item/triumph_weaponkit_classicpsymace
	name = "Cosmetic Kit - Classic Psydonic Handmace - Required: Psydonic Handmace or Enduring Handmace"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_weaponkit_psymace
	triumph_cost = 6

/datum/loadout_item/featherplumestandalone
	name = "Standalone Decoration, Featherplume"
	category = list("Points")
	path = /obj/item/clothing/head/roguetown/decoration/featherplume
	triumph_cost = 7

/datum/loadout_item/crestplumestandalone
	name = "Standalone Decoration, Crestplume"
	category = list("Points")
	path = /obj/item/clothing/head/roguetown/decoration/crestplume
	triumph_cost = 7

/datum/loadout_item/orlestandalone
	name = "Standalone Decoration, Orle"
	category = list("Points")
	path = /obj/item/clothing/head/roguetown/decoration/orle/donator_dyeable
	triumph_cost = 7

/datum/loadout_item/donator/universal/elegant_armory
	name = "Cosmetic Kit - Elegant Armory - Required: Steel Dagger, War Flail, Steel Warhammer, Steel or Silver Mace, Messer, Executioner's Sword, Decorated Longsword, Decorated Sabre, Decorated Rapier, Knuckles, Steel Handaxe, Steel Quarterstaff, Grenzel Greatsword, Rapier, Shortsword, Longsword, Sabre, Decorated Sword, Steel Flail, Steel Greataxe, Lance, Battle Axe, Boar Spear, Greatsword, Katar, Halberd, Eaglebeak or Arming Sword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_universal_armory
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/elegant_whip
	name = "Cosmetic Kit - Elegant Whip - Required: Whip"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_universal_whips
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/elegant_urumi
	name = "Cosmetic Kit - Elegant Urumi - Required: Antique, Bronze, Blacksteel, Silver or Lesser Psydonic Whip"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_universal_urumi
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/elegant_shield
	name = "Cosmetic Kit - Elegant Shield - Required: Metal Kite Shield"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_universal_shield
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/grenzshortsword
	name = "Cosmetic Kit - Katzbalger Shortsword - Required: Steel Shortsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_universal_grenzshortsword
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/grenzrapier
	name = "Cosmetic Kit - Smallsword-Style Rapier - Required: Steel Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_universal_grenzrapier
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/armor_gothic_burgeonet
	name = "Cosmetic Kit - Gothic Burgeonet - Required: Pigface Bascinet, Hounskull Bascinet or Roundface Bascinet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/gothicburgeonet
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/headpiece_featherplume
	name = "Cosmetic Item - Helmet Cosmetic, Featherplume"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/decoration/featherplume
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/headpiece_crestplume
	name = "Cosmetic Item - Helmet Cosmetic, Crestplume"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/decoration/crestplume
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/headpiece_orle
	name = "Cosmetic Item - Helmet Cosmetic, Orle"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/decoration/orle/donator_dyeable
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/armorpiece_armharness
	name = "Cosmetic Kit - Arm Harness - Required: Steel Bracers"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_universal_armharness
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/heelkit
	name = "Cosmetic Kit - Heelification Elixir - Required: Any Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/heelkit
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/donator_cropped_gambeson
	name = "Cosmetic Kit - Cropped Gambeson - Required: Padded Gambeson or Gambeson"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_cropped_gambeson
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/dasfox/tyesca_brigandine
	name = "Cosmetic Kit - Fencer's Brigandine - Required: Fencing Cuirass or Light Brigandine"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/tyesca_brigandine
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/dasfox/tyesca_montante
	name = "Cosmetic Kit - Tyesca's Montante - Required: Szöréndnížine Montante"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/tyesca_sword
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/dasfox/tyesca_cloak
	name = "Cosmetic Item - Tyesca's Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/raincloak/tyesca
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/dasfox/tyesca_scabbard
	name = "Cosmetic Item - Tyesca's Scabbard"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/rogueweapon/scabbard/sword/tyesca
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/stinketh
	name = "Cosmetic Kit - Silver Shashka - Required: Szöréndnížine Sabre or Aavnic Shashka"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/stinketh_shashka
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/kadeguandao
	name = "Cosmetic Kit - Dawn Cometh - Required: Halberd, Greataxe or Naginata"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/kadeguandao
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/walkthewaste
	name = "Cosmetic Item - Worn Bamboo Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/mentorhat/walkthewaste
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lime_helm
	name = "Cosmetic Kit - Serpentine Bascinet - Required: Visored Sallet or Abyssor Greathelm"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/limetease
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lime_dress
	name = "Cosmetic Item - Noviciate Robe"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/robe/limetease
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lime_dress_color
	name = "Cosmetic Item - Colorable Noviciate Robe"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/robe/limetease/color
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/gazelleskull
	name = "Cosmetic Item - Gazelle Skull"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/decoration/gazelleskull
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/chivalre_aasimar
	name = "Cosmetic Kit - Aasimari Equipment(Only Female, No Small Races) - Required: Steel Cuirass or Fluted Steel Cuirass, Visored Sallet, Steel Boots, Plate Chausses, Steel Bracers, Plate Gauntlets, Bevor, Partizan, Boar Spear, Longsword or Steel Mace"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/chivalre_aasimar
	donatitem = TRUE
	donat_tier = 1

/datum/loadout_item/donator/chivalre_aasimar_sack
	name = "Cosmetic Kit - Aasimari Equipment(Only Female, No Small Races), Sackful"
	category = list("Miscellaneous", "Legacy Cosmetics")
	path = /obj/item/storage/roguebag/donator_chivalre_elixirs
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/truill_flowerblade
	name = "Cosmetic Kit - Beflowered Longsword - Required: Enduring Longsword, Psydonic Longsword or Anointed Longsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/truill_flowerblade
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/rhynnrhynn_staff
	name = "Cosmetic Kit - Celestial Staff - Required: Blacksteel Staff or Refined Blacksteel Staff"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/rhynnrhynn_staff
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/rhynnrhynn_staff_crested
	name = "Cosmetic Kit - Celestial Staff, Crested - Required: Blacksteel Staff or Refined Blacksteel Staff"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/rhynnrhynn_staff_crested
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/rhynnrhynn_staff_winged
	name = "Cosmetic Kit - Celestial Staff, Winged - Required: Blacksteel Staff or Refined Blacksteel Staff"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/rhynnrhynn_staff_winged
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/rhynnrhynn_staff_solar
	name = "Cosmetic Kit - Celestial Staff, Solar - Required: Blacksteel Staff or Refined Blacksteel Staff"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/rhynnrhynn_staff_solar
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lamprey_stechhelm
	name = "Cosmetic Kit - Stechhelm - Required: Iron Aventailed Bascinet or Steel Aventailed Bascinet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/lamprey_stechhelm
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/squidqueen_longcoat
	name = "Cosmetic Kit - Ragged Longcoat - Required: Longcoat or Hardened Leather Coat"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/squidqueen_longcoat
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/squidqueen_longcoat_alt
	name = "Cosmetic Kit - Frayed Longcoat - Required: Longcoat or Hardened Leather Coat"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/squidqueen_longcoat_alt
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/squidqueen_harlottoga
	name = "Cosmetic Item - Harlotous Toga"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/tabard/donator_squidqueen_harlottoga
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/hellpossum_apostle_armor
	name = "Cosmetic Kit - Apostle's Armor - Required: Steel Cuirass, Steel Full Plate or Steel Scale Armor, including Fluted or Ornate variants"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_apostle_armor
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/hellpossum_robed_apostle_armor
	name = "Cosmetic Kit - Apostle's Armor, Robed - Required: Steel Cuirass, Steel Full Plate, Steel Scale Armor or Steel Hauberk, including Fluted or Ornate variants"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_robed_apostle_armor
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/hellpossum_apostle_helm
	name = "Cosmetic Kit - Apostle's Burgeonet - Required: Pigface Bascinet, Hounskull Bascinet, Roundface Bascinet or Aventailed Bascinet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_apostle_helm
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/hellpossum_apostle_winghelm
	name = "Cosmetic Kit - Apostle's Burgeonet, Winged - Required: Pigface Bascinet, Hounskull Bascinet or Roundface Bascinet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_apostle_winghelm
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/hellpossum_apostle_wingsallet
	name = "Cosmetic Kit - Apostle's Sallet, Winged - Required: Visored Sallet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_apostle_wingsallet
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/hellpossum_grandmaster_armor
	name = "Cosmetic Kit - Grandmaster's Armor, Robed - Required: Steel Full Plate or Steel Hauberk, including Fluted or Ornate variants"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_grandmaster_armor
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/hellpossum_grandmaster_helm
	name = "Cosmetic Kit - Grandmaster's Burgeonet - Required: Pigface Bascinet, Hounskull Bascinet, Roundface Bascinet or Aventailed Bascinet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_grandmaster_helm
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/hellpossum_grandmaster_helm_habit
	name = "Cosmetic Kit - Grandmaster's Burgeonet, Habited - Required: Pigface Bascinet, Hounskull Bascinet, Roundface Bascinet or Aventailed Bascinet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/hellpossum_grandmaster_habit
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/rosy/birdmask
	name = "Cosmetic Kit - Beaked Mask - Required: Steel Maille Mask or Fluted Steel Maille Mask"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/rosy/birdmask
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/flimsy_visor
	name = "Helmetless Visor"
	category = "Accessories"
	category = list("Accessories", "Points")
	path = /obj/item/clothing/mask/rogue/facemask/steel/visor/flimsy
	triumph_cost = 4

/datum/loadout_item/furcollar
	name = "Fur Collar"
	category = "Accessories"
	path = /obj/item/clothing/neck/roguetown/collar/fur

/datum/loadout_item/scoutcloak
	name = "Scout Cloak"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/scout

/datum/loadout_item/traditionaltabard
	name = "Traditional Tabard, Psydonic"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/tabard/psydontabard/white

/datum/loadout_item/fancycoattrimmed
	name = "Trimmed Fancy Coat"
	category = "Raincoats"
	path = /obj/item/clothing/cloak/poncho/fancycoat/trimmed


/datum/loadout_item/donator/universal/headpiece_decoration
	name = "Cosmetic Item - Oathtaker's Orle"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/decoration/orle
	donatitem = TRUE

/datum/loadout_item/donator/universal/headpiece_oathkeeperdec
	name = "Cosmetic Item - Oathtaker's Decoration, Shieldcrest"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/decoration/orle/donator_oathkeeper
	donatitem = TRUE

/datum/loadout_item/donator/universal/donator_jacketed_gambeson_short
	name = "Cosmetic Kit - Short Jacketed Gambeson - Required: Padded Gambeson or Gambeson"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_jacketed_gambeson_short
	donatitem = TRUE

/datum/loadout_item/donator/universal/donator_jacketed_gambeson_long
	name = "Cosmetic Kit - Long Jacketed Gambeson - Required: Padded Gambeson or Gambeson"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_jacketed_gambeson_long
	donatitem = TRUE

/datum/loadout_item/donator/moonlightdussack
	name = "Cosmetic Kit - Moonlight Dussack - Required: Sabre or Steel Shortsword"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/moonlightdussack
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/nero_woodlandcloak
	name = "Cosmetic Item - Woodland Mantle"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/furcloak/woodland
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/nero_woodlandhood
	name = "Cosmetic Item - Woodland Shawl"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/roguehood/shawlhood/woodland
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/nero_woodlandbrigplackart
	name = "Cosmetic Kit - Woodland Brigandine - Required: Light Brigandine, Studded Leather Armor, Steel Cuirass, Fluted Cuirass, Haubergeon or Hauberk"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/nero_woodlandbrigplackart
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lagomorphica_obligatoire
	name = "Cosmetic Kit - Obligatoire - Required: Longsword, Sabre or Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_lagomorphica_obligatoire
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lagomorphica_delirante
	name = "Cosmetic Kit - Delirante - Required: Longsword, Sabre or Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_lagomorphica_delirante
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lagomorphica_traitresse
	name = "Cosmetic Kit - Traitresse - Required: Spear, Halberd or Greataxe"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_lagomorphica_traitresse
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/stalkerino_drowsword
	name = "Cosmetic Kit - Skikuldic Sword - Required: Steel Arming Sword, Longsword, Sabre or Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/donator_stalkerino_drowsword
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/stalkerino_drowcrossbow
	name = "Cosmetic Kit - Skikuldic Crossbow - Required: Crossbow or Slurbow"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_stalkerino_drowcrossbow
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/rivercadaver_tabis
	name = "Cosmetic Item - Tabis - Required: Leather Boots, Psydonic Leather Boots, or Inquisitorial Boots"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_rivercadaver_tabis
	donatitem = TRUE

/datum/loadout_item/donator/stalkerino_drowhelmet
	name = "Cosmetic Kit - Skikudic Savoyard - Required: Hounskull Bascinet, Pigface Bascinet, Visored Sallet or Savoyard"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_stalkerino_drowhelmet
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/chivalre_drowmantle
	name = "Cosmetic Kit - Scourge Mantle - Required: Hounskull Bascinet, Pigface Bascinet, Visored Sallet or Savoyard"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_chivalre_drowmantle
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/chivalre_drowgreatflail
	name = "Cosmetic Kit - Jagged Skikuldic Greatflail - Required: Greatflail"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_chivalre_drowgreatflail
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/chivalre_drowgreatflailalt
	name = "Cosmetic Kit - Smooth Skikuldic Greatflail - Required: Greatflail"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_chivalre_drowgreatflailalt
	donatitem = TRUE
	donat_tier = 2


/datum/loadout_item/shawlhood
	name = "Shawl (Hijab Variant)"
	category = "Hats"
	path = /obj/item/clothing/head/roguetown/roguehood/shawlhood


/datum/loadout_item/shortskirt
	name = "Short Skirt"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/skirt/short


/datum/loadout_item/silkshirt
	name = "Silk Shirt"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/shadowshirt

/datum/loadout_item/darkjacket
	name = "Dark Jacket"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/fancyjacket/triumph_padded

/datum/loadout_item/shalwarpants
	name = "Shalwar Pants"
	category = "Clothing"
	path = /obj/item/clothing/under/roguetown/tights/shalwar

/datum/loadout_item/greendress
	name = "Light Green Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/green

/datum/loadout_item/bluedress
	name = "Light Blue Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/blue

/datum/loadout_item/taverndress
	name = "Tavern Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/tavern

/datum/loadout_item/courtesandress
	name = "Courtesan Dress"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/courtesan

/datum/loadout_item/nightgown
	name = "Nightgown"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/nightgown

/datum/loadout_item/wintercoat
	name = "Winter Coat"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/winter

/datum/loadout_item/blouse
	name = "Blouse"
	category = "Clothing"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/blouse

/datum/loadout_item/triumph_armorkit_pleather
	name = "Cosmetic Kit - Padded Leather Armor - Required: Leather Armor, Leather Cuirass, Studded Leather Armor or Hardened Leather Armor"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_armorkit_pleather
	triumph_cost = 12

/datum/loadout_item/triumph_weaponkit_khanda
	name = "Cosmetic Kit - Khanda - Required: Iron Arming Sword, Steel Arming Sword, Silver Arming Sword or Bronze Arming Sword"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_weaponkit_khanda
	triumph_cost = 12

/datum/loadout_item/triumph_weaponkit_urumi
	name = "Cosmetic Kit - Urumi - Required: Whip, Bronze Whip, Silver Whip or Blacksteel Whip"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_weaponkit_urumi
	triumph_cost = 12

/datum/loadout_item/triumph_weaponkit_pata
	name = "Cosmetic Kit - Pata - Required: Steel Katar, Silver Katar or Bronze Katar"
	category = list("Points")
	path = /obj/item/enchantingkit/triumph_weaponkit_pata
	triumph_cost = 12

/datum/loadout_item/donator_crowcane_blade
	name = "Cosmetic Kit - Crow Cane Blade - Required: Decorated Rapier or Decorated Sabre"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/crowcane_blade
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_crowcane_scabbard
	name = "Cosmetic Kit - Crow Cane Scabbard - Required: Decorated Scabbard, Golden"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/crowcane_scabbard
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator_jezail
	name = "Cosmetic Kit - Jezail - Required: Arquebus, Hakenbüchse, or Barker"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/jezail
	donatitem = TRUE

/datum/loadout_item/donator_teppo
	name = "Cosmetic Kit - Teppo - Required: Arquebus, Hakenbüchse, or Barker"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/teppo
	donatitem = TRUE

/datum/loadout_item/triumph_thinwinterdress
	name = "Thin Winter Dress"
	category = list("Clothing", "Points")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/thinwinterdress/triumph
	triumph_cost = 6

/datum/loadout_item/donator/ryan/naginata
	name = "Cosmetic Kit - +5 Common Profane Naginata - Required: Spear or Halberd"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/ryan_naginata
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/lime_swordspear
	name = "Cosmetic Kit - Ornate Swordspear - Required: Greatsword or Halberd"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/limetease_swordspear
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/kadedao
	name = "Cosmetic Kit - Spring Cometh - Required: Shortsword or Sabre"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/kadedao
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/rosy/rosecollar
	name = "Cosmetic Kit - Rosestone Clasped Collar - Required: Amulet of Eora"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/rosy/rosecollar
	donatitem = TRUE

/datum/loadout_item/donator/glassfeddockterr_bighat
	name = "Cosmetic Item - Wizard's Big Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/wizhat/bighat
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/koruu_cadwyncloak
	name = "Cosmetic Item - Sefirot's Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/ravoxcleric/koruu
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/koruu_cadwynhelm
	name = "Cosmetic Item - Gebura - Required: Justice Eagle"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_koruu_ravoxclerichelm
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/universal/greatcoat
	name = "Cosmetic Item - Greatcoat"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/donator_greatcoat
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/universal/greatcoat_dyeable
	name = "Cosmetic Item - Greatcoat, Dyeable"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/donator_greatcoat/dyeable
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/universal/shadedhat
	name = "Cosmetic Item - Shaded Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/roguehood/shadedhat
	donatitem = TRUE

/datum/loadout_item/donator/universal/beltedbackpackkit
	name = "Cosmetic Item - Belted Backpack - Required: Backpack"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/beltedbackpack
	donatitem = TRUE

/datum/loadout_item/donator/drd/tiara
	name = "Cosmetic Item - Ornate Coronet"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/nyle/consortcrown/drd
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/drd/smallsword
	name = "Cosmetic Kit - 'Mære' - Required: Steel Rapier"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/drd_rapier
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/flybrokenwings_drowparasol
	name = "Cosmetic Item - Skikuldic Parasol"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/rogueweapon/mace/donator_flybrokenwings_parasol
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/naman_lance
	name = "Cosmetic Kit - Noble Lance - Required: Steel Lance"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_naman_lance
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/naman_sabre
	name = "Cosmetic Kit - Noble Sabre - Required: Steel Sabre"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_naman_sabre
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/naman_tassetedbeltpack
	name = "Cosmetic Kit - Tasseted Beltpack - Required: Steel Tasseted Belt or Beltpack"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_naman_tassetedbeltpack
	donatitem = TRUE
/*
/datum/loadout_item/donator/naman_triumph_tassetedbeltpack
	name = "Cosmetic Item - Tasseted Beltpack"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/storage/backpack/rogue/satchel/beltpack/donator_naman
	donatitem = TRUE
*/
/datum/loadout_item/donator/naman_deccoatofplates
	name = "Cosmetic Kit - Decorated Coat Of Plates - Required: Steel Coat-Of-Plates"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_naman_deccoatofplates
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/naman_scarfedridercloak
	name = "Cosmetic Item - Rider's Scarfed Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/half/rider/donator_naman
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/sanshoom_prowlerrobe
	name = "Cosmetic Kit - Prowler Robe - Required: Stalker Robe or Heavy Stalker Robe"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_sanshoom_prowlerrobe
	donatitem = TRUE

/datum/loadout_item/donator/sanshoom_prowlermask
	name = "Cosmetic Kit - Prowler Mask - Required: Purple Halfmask"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_sanshoom_prowlermask
	donatitem = TRUE

/datum/loadout_item/donator/trueterrydactyl_shibari
	name = "Cosmetic Item - Smallclothes, Shibari (Underwear)"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/undies/bikini/shibari
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/guidesa_bonebuckler
	name = "Cosmetic Kit - Bone Buckler - Required: Buckler"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/guidesa_bonebuckler
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/guidesa_bonesickle
	name = "Cosmetic Kit - Bone Sickle - Required: Combat Knife"
	category = list("Weapons", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/weapon/guidesa_bonesickle
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/koruu_cadwyncloak_astrata
	name = "Cosmetic Item - Cloak of the Order of the Sun"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/templar/astratancleric/koruu
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/koruu_cadwynhelm_astrata
	name = "Cosmetic Item - Lux In Tenebris - Required: Astratan/Astrata Helmet"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_koruu_astrataclerichelm
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/lief_friend
	name = "Cosmetic Item - Aurum's Amulets"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/neck/roguetown/psicross/liefdonator
	donatitem = TRUE

/datum/loadout_item/donator/rezathedwarf
	name = "Cosmetic Item - Glimmering Cloak (Only Male, No Small Races)"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/half/donator_rezathedwarf
	donatitem = TRUE

/datum/loadout_item/donator/rezathedwarf/blade
	name = "Cosmetic Kit - The Enclave Blade - Required: Sabre"
	path = /obj/item/enchantingkit/weapon/donator_rezathedwarf_blade
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/scarlet_hat
	name = "Cosmetic Item - Scarlet Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/rosa
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/velvet_hat
	name = "Cosmetic Item - Velvet Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/rosa/three
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/obsidian_hat
	name = "Cosmetic Item - Obsidian Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/rosa/four
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/sable_hat
	name = "Cosmetic Item - Sable Hat"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/rosa/five
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/maroon_cap
	name = "Cosmetic Item - Maroon Cap"
	category = list("Hats", "Legacy Cosmetics")
	path = /obj/item/clothing/head/roguetown/rosa/six
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/regal_cloak
	name = "Cosmetic Item - Regal Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/rosa
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/courtly_cloak
	name = "Cosmetic Item - Courtly Cloak"
	category = list("Raincoats", "Legacy Cosmetics")
	path = /obj/item/clothing/cloak/rosa/two
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/ivory_shoes
	name = "Cosmetic Item - Ivory Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/scarlet_shoes
	name = "Cosmetic Item - Scarlet Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/two
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/silvered_shoes
	name = "Cosmetic Item - Silvered Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/three
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/obsidian_shoes
	name = "Cosmetic Item - Obsidian Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/four
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/sable_shoes
	name = "Cosmetic Item - Sable Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/five
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/maroon_shoes
	name = "Cosmetic Item - Maroon Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/six
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/regal_shoes
	name = "Cosmetic Item - Regal Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/seven
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/courtly_shoes
	name = "Cosmetic Item - Courtly Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/eight
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/royal_shoes
	name = "Cosmetic Item - Royal Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/nine
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/stately_shoes
	name = "Cosmetic Item - Stately Shoes"
	category = list("Shoes", "Legacy Cosmetics")
	path = /obj/item/clothing/shoes/roguetown/rosa/ten
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/ivory_gloves
	name = "Cosmetic Item - Ivory Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/scarlet_gloves
	name = "Cosmetic Item - Scarlet Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/two
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/silvered_gloves
	name = "Cosmetic Item - Silvered Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/three
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/obsidian_gloves
	name = "Cosmetic Item - Obsidian Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/four
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/sable_gloves
	name = "Cosmetic Item - Sable Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/five
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/maroon_gloves
	name = "Cosmetic Item - Maroon Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/six
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/regal_gloves
	name = "Cosmetic Item - Regal Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/seven
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/courtly_gloves
	name = "Cosmetic Item - Courtly Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/eight
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/royal_gloves
	name = "Cosmetic Item - Royal Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/nine
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/stately_gloves
	name = "Cosmetic Item - Stately Gloves"
	category = list("Accessories", "Legacy Cosmetics")
	path = /obj/item/clothing/gloves/roguetown/rosa/ten
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/ivory_dress
	name = "Cosmetic Item - Ivory Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosa
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/scarlet_dress
	name = "Cosmetic Item - Scarlet Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosa/two
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/velvet_dress
	name = "Cosmetic Item - Velvet Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosa/three
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/obsidian_dress
	name = "Cosmetic Item - Obsidian Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosa/four
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/sable_dress
	name = "Cosmetic Item - Sable Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosa/five
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/maroon_dress
	name = "Cosmetic Item - Maroon Dress"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosa/six
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/regal_coat
	name = "Cosmetic Item - Regal Coat"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosacoat
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/courtly_coat
	name = "Cosmetic Item - Courtly Coat"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosacoat/two
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/royal_coat
	name = "Cosmetic Item - Royal Coat"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosacoat/three
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/stately_coat
	name = "Cosmetic Item - Stately Coat"
	category = list("Clothing", "Legacy Cosmetics")
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/rosacoat/four
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/limetease/limesaber
	name = "Cosmetic Kit - Malignant Blade - Required: Sabre"
	path = /obj/item/enchantingkit/weapon/limesaber
	category = list("Weapons", "Legacy Cosmetics")
	donatitem = TRUE
	donat_tier = 3

/datum/loadout_item/donator/universal/overseer_gold_mask
	name = "Cosmetic Kit - Golden Confessor Mask - Required: Any Armor Mask"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_overseer_gold_mask
	donatitem = TRUE
	donat_tier = 2

/datum/loadout_item/donator/universal/overseer_silver_mask
	name = "Cosmetic Kit - Silver Confessor Mask - Required: Any ArmorMask"
	category = list("Armor", "Legacy Cosmetics")
	path = /obj/item/enchantingkit/donator_overseer_silver_mask
	donatitem = TRUE
	donat_tier = 2
