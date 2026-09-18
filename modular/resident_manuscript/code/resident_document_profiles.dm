/datum/resident_document_role_rule
	var/document_type
	var/list/job_types
	var/list/migrant_role_types
	var/list/advclass_types
	var/priority = 0

/datum/resident_document_role_rule/proc/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	if(LAZYLEN(migrant_role_types) && user.migrant_type)
		for(var/migrant_role_type in migrant_role_types)
			if(user.migrant_type == migrant_role_type || ispath(user.migrant_type, migrant_role_type))
				return TRUE
	if(LAZYLEN(job_types))
		var/datum/job/job = SSjob.GetJob(user.job || user.mind.assigned_role)
		for(var/job_type in job_types)
			if(istype(job, job_type))
				return TRUE
	if(LAZYLEN(advclass_types) && user.advjob)
		var/datum/advclass/advclass = SSrole_class_handler.get_advclass_by_name(user.advjob)
		for(var/advclass_type in advclass_types)
			if(istype(advclass, advclass_type))
				return TRUE
	return FALSE

/datum/resident_document_role_rule/merchant
	document_type = /obj/item/book/granter/resident_manuscript/merchant
	job_types = list(
		/datum/job/roguetown/merchant,
		/datum/job/roguetown/shophand,
	)
	priority = 100

/datum/resident_document_role_rule/grenzelhoft_mission
	document_type = /obj/item/book/granter/resident_manuscript/grenzelhoft_mission
	migrant_role_types = list(/datum/migrant_role/grenzel)
	priority = 120

/datum/resident_document_role_rule/heartfelt_noble
	document_type = /obj/item/book/granter/resident_manuscript/heartfelt_noble
	migrant_role_types = list(
		/datum/migrant_role/heartfelt/lord,
		/datum/migrant_role/heartfelt/hand,
		/datum/migrant_role/heartfelt/knight,
	)
	priority = 120

/datum/resident_document_role_rule/heartfelt_identity
	document_type = /obj/item/book/granter/resident_manuscript/heartfelt_identity
	migrant_role_types = list(/datum/migrant_role/heartfelt)
	priority = 115

/datum/resident_document_role_rule/azurian_imperial_patronage
	document_type = /obj/item/book/granter/resident_manuscript/imperial
	job_types = list(
		/datum/job/roguetown/lord,
		/datum/job/roguetown/priest,
		/datum/job/roguetown/inquisitor,
	)
	priority = 125

/datum/resident_document_role_rule/azurian_imperial_patronage/matches(mob/living/carbon/human/user)
	return resident_manuscript_uses_azuria_titles() && ..()

/datum/resident_document_role_rule/rockhill_crown
	document_type = /obj/item/book/granter/resident_manuscript/enigma_crown
	job_types = list(/datum/job/roguetown/lord)
	priority = 125

/datum/resident_document_role_rule/rockhill_crown/matches(mob/living/carbon/human/user)
	return resident_manuscript_uses_rockhill_titles() && ..()

/datum/resident_document_role_rule/rockhill_bishop
	document_type = /obj/item/book/granter/resident_manuscript/valorian_church
	job_types = list(/datum/job/roguetown/priest)
	priority = 125

/datum/resident_document_role_rule/rockhill_bishop/matches(mob/living/carbon/human/user)
	return resident_manuscript_uses_rockhill_titles() && ..()

/datum/resident_document_role_rule/innkeeper
	document_type = /obj/item/book/granter/resident_manuscript/commoner
	job_types = list(/datum/job/roguetown/innkeeper)
	priority = 100

/datum/resident_document_role_rule/bathmaster
	document_type = /obj/item/book/granter/resident_manuscript/commoner
	job_types = list(/datum/job/roguetown/bathmaster)
	priority = 100

/datum/resident_document_role_rule/mages
	document_type = /obj/item/book/granter/resident_manuscript/mages
	job_types = list(
		/datum/job/roguetown/magician,
		/datum/job/roguetown/wapprentice,
	)
	priority = 100

