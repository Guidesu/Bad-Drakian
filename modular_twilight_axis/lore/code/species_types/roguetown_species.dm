/datum/species/human/northern
	desc_title = "People"
	desc = "Humans are familiar throughout Grimoria and form the majority population of most of its nations. Their many peoples, cultures, and complexions outnumber every other mortal race combined. Humans owe their success to their great numbers, adaptability, and ancient lineage. Some traditions claim they descend from the All-Father himself, while others hold that humanity arose alongside the elves."
	languages = list(/datum/language/common)

/datum/species/tieberian
	desc_title = "Tieflings"
	desc = "The first tieflings were born in the Inferno from unions between mortals and demons. Most occupy the lowest ranks of infernal society as disenfranchised laborers, although some archdevils permit favored tieflings to hold positions of influence.\
	Tieflings reach Grimoria either as refugees from the Inferno or as descendants of demonic incursions into the mortal world. Those born in the aftermath of such attacks are often treated as a curse upon their families and face fear and persecution. Refugees who escaped the Inferno by their own courage—especially through open revolt—may earn far greater respect. Tieflings who defied their infernal heritage through action have even founded noble houses in Zybantu, Grenzelhoft, and Azuria."
	origin_default = /datum/virtue/origin/racial/infernal
	origin = "Infernal"
	languages = list(/datum/language/common)
	base_name = "Demonkin"
	is_subrace = FALSE

/datum/species/elf
	languages = list(/datum/language/common)

/datum/species/elf/wood
	sub_name = "Northern Elf"
	desc_title = "Northern Elves"
	desc = "Elves are among Grimoria's oldest peoples, heirs to a long history and a refined culture. Their longevity and accumulated wisdom helped them found the Divine Empire, once the great stronghold of the Primal Five in lands now held by the Western Kingdoms. \
	After the Empire fell, many elves fled north from its ruined heartland. These refugees became the northern elves: founders of Hammerhold, settlers along the Narrow Sea, and, in some cases, migrants as far as Gronn. They adapted to a harsh climate and adopted many customs from Hammerhold's human population without surrendering their longevity or aristocratic traditions. Northern elven culture blends imperial heritage with the resilience, discipline, and practical readiness demanded by the Wild North."

/datum/species/elf/sun
	desc_title = "Sun Elves"
	desc = "Elves are among Grimoria's oldest peoples, heirs to a long history and a refined culture. Their longevity and accumulated wisdom helped them found the Divine Empire, once the great stronghold of the Primal Five in lands now held by the Western Kingdoms. \
	Sun elves are descended from those who refused to accept the Empire's end. They remained in its former territories—Etrusca, Valoria, and the Raneshan prefecture of the Zybantian Empire—preserving its traditions and the worship of Astrata. Where their northern kin embraced pragmatism, sun elves remain devoted to ancient rites, old temples, and the hope that the Pantheon's favor may one day be restored. Their societies are conservative and strictly hierarchical, with Astrata revered as first among the Indivisible Ten."
	origin_default = /datum/virtue/origin/etrusca
	origin = "Etrusca"

/datum/species/elf/dark
	desc_title = "Dark Elves"
	desc = "Long before the modern empires arose, one elven people sought dominion over all the others beneath the leadership of the Spider Queens. Their promise of power drew many followers and kindled generations of brutal war. Defeat at the hands of the other clans finally drove the survivors into the Underdark, where they became the drow known today.\
	Life in that hostile realm transformed them, aided by the Spider Queens' arcane influence. Their skin darkened, their hair turned white, and eyes adapted to the darkness took on a red hue. The Queens granted women greater physical strength than men, establishing the matriarchal order found throughout drow cities. Their highest priestesses may receive a further blessing through metamorphosis into spider-like forms, though such beings are rarely encountered on the surface."
	origin_default = /datum/virtue/origin/racial/underdark_drow
	origin = "the Underdark"

/datum/species/dullahan
	desc_title = "Dullahan"
	desc = "Little is known about the sinister dullahans who emerge from the ice of Mandira, one of the Inferno's kingdoms. The prevailing theory holds that the Inferno gradually corrupts mortals trapped within its chaotic planes. Dullahans may therefore be Grimorian mortals who died in Mandira or endured its decay until the taint of undeath—present since Zizo's invasion—became irreversible.\
	These revenants appeared in Grimoria only recently; Otavan chronicles record the first encounter seventy years ago. Like tieflings before them, they cross the boundary between planes while fleeing the Inferno. Their visibly unnatural condition inspires far greater fear, however. Tieflings who resist their demonic heritage may earn acceptance, but dullahans remain distrusted across the world, and the less educated often mistake them for servants of Zizo—with predictable consequences."
	origin_default = /datum/virtue/origin/racial/infernal
	origin = "Infernal"
	languages = list(/datum/language/common)
	base_name = "Demonkin"

