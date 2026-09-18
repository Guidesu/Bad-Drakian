/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/template/deserttown
	map_file_name = "deserttown.dmm"
	realm_name = "Al-Ashur"
	// BEGIN DESERT TOWN CONTRACTS (Rollback by removing this list)
	threat_regions = list(
		THREAT_REGION_DESERT_NEAR,
		THREAT_REGION_DESERT_DEEP,
	)
	realm_type = "Sultanate"
	realm_type_short = "Sultanate"
	slot_adjust = list(
		// /datum/job/roguetown/mercenary = 7, //haha fuck you one less slot!!
		// /datum/job/roguetown/apothecary = 1, //remodelled the building for more room
		/datum/job/roguetown/gnoll = 3,//hyenas just belong here!
	)
	title_adjust = list(
		/datum/job/roguetown/cook = list(display_title = "Abd-Al-Matbakh", f_title = "Abd-Al-Matbakh"),
		/datum/job/roguetown/tapster = list(display_title = "Abd-Al-Khidma", f_title = "Abd-Al-Khidma"),
		/datum/job/roguetown/bathworker = list(display_title = "Khadim-Hammam", f_title = "Khadim-Hammam"),
		/datum/job/roguetown/merchant = list(display_title = "Tajir-Kalan", f_title = "Tajir-Kalan"),
		/datum/job/roguetown/bathmaster = list(display_title = "Hammami", f_title = "Hammami"),
		/datum/job/roguetown/innkeeper = list(display_title = "Sahib-Al-Khan", f_title = "Sahib-Al-Khan"),
		/datum/job/roguetown/apothecary = list(display_title = "Attar", f_title = "Attar"),
		/datum/job/roguetown/guildsman = list(display_title = "Tawaifi", f_title = "Tawaifi"),
		/datum/job/roguetown/guildmaster = list(display_title = "Rais-Al-Tawaifa", f_title = "Rais-Al-Tawaifa"),
		/datum/job/roguetown/adventurer/courtagent = list (display_title = "Enslaved kafir", f_title = "Enslaved kafir"),
		/datum/job/roguetown/marshal = list(display_title = "Mushir", f_title = "Mushira"),
		/datum/job/roguetown/prince = list(display_title = "Amir", f_title = "Amira"),
		/datum/job/roguetown/priest =  list(display_title = "High Priest", f_title = "High Priestess"),
		/datum/job/roguetown/clerk = list(display_title = "Katib", f_title = "Katiba"),
		/datum/job/roguetown/squire = list(display_title = "Radif", f_title = "Radifah"),
		/datum/job/roguetown/physician = list(display_title = "Palace Physician"),
		/datum/job/roguetown/villager = list(display_title = "Villager"),
		/datum/job/roguetown/magician = list(display_title = "Palace Magician"),
		/datum/job/roguetown/pilgrim = list(display_title = "Nomad"),
	)
	tutorial_adjust = list(
		/datum/job/roguetown/cook = "By the will of fate, you fell into slavery to Sahib Al-Khan. This is not the worst fate, especially knowing that you work with food: cook, preserve, come up with recipes. But the stigma of a slave is oppressive...",
		/datum/job/roguetown/tapster = "By the will of fate, you fell into slavery to Sahib-Al-Khan. This is not the worst fate, considering who you work with and how you work: you are nothing more than a servant serving food and serving the clients of the caravanserai. But the stigma of a slave is oppressive...",
		/datum/job/roguetown/bathworker = "It doesn’t matter whether voluntarily, by force, or in any other way - but you found yourself a slave in the hammam. This is not the worst fate, considering that you could probably simply be killed?... But now you are a powerless thing in the hands of Hammami - your Master, it is he who will decide your future fate",
		/datum/job/roguetown/merchant = "Tajir-Kalan, as you are called here, means 'senior merchant', which quite accurately reflects your position: you head the local trading bazaar, it is you who decide where and which caravan will go, what it will sell and what it will buy. This is a very, very influential position - however, the dissolution of the Tawaif of Sheikhs, in which your predecessor occupied one of the main roles, significantly undermined your position, now you are no better than a monkey - spin, run, jump, fulfill the wishes of the gentlemen with coins .. And maybe someday you will regain your position in the Sultanate.",
		/datum/job/roguetown/bathmaster = "The Zibantian hammam is a whole science. The centuries of decadence of the Golden Empire in its decline gave rise to countless ways to satisfy oneself and someone else. You are not just a bath attendant, you are Hammami, the master of the hammam, the master of the bath boys and girls, the brightest persons of the Sultanate come to you - and no one except you knows about this, their dirtiest and most perversions, the most sophisticated and hidden desires: everything is revealed and becomes obvious in the setting of the hammam... And who is behind managing it all?... Of course, you.",
		/datum/job/roguetown/innkeeper = "Sahib-Al-Clan, that is, the owner of the caravanserai - in simple terms of the TAVERN - is the one who runs an entire inn, where numerous travelers, mercenaries and all sorts of dubious personalities stay. A whole galaxy of rumors passes through your ears, both commercial and everyday, sometimes there is rumor from Al-Qasr itself!.. But do not forget, because you are a servant of the Sultan like everyone else here.",
		/datum/job/roguetown/apothecary = "You are Attar, that is, a doctor, doctor, healer - whatever they call you. In the deserts of Zibantia, this calling is treated with particular reverence: many desert tales and legends tell of wise healers, semi-mystical people who heal as much through scientific calculation as through connection with the gods.",
		/datum/job/roguetown/guildsman = "You are a full member of the tawaif of artisans, which was created anew relatively recently. One way or another connected with your Rais-Al-Tawaif, you work both for him and for the benefit of the tawaif, not forgetting to take a certain percentage for yourself.",
		/datum/job/roguetown/guildmaster = "Several years ago, the tawaif, that is, the association of artisans and traders, which was headed by the influential sheikhs of Al-Ashur, was abolished and dissolved. Immediately after this, the 'Sheikhs' Rebellion' happened and the dunes were filled with desert bandits. You, Rais-Al-Tawaifa, now head the newly created tawaif of artisans, but have virtually no influence compared to what the tawaif had previously. Follow the orders of the Sultan and local residents and perhaps one day you will regain the untold wealth of the Sheikhs.",
		/datum/job/roguetown/adventurer/courtagent = "By the will of fate, you became a slave. But you were too useful - the VIZIR liked your connections, your skills, your abilities. Now you owe him not only your life - but also the absence of any stigma. You have been given an assignment - espionage. Listen to your Master and perhaps one day you will be set free.",
		/datum/job/roguetown/marshal = "Zibantia has never been a quiet place; there were always hermits who decided to start a war over trade routes. However, the situation worsened significantly after the Twilight War. You are Mushir, the commander-in-chief of the Sultan's army. At your disposal are cataphracts, janissaries and Azebs - you have always been wary of the latter; what kind of loyalty can you expect from slaves?",
		/datum/job/roguetown/physician = "You are the personal physician of the Sultan, who personally chose you for such a responsible task. At your disposal are significant intellectual works of the entire east - do not dare to disgrace the right to be called the doctor of the Sultan himself!",
		/datum/job/roguetown/magician = "Your path is a sacred vow dedicated to conquering the art of arcana and an unquenchable thirst for knowledge. \
        You owe your life to the Sultan, for it is only his generous wealth that allowed you to continue your research in these harsh times.\
        In return, you have repeatedly proven your loyalty to the throne by serving as a just kadi of His Majesty.",
		/datum/job/roguetown/squire = "You are Radif, a junior comrade and faithful squire in the service of the steel-clad Faris. \
        Your lot is to bear your master's shield, clean his plate armor, and care for his war saiga in the cool of the oases.\
        Let the noble hassa and sheikhs in the palaces barely notice your presence; on the battlefield, you are his shield, his shadow, and his most loyal blade.\
        Study diligently, endure the harshness of training in the sands of the frontier, and one day, having shed enough enemy blood in forthcoming wars of glory,\
        you will earn the right to wash your visage with gold and to call yourself the true Pharis of the Sultanate.",
		/datum/job/roguetown/prince = "You have never known what the winter cold is, you have not known the torment of hunger and, of course, you have never worked a day in your life. \
        You are free, like a bird in the sky, and can indulge in any vices, as long as your parents sit on the throne.\
        But one day you will have to grow up, and then will come the day when your carelessness will cost you far more than a few squandered mammon.",
		/datum/job/roguetown/clerk = "Katib scribe, tax collector, blessed fool. You assist the Sultan's Vizier in everything he needs and take on his burden when he is away. Even if you do not belong to the noble Hassa, this is far from the worst fate. There is just one caveat: if the Sultan’s mammon are lost or disappear without a trace, the noble nobleman will always be able to buy himself off and avoid the slave stocks. And you? Eh... Well, they say that Giza is extremely beautiful at this time of year.",
		/datum/job/roguetown/shophand = "You work in the greatest shop of Al-Ashur at the behest of the merchant who chained you to this painful routine. \
        Sorting goods on the shelves and keeping account for your master is a monotonous and dulling occupation, but at least you have a roof\
        and a well-fed life in warmth. Perhaps, in time, you may manage to become someone greater than just a servant.",
	)
	/// Jobs that this map won't use
	blacklist = list(
		/datum/job/roguetown/hag,
		// /datum/job/roguetown/adventurer//Adventurers (Could rename which are 'foreigners but who cares)'
		// /datum/job/roguetown/wretch,
		/datum/job/roguetown/bandit,
		// /datum/job/roguetown/pilgrim, //I have Nomads in the dtvillager.dm //actually this makes sense as a non-zyb foreigner!
		// /datum/job/roguetown/trader,
		// /datum/job/roguetown/assassin,

		/datum/job/roguetown/lord,// sultan//moved to an if-map-then-outfit
		/datum/job/roguetown/knight,// cataphract
		/datum/job/roguetown/hand,// vizier
		// /datum/job/roguetown/suitor,
		/datum/job/roguetown/steward, //gonna try merging this role with Vizier EDIT: with the higher pop we can afford to keep em separate now
		// /datum/job/roguetown/consort,
		// /datum/job/roguetown/captain,
		// /datum/job/roguetown/bailiff,

		//church. Fine as is

		/datum/job/roguetown/seneschal,// headslave
		/datum/job/roguetown/councillor,// sheikh
		// /datum/job/roguetown/magician,// moved to an if-map-then-outfit statement in the baseblock
		/datum/job/roguetown/jester, //are jesters really a desert thing? Maybe ought to push people into playing slaves instead..?
		// /datum/job/roguetown/physician,

		/datum/job/roguetown/manorguard,//  mamaluk
		// /datum/job/roguetown/rookie,//  mamalukrookie!
	//	/datum/job/roguetown/guardsman,//  mamaluk
		/datum/job/roguetown/vanguard,//  jannissary
		/datum/job/roguetown/warden,//  jannissary
		/datum/job/roguetown/sergeant,//janissary sergeant
		// /datum/job/roguetown/squire,
		// /datum/job/roguetown/veteran,
	//	/datum/job/roguetown/watchcaptain,
	//	/datum/job/roguetown/wardenmaster,

		//trader (probably fine to keep as it is)

		// /datum/job/roguetown/archivist,
		// /datum/job/roguetown/barkeep,
		// /datum/job/roguetown/guildmaster,
		// /datum/job/roguetown/guildsman,
		// /datum/job/roguetown/merchant,
		// /datum/job/roguetown/niteman,
		// /datum/job/roguetown/tailor,
		// /datum/job/roguetown/elder,
		
		// /datum/job/roguetown/villager,
		// /datum/job/roguetown/farmer,
		// /datum/job/roguetown/prisonerb,
		// /datum/job/roguetown/prisonerr,
		// /datum/job/roguetown/hostage,
		// /datum/job/roguetown/nightmaiden, // Current ones are probably fine?
		// /datum/job/roguetown/cook,
	//	/datum/job/roguetown/knavewench, //maybe after expanding the tavern for it
		// /datum/job/roguetown/lunatic,


		//inquisition. Fine as is

		//mercenaries. Fine as is
		
		/datum/job/roguetown/servant,//slave
		// /datum/job/roguetown/apothecary,
		// /datum/job/roguetown/churchling,
		// /datum/job/roguetown/clerk, //gonna try merging this with Sheikh - EDIT with higher pop we can afford to keep this role around
		// /datum/job/roguetown/wapprentice,
		// /datum/job/roguetown/orphan,
		// /datum/job/roguetown/prince,//dtprince
		// /datum/job/roguetown/shophand,
		
	//	/datum/job/roguetown/tribalchieftain,
	//	/datum/job/roguetown/tribalshaman,
	//	/datum/job/roguetown/tribalguard,
	//	/datum/job/roguetown/tribalrabble,
	//	/datum/job/roguetown/tribalvillager,

		/datum/job/roguetown/royal_guard, 
		/datum/job/roguetown/sheriff, 
		/datum/job/roguetown/town_watch, 
		/datum/job/roguetown/vanguard, 
		/datum/job/roguetown/courtphysician, 
		/datum/job/roguetown/knight_enigma, 
		/datum/job/roguetown/royal_sergeant, 
		/datum/job/roguetown/overseer, 
		/datum/job/roguetown/mayor,
		/datum/job/roguetown/bailiff,
	)


/*list to blacklist for other maps (update as new replacements are added)
		/datum/job/roguetown/cataphract,
		/datum/job/roguetown/vizier,
		/datum/job/roguetown/headslave,
		/datum/job/roguetown/sheikh,
		/datum/job/roguetown/janissary,
		/datum/job/roguetown/janissarysergeant,
		/datum/job/roguetown/azeb,
		/datum/job/roguetown/azebagha,
		/datum/job/roguetown/slavemaster,
		/datum/job/roguetown/dtslave, */

/datum/map_adjustment/template/deserttown/on_mapping_init()
	. = ..()
	setup_deserttown_economy()