/datum/resident_document_role_rule/mercenary
	document_type = /obj/item/book/granter/resident_manuscript/mercenary
	job_types = list(/datum/job/roguetown/mercenary)
	priority = 100

/datum/resident_document_role_rule/retinue
	document_type = /obj/item/book/granter/resident_manuscript/retinue
	priority = 90

/datum/resident_document_role_rule/retinue/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	var/job_title = user.job || user.mind.assigned_role
	return job_title && (job_title in GLOB.retinue_positions)

/datum/resident_document_role_rule/garrison
	document_type = /obj/item/book/granter/resident_manuscript/guards
	priority = 50

/datum/resident_document_role_rule/garrison/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	var/job_title = user.job || user.mind.assigned_role
	return job_title && ((job_title in GLOB.garrison_positions) || (job_title in GLOB.citywatch_positions) || (job_title in GLOB.vanguard_positions))

/datum/resident_document_role_rule/church
	document_type = /obj/item/book/granter/resident_manuscript/church
	priority = 50

/datum/resident_document_role_rule/church/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	var/job_title = user.job || user.mind.assigned_role
	return job_title && (job_title in GLOB.church_positions)

/datum/resident_document_role_rule/inquisition
	document_type = /obj/item/book/granter/resident_manuscript/otava
	priority = 50

/datum/resident_document_role_rule/inquisition/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	var/job_title = user.job || user.mind.assigned_role
	return job_title && (job_title in GLOB.inquisition_positions)

/datum/resident_document_role_rule/craftsmen
	document_type = /obj/item/book/granter/resident_manuscript/craftsmen
	priority = 50

/datum/resident_document_role_rule/craftsmen/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	var/job_title = user.job || user.mind.assigned_role
	return job_title && (job_title in GLOB.burgher_positions)

/datum/resident_document_role_rule/noble_fallback
	document_type = /obj/item/book/granter/resident_manuscript/roundstart
	priority = -10

/datum/resident_document_role_rule/noble_fallback/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	var/job_title = user.job || user.mind.assigned_role
	return job_title && ((job_title in GLOB.noble_positions) || (job_title in GLOB.courtier_positions))

/datum/resident_document_role_rule/commoner_fallback
	document_type = /obj/item/book/granter/resident_manuscript/commoner
	priority = -100

/datum/resident_document_role_rule/commoner_fallback/matches(mob/living/carbon/human/user)
	if(!ishuman(user) || !user.mind)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_RESIDENT))
		return TRUE
	var/job_title = user.job || user.mind.assigned_role
	return job_title && (job_title in GLOB.peasant_positions)

/proc/get_resident_document_role_rules()
	var/static/list/cached
	if(!cached)
		cached = list()
		for(var/rule_type in subtypesof(/datum/resident_document_role_rule))
			cached += new rule_type
		sortTim(cached, GLOBAL_PROC_REF(cmp_resident_document_role_rule_priority))
	return cached

/proc/cmp_resident_document_role_rule_priority(datum/resident_document_role_rule/a, datum/resident_document_role_rule/b)
	return b.priority - a.priority

/proc/get_default_manuscript_type_for_job(mob/living/carbon/human/recipient)
	if(!recipient || !recipient.mind)
		return null
	for(var/datum/resident_document_role_rule/rule as anything in get_resident_document_role_rules())
		if(rule.matches(recipient))
			return rule.document_type
	return null

/datum/resident_manuscript_seal_rule
	var/key
	var/title
	var/stamper
	var/list/job_types
	var/list/advclass_types
	var/priority = 0
	var/list/allowed_statuses

