/obj/item/book/granter/residentcard
	name = "Resident Certificate"
	icon_state = "contractunsigned"
	icon = 'icons/roguetown/items/misc.dmi'
	desc = "This deed gives the signer the right of residence and the opportunity to occupy a vacant house in the city."
	oneuse = TRUE
	drop_sound = 'sound/foley/dropsound/paper_drop.ogg'
	pickup_sound = 'sound/blank.ogg'

/obj/item/book/granter/residentcard/Initialize()
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return .
	if(!resident_manuscripts_enabled())
		return INITIALIZE_HINT_QDEL

/obj/item/book/granter/residentcard/attack_self(mob/living/user)
	if(!resident_manuscripts_enabled())
		to_chat(user, span_warning("Certificates of residence on this map are temporarily unavailable."))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_RESIDENT))
		to_chat(user, span_danger("I already have a residence!"))
		return FALSE
	if(icon_state == "contractsigned")
		to_chat(user, span_danger("This letter has already been signed."))
		return FALSE
	else
		var/obj/item/writefeather
		for(var/obj/item/I in user.held_items)
			if(istype(I, /obj/item/natural/feather))
				writefeather = I
				break
		if(!writefeather)
			to_chat(user, span_warning("I need to hold the pen!"))
			return FALSE

		var/turf/T = get_step(user, user.dir)
		if(!(locate(/obj/structure/table) in T))
			to_chat(user, span_warning("I need a table to fill out the certificate."))
			return FALSE

		if(!do_after(user, 4 SECONDS, TRUE))
			to_chat(user, span_warning("I'm losing concentration and can't sign the letter properly."))
			return FALSE

		to_chat(user, span_notice("I sign the document and receive the right to reside in the city."))
		playsound(user, 'sound/items/write.ogg', 50, TRUE, -2)
		ADD_TRAIT(user, TRAIT_RESIDENT, TRAIT_GENERIC)
		onlearned(user)

/obj/item/book/granter/residentcard/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		name = "[user.real_name] - certificate of residence"
		desc = "A certificate confirming the signatory's lawful residence."
		icon_state = "contractsigned"

#ifdef COMPILE_LEGACY_RESIDENTCARDVIRTUE
#define MANUSCRIPT_ITEM_DESCRIPTION "This ivory-colored parchment is perfectly smooth, cool, and free of imperfections. Its gilded edges shimmer as it unfolds with a dry rustle. The text is written in deep blue-black ink with lapis lazuli initials, and an intricate wax seal hangs from a silk-and-gold cord. The document smells of wax, herbs, and expensive leather."

#define MANUSCRIPT_DESCRIPTION "Let it be publicly known that, by the will of the Crown and under the Council's supervision, the bearer of this document is recognized as a lawful resident of these lands and enjoys the protection of common law. Every official and titled person must recognize the named bearer as a faithful subject and place no unlawful obstacle in their way. Anyone who harms the bearer by deed or design shall answer fully before the law for defying the order established by the throne."

#define MANUSCRIPT_DEFECT_NOTES list(\
	"A barely noticeable blot in the corner is visible on the paper.",\
	"The ink on the print is slightly smudged.",\
	"One of the letters in the name was written with an unsteady hand.",\
	"The edge of the parchment is cut unevenly.",\
	"The signature appears hesitant.",\
	"The parchment gives off a stale smell.",\
	"The lapis lazuli initial sits out of line and appears to have dried over the main text.",\
	"Fresh ruling marks along the lower margin do not align with the written lines.",\
	"In several places, the gilded edging overlaps a fresh cut.",\
	"The silk-gold cord has been re-threaded: fiber breaks are visible around the holes.",\
	"The sealing wax of one seal is warmer in color and shines as if recently melted.",\
	"The ink in the middle of one line has a bluish halo, as though diluted with a different liquid.",\
	"In the date, one stroke is crossed out too evenly for a clerical hand.",\
	"Someone else’s postscript appears between the lines: “Zizo keeps a whisper, Graggar waits for blood, Matthios weighs his debt.”",\
)

