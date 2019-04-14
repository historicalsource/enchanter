"CASTLE for
		 	    ENCHANTER
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

"Basic Geography"

<ROOM INSIDE-GATE ;"starting location"
      (IN ROOMS)
      (DESC "Inside Gate")
      (EAST TO COURTYARD-1)
      (WEST TO WEST-CASTLE)
      (OUT TO WEST-CASTLE) ;(IF IRON-GATE IS OPEN
       			     ELSE "The iron gate is locked and chained.")
      (SOUTH TO WEST-HALL)
      (NORTH TO PEBBLED-PATH)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (ACTION INSIDE-GATE-F)
      (GLOBAL IRON-GATE IRON-GATE-CHAINS HILLS ARCH COURTYARD)>

<GLOBAL CASTLE-ENTER <>>

<ROUTINE INSIDE-GATE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT ,CASTLE-ENTER>>
		<SETG CASTLE-ENTER T>
		<TELL
"As you pass through the gate, you feel that your mind is being probed. After
a moment, it is released or, perhaps, discarded as uninteresting." CR CR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are just inside what appears to be the main entrance to the castle.
An iron gate, standing wide open, looms to the west. Through it, a narrow
road can be seen winding through low, smoky hills. Before you, to the
east, is a huge open courtyard. To the north and the south are archways
leading to the interior of the castle." CR>)>>

<OBJECT IRON-GATE
	(IN LOCAL-GLOBALS)
	(DESC "iron gate")
	(SYNONYM GATE)
	(ADJECTIVE MASSIVE IRON)
	(FLAGS NDESCBIT DOORBIT VOWELBIT LOCKEDBIT)
	(ACTION IRON-GATE-F)>

<OBJECT IRON-GATE-CHAINS
	(IN LOCAL-GLOBALS)
	(DESC "chains")
	(SYNONYM CHAIN CHAINS)
	(ADJECTIVE IRON)
	(FLAGS NDESCBIT)
	(ACTION IRON-GATE-F)>

<ROUTINE IRON-GATE-F ()
	 <COND (<VERB? OPEN UNLOCK>
		<TELL "The gate is secure; it cannot be unlocked." CR>)
	       (<VERB? CLOSE> <TELL "It is too heavy to move." CR>)
	       (<VERB? REZROV>
		<SETG SCORE <+ ,SCORE ,ENTRY-POINT>>
		<SETG ENTRY-POINT 0>
		<TELL
"The chains of the iron gate fly into the air and vanish. The gate flies
open and a blast of cold air fills your lungs." CR>
		<FSET ,IRON-GATE-CHAINS ,INVISIBLE>
		<FSET ,IRON-GATE ,OPENBIT>)>> 

<ROOM PEBBLED-PATH
      (IN ROOMS)
      (DESC "Pebbled Path")
      (LDESC
"You are on a long pebbled path, stretching out to the north. To the south
the path continues through an open arch into an open area.")
      (NORTH TO NW-TOWER)
      (SOUTH TO INSIDE-GATE)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL ARCH)>

<OBJECT ARCH
	(IN LOCAL-GLOBALS)
	(DESC "arch")
	(SYNONYM ARCH ARCHWAY)
	(FLAGS VOWELBIT)
	(ACTION ARCH-F)>

<ROUTINE ARCH-F ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,PEBBLED-PATH>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,INSIDE-GATE>
		       <TELL
"You should specify a compass direction, since there are two archways." CR>
		       <RTRUE>)
		      (T
		       <DO-WALK ,P?NORTH>)>)>>

<ROOM COURTYARD-1
      (IN ROOMS)
      (DESC "Courtyard")
      (LDESC
"This is the westernmost point in a large open courtyard. The huge entrance
gate to the castle looms ominously to the west. The courtyard widens as it
proceeds to the east, where a large, ivy-covered temple stands. On either
side of the temple are small towers. Far beyond the temple, high above, are
two large towers marking the corners of the castle. A squat dark turret
hunches between them, blackening the sky around it. A small path leads into
the castle to the south.")
      (WEST TO INSIDE-GATE)
      (EAST TO COURTYARD-3)
      (NE TO COURTYARD-2)
      (SE TO COURTYARD-4)
      (SOUTH TO KNOT-ROOM)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL TEMPLE-OBJ COURTYARD TURRET TOWER)>

<ROOM WEST-HALL
      (IN ROOMS)
      (DESC "West Hall")
      (LDESC
"This narrow promenade stretches into darkness to the south and, through
an archway, toward an open area to the north.")
      (NORTH TO INSIDE-GATE)
      (SOUTH TO SW-TOWER)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL ARCH)>