/datum/resident_manuscript_seal_rule/proc/can_stamp(mob/living/carbon/human/user)
	if(!ishuman(user))
		return FALSE
	var/datum/job/job = SSjob.GetJob(user.mind?.assigned_role)
	for(var/job_type in job_types)
		if(istype(job, job_type))
			return TRUE
	var/datum/advclass/advclass
	if(user.advjob)
		advclass = SSrole_class_handler.get_advclass_by_name(user.advjob)
	for(var/advclass_type in advclass_types)
		if(istype(advclass, advclass_type))
			return TRUE
	return FALSE

/datum/resident_manuscript_seal_rule/proc/can_apply_to_status(status_key)
	if(!LAZYLEN(allowed_statuses))
		return TRUE
	return status_key in allowed_statuses

/datum/resident_manuscript_seal_rule/proc/get_title()
	return title || key

/datum/resident_manuscript_seal_rule/proc/get_stamper()
	return stamper || get_title()

/datum/resident_manuscript_seal_rule/elder
	key = "elder"
	title = "Elder"
	stamper = "Elder"
	advclass_types = list(/datum/advclass/elder)
	priority = RESIDENT_SEAL_PRIORITY_ELDER

/datum/resident_manuscript_seal_rule/elder/can_stamp(mob/living/carbon/human/user)
	if(..())
		return TRUE
	if(!resident_manuscript_uses_rockhill_titles() || !ishuman(user))
		return FALSE
	var/datum/job/job = SSjob.GetJob(user.job || user.mind?.assigned_role)
	if(istype(job, /datum/job/roguetown/mayor))
		return TRUE
	var/datum/advclass/advclass
	if(user.advjob)
		advclass = SSrole_class_handler.get_advclass_by_name(user.advjob)
	if(istype(advclass, /datum/advclass/mayor))
		return TRUE
	return FALSE

/datum/resident_manuscript_seal_rule/elder/get_title()
	if(resident_manuscript_uses_rockhill_titles())
		return "Mayor"
	return ..()

/datum/resident_manuscript_seal_rule/elder/get_stamper()
	if(resident_manuscript_uses_rockhill_titles())
		return "Mayor"
	return ..()

/datum/resident_manuscript_seal_rule/chancellor
	key = "chancellor"
	title = "Chancellor"
	stamper = "Chancellor"
	job_types = list(/datum/job/roguetown/councillor)
	priority = RESIDENT_SEAL_PRIORITY_CHANCELLOR

/datum/resident_manuscript_seal_rule/hand
	key = "hand"
	title = "Hand"
	stamper = "Hand"
	job_types = list(/datum/job/roguetown/hand)
	priority = RESIDENT_SEAL_PRIORITY_HAND

/datum/resident_manuscript_seal_rule/ruler
	key = "ruler"
	title = "Duke"
	stamper = "Duke"
	job_types = list(/datum/job/roguetown/lord)
	priority = RESIDENT_SEAL_PRIORITY_RULER
	allowed_statuses = list(RESIDENT_MANUSCRIPT_STATUS_NOBLE)

/datum/resident_manuscript_seal_rule/ruler/get_title()
	if(resident_manuscript_uses_rockhill_titles())
		return "King"
	return ..()

/datum/resident_manuscript_seal_rule/ruler/get_stamper()
	if(resident_manuscript_uses_rockhill_titles())
		return "King"
	return ..()

/datum/resident_manuscript_seal_rule/sergeant
	key = "sergeant"
	title = "Sergeant"
	stamper = "Sergeant of the Guard"
	job_types = list(/datum/job/roguetown/sergeant)
	priority = RESIDENT_SEAL_PRIORITY_FACTION_LOW

/datum/resident_manuscript_seal_rule/marshal
	key = "marshal"
	title = "Marshal"
	stamper = "Marshal"
	job_types = list(/datum/job/roguetown/marshal)
	priority = RESIDENT_SEAL_PRIORITY_FACTION_MID

/datum/resident_manuscript_seal_rule/bishop
	key = "bishop"
	title = "Bishop"
	stamper = "Bishop"
	job_types = list(/datum/job/roguetown/priest)
	priority = RESIDENT_SEAL_PRIORITY_FACTION_MID

