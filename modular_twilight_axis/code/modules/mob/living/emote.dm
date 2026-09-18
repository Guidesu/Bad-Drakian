/datum/emote/living/blush
	key_third_person = "blushes"
	message = "blushes."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_blush()
	set name = "To blush"
	set category = "Emotes"

	emote("blush", intentional = TRUE)

/datum/emote/living/pray
	key_third_person = "prays"
	message = "utters a prayer."

/datum/emote/living/meditate
	key_third_person = "meditates"
	message = "meditates."

/datum/emote/living/bow
	key_third_person = "bows"
	message = "bows."
	message_param = "bows %t."

/datum/emote/living/burp
	key_third_person = "burps"
	message = "burps."
	message_muffled = "makes a muffled sound."

/datum/emote/living/choke
	key_third_person = "suffocates"
	message = "suffocates!"

/datum/emote/living/cross
	key_third_person = "crosses arms"
	message = "crosses arms."

/datum/emote/living/collapse
	key_third_person = "loses consciousness"
	message = "loses consciousness."

/datum/emote/living/whisper
	key_third_person = "whispers"
	message = "whispers."
	message_mime = "whispers something."

/datum/emote/living/cough
	key_third_person = "coughs"
	message = "coughs."

/datum/emote/living/clearthroat
	key_third_person = "clears throat"
	message = "clears throat."
	message_muffled = "makes a muffled sound."

/datum/emote/living/dance
	key_third_person = "dances"
	message = "dances."

/datum/emote/living/drool
	key_third_person = "drools"
	message = "drools."

/datum/emote/living/faint
	key_third_person = "collapses"
	message = "collapses from exhaustion."

/datum/emote/living/frown
	key_third_person = "frowns"
	message = "frowns."
	emote_type = EMOTE_VISIBLE

/datum/emote/living/gag
	key_third_person = "chokes"
	message = "chokes."

/datum/emote/living/gasp
	key_third_person = "gasps"
	message = "gasps!"
	message_muffled = "makes a muffled sound trying to scream."

/datum/emote/living/breathgasp
	key_third_person = "catches air with mouth"
	message = "catches air with mouth!"

/datum/emote/living/giggle
	key_third_person = "giggles"
	message = "giggles."

/datum/emote/living/chuckle
	key_third_person = "smirks"
	message = "smirks."


/datum/emote/living/glare
	key_third_person = "stares piercingly"
	message = "stares piercingly."
	message_param = "stares piercingly at %t."

/datum/emote/living/grin
	key_third_person = "grins"
	message = "grins."

/datum/emote/living/groan
	key_third_person = "sighs heavily"
	message = "sighs heavily."
	message_muffled = "lets out a muffled sigh."

/datum/emote/living/grimace
	key_third_person = "winces"
	message = "winces."

/datum/emote/living/jump
	key_third_person = "jumps"
	message = "jumps!"


/datum/emote/living/leap
	key_third_person = "gallops"
	message = "gallops!"

/datum/emote/living/kiss
	key_third_person = "kisses"
	message = "blows a kiss."
	message_param = "kisses %t."
	emote_type = EMOTE_VISIBLE
	use_params_for_runechat = TRUE

/datum/emote/living/lick
	key_third_person = "licks"
	message = "licks."
	message_param = "licks %t."

/datum/emote/living/spit
	key_third_person = "spits"
	message = "spits on the ground."
	message_param = "spits at %t."

/datum/emote/living/spit/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.mouth)
			if(H.mouth.spitoutmouth)
				H.visible_message(span_warning("[H] spits out [H.mouth]."))
				H.dropItemToGround(H.mouth, silent = FALSE)
			return
	..()

/datum/emote/living/hug
	key_third_person = "hugs"
	message = ""
	message_param = "hugs %t."

/datum/emote/living/slap
	key_third_person = "slaps"
	message = ""
	message_param = "slaps %t on the cheek."

/datum/emote/living/slap/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.zone_selected == BODY_ZONE_PRECISE_GROIN)
			message_param = "spanks %t' on the butt."
		else if(H.zone_selected == BODY_ZONE_PRECISE_SKULL)
			message_param = "gives %t a slap on the back of the head."
		else if(H.zone_selected == BODY_ZONE_PRECISE_L_HAND || H.zone_selected == BODY_ZONE_PRECISE_R_HAND)
			message_param = "slaps %t on the hand."
		else if(H.zone_selected == BODY_ZONE_CHEST)
			message_param = "slaps %t on the chest."
	..()

/datum/emote/living/pinch
	message = ""
	message_param = "pinches %t."

