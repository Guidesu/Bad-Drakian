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
	flavor_text = {"This Contract of the Defenders of Azuria, concluded between the Crown of Azuria, on the one hand, and the Armed Forces of the Grand Duchy, on the other hand, testifies to the following:

The Crown undertakes to pay its soldiers fair salaries on a daily basis, without delays or postponements, according to the ranks specified in this document:
 
- Marshal of the Grand Duchy — sixty mammon,
- Knights of Azuria — forty mammon,
- Guard Sergeants — also forty mammon,
- Soldiers — twenty mammon.
- Wardens — twenty mammon,
- Squires of the Knights of Azuria — ten mammon.

No reward may be less than the specified amounts for the duration of this Contract.

In return, the servicemen of the Grand Duchy agree to faithfully serve the Grand Duke and obey his lieutenants and officers in all lawful and reasonable matters. And if the said servicemen breach or fail to fulfill this Contract, the Duke is endowed with the legal right to unilaterally determine their fate, no matter how severe it may be. And if the Crown violates this Contract — withholding the reward promised in it or setting it lower than specified here — the soldier is released from his oath, and the Crown will be accountable for the committed breach of the oath.

In confirmation of which, the Crown of Azuria has affixed its seal on this Contract, and the lawful representative of the servicemen of the Grand Duchy has affixed his seal in the same manner.

Certified by the seal of the Crown and the seal of the Marshal of the Grand Duchy."}
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