#define MANUSCRIPT_MIN_FOUND_DEFECT_COUNT 3
#define MANUSCRIPT_MAX_FOUND_DEFECT_COUNT 5

#define MANUSCRIPT_VALIDATION_NOTES list(\
	"The seals sit evenly, the ink is applied with confidence, and the cord shows no sign of reattachment.",\
	"The ruling marks, guide holes, and written lines align perfectly; the letter follows the proper form.",\
	"The handwriting, seals, and gilded edges are consistent. There is no reason to doubt the scribe's skill.",\
	"The wax bears a deep, unbroken impression, and every line appears to be written by the same hand.",\
	"The document follows every convention of clerical practice.",\
)

#define FAKE_DEFECT_CHANCE 65

/obj/item/book/granter/residentcardvirtue
	name = "Travel Certificate"
	desc = MANUSCRIPT_ITEM_DESCRIPTION
	icon_state = "contractsigned"
	icon = 'icons/roguetown/items/misc.dmi'
	drop_sound = 'sound/foley/dropsound/paper_drop.ogg'
	pickup_sound = 'sound/blank.ogg'
	oneuse = FALSE
	var/owner_character_key
	var/owner_name
	var/owner_status_label
	var/expiry_date
	var/issued_place
	var/description
	var/is_bound = FALSE
	var/is_fake = FALSE
	var/undetectable_fake = FALSE
	var/authority_validated = FALSE
	var/defect_note
	var/list/defect_notes
	var/list/seals
	var/list/detection_attempts
	var/list/detection_results
	var/list/detection_notes
	var/auto_stamp_seals = TRUE
	var/can_grant_residence = TRUE
	var/expiry_year_bonus_min = 0
	var/expiry_year_bonus_max = 0

/obj/item/book/granter/residentcardvirtue/Initialize()
	. = ..()
	issued_place = get_map_display_name()
	description = MANUSCRIPT_DESCRIPTION
	expiry_date = compute_expiry_date()
	defect_notes = list()
	seals = list(
		"chancellor" = null,
		"elder" = null,
		"duke" = null,
		"hand" = null,
	)
	detection_attempts = list()
	detection_results = list()
	detection_notes = list()
	if(auto_stamp_seals)
		stamp_all_seals(should_initially_include_duke_seal())

/obj/item/book/granter/residentcardvirtue/proc/get_map_display_name()
	var/raw = SSmapping.config?.map_name
	switch(raw)
		if("Dun World")
			return "Duchy of Azuria"
		if("Rockhill")
			return "Rockhill"
	return raw || "Azur Peak"

/obj/item/book/granter/residentcardvirtue/proc/compute_expiry_date()
	var/round_id = text2num(GLOB.round_id) || 0
	var/days_since_epoch = (round_id) * CALENDAR_DAYS_IN_WEEK + (GLOB.dayspassed - 1)
	if(GLOB.date_override_enabled)
		days_since_epoch += GLOB.date_override_offset
	var/day_of_year = MODULUS(days_since_epoch, CALENDAR_DAYS_IN_YEAR) + 1
	var/current_month = FLOOR((day_of_year - 1) / CALENDAR_DAYS_IN_MONTH, 1) + 1
	var/current_day = MODULUS((day_of_year - 1), CALENDAR_DAYS_IN_MONTH) + 1
	var/offset = rand(10, 20)
	var/new_day = current_day + offset
	var/new_month = current_month
	var/new_year = CALENDAR_EPOCH_YEAR
	while(new_day > CALENDAR_DAYS_IN_MONTH)
		new_day -= CALENDAR_DAYS_IN_MONTH
		new_month += 1
	if(new_month > CALENDAR_MONTHS_PER_YEAR)
		new_year += FLOOR((new_month - 1) / CALENDAR_MONTHS_PER_YEAR, 1)
		new_month = ((new_month - 1) % CALENDAR_MONTHS_PER_YEAR) + 1
	if(expiry_year_bonus_max > 0)
		new_year += rand(expiry_year_bonus_min, expiry_year_bonus_max)
	return "[new_day] [get_month_number_to_text(new_month)] [new_year]"

