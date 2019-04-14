"SLEEP for
		 	    ENCHANTER
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"Not exactly Holiday Inn, much less the Ritz"

<GLOBAL LAST-SLEEP 0>

<CONSTANT MOVES-PER-DAY 86>
<CONSTANT MOVES-PER-SLEEP 42>

<ROUTINE V-TIME ("AUX" EL)
	 <SET EL </ ,TOD 10>>
	 <TELL "It would be " <GET ,TIME-TABLE .EL> " now." CR>>

<GLOBAL TIME-TABLE <TABLE
"just past dawn" 	;"6am"
"early morning"		;"8am"
"mid-morning"
"around noon"		;"12n"
"early afternoon"
"mid-afternoon"		;"4pm"
"early evening"
"mid evening"		;"8pm"
"late evening"
"midnight"		;"12m"
"in the early hours"
"pre-dawn"		;"4am"
"dawn">>

<OBJECT GLOBAL-SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE>
		<COND (<IN? ,WINNER ,BEDROOM>
		       <MOVE ,WINNER ,BED>)>
		<PERFORM ,V?SLEEP>
		<RTRUE>)
	       (<VERB? FIND> <TELL "Why not find a bed to sleep in?" CR>)>>
	       
<GLOBAL THIRST-COUNT 0>

<ROUTINE I-THIRST ()
	 <COND (<G? <SETG THIRST-COUNT <+ ,THIRST-COUNT 1>> 5>
		<SETG THIRST-COUNT 0>
		<QUEUE I-THIRST 40>
		<SETG WINNER ,PLAYER>
		<JIGS-UP
"You pass out from lack of water and die." <>>)
	       (T
		<TELL <GET ,THIRST-TABLE ,THIRST-COUNT> CR>
		<QUEUE I-THIRST 10>)>>

<GLOBAL THIRST-TABLE <LTABLE
"Your mouth is getting rather dry."
"You are becoming quite thirsty."
"You are very thirsty now. You'd better have a drink soon."
"Your lips are parched. If you don't get a drink soon you will pass out."
"You are beginning to feel faint from lack of water."
"BUG">>

<GLOBAL HUNGER-COUNT 0>

<ROUTINE I-HUNGER ()
	 <COND (<G? <SETG HUNGER-COUNT <+ ,HUNGER-COUNT 1>> 5>
		<SETG HUNGER-COUNT 0>
		<QUEUE I-HUNGER 47>
		<SETG WINNER ,PLAYER>
		<JIGS-UP
"You pass out from lack of strength and die." <>>)
	       (T
		<TELL <GET ,HUNGER-TABLE ,HUNGER-COUNT> CR>
		<QUEUE I-HUNGER 10>)>>

<GLOBAL HUNGER-TABLE <LTABLE
"Your stomach is starting to grumble."
"You are becoming quite hungry."
"You are very hungry now. You'd better have something to eat."
"You're fairly starving. If you don't eat soon you will pass out."
"You are beginning to feel faint from lack of sustenance."
"BUG">>

