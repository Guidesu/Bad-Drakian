/*GLOBAL_LIST_EMPTY(loadout_items)
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
	var/donator_unlocked = FALSE
	var/triumph_cost
	var/category = "Miscellaneous"

/datum/loadout_item/New()
	if(isnull(donoritem))
		if(ckeywhitelist || donator_unlocked)
			donoritem = TRUE
	var/obj/targetitem = path
	desc = targetitem.desc
	if (triumph_cost)
		desc += "<b>Worth [triumph_cost] TRIUMPHS.</b>"
	if(donat_tier > 0)
		desc += "<b>Available for patrons of level: [donat_tier]</b>"

/datum/loadout_item/proc/donator_ckey_check(key, client/user)
	if((donator_unlocked && (is_donator(key) || user?.holder)))
		return TRUE
	if(ckeywhitelist && ckeywhitelist.Find(key))
		return TRUE
	return
*/