/obj/item/book/granter/residentcardvirtue/proc/get_ruler_seal_title()
	return SSticker?.rulertype || "Count"

/obj/item/book/granter/residentcardvirtue/proc/is_noble_manuscript_status()
	return owner_status_label == "Under the Grace of Astrata"

/obj/item/book/granter/residentcardvirtue/proc/should_initially_include_duke_seal()
	return is_noble_manuscript_status()

/obj/item/book/granter/residentcardvirtue/proc/stamp_all_seals(include_duke_seal = TRUE)
	seals["chancellor"] = list("stamper" = "Chancellor", "time" = world.time)
	seals["elder"] = list("stamper" = "Elder", "time" = world.time)
	seals["duke"] = include_duke_seal ? list("stamper" = get_ruler_seal_title(), "time" = world.time) : null
	seals["hand"] = list("stamper" = "Hand", "time" = world.time)

/obj/item/book/granter/residentcardvirtue/proc/has_any_seal()
	if(!seals)
		return FALSE
	for(var/seal_key in seals)
		if(seals[seal_key])
			return TRUE
	return FALSE

/obj/item/book/granter/residentcardvirtue/proc/get_seal_key_for_user(mob/living/carbon/human/user)
	if(!user)
		return null
	var/datum/job/J = SSjob.GetJob(user.mind?.assigned_role)
	if(istype(J, /datum/job/roguetown/councillor))
		return "chancellor"
	var/datum/advclass/advclass = SSrole_class_handler.get_advclass_by_name(user.advjob)
	if(istype(advclass, /datum/advclass/elder))
		return "elder"
	if(istype(J, /datum/job/roguetown/lord))
		return "duke"
	if(istype(J, /datum/job/roguetown/hand))
		return "hand"
	return null

/obj/item/book/granter/residentcardvirtue/proc/seal_title_for_key(key)
	switch(key)
		if("chancellor")
			return "Chancellor"
		if("elder")
			return "Elder"
		if("duke")
			return get_ruler_seal_title()
		if("hand")
			return "Hand"
	return ""

/obj/item/book/granter/residentcardvirtue/proc/get_detection_character_key(mob/living/carbon/human/user)
	if(!user)
		return null
	if(user.mobid)
		return "[user.mobid]"
	return user.real_name || user.name

/obj/item/book/granter/residentcardvirtue/proc/is_owner_viewer(mob/living/carbon/human/user)
	if(!ishuman(user))
		return FALSE
	var/detection_key = get_detection_character_key(user)
	if(owner_character_key && detection_key && detection_key == owner_character_key)
		return TRUE
	if(is_fake && owner_name)
		var/real_name = user.real_name || ""
		var/user_name = user.name || ""
		if(owner_name == real_name || owner_name == user_name || owner_name == html_encode(real_name) || owner_name == html_encode(user_name))
			return TRUE
	return FALSE

/obj/item/book/granter/residentcardvirtue/examine(mob/user)
	. = ..()
	if(is_bound && owner_name)
		. += span_info("Certificate issued in the name: [owner_name].")
	else
		. += span_info("The certificate has not yet been sealed with the owner.")

/obj/item/book/granter/residentcardvirtue/attack_self(mob/living/user)
	ui_interact(user)

/obj/item/book/granter/residentcardvirtue/equipped(mob/living/user, slot)
	. = ..()
	if(is_bound || !ishuman(user))
		return
	if(istype(src, /obj/item/book/granter/residentcardvirtue/fake))
		return
	if(istype(src, /obj/item/book/granter/residentcardvirtue/base))
		return
	bind_to_holder(user)

/obj/item/book/granter/residentcardvirtue/proc/bind_to_holder(mob/living/carbon/human/target)
	if(is_bound || !ishuman(target))
		return
	owner_character_key = get_detection_character_key(target)
	owner_name = target.real_name
	owner_status_label = status_label_for(target)
	is_bound = TRUE
	name = "Travel Certificate"
	if(auto_stamp_seals)
		stamp_all_seals(should_initially_include_duke_seal())

