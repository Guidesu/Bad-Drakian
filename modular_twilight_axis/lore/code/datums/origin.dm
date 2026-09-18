/datum/virtue/origin
	var/map_group_order = 4
	var/map_state_order = 1
	var/map_origin_order = 1
	var/map_visible = FALSE
	var/map_x = 50
	var/map_y = 50
	var/map_state_id
	var/map_state_name
	var/map_origin_name
	var/list_group_id
	var/list_group_name
	var/list_group_order = 0
	var/list_item_order = 0
	var/list_subgroup_name

/datum/virtue/origin/unknown
	map_group_order = 4
	map_state_order = 100
	map_origin_order = 1
	map_visible = FALSE
	map_x = 50.0
	map_y = 50.0
	map_state_id = "unknown"
	map_state_name = "From nowhere"
	map_origin_name = "From nowhere"
	list_group_order = 100
	list_item_order = 1
	name = "Nowhere"
	origin_name = "Elsewhere"
	desc = "I come from one of Psaidonia's countless isolated villages and forgotten settlements. No great homeland claims me, and I speak no regional language.<br>"
	origin_desc = "Not everyone can name a great kingdom as their homeland. Countless villages, estates, and vanished settlements survive only in the memories of those who left them behind. Peasants, refugees, orphans, and wanderers often carry such legacies without a nation to claim them."

/datum/virtue/origin/azuria
	map_group_order = 1
	map_state_order = 1
	map_origin_order = 1
	map_visible = TRUE
	map_x = 18.4
	map_y = 38.8
	map_state_id = "azuria"
	map_state_name = "The Independent Realm of Azuria"
	map_origin_name = "The Independent Realm of Azuria"
	name = "Azurian"
	origin_name = "Azuria"
	desc = "I come from Azuria, a small, independent mountain realm on Grenzelhoft's northern frontier. The high ranges enclosing its southern and western borders make overland travel difficult and have shielded the valley from many wars.<br>"
	restricted = FALSE
	added_languages = list(/datum/language/oldazurian)
	origin_desc = "<br><br><b>Azuria</b> is a small, independent mountain realm on Grenzelhoft's northern frontier. High ridges close the valley to the south and west, while the Azure Basin opens onto the Black Ocean to the east. The difficult terrain has spared Azuria from many foreign invasions and made it a refuge for adventurers, exiles, and displaced people from across Grimoria.<br><br>A sovereign count, earl, jarl, or equivalent ruler governs the valley from its independent capital and owes allegiance to no outside crown. The ruling dynasty claims kinship with Grenzelhoft's imperial house, but that ancestry grants the Empire no jurisdiction here.<br><br>The Church of the Ten is Azuria's dominant faith. Its senior priest blesses each lawful succession, while an Otavan magister oversees the local Inquisition under an old compact with the Imperial Church of the Eleven. Political pressure and their common enemies hold this uneasy arrangement together; when the churches clash, the sovereign ruler is expected to mediate.<br><br>Azuria's early history remains disputed. Imperial chroniclers say Grenzelhoft conquered the valley and later granted it to the present dynasty. Other traditions describe the dynasty overthrowing ancient vampire clans, while elven accounts remember a homeland taken by a Grenzelhoft-backed army. Whatever the truth, modern Azuria is neutral, sovereign, and crowded with refugees from the Twilight War. Whether those many peoples can forge a lasting realm remains an open question.<br><br>"

/datum/virtue/origin/enigma
	map_group_order = 3
	map_state_order = 3
	map_origin_order = 1
	map_visible = TRUE
	map_x = 64.2
	map_y = 75.0
	map_state_id = "enigma"
	map_state_name = "Kingdom of Enigma"
	map_origin_name = "Kingdom of Enigma"
	name = "Enigmian"
	origin_name = "Enigma"
	desc = "I come from the Enigma Islands, once a powerful and diverse kingdom. The ancient pact that protected my homeland has broken, and Rockhill is now among the last islands still resisting the vampire threat.<br>"
	restricted = FALSE
	origin_desc = "<br><br><b>Enigma</b> is an island realm in the Sea of Travelers. Convicts and enslaved laborers laid its foundations, and generations of harsh discipline shaped its culture. Its old maxim—'Rock and Stone, Discipline and Death'—once expressed the certainty of a powerful kingdom. It sounds more desperate now.<br><br>Ghoul incursions have severed roads and sea lanes across the largest islands, leaving cities, castles, and villages to survive in isolation. Great fortresses remain difficult to storm, but the countryside between them has been devastated.<br><br>Rockhill retains a measure of ordinary life because a broad strait separates it from the worst of the invasion. From this refuge, an independent sovereign and the surviving court plan the recovery of the lost islands with the aid of the Church of the Ten and the Inquisition.<br><br>"

