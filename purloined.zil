"PURLOINED for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"La Grande Illusion"

<ROOM PURLOINED-ROOM
      (IN ROOMS)
      (DESC "Guarded Door")
      (WEST TO NORTH-GATE)
      (UP TO MAP-ROOM IF DOOR-REALITY IS OPEN)
      (NORTH TO MAP-ROOM IF DOOR-REALITY IS OPEN)
      (FLAGS RLANDBIT)
      (ACTION PURLOINED-ROOM-F)
      (ADVFCN PURLOINED-ROOM-A)
      (GLOBAL DOOR-ILLUSION DOOR-REALITY)>

<OBJECT DOOR-REALITY
	(IN LOCAL-GLOBALS)
	(DESC "simple wooden door")
	(SYNONYM DOOR)
	(ADJECTIVE SIMPLE WOODEN)
	(FLAGS NDESCBIT LOCKEDBIT INVISIBLE DOORBIT CONTBIT)>

<ROOM MAP-ROOM
      (IN ROOMS)
      (DESC "Map Room")
      (LDESC
"This room in the high tower appears to be a map room, with hundreds of ancient
maps covering the walls. A huge globe, made of gold, sits on a pedestal in the
center of the room. Through the tower windows can be seen a vast forest
stretching out to the northeast and the sea, covered in fog, to the east and
south. Stairs to the south lead to the bottom of the tower.")
      (DOWN TO PURLOINED-ROOM IF DOOR-REALITY IS OPEN)
      (SOUTH TO PURLOINED-ROOM IF DOOR-REALITY IS OPEN)
      (FLAGS RLANDBIT)
      (TEXT
"Through the windows you can discern a vast forest to the northeast and the
fog-shrouded sea stretching out to the east and south.")
      (GLOBAL DOOR-REALITY WINDOW FOREST SEA)>

<OBJECT MAPS
	(IN MAP-ROOM)
	(DESC "maps")
	(SYNONYM MAPS WALL WALLS)
	(ADJECTIVE ANCIENT)
	(FLAGS NDESCBIT)
	(ACTION MAPS-F)>

<ROUTINE MAPS-F ()
	 <COND (<VERB? TAKE>
		<TELL
"Most of the maps are murals painted onto the walls. The others are securely
mounted." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The maps on the walls were made in the Elder days, when the face of the earth
was different. You can recognize the ancient cities of Galepath and Mareilon
on the shores of the Sea from your legends class at the University, but you
have trouble discerning any other places. One map shows a proud castle
standing on a cliff rising above the Sea. Largoneth it was, the once-proud
home of Entharion the Wise, King of Quendor. As you realize that this place
was the King's Map Room, you are filled with wonder at the ancient days."
CR>)>>

<OBJECT ENTHARION
	(IN GLOBAL-OBJECTS)
	(DESC "Entharion")
	(SYNONYM ENTHARION)
	(FLAGS VILLAIN)
	(ACTION ENTHARION-F)>

<ROUTINE ENTHARION-F ()
	 <COND (<VERB? EXAMINE WHO>
		<TELL
"You can remember little of the legends of Entharion the Wise. Perhaps you
should have paid more attention in Legends class." CR>)
	       (<VERB? ZIFMIA>
		<TELL
"Poor Entharion, he's been dead these many years. You would need more
than a summoning spell to get him here." CR>)>>

<OBJECT GLOBE
	(IN PEDESTAL)
	(DESC "golden globe")
	(SYNONYM GLOBE)
	(ADJECTIVE GOLD GOLDEN)
	(FLAGS NDESCBIT)
	(ACTION GLOBE-F)>

<ROUTINE GLOBE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The globe represents the world as it was thought to be in the ancient
days. Very little can be recognized of the seas or land masses." CR>)>>

<OBJECT PEDESTAL
	(IN MAP-ROOM)
	(DESC "pedestal")
	(SYNONYM PEDESTAL)
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(ACTION PEDESTAL-F)>

<ROUTINE PEDESTAL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "A globe is sitting on it." CR>)>>

<GLOBAL DOOR-ILLUSION-GONE <>>

;"A pronounced 'blue shift' (actually purple) occurs here."

<ROUTINE PURLOINED-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<NOT ,DOOR-ILLUSION-GONE>
		       <TELL
"A more incongruous place than this would be difficult to believe. The room
itself is nothing more than a small room at the base of the northeast tower
with a narrow passageway entering from the west. Standing in front of
you to the north, however, is a door surpassing anything you could have
imagined. For starters, its massive lock is wrapped in a dozen six-inch thick
iron chains. In addition, a certain five-headed monster sporting razor-sharp
spears for tongues seems to be imbedded within its heavy oak frame. One is
almost embarrassed to mention the gargoyles spewing flame and sulphurous ash
which ornament either side of the door, or the ninety-seven slimy groping
tentacles which taunt you ever closer to certain death. A sign, floating
serenely above the door and glowing hideously in purple letters, offers
the following rude understatement: ">
		       <TELL <GETP ,FLOATING-SIGN ,P?TEXT> "." CR>)
		      (T
		       <TELL
"This rather unobtrusive room at the base of the northwest tower sports a small
passageway to the west and a small, rickety door to the north
which is ">
		       <COND (<FSET? ,DOOR-REALITY ,OPENBIT>
			      <TELL "open">)
			     (T <TELL "closed">)>
		       <TELL "." CR>)>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>
		     <EQUAL? ,PRSO ,P?UP ,P?NORTH>
		     <NOT ,DOOR-ILLUSION-GONE>>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <PERFORM ,V?OPEN ,DOOR-ILLUSION>
		       <RTRUE>)
		      (T
		       <TELL "\"I'd like to, but the door's closed.\"" CR>
		       <RTRUE>)>)>> 

<OBJECT DOOR-ILLUSION
	(IN LOCAL-GLOBALS)
	(DESC "guarded door")
	(SYNONYM DOOR)
	(ADJECTIVE GUARDED OAK)
	(FLAGS VICBIT DOORBIT CONTBIT NDESCBIT)
	(ACTION DOOR-ILLUSION-F)>