/obj/item/book/granter/residentcardvirtue/proc/can_make_undetectable_forgery(mob/living/carbon/human/user)
	return can_write_master_forgery(user) && (is_fake || istype(src, /obj/item/book/granter/residentcardvirtue/base))

/obj/item/book/granter/residentcardvirtue/proc/can_write_master_forgery(mob/living/carbon/human/user)
	if(!ishuman(user))
		return FALSE
	return HAS_TRAIT(user, TRAIT_GOODWRITER) || user.get_true_stat(STATKEY_INT) >= 17

/obj/item/book/granter/residentcardvirtue/proc/can_edit_fake_manuscript(mob/living/carbon/human/user)
	return ishuman(user) && is_fake && !is_bound

/obj/item/book/granter/residentcardvirtue/proc/is_barred_from_residence(mob/living/carbon/human/user)
	if(!ishuman(user))
		return TRUE
	if(HAS_TRAIT(user, TRAIT_OUTLAW) || HAS_TRAIT(user, TRAIT_HERESIARCH) || HAS_TRAIT(user, TRAIT_EXCOMMUNICATED))
		return TRUE
	if((user.name in GLOB.outlawed_players) || (user.real_name in GLOB.outlawed_players))
		return TRUE
	if((user.name in GLOB.excommunicated_players) || (user.real_name in GLOB.excommunicated_players))
		return TRUE
	return FALSE

/obj/item/book/granter/residentcardvirtue/proc/can_claim_residence(mob/living/carbon/human/user)
	return can_grant_residence && ishuman(user) && owner_character_key && get_detection_character_key(user) == owner_character_key && !HAS_TRAIT(user, TRAIT_RESIDENT) && !is_barred_from_residence(user) && !is_fake && has_any_seal()

/obj/item/book/granter/residentcardvirtue/proc/is_ruling_authority(mob/living/carbon/human/user)
	var/seal_key = get_seal_key_for_user(user)
	if(seal_key == "duke")
		return !!LAZYACCESS(seals, "duke")
	return seal_key == "hand"

/obj/item/book/granter/residentcardvirtue/proc/forge_undetectable_fake(mob/living/carbon/human/forger)
	if(!ishuman(forger))
		return FALSE
	is_fake = TRUE
	undetectable_fake = TRUE
	authority_validated = FALSE
	defect_note = null
	defect_notes = list()
	if(!is_bound)
		bind_to_holder(forger)
	icon_state = "contractsigned"
	stamp_all_seals(should_initially_include_duke_seal())
	return TRUE

/obj/item/book/granter/residentcardvirtue/proc/status_label_for(mob/living/carbon/human/target)
	if(HAS_TRAIT(target, TRAIT_NOBLE))
		return "Under the Grace of Astrata"
	return "Unknown"

/obj/item/book/granter/residentcardvirtue/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/book/granter/residentcardvirtue/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ResidentManuscript", name)
		ui.open()

/obj/item/book/granter/residentcardvirtue/ui_data(mob/user)
	var/list/data = list()
	var/detection_key
	var/can_edit_fake = FALSE
	var/can_become_resident = FALSE
	var/is_owner_viewing = FALSE
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		detection_key = get_detection_character_key(human_user)
		can_edit_fake = can_edit_fake_manuscript(human_user)
		can_become_resident = can_claim_residence(human_user)
		is_owner_viewing = is_owner_viewer(human_user)
	data["owner_name"] = owner_name || (can_edit_fake ? "" : "Unknown")
	data["owner_status"] = owner_status_label || (can_edit_fake ? "Unknown" : "—")
	data["expiry_date"] = expiry_date || "—"
	data["issued_place"] = issued_place || "—"
	data["description"] = description || ""
	data["is_owner"] = is_owner_viewing
	data["is_bound"] = is_bound
	data["can_edit_fake"] = can_edit_fake
	data["can_become_resident"] = can_become_resident
	data["seal_chancellor"] = seal_entry("chancellor", "Chancellor")
	data["seal_elder"] = seal_entry("elder", "Elder")
	data["seal_duke"] = seal_entry("duke", get_ruler_seal_title(), FALSE)
	data["seal_hand"] = seal_entry("hand", "Hand")

	data["can_detect"] = FALSE
	data["detection_done"] = FALSE
	data["detection_result"] = ""
	data["detection_note"] = ""
	data["defect_note"] = ""
	data["defect_notes"] = list()

	if(is_bound && detection_key && !is_owner_viewing)
		if(LAZYACCESS(detection_attempts, detection_key))
			data["detection_done"] = TRUE
			data["detection_result"] = LAZYACCESS(detection_results, detection_key) || "unknown"
			data["detection_note"] = LAZYACCESS(detection_notes, detection_key) || ""
			if(data["detection_result"] == "fake")
				ensure_defect_notes()
				data["defect_note"] = format_defect_notes()
				data["defect_notes"] = defect_notes || list()
		else if(!authority_validated)
			data["can_detect"] = TRUE
	return data