/datum/virtue/origin/grenzelhoft
	map_group_order = 1
	map_state_order = 4
	map_origin_order = 1
	map_visible = TRUE
	map_x = 18.3
	map_y = 47.4
	map_state_id = "grenzelhoft"
	map_state_name = "The Empire of Grenzelhoft"
	map_origin_name = "The Empire of Grenzelhoft"
	name = "Grenzelhoftian"
	origin_name = "Grenzelhoft"
	added_languages = list(/datum/language/grenzelhoftian)
	desc = "I come from Grenzelhoft, whose dominions stretch from Hammerhold's northern mountains to the Crimson Lands and the deserts of Naledi. Militarism and fierce national pride have made it Grimoria's greatest power.<br>"
	origin_desc = "<br><br><b>The Grenzelhoft Empire</b>, formally the Great Imperial Pact of the Grenzelhoft Dynasty and often called the Black Empire, dominates the western continent. Its banner unites many of the west's richest and most influential kingdoms.<br><br>Militarism and national pride define Grenzelhoftian culture. Centuries of war produced Grimoria's first professional army and a noble class in which battlefield service can matter as much as birth. Conquest spreads the Empire's customs by force, and Grenzelhoft was the first power to deploy firearms throughout its armies.<br><br>Alistair IV Grenzelhoft reigns as Kaiser of the Zenithar Pact and King of Zentarion. His authority is formidable, though it depends upon the Kaiserstag, an assembly that represents the imperial estates in legislation and high justice.<br><br>The Empire accommodates both the Church of the Ten and the All-Father's cathedrals within the Imperial Church of the Eleven. That uneasy settlement grew from the marriage of Supreme Magister Adrian VII and High Priestess Miranda II Bastonskaya—a union privately mocked as <i>sacred in name and forged in Tartarus</i>.<br><br>"

/datum/virtue/origin/valorian
	map_group_order = 1
	map_state_order = 2
	map_origin_order = 1
	map_visible = TRUE
	map_x = 26.4
	map_y = 36.1
	map_state_id = "valoria"
	map_state_name = "Valorian Trade Union"
	map_origin_name = "Valorian Trade Union"
	name = "Valorian"
	origin_name = "Valoria"
	added_languages = list(/datum/language/valorian)
	desc = "I come from Valoria, heartland of the Church of the Ten and home to five mercantile republics scattered across the Black Ocean.<br>"
	origin_desc = "<br><br><b>Valoria</b>, formally the Most Serene Union of the Five Trade Republics and the Church of the Indivisible Ten, is a confederation of five semi-independent republics. Its wealth and influence follow its merchants, ports, and trading quarters across both land and sea.<br><br>Four republics stand as equal partners; the fifth serves as their administrative and legal center. There the Most Serene Doge is elected to settle disputes, direct foreign policy, regulate commerce, and levy common taxes and duties.<br><br>Valoria is also the heartland of the Church of the Ten, Grimoria's most widespread faith. The city of Eterna holds the oldest Holy Throne, from which the Patriarch guides temples devoted to the indivisible pantheon.<br><br>"

/datum/virtue/origin/heartfelt
	map_group_order = 3
	map_state_order = 6
	map_origin_order = 1
	map_visible = TRUE
	map_x = 33.0
	map_y = 33.0
	map_state_id = "heartfelt"
	map_state_name = "Free Islands of Hartfelt"
	map_origin_name = "Free Islands of Hartfelt"
	list_group_order = 6
	list_item_order = 1
	name = "Heartfeltian"
	origin_name = "Heartfelt"
	desc = "I come from the islands of Hartfelt, once the jewel of the northern seas and now a kingdom consumed by civil war.<br>"
	origin_desc = "<br><br><b>The Kingdom of Hartfelt</b> was once the pearl of the northern seas. Nobles traveled from across the world to admire its landscapes, collect its art, and taste fruit grown nowhere else. Its scholars and craftspeople prospered beneath a stable crown.<br><br>That peace ended fourteen years ago. Civil war shattered the kingdom, and no claimant has restored its unity. Only the gods know what order, if any, will rise from the ruins.<br><br>"