/datum/emote/living/pinch/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.zone_selected == BODY_ZONE_HEAD)
			message_param = "pinches %t on the cheek."
		else if(H.zone_selected == BODY_ZONE_PRECISE_L_HAND || H.zone_selected == BODY_ZONE_PRECISE_R_HAND)
			message_param = "pinches %t on the arm."
		else if(H.zone_selected == BODY_ZONE_CHEST)
			message_param = "pinches %t on the chest."
		else
			var/ru_zone_selected = GLOB.zone_translations[user.zone_selected]
			message_param = "pinches %t on [ru_zone_selected]."
	..()

/datum/emote/living/laugh
	key_third_person = "laughs"
	message = "laughs."
	message_mime = "laughs silently."
	message_muffled = "laughs quietly."

/datum/emote/living/look
	key_third_person = "looks"
	message = "looks."
	message_param = "examines %t."
/mob/living/carbon/human/verb/emote_look()
	set name = "To look"
	set category = "Emotes"

	emote("look", intentional = TRUE)

/datum/emote/living/nod
	key_third_person = "nods"
	message = "nods."
	message_param = "nods %t."

/datum/emote/living/point
	key_third_person = "points"
	message = "points."
	message_param = "points at %t."

/datum/emote/living/pout
	key_third_person = "sulks"
	message = "sulks."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE
/mob/living/carbon/human/verb/emote_pout()
	set name = "To sulk"
	set category = "Emotes"

	emote("pout", intentional = TRUE)

/datum/emote/living/scream
	key_third_person = "shouts"
	message = "shouts!"
	message_mime = "pretends to shout!"
	message_muffled = "makes a muffled sound attempting to scream."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/scream/painscream
	message = "screams in pain!"

/datum/emote/living/scream/strain
	message = "strains!"

/datum/emote/living/scream/agony
	message = "screams in agony!"

/datum/emote/living/haltyell
	message = "demands to stop!"

/datum/emote/living/rage
	message = "screams in rage!"

/datum/emote/living/attnwhistle
	message = "attracts attention with a whistle!"
	message_muffled = "makes a muffled sound."

/datum/emote/living/scowl
	key_third_person = "looks askance"
	message = "looks askance."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE
/mob/living/carbon/human/verb/emote_scowl()
	set name = "Looks askance"
	set category = "Emotes"

	emote("scowl", intentional = TRUE)


/datum/emote/living/shakehead
	key_third_person = "shakes head"
	message = "shakes head."

/datum/emote/living/shake
	key_third_person = "shakes head"
	message = "shakes head."

/datum/emote/living/shiver
	key_third_person = "shivers"
	message = "shivers."

/datum/emote/living/sigh
	key_third_person = "sighs"
	message = "sighs."
	message_muffled = "lets out a muted sigh."

/datum/emote/living/whistle
	key_third_person = "whistles"
	message = "whistles."
	message_muffled = "makes a muffled sound."

/datum/emote/living/hmm
	key_third_person = "snorts"
	message = "snorts."
	message_muffled = "snorts quietly."

/datum/emote/living/huh
	key_third_person = "snorts?"
	message_muffled = "makes a muffled sound."

/datum/emote/living/hum
	key_third_person = "hums"
	message = "hums."
	message_muffled = "hums quietly."

/datum/emote/living/smile
	key_third_person = "smiles"
	message = "smiles."

/datum/emote/living/carbon/clap
	key_third_person = "claps"
	message = "claps."

/datum/emote/living/sneeze
	key_third_person = "sneezes"
	message = "sneezes."
	message_muffled = "sneezes softly."

/datum/emote/living/hmph
	key = "hmph"
	key_third_person = "snorts!"
	message = "snorts!"
	message_muffled = "snorts quietly."
/mob/living/carbon/human/verb/emote_hmph()
	set name = "To snort!"
	set category = "Emotes.Noises"

	emote("hmph", intentional = TRUE)

/datum/emote/living/shh
	key_third_person = "hisses"
	message = "hisses."
	message_muffled = "hisses softly."

/datum/emote/living/smug
	key_third_person = "grins smugly"
	message = "grins smugly."
/mob/living/carbon/human/verb/emote_smug()
	set name = "To grin smugly"
	set category = "Emotes"

	emote("smug", intentional = TRUE)

/datum/emote/living/sniff
	key_third_person = "sniffs"
	message = "sniffs."
/mob/living/carbon/human/verb/emote_sniff()
	set name = "To sniff"
	set category = "Emotes"

	emote("sniff", intentional = TRUE)

/datum/emote/living/snore
	key_third_person = "snores"
	message = "snores."
	message_mime = "snores softly."

/datum/emote/living/stare
	key_third_person = "stares"
	message = "stares."
	message_param = "stares at %t."
/mob/living/carbon/human/verb/emote_stare()
	set name = "To stare"
	set category = "Emotes"

	emote("stare", intentional = TRUE)

/datum/emote/living/strech
	key_third_person = "stretches"
	message = "stretches."