/obj/item/book/granter/residentcardvirtue/proc/seal_entry(key, label, visible = TRUE)
	var/list/entry
	if(seals)
		entry = seals[key]
	if(entry)
		return list(
			"label" = label,
			"stamped" = TRUE,
			"stamper" = entry["stamper"] || "",
			"visible" = TRUE,
		)
	return list(
		"label" = label,
		"stamped" = FALSE,
		"stamper" = "",
		"visible" = visible,
	)

/obj/item/book/granter/residentcardvirtue/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	var/mob/living/user = usr
	switch(action)
		if("detect")
			handle_detection(user)
			return TRUE
		if("save_fake")
			save_fake_manuscript(user, params)
			return TRUE
		if("become_resident")
			claim_residence(user)
			return TRUE
		if("bind")
			return TRUE

/obj/item/book/granter/residentcardvirtue/proc/sanitize_manuscript_field(value, max_length, fallback)
	var/text_value = ""
	if(!isnull(value))
		text_value = "[value]"
	text_value = trim(html_encode(text_value), max_length)
	return length(text_value) ? text_value : fallback

/obj/item/book/granter/residentcardvirtue/proc/generate_defect_notes()
	var/list/available_defects = MANUSCRIPT_DEFECT_NOTES
	available_defects = available_defects.Copy()
	var/list/generated_defects = list()
	var/defect_count = rand(MANUSCRIPT_MIN_FOUND_DEFECT_COUNT, MANUSCRIPT_MAX_FOUND_DEFECT_COUNT)
	while(length(generated_defects) < defect_count && length(available_defects))
		var/selected_defect = pick(available_defects)
		generated_defects += selected_defect
		available_defects -= selected_defect
	return generated_defects

/obj/item/book/granter/residentcardvirtue/proc/ensure_defect_notes()
	if(length(defect_notes) >= MANUSCRIPT_MIN_FOUND_DEFECT_COUNT)
		return
	var/list/generated_defects = generate_defect_notes()
	if(length(defect_note) && !(defect_note in generated_defects))
		generated_defects.Insert(1, defect_note)
	while(length(generated_defects) > MANUSCRIPT_MAX_FOUND_DEFECT_COUNT)
		generated_defects.Cut(length(generated_defects), length(generated_defects) + 1)
	defect_notes = generated_defects
	defect_note = length(defect_notes) ? defect_notes[1] : null

/obj/item/book/granter/residentcardvirtue/proc/format_defect_notes()
	if(!length(defect_notes))
		ensure_defect_notes()
	return length(defect_notes) ? jointext(defect_notes, " ") : (defect_note || "")

/obj/item/book/granter/residentcardvirtue/proc/normalize_manuscript_status(value)
	var/text_value = ""
	if(!isnull(value))
		text_value = "[value]"
	switch(text_value)
		if("Under the Grace of Astrata")
			return "Under the Grace of Astrata"
	return "Unknown"