/datum/virtue/origin/etrusca
	map_group_order = 3
	map_state_order = 1
	map_origin_order = 1
	map_visible = TRUE
	map_x = 43.9
	map_y = 40.2
	map_state_id = "etrusca"
	map_state_name = "Kingdom of Etrusca"
	map_origin_name = "Kingdom of Etrusca"
	name = "Etruscan"
	origin_name = "Etrusca"
	added_languages = list(/datum/language/etruscan)
	desc = "I belong to one of the many cultures of the Etruscan archipelago. Refined tastes, elaborate dress, and the institution of slavery shaped my early life.<br>"
	origin_desc = "<br><br><b>The Kingdom of Etrusca</b>, also called the Etruscan Islands or the Island Union of Zaragoza, lies in the middle of the Resting Ocean. Isolation and maritime trade produced one of Grimoria's wealthiest and most diverse cultures.<br><br>Its two principal islands, Navarno and Montecarina, differ enough to resemble separate countries. The crown of House Zaragoza nevertheless binds them into a single kingdom.<br><br>"

/datum/virtue/origin/otava
	map_group_order = 3
	map_state_order = 5
	map_origin_order = 1
	map_visible = TRUE
	map_x = 18.1
	map_y = 90.2
	map_state_id = "otava"
	map_state_name = "The Otavan Theocracy"
	map_origin_name = "The Otavan Theocracy"
	name = "Otavan"
	origin_name = "Otava"
	added_languages = list(/datum/language/otavan)
	desc = "I come from Otava, the island stronghold of those who worship Psydon, the wounded All-Creator.<br>"
	origin_desc = "<br><br><b>The Otavan Theocracy</b> is the foremost stronghold of faith in Psydon, the wounded All-Creator. Founded after the fall of the holy comet Zion and united under a Supreme Magister, this small state commands religious learning and influence far beyond its shores. Steam and gunpowder have only strengthened its resolve to confront the forces of darkness.<br><br>Otava lies southwest of Giza in the southern ocean. Its ports make the island strategically important, while a network of overseas fortresses and port cities supplies it with food and raw materials. Those holdings belong to the Church of the All-Father in law but answer in practice to the Supreme Magister's chancery.<br><br>Supreme Magister Kastellos Neratta rules from the walled cathedral-fortress of Deilitis. The Marshal of the Inquisition—whose identity is carefully concealed—stands beside the Magister as the island's second great authority. Travelers, refugees, sailors, and religious orders have all shaped Otavan society, but faith in the All-Father binds them together. Otava is the birthplace of the Inquisition, the Order of Silver, and the Order of Black Gunpowder.<br><br>"

/datum/virtue/origin/gronn
	map_group_order = 1
	map_state_order = 5
	map_origin_order = 1
	map_visible = TRUE
	map_x = 11.3
	map_y = 31.6
	map_state_id = "gronn"
	map_state_name = "Gronn"
	map_origin_name = "Gronn"
	list_group_id = "gronn"
	list_group_name = "Gronn"
	name = "Gronnic"
	origin_name = "Gronn"
	added_languages = list(/datum/language/gronnic)
	desc = "I come from the cold, unforgiving lands of Gronn: either the Northern Isles or the neighboring Sister Lands of Fjalla.<br>"
	origin_desc = "<br><br><b>Gronn</b> encompasses the Northern Islands and the neighboring Sister Lands of the Northern Wastes. Outsiders know its people as guarded traders and fearsome raiders. Those who survive the journey with useful goods, however, can find willing partners among them.<br><br>Gronn faith rejects both the Ten and the teachings of Psydon. Its people honor six great beasts, each embodying a principle by which life should be lived. Foreign theologians draw parallels with other pantheons, but the Gronn firmly deny those interpretations and preserve their own rites. They seldom wage war solely over religion; the northern climate itself has proved a stronger defense against conversion than any army.<br><br>"