<ROOM SW-TOWER
      (IN ROOMS)
      (DESC "Tower")
      (LDESC
"This dark and damp spot is at the base of the southwest tower of the castle.
Two corridors lead off to the north and east. A winding staircase ascends into
the tower.")
      (NORTH TO WEST-HALL)
      (EAST TO DIM-DESCENT)
      (UP TO BEDROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS TOWER)>

<ROOM BEDROOM
      (IN ROOMS)
      (DESC "Bedroom")
      (LDESC
"The eyrie is a round bedroom high in the tower. Narrow windows overlook
the outside. A stone stairway leads down.")
      (DOWN TO SW-TOWER)
      (TEXT
"Through the window, you can see a long twisting road making its way
through a land of low, smoky hills.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL STAIRS WINDOW HILLS)>

<OBJECT BED
	(IN BEDROOM)
	(DESC "fourposter feather bed")
	(SYNONYM BED)
	(ADJECTIVE FEATHER FOURPOSTER)
	(FLAGS VEHBIT CONTBIT SEARCHBIT OPENBIT SURFACEBIT)
	(ACTION BED-F)>

<ROUTINE BED-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <TELL
"You'll have to get up first. The bed is so comfy you would almost rather
not." CR>)
		      (<VERB? BOARD CLIMB-ON WEAR>
		       <TELL "You already are." CR>)
		      (<AND <VERB? TAKE MOVE PUSH RUB OPEN CLOSE>
			    <NOT <IN? ,PRSO ,WINNER>>>
		       <TELL
"You can't do that from your resting position." CR>)>)
	       (<EQUAL? .RARG ,M-END> <RFALSE>)
	       (<NOT <EQUAL? ,BED ,PRSO ,PRSI>> <RFALSE>)
	       (<VERB? BOARD CLIMB-ON WEAR>
		<MOVE ,WINNER ,BED>
		<COND (<L? <- ,MOVES ,LAST-SLEEP> ,MOVES-PER-DAY>
		       <TELL
"The bed is very comfortable and soft. In fact, you feel sort of
sleepy just lying on it." CR>)
		      (ELSE
		       <TELL "Lying on this soft bed puts you to sleep." CR>
		       <PERFORM ,V?SLEEP>
		       <RTRUE>)>)
	       (<VERB? WALK-TO>
		<PERFORM ,V?BOARD ,BED>
		<RTRUE>)
	       (<AND <VERB? DISEMBARK DROP>
		     <IN? ,WINNER ,BED>>
		<MOVE ,WINNER ,HERE>
		<TELL
"Ah, that was a comfortable bed! But you're now on your own feet
again." CR>)
	       (<AND <VERB? EXAMINE> <==? ,PRSO ,BED>>
		<TELL
"The feather bed looks as though it would be quite comfy to sleep on." CR>)
	       (<AND <VERB? SHAKE>
		     <==? ,PRSO ,BED>
		     <FIRST? ,BEDPOST>>
		<TELL
"When you shake the bed, one of the bedposts rattles as though something
were loose inside it." CR>)>>

<OBJECT BEDPOST
	(IN BED)
	(DESC "bedpost")
	(SYNONYM BEDPOST POST)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT)
	(CAPACITY 5)
	(ACTION BEDPOST-F)>

<ROUTINE BEDPOST-F ()
	 <COND (<VERB? EXAMINE SEARCH>
		<COND (<FSET? ,BEDPOST ,OPENBIT>
		       <TELL
"The bedpost is open." CR>)
		      (<IN? ,BEDPOST-BUTTON ,BED>
		       <TELL
"A careful examination reveals the outline of a small compartment, and
near it an ornate carving which looks like a button. You could never
have found it on your own." CR>)
		      (ELSE
		       <TELL
"A careful examination reveals a thin line which might well be the
outline of a small compartment, but the mechanism for opening it is
not discernable." CR>)>)
	       (<VERB? OPEN>
		<TELL
"Maybe it can be opened, but it's unclear how." CR>)
	       (<VERB? REZROV>
		<FSET ,BEDPOST ,OPENBIT>
		<COND (<IN? ,CHARM-SCROLL ,BEDPOST>
		       <SETG SCORE <+ ,SCORE ,CHARM-POINT>>
		       <SETG CHARM-POINT 0>
		       <THIS-IS-IT ,CHARM-SCROLL>
		       <TELL ,POPS-OPEN CR>)
		      (ELSE
		       <TELL "The bedpost pops open." CR>)>)
	       (<AND <VERB? SHAKE> <FIRST? ,BEDPOST>>
		<TELL
"There is something rustling around inside the bedpost." CR>)>>

<GLOBAL POPS-OPEN 
"The bedpost pops open, revealing a small compartment and, nestled
inside, a gold leaf scroll!">

<OBJECT COMPARTMENT
	(IN BED)
	(DESC "compartment")
	(SYNONYM COMPARTMENT)
	(ADJECTIVE SMALL)
	(FLAGS NDESCBIT)
	(ACTION COMPARTMENT-F)>

<ROUTINE COMPARTMENT-F ()
	 <COND (<AND <NOT <IN? ,BEDPOST-BUTTON ,BED>>
		     <VERB? EXAMINE SEARCH>>
		<TELL
"A very thin line indicates that a hidden compartment might be imbedded
in the bedpost, but it's not clear how to open it." CR>)
	       (T
		<PERFORM ,PRSA ,BEDPOST>
		<RTRUE>)>>

<OBJECT BEDPOST-BUTTON
	(DESC "ornate button")
	(SYNONYM BUTTON CARVING ORNAME)
	(ADJECTIVE ORNATE WOODEN)
	(FLAGS NDESCBIT VOWELBIT)
	(ACTION BEDPOST-BUTTON-F)>

<ROUTINE BEDPOST-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<FSET ,BEDPOST ,OPENBIT>
		<SETG SCORE <+ ,SCORE ,CHARM-POINT>>
		<SETG CHARM-POINT 0>
		<COND (<IN? ,CHARM-SCROLL ,BEDPOST>
		       <THIS-IS-IT ,CHARM-SCROLL>
		       <TELL ,POPS-OPEN CR>)>
		<RTRUE>)>>

<ROOM DIM-DESCENT
      (IN ROOMS)
      (DESC "South Hall")
      (LDESC
"The damp corridor continues east and west from here. A dark and forbidding
stairway leads down to the south. In addition, a narrow passage leads to the
north.")
      (NORTH TO KNOT-ROOM)
      (WEST TO SW-TOWER)
      (EAST TO GALLERY)
      (DOWN TO DUNGEON)
      (SOUTH TO DUNGEON)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

;"<ROOM KNOT-ROOM ...> (IN KNOT.ZIL)"

<ROOM DUNGEON
      (IN ROOMS)
      (DESC "Dungeon")
      (LDESC
"A dank and forgotten pit contains the dungeons. There is a cell to
the north, and a partly blocked passage leads even deeper into the
earth. It looks as if there was once a mortared stone wall blocking this
passage, but it has crumbled and collapsed, reopening the tunnel.")
      (UP TO DIM-DESCENT)
      (DOWN TO T-A)
      (NORTH TO NORTH-CELL IF NORTH-CELL-DOOR IS OPEN) 
      (IN TO NORTH-CELL IF NORTH-CELL-DOOR IS OPEN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS STONE-WALL NORTH-CELL-DOOR)
      (PSEUDO "CELL" CELL-F)>

<ROOM NORTH-CELL
      (IN ROOMS)
      (DESC "Cell")
      (SOUTH TO DUNGEON IF NORTH-CELL-DOOR IS OPEN) 
      (EAST TO SECRET-PASSAGE IF NORTH-BLOCK-FLAG)
      (OUT TO DUNGEON IF NORTH-CELL-DOOR IS OPEN)
      (FLAGS RLANDBIT)
      (ACTION NORTH-CELL-F)
      (GLOBAL NORTH-CELL-DOOR STONE-WALL NORTH-BLOCK)
      (PSEUDO "CELL" CELL-F)>

<ROUTINE CELL-F ()
	 <COND (<AND <VERB? THROUGH> <EQUAL? ,HERE ,DUNGEON>>
		<DO-WALK ,P?NORTH>)
	       (<AND <VERB? DROP> <EQUAL? ,HERE ,NORTH-CELL>>
		<DO-WALK ,P?SOUTH>)
	       (<AND <VERB? SEARCH> <EQUAL? ,HERE ,NORTH-CELL>>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT NORTH-CELL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "cell door")
	(SYNONYM DOOR)
	(ADJECTIVE CELL)
	(ACTION CELL-DOOR-F)
	(FLAGS NDESCBIT DOORBIT CONTBIT)>

<ROUTINE NORTH-CELL-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is a damp and unhealthy dungeon cell with writing on the walls.
The rusty door of the cell is ">
		<COND (<FSET? ,NORTH-CELL-DOOR ,OPENBIT>
		       <TELL "open.">)
		      (ELSE <TELL "closed.">)>
		<COND (,NORTH-BLOCK-FLAG
		       <TELL
" A square block sits beside a passage in the eastern wall.">)
		      (<AND <NOT ,NORTH-BLOCK-FLAG>
			    <NOT <FSET? ,NORTH-BLOCK ,NDESCBIT>>>
		       <TELL
" A square block in the east wall seems to be loose.">)>
		<CRLF>)>>

<ROUTINE CELL-DOOR-F ()
	 <COND (<OR <AND <VERB? OPEN> <NOT <FSET? ,PRSO ,OPENBIT>>>
		    <AND <VERB? CLOSE> <FSET? ,PRSO ,OPENBIT>>>
		<TELL "The door is very rusty and reluctantly ">
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "close">)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <TELL "open">)>
		<TELL "s." CR>)>>

<OBJECT STONE-WALL
	(IN LOCAL-GLOBALS)
	(DESC "stone wall")
	(SYNONYM WALL WRITING GRAFFITI SCRATCHINGS)
	(ADJECTIVE STONE)
	(ACTION STONE-WALL-F)
	(FLAGS NDESCBIT READBIT)>

<ROUTINE STONE-WALL-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The wall is covered with graffiti and scratchings marking time's passage." CR>
		<COND (<==? ,HERE ,NORTH-CELL>
		       <COND (<NOT ,NORTH-BLOCK-FLAG>
			      <FCLEAR ,NORTH-BLOCK ,NDESCBIT>
			      <TELL
"You notice that the mortar holding a square block has been chipped
away, and the block is loose." CR>)>)>
		<RTRUE>)>>

<OBJECT NORTH-BLOCK
	(IN LOCAL-GLOBALS)
	(DESC "square block of stone")
	(SYNONYM BLOCK)
	(ADJECTIVE SQUARE STONE LOOSE)
	(ACTION NORTH-BLOCK-F)
	(FLAGS NDESCBIT TAKEBIT)>

<GLOBAL NORTH-BLOCK-FLAG <>>

<ROUTINE NORTH-BLOCK-F ()
	 <COND (<VERB? MOVE TAKE>
		<COND (<NOT ,NORTH-BLOCK-FLAG>
		       <SETG NORTH-BLOCK-FLAG T>
		       <TELL
"You pull the block out of the crumbling wall, revealing a dark passage
leading east." CR>)
		      (ELSE
		       <TELL
"It's too heavy." CR>)>)>>

<ROOM SECRET-PASSAGE
      (IN ROOMS)
      (DESC "Secret Passage")
      (WEST TO NORTH-CELL IF NORTH-BLOCK-FLAG)
      (UP
"Unfortunately, this passage was never completed, so you don't get very
far (neither did the prisoners).")
      (FLAGS RLANDBIT)
      (ACTION SECRET-PASSAGE-F)
      (GLOBAL STONE-WALL NORTH-BLOCK)>

<ROUTINE SECRET-PASSAGE-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is a crudely carved secret passage. It appears
to have been hollowed out by (perhaps) generations of prisoners.">
		<COND (,NORTH-BLOCK-FLAG
		       <TELL
" A passage leads west.">)
		      (ELSE
		       <TELL
" A square block in the western wall seems to be loose.">)>
		<TELL " A short, crudely hewn passage leads up." CR>)>>

<OBJECT SILVER-SPOON
	(IN SECRET-PASSAGE)
	(DESC "worn silver spoon")
	(FDESC
"Lying near the door is a silver spoon, discarded by the prisoners as too
soft to dig with. It is only slightly worn.")
	(SYNONYM SPOON)
	(ADJECTIVE WORN SILVER)
	(FLAGS TAKEBIT TREASURE TOOLBIT)>

;"<ROOM T-START ...> (IN TERROR)"

;"<ROOM GALLERY ...> (IN GALLERY)"

<ROOM SOUTH-GATE
      (IN ROOMS)
      (DESC "South Gate")
      (EAST TO SE-TOWER)
      (SOUTH TO MEADOW IF RUSTY-GATE IS OPEN)
      (WEST TO GALLERY)
      (NORTH TO EAST-HALL)
      (FLAGS RLANDBIT ONBIT)
      (ACTION SOUTH-GATE-F)
      (GLOBAL MEADOW-OBJ RUSTY-GATE BEACH-OBJ SEA)>

<ROUTINE SOUTH-GATE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This interior courtyard stands at the southern entrance to the castle, where
a small rusty gate ">
		<COND (<FSET? ,RUSTY-GATE ,OPENBIT>
		       <TELL
"is standing open and slowly swaying in a gentle sea
breeze">)
		      (ELSE
		       <TELL
"stands closed">)>
		<TELL 
". Beyond the gate can be seen a small meadow and, beyond that, a white
beach on a misty sea. Passages enter the castle proper to the north, east,
and west." CR>)>>

<OBJECT RUSTY-GATE
	(IN LOCAL-GLOBALS)
	(DESC "rusty gate")
	(SYNONYM GATE)
	(ADJECTIVE RUSTY SMALL)
	(FLAGS DOORBIT CONTBIT OPENBIT NDESCBIT)>

<ROOM EAST-HALL
      (IN ROOMS)
      (DESC "East Hall")
      (LDESC
"This short piece of corridor continues to the north and south.")
      (NORTH TO BANQUET-HALL)
      (SOUTH TO SOUTH-GATE)
      (FLAGS RLANDBIT)>

<ROOM SE-TOWER
      (IN ROOMS)
      (DESC "Tower")
      (LDESC
"This is the base of the southeast tower of the castle. From atop a winding
staircase comes a loud crashing and screeching noise. To the west is a
corridor and the southern gate of the castle.")
      (WEST TO SOUTH-GATE)
      (UP TO ENGINE-ROOM)
      (FLAGS RLANDBIT)
      (ACTION SE-TOWER-F)
      (GLOBAL STAIRS VOICES)>

;"<ROOM ENGINE-ROOM ...> in GEARS"

<ROOM BANQUET-HALL
      (IN ROOMS)
      (DESC "Banquet Hall")
      (NORTH TO JUNCTION)
      (SOUTH TO EAST-HALL)
      (EAST TO KITCHEN)
      (FLAGS RLANDBIT)
      (ACTION GUARD-WARNING-F)
      (ADVFCN ADV-VS-GANG)
      (GLOBAL VOICES)>

<OBJECT BANQUET-ILLUSION
	(IN BANQUET-HALL)
	(SYNONYM DECORATIONS)
	(ADJECTIVE FESTIVE)
	(DESC "festive decorations")
	(FLAGS CONTBIT TRANSBIT NDESCBIT OPENBIT)
	(ACTION BANQUET-STUFF-F)>

<ROUTINE BANQUET-STUFF-F ()
	 <COND (<AND <VERB? REZROV OPEN CLOSE LOOK-INSIDE EXAMINE>
		     <FSET? ,PRSO ,CONTBIT>>
		<FCLEAR ,PRSO ,CONTBIT>
		<PERFORM ,PRSA ,PRSO>
		<FSET ,PRSO ,CONTBIT>
		<RTRUE>)>>

<OBJECT BTABLES
	(IN BANQUET-ILLUSION)
	(DESC "tables")
	(SYNONYM TABLE TABLES)
	(ADJECTIVE WOODEN WOOD)
	(FLAGS NDESCBIT)
	(ACTION BANQUET-ILLUSION-F)>

<OBJECT BENCHES
	(IN BANQUET-HALL)
	(DESC "benches")
	(SYNONYM BENCH BENCHES)
	(ADJECTIVE WOOD WOODEN)
	(FLAGS NDESCBIT)
	(ACTION BANQUET-ILLUSION-F)>

<OBJECT IMPLEMENTS
	(IN BANQUET-ILLUSION)
	(DESC "golden cutlery")
	(SYNONYM CUTLERY CRYSTAL)
	(ADJECTIVE GOLD GOLDEN GLITTERING)
	(FLAGS NDESCBIT)
	(ACTION BANQUET-ILLUSION-F)>

<OBJECT FOOD
	(IN BANQUET-ILLUSION)
	(DESC "luscious food")
	(SYNONYM FOOD)
	(ADJECTIVE LUSCIOUS)
	(FLAGS NDESCBIT)
	(ACTION BANQUET-FOOD-F)>

<OBJECT CANDLES
	(IN BANQUET-ILLUSION)
	(DESC "banquet candles")
	(SYNONYM CANDLE)
	(ADJECTIVE BANQUET)
	(FLAGS NDESCBIT)
	(ACTION BANQUET-ILLUSION-F)>

<ROUTINE BANQUET-ILLUSION-F ()
	 <COND (<VERB? KULCAD>
		<REMOVE ,BANQUET-ILLUSION>
		<TELL
"The festive banquet setting dissolves, leaving a large hall littered with
broken benches." CR>)
	       (<AND <VERB? CLIMB-ON BOARD>
		     <EQUAL? ,PRSO ,BENCHES ,BTABLES>>
		<TELL "It's not worth the bother." CR>)
	       (<VERB? TAKE MOVE>
		<COND (<IN? ,BANQUET-ILLUSION ,HERE>
		       <TELL
"They seem to be protected by some magic; you can't budge them." CR>)
		      (T
		       <TELL
"You realize there is no point in that." CR>)>)>>

<ROUTINE BANQUET-FOOD-F ()
	 <COND (<VERB? EAT TAKE>
		<TELL
"The food is quite delicious, but somehow unsatisfying." CR>)
	       (T <BANQUET-ILLUSION-F>)>>

<ROUTINE GUARD-WARNING-F (RARG "AUX" (LP <LOC ,PLAYER>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<EQUAL? .LP ,BANQUET-HALL>
		       <COND (<FSET? ,BANQUET-HALL ,RMUNGBIT>
			      <REMOVE ,BANQUET-ILLUSION>
			      <TELL
"This desolate hall is nearly empty, save for a few long benches which
are scattered throughout the room. The walls seem to be scorched, and
everywhere are signs of decay. A sickening odor pervades the room, and
wisps of acrid black smoke can be seen to the north. A wide passage leads
south, and a small one opens to the east." CR>)
			     (<IN? ,BANQUET-ILLUSION ,BANQUET-HALL>
			      <TELL
"A banquet has been set here for hundreds. Long benches fill the room, each
covered with finest linen and set with golden cutlery and glittering
crystal. Luscious food weighs down each table, and candles light the room
with a festive glow. The room can be entered by a north-south corridor and
a small opening to the east, from which an odd, acrid smell issues." CR>)
			     (T
			      <TELL
"This hall is completely empty, except for some long benches which are
scattered throughout the room." CR>)>)
		      (<EQUAL? .LP ,LIBRARY>
		       <TELL <GETP .LP ,P?LDESC> CR>)
		      (ELSE <RFALSE>)>
		<COND (<NOT <IN? ,GANG-OF-FOUR .LP>>
		       <TELL "To the ">
		       <COND (<EQUAL? .LP ,LIBRARY>
			      <TELL "south">)
			     (T <TELL "north">)>
		       <TELL
" you can hear the sound of a group of low, guttural voices." CR>)>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <EQUAL? ,WINNER ,PLAYER>
		     <VERB? WALK>
		     <NOT ,PROTECTED-FROM-EVIL>
		     <IN? ,GANG-OF-FOUR .LP>>
		<COND (<OR <AND <EQUAL? .LP ,LIBRARY>
				<==? ,PRSO ,P?SOUTH>>
			   <AND <EQUAL? .LP ,BANQUET-HALL>
				<==? ,PRSO ,P?NORTH>>>
		       <TELL
"In your confused and fearful state, you have blundered right into the
advancing guards! They grab you, not too gently, and take you away. You end up
at a huge temple." CR CR>
		       <QUEUE I-GUARDS-ARRIVE 0>
		       <QUEUE I-GANG 0>
		       <TAKE-TO-TOWER>
		       <RTRUE>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <PROB 30>
		     <EQUAL? .LP ,LIBRARY ,BANQUET-HALL>
		     <NOT <IN? ,GANG-OF-FOUR .LP>>>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TELL
"The low, guttural voices seem to be coming in your direction." CR>)>
		<ENABLE <QUEUE I-GUARDS-ARRIVE 2>>
		<RTRUE>)>>
		
<ROUTINE I-GUARDS-ARRIVE ("AUX" (LP <LOC ,PLAYER>))
	 <COND (<EQUAL? .LP ,LIBRARY ,BANQUET-HALL>
		<TELL
"A group of four hunched and hairy shapes walks into your presence. ">
		<COND (<NOT ,PROTECTED-FROM-EVIL>
		       <MOVE ,GANG-OF-FOUR .LP>
		       <TELL
"They
seem surprised to see you. After whispering a few guttural words to each
other, they start to move toward you purposefully." CR>
		       <SETG GANG-FOLLOWS 0>
		       <ENABLE <QUEUE I-GANG 1>>)
		      (T
		       <TELL
"They
don't seem to take much notice of you, and they soon depart." CR>)>)>>

<GLOBAL GANG-FOLLOWS 0>

<ROUTINE I-GANG ()
	 <SETG GANG-FOLLOWS <+ ,GANG-FOLLOWS 1>>
	 <COND (<IN? ,GANG-OF-FOUR <LOC ,PLAYER>>
		<REMOVE ,GANG-OF-FOUR>
		<COND (,PROTECTED-FROM-EVIL
		       <TELL
"The group of hunched and hairy shapes glances at you disinterestedly,
wanders around the room for a while, and then departs." CR>)
		      (T
		       <TELL
"The group of hunched and hairy shapes takes you in their arms and escorts
you into a huge temple." CR CR>
		       <TAKE-TO-TOWER>
		       <RTRUE>)>)
	       (<FSET? <LOC ,PLAYER> ,RMUNGBIT>
		<TELL
"The group of shapes follows you, intent on your capture! They seem to
come alive in the desolation which fills this room." CR>
		<MOVE ,GANG-OF-FOUR <LOC ,PLAYER>>
		<QUEUE I-GANG 1>
		<RTRUE>)
	       (<L? ,GANG-FOLLOWS ,LOSSAGE>
		<TELL
"The group of shapes follows you into this undespoiled room, emboldened
and eager for blood." CR>
		<MOVE ,GANG-OF-FOUR <LOC ,PLAYER>>
		<QUEUE I-GANG 1>
		<RTRUE>)
	       (T 
		<TELL
"Fortunately for you, the gang has stopped following! You relax for a
moment and heave a sigh of relief." CR>
		<REMOVE ,GANG-OF-FOUR>
		<RFALSE>)>>

<OBJECT GANG-OF-FOUR
	(DESC "group of hairy shapes")
	(LDESC "A group of hunched and hairy shapes is standing here.")
	(SYNONYM SHAPES COUPLE GUARDS BEINGS)
	(ADJECTIVE HAIRY HUNCHED GROUP)
	(FLAGS VICBIT)
	(ACTION GANG-OF-FOUR-F)>

<ROUTINE GANG-OF-FOUR-F ()
	 <COND (<VERB? CLEESH>
		<TELL
"The group of shapes turns into a small convention of newts, who run away." CR>
		<QUEUE I-GANG 0>
		<REMOVE ,GANG-OF-FOUR>)
	       (<VERB? VAXUM>
		<COND (,PROTECTED-FROM-EVIL <RFALSE>)
		      (T
		       <TELL
"The shapes, who were on the verge of reaching you, seem to waver in their
resolve. After a moment's pause, they leave the room together, talking
in a less guttural tone which might correspond to cheerfulness." CR>
		       <REMOVE ,GANG-OF-FOUR>
		       <QUEUE I-GANG 0>
		       <RTRUE>)>)
	       (<VERB? GUNCHO>
		<TELL
"The shapes">
		<COND (<NOT ,PROTECTED-FROM-EVIL>
		       <TELL ", on the verge of reaching you,">)>
		<TELL " disappear, seeming to dwindle into the distance
while remaining in the same spot. Eventually you can see them no longer." CR>
		<REMOVE ,GANG-OF-FOUR>)
	       (<AND <VERB? ZIFMIA> ,PROTECTED-FROM-EVIL>
		<ENABLE <QUEUE I-GANG 2>>
		<TELL
"The shapes, previously ignoring you, now approach with menace in their
eyes." CR>)
	       (<VERB? FROTZ>
		<TELL
"The shapes glow brightly from the frotz spell. This apparently doesn't
appeal to them, as they shriek with horror and attempt to avert their
gaze from themselves. Within a moment, they have run screaming from the
room." CR>
		<REMOVE ,GANG-OF-FOUR>)
	       (<AND <VERB? NITFOL> <NOT ,PROTECTED-FROM-EVIL>>
		<TELL
"The shapes, whose language you understand instinctively, say something
on the order of \"Blood for sacrifice!\", \"Master pleased!\", and other
not-so-soothing words as they approach." CR>)>> 

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (LDESC
"The kitchen is dusty and disused. Old bones litter the floor, and the
carving knives are rusty. A rat nest fills one of the ovens, and cobwebs
are everywhere. There is some rotting food in a garbage heap in one corner.")
      (MUNGDESC
"The kitchen has been freshly used. The oven, though empty, is still
warm. Bones litter the floor, and the carving knives are bloody. The
bones give all too clear an indication of the nature of the viands
prepared here.")
      (WEST TO BANQUET-HALL)
      (FLAGS RLANDBIT)>

<OBJECT LITTER
	(IN KITCHEN)
	(DESC "various and sundry items")
	(SYNONYM KNIVES KNIFE BONES COBWEBS)
	(ADJECTIVE OLD CARVING RUSTY HUGE)
	(FLAGS NDESCBIT)
	(ACTION LITTER-F)>

<ROUTINE LITTER-F ()
	 <COND (<VERB? TAKE>
		<TELL "You have no use for those things." CR>)
	       (<VERB? EXAMINE>
		<TELL
"They look as if they haven't been disturbed in a long time." CR>)>>

<OBJECT RAT-NEST
	(IN OVEN)
	(DESC "rat nest")
	(SYNONYM NEST)
	(ADJECTIVE RAT)
	(FLAGS NDESCBIT)
	(ACTION RAT-NEST-F)>

<ROUTINE RAT-NEST-F ()
	 <COND (<VERB? TAKE>
		<TELL "What on earth for?" CR>)
	       (<VERB? RUB MUNG>
		<TELL
"You poke around in the nest, but there doesn't seem to be anything
of interest in there." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "There's nothing in there." CR>)>>

<OBJECT OVEN
	(IN KITCHEN)
	(DESC "oven")
	(SYNONYM OVEN)
	(FLAGS NDESCBIT VOWELBIT CONTBIT OPENBIT)
	(ACTION OVEN-F)>

<ROUTINE OVEN-F ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE REACH-IN>
		<TELL
"The oven contains nothing of interest, unless of course you have a
hankering for rat's nests." CR>)
	       (<VERB? OPEN REZROV>
		<COND (<FSET? ,OVEN ,OPENBIT>
		       <TELL "The oven is already open." CR>)
		      (T
		       <FSET ,OVEN ,OPENBIT>
		       <TELL "Opened." CR>)>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? ,OVEN ,OPENBIT>>
		       <TELL "The oven is already closed." CR>)
		      (T
		       <FCLEAR ,OVEN ,OPENBIT>
		       <TELL "Closed." CR>)>)>>

<OBJECT HEAP
	(IN KITCHEN)
	(DESC "heap of garbage")
	(SYNONYM HEAP FOOD)
	(ADJECTIVE GARBAGE ROTTED ROTTIN)
	(FLAGS NDESCBIT)
	(ACTION HEAP-F)>

<ROUTINE HEAP-F ()
	 <COND (<VERB? TAKE>
		<TELL "That would be rather undignified." CR>)
	       (<VERB? SEARCH LOOK-INSIDE DIG>
		<TELL "There is nothing but rotted food there." CR>)>>

<ROOM JUNCTION
      (IN ROOMS)
      (DESC "Junction")
      (LDESC
"The corridor widens here to form a large hall. To the north and south are
small passages, and to the east is what appears to be an enormous spiral
staircase. A passage to the west leads into a courtyard. The walls here are
scarred and black, and a strange heaviness hangs in the air.")
      (WEST TO COURTYARD-7)
      (EAST TO LANDING)
      (SOUTH TO BANQUET-HALL)
      (NORTH TO LIBRARY)
      (FLAGS RLANDBIT RMUNGBIT)
      (ACTION JUNCTION-F)
      (GLOBAL STAIRS)
      (ADVFCN ADV-VS-GANG)>

<ROUTINE JUNCTION-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <EQUAL? ,WINNER ,PLAYER>
		     <NOT ,PROTECTED-FROM-EVIL>>
		<TELL
"A host of hunched and hairy shapes walk into the hall before you can
do anything and, seeing you, take you in their arms and escort you to the
west into a huge temple." CR CR>
		<GOTO ,TEMPLE>)>>

<ROUTINE ADV-VS-GANG ("AUX" (L <LOC ,ADVENTURER>))
	 <COND (<AND <IN? ,WINNER .L>
		     <IN? ,GANG-OF-FOUR .L>>
		<MOVE ,ADVENTURER
		      <COND (<IN? ,WINNER ,LIBRARY> ,NORTH-GATE)
			    (ELSE ,EAST-HALL)>>
		<TELL
"The adventurer softly, silently, and stealthily disappears." CR>)
	       (<AND <IN? ,ADVENTURER ,JUNCTION>
		     <EQUAL? <LOC ,WINNER> ,LIBRARY ,BANQUET-HALL>>
		<TELL
"You hear yelling, oaths, and the crash of metal coming from the "
<COND (<IN? ,WINNER ,LIBRARY> "south")(T "north")> 
".
It sounds like a swordfight! Suddenly, everything is quiet." CR>
		<COND (<PROB 70>
		       <MOVE ,ADVENTURER
			     <COND (<IN? ,WINNER ,LIBRARY> ,NORTH-GATE)
				   (ELSE ,EAST-HALL)>>
		       <SETG ADV-OLD-LOC ,HERE>
		       <SETG ADV-NEW-LOC <LOC ,ADVENTURER>>
		       <TELL
"Then the adventurer, running at an impressive speed, tears by you heading "
		       <COND (<IN? ,WINNER ,LIBRARY> "north")
			     (ELSE "south")>
		       ". He seems to have been in a fight." CR>)
		      (ELSE
		       <REMOVE ,ADVENTURER>
		       <MOVE ,SKELETON ,TOWER-S>
		       <QUEUE I-ADVENTURER 0>)>)>>

<OBJECT SKELETON
	(DESC "skeleton")
	(SYNONYM SKELETON HEAP BONES)
	(ADJECTIVE HUMAN)
	(LDESC
"Lying in a heap on the ground are what appear to be human bones, picked
entirely clean.")
	(ACTION SKELETON-F)>

<ROUTINE SKELETON-F ()
	 <COND (<VERB? TAKE>
		<TELL
"They're quite heavy, and you don't need them anyway." CR>)
	       (<VERB? MUNG ATTACK KILL>
		<TELL
"Show some respect! Especially considering that he got that way because of
you!" CR>)>>	

<ROOM LIBRARY
      (IN ROOMS)
      (DESC "Library")
      (LDESC
"This is a library, or rather it was until it was ransacked and despoiled.
Most of the contents of the room have been burned in a huge bonfire in the
center of the room. Hundreds of charred and empty tubes are scattered
about, as if by someone searching, so ashes are strewn about. There
are rat tracks in the ashes.")
      (NORTH TO NORTH-GATE)
      (SOUTH TO JUNCTION)
      (FLAGS RLANDBIT)
      (ACTION GUARD-WARNING-F)
      (ADVFCN ADV-VS-GANG)
      (GLOBAL VOICES)
      (PSEUDO "ASHES" ASHES-PSEUDO "TUBES" TUBES-PSEUDO)>

<OBJECT VOICES
	(IN LOCAL-GLOBALS)
	(DESC "noise")
	(SYNONYM VOICES NOISE NOISES DRONING)
	(ADJECTIVE LOW GUTTURAL SCREECHING)
	(ACTION VOICES-F)>

<ROUTINE VOICES-F ()
	 <COND (<EQUAL? ,HERE ,ENGINE-ROOM ,SE-TOWER>
		<COND (<VERB? LISTEN EXAMINE>
		       <TELL "The noise is loud and screeching." CR>)>)
	       (<EQUAL? ,HERE ,COURTYARD-3 ,ALTAR>
		<COND (<VERB? LISTEN>
		       <TELL
"The voices are chanting something horrifying." CR>)>)
	       (<VERB? LISTEN>
		<TELL
"You can't make out what they are saying, though it would be fair to say
it's not too pleasant." CR>)
	       (<VERB? ZIFMIA>
		<TELL
"The voices seem to be approaching. I hope you know what you're doing." CR>
		<ENABLE <QUEUE I-GUARDS-ARRIVE 1>>)
	       (<VERB? NITFOL>
		<TELL
"You can't use that spell on voices, only beings." CR>)>>

<ROUTINE TUBES-PSEUDO ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "They are all empty." CR>)
	       (<VERB? TAKE>
		<TELL "As you touch each one, it crumbles to ash." CR>)>>

<ROUTINE ASHES-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL "The ash slips through your fingers." CR>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,LIBRARY>
		       <TELL
"The ashes have rat tracks in them. Little rat thoroughfares head here
and there, but most head in one direction." CR>)
		      (ELSE
		       <TELL
"The ashes are black and greasy." CR>)>)
	       (<VERB? SEARCH LOOK-INSIDE>
		<TELL
"You find nothing of interest in the ashes">
		<COND (<EQUAL? ,HERE ,LIBRARY>
		       <TELL ", other than rat tracks heading
this way and that">)>
		<TELL "." CR>)>>

<OBJECT RAT-TRACKS
	(IN LIBRARY)
	(DESC "tracks")
	(SYNONYM TRACK TRACKS)
	(ADJECTIVE RAT)
	(FLAGS NDESCBIT)
	(ACTION RAT-TRACKS-F)>

<ROUTINE RAT-TRACKS-F ()
	 <COND (<VERB? FOLLOW EXAMINE>
		<TELL
"There are plenty of rat tracks here, going in various directions. One
prominent rodentine thoroughfare stands out though, going as it does into
a small hole in the wall." CR>
		<MOVE ,RAT-HOLE ,HERE>)>>

<OBJECT RAT-HOLE
	(DESC "rat hole")
	(SYNONYM HOLE)
	(ADJECTIVE RAT SMALL)
	(LDESC
"Inspection has revealed that the tracks lead into a small hole in the wall.")
	(FLAGS CONTBIT OPENBIT)
	(CAPACITY 10)
	(ACTION RAT-HOLE-F)>

<ROUTINE RAT-HOLE-F ("AUX" OBJ)
	 <SET OBJ <FIRST? ,RAT-HOLE>>
	 <COND (<VERB? EXAMINE>
		<TELL "You can't see anything in the rat hole." CR>)
	       (<VERB? REACH-IN>
		<TELL
"You reach around for a moment and come up ">
		<COND (<NOT .OBJ>
		       <TELL "empty." CR>)
		      (T
		       <TELL "with something. It's " A .OBJ "." CR>
		       <THIS-IS-IT .OBJ>
		       <FCLEAR .OBJ ,INVISIBLE>
		       <SETG SCORE <+ ,SCORE ,QUENCH-POINT>>
		       <SETG QUENCH-POINT 0>
		       <FSET ,RAT-HOLE ,NDESCBIT>
		       <MOVE .OBJ ,WINNER>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"It's too dark to see anything inside the hole." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,RAT-HOLE>>
		<COND (<FIRST? ,RAT-HOLE>
		       <TELL
"Something's blocking up the hole from inside." CR>)
		      (<G? <GETP ,PRSO ,P?SIZE> 5>
		       <TELL "It won't fit." CR>)
		      (T
		       <FSET ,PRSO ,INVISIBLE>
		       <MOVE ,PRSO ,PRSI>
		       <TELL "Done." CR>)>)
	       (<VERB? CLOSE>
		<TELL "How absurd!" CR>)>>

<ROOM NORTH-GATE
      (IN ROOMS)
      (DESC "North Gate")
      (LDESC
"This small open area stands at the old north gate of the castle, now badly
rusted. Through the gate, a forest can be seen. To the west, a hall glows with
light, and to the south, the dark castle can be reentered. A narrow passage
to the east leads to the base of the northeast tower.")
      (WEST TO MIRROR-HALL-4)
      (SOUTH TO LIBRARY)
      (EAST TO PURLOINED-ROOM)
      (NORTH TO FOREST-1 IF NORTH-GATE-OBJ IS OPEN
        ELSE "The gate is rusted shut.")
      (FLAGS RLANDBIT)
      (GLOBAL FOREST NORTH-GATE-OBJ TOWER)>

<OBJECT NORTH-GATE-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "gate")
	(SYNONYM GATE)
	(ADJECTIVE NORTH RUSTED OLD RUSTY)
	(FLAGS NDESCBIT LOCKEDBIT DOORBIT CONTBIT)
	(ACTION NORTH-GATE-OBJ-F)>

<ROUTINE NORTH-GATE-OBJ-F ()
	 <COND (<AND <VERB? REZROV> <NOT <FSET? ,PRSO ,OPENBIT>>>
		<TELL
"The rusted north gate magically creaks open far enough for you to
leave." CR>
		<FSET ,PRSO ,OPENBIT>
		<FCLEAR ,PRSO ,LOCKEDBIT>)
	       (<AND <VERB? OPEN> <FSET? ,PRSO ,LOCKEDBIT>>
		<TELL "The gate is rusted shut." CR>)>>

<ROOM FOREST-1
      (IN ROOMS)
      (DESC "Forest")
      (LDESC
"You are in a dark forest, just north of a rusted gate. Except to
the east and south, the forest is thick all around you.")
      ;(MUNGDESC
"You are in a blasted and ruined forest. The trees are covered with ash,
and their leaves are gone. Most of their limbs are cracked, and many
litter the ground. A thin pall of smoke fills the air. There is a rusted
gate to the south. The desolation continues in all other directions but east.")
      (SOUTH TO NORTH-GATE)
      (NORTH "The forest is deep and dark. I wouldn't go in there.")
      (EAST TO FOREST-2)
      (WEST "The forest is deep and dark. I wouldn't go in there.")
      (NE "The forest is deep and dark. I wouldn't go in there.")
      (NW "The forest is deep and dark. I wouldn't go in there.")
      (SE "The forest is deep and dark. I wouldn't go in there.")
      (SW "The forest is deep and dark. I wouldn't go in there.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL NORTH-GATE-OBJ FOREST TREES)
      (ACTION FOREST-1-F)>

<ROUTINE FOREST-1-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,REPAIR-SCROLL ,HERE>
		     <NOT <FSET? ,REPAIR-SCROLL ,TOUCHBIT>>>
		<THIS-IS-IT ,REPAIR-SCROLL>
		<RFALSE>)>>

;"One Froggy Evening..."

<ROOM FOREST-2
      (IN ROOMS)
      (DESC "Swamp")
      (LDESC
"You are in a thick forest shading into a deep and miasmic swamp.
The ground is very wet and boggy here, and footing is treacherous.
Lily pads cover the surface of the water, and frogs abound. Things
look drier to the west.")
      (SOUTH "There could be quicksand there. You should stay here.")
      (NORTH "There could be quicksand there. You should stay here.")
      (EAST "There could be quicksand there. You should stay here.")
      (WEST TO FOREST-1)
      (NE "There could be quicksand there. You should stay here.")
      (NW "There could be quicksand there. You should stay here.")
      (SE "There could be quicksand there. You should stay here.")
      (SW "There could be quicksand there. You should stay here.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (ACTION SWAMP-F)
      (GLOBAL FOREST GLOBAL-WATER)
      (PSEUDO "SWAMP" SWAMP-PSEUDO)>

<ROUTINE SWAMP-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <==? .RARG ,M-END>
		     <NOT <VERB? TELL>>>
		<TELL
"The sounds of frogs and other swamp dwellers fill the air.">
		<COND (<==? ,TALK-TO-ANIMAL? ,FROG>
		       <COND (<NOT <FSET? ,NEWT-SCROLL ,INVISIBLE>>
			      <TELL " The frogs are discussing
">
			      <TELL <PICK-ONE ,FROG-TALKS>>)
			     (ELSE
			      <TELL " The frogs say
\"Look under the lily pad. Breep!\"">)>)
		      ;(ELSE
		       <TELL " The sounds they make
are almost on the border of comprehension.">)>
		<CRLF>
		<RFALSE>)>>

<ROUTINE SWAMP-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? THROUGH>
		<TELL
"There is probably quicksand there. At best you would get
horribly muddy." CR>)>>

<GLOBAL FROG-TALKS <LTABLE 0
"what they will do if they ever become princes again."
"the finer points of insect flavoring."
"the politics of lily pad assignment."
"the Interlogic series of prose adventures."
"the recent disturbing rise in the number of predators in the swamp.">>

<OBJECT FROG
	(IN FOREST-2)
	(DESC "frog")
	(SYNONYM FROG FROGS)
	(FLAGS NDESCBIT VILLAIN VICBIT)
	(ACTION FROG-F)>

<ROUTINE FROG-F ()
	 <COND (<AND <EQUAL? ,WINNER ,FROG>
		     <NOT <VERB? HELLO>>>
		<TELL "\"Breep! No, thank you. Breep!\"" CR>)
	       (<VERB? HELLO LISTEN>
		<TELL "\"Breep! ">
		<COND (<EQUAL? ,TALK-TO-ANIMAL? ,FROG>
		       <TELL <PICK-ONE ,FROGGERS> " ">)>
		<TELL "Breep!\"" CR>)>>

<GLOBAL FROGGERS <LTABLE 0
"Hiya! Seen any juicy flies?"
"Awful day, isn't it?"
"Tell Belboz that Fr'nb-ap says hello!">>

<OBJECT LILY-PAD
	(IN FOREST-2)
	(DESC "lily pad")
	(SYNONYM PAD PADS LILIES)
	(ADJECTIVE LILY)
	(FLAGS NDESCBIT CONTBIT SURFACEBIT OPENBIT)
	(ACTION LILY-PAD-F)>

<ROUTINE LILY-PAD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"There's not much to say about the lily pads except that they seem to make a
cheery home for the frogs." CR>)
	       (<VERB? THROUGH CLIMB-ON>
		<TELL
"You sink into the goo, crushing a lily pad." CR>)
	       (<VERB? LOOK-UNDER>
		<COND (<FSET? ,NEWT-SCROLL ,INVISIBLE>
		       <FCLEAR ,NEWT-SCROLL ,INVISIBLE>
		       <MOVE ,NEWT-SCROLL ,WINNER>
		       <TELL
"There is a damp scroll there, which you take into your hand." CR>)
		      (T <TELL "There is nothing there but goo." CR>)>)>>

;"<ROOM PURLOINED-ROOM ...> (IN PURLOINED.ZIL)"

;"<ROOM MIRROR-HALL-N ...> (IN PURLOINED.ZIL)"

<ROOM NW-TOWER
      (IN ROOMS)
      (DESC "Tower")
      (LDESC
"This is the base of the northwest tower of the castle. A winding staircase
leads up into the tower itself, and passages lead from here to the east and
south.")
      (UP TO JEWEL-ROOM)
      (EAST TO MIRROR-HALL-1)
      (SOUTH TO PEBBLED-PATH)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS TOWER)>

;"<ROOM JEWEL-ROOM ...> (IN EGG)"

<ROOM COURTYARD-2
      (IN ROOMS)
      (DESC "Courtyard")
      (LDESC 
"This is the northern part of the large interior courtyard of the castle.
The vast lawns continue from here south and west. To the southeast stands
a huge temple, on either side of which are dark towers. The courtyard
continues east along a narrow path.")
      (MUNGDESC
"The northern part of the interior courtyard is grey and lifeless. The
vast lawns are withered and covered in black ash stretching from south
to west. The temple stands to the southeast, and the courtyard continues
east.")
      (SW TO COURTYARD-1)
      (SE TO TEMPLE)
      (WEST TO COURTYARD-1)
      (EAST TO COURTYARD-5)
      (SOUTH TO COURTYARD-3)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL COURTYARD LAWN TEMPLE-OBJ)>

<ROOM COURTYARD-3
      (IN ROOMS)
      (DESC "Courtyard")
      (LDESC 
"You are in the center of a large courtyard, which surrounds you in all
directions. Directly in front of you, to the east, is a large temple flanked
by two smaller towers. Behind the temple can be seen the two eastern towers
of the castle, shrouded in fog, and the single dark turret, black as night and
sending dark streams of smoke into a lowering sky. From the temple comes
a howling, haunting chant.")
      (MUNGDESC 
"You are in the center of a large courtyard, which surrounds you. Everything
around you is ashen and grey, and the air seems miasmic and oppressive. The
dead grass seems to grab at your feet as you stand gazing around. To
the east is a temple flanked by two smaller towers. Behind it can be seen
the two eastern towers of the castle, shrouded in blood-red fog. Between them
is a dark turret, black and ominous as night. It sends dark streams of smoke
curling around everything near it. From the temple can be heard a mournful
chant.")
      (NORTH TO COURTYARD-2)
      (SOUTH TO COURTYARD-4)
      (EAST TO TEMPLE)
      (WEST TO COURTYARD-1)
      (NE TO COURTYARD-5)
      (SE TO COURTYARD-6)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL COURTYARD LAWN TEMPLE-OBJ TOWER TURRET VOICES)>

<ROOM COURTYARD-4
      (IN ROOMS)
      (DESC "Courtyard")
      (LDESC 
"This is the southern part of the great courtyard, which spreads out to
the north and west. A narrow stretch of grass continues to the east. To
the northeast stands the temple, flanked by two small towers.")
      (MUNGDESC
"This is the southern part of the courtyard, spreading north and west.
The ground is ashen and grey, and the air heavy with death. The dead grass
seems to grab at your feet. A narrow stretch of scorched earth continues to
the east. To the northeast stands the temple, flanked by two small towers.")
      (EAST TO COURTYARD-6)
      (NW TO COURTYARD-1)
      (WEST TO COURTYARD-1)
      (NORTH TO COURTYARD-3)
      (NE TO TEMPLE)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL COURTYARD LAWN TEMPLE-OBJ TOWER)>

<ROOM COURTYARD-5
      (IN ROOMS)
      (DESC "Courtyard")
      (LDESC 
"You are north of a small tower which connects with the temple to
the south. A large courtyard can be seen to the west and a smaller one
to the southeast.")
      ;(MUNGDESC
"You are north of a small tower which connects with the temple to the south.
A large courtyard lies to the west and a smaller one to the southeast. The
ground here is dark and hard, with wisps of acrid smoke hanging ominously
in the still air.")
      (SE TO COURTYARD-7)
      (SW TO COURTYARD-3)
      (WEST TO COURTYARD-2)
      (SOUTH "There is no entrance to the tower here.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL COURTYARD LAWN TEMPLE-OBJ TOWER)>

<ROOM COURTYARD-6
      (IN ROOMS)
      (DESC "Courtyard")
      (LDESC 
"You are south of a small tower which connects with the temple to
the north. A large courtyard can be seen to the west and a smaller one
to the northeast.")
      ;(MUNGDESC
"You are south of a small tower which connects with the temple to the north.
A large courtyard can be seen to the west and a smaller one to the northeast.
No grass grows in this area however and the few trees are dark and lifeless.")
      (NE TO COURTYARD-7)
      (NW TO COURTYARD-3)
      (WEST TO COURTYARD-4)
      (NORTH "There is no entrance to the tower here.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL COURTYARD LAWN TOWER TEMPLE-OBJ TREES)>

<ROOM COURTYARD-7
      (IN ROOMS)
      (DESC "Courtyard")
      (LDESC 
"You are standing in a small courtyard between a large open hall to
the east and a temple to the west. The temple is flanked to the north
and south by two small towers. Paths cross the lawn to the northwest and
southwest.")
      (MUNGDESC
"You are in a courtyard between an open hall to the east and a temple to
the west. The temple is flanked, north and south, by twin towers. Paths
cross the scarred lawn to the northwest and southwest. Nothing now grows
here, however, and a foul stench fills the air.")
      (EAST TO JUNCTION)
      (WEST TO TEMPLE)
      (SW TO COURTYARD-6)
      (NW TO COURTYARD-5)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL COURTYARD LAWN TEMPLE-OBJ TOWER)>

;"<ROOM MEADOW ...> and <ROOM BEACH ...> in GEARS"

<GLOBAL MUNG-ROOM-TABLE
	<TABLE ALTAR TEMPLE TOWER-N TOWER-S
	       COURTYARD-7 COURTYARD-3 JUNCTION COURTYARD-4
	       COURTYARD-2 LANDING COURTYARD-6 COURTYARD-5
	       LIBRARY BANQUET-HALL COURTYARD-1 KITCHEN
	       NORTH-GATE EAST-HALL FOREST-1 CLOSET
	       INSIDE-GATE WEST-HALL SOUTH-GATE MEADOW
	       SE-TOWER PEBBLED-PATH SW-TOWER BEDROOM
	       <>>>