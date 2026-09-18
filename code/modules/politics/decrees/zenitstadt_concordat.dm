/datum/decree/zenitstadt_concordat
	id = DECREE_ZENITSTADT_CONCORDAT
	name = "The Zenitstadt Concordat"
	category = DECREE_CATEGORY_ANCIENT
	mechanical_text = "Church clergy and declared Benefactors of the Faith pay no taxes."
	flavor_text = {"This Twilight Concordat, concluded under the auspices of the Ten Indivisible between the Crown of %REALM%, the Holy See of Grenzelhoft, and the Holy See of Valoria, decrees the following:

- The Valorian Church of the Indivisible Ten, illuminated by Astrata's light, holds the right and duty to preserve divine peace in this land. Its servants shall pray for the safety and prosperity of %REALM%, maintain the favor of the Ten through proper rites, collect tithes from their parishioners, and shelter the poor and oppressed. Clergy and Templars may travel freely through the realm without persecution.
- The Grenzelhoft Church of the Ten, sponsored and blessed by the Imperial Church of the Eleven, holds equal freedom to preach and pray to the Ten and the One in %REALM%. In return, it renounces all claims to the temples and shrines of the Valorian Church.
- The Crown of %REALM%, recognizing Astrata's will as the source of lawful authority, shall exempt the Church's clergy, property, and declared benefactors from taxes and levies. The Crown shall not interfere in the Church's internal affairs except through negotiation with the highest Valorian representative in the realm. In return, the Church shall not interfere in secular justice except in matters of Divine Order, heresy, and crimes against the Church.
	
For the peace of %REALM%, every party to this Concordat pledges to uphold its letter and spirit henceforth and forever.

Certified with the seal of the Crown, the seal of the Holy See of Grenzelhoft, and the seal of the Holy See of Valoria, by the grace of the Ten Indivisible."}
	revoke_text = "The %RULER% has rescinded the Zenitstadt Concordat. The Church's wealth shall serve the greater good of %REALM%—let the Ten judge who betrayed whom."
	restore_text = "The %RULER% has affirmed the Zenitstadt Concordat. The hand of the Crown shall meddle no more in the disposition of the Church's worldly wealth."

/datum/decree/zenitstadt_concordat/roll_initial_year()
	return CALENDAR_EPOCH_YEAR - rand(50, 120)

/datum/decree/zenitstadt_concordat/apply_exemption(mob/living/payer, tax_category)
	if(!active)
		return FALSE
	if(payer.job in GLOB.church_positions)
		return TRUE
	if(HAS_TRAIT(payer, TRAIT_AGENT_CHURCH))
		return TRUE
	return FALSE