/datum/virtue/origin/racial/crimson_lands
	map_group_order = 1
	map_state_order = 6
	map_origin_order = 1
	map_visible = TRUE
	map_x = 26.5
	map_y = 69.3
	map_state_id = "crimson_lands"
	map_state_name = "Crimson Lands"
	map_origin_name = "Crimson Lands"
	list_group_id = "crimson_lands"
	list_group_name = "Crimson Lands"
	list_group_order = 7
	list_item_order = 1
	name = "Crimsonlander"
	origin_name = "Crimson Lands"
	added_languages = list(/datum/language/raneshi)
	races = list(/datum/species/anthromorph,
				/datum/species/anthromorphsmall)
	desc = "My life is bound to the Crimson Lands, whether as a native of that magically ruined country or as one of the soldiers, mercenaries, and fortune-seekers drawn there by the Twilight War. Whatever brought me to the scarlet wastes, I left them forever changed.<br>"
	origin_desc = "<br><br><b>The Crimson Lands</b> stretch between the Black Empire's northern plains and the prefecture of Naledi. Dozens of tribes, petty kingdoms, and city-states once flourished there under rulers who drew power from an ancient magical source. During the Twilight War the region became Grenzelhoft's road south, then the stronghold of Wolf Shah Zukhim and his coalition against Dvergeil.<br><br>After Zukhim's defeat, Basileus Mansa-Padashi ordered the mages of the Tower of Nok to overload the source and end the northern threat. The resulting catastrophe incinerated powerful sorcerers, twisted others into maddened wild-kin, and killed or transformed much of the population.<br><br>Today the region is a barren scarlet waste saturated with unstable magic. Ruined towers and fortresses draw treasure-seekers despite their dangers, while scattered communities struggle to survive in a land almost stripped of ordinary plant and animal life."

/datum/virtue/origin/raneshen
	map_group_order = 1
	map_state_order = 7
	map_origin_order = 1
	map_visible = TRUE
	map_x = 50.4
	map_y = 71.6
	map_state_id = "raneshen"
	map_state_name = "Prefecture of Raneshan"
	map_origin_name = "Prefecture of Raneshan"
	list_group_id = "zybantian_empire"
	list_group_name = "Zibantian Empire"
	list_group_order = 8
	list_item_order = 3
	list_subgroup_name = "Prefectures"
	name = "Ranesheni"
	origin_name = "Raneshan"
	added_languages = list(/datum/language/raneshi)
	desc = "I come from Raneshan, a Zibantian prefecture where the saber commands more respect than gold. Its people measure status through martial glory, conquest, and captives taken in battle rather than mercantile profit.<br>"
	origin_desc = "<br><br><b>Raneshen</b> is Zibantia's second-largest prefecture and marks the eastern edge of the Western Kingdoms. A kephalos governs it with broad autonomy, much like neighboring Naledi.<br><br>Its position once gave Raneshen a near-monopoly over trade with the Far East. Rare goods from Gyozdai enriched its cities during the Golden Empire's height. That prosperity faded when the old empire fell and merchants opened new routes; eastern caravans now arrive only rarely.<br><br>"

/datum/virtue/origin/naledi
	map_group_order = 1
	map_state_order = 8
	map_origin_order = 1
	map_visible = TRUE
	map_x = 34.7
	map_y = 77.5
	map_state_id = "naledi"
	map_state_name = "Prefecture of Naledi"
	map_origin_name = "Prefecture of Naledi"
	list_group_id = "zybantian_empire"
	list_group_name = "Zibantian Empire"
	list_group_order = 8
	list_item_order = 2
	list_subgroup_name = "Prefectures"
	name = "Naledian"
	origin_name = "Naledi"
	added_languages = list(/datum/language/raneshi)
	desc = "I come from Naledi, a Zibantian prefecture known for its endless deserts and distinctive faith. The Twilight War devastated my homeland and marked everyone who survived it.<br>"
	origin_desc = "<br><br><b>Naledi</b> is one of Zibantia's two largest prefectures and is governed by a kephalos appointed by the Basileus. Despite its formal subordination to the central government, Naledi retains broad autonomy over local administration, culture, and religion. Its traditions and beliefs distinguish it sharply from the rest of Zibantia.<br><br>Unlike most Zibantians, the Naledian people follow the Psydonite faith rather than the Ten. Most Naledians believe the Almighty still lives, a conviction that shapes every part of their daily life and lends their culture unusual fervor and cohesion.<br><br>The Naledian confession, known as the Doctrine of Fate, teaches that Psydon foresaw his defeat at the hands of Zizo—called Iblis in Naledi—and willingly abandoned his heavenly throne when he understood what was to come. Since then, he has walked among mortals, observing them until humanity proves worthy of his return. Legend holds that Psydon taught the Naledians to wear golden masks: second faces that shield the soul and mind from demons and jinn."