/obj/item/book/granter/residentcardvirtue/proc/save_fake_manuscript(mob/living/carbon/human/user, list/params)
	if(!can_edit_fake_manuscript(user))
		return FALSE
	if(!params)
		params = list()
	var/perfect_forgery = can_make_undetectable_forgery(user)
	owner_character_key = null
	owner_name = sanitize_manuscript_field(params["owner_name"], MAX_NAME_LEN, "Unknown")
	owner_status_label = normalize_manuscript_status(params["owner_status"])
	expiry_date = expiry_date || compute_expiry_date()
	issued_place = issued_place || get_map_display_name()
	description = description || MANUSCRIPT_DESCRIPTION
	is_bound = TRUE
	name = "Travel Certificate"
	icon_state = "contractsigned"
	stamp_all_seals(should_initially_include_duke_seal())
	authority_validated = FALSE
	if(perfect_forgery)
		undetectable_fake = TRUE
		defect_note = null
		defect_notes = list()
	else
		undetectable_fake = FALSE
	detection_attempts = list()
	detection_results = list()
	detection_notes = list()
	if(perfect_forgery)
		to_chat(user, span_notice("Through mastery of writing, you create a flawless fake letter. No one will be able to recognize the lies in her! Almost..."))
	else
		to_chat(user, span_notice("You are creating a fake letter, giving it the appearance of a real one."))
	playsound(user, 'sound/items/write.ogg', 40, TRUE, -2)
	return TRUE

/obj/item/book/granter/residentcardvirtue/proc/claim_residence(mob/living/carbon/human/user)
	if(!can_claim_residence(user))
		return FALSE
	ADD_TRAIT(user, TRAIT_RESIDENT, TRAIT_GENERIC)
	REMOVE_TRAIT(user, TRAIT_OUTLANDER, ADVENTURER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_OUTLANDER, JOB_TRAIT)
	REMOVE_TRAIT(user, TRAIT_OUTLANDER, TRAIT_GENERIC)
	to_chat(user, span_notice("The stamps on the charter are recognized as sufficient grounds: from now on you are considered a citizen of these lands."))
	return TRUE

/obj/item/book/granter/residentcardvirtue/proc/handle_detection(mob/living/carbon/human/user)
	if(!ishuman(user))
		return
	var/detection_key = get_detection_character_key(user)
	if(!detection_key)
		return
	if(owner_character_key && detection_key == owner_character_key)
		return
	if(LAZYACCESS(detection_attempts, detection_key))
		return
	var/base_int = user.get_true_stat(STATKEY_INT)
	if(is_ruling_authority(user))
		handle_authority_detection(user, detection_key, base_int)
		return
	if(authority_validated)
		return
	LAZYSET(detection_attempts, detection_key, TRUE)
	var/chance = 5
	var/base_per = user.get_true_stat(STATKEY_PER)
	if(base_int > 10)
		chance += 5
	if(base_per > 10 && base_per <= 12)
		chance += 5
	if(HAS_TRAIT(user, TRAIT_INTELLECTUAL))
		chance += 15
	var/reading = user.get_skill_level(/datum/skill/misc/reading)
	if(reading > 0)
		chance += 10 * reading
	var/result = "unknown"
	if(prob(chance))
		if(is_fake && !undetectable_fake)
			ensure_defect_notes()
			result = "fake"
		else
			result = "real"
	LAZYSET(detection_results, detection_key, result)
	if(result == "fake")
		to_chat(user, span_warning("You discover that the document is fake: [format_defect_notes()]"))
	if(result != "fake")
		LAZYSET(detection_notes, detection_key, pick(MANUSCRIPT_VALIDATION_NOTES))

/obj/item/book/granter/residentcardvirtue/proc/handle_authority_detection(mob/living/carbon/human/user, detection_key, base_int)
	if(authority_validated)
		return
	LAZYSET(detection_attempts, detection_key, TRUE)
	var/result = "real"
	if(is_fake)
		var/detected_fake = base_int > 10 || prob(25)
		if(detected_fake)
			ensure_defect_notes()
			result = "fake"
		else
			authority_validated = TRUE
	LAZYSET(detection_results, detection_key, result)
	if(result == "fake")
		to_chat(user, span_warning("You discover that the document is fake: [format_defect_notes()]"))
	if(result != "fake")
		LAZYSET(detection_notes, detection_key, pick(MANUSCRIPT_VALIDATION_NOTES))

