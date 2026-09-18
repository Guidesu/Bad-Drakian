/// Divine pantheon storytellers
#define DIVINE_STORYTELLERS list( \
	/datum/storyteller/astrata, \
	/datum/storyteller/noc, \
	/datum/storyteller/ravox, \
	/datum/storyteller/abyssor, \
	/datum/storyteller/xylix, \
	/datum/storyteller/necra, \
	/datum/storyteller/pestra, \
	/datum/storyteller/malum, \
	/datum/storyteller/eora, \
	/datum/storyteller/dendor, \
	/datum/storyteller/psydon, \
)

//Yeah-yeah, he's not the same pantheon but suck it up, buttercup. We not makin' more defines.

/// Inhumen pantheon storytellers
#define INHUMEN_STORYTELLERS list( \
	/datum/storyteller/zizo, \
	/datum/storyteller/baotha, \
	/datum/storyteller/graggar, \
	/datum/storyteller/matthios, \
)

/// All storytellers
#define STORYTELLERS_ALL (DIVINE_STORYTELLERS + INHUMEN_STORYTELLERS)

/datum/storyteller
	var/ru_name = null

/datum/storyteller/proc/get_display_name()
	return ru_name || name

/datum/storyteller/psydon
	name = "Psydon"
	ru_name = "Psydon"
	vote_desc = "Peace reigns. There will be no antagonists. His children can rest easy - they deserve a break."
	desc = "Ordinary and moderate events happen 1.2 times more often. Without antagonists and divine intervention. Gnolls are disabled."
	welcome_text = "A soft wind passes through the quiet streets..."
	weight = 6
	always_votable = TRUE
	color_theme = "#80ced8"
	preferred_gnoll_mode = GNOLL_SCALING_NONE
	wretch_slot_cap = 0
	guarantees_roundstart_roleset = FALSE
	roundstart_prob = 0

	//Has no influence, your actions will not impact him his spawn rates. Cus he's asleep.
	//Tl;dr - higher event spawn rates to keep stuff interesting, no god intervention, no antags. (Raids and omens will still happen at normal rate.)
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1.2,
		EVENT_TRACK_MODERATE = 1.2,
		EVENT_TRACK_INTERVENTION = 0,			//No god intervention, cus he's asleep.
		EVENT_TRACK_CHARACTER_INJECTION = 0,	//No antagonist spawns.
	)

/datum/storyteller/astrata
	name = "Astrata"
	ru_name = "Astrata"
	vote_desc = "Order reigns. The great threats are not destined to appear, and the gnolls do not dare to set foot in Her daylight. Her mercy is addressed to the nobility and Her decrees."
	desc = "Bandits, liches, werewolves and vampire lords do not drop. Masquerade is the only major antagonist at the start of the round and receives a weight of x1.5. Gnolls are disabled. Wretches scale normally."
	welcome_text = "Warm daylight awakens you from sleep..."
	weight = 6
	always_votable = TRUE
	follower_modifier = LOWER_FOLLOWER_MODIFIER
	color_theme = "#FFD700"
	preferred_gnoll_mode = GNOLL_SCALING_NONE
	guarantees_roundstart_roleset = FALSE
	roundstart_prob = 0

	starting_point_multipliers = list(
		EVENT_TRACK_CHARACTER_INJECTION = 0,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_CHARACTER_INJECTION = 0,	//No antagonist spawns under Her order.
	)

	influence_sets = list(
	"Set 1" = list(
		STATS_LAWS_AND_DECREES_MADE = list("name" = "Laws and decrees:", "points" = 2.75, "capacity" = 45),
	),
	"Set 2" = list(
		STATS_ALIVE_NOBLES = list("name" = "Number of nobles:", "points" = 2.5, "capacity" = 60),
	),
	"Set 3" = list(
		STATS_NOBLE_DEATHS = list("name" = "Noble deaths:", "points" = -3.75, "capacity" = -60),
		STATS_PEOPLE_SMITTEN = list("name" = "People smitten:", "points" = 4, "capacity" = 40),
	),
	"Set 4" = list(
		STATS_ASTRATA_REVIVALS = list("name" = "Holy revivals:", "points" = 6, "capacity" = 75),
		STATS_PRAYERS_MADE = list("name" = "Prayers made:", "points" = 2.25, "capacity" = 65),
	),
	"Set 5" = list(
		STATS_TAXES_COLLECTED = list("name" = "Taxes collected:", "points" = 0.2, "capacity" = 80),
	))

