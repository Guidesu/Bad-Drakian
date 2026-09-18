/datum/decree/indenture_of_war
	id = DECREE_INDENTURE_OF_WAR
	name = "The Indenture of War"
	category = DECREE_CATEGORY_ANCIENT
	mechanical_text = "Sets minimum daily wages for soldiery: Marshal 60m, Knight/Sergeant 40m, Man-at-Arms/Warden 20m, Squire 10m."
	/// Per-rank mandated daily wage. Steward cannot set below these amounts while the Indenture
	/// stands, and any existing below-floor wage is bumped up at activation. Military ranks only -
	/// courtiers, healers, scholars, and civilian staff are not covered by this charter.
	var/static/list/wage_floors = list(
		"Marshal" = 60,
		"Knight" = 40,
		"Sergeant" = 40,
		"Man at Arms" = 20,
		"Warden" = 20,
		"Squire" = 10,
	)
	flavor_text = {"This Contract of the Defenders of %REALM%, concluded between the Crown and the realm's armed forces, records the following terms:

The Crown shall pay its soldiers fair daily wages, without delay, according to the ranks set forth herein:
 
- Marshal of %REALM% — sixty mammon,
- Knights — forty mammon,
- Guard Sergeants — forty mammon,
- Soldiers — twenty mammon,
- Wardens — twenty mammon,
- Squires — ten mammon.

No wage may fall below these amounts while this Contract remains in force.

In return, the soldiers of %REALM% shall faithfully serve the %RULER% and obey the Crown's officers in all lawful and reasonable matters. A soldier who breaks this Contract shall answer to the Crown. If the Crown withholds the promised wage or sets it below the amount written here, the soldier is released from the corresponding oath of service, and the Crown shall answer for its breach.

In witness thereof, the Crown of %REALM% and the lawful representative of its soldiers have affixed their seals to this Contract.

Certified by the seals of the Crown and the Marshal of %REALM%."}
	revoke_text = "The %RULER% has broken the Indenture of War. The soldier's oath is dissolved, and the Crown's armed men stand at liberty of service - let the garrison remember whose seal was cut first."
	restore_text = "The %RULER% has renewed the Indenture of War. The soldier's wage is pledged, and the soldier's oath stands - each binds the other."

/datum/decree/indenture_of_war/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(40, 120)

/datum/decree/indenture_of_war/apply_wage_floor(job_title, current_floor)
	var/mandated = wage_floors[job_title] || 0
	return max(current_floor, mandated)

/datum/decree/indenture_of_war/wage_floored_jobs()
	return wage_floors

/datum/decree/indenture_of_war/on_restore()
	. = ..()
	SStreasury.steward_machine?.enforce_wage_floors()
