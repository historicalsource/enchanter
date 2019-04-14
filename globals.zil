"GLOBALS for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<DIRECTIONS ;"Do not change the order of the first eight
	      without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<ROUTINE NULL-F () <RFALSE>>

"SUBTITLE GLOBAL OBJECTS"

<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT
	       OPENBIT SEARCHBIT TRANSBIT ;WEARBIT VOWELBIT
	       ONBIT RLANDBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	(DESCFCN 0)
        (GLOBAL GLOBAL-OBJECTS)
	(ADVFCN 0)
	(FDESC "F")
	(LDESC "F")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(SIZE 0)
	(CAPACITY 0)>
;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(DESC "pseudo")
	(ACTION CRETIN)>

<OBJECT IT	;"was IT"
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THAT HER HIM)
	(DESC "random object")
	(FLAGS NDESCBIT TOUCHBIT)>

<OBJECT GROUND	;"was GROUND"
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND)
	(ADJECTIVE STONE)
	(DESC "floor")
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-ON CLIMB-FOO BOARD>
		<TELL "You've got better things to do." CR>)>>

<OBJECT CORRIDOR
	(IN GLOBAL-OBJECTS)
	(DESC "passage")
	(SYNONYM PASSAGE CORRIDOR ENTRANCE)
	(ACTION CORRIDOR-F)>

<ROUTINE CORRIDOR-F ()
	 <COND (<VERB? THROUGH WALK-TO>
		<USE-DIRECTIONS>)>>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "castle wall")
	(SYNONYM WALL WALLS CASTLE)
	(ADJECTIVE TRANSLUCENT)
	(ACTION WALLS-F)>

<ROUTINE WALLS-F ()
	 <COND (<AND <EQUAL? ,WALLS ,PRSO>
		     <EQUAL? ,HERE ,NORTH-CELL>>
		<PERFORM ,PRSA ,STONE-WALL>)
	       (<FSET? ,HERE ,RMUNGBIT>
		<COND (<VERB? EXAMINE>
		       <TELL
"The wall is stained and noisome." CR>)
		      (<VERB? LISTEN>
		       <TELL
"That's noisome, not noisy!" CR>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"They're translucent, not transparent!" CR>)>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN)>

<OBJECT HANDS	;"was HANDS"
	(IN GLOBAL-OBJECTS)
	(SYNONYM HAND HANDS)
	(ADJECTIVE BARE)
	(DESC "bare hands of a novice enchanter")
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT)>

<OBJECT PLAYER		;"was ADVENTURER"
	(SYNONYM ENCHANTER)
	(DESC "cretin")
	(FLAGS VILLAIN NDESCBIT INVISIBLE)
	(ACTION 0)>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF FACE)
	(DESC "you")
	(FLAGS VILLAIN TOUCHBIT)
	(ACTION CRETIN)> 
	