/mob/living/carbon/human/verb/emote_strech()
	set name = "To stretch"
	set category = "Emotes"

	emote("stretch", intentional = TRUE)

/datum/emote/living/sway
	key = "sway"
	key_third_person = "sways"
	message = "staggering."
/mob/living/carbon/human/verb/emote_sway()
	set name = "To stagger"
	set category = "Emotes"

	emote("sway", intentional = TRUE)

/datum/emote/living/tremble
	key_third_person = "shivers"
	message = "trembling with fear!"
/mob/living/carbon/human/verb/emote_tremble()
	set name = "To tremble with fear"
	set category = "Emotes"

	emote("tremble", intentional = TRUE)

/datum/emote/living/twitch
	key_third_person = "twitching"
	message = "convulsively twitching."

/datum/emote/living/twitch_s
	message = "twitching."

/datum/emote/living/warcry
	key_third_person = "lets out a battle cry!"
	message = "shouts an inspiring battle cry!"
	message_muffled = "lets out a muffled scream."

/datum/emote/living/wave
	key_third_person = "waving"
	message = "waves."

/datum/emote/living/whimper
	key_third_person = "sobbing"
	message = "sobbing."
	message_mime = "sobbing."
	message_muffled = "sobbing quietly."

/datum/emote/living/wsmile
	key_third_person = "faintly smiling"
	message = "faintly smiling."
/mob/living/carbon/human/verb/emote_wsmile()
	set name = "To faintly smile"
	set category = "Emotes"

	emote("wsmile", intentional = TRUE)

/datum/emote/living/yawn
	key_third_person = "yawning"
	message = "yawning."
	message_muffled = "yawning quietly."

/datum/emote/living/squint
	key_third_person = "squinting"
	message = "squinting."

/datum/emote/living/snap
	key_third_person = "snapping fingers"
	message = "snaps fingers!"

/datum/emote/living/blink
	key_third_person = "blinks."
	message = "blinks."

/datum/emote/living/stomp
	key_third_person = "stomps"
	message = "stomps!"

/datum/emote/living/snap2
	key_third_person = "snaps fingers twice"
	message = "snaps fingers twice!"

/datum/emote/living/snap3
	key_third_person = "snaps fingers three times"
	message = "snaps fingers three times!"

/datum/emote/living/fsalute
	key_third_person = "extols their faith"
	message = "extols their faith."

/datum/emote/living/ffsalute
	key_third_person = "extols their faith"
	message = "extols their faith."

/datum/emote/living/carbon/human/cry
	key = "cry"
	key_third_person = "cries"
	message = "cries."
/datum/emote/living/carbon/human/cry/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.silent || !C.can_speak())
			message = "sobs. A stream of tears runs down the face."

/*
/datum/emote/living/carbon/human/sexmoanlight/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.silent || !C.can_speak())
			message = "makes a noise."
*/

/datum/emote/living/carbon/human/eyebrow
	message = "raises an eyebrow."

/datum/emote/living/carbon/human/grumble
	key_third_person = "grumbles"
	message = "grumbles."
	message_muffled = "grumbles softly."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/handshake
	message = "shakes their hand"
	message_param = "shakes the hand of %t."

/datum/emote/living/carbon/human/pale
	message = "pales for a moment."
/mob/living/carbon/human/verb/emote_pale()
	set name = "To pale"
	set category = "Emotes"

	emote("pale", intentional = TRUE)

/datum/emote/living/carbon/human/raise
	key_third_person = "raises a hand"
	message = "raises a hand."
/mob/living/carbon/human/verb/emote_raise()
	set name = "Raise a hand"
	set category = "Emotes"

	emote("raise", intentional = TRUE)

/datum/emote/living/carbon/human/salute
	key_third_person = "salutes"
	message = "salutes."
	message_param = "salutes %t."
	restraint_check = TRUE
/mob/living/carbon/human/verb/emote_salute()
	set name = "Saluting"
	set category = "Emotes"

	emote("salute", intentional = TRUE)

/datum/emote/living/carbon/human/shrug
	key_third_person = "shrugs"
	message = "shrugs."
/mob/living/carbon/human/verb/emote_shrug()
	set name = "Shrug"
	set category = "Emotes"

	emote("shrug", intentional = TRUE)

/datum/emote/living/carbon/human/wag
	key_third_person = "wags"
	message = "wags its tail."

/datum/emote/living/carbon/human/wing
	key_third_person = "flaps its wings"
	message = "flaps its wings."

/datum/emote/living/softmoan
	key = "softmoan"
	key_third_person = "moans softly"
	message = "moans softly."
	message_muffled = "moans quietly."
	emote_type = EMOTE_AUDIBLE
	show_runechat = TRUE

/mob/living/carbon/human/verb/emote_softmoan()
	set name = "Moan softly"
	set category = "Emotes.Noises"

	emote("softmoan", intentional = TRUE)