/datum/virtue/origin/zybantian
	map_group_order = 1
	map_state_order = 9
	map_origin_order = 1
	map_visible = TRUE
	map_x = 40.8
	map_y = 67.4
	map_state_id = "zybantu"
	map_state_name = "Zibantian Empire"
	map_origin_name = "Zibantian Empire"
	list_group_id = "zybantian_empire"
	list_group_name = "Zibantian Empire"
	list_group_order = 8
	list_item_order = 1
	name = "Zybantian"
	origin_name = "Zybantu"
	added_languages = list(/datum/language/raneshi)
	desc = "I come from Zigurat Zibantu, which gathers the remnants of the fallen Golden Empire beneath one banner. Its crowded, diverse cities are known for arcane learning, the slave trade, and a government that balances imperial authority with regional autonomy.<br>"
	origin_desc = "<br><br><b>The Zibantian Empire</b>, or Zigurat Zibantu, arose in the south from the ruins of the Golden Empire after its defeat by Grenzelhoft in the Twilight War. It preserves many ancient institutions while slowly rebuilding its power.<br><br>Basileus Manasa-Padashi rules the Zibantian heartland and the autonomous prefectures of Naledi and Raneshen. The Universal Patriarchate of Dvergeil provides spiritual authority, teaching a form of the Pantheon in which Nok, rather than Astrata, holds primacy.<br><br>Enslaved labor and the slave trade remain central to the imperial economy. The Golden Empire's Purple Fleet once taxed every merchant crossing the Black Sea, but that naval supremacy ended with the war. Naledi still suffers from the devastation of Grenzelhoftian raids, and communities of escaped slaves have turned to banditry or Mattiosism. Zibantian arcane traditions also endured: although Grenzelhoft destroyed great orders such as the New Moon, Naledian Psydonite sorcerers and other mages remain influential.<br><br>"

/datum/virtue/origin/kazengun
	map_group_order = 3
	map_state_order = 4
	map_origin_order = 1
	map_visible = TRUE
	map_x = 84.8
	map_y = 66.9
	map_state_id = "kazengun"
	map_state_name = "Kazen Shogunate"
	map_origin_name = "Kazen Shogunate"
	list_group_id = "kazengun"
	list_group_name = "Kazen Shogunate"
	list_group_order = 7
	list_item_order = 1
	name = "Kazen Mainlander"
	origin_name = "Kazengun"
	added_languages = list(/datum/language/kazengunese)
	desc = "I come from the mist-shrouded lands of Kazengun. The customs I learned in childhood often surprise the Westerners I meet.<br>"
	origin_desc = "<br><br><b>The Kazen Shogunate</b>, also called Kazengun, is a great feudal island state in the eastern ocean. The Shogun's military authority binds together the Au'ra peoples, the powerful northern and southern clans, and the recently conquered lands of Joseon on the eastern continent.<br><br>Rigid social rank, aristocratic privilege, and the Aisatai Order form the pillars of Kazengun society. Openly challenging a superior is scandalous and can border on heresy. Advancement is accepted only when success itself appears to prove that the Order intended it: an exceptionally wealthy merchant might, for example, rise to daimyo. Even then, official doctrine insists that change is unnatural to the Order."