/datum/storyteller/noc
	name = "Noc"
	ru_name = "Nok"
	vote_desc = "Knowledge reigns. There are fewer events than usual, but lasso intervention is still possible. Her grace is directed to those who dream of more."
	desc = "Magic events receive a weight of x1.2, events with ghosts - x1.1. The spread of event costs is higher. The pool of antagonists remains unchanged. One gnoll possible."
	welcome_text = "The air crackles with arcane energy..."
	weight = 4
	always_votable = TRUE
	color_theme = "#F0F0F0"
	preferred_gnoll_mode = GNOLL_SCALING_SINGLE

	tag_multipliers = list(
		TAG_MAGICAL = 1.2,
		TAG_HAUNTED = 1.1,
	)
	cost_variance = 25

	influence_sets = list(
		"Set 1" = list(
			STATS_BOOKS_PRINTED = list("name" = "Books printed:", "points" = 2, "capacity" = 40),
		),
		"Set 2" = list(
			STATS_LITERACY_TAUGHT = list("name" = "Literacy taught:", "points" = 20, "capacity" = 140),
		),
		"Set 3" = list(
			STATS_BOOKS_BURNED = list("name" = "Books burned:", "points" = -2, "capacity" = -50),
		),
		"Set 4" = list(
			STATS_SKILLS_DREAMED = list("name" = "Skills dreamed:", "points" = 0.325, "capacity" = 100),
		),
		"Set 5" = list(
			STATS_VOYEURS = list("name" = "Voyeurs:", "points" = 5, "capacity" = 50),
		),
	)

/datum/storyteller/ravox
	name = "Ravox"
	ru_name = "Ravox"
	vote_desc = "Glory reigns. Raids and omens come more often. His mercy is heard in the clink of steel and war cries - the bandits answer His call, but the gnolls stay away."
	desc = "The raid pool gains points 2 times faster, and raid events gain x1.3 weight. Bandits are guaranteed to become major antagonists at the start of the round. Ordinary and personal events are suppressed. Gnolls are disabled."
	welcome_text = "\"The pipes of Zericho echo in the distance...\""
	weight = 4
	always_votable = TRUE
	color_theme = "#228822"
	preferred_gnoll_mode = GNOLL_SCALING_NONE
	guarantees_roundstart_roleset = TRUE
	roundstart_prob = 100

	tag_multipliers = list(
		TAG_RAID = 1.3,
	)

	starting_point_multipliers = list(
		EVENT_TRACK_CHARACTER_INJECTION = 1,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.75,
		EVENT_TRACK_PERSONAL = 0.9,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,	//No midround antagonist spawns - raids and omens carry the conflict.
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 2,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_COMBAT_SKILLS = list("name" = "Combat skills learned:", "points" = 1.065, "capacity" = 90),
		),
		"Set 2" = list(
			STATS_PARRIES = list("name" = "Parries made:", "points" = 0.052, "capacity" = 100),
		),
		"Set 3" = list(
			STATS_WARCRIES = list("name" = "Warcries made:", "points" = 0.35, "capacity" = 50),
		),
		"Set 4" = list(
			STATS_YIELDS = list("name" = "Yields made:", "points" = -4.25, "capacity" = -40),
		),
		"Set 5" = list(
			STATS_THRILLSEEKERS = list("name" = "Thrillseekers:", "points" = 5, "capacity" = 50)
		)
	)