/datum/resident_manuscript_seal_rule/guild_leader
	key = "guild_leader"
	title = "Guild Leader"
	stamper = "Guild Leader"
	advclass_types = list(/datum/advclass/guildmaster)
	priority = RESIDENT_SEAL_PRIORITY_FACTION_MID

/datum/resident_manuscript_seal_rule/inquisitor
	key = "inquisitor"
	title = "Inquisitor"
	stamper = "Inquisitor"
	job_types = list(/datum/job/roguetown/inquisitor)
	priority = RESIDENT_SEAL_PRIORITY_FACTION_MID

/datum/resident_manuscript_seal_rule/court_magician
	key = "court_magician"
	title = "Court Mage"
	stamper = "Court Mage"
	job_types = list(/datum/job/roguetown/magician)
	priority = RESIDENT_SEAL_PRIORITY_FACTION_MID

/datum/resident_manuscript_seal_rule/merchant_master
	key = "merchant_master"
	title = "Senior Trader"
	stamper = "Senior Trader"
	job_types = list(/datum/job/roguetown/merchant)
	priority = RESIDENT_SEAL_PRIORITY_FACTION_MID

/datum/resident_manuscript_seal_rule/kaiser
	key = "kaiser"
	title = "Imperial Chancellery"
	stamper = "Grenzelhoft Chancellery"
	priority = RESIDENT_SEAL_PRIORITY_KAISER

/datum/resident_manuscript_seal_rule/valorian
	key = "valorian"
	title = "Valorian Trade Guild"
	stamper = "Astinia di Sala Trade Guild"
	priority = RESIDENT_SEAL_PRIORITY_FACTION_HIGH

/datum/resident_manuscript_seal_rule/valorian_holy_see
	key = "valorian_holy_see"
	title = "Valorian Holy See"
	stamper = "Holy See of Valoria"
	priority = RESIDENT_SEAL_PRIORITY_FACTION_HIGH

/datum/resident_manuscript_seal_rule/royal_protection
	key = "royal_protection"
	title = "Royal Patronage"
	stamper = "King"
	job_types = list(/datum/job/roguetown/lord)
	priority = RESIDENT_SEAL_PRIORITY_RULER

/datum/resident_manuscript_seal_rule/heartfelt_chancery
	key = "heartfelt_chancery"
	title = "Heartfelt Chancery"
	stamper = "Heartfelt Chancery"
	priority = RESIDENT_SEAL_PRIORITY_RULER

/proc/get_resident_manuscript_seal_rules()
	var/static/list/seal_rules
	if(!seal_rules)
		seal_rules = list()
		for(var/rule_type in subtypesof(/datum/resident_manuscript_seal_rule))
			var/datum/resident_manuscript_seal_rule/rule = rule_type
			var/key = initial(rule.key)
			if(!key)
				continue
			seal_rules[key] = rule_type
	return seal_rules

/datum/resident_document_profile
	var/id
	var/display_name
	var/subtitle
	var/description
	var/list/allowed_seals
	var/list/default_seal_keys
	var/list/default_commoner_seal_keys
	var/list/default_noble_seal_keys
	var/requires_seal_for_claim = TRUE
	var/grants_residence_claim = FALSE

/datum/resident_document_profile/proc/has_seal(seal_key)
	return seal_key && (seal_key in allowed_seals)

/datum/resident_document_profile/proc/get_default_seal_keys(status_key)
	if(status_key == RESIDENT_MANUSCRIPT_STATUS_NOBLE && default_noble_seal_keys)
		return default_noble_seal_keys
	if(status_key == RESIDENT_MANUSCRIPT_STATUS_COMMONER && default_commoner_seal_keys)
		return default_commoner_seal_keys
	return default_seal_keys || allowed_seals

/datum/resident_document_profile/proc/get_display_name()
	return display_name

