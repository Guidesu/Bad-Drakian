/datum/species/human/northern
	desc_title = "People"
	desc = "A human is the general name for a race that has an appearance quite familiar to everyone. It is very difficult (if at all possible) to find a place where the human race is not known. In most countries of Grimoria, humans are the dominant race. And indeed: there are far more humans of all skin colors and internal races in the world than all the others combined. Possessing ordinary fertility abilities, humans succeed in many ways because they are not only the largest race — which causes their growth to occur geometrically — but also one of the oldest races — some believe that this race originates from the All-Father himself, while others claim that humans appeared if not later, then at the same time as elves."
	languages = list(/datum/language/common)

/datum/species/tieberian
	desc_title = "Tieflings"
	desc = "The first tieflings appeared in the Inferno as a product of interbreeding between members of mortal races and demons. In the hierarchy of infernal realms, they generally occupy the niche of disenfranchised labor, although some archdevils allow tieflings to hold more significant positions in their domains.\
	Tieflings come to the lands of Grimoria in two ways — either by fleeing from Inferno or being born already in the mortal lands as one of the unfortunate consequences of demonic invasions. The attitude of representatives of other races toward these two categories of half-breeds varies greatly. Those who were born due to demon attacks are considered a curse on their entire family for obvious reasons; they are persecuted and despised. On the other hand, those who left Inferno of their own free will often enjoy much greater respect, especially if it was the result of their armed uprising. Tieflings who went against their demonic nature and demonstrated it in action became the founders of several noble lines in Zibantia, Grenzelhoff, and Azuria."
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
	desc = "Elves are one of the oldest races of Grimoria, distinguished by a rich history and refined culture. Endowed with longevity and the wisdom of the ages, it was the elves who became the founders of the Divine Empire, which was a support for the Pantheon of the Primal Five on lands now belonging to the Western Kingdoms. \
	After the fall of the Divine Empire, a significant portion of the elves moved northward, away from the ravaged imperial lands. These refugees — the future northern elves — founded Hammerhold and settled along the lands of the Narrow Sea(now a vassal of Grenzelhof.), and some of them even reached Gronn. The northern elves have adapted to the harsh climate and tough way of life of their new homeland. They have absorbed many customs of Hammerhold's human society while retaining the longevity and aristocratic refinement characteristic of their race. The culture of the northern elves is a blend of imperial heritage with the pragmatism of the north, where resilience, discipline, and readiness to defend against the countless threats of the Wild North are valued."

/datum/species/elf/sun
	desc_title = "Sun Elves"
	desc = "Elves are one of the oldest races of Grimoria, distinguished by a rich history and refined culture. Endowed with longevity and the wisdom of the ages, it was the elves who became the founders of the Divine Empire, which was a support for the Pantheon of the Primal Five on lands now belonging to the Western Kingdoms. \
	Sun Elves are those who could not accept the end of the Divine Empire. They remained in the former imperial lands: in Etrusca, Valoria, and the Raneshan prefecture of the Byzantine Empire, continuing to preserve the traditions and cult of Astrata. Unlike their pragmatic northern kin, Sun Elves live in the past. They devoutly honor the rituals of the Divine Empire, maintain ancient temples, and continue to believe that the favor of the Pantheon can be restored. Their societies are characterized by conservatism, adherence to a strict hierarchy, and deep reverence for Astrata as the first among the Indivisible Pantheon."
	origin_default = /datum/virtue/origin/etrusca
	origin = "Etrusca"

/datum/species/elf/dark
	desc_title = "Dark Elves"
	desc = "Long ago, when empires in their current form did not yet exist, but the division of elves into tribes already did, one of them desired to rise above the others, taking the path of war under the leadership of the Spider Queens. Their ideas captivated many minds, eternal thirst for power and domination led to numerous brutal battles, but it was only the defeat of the drow by the forces of the other clans that gave the final push to the formation of this people in the form in which it exists today. Having lost most of their troops, the drow were forced to flee to the Underdark, where a new stage of their history began.\
	Having found themselves in such a hostile environment, the former elves had to change, not without the help of the arcane power of the Spider Queens. Their skin darkened significantly, their hair turned white, and their eyes, having adapted to the darkness, became red. The Queens endowed the women with much greater physical strength than the men, which is why matriarchy prevails everywhere in the cities. The high priestesses of the Spider Queens received their blessing from time to time in the form of a metamorphosis, which grants them spider-like features, but encountering one on the surface in present times is rare."
	origin_default = /datum/virtue/origin/racial/underdark_drow
	origin = "the Underdark"