/datum/emote/living/moan
	key = "moan"
	key_third_person = "moans"
	message = "moans."
	message_muffled = "moans quietly."
	emote_type = EMOTE_AUDIBLE
	show_runechat = TRUE

/mob/living/carbon/human/verb/emote_moan()
	set name = "Moan"
	set category = "Emotes.Noises"

	emote("moan", intentional = TRUE)

/datum/emote/living/pat
	key = "pat"
	key_third_person = "strokes the head"
	message = ""
	message_param = "strokes the head of %t."
	emote_type = EMOTE_VISIBLE
	restraint_check = TRUE

/mob/living/carbon/human/verb/emote_pat()
	set name = "To stroke"
	set category = "Emotes"

	emote("pat", intentional = TRUE, targetted = TRUE)

/datum/emote/living/pat/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(ishuman(target))
		playsound(target.loc, 'sound/vo/hug.ogg', 100, FALSE, -1)

/*
/datum/emote/living/stat_roll/strength
	attempt_message_list = list(
		"tests his strength...",
		"exerts force...",
		"tenses his muscles...",
	)

	success_message_list = list(
		"demonstrates his strength!",
		"justifies having such muscles!",
		"proves that he is strong!",
	)

	failure_message_list = list(
		"hands are like branches",
		"won't even be able to lift a chair",
		"should have eaten more meat",
	)

/datum/emote/living/stat_roll/perception
	attempt_message_list = list(
		"peers very carefully...",
		"focuses his gaze...",
		"squints...",
	)

	success_message_list = list(
		"boasts eagle vision!",
		"sees what others don't see!",
		"sees the smallest detail!",
	)

	failure_message_list = list(
		"apparently suffers from nearsightedness!",
		"seems to have cataracts!",
		"blind....",
	)

/datum/emote/living/stat_roll/intelligence
	attempt_message_list = list(
		"is thinking...",
		"is drawing his eyebrows together...",
		"is scratching his chin thoughtfully...",
	)

	success_message_list = list(
		"proves that he is among one of the the smartest!",
		"proves the sharpness of his mind!",
		"knows what he is doing!",
	)

	failure_message_list = list(
		"does not understand at all where he is...",
		"head like a stalk",
		"how to add two plus two remains a mystery...",
	)

/datum/emote/living/stat_roll/constitution
	attempt_message_list = list(
		"tests his strength",
		"is preparing to strike...",
		"prepared to endure...",
	)

	success_message_list = list(
		"didn't even flinch!",
		"strong as an oak!",
		"didn’t even raise an eyebrow!",
	)

	failure_message_list = list(
		"is all skin and bones...",
		"sways like a blade of grass in the wind",
		"fragile as crystal",
	)

/datum/emote/living/stat_roll/willpower
	modifiers_list = list(
		TRAIT_TOLERANT = -1,
	)

	attempt_message_list = list(
		"tests his willpower...",
		"gathers his thoughts...",
		"ready to prove his determination...",
	)

	success_message_list = list(
		"overcomes it",
		"never gives up!",
		"will go through fire and water",
	)

	failure_message_list = list(
		"cowardly as a chicken",
		"gives up...",
		"will be scared, even if no one shouts",
	)

/datum/emote/living/stat_roll/speed
	attempt_message_list = list(
		"is preparing his best move...",
		"demonstrates his flexibility...",
		"tries to accelerate...",
	)

	success_message_list = list(
		"shows brilliant control of his body",
		"bends like a cat",
		"incredible flexibility",
	)

	failure_message_list = list(
		"seems to have two lefts",
		"outplays himself",
		"is slower than a snail...",
	)

/datum/emote/living/stat_roll/fortune
	attempt_message_list = list(
		"tries his luck...",
		"seizes the moment...",
		"weighs the bets...",
	)

	success_message_list = list(
		"could find an ingot in a puddle",
		"as if a rabbit's paw is in the pocket!",
		"glowing with true luck!",
	)

	failure_message_list = list(
		"understands that the game was a losing one from the very beginning...",
		"luck is clearly not on his side",
		"all bets are against...",
	)

/datum/emote/living/stat_roll/charisma
	attempt_message_list = list(
		"tries to maintain composure...",
		"tries to impress...",
		"ponders the next step...",
	)

	success_message_list = list(
		"is filled with unshakable confidence!",
		"- face like a stone mask",
		"... face like a god",
	)

	failure_message_list = list(
		"boiling with insecurity...",
		"is not very convincing...",
		"composure hangs on one's word of honor...",
	)
*/

/datum/emote/living/carbon/slowclap
	key_third_person = "claps"
	message = "slowly claps."

/datum/emote/living/carbon/clap1
	key_third_person = "claps"
	message = "claps hands."