/datum/storyteller/abyssor
	name = "Abyssor"
	ru_name = "Abyssor"
	vote_desc = "Water reigns. Events are calm, but their course changes with the tide. His mercy is addressed to fishermen, leeches and drowned people - dreamwalkers walk the deep paths, and gnolls do not dare to go to His shores."
	desc = "Water events receive a weight of x1.3, trade events - x1.2. Dreamwalker gains x1.5 weight in the antagonist pool. Gnolls are disabled."
	welcome_text = "The horizon is darkening: the clouds are gathering for a nearby storm..."
	weight = 4
	always_votable = TRUE
	color_theme = "#3366CC"
	preferred_gnoll_mode = GNOLL_SCALING_NONE

	tag_multipliers = list(
		TAG_WATER = 1.3,
		TAG_TRADE = 1.2,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_FISH_CAUGHT = list("name" = "Fish caught:", "points" = 1.75, "capacity" = 85),
		),
		"Set 2" = list(
			STATS_WATER_CONSUMED = list("name" = "Water consumed:", "points" = 0.014, "capacity" = 90),
		),
		"Set 3" = list(
			STATS_ABYSSOR_REMEMBERED = list("name" = "Abyssor remembered:", "points" = 1.1, "capacity" = 50),
			STATS_ALIVE_AXIAN = list("name" = "Number of axians:", "points" = 8, "capacity" = 70),
		),
		"Set 4" = list(
			STATS_LEECHES_EMBEDDED = list("name" = "Leeches embedded:", "points" = 0.75, "capacity" = 70),
		),
		"Set 5" = list(
			STATS_PEOPLE_DROWNED = list("name" = "People drowned:", "points" = 12, "capacity" = 75),
			STATS_BATHS_TAKEN = list("name" = "Baths taken:", "points" = 4.5, "capacity" = 60),
		)
	)

/datum/storyteller/xylix
	name = "Xylix"
	ru_name = "Xylix"
	vote_desc = "Unpredictability reigns. Nothing is set in stone, but everything is possible. His mercy is directed towards chance, whim and joke."
	desc = "Some forced events ignore online requirements, and events that have already been triggered immediately receive a full replay penalty. Divine Intervention x1.75; character infiltration, bad omen and raids are suppressed to 0. All major antagonists available at the start of the round receive a weight of x1.5. Gnoll mode is randomly selected."
	welcome_text = "\"...this is what happens from excess spices and wine!\""
	weight = 4
	always_votable = TRUE
	event_repetition_multiplier = 0
	forced = TRUE
	color_theme = "#AA8888"
	preferred_gnoll_mode = GNOLL_SCALING_RANDOM

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1.1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1.75,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 0,
		EVENT_TRACK_RAIDS = 0,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_LAUGHS_MADE = list("name" = "Laughs had:", "points" = 0.225, "capacity" = 85),
		),
		"Set 2" = list(
			STATS_PEOPLE_MOCKED = list("name" = "People mocked:", "points" = 5, "capacity" = 60),
		),
		"Set 3" = list(
			STATS_CRITS_MADE = list("name" = "Crits made:", "points" = 0.26, "capacity" = 90),
		),
		"Set 4" = list(
			STATS_SONGS_PLAYED = list("name" = "Songs played:", "points" = 0.675, "capacity" = 70),
			STATS_MOAT_FALLERS = list("name" = "Moat fallers:", "points" = 4, "capacity" = 50),
		)
	)

/datum/storyteller/necra
	name = "Necra"
	ru_name = "Nekra"
	vote_desc = "Death reigns. Events happen less often, and antagonists appear more reluctantly. Her mercy is directed to those who return the rest to their graves."
	desc = "Ghost events gain x1.3 weight. Antagonist and raid spawn points gain points at half the rate; personal events are also slowed down. Ordinary and moderate events happen 1.25 times more often. One gnoll possible."
	welcome_text = "\"The smell of decay was wafted in the fief of Zenmark...\""
	weight = 4
	always_votable = TRUE
	color_theme = "#888888"
	preferred_gnoll_mode = GNOLL_SCALING_SINGLE

	tag_multipliers = list(
		TAG_HAUNTED = 1.3,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1.25,
		EVENT_TRACK_PERSONAL = 0.7,
		EVENT_TRACK_MODERATE = 1.25,
		EVENT_TRACK_INTERVENTION = 1.25,
		EVENT_TRACK_CHARACTER_INJECTION = 0.5,
		EVENT_TRACK_OMENS = 1.25,
		EVENT_TRACK_RAIDS = 0.5,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_DEATHS = list("name" = "Total deaths:", "points" = 1.35, "capacity" = 100),
		),
		"Set 2" = list(
			STATS_GRAVES_CONSECRATED = list("name" = "Graves consecrated:", "points" = 6.25, "capacity" = 80),
		),
		"Set 3" = list(
			STATS_GRAVES_ROBBED = list("name" = "Graves robbed:", "points" = -3.75, "capacity" = -40),
		),
		"Set 4" = list(
			STATS_DEADITES_KILLED = list("name" = "Deadites killed:", "points" = 6.25, "capacity" = 90),
		),
		"Set 5" = list(
			STATS_VAMPIRES_KILLED = list("name" = "Vampires killed:", "points" = 12.5, "capacity" = 70),
		),
		"Set 6" = list(
			STATS_SKELETONS_KILLED = list("name" = "Skeletons killed:", "points" = 5, "capacity" = 50),
		)
	)