/datum/resident_document_profile/proc/get_subtitle()
	return subtitle

/datum/resident_document_profile/proc/get_description()
	return description

/datum/resident_document_profile/resident
	id = "resident"
	display_name = "Resident Certificate"
	subtitle = "At Hand of the Crown"
	description = "Be it known: the bearer is included in register of inhabitants of these lands. He is allowed to reside, apply to city law and pass through the city gates until the expiration of the charter."
	allowed_seals = list("chancellor", "elder", "ruler", "hand")
	default_commoner_seal_keys = list("chancellor")
	default_noble_seal_keys = list("ruler")
	grants_residence_claim = TRUE

/datum/resident_document_profile/resident/get_description()
	if(resident_manuscript_uses_rockhill_titles())
		return "Let it be known that the bearer is included in the register of residents of the Enigma Kingdom on Rockhill. He is allowed to reside, apply to city law and pass through the city gates until the expiration of the charter."
	return ..()

/datum/resident_document_profile/imperial
	id = "imperial"
	display_name = "Imperial Letter of Patronage"
	subtitle = "Under Imperial Countersignature"
	description = "Let it be known that the bearer holds an office, dignity or service recognized by the Imperial Office of Grenzelhoft and the authority of the Duchy of Azuria. The certificate certifies his authority and is not transferred to other persons."
	allowed_seals = list("kaiser", "ruler", "bishop", "inquisitor", "hand")
	default_seal_keys = list("kaiser")
	grants_residence_claim = TRUE

/datum/resident_document_profile/enigma_crown
	id = "enigma_crown"
	display_name = "Crown Letter of Enigma"
	subtitle = "Under the Hand of the King of Rockhill"
	description = "Be it known: the bearer is recognized by the crown authority of the Kingdom of Enigma on Rockhill. His orders and dignity are recognized within the limits of royal law and the term of this charter."
	allowed_seals = list("ruler", "hand")
	default_seal_keys = list("ruler")
	grants_residence_claim = TRUE

/datum/resident_document_profile/valorian_church
	id = "valorian_church"
	display_name = "Valorian Charter of the Holy See"
	subtitle = "Under the Church of the Indivisible Ten"
	description = "Let it be known: the bearer is recognized by the Holy See of Valoria and has the right to perform church services on Rockhill. His dignity, seal and ecclesiastical orders are subject to recognition within the limits of this charter."
	allowed_seals = list("valorian_holy_see", "bishop", "ruler")
	default_seal_keys = list("valorian_holy_see")
	grants_residence_claim = TRUE

/datum/resident_document_profile/grenzelhoft_mission
	id = "grenzelhoft_mission"
	display_name = "Imperial Travel Certificate"
	subtitle = "Seal of the Grenzelhoft Chancellery"
	description = "Let it be known that the bearer is included in the detachment sent by the Imperial Grenzelhoft Chancellery. He is allowed to go on the assigned mission, accompany the Lord Envoy and present the real paper to the authorities."
	allowed_seals = list("kaiser", "hand", "chancellor")
	default_seal_keys = list("kaiser")

/datum/resident_document_profile/heartfelt
	allowed_seals = list("heartfelt_chancery", "valorian_holy_see", "chancellor")
	default_seal_keys = list("heartfelt_chancery")

/datum/resident_document_profile/heartfelt/identity
	id = "heartfelt_identity"
	display_name = "Hartfelt ID Card"
	subtitle = "Under the seal of the Hartfelt Chancery"
	description = "Let it be known that the bearer is certified as a resident of Hartfelt. His name, identity and right to produce this paper are recognized by Hartfelt's office."

/datum/resident_document_profile/heartfelt/noble
	id = "heartfelt_noble"
	display_name = "Certificate of Nobility"
	subtitle = "Under the seal of the Hartfelt Chancery"
	description = "Let it be known that the bearer is certified as a noble resident of Hartfelt. His name, dignity and right to follow in the Hartfelt retinue are recognized by this paper."

