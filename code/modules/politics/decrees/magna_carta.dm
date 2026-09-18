/datum/decree/magna_carta
	id = DECREE_MAGNA_CARTA
	name = "The Magna Carta"
	category = DECREE_CATEGORY_NEW
	mechanical_text = "Zeroes every Crown levy and poll tax. Fines remain. The Crown collects only voluntary tribute."
	active = FALSE
	flavor_text = {"%RULER_NAME%, by the grace of Astrata, Grand Duke of Azuria, overlord of Kingsfield, Blackholt, Hagenwald, Saltwick, Rosawood, Genava and Daftsmarch, banneret of the Grim Coast, Northfort and Côte d'Azur Enclave, loyal servant of the Ten Indivisible, to their archbishops, priests, templars, inquisitors, counts, princes, spouses, assistants, managers, advisers, clerks, marshals, knights, sergeants, warriors, guards, squires, court magicians, archivists, apothecaries, chief physicians, merchants, innkeepers, bath attendants, guild members, townspeople, To peasants, farmers, cooks, innkeepers, servants, forced laborers, mercenaries, adventurers, pilgrims, as well as to all my officials and loyal subjects, I offer honor and greetings.

Know then, that for the salvation of our soul, for the common good of the Grand Duchy, for the glory of the Ten, for the elevation of the holy Church and for better governance of our duchy, I grant to every subject of Azuria, regardless of rank, position, or origin, exemption from all taxes, fees, duties, and all other financial burdens concerning their persons, estates, property, labor, and craft, as well as concerning the means of their sustenance, whether in monetary or any other form.

In return, the subjects of Azuria must remember the Crown in their personal thoughts, speak of it with respect when appropriate, and provide such income as conscience dictates and means allow, in such amounts and at such times as each subject deems suitable.

Certified by the seal%RULER_NAME%, of the Grand Duke of these lands, and may his name be glorified forever."}
	revoke_text = "Hear ye, hear ye. %RULER_NAME%, by the grace of Astrata, %RULER% of Azuria, Count of Kingsfield, Blackholt, and Saltwick, Overlord of Rosawood, Rockhill, and Daftsmarch, Protector of Bleakcoast, Northfort, and Heartfelt, Defender of the Ten, hath this day set aside the Magna Carta. The Realm's subjects are hereby restored to their accustomed fiscal obligations, and the Crown's revenue is restored in kind. Let the record reflect the reconsideration of %RULER_NAME%."
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
	priority_announce(body, "BY LORDLY MERCY", pick('sound/misc/royal_decree.ogg', 'sound/misc/royal_decree2.ogg'), "Captain", strip_html = FALSE)
