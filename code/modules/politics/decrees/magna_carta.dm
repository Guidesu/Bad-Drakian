/datum/decree/magna_carta
	id = DECREE_MAGNA_CARTA
	name = "The Magna Carta"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "Zeroes every Crown levy and poll tax. Fines remain. The Crown collects only voluntary tribute."
	active = FALSE
	flavor_text = {"%RULER_NAME%, by the grace of Astrata, %RULER% of %REALM% and defender of its people, offers honor and greetings to every officer, cleric, soldier, craftsperson, laborer, traveler, and loyal subject of the realm.

Know that, for the good governance of %REALM%, the dignity of its people, and the glory of the Ten, the Crown grants every subject exemption from all taxes, fees, duties, and other financial burdens upon their person, estate, property, labor, craft, and means of sustenance, whether demanded in coin or in kind.

In return, the subjects of %REALM% shall remember the Crown in their thoughts, speak of it with due respect, and offer only such voluntary tribute as conscience and means allow.

Given under the seal of %RULER_NAME%, %RULER% of %REALM%."}
	revoke_text = "Hear ye, hear ye. %RULER_NAME%, %RULER% of %REALM%, has this day set aside the Magna Carta. The realm's subjects are restored to their customary fiscal obligations, and the Crown's revenues are restored in kind. Let the record show the decree of %RULER_NAME%."
	// restore_text intentionally unset - broadcast_state_change is overridden below so that
	// restoring the Carta reads the full charter aloud, ruler's name and all. That's the joke.

/datum/decree/magna_carta/roll_initial_year()
	return CALENDAR_EPOCH_YEAR

/datum/decree/magna_carta/on_restore()
	. = ..()
	SStreasury.tax_rates[TAX_CATEGORY_CONTRACT_LEVY] = 0
	SStreasury.tax_rates[TAX_CATEGORY_HEADEATER_LEVY] = 0
	SStreasury.tax_rates[TAX_CATEGORY_IMPORT_TARIFF] = 0
	SStreasury.tax_rates[TAX_CATEGORY_EXPORT_DUTY] = 0
	// Fines stay at their configured rate - the Crown can still punish.
	for(var/category in SStreasury.poll_tax_rates)
		SStreasury.poll_tax_rates[category] = 0

/datum/decree/magna_carta/broadcast_state_change()
	if(!active)
		return ..()
	var/body = get_display_flavor_text()
	if(!body)
		return ..()
	priority_announce(body, "BY THE CROWN'S MERCY", pick('sound/misc/royal_decree.ogg', 'sound/misc/royal_decree2.ogg'), "Captain", strip_html = FALSE)