/datum/resident_document_profile/guards
	id = "guards"
	display_name = "Garrison Letter"
	subtitle = "From the garrison and the Crown"
	description = "Let it be known: the bearer has been accepted into the service of the city garrison. He is allowed to carry weapons while on duty, demand assistance within the limits of the order and answer to his superiors."
	allowed_seals = list("sergeant", "marshal", "elder")

/datum/resident_document_profile/guards/get_subtitle()
	if(resident_manuscript_uses_rockhill_titles())
		return "From the Royal Guard and Rockhill"
	return ..()

/datum/resident_document_profile/guards/get_description()
	if(resident_manuscript_uses_rockhill_titles())
		return "Be it known that the bearer has been accepted into the service of the Royal Guard of Rockhill. He is allowed to carry weapons while on duty, demand assistance within the limits of the order and answer to his superiors."
	return ..()

/datum/resident_document_profile/church
	id = "church"
	display_name = "Church Letter of Faith"
	subtitle = "Under the Tenfold Light"
	description = "Let it be known: the bearer is a member of the church and is admitted to temple services within the limits of his rank or position. His ecclesiastical position is recognized until the charter is revoked or the term expires."
	allowed_seals = list("bishop")

/datum/resident_document_profile/church/get_subtitle()
	if(resident_manuscript_uses_rockhill_titles())
		return "Under the Valorian Holy See"
	return ..()

/datum/resident_document_profile/church/get_description()
	if(resident_manuscript_uses_rockhill_titles())
		return "Be it known: the bearer is affiliated with the Church of the Indivisible Ten on Rockhill and is admitted to temple service within the limits of his rank or position. His ecclesiastical position is recognized until the charter is revoked or the term expires."
	return ..()

/datum/resident_document_profile/craftsmen
	id = "craftsmen"
	display_name = "Charter of the Craft Guild"
	subtitle = "With an honest hand and bronze"
	description = "Let it be known: the bearer is recognized as a craftsman or employee of the craft guild. He is allowed to work at his craft, enter into orders and enjoy the protection of the guild order."
	allowed_seals = list("guild_leader", "chancellor", "elder")

/datum/resident_document_profile/commoner
	id = "commoner"
	display_name = "Citizen's Certificate"
	subtitle = "By the sign of the city elder"
	description = "Let it be known: the bearer is entered into the city register as a commoner. He is allowed to be among the legitimate people of the city without noble rights and special privileges."
	allowed_seals = list("elder", "chancellor", "hand")
	default_commoner_seal_keys = list("elder", "chancellor")
	default_noble_seal_keys = list("hand")
	requires_seal_for_claim = FALSE

/datum/resident_document_profile/commoner/get_subtitle()
	if(resident_manuscript_uses_rockhill_titles())
		return "By the sign of the city mayor"
	return ..()

/datum/resident_document_profile/commoner/get_description()
	if(resident_manuscript_uses_rockhill_titles())
		return "Be it known: the bearer is entered into the city register of Rockhill as a commoner. He is allowed to be among the legitimate people of the Enigma Kingdom without noble rights and special privileges."
	return ..()

/datum/resident_document_profile/merchant
	id = "merchant"
	display_name = "Valorian Trade Authorization"
	subtitle = "Seal of the Trade Guild of Astinia di Sala"
	description = "Let it be known that the bearer is acting under the authority of the Valorian Trade Guild. He is allowed to conduct trade, accept goods, enter into transactions and keep trade books under the guild seal."
	allowed_seals = list("valorian", "merchant_master", "chancellor")
	default_seal_keys = list("valorian")

/datum/resident_document_profile/merchant/get_description()
	if(resident_manuscript_uses_rockhill_titles())
		return "Let it be known that the bearer is acting on Rockhill under the authority of the Valorian Merchant Guild. He is allowed to conduct trade, accept goods, enter into transactions and keep trade books under the guild seal."
	return ..()