<ROUTINE I-TIRED ("AUX" (FORG <>))
	 <COND (<IN? ,WINNER ,BED>
		<TELL
"The bed sure is comfortable and you are becoming tired." CR>
		<V-SLEEP T>
		<RFATAL>)>
	 <COND (<G? ,LOAD-ALLOWED 10>
		<SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>
	 <COND (<G? ,FUMBLE-NUMBER 1>
		<SETG FUMBLE-NUMBER <- ,FUMBLE-NUMBER 1>>)>
	 <SETG FUMBLE-PROB <+ ,FUMBLE-PROB 1>>
	 <COND (<G? ,SPELL-MAX 1>
		<SETG SPELL-MAX <- ,SPELL-MAX 1>>
		<COND (<NOT <EQUAL? ,SPELL-ROOM 0>>
		       <SETG SPELL-ROOM <- ,SPELL-ROOM 1>>)>
		<COND (<EQUAL? ,SPELL-ROOM 0>
		       <SET FORG T>
		       <FORGET-SPELL ,DISPEL-SPELL>)>)>
	 <ENABLE <QUEUE I-TIRED 10>>
	 <SETG AWAKE <+ ,AWAKE 1>>
	 <COND (<G? ,AWAKE 10>
		<TELL
"You drop in your tracks from exhaustion." CR>
		<CRLF>
		<V-SLEEP>
		<RFATAL>)
	       (ELSE
		<TELL "You are " <GET ,TIRED-TELL ,AWAKE>>
		<COND (.FORG
		       <TELL
" and the spells you've memorized are becoming confused">)>
		<TELL "." CR>)>>

<GLOBAL AWAKE -1>

<ROUTINE V-DIAGNOSE ()
	 <COND (<L? ,AWAKE 0>
		<TELL "You are wide awake">)
	       (T <TELL "You are " <GET ,TIRED-TELL ,AWAKE>>)>
	 <TELL ". You are ">
	 <TELL <GET ,THIRST-TELL ,THIRST-COUNT>>
	 <TELL " and ">
	 <TELL <GET ,HUNGER-TELL ,HUNGER-COUNT>>
	 <TELL "." CR>>

<GLOBAL HUNGER-TELL <TABLE
"well fed"
"a bit hungry"
"becoming quite hungry"
"very hungry"
"fairly starving"
"faint from lack of food"
"huoo">>

<GLOBAL THIRST-TELL <TABLE
"well hydrated"
"a bit thirsty"
"quite thirsty"
"very thirsty"
"extremely thirsty"
"faint from lack of water">>

<GLOBAL TIRED-TELL <TABLE
"beginning to tire"
"feeling tired"
"worn out"
"feeling wrung out and tired"
"getting more and more tired"
"dead on your feet"
"so tired you can barely put one foot in front of another"
"practically asleep"
"moving only on your last reserves of strength"
"barely able to move your arms"
"unable to keep your eyes open for more than a few moments
at a time">>

<GLOBAL BED-WARNING <>>

<ROUTINE V-SLEEP ("OPTIONAL" (TOLD? <>) "AUX" TILL-TIRED MUNGED?)
	 <SET TILL-TIRED <- ,MOVES-PER-DAY <- ,MOVES ,LAST-SLEEP>>>
	 <COND (<EQUAL? ,HERE ,REAL-STAIR ,PIT>
		<TELL "To sleep here would be fatal!" CR>)
	       (<G? .TILL-TIRED 10>
		<TELL
"You settle down to sleep, but you really aren't tired, so you
thrash around for a while and then give up." CR>)
	       (<EQUAL? ,HERE ,ENGINE-ROOM ,CLOSET ,SE-TOWER>
		<TELL "You try to sleep but it's too noisy." CR>)
	       (<AND <EQUAL? ,HERE ,BEDROOM>
		     <NOT <IN? ,WINNER ,BED>>
		     <NOT ,BED-WARNING>
		     <NOT <G? ,AWAKE 10>>>
		<SETG BED-WARNING T>
		<TELL
"You might try getting into the bed first. It would be more comfortable." CR>)
	       (ELSE
		<COND (<AND <G? .TILL-TIRED 0>
			    <IN? ,WINNER ,BED>
			    <NOT .TOLD?>>
		       <TELL
"You're not all that tired, but the bed is very comfortable." CR>)>
		<SETG REAL-SPELL-MAX <+ ,REAL-SPELL-MAX 1>>
		<SETG SPELL-MAX ,REAL-SPELL-MAX>
		<SETG SPELL-ROOM ,SPELL-MAX>
		<SETG LAST-SLEEP ,MOVES>
		<SETG MOVES <+ ,MOVES ,MOVES-PER-SLEEP>>
		<SETG TOD <MOD <+ ,TOD ,MOVES-PER-SLEEP> 128>>
		<SETG LOAD-ALLOWED ,LOAD-MAX>
		<SETG FUMBLE-NUMBER 7>
		<SETG FUMBLE-PROB 8>
		<ENABLE <QUEUE I-TIRED ,MOVES-PER-DAY>>
		<SETG AWAKE -1>
		<FORGET-ALL>
		<SET MUNGED? <FSET? ,HERE ,RMUNGBIT>>
		<I-MUNG-ROOM <>>
		<I-MUNG-ROOM <>>
		<I-MUNG-ROOM <>>
		<COND (<AND <NOT .MUNGED?>
			    <FSET? ,HERE ,RMUNGBIT>>
		       <TELL
"You fall asleep quickly and begin to dream. The dream turns into a
nightmare of decay and desolation, as your surroundings turn grey and
lifeless. You feel a great weight, like a pile of ashes, constricting
your movements, and then you bolt awake!" CR>
		       <RTRUE>)
		      (<AND <IN? ,WINNER ,BED>
			    <NOT <IN? ,BEDPOST-BUTTON ,BED>>
			    <G? ,CHARM-POINT 0>>
		       <MOVE ,BEDPOST-BUTTON ,BED>
		       <TELL
"You fall asleep quickly, the bed being so comfortable. You dream as
well, of this very room. A beautiful damsel, obviously noble, is
standing by the bed holding a scroll in one hand and resting the other
on the bedpost. Turning to block your view, she does something you can't
see. Then she gets in bed and turns out the light, but before she does
you can see she is no longer carrying the scroll... You wake." CR>
		       <RTRUE>)>
		<TELL
"Ah, sleep! It's been a long day, indeed. The rest will do you good.
">
		<COND (<IN? ,WINNER ,BED>
		       <TELL "You make yourself comfortable on the bed">)
		      (<OUTSIDE? ,HERE>
		       <TELL "You spread your cloak under the open sky">)
		      (T <TELL "You spread your cloak on the floor">)>
		<TELL " and drift off, renewing your powers
and refreshing your mind ... Time passes as you snore blissfully." CR>
	 <CRLF>
	 <COND (<AND <OUTSIDE? ,HERE>
		     <NOT ,PROTECTED-FROM-EVIL>
		     <PROB ,MOLESTED>>
		<COND (<PROB ,MUNCHED>
		       <JIGS-UP
"You sleep blissfully, unaware of the evil creatures lurking in the
darkness. Unaware, that is, until one of them sets upon you with nasty
sharp teeth.">
		       <RFATAL>)
		      (ELSE
		       <ROB ,WINNER>
		       <ROB ,HERE>
		       <TELL
"You don't sleep too well, and you awake at least once with the feeling
that something has jostled you in the dark." CR>)>)
	       (<AND <NOT <EQUAL? ,GALLERY-POINT 0>>
		     <NOT ,GALLERY-DREAM>>
		<SETG GALLERY-DREAM T>
		<TELL
"After a while, your sleep is disturbed by a strange dream. You are
wandering in a darkened place, for you have no light or other
possessions. You feel that you are being watched! You are surrounded by
faces, their eyes following you. They drift in and out, staring at you
with proud indifference. One face, brightly lit (unlike the rest), draws
you closer and closer. As you touch it, you wake." CR>)
	       (<AND <NOT <EQUAL? ,GALLERY-POINT 0>> <PROB 70>>
		<TELL
"Your sleep is disturbed by the strange dream of an earlier night. You are
in the dark, with no light or other possessions. You are surrounded by
many faces, their eyes following you. The one brightly lit face beckons
you closer and closer. You wake, convinced that the dream holds a message
for you." CR>)
	       (<AND <NOT ,DOOR-KULCAD>
		     <NOT ,DOOR-DREAM>
		     <FSET? ,DOOR-REALITY ,INVISIBLE>>
		<SETG DOOR-DREAM T>
		<TELL
"You dream of a nondescript room in which a cartoonish figure casually opens
a simple wooden door and ascends the flight of stairs which lies behind. The
scene fades to black, but you awaken in a cold sweat." CR>)
	       (<AND ,DOOR-KULCAD <NOT ,DOOR-DREAM-2>>
		<SETG DOOR-DREAM-2 T>
		<TELL
"You dream of climbing in an unfamiliar place. You seem to climb forever,
beyond reason. A fleeting hope arises in you, and you search furiously in
your spell book and possessions for something. After a moment, you become
frantic as you realize that you don't have it! You bolt awake in a cold
sweat." CR>)
	       (<AND <NOT ,PROTECTED-FROM-EVIL>
		     <PROB 50>>
		<ROB ,HERE ,WARLOCK-TOWER>
		<COND (<PROB 50> <ROB ,WINNER ,WARLOCK-TOWER>)>
		<COND (<NOT <==? ,HERE <LOC ,WINNER>>>
		       <ROB <LOC ,WINNER> ,WARLOCK-TOWER>)>
		<TELL
"You sleep fitfully. At one point it seems that some evil presence is searching
nearby. The tense feeling passes, but it's replaced by one of foreboding." CR>)
	       (<PROB 50>
		<TELL
"You sleep uneventfully, dreamlessly, and awake refreshed." CR>)
	       (ELSE
		<TELL <PICK-ONE ,DREAMS>>
		<TELL " You awaken." CR>)>)>>

<GLOBAL DOOR-DREAM-2 <>>

<GLOBAL DOOR-DREAM <>>

<GLOBAL GALLERY-DREAM <>>

<GLOBAL MOLESTED 20>
<GLOBAL MUNCHED 45>

<GLOBAL DREAMS <LTABLE 0

"You dream of being pursued through a dank cavern. Something is behind
you, something horrible that you can't turn to face. It gets closer and
closer, and you can feel its hot breath on your neck."

"You dream of an idyllic scene in the country, a picnic of wood-sprites
and dryads."

"You dream of Krill. He works feverishly in an evilly lit workroom. He
is working a conjuration of great complexity and power, and the room is
strewn with the noisome components of this horrific casting. Krill chants
words of awful power as he works."

"You dream of dancing penguins in formal dress. One has a particularly
nice tuxedo and a cane with a gold top."

"You dream of a river, slow and muddy. Great grey hippopotami sport there,
bellowing and splashing, and twitching their ears.">>