<GLOBAL BEATEN-UP 0>

<GLOBAL DOOR-KULCAD <>>

<ROUTINE DOOR-ILLUSION-F ()
	 <COND (<NOT ,DOOR-ILLUSION-GONE>
		<COND (<VERB? KULCAD>
		       <TELL
"As the last syllable of the kulcad spell echoes through the chamber,
the door itself seems to dissolve. Slowly at first, then quickly, each
of its rather unlovely ornaments turns pale, then transparent, then -
nothing! What remains is a simple, wooden door which is standing shut.
You move hesitantly toward the door. Nothing. You pause for
a moment to regain your composure." CR>
		       <SETG DOOR-KULCAD T>
		       <FSET ,DOOR-ILLUSION ,INVISIBLE>
		       <FCLEAR ,DOOR-REALITY ,INVISIBLE>
		       <FCLEAR ,DOOR-REALITY ,OPENBIT>
		       <FCLEAR ,DOOR-REALITY ,LOCKEDBIT>
		       <SETG DOOR-ILLUSION-GONE T>
		       <REMOVE ,MONSTERS-1>
		       <REMOVE ,MONSTERS-2>
		       <REMOVE ,MONSTERS-3>)
		      (<AND <VERB? SHOW>
			    <EQUAL? ,PRSI ,ADVENTURER>>
		       <PERFORM ,V?POINT ,PRSO>
		       <RTRUE>)
		      (<AND <VERB? POINT>
			    <IN? ,ADVENTURER ,HERE>>
		       <SETG ADVENTURER-STAY T>
		       <COND (,ADVENTURER-CHARMED
			      <TELL
"As you motion toward the monstrous door, the adventurer follows the imaginary
line which proceeds thence from your outstretched arm." CR CR>
			      <NO-ILLUSIONS>
			      <RTRUE>)
			     (T
			      <TELL
"The adventurer seems frightened, and he backs up toward the door." CR>)>)
		      (<VERB? OPEN RUB UNLOCK MUNG KILL ATTACK KNOCK>
		       <COND (<G? <SETG BEATEN-UP <+ ,BEATEN-UP 1>> 4>
			      <JIGS-UP
"You've really gotten those tentacles in an uproar. Sixty-three of them
grab you and pull in sixty-three different directions. Not good for the
digestion.">
			      <RTRUE>)>
		       <TELL <PICK-ONE ,ILLUSION-HACKS> CR>
		       <PUTP ,FLOATING-SIGN
			     ,P?TEXT
			     <PICK-ONE ,SIGN-TEXTS>>
		       <RTRUE>)
		      (<VERB? REZROV>
		       <TELL
"As you cast the rezrov spell, the door shudders briefly, and
a few tentacles pause in their unending motion. The two gargoyles look
at each other, perplexed. After a tense moment, the sign above the door
flashes briefly: \"Fat Chance\"." CR>)>)>>

<GLOBAL SIGN-TEXTS <LTABLE 0 
"\"Give Up\"" "\"Go Away\"" "\"Had Enough?\"">>

<OBJECT FLOATING-SIGN
	(IN PURLOINED-ROOM)
	(DESC "sign")
	(SYNONYM SIGN LETTER)
	(ADJECTIVE FLOATING PURPLE)
	(FLAGS READBIT NDESCBIT)
	(TEXT "\"Don't Bother\"")>

<OBJECT MONSTERS-1
	(IN PURLOINED-ROOM)
	(DESC "monster")
	(SYNONYM MONSTER TENTACLE GARGOYLE DRAGON)
	(ADJECTIVE FIVE-HEADED GROPING SLIMY)
	(FLAGS NDESCBIT VICBIT)
	(ACTION DOOR-ILLUSION-F)>

<OBJECT MONSTERS-2
	(IN PURLOINED-ROOM)
	(DESC "iron chain")
	(SYNONYM CHAIN CHAINS)
	(ADJECTIVE SIX-INCH THICK IRON HEAVY)
	(FLAGS NDESCBIT VICBIT VOWELBIT)
	(ACTION DOOR-ILLUSION-F)>

<OBJECT MONSTERS-3
	(IN PURLOINED-ROOM)
	(DESC "spear")
	(SYNONYM SPEAR SPEARS TONGUE)
	(FLAGS NDESCBIT VICBIT)
	(ACTION DOOR-ILLUSION-F)>

<GLOBAL ILLUSION-HACKS <LTABLE 0
"Two, or perhaps three, monster heads reach out for you, spearing
you in the process."
"One of the gargoyles spits in your direction, burning your arm
with incendiary byproducts."
"Three or four tentacles grab you briefly and send you flying."
"You manage to reach one of the iron chains before it turns into
a pair of teeth and bites you."
"The floating sign, once serene, knocks you delicately over the head."
"The door opens, and nineteen demons, each a cross between
a carrot and a sledge hammer, march out from behind it, knock you
senseless, and return, the last closing the door behind it.">> 

;"Parlor magic, this time with mirrors"

<ROOM MIRROR-HALL-1
      (IN ROOMS)
      (DESC "Hall of Mirrors One")
      (WEST TO NW-TOWER)
      (EAST TO MIRROR-HALL-2)
      (FLAGS RLANDBIT)
      (COUNT 1)
      (ACTION MIRROR-HALL-F)
      (GLOBAL ADVENTURER-LG MIRROR MIRROR-STUFF SHARDS)>

<OBJECT GLOBAL-ADVENTURER
	;(IN GLOBAL-OBJECTS)
	(SYNONYM ADVENTURER)
	(DESC "adventurer")
	(ACTION GLOBAL-ADVENTURER-F)
	(FLAGS VOWELBIT)>

<ROOM MIRROR-HALL-2
      (IN ROOMS)
      (DESC "Hall of Mirrors Two")
      (WEST TO MIRROR-HALL-1)
      (EAST TO MIRROR-HALL-3)
      (FLAGS RLANDBIT)
      (COUNT 2)
      (ACTION MIRROR-HALL-F)
      (GLOBAL ADVENTURER-LG MIRROR MIRROR-STUFF SHARDS)>