/datum/resident_document_profile/mages
	id = "mages"
	display_name = "Mages Guild Patent"
	subtitle = "By the Light of the Crown, Star and Sigil"
	description = "Let it be known that the bearer is recognized as a permitted practitioner of the magical craft. He is allowed to carry out approved work, keep the necessary tools, and answer to the guild or court."
	allowed_seals = list("court_magician")

/datum/resident_document_profile/mercenary
	id = "mercenary"
	display_name = "Hire contract"
	subtitle = "Coin, steel and word"
	description = "Let it be known: the bearer has been accepted into hired service under the contract. He is allowed to carry weapons, fulfill a paid contract and be responsible for his actions before the employer and the law."
	allowed_seals = list("elder", "chancellor", "hand")
	default_commoner_seal_keys = list("elder", "chancellor")
	default_noble_seal_keys = list("hand")

/datum/resident_document_profile/otava
	id = "otava"
	display_name = "Inquisitorial Edict"
	subtitle = "By truth, inquiry and purifying flame"
	description = "Let it be known: the bearer is a member of the Inquisition of Otava. He is allowed to conduct inquiries, make demands in matters of faith and act within the limits of recognized authority."
	allowed_seals = list("inquisitor", "royal_protection")

/datum/resident_document_profile/otava/get_display_name()
	if(resident_manuscript_uses_rockhill_titles())
		return "Letter of Royal Protection"
	return ..()

/datum/resident_document_profile/otava/get_subtitle()
	if(resident_manuscript_uses_rockhill_titles())
		return "Otavan Mission under the King's Hand"
	return ..()

/datum/resident_document_profile/otava/get_description()
	if(resident_manuscript_uses_rockhill_titles())
		return "Let it be known that the bearer is attached to the Otavan Mission on Rockhill and is under the personal protection of the King. It is allowed to prevent it only on legal grounds or by direct order of the crown."
	return ..()

/datum/resident_document_profile/otava/get_default_seal_keys(status_key)
	if(resident_manuscript_uses_rockhill_titles())
		return list("royal_protection")
	return list("inquisitor")

/datum/resident_document_profile/retinue
	id = "retinue"
	display_name = "Certificate of Palace Service"
	subtitle = "Under the ducal hand and oath"
	description = "Let it be known: the bearer is at the court of the Duchy of Azuria and performs personal service to the duke. His place, duties and right to be at court are confirmed by this charter."
	allowed_seals = list("hand", "ruler", "marshal")
	default_commoner_seal_keys = list("hand")
	default_noble_seal_keys = list("hand")
	grants_residence_claim = TRUE

/datum/resident_document_profile/retinue/get_subtitle()
	if(resident_manuscript_uses_rockhill_titles())
		return "Under the royal hand and oath"
	return ..()

/datum/resident_document_profile/retinue/get_description()
	if(resident_manuscript_uses_rockhill_titles())
		return "Be it known: the bearer is at the court of the Enigma Kingdom on Rockhill and is in personal service to the King. His place, duties and right to be at court are confirmed by this charter."
	return ..()

/proc/get_resident_document_profiles()
	var/static/list/profiles
	if(!profiles)
		profiles = list()
		for(var/profile_type in subtypesof(/datum/resident_document_profile))
			var/datum/resident_document_profile/profile = profile_type
			var/profile_id = initial(profile.id)
			if(!profile_id)
				continue
			profiles[profile_id] = profile_type
	return profiles

/proc/get_resident_document_profile(profile_id)
	var/static/list/cache
	if(!cache)
		cache = list()
	if(cache[profile_id])
		return cache[profile_id]
	var/list/profiles = get_resident_document_profiles()
	var/profile_type = profiles[profile_id] || profiles["resident"]
	if(!profile_type)
		return null
	var/datum/resident_document_profile/profile = new profile_type
	cache[profile_id] = profile
	return profile