/datum/virtue/origin/lingyue
	map_group_order = 3
	map_state_order = 7
	map_origin_order = 1
	map_visible = TRUE
	map_x = 81.3
	map_y = 36.4
	map_state_id = "jeoseon"
	map_state_name = "Joseon"
	map_origin_name = "Joseon"
	list_group_id = "kazengun"
	list_group_name = "Kazen Shogunate"
	list_group_order = 7
	list_item_order = 2
	name = "Joseonese"
	origin_name = "Joseon"
	added_languages = list(/datum/language/lingyuese)
	desc = "I come from Joseon, a vassal kingdom of the Kazen Shogunate. My homeland once won independence from Gyozdai; although conquest forced my people to bow again, their desire for freedom remains strong.<br>"
	origin_desc = "<br><br>For most of recorded history, Joseon belonged to <b>the Gyozdai realm.</b> Gyozdai chronicles claim that Joseon was the first civilized state to swear loyalty after witnessing the countless legions of the Malachite Huangdi, decades before the Arch-Betrayal and the War in the Heavens.<br><br>The relationship was never equal. Gyozdai elites dismissed Joseon as barbaric, and their diplomats treated its people as a conquered nation. Joseon finally declared independence in the eleventh century of the New Order, when civil conflict and undead incursions weakened its former master. The freedom was brief: after the devastating Red Band uprising, the Kazen Shogunate conquered the exhausted country. Its people nevertheless remember independence, and their desire for it endures.<br><br>"

/datum/virtue/origin/gyedzenese
	map_group_order = 2
	map_state_order = 3
	map_origin_order = 1
	map_visible = TRUE
	map_x = 72.4
	map_y = 36.6
	map_state_id = "gyedzai"
	map_state_name = "Gyozdai"
	map_origin_name = "Gyozdai"
	list_group_order = 3
	list_item_order = 1
	name = "Gyedzenese"
	origin_name = "Gyedzai"
	added_languages = list(/datum/language/gyedzenese)
	desc = "I come from Gyozdai, once united beneath a Huangdi. Today it is no single state, but a collection of rival factions struggling for land, resources, and legitimacy.<br>"
	origin_desc = "<br><br><b>Gyozdai</b>, sometimes called the Gyozdai Kingdom or Empire, is now a cultural name rather than a unified state. A Huangdi once ruled these lands through a succession of celebrated dynasties, but the empire fragmented more than four centuries ago. Shared language, religion, and custom still bind its peoples together. Gyozdai is renowned for silk cultivation and for tea ceremonies that serve equally as daily ritual, diplomatic language, and an expression of respect.<br><br>Ten rival dynasties, supported by shifting leagues and clans, now fight for the right to name a new Huangdi. Armies contest the borders while factions struggle within every court. No claimant has yet brought all Gyozdai beneath a single banner.<br><br>"

/datum/virtue/origin/hammerhold
	map_group_order = 1
	map_state_order = 10
	map_origin_order = 1
	map_visible = TRUE
	map_x = 23.1
	map_y = 18.8
	map_state_id = "hammerhold"
	map_state_name = "The Kingdom of Hammerhold"
	map_origin_name = "The Kingdom of Hammerhold"
	name = "Hammerholdian"
	origin_name = "Hammerhold"
	added_languages = list(/datum/language/elvish)
	desc = "I come from Hammerhold, a cold northern kingdom that became a homeland for the elves after the Divine Empire fell.<br>"
	origin_desc = "<br><br><b>The Kingdom of Hammerhold</b>, also called the Six Great Principalities, is small in territory but vital to the Western Continent's defense. It stands against three northern scourges: goblin tribes, marching dead, and cannibal clans. Warm summers and rich harvests are rare, but the harsh country raises people renowned for endurance.<br><br>The royal demesne and five princely marches divide Hammerhold between them. The ancient elven House of Khmelnitsky holds the crown and claims descent from witnesses to the All-Father's reign. By tradition, the women of that house wear the Monomakh Hat and rule for long, measured reigns. Their vassal principalities guard the frontier between the Wild North and the troubled south.<br><br>"

/datum/virtue/origin/avar
	map_group_order = 2
	map_state_order = 2
	map_origin_order = 1
	map_visible = TRUE
	map_x = 62.2
	map_y = 24.8
	map_state_id = "aavnr"
	map_state_name = "Aavnr Highlands"
	map_origin_name = "Aavnr Highlands"
	name = "Aavnic"
	origin_name = "Avar"
	added_languages = list(/datum/language/aavnic)
	desc = "I come from the Aavnr Highlands, a vast country of steppes, warriors, and nomads only recently freed from centuries of Gyozdai domination.<br>"
	origin_desc = "<br><br><b>The Aavnr Highlands</b> are a vast expanse of mountains and steppe north of Gyozdai. Aavnr has no unified state. Many nomadic communities resist permanent settlement, even as a feudal society develops in the north.<br><br>A loose confederation centered on the city-state of Serendnizhina offers the nearest thing to common government. Tribal chiefs, urban rulers, and steppe khans gather there to exchange news, settle disputes, bargain over trade, or declare hostilities. Seven leading figures form a council for major decisions, but its authority is often ceremonial. In serious conflicts, each faction relies upon its own strength and alliances."