/datum/storyteller/pestra
	name = "Pestra"
	ru_name = "Motley"
	vote_desc = "Healing reigns. Events are calm, but skillful hands can change their course. Her mercy is addressed to healers and alchemists."
	desc = "Alchemical and medical events receive a weight of x1.2, natural ones - x1.1. All major antagonists drop at the same base weight - no preference between bandits, liches, werewolves and vampire lords. One gnoll possible."
	welcome_text = "You can hear the clinking of instruments and the gurgling of alchemical miracles..."
	color_theme = "#AADDAA"
	preferred_gnoll_mode = GNOLL_SCALING_SINGLE

	tag_multipliers = list(
		TAG_ALCHEMY = 1.2,
		TAG_MEDICAL = 1.2,
		TAG_NATURE = 1.1,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_POTIONS_BREWED = list("name" = "Potions brewed:", "points" = 5.25, "capacity" = 80),
		),
		"Set 2" = list(
			STATS_WOUNDS_SEWED = list("name" = "Wounds sewed up:", "points" = 0.48, "capacity" = 100),
		),
		"Set 3" = list(
			STATS_LUX_HARVESTED = list("name" = "Lux extracted:", "points" = 8, "capacity" = 70),
		),
		"Set 4" = list(
			STATS_LUX_REVIVALS = list("name" = "Lux revivals:", "points" = 16, "capacity" = 70),
		),
		"Set 5" = list(
			STATS_ROT_CURED = list("name" = "Rot cured:", "points" = 5, "capacity" = 70),
		),
		"Set 6" = list(
			STATS_FOOD_ROTTED = list("name" = "Food rotted:", "points" = 0.26, "capacity" = 80),
		)
	)

/datum/storyteller/malum
	name = "Malum"
	ru_name = "Malum"
	vote_desc = "Labor reigns. Divine intervention happens more often. His mercy is addressed to the masters who create masterpieces and to the miners."
	desc = "Labor events receive a weight of x1.5. Divine intervention happens 2 times more often, personal events - 1.2 times more often. All major antagonists drop at the same base weight. One gnoll possible."
	welcome_text = "The sound of hammers echoes throughout the area, and the heat of forges fills the streets..."
	color_theme = "#D4A56C"
	preferred_gnoll_mode = GNOLL_SCALING_SINGLE

	tag_multipliers = list(
		TAG_WORK = 1.5,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1.2,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 2,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_MASTERWORKS_FORGED = list("name" = "Masterworks forged:", "points" = 7, "capacity" = 85),
		),
		"Set 2" = list(
			STATS_ROCKS_MINED = list("name" = "Rocks mined:", "points" = 0.26, "capacity" = 100),
		),
		"Set 3" = list(
			STATS_CRAFT_SKILLS = list("name" = "Craft skills learned:", "points" = 0.4, "capacity" = 80),
		),
		"Set 4" = list(
			STATS_CRAFTED_ITEMS = list("name" = "Crafted items:", "points" = 0.1, "capacity" = 100), //So he doesn't reign every round
		),
		"Set 5" = list(
			STATS_BEARDS_SHAVED = list("name" = "Beards shaved:", "points" = -4, "capacity" = -40),
			STATS_ALIVE_DWARVES = list("name" = "Number of dwarfs:", "points" = 4, "capacity" = 45),
		),
	)