/datum/species/dullahan
	desc_title = "Dullahan"
	desc = "Little is known about the sinister dullahans that come from the ice of Mandira — one of the kingdoms of Inferno. The most common theory of their origin revolves around Inferno's property of gradually altering and corrupting members of mortal races who find themselves in the chaotic environment of this Plane. It is believed that those who become dullahans are members of the Grimorean races who were unlucky enough to die in the lands of Mandira — or to be trapped there long enough for the decaying influence of these lands, forever tainted by the force of undeath since the invasion of Zizo, to become irreversible.\
	Revenants began to appear in the lands of Grimoria relatively recently — the first recorded encounter with them was entered into Ottawa's chronicles seventy years ago. Just like the tieflings before them, revenants cross the boundary between the Planes, fleeing from Inferno for one reason or another. Their unnatural nature, however, has become a cause for distrust and concern among the inhabitants of Grimoria — whereas tieflings are accepted, and sometimes even exalted for their willingness to combat their demonic nature, dullahans are feared and rejected throughout the world. Less educated segments of the population, not without reason, take them for servants of Zizo, with predictable results."
	origin_default = /datum/virtue/origin/racial/infernal
	origin = "Infernal"
	languages = list(/datum/language/common)
	base_name = "Demonkin"

/datum/species/aasimar
	desc_title = "Aasimars"
	desc = "The first aasimar were created by Malum shortly after his ascension to the Pantheon. Unwilling to lose connection with his flock, the dwarf, chosen to become a deity, blessed certain mortal women to give birth to divine messengers, who were endowed with the ability to hear the dictates of the deities in their dreams, and sometimes even in waking life. Possessing part of the divine power of their creator, these messengers were met by mortals with awe and respect, and their words were often interpreted as the ultimate truth. As the aasimar proved their usefulness, all the deities of the Pantheon, as well as the All-Father himself, adopted this practice, creating their own messengers among the mortal races of Grimoria.\
	It is said that the power of an aasimar can lie dormant in a family's genetic line for many generations until the time comes for it. At least, that is how the birth of aasmirs from ordinary mortal couples is explained nowadays. Despite the fact that former reverence for divine messengers is no longer so widespread, the birth of an aasimar is still considered an auspicious sign for the family, and he himself, like his parents, is often surrounded by honor and respect.\
	The Church of the Ten categorically denies any claims that some aasimars descend not from the Ten or the All-Father, but from the deities of the Despised Pantheon."
	origin_default = /datum/virtue/origin/valorian
	origin = "Valoria"
	languages = list(/datum/language/common)
	blood_color = "#00ffef"

/datum/species/dracon
	desc_title = "Dracians"
	desc = "Dracians, also called dragonborn — a species of intelligent humanoid reptiles, tracing their roots back to dragons. \
	The first mentions of dracians date back to IV-to my age before the New Order. Theories about how exactly they appeared in Grimoria vary from the interbreeding of dragons in mortal form with other races to experiments aimed at replicating the ancient and powerful dragon nature. The dragons themselves, in turn, often call the Drakians«a mistake» and refuse to explain in detail.\
	Throughout their history, the dragonkin have remained a small and scattered people. There is no documented draconic state in any chronicle; instead, members of this race are often mentioned among the ranks of prominent nobility of many states of the past and present, including the Divine Empire, Valoria, the Golden Empire, and the Otavan Theocracy."
	max_age = 1900
	origin_default = /datum/virtue/origin/racial/ancient
	origin = "Age Long Gone"
	base_name = "Dragonkin"
	languages = list(/datum/language/common)

/datum/species/human/halfelf
	desc_title = "Half-elves"
	desc = "Half-elves are the result of interracial relationships between humans and elves. Only partially inheriting the strength of ancient elven blood, half-breeds nevertheless often possess longevity and the precision inherent to elves. Among their pure-blooded kin, half-elves usually encounter dislike or open hostility, while humans often find it difficult to distinguish them from a full-fledged elf. \
	An even rarer category among half-breeds are the half-drow. Even those dark elves who were exiled from the Underdark rarely admit members of other races, which is why encountering a drow half-breed is an extremely rare event. They are easily distinguished from pure-blooded comrades by their lighter skin and hair shades unusual for drow."
	languages = list(/datum/language/common)

/datum/species/halforc
	desc_title = "Half-orcs"
	desc = "Half-orcs are the result of interspecies unions between an orc and a human, with the overwhelming majority of cases involving an orc mother. Despite the barbaric nature of their blood, half-orcs are usually raised in a very traditional way, which allows them to be surprisingly intelligent for their appearance."
	languages = list(/datum/language/common)

