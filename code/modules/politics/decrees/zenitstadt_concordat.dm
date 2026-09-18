/datum/decree/zenitstadt_concordat
	id = DECREE_ZENITSTADT_CONCORDAT
	name = "Twilight Concordat"
	category = DECREE_CATEGORY_ANCIENT
	mechanical_text = "Clergy and benefactors of the Church are exempt from taxes."
	flavor_text = {"This Twilight Concordat, concluded under the auspices of the Ten Indivisibles between the Crown of Azuria, the Holy See of Grenzelhoft and the Holy See of Valoria in memory of the great victory over the forces of darkness that dominated the Asurian Valley, decree:

- The Valorian Church of the Indivisible Ten, illuminated by the light of Astrata, is endowed with the right and duty to preserve the peace of the gods on this land. In fulfillment of this noble purpose, the servants of the Church will pray for the safety and prosperity of the Duchy day and night, maintain the favor of the Ten through proper sacraments and ceremonies, collect tithes from their parishioners, and provide shelter to the poor and oppressed. The servants of the Church, including the crusaders of the Order of the Templars, called to protect the sanctity of the temples and shrines of the Ten, may freely and unobstructedly move through the lands of the Azurian Valley, and shall not be subjected to any persecution or oppression.
- The Church of the Ten Grenzelhofts, with the sponsorship and blessing of the Imperial Church of the Eleven, is granted equal rights to preach and offer prayers to the Ten and the One on the lands of Azuria, without being subjected to any persecution or oppression regarding its clergy or its followers. In turn, the Church of the Ten Grenzelhofts renounces any claims to the temples and shrines of the Valorian Church of the Indivisible Ten on the lands of the Azurian Valley.
- The Crown of the Grand Duchy of Azurium, recognizing the will of Astrata as the source of lawful authority over this land, undertakes to exempt the clergy, property, and benefactors of the Church from taxes and levies, and renounces the right to interfere in the internal affairs of the Church, except through negotiations with the highest representative of the Valorian Holy See in this land. In turn, the Church renounces the right to interfere in matters of secular justice and law, as long as they do not pertain to issues of maintaining Divine Order, heresy, and crimes against the Church.
	
Striving to maintain peace on the lands of Azuria, all parties who have assured this Concordat undertake to seek to uphold the letter and spirit of this agreement, henceforth and forever.

Certified with the seal of the Crown, the seal of the Holy See of Grenzelhoft, and the seal of the Holy See of Valoria, by the grace of the Ten Indivisible."}
	revoke_text = "Ruler of these lands annulled the Twilight Concordat. The wealth of the Church must serve the good of the Duchy - and may the Ten judge the justice of this decision."
	restore_text = "The ruler of these lands has restored the Twilight Concordat. The Crown will no longer interfere with the disposition of the Church's temporal wealth."

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