/datum/species/aasimar
	desc_title = "Aasimar"
	desc = "Malum created the first aasimar shortly after his ascension to the Pantheon. Unwilling to lose contact with his former flock, the newly divine dwarf blessed certain mortals to bear messengers capable of hearing the gods in dreams and, at times, while awake. Carrying a fragment of their creator's power, these messengers inspired awe, and their words were often treated as divine truth. Once their value became clear, the other gods of the Pantheon—and eventually the All-Father—created messengers of their own among Grimoria's mortal peoples.\
	Aasimar power may lie dormant in a bloodline for generations before awakening, which scholars use to explain aasimar children born to otherwise ordinary parents. Though divine messengers no longer command the reverence they once did, an aasimar birth remains an auspicious event, bringing honor to both child and family.\
	The Church of the Ten firmly rejects every claim that some aasimar descend from the Despised Pantheon rather than the Ten or the All-Father."
	origin_default = /datum/virtue/origin/valorian
	origin = "Valoria"
	languages = list(/datum/language/common)
	blood_color = "#00ffef"

/datum/species/dracon
	desc_title = "Dracians"
	desc = "Dracians, also known as dragonborn, are intelligent humanoid reptiles who trace their ancestry to dragons. \
	The earliest surviving references to them date to the fourth age before the New Order. Theories of their origin range from unions between mortals and dragons in humanoid form to experiments intended to reproduce the ancient power of dragonkind. Dragons themselves often dismiss the Dracians as 'a mistake' and refuse to elaborate.\
	Dragonkin have remained a small and scattered people throughout recorded history. No chronicle describes a draconic state of their own; instead, individual Dracians frequently appear among the nobility of past and present powers, including the Divine Empire, Valoria, the Golden Empire, and the Otavan Theocracy."
	max_age = 1900
	origin_default = /datum/virtue/origin/racial/ancient
	origin = "Age Long Gone"
	base_name = "Dragonkin"
	languages = list(/datum/language/common)

/datum/species/human/halfelf
	desc_title = "Half-elves"
	desc = "Half-elves are born of human and elven parentage. Although they inherit only part of ancient elven strength, many enjoy unusual longevity and the grace associated with their elven kin. Pure-blooded elves often meet them with dislike or open hostility, while humans may struggle to distinguish them from full elves. \
	Half-drow are rarer still. Even drow exiles seldom welcome outsiders, making children of mixed drow heritage exceptionally uncommon. Their lighter complexions and unusual hair colors usually distinguish them from full-blooded drow."
	languages = list(/datum/language/common)

/datum/species/halforc
	desc_title = "Half-orcs"
	desc = "Half-orcs are born of human and orc parentage, most often to orcish mothers. Their upbringing varies as widely as either people, and many are raised within strong family and cultural traditions. Outsiders who mistake their imposing appearance for a lack of intelligence rarely make that error twice."
	languages = list(/datum/language/common)

/datum/species/vulpkanin
	desc_title = "Vendarines"
	desc = "Vendarines resemble lupians closely enough that outsiders often confuse the two peoples. Lupian tradition attributes their awakening to Nok, but no surviving account connects the vendarines to divine intervention. They first appeared after the War in the Heavens in lands now ruled by Grenzelhoft. Most vendarines live in cities, where they are prominent as merchants, scholars, artisans, and members of the professional classes. Several influential patrician families in the free cities are also of vendarine descent."
	languages = list(/datum/language/common)

/datum/species/kobold
	desc_title = "Kobolds"
	desc = "Kobolds are small reptilian humanoids, usually standing between seventy and one hundred twenty centimeters tall. Colorful scales cover their bodies, while their eyes range from violet to shades of orange and red. They have digitigrade legs, long clawed fingers, crocodilian jaws, small pale horns, and slender tails. Scholars agree that kobolds are related to Dracians and dragons, although the exact nature of that ancestry remains disputed."
	origin_default = /datum/virtue/origin/racial/lirvas
	origin = "Lirvas"
	base_name = "Dragonkin"
	languages = list(/datum/language/common)

/datum/species/anthromorph
	desc_title = "Wildkins"
	desc = "No single cause explains the existence of wildkin. Some are born to beastkin parents, while others appear unexpectedly in otherwise human or elven families. Priests variously attribute such births to Dendor, Xailix, or an inherited magical influence.\
	Powerful sorcery can also transform mortals into beastlike forms. The magical catastrophe that created the Crimson Lands changed many of its survivors into wildkin, and their descendants now form one of the world's largest beastkin populations."
	languages = list(/datum/language/common)

/datum/species/anthromorphsmall
	desc_title = "Verminwolves"
	desc = "Verminwolves are small beastkin whose features resemble rats, mice, mustelids, and other creatures commonly dismissed as vermin. Their origins are as varied and uncertain as those of larger wildkin: inherited traits, divine influence, and magical transformation may all play a part. Their slight stature and association with scavenging animals expose them to prejudice even from other beastkin, but communities of verminwolves thrive throughout the Crimson Lands and the great cities of Grimoria."
	languages = list(/datum/language/common)