<ROUTINE CRETIN ()
	 <COND (<VERB? ESCAPE>
		<TELL "There's no escaping yourself." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSO ,EGG>>
		<TELL
"If you don't succeed, there will be plenty of egg on your face." CR>)
	       (<VERB? BURN>
		<TELL "Ouch!" CR>)
	       (<VERB? LISTEN>
		<TELL "Yes?" CR>)
	       (<VERB? ALARM>
		<TELL "You are obviously awake already." CR>)
	       (<VERB? GUNCHO>
		<TELL
"You vanish into oblivion where, to the relief of much of the Circle, you
will be unable to do much harm." CR>
		<FINISH>)
	       (<VERB? FROTZ>
		<FSET ,PLAYER ,ONBIT>
		<SETG ALWAYS-LIT T>
		<TELL
"You are bathed in a sickly yellow light, bright enough to read by." CR>)
	       (<VERB? BLORB>
		<JIGS-UP
"You experience the most peculiar sensation of being simultaneously shrunken
and sucked into what might best be likened to a black hole. The effect is not
without its exhilarating aspect; as a way of life, however, it leaves much to
be desired." <>>
		<RTRUE>)
	       (<VERB? KULCAD>
		<TELL
"You seem real enough already." CR>)
	       (<VERB? EXAMINE>
		<TELL "You are not a pretty sight." CR>)
	       (<VERB? GIVE>
		<TELL "I think you're a little confused." CR>)
	       (<VERB? KILL MUNG ATTACK>
		<TELL "You don't need my help to do that!" CR>)
	       (<VERB? FIND>
		<TELL "You're right here!" CR>)
	       (<AND <VERB? CUT> <==? ,PRSI ,MAGIC-KNIFE>>
		<TELL
"I should think one experience with that knife would be enough. I wouldn't
press my luck." CR>)>>

;"GLOBAL VARIABLES"

<GLOBAL HERE <>>

<GLOBAL LOAD-ALLOWED 100>

<GLOBAL LOAD-MAX 100>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW)
	(ADJECTIVE BROKEN)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<G? ,TOD ,NIGHTFALL>
		       <TELL "It's too dark to make out much of anything." CR>)
		      (T <TELL <GETP ,HERE ,P?TEXT> CR>)>)
	       (<VERB? OPEN>
		<TELL "You can't open it." CR>)
	       (<VERB? CLOSE>
		<TELL "It already is." CR>)>>

<OBJECT SEA
	(IN LOCAL-GLOBALS)
	(DESC "sea")
	(SYNONYM OCEAN SEA)
	(ADJECTIVE MISTY)
	(ACTION SEA-F)>

<ROUTINE SEA-F ()
	 <COND (<NOT <EQUAL? ,HERE ,BEACH>>
		<TELL
"The sea is off beyond the beach." CR>)
	       (<VERB? THROUGH>
		<TELL "You would drown." CR>)
	       (<VERB? EXAMINE>
		<TELL "The sea is very rough. I wouldn't go in." CR>)>>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(DESC "forest")
	(SYNONYM FOREST)
	(ACTION FOREST-F)>

<ROUTINE FOREST-F ()
	 <COND (<VERB? THROUGH>
		<USE-DIRECTIONS>)>>

<OBJECT TEMPLE-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "temple")
	(SYNONYM TEMPLE)
	(ACTION TEMPLE-OBJ-F)>

<ROUTINE TEMPLE-OBJ-F ()
	 <COND (<OR <EQUAL? ,HERE ,COURTYARD-2 ,COURTYARD-3>
		    <EQUAL? ,HERE ,COURTYARD-4 ,COURTYARD-7>>
		<COND (<VERB? THROUGH>
		       <GOTO ,TEMPLE>
		       <RTRUE>)
		      (<VERB? LISTEN>
		       <TELL
"You can hear a howling chant coming from inside the temple." CR>)>)>>

<OBJECT COURTYARD
	(IN LOCAL-GLOBALS)
	(DESC "courtyard")
	(SYNONYM COURTYARD LAWN LAWNS GRASS)
	(ACTION COURTYARD-F)>

<ROUTINE COURTYARD-F ()
	 <COND (<AND <VERB? WALK-AROUND> <NOT <EQUAL? ,HERE ,INSIDE-GATE>>>
		<COND (<EQUAL? ,HERE ,COURTYARD-7 ,COURTYARD-6 ,COURTYARD-4>
		       <DO-WALK ,P?WEST>)
		      (T <DO-WALK ,P?EAST>)>)
	       (<AND <VERB? THROUGH>
		     <EQUAL? ,HERE ,INSIDE-GATE>>
		<DO-WALK ,P?EAST>)>>

<OBJECT TOWER
	(IN LOCAL-GLOBALS)
	(DESC "tower")
	(SYNONYM TOWER)
	(FLAGS CLIMBBIT)
	(ACTION TOWER-F)>