/datum/storyteller/eora
	name = "Eora"
	ru_name = "Eora"
	vote_desc = "Love reigns. Good events come more often, and She does not wish harm on anyone. Without antagonists and gnolls; only a handful of outcasts (Wretches) hide on the outskirts. Her grace turns to romance."
	desc = "Mass events receive a weight of x1.5, blessings - x1.2. No antagonists or raids. Divine intervention happens 2 times more often, personal events - 1.4 times more often. Wretches are forced to be limited to 5 slots. Gnolls are disabled."
	welcome_text = "\"Love is in the air? No; This is the smell of freshly baked pies on the windowsills!\""
	color_theme = "#9966CC"
	preferred_gnoll_mode = GNOLL_SCALING_NONE
	wretch_slot_cap = 5
	guarantees_roundstart_roleset = FALSE
	roundstart_prob = 0

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)

	tag_multipliers = list(
		TAG_WIDESPREAD = 1.5,
		TAG_BOON = 1.2,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1.4,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 2,
		EVENT_TRACK_CHARACTER_INJECTION = 0,	//No antagonist spawns.
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 0,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_HUGS_MADE = list("name" = "Hugs made:", "points" = 2.5, "capacity" = 70),
		),
		"Set 2" = list(
			STATS_KISSES_MADE = list("name" = "Kisses made:", "points" = 7, "capacity" = 70),
		),
		"Set 3" = list(
			STATS_CLINGY_PEOPLE = list("name" = "Clingy people:", "points" = 6.5, "capacity" = 75),
		),
		"Set 4" = list(
			STATS_BEAUTIFUL_PEOPLE = list("name" = "Beautiful people:", "points" = 9, "capacity" = 50),
		),
		"Set 5" = list(
			STATS_MARRIAGES_MADE = list("name" = "Marriages made:", "points" = 20, "capacity" = 80), //Rare so worth a ton.
		)
	)

/datum/storyteller/dendor
	name = "Dendor"
	ru_name = "Dendor"
	vote_desc = "Nature reigns. Thickets and werewolves come more often. His mercy goes to the harvest and the lycanthropes - the gnolls stay away from His wild lands."
	desc = "Natural events receive a weight of x1.5. The werewolf is the only major antagonist at the start of the round and receives weight x1.5; Bandits, Liches and Vampire Lords do not drop. Divine intervention happens 2 times more often. Gnolls are disabled."
	welcome_text = "The roll call of birds sitting on the branches and the shine of the morning dew..."
	weight = 4
	always_votable = TRUE
	color_theme = "#664422"
	preferred_gnoll_mode = GNOLL_SCALING_NONE

	tag_multipliers = list(
		TAG_NATURE = 1.5,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 0.8,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 2,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_TREES_CUT = list("name" = "Trees felled:", "points" = -0.35, "capacity" = -45),
		),
		"Set 2" = list(
			STATS_PLANTS_HARVESTED = list("name" = "Plants harvested:", "points" = 0.75, "capacity" = 100),
		),
		"Set 3" = list(
			STATS_ANIMALS_TAMED = list("name" = "Animals tamed:", "points" = 3, "capacity" = 90),
		),
		"Set 4" = list(
			STATS_FOREST_DEATHS = list("name" = "Forest deaths:", "points" = 6, "capacity" = 90),
		),
		"Set 5" = list(
			STATS_WEREVOLVES = list("name" = "Number of werevolves:", "points" = 12.5, "capacity" = 65),
		),
	)

// INHUMEN