/datum/species/demihuman
	desc_title = "Halfkins"
	desc = "Halfkins combine mostly human forms with distinct animal features. Some inherit those traits from beastkin ancestry, while others are born after an unpredictable magical or divine influence touches a family. Scholars place them on the same broad spectrum as wildkin, although halfkins usually pass more easily within human society. The distinction offers little protection from suspicion in places where any sign of beastkin heritage is feared."
	languages = list(/datum/language/common)

/datum/species/lizardfolk
	desc_title = "Zardmen"
	desc = "Zardmen are powerful, semi-aquatic reptilian humanoids. Their scales range from dark green to shades of brown and gray. Most stand between six and seven feet tall and possess sharp claws, formidable teeth, and muscular tails used for balance. Some scholars describe them as distant relatives of Dracians and dragons, but Zardmen have cultures and histories entirely their own."
	origin_default = /datum/virtue/origin/racial/lirvas
	origin = "Lirvas"
	base_name = "Dragonkin"
	languages = list(/datum/language/common)

/datum/species/lupian
	desc_title = "Lupians"
	desc = "Lupian legend teaches that wolves were once Dendor's favored beasts. Their nightly howls reached Nok, who heard in them not mere instinct but a longing for knowledge. Beneath a full moon, she descended among a wolf pack and bestowed the Lunar Gift upon every beast that met her gaze. Their bodies rose upon two legs, their minds awakened, and they learned the gifts of speech and reason. These first awakened wolves became the ancestors of the lupian people."
	languages = list(/datum/language/common)

/datum/species/moth
	desc_title = "Fluvianes"
	desc = "Fluvians are commonly compared with moths because of their insectoid appearance and notorious appetite for cloth. The nickname is imperfect, however: despite their wings and light frames, most Fluvians cannot truly fly."
	languages = list(/datum/language/common)

/datum/species/tabaxi
	desc_title = "Tabaxi"
	desc = "Tabaxi are a feline people thought to have originated in the southern Western Kingdoms. Most stand between six and seven feet tall, with slender bodies, long tails, retractable claws, and spotted or striped fur ranging from pale yellow to reddish brown. Their slit-pupiled eyes are usually green or yellow. Keen senses and an exceptional sense of balance make tabaxi accomplished runners, climbers, and swimmers."
	origin_default = /datum/virtue/origin/zybantian
	origin = "Zybantu"
	languages = list(/datum/language/common)

/datum/species/akula
	desc_title = "Axians"
	desc = "Axians are a proud, sharklike people with a long tradition of maritime trade, privateering, and resistance to taxation. Their distrust of hereditary authority often brings them into conflict with nobles and port officials. Axian merchants and sailors travel widely, and many measure status through the distant shores they have visited rather than the land they possess."
	languages = list(/datum/language/common)

/datum/species/construct/metal
	desc_title = "Constructs"
	desc = "The origin of these metal automatons remains uncertain. Constructs claim that Zizo, the Lady of Darkness, created their first kind after her betrayal by Xailix. No reliable account identifies the homeland of their greater population or proves whether any still serve the Arch-Traitoress. Those encountered in the Western Kingdoms insist that they are free of her influence—though wary neighbors do not always believe them."
	origin_default = /datum/virtue/origin/heartfelt
	origin = "Heartfelt"
	languages = list(/datum/language/common)

/datum/species/dwarf/mountain
	desc_title = "Dwarves"
	desc = "Dwarves are among Grimoria's oldest peoples. Their own name, akhdruki, means 'heirs of the mountains,' and their oldest traditions say they were born from stone. They are renowned for craftsmanship, engineering, endurance, fierce pride, and an obstinacy as durable as their works. Reverence for ancestors and the preservation of inherited customs shape nearly every part of dwarven life.\
	Most dwarves stand between ninety and one hundred forty centimeters tall. Their compact frames, broad shoulders, powerful limbs, and remarkable stamina suit life in mountains and deep mines. Other peoples compare them to stone in jest; dwarves generally regard the comparison as a compliment."
	origin_default = /datum/virtue/origin/racial/akhdruk
	origin = "Drud Akhdruk"
	languages = list(/datum/language/common)

/datum/species/goblinp
	desc_title = "Goblins"
	desc = "Goblins are short humanoids distinguished by large ears and, most commonly, green skin. Tradition holds that the first goblins arose from blood spilled when Ravox wounded Graggar, the brutal god of war. Many goblin tribes still worship Graggar and raid their neighbors, but others reject that legacy and maintain secluded communities beyond the reach of both hostile kin and persecutors. During the past several centuries, increasing numbers have entered Grimoria's towns and cities, where they struggle against deep suspicion from churches, governments, and ordinary citizens."
	languages = list(/datum/language/common)