/datum/virtue/origin/racial/lirvas
	map_group_order = 2
	map_state_order = 1
	map_origin_order = 1
	map_visible = TRUE
	map_x = 75.3
	map_y = 48.5
	map_state_id = "lirvas"
	map_state_name = "Lirvas, the One Hundred and Eleventh Empire"
	map_origin_name = "Lirvas, the One Hundred and Eleventh Empire"
	name = "Lirvasian"
	origin_name = "Lirvas"
	added_languages = list(/datum/language/draconic)
	races = list(/datum/species/kobold,
				/datum/species/lizardfolk,
				/datum/species/anthromorph,
				/datum/species/dracon)
	desc = "I come from the jungles of Lirvas, where the descendants of dragons built their Eternal Empire upon the ruins of countless fallen civilizations.<br>"
	origin_desc = "<br><br><b>The One Hundred and Eleventh Empire of Lirvas</b> is, according to naga prophecy, destined to be the last empire—and an eternal one. Kobolds, lizardfolk, and draconoids return from across the world to fulfill that promise and settle their ancient struggle with Gyozdai.<br><br>"

/datum/virtue/origin/racial/underdark
	map_group_order = 4
	map_state_order = 3
	map_origin_order = 1
	map_visible = FALSE
	map_state_id = "underdark"
	map_state_name = "The Underdark"
	map_origin_name = "The Underdark"
	list_group_order = 3
	list_item_order = 1
	name = "Underdweller"
	origin_name = "the Underdark"
	desc = "I come from the Underdark, a vast network of caverns extending beneath much of the Western Kingdoms.<br>"
	added_languages = list(/datum/language/undercommon)
	races = list(/datum/species/elf/dark,
				/datum/species/human/halfelf,
				/datum/species/kobold,
				/datum/species/dwarf/mountain,
				/datum/species/dwarf/gnome,
				/datum/species/goblinp,
				/datum/species/anthromorphsmall,
				/datum/species/ooze,
				/datum/species/moth)
	origin_desc = "<br><br>Beneath Grimoria, beyond the light of Astrata and Nok, lies <b>the Underdark</b>: a cave system extending beneath much of the Western Kingdoms. The drow have made it their refuge since ancient times, and their magnificent cities can become death traps for careless visitors.<br><br>The Upper Underdark consists of caves, catacombs, buried temples, hidden cellars, and ruins close to the surface. Adventurers and smugglers use its passages to travel unseen.<br><br>The Middle Underdark descends roughly fifteen miles into permanent night, where clean water is precious. Drow settlements share this depth with purple worms, umber hulks, beholders, giant moles, and worse creatures that prey upon unprepared travelers.<br><br>No reliable account has returned from the Lower Underdark. Even the predators of the middle depths avoid it. Light fails quickly there, illusions unravel, and magical anomalies distort space, time, body, and mind."

/datum/virtue/origin/racial/underdark_drow
	map_group_order = 4
	map_state_order = 3
	map_origin_order = 2
	map_visible = FALSE
	map_state_id = "underdark"
	map_state_name = "The Underdark"
	map_origin_name = "Underground Cities"
	list_group_order = 3
	list_item_order = 2
	name = "Underdweller - Drow Cities"
	origin_name = "the Underdark"
	desc = "I come from one of the drow cities of the Middle Underdark. I grew up amid intrigue, desperate struggles for survival, and prayers to the Lady of Darkness—whether sincere or merely performed.<br>"
	added_languages = list(/datum/language/undead)
	races = list(/datum/species/elf/dark,
				/datum/species/human/halfelf)
	origin_desc = "<br><br>Beneath Grimoria, beyond the light of Astrata and Nok, lies <b>the Underdark</b>: a cave system extending beneath much of the Western Kingdoms. The drow have made it their refuge since ancient times, and their magnificent cities can become death traps for careless visitors.<br><br>The Upper Underdark consists of caves, catacombs, buried temples, hidden cellars, and ruins close to the surface. Adventurers and smugglers use its passages to travel unseen.<br><br>The Middle Underdark descends roughly fifteen miles into permanent night, where clean water is precious. Drow settlements share this depth with purple worms, umber hulks, beholders, giant moles, and worse creatures that prey upon unprepared travelers.<br><br>No reliable account has returned from the Lower Underdark. Even the predators of the middle depths avoid it. Light fails quickly there, illusions unravel, and magical anomalies distort space, time, body, and mind."