/datum/storyteller/zizo
	name = "Zizo"
	ru_name = "Zizo"
	vote_desc = "Chaos reigns. Liches awaken more readily than under the rule of any other God, the undead become much more ferocious, and the cultists of Ascension crawl out of their hiding places in order to make a worthy sacrifice to their Mistress. Her mercy is directed towards corpses - saints, nobles or rebels."
	desc = "Magical, gambling, deceitful and sudden events receive increased weight (from x1.2 to x1.5). Lich or Cult of Ascension are guaranteed at the start of the round; bandits, werewolves and vampire lords do not drop. Great variation in the cost of events. Fixed gnoll spawn: 15% chance, maximum 2. Expanding the number of Wretches slots may work depending on the number of garrison slots."
	welcome_text = "The dead wind carries the howl of the damned..."
	weight = 4
	always_votable = TRUE
	color_theme = "#CC4444"
	preferred_gnoll_mode = GNOLL_SCALING_FLAT
	wretch_slot_cap = 15

	tag_multipliers = list(
		TAG_MAGICAL = 1.2,
		TAG_GAMBLE = 1.5,
		TAG_TRICKERY = 1.3,
		TAG_UNEXPECTED = 1.2,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1.2,
		EVENT_TRACK_MODERATE = 1.1,
		EVENT_TRACK_INTERVENTION = 1.5,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 1.3,
		EVENT_TRACK_RAIDS = 0.8,
	)

	cost_variance = 50	// Events will be highly variable in cost

	influence_sets = list(
		"Set 1" = list(
			STATS_HUMEN_DEATHS = list("name" = "Humen killed:", "points" = 5.5, "capacity" = 80),
			STATS_CLERGY_DEATHS = list("name" = "Clergy killed:", "points" = 12, "capacity" = 70),
		),
		"Set 2" = list(
			STATS_DEADITES_WOKEN_UP = list("name" = "Deadites woken up:", "points" = 4, "capacity" = 85),
		),
		"Set 3" = list(
			STATS_DEADITES_ALIVE = list("name" = "Deadites alive:", "points" = 1, "capacity" = 40),
		),
		"Set 4" = list(
			STATS_LUX_HARVESTED = list("name" = "Clergy killed:", "points" = 12, "capacity" = 70),
		),
		"Set 5" = list(
			STATS_TORTURES = list("name" = "Tortures performed:", "points" = 5.25, "capacity" = 70),
		),
		"Set 6" = list(
			STATS_BOOKS_BURNED = list("name" = "Books burned:", "points" = 5, "capacity" = 50), //We actually gain influence from it
		),
	)

/datum/storyteller/baotha
	name = "Baotha"
	ru_name = "Baota"
	vote_desc = "Datura reigns. Events become more chaotic and darker. Her mercy is addressed to drunkards and addicts."
	desc = "Madness, Magic and Disaster events receive increased weight (from x1.1 to x1.4). Vampire Lord is guaranteed at the start of the round; bandits, liches and werewolves do not drop. All events accumulate points faster. Gnoll mode is randomly selected. Expanding the number of Wretches slots depending on the number of garrison slots may work."
	welcome_text = "The air is filled with the sugary smell of hops and spices..."
	weight = 4
	always_votable = TRUE
	color_theme = "#9933FF"
	preferred_gnoll_mode = GNOLL_SCALING_RANDOM
	wretch_slot_cap = 15

	tag_multipliers = list(
		TAG_INSANITY = 1.4,
		TAG_MAGIC = 1.2,
		TAG_DISASTER = 1.1,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1.1,
		EVENT_TRACK_PERSONAL = 1.2,
		EVENT_TRACK_MODERATE = 1.3,
		EVENT_TRACK_INTERVENTION = 2,
		EVENT_TRACK_CHARACTER_INJECTION = 0.7,
		EVENT_TRACK_OMENS = 1.5,
		EVENT_TRACK_RAIDS = 1.2,
	)

	cost_variance = 30	// Makes events more erratic in timing

	influence_sets = list(
		"Set 1" = list(
			STATS_JUNKIES = list("name" = "Number of junkies:", "points" = 9, "capacity" = 70),
		),
		"Set 2" = list(
			STATS_DRUGS_SNORTED = list("name" = "Drugs snorted:", "points" = 4, "capacity" = 85),
		),
		"Set 3" = list(
			STATS_ALCOHOLICS = list("name" = "Number of alcoholics:", "points" = 3.25, "capacity" = 60),
		),
		"Set 4" = list(
			STATS_ALCOHOL_CONSUMED = list("name" = "Alcohol consumed:", "points" = 0.042, "capacity" = 90),
		),
		"Set 5" = list(
			STATS_NYMPHOMANIACS = list("name" = "Number of nymphomaniacs:", "points" = 6, "capacity" = 30),
		),
		"Set 6" = list(
			STATS_PLEASURES = list("name" = "Pleasures had:", "points" = 5, "capacity" = 50),
		),
		"Set 5" = list(
			STATS_KNOTTED_NOT_LUPIANS = list("name" = "Non-Lupian knottings:", "points" = 5, "capacity" = 50),
		),
	)