<ROOM MIRROR-HALL-3
      (IN ROOMS)
      (DESC "Hall of Mirrors Three")
      (WEST TO MIRROR-HALL-2)
      (EAST TO MIRROR-HALL-4)
      (FLAGS RLANDBIT)
      (COUNT 3)
      (ACTION MIRROR-HALL-F)
      (GLOBAL ADVENTURER-LG MIRROR MIRROR-STUFF SHARDS)>

<ROOM MIRROR-HALL-4
      (IN ROOMS)
      (DESC "Hall of Mirrors Four")
      (WEST TO MIRROR-HALL-3)
      (EAST TO NORTH-GATE)
      (FLAGS RLANDBIT)
      (COUNT 4)
      (ACTION MIRROR-HALL-F)
      (GLOBAL ADVENTURER-LG MIRROR MIRROR-STUFF SHARDS)>

<OBJECT MIRROR
	(IN LOCAL-GLOBALS)
	(DESC "mirror")
	(SYNONYM MIRROR)
	(FLAGS NDESCBIT VICBIT)
	(ACTION MIRROR-F)>

<ROUTINE MIRROR-F ()
	 <COND (<FSET? ,HERE ,NDESCBIT>
		<COND (<VERB? KREBF>
		       <FCLEAR ,HERE ,NDESCBIT>
		       <TELL
"Shards of glass fly into the air, solving a jigsaw puzzle of a million
pieces. The mirror is repaired!" CR>)
		      (ELSE
		       <TELL
"There's no mirror left here after the way you treated it." CR>)>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"The scene behind the \"mirror\" is an underground landscape.">
		<COND (<NOT <FSET? ,ADVENTURER-LG ,INVISIBLE>>
		       <TELL " A weary
adventurer is standing there, dejected.">)>
		<CRLF>)
	       (<VERB? MUNG ATTACK>
		<TELL
"The mirror here smashes into tiny shards. Behind the mirror is a bare
rock wall." CR>
		<NO-MORE-ADVENTURER>
		<FSET ,HERE ,NDESCBIT>)>>

<OBJECT SHARDS
	(IN LOCAL-GLOBALS)
	(DESC "shards of glass")
	(SYNONYM GLASS SHARDS)
	(FLAGS NDESCBIT)
	(ACTION SHARDS-F)>

<ROUTINE SHARDS-F ()
	 <COND (<NOT <FSET? ,HERE ,NDESCBIT>>
		<TELL "There are no shards of glass here...yet." CR>)
	       (<VERB? TAKE MOVE PUT RUB>
		<TELL "You would slice your fingers on them." CR>)>>		

<GLOBAL MIRROR-HALL-TBL1 <LTABLE
"This is the western end of the"
"This is a spot within the long"
"This is a spot within the long"
"This is the eastern end of the">>

<ROUTINE MIRROR-HALL-F (RARG "AUX" RM)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL <GET ,MIRROR-HALL-TBL1 <SET RM <GETP ,HERE ,P?COUNT>>>>
		<COND (<FSET? ,HERE ,NDESCBIT>
		       <TELL " Hall of Mirrors. Where there used to be a large
mirror mounted on the wall is only an empty frame. Shards of mirror cover the
floor." CR>)
		      (T
		       <TELL " Hall of Mirrors. The hall itself is
astounding and not a little bit confusing. To be sure, its northern wall is
glass, but it does not seem to reflect anything within the hall. Rather, it
seems to be a window on another world. This other world appears to be a large
underground labyrinth, filled with tunnels, caves, and peculiar rock
formations." CR>)>
		<COND (,ADVENTURER-LOC
		       <DESCRIBE-ADVENTURER>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,GLOBAL-ADVENTURER ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,HERE ,NDESCBIT>>
		     <NOT ,ADVENTURER-SUMMONED>
		     <FSET? ,ADVENTURER-LG ,INVISIBLE>
		     <PROB 15>>
		<SETG ADVENTURER-LOC ,HERE>
		<ENABLE <QUEUE I-LG-ADVENTURER -1>>
		<TELL
"From the other side of the \"mirror\" a bedraggled adventurer comes into
view, carrying a brass lantern and an elvish sword, which is glowing dimly.
He stops and stares in your direction." CR>
		<SETG ADVENTURER-SEEN T>
		<FCLEAR ,ADVENTURER-LG ,INVISIBLE>)>>

<OBJECT MIRROR-STUFF
	(IN LOCAL-GLOBALS)
	(DESC "mirror environment")
	(SYNONYM CAVE TUNNEL FORMATION LABYRINTH)
	(ADJECTIVE ROCK)
	(ACTION MIRROR-STUFF-F)>

<ROUTINE MIRROR-STUFF-F ()
	 <COND (<FSET? ,HERE ,NDESCBIT>
		<GLOBAL-NOT-HERE-PRINT ,MIRROR-STUFF>)
	       (<VERB? EXAMINE>
		<TELL
"The scene is an underground world, quite dissimilar from your own." CR>)>>

<GLOBAL ADVENTURER-SEEN <>>

<ROUTINE NO-MORE-ADVENTURER ()
	 <FSET ,ADVENTURER-LG ,INVISIBLE>
	 <SETG ADVENTURER-LOC <>>
	 <QUEUE I-LG-ADVENTURER 0>
	 <RTRUE>>

<ROUTINE I-LG-ADVENTURER ()
	 <COND (<OR ,ADVENTURER-SUMMONED
		    <NOT <EQUAL? ,HERE ,ADVENTURER-LOC>>>
		<NO-MORE-ADVENTURER>
		<RFALSE>)
	       (<PROB 25>
		<TELL
"The adventurer, after checking his compass, walks off." CR>
		<NO-MORE-ADVENTURER>
		<RTRUE>)>> 

<GLOBAL ADVENTURER-LOC <>>

<GLOBAL ADVENTURER-SUMMONED <>>

<GLOBAL ADVENTURER-FEEBLES <LTABLE 0
"stares in your direction but seems not to see you"
"is combing his hair"
"is wandering around his surroundings, seemingly lost"
"is deep in thought">>

<ROUTINE DESCRIBE-ADVENTURER ()
	 <TELL
"A bedraggled adventurer, carrying a brass lantern and a dimly glowing elvish
sword, can be seen through the \"mirror\". He ">
	 <TELL <PICK-ONE ,ADVENTURER-FEEBLES> "." CR>>

<OBJECT ADVENTURER-LG
	(IN LOCAL-GLOBALS)
	(DESC "adventurer")
	(SYNONYM ADVENTURER PERSON)
	(ADJECTIVE WEARY BEDRAGGLED)
	(FLAGS NDESCBIT VOWELBIT INVISIBLE)
	(ACTION ADVENTURER-LG-F)>

<ROUTINE GLOBAL-ADVENTURER-F ()
	 <COND (<VERB? ZIFMIA>
		<NO-ZIF>)
	       (<AND <VERB? FOLLOW> ,ADVENTURER-SUMMONED>
		<COND (<EQUAL? ,ADV-OLD-LOC ,HERE>
		       <GOTO ,ADV-NEW-LOC>
		       <RTRUE>)
		      (T
		       <TELL "You have lost track of him." CR>)>)
	       (T
		<GLOBAL-NOT-HERE-PRINT ,GLOBAL-ADVENTURER>
		<RTRUE>)>> 

<ROUTINE ADVENTURER-LG-F ()
	 <COND (<VERB? EXAMINE>
		<DESCRIBE-ADVENTURER>)
	       (<VERB? WAVE-AT>
		<TELL "He doesn't seem to notice your gesture." CR>)
	       (<VERB? ZIFMIA>
		<TELL
"All at once, the bedraggled adventurer appears before you, brightly glowing
sword in hand. His jaw has dropped and his eyes are bulging. His eyes dart
this way and that, as if looking for a way to escape." CR>
		<SETG SCORE <+ ,SCORE ,SUMMON-POINT>>
		<SETG SUMMON-POINT 0>
		<MOVE ,ADVENTURER ,HERE>
		<SETG ADVENTURER-SUMMONED T>
		<SETG ADVENTURER-STAY T>
		<ENABLE <QUEUE I-ADVENTURER -1>>
		<THIS-IS-IT ,ADVENTURER>
		<RTRUE>)
	       (<VERB? CLEESH>
		<TELL
"The spell has no effect, perhaps because he isn't here." CR>)
	       (<VERB? GUNCHO>
		<TELL
"Behind the \"mirror\", the luckless adventurer seems to fade away.
He shimmers briefly and then vanishes without a trace." CR>
		<NO-MORE-ADVENTURER>
		<SETG ADVENTURER-SUMMONED T>)>>

<OBJECT ADVENTURER
	(DESC "adventurer")
	(SYNONYM ADVENTURER PERSON)
	(ADJECTIVE BEDRAGGLED WEARY)
	(FLAGS VICBIT VILLAIN VOWELBIT CONTBIT OPENBIT)
	(DESCFCN ADVENTURER-D)
	(CONTFCN ADVENTURER-C)
	(CAPACITY 100)
	(ACTION ADVENTURER-F)>

<ROUTINE ADVENTURER-C ()
	 <COND (<VERB? TAKE>
		<PERFORM ,V?ASK-FOR ,ADVENTURER ,PRSO>
		<RTRUE>)
	       (<VERB? READ>
		<COND (<NOT ,ADVENTURER-CHARMED>
		       <TELL
"The adventurer pulls back as you approach." CR>)
		      (T
		       <TELL
"The adventurer moves closer so that you might read it." CR>
		       <RFALSE>)>)>>

<ROUTINE ADVENTURER-D (RARG)
	 <TELL 
"There is a bedraggled and weary adventurer standing here. He is carrying
">
	 <PRINT-CONTENTS ,ADVENTURER>
	 <COND (,ADVENTURER-CHARMED
		<TELL ".
He seems pleased to see you and frequently smiles in your direction">)>
	 <TELL "." CR>>

<OBJECT LANTERN
	(IN ADVENTURER)
	(DESC "brass lantern")
	(SYNONYM LANTERN)
	(ADJECTIVE BRASS)
	(FLAGS LIGHTBIT ONBIT TAKEBIT)>

<OBJECT SWORD
	(IN ADVENTURER)
	(DESC "sword")
	(SYNONYM SWORD)
	(ADJECTIVE ELVISH)
	(FLAGS WEAPONBIT)
	(ACTION SWORD-F)>

<ROUTINE SWORD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The sword is of elvish workmanship and is glowing brightly." CR>)>>

<ROUTINE ADVENTURER-ACTOR ()
	 <COND (<VERB? FOLLOW>
		<COND (,ADVENTURER-CHARMED
		       <TELL
"\"Sorry, but I've got better things to do than follow you.\"" CR>)
		      (T
		       <TELL
"\"I'd sooner follow Dimwit Flathead!\"" CR>)>)
	       (<VERB? EXAMINE>
		<COND (<NOT ,ADVENTURER-CHARMED>
		       <TELL
"He glances suspiciously at it." CR>)
		      (<EQUAL? ,PRSO ,DOOR-ILLUSION>
		       <TELL "\"It's a door.\"" CR>)
		      (ELSE
		       <TELL "\"It's " A ,PRSO ".\"" CR>)>)
	       (<AND <VERB? OPEN THROUGH>
		     <EQUAL? ,PRSO ,DOOR-ILLUSION>>
		<COND (,ADVENTURER-CHARMED
		       <SETG WINNER ,PLAYER>
		       <SETG HERE <LOC ,WINNER>>
		       <PERFORM ,V?POINT ,DOOR-ILLUSION>
		       <RTRUE>)
		      (ELSE
		       <TELL
"The adventurer looks at you suspiciously. \"Can't you open it
yourself?\"" CR>)>)
	       (<VERB? HELLO>
		<COND (,ADVENTURER-CHARMED
		       <TELL "\"Hello. Nice to meet you.\"" CR>)
		      (,PRSO
		       <TELL "The " D ,PRSO " steps away from you." CR>)
		      (T
		       <TELL "The adventurer steps warily away." CR>)>)
	       (<AND <VERB? UNTIE>
		     <EQUAL? ,PRSO ,MAGIC-ROPE>
		     ,ADVENTURER-CHARMED>
		<TELL
"The adventurer tries to untie the rope, but he only becomes entangled.
He gives up and glares suspiciously at you." CR>)
	       (<AND <VERB? MUNG ATTACK> <EQUAL? ,PRSO ,DOOR-ILLUSION>>
		<TELL
"He pauses as if searching for the right thing to say. \"I've known strange
people, but fighting a wooden door?\"" CR>)
	       (<AND <VERB? CUT MUNG>
		     <EQUAL? ,PRSO ,MAGIC-ROPE>>
		<COND (<NOT ,ADVENTURER-CHARMED>
		       <TELL
"\"Not bloody likely! There's magic there!\"" CR>)
		      (<NOT ,ROPE-MAGIC?>
		       <ROPE-DISSOLVES>
		       <MOVE ,JEWELLED-BOX ,ADVENTURER>
		       <MOVE ,PROTECTION-SCROLL <LOC ,ADVENTURER>>
		       <TELL
"The adventurer draws his sword and slices the rope cleanly into so
much fluff. He opens the box, revealing a scroll! He drops this on
the ground disdainfully but retains the box." CR>)
		      (<OR <NOT ,PRSI> <EQUAL? ,PRSI ,SWORD>>
		       <TELL
"\"Ooo! Nice idea!\" He slashes at the rope with his sword, but to no
avail. The rope is impervious to the magic of this weapon! He looks
crestfallen." CR>)
		      (ELSE <TELL "\"I doubt that would work.\"" CR>)>)
	       (<VERB? SGIVE SSHOW> <RFALSE>)
	       (<AND <VERB? GIVE SHOW> <EQUAL? ,PRSI ,ME>>
		<COND (<VERB? GIVE>
		       <PERFORM ,V?ASK-FOR ,ADVENTURER ,PRSO>)
		      (,ADVENTURER-CHARMED
		       <TELL "The " D ,ADVENTURER
" allows you a quick look at the " D ,PRSO "." CR>)
		      (T
		       <TELL "The " D ,ADVENTURER
" gives you a suspicious look and attempts to conceal his possessions." CR>)>
		<RTRUE>)
	       (T
		<TELL
"\"I'll do what I please, thank you.\"" CR>)>>

<ROUTINE ADVENTURER-F ()
	 <COND (<EQUAL? ,WINNER ,ADVENTURER>
		<ADVENTURER-ACTOR>)
	       (<VERB? WAVE-AT>
		<COND (,ADVENTURER-CHARMED
		       <TELL "The adventurer waves right back." CR>)
		      (T <TELL "The adventurer steps back a few paces." CR>)>)
	       (<VERB? FOLLOW>
		<TELL "He's right here!" CR>)
	       (<VERB? ATTACK KILL>
		<SETG ADVENTURER-CHARMED <>>
		<JIGS-UP
"The adventurer, startled momentarily, fights back with surprising skill.
In fact, his skill is much greater than your own, and he quickly dispatches
you.">)
	       (<VERB? NITFOL>
		<TELL
"He already speaks your language, but now a bit better." CR>)
	       (<VERB? GUNCHO>
		<TELL
"The adventurer blurs as though you were seeing him from a distance, wavers
like a mirage, and then vanishes." CR>
		<REMOVE ,ADVENTURER>
		<QUEUE I-ADVENTURER 0>)
	       (<VERB? FROTZ>
		<TELL
"The adventurer is now bathed in light, much to his amazement." CR>
		<SETG ADVENTURER-CHARMED <>>
		<FSET ,ADVENTURER ,LIGHTBIT>
		<FSET ,ADVENTURER ,ONBIT>)
	       (<VERB? VAXUM>
		<SETG ADVENTURER-STAY T>
		<SETG ADVENTURER-CHARMED T>
		<ENABLE <QUEUE I-ADVENTURER-UNCHARM 20>>
		<TELL
"The adventurer smiles at you with an air of good will." CR>)
	       (<VERB? HELLO>
		<COND (,ADVENTURER-CHARMED
		       <TELL "The " D ,PRSO
" waves back and says \"Hello!\"" CR>)
		      (T
		       <TELL "The " D ,PRSO
" keeps his distance, eyeing you cautiously." CR>)>)
	       (<VERB? SEARCH>
		<TELL "The " D ,PRSO
" isn't inclined to allow himself to be searched." CR>)
	       (<VERB? MUNG>
		<TELL "The " D ,PRSO
" dodges your blow and becomes very wary of you." CR>
		<SETG ADVENTURER-CHARMED <>>
		<RTRUE>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ADVENTURER>>
		<COND (<NOT ,ADVENTURER-CHARMED>
		       <TELL "The " D ,PRSI
" eyes you suspiciously. Why, he thinks, is this sorcerer
handing me something">
		       <COND (<FSET? ,PRSO ,TREASURE>
			      <TELL ", especially something valuable">)>
		       <TELL "?" CR>)
		      (<AND ,SAILOR? <L? <- ,MOVES ,SAILOR?> 2>>
		       <MOVE ,PRSO ,ADVENTURER>
		       <TELL
"A wide smile comes over his face as he takes the " D ,PRSO ", as though
your action resolved for him some great mystery." CR>)
		      (<FSET? ,PRSO ,TREASURE>
		       <TELL "The " D ,PRSI
" gratefully accepts the offer of the " D ,PRSO ". He is fascinated by
its beauty and stops to thank you." CR>
		       <MOVE ,PRSO ,ADVENTURER>)
		      (T
		       <TELL "The " D ,PRSI
" refuses your offer politely." CR>)>)
	       (<AND <VERB? SHOW>
		     <EQUAL? ,PRSI ,ADVENTURER>>
		<COND (<NOT ,ADVENTURER-CHARMED>
		       <TELL "He ignores you pointedly." CR>)
		      (<EQUAL? ,PRSO ,DOOR-ILLUSION>
		       <RFALSE> ;"let DOOR-ILLUSION-F handle it")
		      (<FSET? ,PRSO ,TREASURE>
		       <TELL
"His eyes light up at the sight of the " D ,PRSO "." CR>
		       <SETG ADVENTURER-STAY T>)
		      (T
		       <TELL
"He yawns briefly, indicating his disinterest." CR>)>)
	       (<AND <VERB? TAKE> <EQUAL? ,PRSI ,ADVENTURER>>
		<PERFORM ,V?ASK-FOR ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE I-ADVENTURER-UNCHARM ()
	 <SETG ADVENTURER-CHARMED <>>
	 <COND (<IN? ,ADVENTURER ,HERE>
		<TELL
"The adventurer looks at you as if seeing you for the first time. It's
not clear that he likes what he sees, either." CR>)>>

;"Here's how the adventurer comports himself"

<GLOBAL ADVENTURER-MOVE -1>

<ROUTINE I-ADVENTURER ("AUX" L NL)
	 <SET L <LOC ,ADVENTURER>>
	 <COND (<FSET? .L ,ONBIT>
		<FCLEAR ,LANTERN ,ONBIT>)
	       (ELSE
		<FSET ,LANTERN ,ONBIT>)>
	 <SETG ADVENTURER-MOVE <+ ,ADVENTURER-MOVE 1>>
	 <COND (<EQUAL? ,ADVENTURER-MOVE 0>
		<RTRUE>)
	       (<APPLY <GETP .L ,P?ADVFCN>>
		<RTRUE>)
	       (,ADVENTURER-STAY
		<SETG ADVENTURER-STAY <>>
		<COND (<AND <EQUAL? ,HERE .L> ,ADVENTURER-CHARMED> ;"6/27"
		       <TELL "The adventurer"
			     <PICK-ONE ,ADVENTURER-LOITERS> CR>)>)
	       (<OR <EQUAL? .L ,MIRROR-HALL-1 ,MIRROR-HALL-2 ,MIRROR-HALL-3>
		    <EQUAL? .L ,MIRROR-HALL-4 ,NORTH-GATE>>
		<COND (<TREASURE-HERE? <SET NL <NEXT-HALL .L T>>>
		       <RETURN <MOVE-ADVENTURER .NL>>)
		      (<L? ,ADVENTURER-MOVE 5>
		       <RETURN <MOVE-ADVENTURER <NEXT-HALL .L <>>>>)
		      (T <RETURN <ADVENTURER-DECIDE .L>>)>)
	       (<AND <PROB 25> <EQUAL? ,HERE .L>>
		<TELL "The adventurer ">
		<COND (,ADVENTURER-CHARMED
		       <COND (<AND <NOT ,SAILOR?> <PROB 16>>
			      <SETG SAILOR? ,MOVES>
			      <TELL
"waves at you and asks \"Hello, Sailor?\" Strange, you've never even been
to sea." CR>)
			     (T
			      <TELL <PICK-ONE ,ADVENTURER-NICE> CR>)>)
		      (T
		       <TELL <PICK-ONE ,ADVENTURER-QUIPS> CR>)>)
	       (<ADVENTURER-TAKE .L>
		<SETG ADVENTURER-STAY <>>
		<RTRUE>)
	       (T
		<COND (<AND <NOT ,ADV-HASTE> <EQUAL? ,HASTED? ,ADVENTURER>>
		       <SETG ADV-HASTE T>
		       <ADVENTURER-DECIDE .L>
		       <I-ADVENTURER>)
		      (T
		       <SETG ADV-HASTE <>>
		       <ADVENTURER-DECIDE .L>)>
		<RTRUE>)>>

<GLOBAL ADVENTURER-LOITERS <LTABLE 0
" eyes your possessions intently."
", not overly tactful, asks to see what you're holding."
" asks what you would be needing treasures for."
" offers to relieve you of some of your possessions.">>

<GLOBAL ADV-HASTE <>>

<GLOBAL SAILOR? <>> ;"becomes ,MOVES when he says hello sailor to you"

<GLOBAL ADVENTURER-NICE <LTABLE 0
"smiles at you like an idiot."
"pulls out his map, a convoluted collection of lines, arrows, and
boxes, and checks it briefly."
"stares at his possessions as if expecting a revelation."
"tries to make some small talk, but he only mumbles. He'll have to speak
up if he expects you to hear him."
"asks for directions to Flood Control Dam #3.">>

<GLOBAL ADVENTURER-QUIPS <LTABLE 0
"pulls out his map, a convoluted collection of lines, arrows, and
boxes, and checks it briefly."
"stares at his possessions as if expecting a revelation."
"tries to make some small talk, but only mumbles. He'll have to speak
up if he expects you to hear him."
"waves his sword menacingly in your direction."
"fends you off with his sword."
"attempts to eat his sword. I don't think it would agree with him.">>

<ROUTINE MOVE-ADVENTURER (RM "AUX" L (CNT 0) OBJ DIR)
	 <SET L <LOC ,ADVENTURER>>
	 <COND (<AND <EQUAL? .L ,NORTH-GATE>
		     <EQUAL? .RM ,PURLOINED-ROOM>
		     <NOT <TREASURE-HERE? .RM>>>
		<FSET ,PURLOINED-ROOM ,VILLAIN>
		<COND (<EQUAL? ,HERE .L>
		       <TELL
"The adventurer starts toward the east but, seeing nothing of interest,
changes his mind." CR>)>
		<RTRUE>)
	       (<EQUAL? .RM ,TEMPLE>
		<COND (<EQUAL? ,HERE .L>
		       <TELL
"The adventurer looks as if he might go into the temple, but then he thinks
better of it." CR>)>
		<FSET ,TEMPLE ,VILLAIN>
		<RTRUE>)
	       (<EQUAL? .RM ,T-A>
		<COND (<EQUAL? ,HERE .L>
		       <TELL
"The adventurer starts to descend further, but chickens out. He won't make
Dungeon Master at that rate!" CR>)>
		<FSET ,T-A ,VILLAIN>
		<SET RM ,DIM-DESCENT>)
	       (<EQUAL? .RM ,WEST-CASTLE>
		<COND (<EQUAL? ,HERE .L>
		       <TELL
"The adventurer peers through the gate, but he decides against passing
through." CR>)>
		<FSET ,WEST-CASTLE ,VILLAIN>
		<SET RM ,COURTYARD-1>)>
	 <COND (<EQUAL? ,HERE .L>
		<TELL "The adventurer ">
		<COND (<EQUAL? ,HASTED? ,ADVENTURER>
		       <TELL "rockets out of">)
		      (T <TELL "leaves">)>
		<TELL " the room">
		<COND (<SET OBJ <DOOR-FROM? .L .RM>>
		       <TELL " through the " D .OBJ>)>
	        <TELL ", heading ">
		<SET DIR <DIR-FROM .L .RM>>
		<COND (<NOT <EQUAL? .DIR ,P?UP ,P?DOWN>>
		       <TELL "to ">)>
		<DIR-PRINT .DIR>
		<SETG ADV-NEW-LOC .RM>
		<SETG ADV-OLD-LOC .L>
		<TELL "." CR>)
	       (<EQUAL? ,HERE .RM>
		<COND (<AND <EQUAL? ,HERE ,PURLOINED-ROOM>
			    <NOT <FSET? ,MAP-ROOM ,VILLAIN>>
			    <TREASURE-HERE? ,HERE>>
		       <TELL
"An adventurer peeks into the room, sees the " D <TREASURE-HERE? ,HERE>
", and enters." CR>)
		      (T
		       <TELL
"A bedraggled adventurer ">
		       <COND (<EQUAL? ,HASTED? ,ADVENTURER>
			      <TELL "speeds">)
			     (T <TELL "walks">)>
		       <TELL " into the room from ">
		       <DIR-PRINT <DIR-FROM .RM .L>>
		       <COND (<SET OBJ <DOOR-FROM? .RM .L>>
			      <TELL ", coming through the " D .OBJ>)>
		       <TELL "." CR>)>)>
	 <MOVE ,ADVENTURER .RM>
	 <FSET .RM ,VILLAIN>
	 <COND (<NOT <EQUAL? .RM ,PURLOINED-ROOM>>
		<ADVENTURER-TAKE .RM>)>>

<ROUTINE DOOR-FROM? (HERE THERE "AUX" P L TX)
	 <SET P 0>
	 <REPEAT ()
		 <COND (<0? <SET P <NEXTP .HERE .P>>>
			<RFALSE>)
		       (<NOT <L? .P ,LOW-DIRECTION>>
			<SET TX <GETPT .HERE .P>>
			<SET L <PTSIZE .TX>>
			<COND (<AND <EQUAL? .L ,DEXIT>
				    <==? <GETB .TX ,REXIT> .THERE>>
			       <RETURN <GETB .TX ,DEXITOBJ>>)>)>>>

<GLOBAL ADV-NEW-LOC <>>
<GLOBAL ADV-OLD-LOC <>>

<ROUTINE ADVENTURER-TAKE (RM "AUX" F N (TR <>) (CNT 0) OBJ)
	 <SET F <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<SET N <NEXT? .F>>
			<COND (<AND <FSET? .F ,TAKEBIT>
				    <NOT <FSET? .F ,INVISIBLE>>
				    <NOT <EQUAL? .F ,STRONG-BOX>>
				    <OR <FSET? .F ,TREASURE>
					<PROB 25>>>
			       <COND (<NOT <APPLY <GETP .F ,P?ADVFCN>>>
				      <MOVE .F ,ADVENTURER>
				      <SET CNT <+ .CNT 1>>
				      <SET OBJ .F>
				      <COND (<FSET? .F ,TREASURE>
					     <SET TR T>)>)>)>
			<SET F .N>)>>
	 <COND (<AND <EQUAL? ,HERE .RM> <G? .CNT 0>>
		<TELL
"The adventurer stoops over and picks up ">
		<COND (<EQUAL? .CNT 1>
		       <TELL "the " D .OBJ>)
		      (T
		       <TELL "some objects">)>
		<COND (.TR
		       <TELL " and seems pleased
by his discovery">)>
		<TELL "." CR>)>>

<ROUTINE DIR-FROM (HERE THERE "AUX" P L TX O)
	 #DECL ((HERE THERE O) OBJECT (P L) FIX)
	 <SET P 0>
	 <REPEAT ()
		 <COND (<0? <SET P <NEXTP .HERE .P>>>
			<RFALSE>)
		       (<EQUAL? .P ,P?IN ;,P?OUT> T)
		       (<NOT <L? .P ,LOW-DIRECTION>>
			<SET TX <GETPT .HERE .P>>
			<SET L <PTSIZE .TX>>
			<COND (<AND <EQUAL? .L ,DEXIT ,UEXIT ,CEXIT>
				    <==? <GETB .TX ,REXIT> .THERE>>
			       <RETURN .P>)>)>>>

<ROUTINE DIR-PRINT (DIR "AUX" (CNT 0))
	 #DECL ((DIR CNT) FIX)
	 <REPEAT ()
		 <COND (<==? <GET ,DIR-STRINGS .CNT> .DIR>
			<COND (<NOT <EQUAL? .DIR ,P?UP ,P?DOWN>>
			       <TELL "the ">)>
			<PRINT <GET ,DIR-STRINGS <+ .CNT 1>>>
			<RTRUE>)>
		 <SET CNT <+ .CNT 1>>>>

<GLOBAL DIR-STRINGS
	<TABLE  P?NORTH "north" P?SOUTH "south"
		P?EAST "east" P?WEST "west"
		P?NW "northwest" P?NE "northeast"
		P?SW "southwest" P?SE "southeast"
		P?DOWN "downstairs" P?UP "upstairs"
		P?IN "in" P?OUT "out">>

<GLOBAL ADV-POSS <TABLE 0 0 0 0 0 0 0 0>>

<ROUTINE ADVENTURER-DECIDE (L "AUX" P S TX)
	 <SET P <NEXTP .L 0>>
	 <PUT ,ADV-POSS 0 0>
	 <REPEAT ()
		 <COND (<L? .P ,LOW-DIRECTION> <RETURN>)
		       (T
			<SET S <PTSIZE <SET TX <GETPT .L .P>>>>
			<COND (<OR <EQUAL? .S ,UEXIT>
			       	   <AND <EQUAL? .S ,DEXIT>
					<NOT <FSET? <GETB .TX ,DEXITOBJ>
						    ,LOCKEDBIT>>>
				   <AND <EQUAL? .S ,CEXIT>
					<VALUE <GETB .TX ,CEXITFLAG>>>>
			       <SET S <GETB .TX ,REXIT>>
			       <PUT ,ADV-POSS
				    0
				    <SET TX <+ <GET ,ADV-POSS 0> 1>>>
			       <PUT ,ADV-POSS .TX .S>)>)>
		 <SET P <NEXTP .L .P>>>
	 <COND (<EQUAL? <SET S <GET ,ADV-POSS 0>> 0>
		<TELL "**BUG: Can't move from " D <LOC ,ADVENTURER> "!" CR>)
	       (<EQUAL? .S 1>
		<MOVE-ADVENTURER <GET ,ADV-POSS 1>>)
	       (T
		<SET P 0>
		<REPEAT ()
			<COND (<G? <SET P <+ .P 1>> .S>
			       <RETURN>)
			      (<NOT <FSET? <SET TX <GET ,ADV-POSS .P>>
					   ,VILLAIN>>
			       <MOVE-ADVENTURER .TX>
			       <RTRUE>)>>
		<MOVE-ADVENTURER <RANDOM-ELEMENT ,ADV-POSS>>)>>

<GLOBAL HALL-TBL <TABLE NW-TOWER MIRROR-HALL-1 MIRROR-HALL-2
			MIRROR-HALL-3 MIRROR-HALL-4 NORTH-GATE
			PURLOINED-ROOM 0>>

<ROUTINE NEXT-HALL (RM "OPTIONAL" (L-R T) "AUX" TBL (OFFS 0) NR)
	 <SET TBL ,HALL-TBL>
	 <REPEAT ()
		 <COND (<EQUAL? <SET NR <GET .TBL .OFFS>> .RM>
			<COND (.L-R <RETURN <GET .TBL <+ .OFFS 1>>>)
			      (T <RETURN <GET .TBL <- .OFFS 1>>>)>)>
		 <SET OFFS <+ .OFFS 1>>>>

<ROUTINE TREASURE-HERE? (RM "AUX" F)
	 <SET F <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<FSET? .F ,TREASURE> <RETURN .F>)
		       (T
			<SET F <NEXT? .F>>)>>>

;"The denouement"

<GLOBAL ADVENTURER-CHARMED <>>
<GLOBAL ADVENTURER-STAY <>>

<ROUTINE PURLOINED-ROOM-A ("AUX" TX)
	 <SET TX <TREASURE-HERE? ,PURLOINED-ROOM>>
	 <COND (.TX
		<SETG ADVENTURER-STAY T>
		<COND (<EQUAL? ,HERE ,PURLOINED-ROOM>
		       <MOVE .TX ,ADVENTURER>
		       <COND (<FSET? ,DOOR-REALITY ,INVISIBLE>
		              <TELL
"The adventurer stops to pick up the " D .TX ". As he rises, he casts a cursory
glance at the door, then he notices you. ">
			      <COND (,ADVENTURER-CHARMED
				     <TELL
"He smiles at you as he pockets the " D .TX "." CR>)
				    (T
				     <TELL
"He straightens quickly, glaring at you with distrust." CR>)>)>)>)
	       (<NOT ,ADVENTURER-NOTES-DOOR>
		<SETG ADVENTURER-NOTES-DOOR T>
		<SETG ADVENTURER-STAY T>
		<COND (<FSET? ,DOOR-REALITY ,INVISIBLE>
		       <TELL
"The adventurer glances around the room in a businesslike way and makes a few
notes on his map." CR>)>)>
	 <RFALSE>>

<GLOBAL ADVENTURER-NOTES-DOOR <>>

<ROUTINE NO-ILLUSIONS ()
	 <FSET ,DOOR-ILLUSION ,INVISIBLE>
	 <FCLEAR ,DOOR-REALITY ,INVISIBLE>
	 <FCLEAR ,DOOR-REALITY ,LOCKEDBIT>
	 <FSET ,DOOR-REALITY ,OPENBIT>
	 <SETG DOOR-ILLUSION-GONE T>
	 <TELL
"The seemingly fearless adventurer shrugs and walks purposefully toward the
door, ignoring all harm to his person in the form of knives, tentacles, and
molten lead. As three buckets of the latter pour over his head, he casts
you a perplexed look.|
\"Did you try the doorknob?\" he asks, as twenty-seven knives delicately
skewer him.|
Before you can answer, he reaches for one of the gargoyle heads which, by
sheerest coincidence, has just flooded him in red-orange flame,
and turns it gently.|
\"I think it's unlocked,\" he says, stoically ignoring the host of human-sized
rats which feed on his incinerated torso.|
His left hand, broken and bloodied, pulls at the gargoyle head.|
\"I'm going on ahead!\" he cries, opening a simple wooden door.|
Wooden door? You rub your eyes for a moment and look again as he
goes through it. Yes, just a plain wooden door." CR>
	 <SETG SCORE <+ ,SCORE ,DOOR-POINT>>
	 <SETG DOOR-POINT 0>
	 <MOVE ,ADVENTURER ,MAP-ROOM>
	 <SETG ADVENTURER-STAY T>>