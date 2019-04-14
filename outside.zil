"OUTSIDE for
		 	    ENCHANTER
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

"Various hacks you can perform outside the castle"

<ROOM WEST-CASTLE
      (IN ROOMS)
      (DESC "Outside Gate")
      (EAST TO INSIDE-GATE
            IF IRON-GATE IS OPEN ELSE "The iron gate is locked.")
      (IN TO INSIDE-GATE
          IF IRON-GATE IS OPEN ELSE "The iron gate is locked.")
      (WEST TO WESTERN-ROAD)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (ACTION WEST-CASTLE-F)
      (GLOBAL IRON-GATE IRON-GATE-CHAINS)>

<ROUTINE WEST-CASTLE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are outside the western entrance to the castle. To the east stands
an iron gate which is ">
		<COND (<FSET? ,IRON-GATE ,OPENBIT>
		       <TELL "wide open">)
		      (T <TELL "closed and chained">)>
		<TELL ". A winding road starts here and proceeds
to the west." CR>)>>

<ROOM WESTERN-ROAD
      (IN ROOMS)
      (DESC "Western Road")
      (LDESC
"You are on an east-west road, which wends its way through
the dark, rolling hills of this land. To the west rises a high
mountain, to the east stands a high castle with dark towers.")
      (EAST TO WEST-CASTLE)
      (WEST TO EAST-FORK)
      (NORTH
"You would become lost among the brambles. Better to stay on the road.")
      (SOUTH
"You would become lost among the brambles. Better to stay on the road.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN DISTANT-CASTLE)>

<ROOM EAST-FORK
      (IN ROOMS)
      (DESC "Eastern Fork")
      (LDESC
"You are at a fork in the road where paths to the northwest and southwest
girdle the base of the Lonely Mountain and a smaller path winds its way
to the east.")
      (NW TO TRAIL-HEAD)
      (SW TO VILLAGE-EAST)
      (EAST TO WESTERN-ROAD)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN)>

<ROOM TRAIL-HEAD
      (IN ROOMS)
      (DESC "Trail Head")
      (LDESC
"You are on the northeast side of the Lonely Mountain, walking a narrow
path through rolling hills. On one side of the path is a sign and behind
that, to the northeast, a winding path through the thick undergrowth. The
trail continues to the southeast.")
      (NE TO SHADY-BROOK)
      (NW TO SHACK-EAST)
      (SE TO EAST-FORK)
      ;(WEST "There is no trail up the mountain here.")
      ;(SOUTH "There is no trail up the mountain here.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN UNDERGROWTH)>

<OBJECT UNDERGROWTH
	(IN LOCAL-GLOBALS)
	(DESC "undergrowth")
	(SYNONYM UNDERGROWTH)
	(ADJECTIVE THICK)
	(FLAGS VOWELBIT)
	(ACTION UNDERGROWTH-F)>

<ROUTINE UNDERGROWTH-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The undergrowth is thick. You would never get through it." CR>)
	       (<VERB? CUT MUNG>
		<TELL
"You could spend a few days doing this without much progress." CR>)>>

<OBJECT PATH-SIGN
	(IN TRAIL-HEAD)
	(DESC "sign")
	(SYNONYM SIGN)
	(FLAGS READBIT NDESCBIT)
	(ACTION PATH-SIGN-F)>

<ROUTINE PATH-SIGN-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL "|
  - Shady Brook Trail -|
|
    Old Lingolf House|
        1000 feet|
">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROOM SHADY-BROOK
      (IN ROOMS)
      (DESC "Shady Brook")
      (LDESC
"The trail ends here. A ruined stone foundation marks the site of the
Old Lingolf House, which presumably was a monument of some sort. The
trail head is off to the southwest, and a small brook flows slowly by.")
      (SW TO TRAIL-HEAD)
      ;(NORTH "The only trail heads back to the southwest.")
      ;(EAST "The only trail heads back to the southwest.")
      ;(WEST "The only trail heads back to the southwest.")
      ;(SOUTH "The only trail heads back to the southwest.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL GLOBAL-WATER HILLS MOUNTAIN UNDERGROWTH)>

<OBJECT FOUNDATION
	(IN SHADY-BROOK)
	(DESC "foundation")
	(SYNONYM FOUNDATION HOUSE)
	(ADJECTIVE STONE RUINED LINGOLF OLD)
	(FLAGS NDESCBIT)
	(ACTION FOUNDATION-F)>

<ROUTINE FOUNDATION-F ()
	 <COND (<VERB? THROUGH> <TELL "No way." CR>)
	       (<VERB? WHO> <TELL "There's no way of knowing." CR>)
	       (<VERB? SEARCH LOOK-INSIDE>
		<TELL
"There is nothing but stone there." CR>)>>

<OBJECT DISTANT-CASTLE
	(IN LOCAL-GLOBALS)
	(DESC "castle")
	(SYNONYM CASTLE TOWER TOWERS TURRET)
	(ADJECTIVE HIGH DARK GREAT)
	(ACTION DISTANT-CASTLE-F)>

<ROUTINE DISTANT-CASTLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The castle is far to the east and flanked by dark towers. From this distance,
not much detail can be discerned." CR>)
	       (<VERB? WALK-TO>
		<TELL
"There's no direct path from here, although roads lead there. Try specifying
a compass direction in order to move around." CR>)>>

<ROOM SHACK-EAST
      (IN ROOMS)
      (DESC "Trail")
      (LDESC
"The trail turns a corner here, bending out of sight to the southeast and
southwest. The ground is higher here than to the south, allowing you to make
out the top of the Lonely Mountain, shrouded in clouds. No path from here
leads up the mountain, however.")
      (SE TO TRAIL-HEAD)
      (SW TO SHACK-ROOM)
      ;(UP "There is no trail up the mountain here.")
      ;(SOUTH "There is no trail up the mountain here.")
      ;(NORTH "There is no trail down the mountain here.")
      ;(DOWN "There is no trail down the mountain here.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN)>

<ROOM SHACK-ROOM
      (IN ROOMS)
      (DESC "Outside of Shack")
      (LDESC
"You are south of an old wooden shack, apparently deserted.
The trail extends from northeast to southwest here, circling the Lonely
Mountain, which lies to the southeast.")
      (NE TO SHACK-EAST)
      (EAST TO SHACK-EAST)
      (WEST TO WEST-FORK)
      (SW TO WEST-FORK)
      (NORTH TO SHACK)
      (IN TO SHACK)
      ;(SOUTH "There is no trail up the mountain here.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL SHACK-OBJ HILLS MOUNTAIN)>

<OBJECT SHACK-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "wooden shack")
	(SYNONYM SHACK)
	(ADJECTIVE OLD WOODEN)
	(FLAGS NDESCBIT)
	(ACTION SHACK-OBJ-F)>

<ROUTINE SHACK-OBJ-F ()
	 <COND (<AND <VERB? THROUGH> <EQUAL? ,HERE ,SHACK-ROOM>>
		<GOTO ,SHACK>
		<RTRUE>)
	       (<AND <VERB? DROP> <EQUAL? ,HERE ,SHACK>>
		<GOTO ,SHACK-ROOM>
		<RTRUE>)>>

<ROOM SHACK
      (IN ROOMS)
      (DESC "Inside Shack")
      (LDESC
"The inside of the shack is a shambles. An overturned table and bench,
and a few broken windows remain. An oven is the only fixture
that's even recognizable. The door is to the south.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL SHACK-OBJ WINDOW)
      (SOUTH TO SHACK-ROOM)
      (OUT TO SHACK-ROOM)
      (TEXT
"You can't see much except for scrubby vegetation.")
      (PSEUDO "TABLE" SHACK-STUFF "BENCH" SHACK-STUFF)>

<OBJECT BATTERED-LANTERN
	(IN SHACK)
	(DESC "battered lantern")
	(FDESC
"The top of a battered lantern is partially visible behind the overturned
table.")
	(SYNONYM LANTERN LAMP)
	(ADJECTIVE BATTERED)
	(FLAGS TAKEBIT)
	(ACTION BATTERED-LANTERN-F)>

<ROUTINE BATTERED-LANTERN-F ()
	 <COND (<VERB? ERASE-LINE>
		<TELL "Aladdin you're not." CR>)
	       (<VERB? LAMP-ON>
		<TELL
"The lamp seems to be broken, most likely beyond repair." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The lamp is made of brass and is old and battered. It doesn't seem
likely that any use can be made of it." CR>)
	       (<AND <VERB? LAMP-OFF> <NOT <FSET? ,PRSO ,ONBIT>>>
		<TELL "It isn't on!" CR>)>>

<ROUTINE SHACK-STUFF ()
	 <COND (<AND <VERB? PUT> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"They are overturned and don't make good surfaces." CR>)>>

<OBJECT SHACK-OVEN
	(IN SHACK)
	(DESC "oven")
	(SYNONYM OVEN FIXTURE)
	(FLAGS NDESCBIT CONTBIT VOWELBIT)
	(CAPACITY 20)
	(ACTION SHACK-OVEN-F)>

<ROUTINE SHACK-OVEN-F ()
	 <COND (<VERB? LAMP-ON LAMP-OFF>
		<TELL "It's not working." CR>)
	       (<VERB? EXAMINE>
		<TELL
"Strangely, the oven is still slightly warm, as if it had been used
recently." CR>)>>

<OBJECT BREAD
	(IN SHACK-OVEN)
	(DESC "loaf of bread")
	(SYNONYM LOAF BREAD FOOD)
	(SIZE 8)
	(FLAGS TAKEBIT)
	(ACTION BREAD-F)>

<ROUTINE BREAD-F ("AUX" AMT S)
	 <COND (<VERB? EXAMINE>
		<TELL "There's "
		      <GET ,BREAD-EXAMINES <GETP ,BREAD ,P?SIZE>>
		      " left." CR>)
	       (<VERB? EAT>
		<SET S <GET <INT I-HUNGER> ,C-TICK>>
		<COND (<G? .S 60>
		       <TELL "You aren't the least bit hungry." CR>
		       <RTRUE>)>
		<PUTP ,BREAD ,P?SIZE <SET AMT <- <GETP ,BREAD ,P?SIZE> 1>>>
		<SETG SCORE <+ ,SCORE ,EAT-POINT>>
		<SETG EAT-POINT 0>
		<TELL
"Mmm. That tasted great! ">
		<TELL <GET ,BREAD-AMTS .AMT> CR>
		<COND (<EQUAL? .AMT 0>
		       <REMOVE ,BREAD>)>
		<QUEUE I-HUNGER <+ .S 47>>
		<SETG HUNGER-COUNT 0>
		<RTRUE>)
	       (<AND <VERB? BURN> <==? ,PRSI ,ETERNAL-FLAME>>
		<TELL
"Toast without jam? What a silly idea!" CR>)
	       (<AND <VERB? CUT MUNG> <==? ,PRSI ,MAGIC-KNIFE>>
		<TELL
"It seems silly to cut up your bread when it's more easily carried in
one piece. Besides, you might get crumbs all over your spell book." CR>)>>

<GLOBAL BREAD-EXAMINES <TABLE
0
"not much"
"only a small amount"
"a good deal"
"nearly half"
"about half"
"a lot"
"a whole lot"
"an entire loaf">>

<GLOBAL BREAD-AMTS <TABLE
"There's none left, though."
"There's not much left, though."
"There's only a small amount left, though."
"There's still a good deal left, too."
"There's nearly half of it left, too."
"There's still about half of it left, too."
"There's a lot of bread left, too."
"There's a whole lot of it left, too."
"There's a full loaf, too.">>

<ROOM WEST-FORK
      (IN ROOMS)
      (DESC "Fork")
      (LDESC
"You stand at a point of decision on a road which makes a wide
fork to the northeast and southeast, circling the base of the Lonely Mountain,
which looms high overhead to the east. A very long and winding road starts
here and stretches out of sight to the west through low, smoky hills.")
      (WEST TO LONG-ROAD)
      (NE TO SHACK-ROOM)
      (SE TO DUSTY-ROAD)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN)>

<ROOM DUSTY-ROAD
      (IN ROOMS)
      (DESC "Dusty Trail")
      (LDESC
"The trail here turns dry and dusty. To the northwest is the fork leading to
the Long Road, and the trail continues to the southeast.")
      (NW TO WEST-FORK)
      (SE TO HAIRPIN-LOOP)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN)>

<ROOM HAIRPIN-LOOP
      (IN ROOMS)
      (DESC "Loop")
      (LDESC
"The trail makes a hairpin turn here, swinging out to the northwest and
northeast, where it enters a small village. Low, smoky hills stretch
out to the west and south.")
      (NE TO VILLAGE)
      (NW TO DUSTY-ROAD)
      ;(NORTH "There is no trail up the mountain here.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN)>

<ROOM VILLAGE
      (IN ROOMS)
      (DESC "Deserted Village")
      (LDESC
"This is the castle's village. Formerly, peasants lived here, going to
their farm plots each day. Merchants and artisans made it a center of
cultural activity. But now it's deserted. Or almost: there is smoke
rising from a particularly decrepit hovel to the south. A path travels
through the village from southwest to northeast, heading towards the
castle, and a less-used trail heads north up the mountain.")
      (NE TO VILLAGE-EAST)
      (SW TO HAIRPIN-LOOP)
      (NORTH TO MOUNTAIN-TRAIL)
      (UP TO MOUNTAIN-TRAIL)
      (EAST
"You wander around in the village, find nothing of interest, and return to
the path.")
      (WEST
"You wander around in the village, find nothing of interest, and return to
the path.")
      (NW
"You wander around in the village, find nothing of interest, and return to
the path.")
      (SE
"You wander around in the village, find nothing of interest, and return to
the path.")
      (IN PER HOVEL-KLUDGE)
      (SOUTH PER HOVEL-KLUDGE)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HOVEL HILLS MOUNTAIN)>

<ROOM MOUNTAIN-TRAIL
      (IN ROOMS)
      (DESC "Mountain Trail")
      (LDESC
"This spot halfway up the Lonely Mountain is desolate of vegetation. Short,
stunted trees with branches empty surround you and the air is heavy and
smoke-filled.")
      (DOWN TO VILLAGE)
      (SOUTH TO VILLAGE)
      (UP TO VISTA)
      (NORTH TO VISTA)
      (EAST "The trail is narrow and only heads up and down.")
      (WEST "The trail is narrow and only heads up and down.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN TREES)>

<OBJECT TREES
	(IN LOCAL-GLOBALS)
	(DESC "tree")
	(SYNONYM TREE TREES BRANCH)
	(ADJECTIVE SHORT STUNTED)
	(ACTION TREES-F)>

<ROUTINE TREES-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<TELL
"The trees are not suitable for climbing." CR>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,HERE ,RMUNGBIT>
		       <TELL
"The trees are short and stunted and covered in a thick, grey ash. The
roots themselves are blackened and foul-smelling." CR>)
		      (T
		       <TELL
"The trees are mostly short and stunted." CR>)>)>>

<ROOM VISTA
      (IN ROOMS)
      (DESC "Lonely Mountain")
      (LDESC
"This is the top of the Lonely Mountain. In olden days, mariners had
named it Signal Mountain, for its glistening peak reflected the pale
moonlight, providing an unmistakable landmark on unclouded nights. The
bald mountain face is made of a shining substance whose nature is
unknown to you. Looking to the west, low hills stretch to the horizon,
and small pieces of the Long Road can be seen winding their way to
distant lands. To the east, far away, can be seen a great castle at the
edge of the Sea. Three turrets it has; two, old and still
majestic, lie on either side of a third, cold, black as night and squat
as a toad. An evil smoke seems to emanate from this tower, shrouding the
others in a darkening fog. A small mountain trail leaves the peak and descends
to the south into a small village far below.")
      (DOWN TO MOUNTAIN-TRAIL)
      (SOUTH TO MOUNTAIN-TRAIL)
      (EAST
"At the last moment, you remember that you don't know a flying spell.")
      (WEST
"At the last moment, you remember that you don't know a flying spell.")
      (NORTH
"At the last moment, you remember that you don't know a flying spell.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL DISTANT-CASTLE HILLS MOUNTAIN)>

<OBJECT HOVEL
	(IN LOCAL-GLOBALS)
	(DESC "hovel")
	(SYNONYM HOVEL)
	(ADJECTIVE DECREPIT)
	(ACTION HOVEL-F)>

<ROUTINE HOVEL-F ()
	 <COND (<AND <EQUAL? ,HERE ,VILLAGE> <VERB? THROUGH WALK-TO>>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)>>

<ROUTINE HOVEL-KLUDGE ()
	 <TELL
"It is dark and smoky in here, but this is a place of great disorder,
and its odor is indescribable. A pile of rags sits near a small pot which
is bubbling and steaming over a tiny fire. The pile of rags sports a gnarled
hand which busies itself with the noisome stew. A closer look reveals a
withered crone at the other end of the hand." CR>
	 <COND (<EQUAL? ,CRONE-MOVE 0>
		<TELL CR
"The creature looks you over keenly and speaks: \"I should have thought
they would send someone more ... more ...\" She laughs in an unsettling
way. \"They've all left! A great storm is brewing in the east, my friend,
and all have fled before it!\" She starts to chuckle. \"Take this and
begone!\" With a wave of her hand, you find yourself reeling out of the door
of the hovel, holding some sort of scroll in your hand." CR>
		<MOVE ,OPEN-SCROLL ,WINNER>
		<SETG CRONE-MOVE ,MOVES>)
	       (<L? <- ,MOVES ,CRONE-MOVE> 20>
		<TELL
"As you enter the crone's hovel, she booms at you: \"Are you here again?
What a wizard!\" Her emphasis on the word \"wizard\" is filled with derision.
\"Make a small effort, would you, to make your Circle proud of you?\" The
same horrible emphasis on \"proud\" fills you with revulsion. \"Go!\" You
find yourself back in the village." CR>)
	       (T
		<SETG CRONE-MOVE ,MOVES>
		<TELL
"As you enter, the woman in rags wags her head slowly. \"You've
returned, have you? You need help perhaps? Well, I've given you all
the help in my meager store. You want more? Leave me!\" You find
yourself in the village." CR>)>
	 <RFALSE>>

<GLOBAL CRONE-MOVE 0>

<OBJECT GLOBAL-CRONE
	(IN GLOBAL-OBJECTS)
	(DESC "creature swathed in rags")
	(SYNONYM CRONE)
	(ACTION GLOBAL-CRONE-F)>

<ROUTINE GLOBAL-CRONE-F ()
	 <COND (<VERB? ZIFMIA>
		<TELL
"Slowly, the old woman, swathed in rags, appears before you. She seems to be
staring through you and speaks slowly and sullenly: \"I thought I might see
you again, my friend! I gave you all the aid that I can. The rest is up to
you...\" She disappears." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The crone was presumably the village wise woman and its last remaining
inhabitant." CR>)
	       (T <TELL "The crone isn't here." CR>)>>

<ROOM VILLAGE-EAST
      (IN ROOMS)
      (DESC "Village Outskirts")
      (LDESC
"You are on a road which enters a small village to the southwest and comes
to a fork to the northeast. The Lonely Mountain looms above but there is
no path from here which ascends the mountain.")
      (SW TO VILLAGE)
      (NE TO EAST-FORK)
      (SOUTH "There is no road there.")
      (NORTH "There is no road there.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN)>

<ROOM LONG-ROAD
      (IN ROOMS)
      (DESC "Long Road")
      (EAST PER LONG-ROAD-EXIT-F)
      (WEST PER LONG-ROAD-EXIT-F)
      (ACTION LONG-ROAD-F)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL HILLS MOUNTAIN FOREST TREES)
      (PSEUDO "FARM" FARM-PSEUDO)>

<ROUTINE LONG-ROAD-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are walking along the road. It wends its way through low hills, sparse
forests, and occasional subsistence farms. To the west, things seem lighter
and more pleasant. To the east they seem oppressive and dark. A worn sign
sits beside the road here.">
		<COND (<==? ,ROAD-LOC ,ROAD-START>
		       <TELL " The deserted village is to the east.">)>
		<CRLF>)>>

<ROUTINE FARM-PSEUDO ()
	 <COND (<VERB? EXAMINE THROUGH>
		<TELL
"It's a poor, run-down farm, and not of interest." CR>)>>

<OBJECT LONG-ROAD-SIGN
	(IN LONG-ROAD)
	(DESC "sign")
	(SYNONYM SIGN)
	(ADJECTIVE WORN)
	(FLAGS NDESCBIT)
	(ACTION LONG-ROAD-SIGN-F)>

<ROUTINE LONG-ROAD-SIGN-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (<G? <- ,ROAD-LOC ,ROAD-START> 11>
		       <TELL "The sign is too worn to be read." CR>)
		      (T
		       <TELL "\""
			     <GET ,SIGN-TBL <- ,ROAD-LOC ,ROAD-START>>
			     "\"" CR>)>)>>

<GLOBAL SIGN-TBL <TABLE
"Why"
"are"
"you"
"going"
"west"
"when"
"the"
"castle"
"is"
"east?"
"Burma"
"Shave">>

<ROUTINE LONG-ROAD-EXIT-F ()
	 <COND (<AND <==? ,ROAD-LOC ,ROAD-START>
		     <==? ,PRSO ,P?EAST>>
		,WEST-FORK)
	       (ELSE
		<FCLEAR ,LONG-ROAD ,TOUCHBIT>
		<ROAD-TO-TABLE ,ROAD-LOC>
		<COND (<==? ,PRSO ,P?WEST>
		       <SETG ROAD-LOC <+ ,ROAD-LOC 1>>)
		      (<==? ,PRSO ,P?EAST>
		       <SETG ROAD-LOC <- ,ROAD-LOC 1>>)>
		<TABLE-TO-ROAD ,ROAD-LOC>
		,LONG-ROAD)>>

<ROUTINE ROAD-TO-TABLE (SLOC
			 "AUX" TBL (CNT 0)
			  (F <FIRST? ,LONG-ROAD>) N)
	 <SET TBL ,ROAD-TABLE>
	 <REPEAT ()
		 <COND (.F <SET N <NEXT? .F>>)
		       (ELSE <RETURN>)>
		 <COND (<EQUAL? .F ,WINNER>)
		       (<FSET? .F ,TAKEBIT>
			<REPEAT ()
				<COND (<==? <GET .TBL .CNT> 0>
				       <PUT .TBL .CNT .SLOC>
				       <PUT .TBL <+ .CNT 1> .F>
				       <SET CNT <+ .CNT 2>>
				       <REMOVE .F>
				       <RETURN>)
				      (ELSE
				       <SET CNT <+ .CNT 2>>)>>)>
		 <SET F .N>>>

<ROUTINE TABLE-TO-ROAD (SLOC
			"AUX" TBL (CNT 0))
	 <SET TBL ,ROAD-TABLE>
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,ROAD-TABLE-LENGTH>>
			<RETURN>)
		       (<==? <GET .TBL .CNT> .SLOC>
			<PUT .TBL .CNT 0>
			<MOVE <GET .TBL <+ .CNT 1>> ,LONG-ROAD>)>
		 <SET CNT <+ .CNT 2>>>>

<GLOBAL ROAD-LOC 10000>
<CONSTANT ROAD-START 10000>

<CONSTANT ROAD-TABLE-LENGTH 80> ;"currently 33 objects with TAKEBIT"

<GLOBAL ROAD-TABLE ;"length should be 2*number of takeable objects"
	<TABLE 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<OBJECT ROAD
	(IN GLOBAL-OBJECTS)
	(DESC "road")
	(SYNONYM ROAD PATH TRAIL)
	(ADJECTIVE WINDING LONG DUSTY DRY)
	(ACTION ROAD-F)>

<ROUTINE ROAD-F ()
	 <COND (<VERB? FOLLOW TAKE>
		<TELL
"You should supply a compass direction in which to follow the path." CR>)
	       (<VERB? DROP>
		<COND (<OUTSIDE? ,HERE>
		       <TELL
"It's much safer to stay on the path, especially in these times." CR>)
		      (T
		       <TELL
"You'll have to give a direction." CR>)>)>>

<OBJECT HILLS
	(IN LOCAL-GLOBALS)
	(DESC "hills")
	(SYNONYM HILL HILLS)
	(ADJECTIVE LOW ROLLING SMOKY)
	(ACTION HILLS-F)>

<ROUTINE HILLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The hills are mostly low and shrouded in a fine mist-like haze. They
stretch out mainly to the west." CR>)
	       (<VERB? CLIMB-UP CLIMB-FOO>
		<PERFORM ,V?LEAVE ,ROAD>
		<RTRUE>)>>

<OBJECT MOUNTAIN
	(IN LOCAL-GLOBALS)
	(DESC "mountain")
	(SYNONYM MOUNTAIN PEAK)
	(ADJECTIVE LONELY)
	(ACTION MOUNTAIN-F)>

<ROUTINE MOUNTAIN-F ()
	 <COND (<AND <VERB? LEAP> <EQUAL? ,HERE ,VISTA>>
		<JIGS-UP
"You execute a perfect swan-dive into the rocks below.">)
	       (<VERB? CLIMB-FOO CLIMB-UP>
		<COND (<EQUAL? ,HERE ,VISTA>
		       <TELL "You are here!" CR>)
		      (<EQUAL? ,HERE ,VILLAGE ,MOUNTAIN-TRAIL>
		       <DO-WALK ,P?UP>)
		      (T
		       <TELL
"There's no way up the mountain from here." CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"The mountain is tall and proud, and its shining peak stands above
the low-hanging clouds." CR>)>>

<ROUTINE OUTSIDE? (RM)
	 <COND (<NOT <FSET? .RM ,LIGHTBIT>> <RFALSE>)
	       (<OR <EQUAL? .RM ,SHACK ,INSIDE-GATE>
		    <EQUAL? .RM ,PEBBLED-PATH ,COURTYARD-1>
		    <EQUAL? .RM ,COURTYARD-2 ,COURTYARD-3 ,COURTYARD-4>
		    <EQUAL? .RM ,COURTYARD-5 ,COURTYARD-6 ,COURTYARD-7>
		    <EQUAL? .RM ,SHACK-ROOM ,BEDROOM>>
		<RFALSE>)
	       (ELSE <RTRUE>)>>

<ROUTINE I-SCURRY ()
	 <ENABLE <QUEUE I-SCURRY <+ 15 <RANDOM 20>>>>
	 <COND (<PROB 25>
		<COND (<OUTSIDE? ,HERE>
		       <COND (<AND <L? ,NIGHTFALL 70> <PROB 50>>
			      <TELL
"You hear noises in the brambles. Snorting noises are followed by loud
crashing and finally a hideous squeal of triumph." CR>)
			     (ELSE
			      <TELL
"You hear a rustling in the brambles nearby, and you catch a glimpse of
something small and furry as it scurries away." CR>)>)
		      (<OR <EQUAL? ,HERE ,PIT ,REAL-STAIR ,PURLOINED-ROOM>
			   <EQUAL? ,HERE ,WARLOCK-TOWER>>
		       <RFALSE>)
		      (<GETP ,HERE ,P?TMAZE> <RFALSE>)
		      (<OR <EQUAL? <LOC ,WINNER>
				   ,DUNGEON ,NORTH-CELL>
			   <EQUAL? <LOC ,WINNER>
				   ,SECRET-PASSAGE>>
		       <TELL
"You hear, almost beyond your hearing, the soft rattle of chains, and
a cold wind blows over the back of your neck." CR>)
		      (<G? ,TOD ,NIGHTFALL>
		       <TELL <PICK-ONE ,NIGHT-GLIMPSES> CR>)
		      (ELSE
		       <TELL <PICK-ONE ,GLIMPSES> CR>)>)>>

<OBJECT GLIMPSE-1
	(IN GLOBAL-OBJECTS)
	(DESC "glimpse")
	(SYNONYM DOG RAT BATS BAT)
	(ADJECTIVE FERAL GAUNT)
	(ACTION GLIMPSE-F)>

<OBJECT GLIMPSE-2
	(IN GLOBAL-OBJECTS)
	(DESC "glimpse")
	(SYNONYM MIST OUTLINE BLUEBOTTLE FLY)
	(ADJECTIVE THIN)
	(ACTION GLIMPSE-F)>

<ROUTINE GLIMPSE-F ()
	 <COND (<G? ,MOVES 0>
		<TELL "You can't see that anymore." CR>)
	       (ELSE
		<TELL "You see no such thing." CR>)>>

<GLOBAL GLIMPSES <LTABLE 0
"A rat skitters across the floor, sees you, is startled, and rushes
back the way it came."
"Bluebottles buzz up to you, and then away."
"A gaunt, feral-looking dog carrying a well-chewed bone approaches,
is surprised by your presence, growls and then turns tail.">>

<GLOBAL NIGHT-GLIMPSES <LTABLE 0
"Bats flutter by, red eyes glowing."
;"Ahead, a thin mist forms into the ghostly outline of a man. He beckons,
but before you can approach, the outline wavers, the mist dissolves, and
all is as before."
"You hear noises in the darkness nearby."
"You sense something behind you, turn, and there is nothing there.">>