/datum/species/vulpkanin
	desc_title = "Vendarines"
	desc = "At first glance, a vendarin can easily be mistaken for a member of the lupian race — they can appear so similar externally. Nevertheless, while lupiens are essentially the evolution of wolves, accelerated by the will of the Lady of the Night, the origin of vendarins is presumably not related to divine intervention at all. Like the Tabaxi, they appeared after the War in the Heavens on the lands now belonging to the Grenzelhoft Empire. Unlike the predominantly tribal lupiens, the main population of vendarins is concentrated in cities, where they occupy the niche of active traders, intellectuals, and the middle bourgeois class; many influential patrician families of the free cities are also vendarin."
	languages = list(/datum/language/common)

/datum/species/kobold
	desc_title = "Kobolds"
	desc = "Kobolds are a reptiloid humanoid race. Their height ranges from 70 to 120 centimeters, their skin is covered with scales of various colors, and their eye color ranges from violet to shades of orange and red. Their legs are sinewy and digitigrade. They have long clawed fingers and a jaw like a crocodile. Small white or light brown horns protrude from their heads, and their tails resemble those of rats. Researchers claim there is an undeniable connection between kobolds, draconians, and dragons — supposedly, the former are significantly degenerated distant descendants of the latter."
	origin_default = /datum/virtue/origin/racial/lirvas
	origin = "Lirvas"
	base_name = "Dragonkin"
	languages = list(/datum/language/common)

/datum/species/anthromorph
	desc_title = "Wildkins"
	desc = "The exact way mortals become beast-like is still unknown to this day. Some hybrids, quite predictably, are the result of interspecies breeding, although far more often such unions do not produce offspring at all. At the same time, beast-like children can sometimes appear even in ordinary couples — the reasons for this phenomenon remain unclear, and some call it a curse of the gods, usually attributing it to Dendor or Xailix.\
	Another source of the emergence of beast-like beings is powerful magical rituals. For example, a magical storm that destroyed the Crimson Lands turned all survivors of the catastrophe in these lands into wildkin. Considering how rare it is for a halfkin or wildkin to be born naturally, today the largest population of beast-like beings resides precisely in the Crimson Lands."
	languages = list(/datum/language/common)

/datum/species/anthromorphsmall
	desc_title = "Verminwolves"
	desc = "The exact way mortals become beast-like is still unknown to this day. Some hybrids, quite predictably, are the result of interspecies breeding, although far more often such unions do not produce offspring at all. At the same time, beast-like children can sometimes appear even in ordinary couples — the reasons for this phenomenon remain unclear, and some call it a curse of the gods, usually attributing it to Dendor or Xailix.\
	Another source of the emergence of beast-like beings is powerful magical rituals. For example, a magical storm that destroyed the Crimson Lands turned all survivors of the catastrophe in these lands into wildkin. Considering how rare it is for a halfkin or wildkin to be born naturally, today the largest population of beast-like beings resides precisely in the Crimson Lands."
	languages = list(/datum/language/common)

/datum/species/demihuman
	desc_title = "Halfkins"
	desc = "The exact way mortals become beast-like is still unknown to this day. Some hybrids, quite predictably, are the result of interspecies breeding, although far more often such unions do not produce offspring at all. At the same time, beast-like children can sometimes appear even in ordinary couples — the reasons for this phenomenon remain unclear, and some call it a curse of the gods, usually attributing it to Dendor or Xailix.\
	Another source of the emergence of beast-like beings is powerful magical rituals. For example, a magical storm that destroyed the Crimson Lands turned all survivors of the catastrophe in these lands into wildkin. Considering how rare it is for a halfkin or wildkin to be born naturally, today the largest population of beast-like beings resides precisely in the Crimson Lands."
	languages = list(/datum/language/common)

/datum/species/lizardfolk
	desc_title = "Zardmen"
	desc = "Zardmen are reptilian humanoids, which, according to some researchers, are even more degenerate descendants of the proud Drakians. Their flesh is covered with scales, the color of which ranges from dark green to shades of brown and gray. Zardmen are taller than humans and have a powerful build; their height often ranges from 6 to 7 feet. Zardmen have muscular tails that reach three to four feet in length, which are used to maintain balance. They also possess sharp claws and teeth."
	origin_default = /datum/virtue/origin/racial/lirvas
	origin = "Lirvas"
	base_name = "Dragonkin"
	languages = list(/datum/language/common)