/datum/storyteller/graggar
	name = "Graggar"
	ru_name = "Graggar"
	vote_desc = "Power reigns. Gnolls and assassins prowl harder than under any other God, and raids happen more often. His mercy turns to bloodshed and cannibalism."
	desc = "Combat, bloody and military events receive increased weight (from x1.2 to x1.6). Gnolls and assassins are guaranteed at the start of the round. Raids gain points 2.5 times faster. Dynamic gnoll scaling: packs grow with population. Expanding the number of Wretches slots depending on the number of garrison slots may work."
	welcome_text = "Smoke spreads through the streets, reeking of ash and blood..."
	weight = 4
	always_votable = TRUE
	color_theme = "#8B3A3A"
	preferred_gnoll_mode = GNOLL_SCALING_DYNAMIC
	wretch_slot_cap = 15

	tag_multipliers = list(
		TAG_BATTLE = 1.6,
		TAG_BLOOD = 1.3,
		TAG_WAR = 1.2,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.8,
		EVENT_TRACK_PERSONAL = 0.7,
		EVENT_TRACK_MODERATE = 1.2,
		EVENT_TRACK_INTERVENTION = 1.5,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 0.9,
		EVENT_TRACK_RAIDS = 2.5,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_BLOOD_SPILT = list("name" = "Blood spilt:", "points" = 0.03, "capacity" = 60),
		),
		"Set 2" = list(
			STATS_ORGANS_EATEN = list("name" = "Organs eaten:", "points" = 5, "capacity" = 70),
		),
		"Set 3" = list(
			STATS_DEATHS = list("name" = "Deaths:", "points" = 5, "capacity" = 115),
		),
		"Set 4" = list(
			STATS_ASSASSINATIONS = list("name" = "Sucessful assassinations:", "points" = 20, "capacity" = 100),
		),
		"Set 5" = list(
			STATS_PEOPLE_GIBBED = list("name" = "People gibbed:", "points" = 3.5, "capacity" = 55),
		)
	)

	cost_variance = 10	// Less randomness, more direct

/datum/storyteller/matthios
	name = "Matthios"
	ru_name = "Matthios"
	vote_desc = "Freedom reigns. Bandit raids happen much more often than under other Gods. His mercy is directed towards thefts and offerings from one special sanctuary."
	desc = "Trade, corruption and mining events are selected more often (x1.2 to x1.4). Bandits are guaranteed at the start of the round; Liches, werewolves and vampire lords do not appear. Antagonist spawn points accumulate 1.5 times faster. Gnoll mode is randomly selected. Expanding the number of Wretches slots depending on the number of garrison slots may work."
	welcome_text = "Mammon is ringing, and freshly signed awards still smell of ink..."
	weight = 4
	always_votable = TRUE
	color_theme = "#8B4513"
	preferred_gnoll_mode = GNOLL_SCALING_RANDOM
	wretch_slot_cap = 15
	tag_multipliers = list(
		TAG_TRADE = 1.4,
		TAG_CORRUPTION = 1.3,
		TAG_LOOT = 1.2,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1.1,
		EVENT_TRACK_MODERATE = 1.2,
		EVENT_TRACK_INTERVENTION = 1.3,
		EVENT_TRACK_CHARACTER_INJECTION = 1.5,
		EVENT_TRACK_OMENS = 1.1,
		EVENT_TRACK_RAIDS = 0.6,
	)

	influence_sets = list(
		"Set 1" = list(
			STATS_NOBLE_DEATHS = list("name" = "Nobles killed:", "points" = 5.5, "capacity" = 80),
		),
		"Set 2" = list(
			STATS_SHRINE_VALUE = list("name" = "Value offered to his idol:", "points" = 0.08, "capacity" = 70),
		),
		"Set 3" = list(
			STATS_GREEDY_PEOPLE = list("name" = "Number of greedy people:", "points" = 6.5, "capacity" = 70),
			STATS_INDEBTED = list("name"= "Number of indebted people:", "points" = 5, "capacity" = 25),
		),
		"Set 4" = list(
			STATS_ITEMS_PICKPOCKETED = list("name" = "Items pickpocketed:", "points" = 4.5, "capacity" = 80),
		),
		"Set 5" = list(
			STATS_LOCKS_PICKED = list("name" = "Locks picked:", "points" = 3.75, "capacity" = 80),
		)
	)

	cost_variance = 15	// Keeps a balance between predictability and randomness

#undef DIVINE_STORYTELLERS
#undef INHUMEN_STORYTELLERS
#undef STORYTELLERS_ALL