/obj/item/book/granter/residentcardvirtue/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/natural/feather) && ishuman(user))
		if(handle_feather_use(user))
			return
	return ..()

/obj/item/book/granter/residentcardvirtue/proc/handle_feather_use(mob/living/carbon/human/user)
	if(!is_bound)
		if(can_make_undetectable_forgery(user))
			forge_undetectable_fake(user)
			to_chat(user, span_notice("Through mastery of writing, you create a flawless fake letter. No one will be able to recognize the lies in her! Almost..."))
		else
			bind_to_holder(user)
			to_chat(user, span_notice("You draw up a travel document, entering your name and image."))
		icon_state = "contractsigned"
		playsound(user, 'sound/items/write.ogg', 40, TRUE, -2)
		return TRUE
	var/seal_key = get_seal_key_for_user(user)
	if(!seal_key)
		to_chat(user, span_warning("You do not have the right to put a stamp on this certificate."))
		return TRUE
	if(seals[seal_key])
		to_chat(user, span_warning("Your seal has already been set."))
		return TRUE
	var/title = seal_title_for_key(seal_key)
	stamp_seal(seal_key, title)
	to_chat(user, span_notice("You put the stamp [title] on the certificate."))
	playsound(user, 'sound/items/write.ogg', 50, TRUE, -2)
	return TRUE

/obj/item/book/granter/residentcardvirtue/proc/stamp_seal(seal_key, stamper_name)
	if(!seals || !(seal_key in seals))
		return FALSE
	if(seals[seal_key])
		return FALSE
	seals[seal_key] = list("stamper" = stamper_name, "time" = world.time)
	return TRUE

/obj/item/book/granter/residentcardvirtue/fake
	name = "Travel Certificate"
	desc = MANUSCRIPT_ITEM_DESCRIPTION
	is_fake = TRUE
	auto_stamp_seals = FALSE

/obj/item/book/granter/residentcardvirtue/fake/Initialize()
	. = ..()
	if(prob(FAKE_DEFECT_CHANCE))
		ensure_defect_notes()

/obj/item/book/granter/residentcardvirtue/fake/attack_self(mob/living/user)
	ui_interact(user)

/obj/item/book/granter/residentcardvirtue/roundstart
	can_grant_residence = FALSE
	expiry_year_bonus_min = 5
	expiry_year_bonus_max = 10

/obj/item/book/granter/residentcardvirtue/base
	name = "Travel document form"
	desc = "Travel document blank form. Take a pen and write your name, then send it to authorized persons for sealing."
	icon_state = "contractunsigned"
	auto_stamp_seals = FALSE

/datum/supply_pack/rogue/drugs/fake_manuscript
	name = "Suspicious Scroll"
	cost = 100
	contains = list(/obj/item/book/granter/residentcardvirtue/fake)

/datum/supply_pack/rogue/luxury/manuscript_base
	name = "Travel document form"
	cost = 50
	contains = list(/obj/item/book/granter/residentcardvirtue/base)

#undef MANUSCRIPT_ITEM_DESCRIPTION
#undef MANUSCRIPT_DESCRIPTION
#undef MANUSCRIPT_DEFECT_NOTES
#undef MANUSCRIPT_MIN_FOUND_DEFECT_COUNT
#undef MANUSCRIPT_MAX_FOUND_DEFECT_COUNT
#undef MANUSCRIPT_VALIDATION_NOTES
#undef FAKE_DEFECT_CHANCE
#endif

/obj/item/book/granter/residentcardvirtue
	parent_type = /obj/item/book/granter/resident_manuscript

/obj/item/book/granter/residentcardvirtue/fake
	parent_type = /obj/item/book/granter/resident_manuscript/fake

/obj/item/book/granter/residentcardvirtue/roundstart
	parent_type = /obj/item/book/granter/resident_manuscript/roundstart

/obj/item/book/granter/residentcardvirtue/base
	parent_type = /obj/item/book/granter/resident_manuscript/blank