/datum/virtue/origin/racial/akhdruk
	map_group_order = 4
	map_state_order = 4
	map_origin_order = 1
	map_visible = FALSE
	map_state_id = "akhdruk"
	map_state_name = "Drud Akhdruk"
	map_origin_name = "Drud Akhdruk"
	list_group_order = 4
	list_item_order = 1
	name = "Akhdruki"
	added_languages = list(/datum/language/dwarvish)
	origin_name = "Drud Akhdruk"
	desc = "I come from Drud Akhdruk, the dwarven kingdom that unites dozens of strongholds across Grimoria.<br>"
	races = list(/datum/species/dwarf/mountain,
				/datum/species/dwarf/gnome)
	origin_desc = "<br><br>Dwarven standing rests on three measures: age, wealth, and mastery of a craft. Those who possess all three command the greatest respect, though boasting about one's lineage is considered poor form.<br><br>Dwarves honor their ancestors by preserving what they made. Craftspeople repair ancient works, reforge inherited weapons, and incorporate old relics into new creations. Their greatest arms are forged from blacksteel.<br><br>Oaths lie at the heart of dwarven honor. A broken promise does not die with the oathbreaker: descendants may inherit both the duty to fulfill an ancestor's pledge and the right to demand restitution from the betrayer's heirs.<br><br>Grave offenses against faith or law are entered into a Book of Grudges. Every respectable dwarf carries a personal volume in which to record wrongs that remain unsettled."

/datum/virtue/origin/racial/infernal
	map_group_order = 4
	map_state_order = 5
	map_origin_order = 1
	map_visible = FALSE
	map_state_id = "infernal"
	map_state_name = "Inferno"
	map_origin_name = "Inferno"
	list_group_order = 5
	list_item_order = 1
	name = "Infernal"
	added_languages = list(/datum/language/hellspeak)
	origin_name = "the Inferno"
	desc = "I come from Inferno, an outer plane and the homeland of demons. I escaped its calculated evil and institutional cruelty to seek a life in the unfamiliar lands of Grimoria.<br>"
	races = list(/datum/species/tieberian,
				/datum/species/dullahan,
				/datum/species/demihuman)
	origin_desc = "<br><br><b>Inferno</b> is the nearest of the outer planes and exerts a powerful influence upon Grimoria. Etruscans call it Averno; in the Western Kingdoms it is simply Hell. Some Psydonite clergy identify it with Tartarus, the destination of sinful souls, but infernal witnesses dispute that teaching. They claim only souls bound by a mortal pact with a devil are drawn there.<br><br>Because the two planes lie so close together, ambitious infernal lords often cross the boundary to seize resources or display their power. Such incursions leave ruined lands, shattered communities, and new generations of tieflings in their wake."

/datum/virtue/origin/racial/ancient
	map_group_order = 4
	map_state_order = 6
	map_origin_order = 1
	map_visible = FALSE
	map_state_id = "ancient"
	map_state_name = "Ancient Age"
	map_origin_name = "Ancient Age"
	list_group_order = 6
	list_item_order = 1
	name = "Ancient"
	origin_name = "Age Long Gone"
	added_languages = list(/datum/language/celestial)
	desc = "My origins are lost to the centuries. Perhaps no trace of my culture survives, or perhaps divine intervention alone brought me into being.<br>"
	races = list(/datum/species/elf/wood,
				/datum/species/elf/dark,
				/datum/species/elf/sun,
				/datum/species/aasimar,
				/datum/species/dracon)
	origin_desc = "<br>Not every people can still point to a homeland on a modern map. The War in the Heavens and the Age of Strife erased realms that once held millions, leaving only scattered ruins and a few surviving chronicles to testify that those powers ever existed."