<ROUTINE TOWER-F ()
	 <COND (<AND <VERB? CLIMB-UP CLIMB-FOO BOARD>
		     <OR <EQUAL? ,HERE ,PURLOINED-ROOM ,SE-TOWER>
		         <EQUAL? ,HERE ,NW-TOWER ,SW-TOWER>>>
		<DO-WALK ,P?UP>)
	       (<AND <VERB? CLIMB-DOWN CLIMB-FOO>
		     <OR <EQUAL? ,HERE ,JEWEL-ROOM ,MAP-ROOM>
			 <EQUAL? ,HERE ,ENGINE-ROOM ,BEDROOM>>>
		<DO-WALK ,P?DOWN>)
	       (<VERB? CLIMB-UP CLIMB-FOO>
		<TELL
"They are a bit far away to climb from here, and anyway the walls would
be impossible to scale." CR>)>>

<OBJECT TURRET
	(IN LOCAL-GLOBALS)
	(DESC "turret")
	(SYNONYM TURRET)>

<OBJECT LAWN
	(IN LOCAL-GLOBALS)
	(DESC "lawn")
	(SYNONYM LAWN)>

<OBJECT MEADOW-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "meadow")
	(SYNONYM MEADOW)>

<OBJECT BEACH-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "beach")
	(SYNONYM BEACH)
	(ADJECTIVE WHITE ROCKY)>
	
<OBJECT GLOBAL-WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER BROOK ;OCEAN POND)
	(ADJECTIVE DELICIOUS SPRING)
	(DESC "water")
	(ACTION WATER-FUNCTION)>

<OBJECT WATER
	(SYNONYM WATER QUANTITY)
	(ADJECTIVE DELICIOUS SPRING)
	(DESC "quantity of water")
	(FLAGS TAKEBIT)
	(ACTION WATER-FUNCTION)
	(SIZE 4)>

<OBJECT JUG
	(IN SHACK)
	(SYNONYM JUG)
	(ADJECTIVE POTTERY)
	(DESC "jug")
	(FLAGS TAKEBIT TRANSBIT CONTBIT OPENBIT)
	(ACTION JUG-F)
	(FDESC
"An empty jug lies in a corner of the room, against the overturned table.")
	(CAPACITY 4)>

<ROUTINE JUG-F ("AUX" (E? <>))
	 <COND (<VERB? OPEN CLOSE>
		<TELL
"The jug has no cover. It can't be opened or closed." CR>
		<RTRUE>)
	       (<VERB? THROW MUNG>
		<REMOVE ,PRSO>
		<SET E? T>
		<TELL "The jug shatters into innumerable pieces." CR>)
	       (<VERB? SHAKE>
		<COND (<FSET? ,PRSO ,OPENBIT> <SET E? T>)>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The jug is ">
		<COND (<NOT <IN? ,WATER ,PRSO>>
		       <TELL "empty." CR>)
		      (T
		       <TELL <GET ,JUG-AMTS <GETP ,WATER ,P?SIZE>> CR>)>)
	       (.E?
		<COND (<IN? ,WATER ,PRSO>
		       <TELL
"The water spills to the ground and evaporates." CR>
		       <REMOVE ,WATER>)>
		<RTRUE>)>>

<GLOBAL JUG-AMTS <TABLE
"foo"
"mostly empty."
"half full."
"nearly full."
"full.">> 