/datum/species/lupian
	desc_title = "Lupians"
	desc = "According to ancient legends, at the beginning of time, wolves were the beloved creatures of Dendor, the First Beast. They howled at the moon every night, and their voices reached the heavens, where Nok resided. The Moon Goddess heard in the wolves' howl something more than animal instinct — she heard a longing for something unattainable, a desire for knowledge. And Nok, the mistress of knowledge and dreams, decided to answer this call. \
	On one night of the full moon, she descended to the wolf pack and touched them with her light. Those wolves who looked directly at the moon received the Lunar Gift — a spark of reason, the ability to think and speak. Their bodies changed, gaining the ability to walk on two legs, and their souls awakened to the awareness of the world.\
	This is how the first lupians appeared — wolves who became something more under the influence of Nok."
	languages = list(/datum/language/common)

/datum/species/moth
	desc_title = "Fluvianes"
	desc = "To describe this unique species, many comparisons were made with ordinary moths. From an appetite for clothing to a frighteningly insect-like appearance, the name 'moth' has become firmly established in common usage. However, this comparison does not quite accurately reflect the ability, or rather the lack thereof, to fly."
	languages = list(/datum/language/common)

/datum/species/tabaxi
	desc_title = "Tabaxi"
	desc = "Tabaxi, presumably originating from the southern regions of the Western Kingdoms, are taller than most humans, standing between six and seven feet. Their bodies are slender and covered with spotted or striped fur. Like most felines, tabaxi have long tails and retractable claws. The fur color of tabaxi ranges from light yellow to reddish-brown. Tabaxi eyes are slitted, usually green or yellow. Tabaxi are skilled swimmers, climbers, and fast runners. They have a good sense of balance and a keen sense of smell."
	origin_default = /datum/virtue/origin/zybantian
	origin = "Zybantu"
	languages = list(/datum/language/common)

/datum/species/akula
	desc_title = "Axiames"
	desc = "Axians are a proud, shark-like people whose culture is based on maritime trade, tax evasion, and piracy."
	languages = list(/datum/language/common)

/datum/species/construct/metal
	desc_title = "Constructs"
	desc = "The origin of these automatons is shrouded in mystery. The constructs themselves claim that they were originally created by Zizo, the Lady of Darkness, against the backdrop of betrayal by her closest ally, Xailix. It is unknown where the main population of constructs currently resides, and whether they truly serve the Arch-Traitoress; however, those encountered in the lands of the Western Kingdoms are free from her influence. At least, that is what they claim."
	origin_default = /datum/virtue/origin/heartfelt
	origin = "Heartfelt"
	languages = list(/datum/language/common)

/datum/species/dwarf/mountain
	desc_title = "Dwarves"
	desc = "Dwarves are one of the oldest races, born from stone, inhabitants of mountains and the deepest mines. They are known throughout the world not only for their craftsmanship and technology, but also for their persistence, relentlessness, as well as a rather bad temper and pride. The dwarves themselves call themselves akhdruki, which can be translated as heirs of the mountains. Observance of traditions and reverence for the ancients is, without exaggeration, an integral part of any dwarf's life. \
	The appearance of this race perfectly demonstrates their connection to their habitats. Dwarves are naturally short and stocky, but they possess incredible endurance, strength, unwavering resilience, and stubbornness. It is no wonder that many other races often mockingly compare them, and in the case of dwarves — embody stone or a mountain. Most dwarves have a height of only90-140 cm, however they are of sturdy build, with strong thick arms, broad shoulders, short but powerful legs, and a torso resembling a barrel. Dwarf women have a similar build, though they are much more voluptuous."
	origin_default = /datum/virtue/origin/racial/akhdruk
	origin = "Drud Akhdruk"
	languages = list(/datum/language/common)

/datum/species/goblinp
	desc_title = "Goblins"
	desc = "Goblins are a short-statured race of humanoids with large ears and usually green skin. It is believed that they originated from the blood shed as a result of the wounding of the fierce God of War Graggar by Ravox. Although most goblins still obey the call of their wicked blood, glorifying Graggar and remaining aggressive toward everyone they encounter, some of them do show free will, forming secluded enclaves where they hide from both their kin and persecution by other intelligent races. Only recently, in the past few centuries, have intelligent goblins begun leaving their isolated villages and tribes to seek their future in civilized society, striving to overcome the discrimination and distrust of the Church, states, and peoples of Grimoria."
	languages = list(/datum/language/common)