<ROUTINE WATER-FUNCTION ("AUX" AV W PI?)
	 #DECL ((AV) <OR OBJECT FALSE> (W) OBJECT (PI?) <OR ATOM FALSE>)
	 <COND (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,GLOBAL-WATER>>
		<COND (<EQUAL? ,HERE ,BEACH>
		       <TELL
"The ocean streches out as far as the eye can see to the south and
east." CR>)
		      (<EQUAL? ,HERE ,FOREST-2>
		       <TELL
"The water is dark and murky, and lily pads cover most of the surface.
I wouldn't drink the stuff." CR>)
		      (T
		       <TELL
"The brook runs slowly through thick vegetation." CR>)>
		<RTRUE>)
	       (<AND <VERB? THROUGH> <EQUAL? ,PRSO ,GLOBAL-WATER>>
		<TELL
"You have better things to do with your time than go swimming." CR>
		<RTRUE>)
	       (<AND <VERB? DRINK-FROM> <EQUAL? ,PRSO ,GLOBAL-WATER>>
		<V-DRINK-FROM>
		<RTRUE>)
	       (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH>
		<TELL "Swimming here is fraught with peril." CR>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SET W ,PRSI>	   ;"put water in bottle"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO .W>
		<SET PI? <>>)
	       (<EQUAL? ,PRSO ,GLOBAL-WATER ,WATER>
		<SET W ,PRSO>
		<SET PI? <>>)
	       (ELSE
		<SET W ,PRSI>
		<SET PI? T>)>
	 <COND (<==? .W ,GLOBAL-WATER>
		<COND (<VERB? DRINK> <RFALSE>)>
		<SET W ,WATER>
		<COND (<VERB? TAKE PUT> <REMOVE .W>)>)>
	 <COND (.PI? <SETG PRSI .W>)
	       (T <SETG PRSO .W>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<COND (<AND ,PRSI <NOT <==? ,PRSI ,JUG>>>
		       <COND (<EQUAL? ,PRSI ,SEA ,GLOBAL-WATER>
			      <TELL
"Ok, but there was plenty enough there already." CR>
			      <REMOVE .W>)
			     (<GETP ,PRSI ,P?CAPACITY>
			      <TELL
"The water leaks out of the " D ,PRSI " and evaporates immediately." CR>
			      <REMOVE .W>)
			     (T
			      <TELL
"The " D ,PRSI " isn't a very good container." CR>)>)
		      (<IN? ,JUG ,WINNER>
		       <COND (<NOT <FSET? ,JUG ,OPENBIT>>
			      <TELL "The jug is closed." CR>)
			     (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
			      <COND (<OR <NOT <IN? ,WATER ,JUG>>
					 <L? <GETP ,WATER ,P?SIZE> 4>>
				     <MOVE ,WATER ,JUG>
				     <PUTP ,WATER ,P?SIZE 4>
				     <TELL "The jug is now full of ">
				     <COND (<EQUAL? ,HERE ,BEACH>
					    <FSET ,WATER ,RMUNGBIT>
					    <TELL "sea">)
					   (<EQUAL? ,HERE ,FOREST-2>
					    <FSET ,WATER ,RMUNGBIT>
					    <TELL "foul algae-infested ">)
					   (T
					    <FCLEAR ,WATER ,RMUNGBIT>)>
				     <TELL "water." CR>)
				    (ELSE
				     <TELL "The jug is already full." CR>
				     <RTRUE>)>)
			     (T
			      <TELL "The only water here is in the jug." CR>)>)
		      (<AND <IN? ,PRSO ,JUG>
			    <VERB? TAKE>
			    <NOT ,PRSI>>
		       <SETG PRSO ,JUG>
		       <ITAKE>
		       <SETG PRSO .W>)
		      (T
		       <TELL "The water slips through your fingers." CR>)>)
	       (.PI? <TELL "Nice try." CR>)
	       (<VERB? DROP GIVE>
		<REMOVE ,WATER>
		<COND (<EQUAL? ,PRSI ,SEA ,GLOBAL-WATER>
		       <TELL
"Ok, but there was plenty enough there already." CR>)
		      (T
		       <TELL
"The water spills to the ground and evaporates." CR>)>)
	       (<VERB? POUR-ON>
		<REMOVE ,WATER>
		<TELL
"The water cascades off the " D ,PRSI " and onto the ground." CR>)
	       (<VERB? THROW>
		<TELL
"The water splashes over everything and evaporates." CR>
		<REMOVE ,WATER>)>>

<OBJECT SKY
	(IN GLOBAL-OBJECTS)
	(DESC "sky")
	(SYNONYM SKY STARS)
	(ACTION SKY-F)>

<ROUTINE SKY-F ("AUX" EL)
	 <COND (<AND <FSET? ,HERE ,ONBIT> <VERB? EXAMINE>>
		<SET EL </ ,TOD 10>>
		<TELL "It would be " <GET ,TIME-TABLE .EL> " now.">
		<COND (<G? ,TOD ,NIGHTFALL>
		       <TELL " Bright stars shine down on the earth.">)>
		<CRLF>)
	       (T <TELL "That would be difficult from here." CR>)>>

<OBJECT NOT-HERE-OBJECT
	(DESC "such thing" ;"[not here]")
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (.PRSO?
		<COND (<OR <VERB? ZIFMIA>
			   <AND <VERB? CAST>
				<EQUAL? ,PRSO ,SUMMON-SPELL>>>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)
	       ;(T
		<COND (<VERB? PUT-VERBS-HERE>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)>
	 ;"Here is the default 'cant see any' printer"
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You can't see any ">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>)
	       (T
		<TELL "The " D ,WINNER " seems confused. \"I don't see any ">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	<COND (,DEBUG
	       <TELL "[Moby-found " N .M-F " objects" "]" CR>)>
	<COND (<AND <G? .M-F 1>
		    <SET OBJ <GETP <GET .TBL 1> ,P?GLOBAL>>>
	       <SET M-F 1>
	       <SETG P-MOBY-FOUND .OBJ>)>
	<COND (<==? 1 .M-F>
	       <COND (,DEBUG <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO? <SETG PRSO ,P-MOBY-FOUND>)
		     (T <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any ">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T ,NOT-HERE-OBJECT)>>

<ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ)
	 ;<COND (,P-MULT <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <TELL "You can't see">
	 <COND (<NOT <EQUAL? .OBJ ,GLOBAL-KRILL>>
		<TELL " any">)>
	 <COND (<EQUAL? .OBJ ,PRSO> <PRSO-PRINT>)
	       (T <PRSI-PRINT>)>
	 <TELL " here." CR>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
 <COND (,P-OFLAG
	<COND (,P-XADJ ;<TELL " "> <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM ;<TELL " "> <PRINTB ,P-XNAM>)>)
       (.PRSO?
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT BELBOZ
	(IN GLOBAL-OBJECTS)
	(DESC "Necromancer Belboz")
	(SYNONYM BELBOZ NECROMANCER)
	(ACTION BELBOZ-F)
	(FLAGS VILLAIN)>

<ROUTINE BELBOZ-F ()
	 <COND (<VERB? ZIFMIA>
		<TELL
"A vision of the great Belboz begins to take shape before you, but ">
		<COND (<GETP ,HERE ,P?TMAZE>
		       <TELL
"as
soon as he realizes where you are, he disappears, a look of fear upon
his face." CR>)
		      (T
		       <TELL
"with
a curt word and a waggle of his finger, he disappears again, shaking his
head in disappointment." CR>)>)
	       (<VERB? EXAMINE WHO>
		<TELL
"Belboz is, in effect, your boss, professor, patron, and ultimate superior.
He is the head of the Circle of Enchanters." CR>)>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM PLACE AREA HERE)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK EXAMINE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the room reveals nothing else of interest. If you want to
move elsewhere, simply indicate the direction you wish to move in." CR>)>>

<OBJECT BRAMBLES
	(IN GLOBAL-OBJECTS)
	(SYNONYM BRAMBLE)
	(DESC "bramble")
	(ACTION BRAMBLES-F)>

<ROUTINE BRAMBLES-F ()
	 <COND (<NOT <OUTSIDE? ,HERE>>
		<TELL "The only brambles here are in your head." CR>)
	       (<VERB? SEARCH LOOK-INSIDE>
		<TELL
"There's nothing in the brambles now. Count your blessings." CR>)>>

<OBJECT GLOBAL-HOLE
	(IN GLOBAL-OBJECTS)
	(DESC "hole")
	(SYNONYM HOLE)
	(ACTION GLOBAL-HOLE-F)>

<ROUTINE GLOBAL-HOLE-F ()
	 <COND (<VERB? DIG>
		<TELL "It's not worth the bother." CR>)
	       (T <GLOBAL-NOT-HERE-PRINT ,GLOBAL-HOLE>)>>