"TERROR for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"It even strikes fear in the hearts of implementers...."

<OBJECT TERROR
	(IN T-I)
	(DESC "lurking evil presence")
	(SYNONYM TERROR PRESENCE FORCE)
	(ADJECTIVE STALKING EVIL LURKING UNSEEN)
	(FLAGS NDESCBIT)
	(GLOBAL TERROR)
	(ACTION TERROR-F)>

<ROUTINE TERROR-F ()
	 <COND (<VERB? ZIFMIA>
		<TELL
"As you cast the zifmia spell, you are overpowered with such a sense of
malice that you cannot continue. All in all, a good thing probably." CR>)
	       (<VERB? VAXUM>
		<TELL
"The terror may be friendlier, but with friends like that...." CR>)
	       (<VERB? GUNCHO>
		<REMOVE ,TERROR>
		<TELL
"The room fills with a horrible noise, darkens to pitch blackness, and
then lightens. The weight of fear lifts." CR>)>>

<OBJECT TMAP
	(IN MAP-ROOM)
	(DESC "map")
	(FDESC
"Lying on the ground is an old parchment map.")
	(SYNONYM MAP)
	(ADJECTIVE OLD PARCHMENT)
	(FLAGS TAKEBIT READBIT CONTBIT OPENBIT)
	(CAPACITY 100)
        (ACTION TMAP-F)>

<OBJECT PENCIL
	(IN MAP-ROOM)
	(DESC "badly worn pencil")
	(FDESC
"In one corner of the room is a badly worn pencil, inscribed with runes.")
	(SYNONYM PENCIL ERASER RUNES)
	(ADJECTIVE BADLY WORN)
	(FLAGS TAKEBIT READBIT)
	(TEXT
"It says \"Frobozz Magic Pencil Company.\" Some sort of joke, probably.")
	(ACTION PENCIL-F)>

<ROUTINE TMAP-F ()
	 <COND (<VERB? KULCAD>
		<TELL
"At once, a maze of lines forms, connecting all of the spots on the map.
Suddenly, the world becomes still and cold." CR CR>
		<END-OF-WORLD>
		<RTRUE>)
	       (<VERB? OPEN CLOSE PUT>
		<TELL "You can't do that." CR>)
	       (<VERB? DRAW-ON>
		<COND (<IN? ,PENCIL ,WINNER>
		       <WRITE-HINT>
		       <RTRUE>)
		      (T
		       <TELL "You have nothing to draw with." CR>)>)
	       (<VERB? READ EXAMINE LOOK-INSIDE>
		<TELL
"The map consists of a drawing with nine points, each represented by
a strange character, with interconnecting thin pencil lines. Using your
native alphabet, it looks like this:" CR>
		<DRAW-TMAZE>)>>

<GLOBAL PENCIL-COUNT 2>
<GLOBAL ERASER-COUNT 2>

<GLOBAL PENCIL-TBL
	<TABLE "gone" "very nearly gone" "nearly gone">>

<GLOBAL ERASER-TBL
	<TABLE "not fit for use" "barely usable" "negligible">>

<ROUTINE PENCIL-F ()
	 <COND (<VERB? KULCAD>
		<TELL
"As the pencil dissolves into nothingness, everything becomes still
and cold." CR CR>
		<END-OF-WORLD>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The pencil is very old and covered with finely inlaid runes. The point is
">
		<TELL  <GET ,PENCIL-TBL ,PENCIL-COUNT>
		       " and the attached eraser is "
		       <GET ,ERASER-TBL ,ERASER-COUNT>
		       "." CR>)>>
		
<OBJECT POINT-B
	(IN TMAP)
	(DESC "point B")
	(SYNONYM B)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 1)>

<OBJECT POINT-R
	(IN TMAP)
	(DESC "point R")
	(SYNONYM R)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 2)>

<OBJECT POINT-K
	(IN TMAP)
	(DESC "point K")
	(SYNONYM K)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 3)>

<OBJECT POINT-H
	(IN TMAP)
	(DESC "point H")
	(SYNONYM H)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 4)>

<OBJECT POINT-J
	(IN TMAP)
	(DESC "point J")
	(SYNONYM J)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 5)>

<OBJECT POINT-M
	(IN TMAP)
	(DESC "point M")
	(SYNONYM M)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 6)>

<OBJECT POINT-V
	(IN TMAP)
	(DESC "point V")
	(SYNONYM V)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 7)>

<OBJECT POINT-F
	(IN TMAP)
	(DESC "point F")
	(SYNONYM F)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 8)>

<OBJECT POINT-P
	(IN TMAP)
	(DESC "point P")
	(SYNONYM P)
	(ADJECTIVE POINT)
	(FLAGS POINTBIT NDESCBIT)
	(POINT 9)>

<CONSTANT T-NW 1>
<CONSTANT T-WEST 3>
<CONSTANT T-SW 5>
<CONSTANT T-SOUTH 7>
<CONSTANT T-SE 9>
<CONSTANT T-EAST 11>
<CONSTANT T-NE 13>
<CONSTANT T-NORTH 15>

<GLOBAL T-DIR-TABLE <TABLE 0 0 0 0 0 "/" 0 "!" 0 "\\">>

<ROOM T-A
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" 0 0 ;"WEST" 0 0 ;"SW" 0 0 ;"SOUTH" T-B 1
	 ;"SE" T-C 0 ;"EAST" T-E 0 ;"NE" 0 0 ;"NORTH" 0 0 -1>)
      (CAPACITY 1)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-B
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" 0 0 ;"WEST" 0 0 ;"SW" 0 0 ;"SOUTH" 0 0
	 ;"SE" T-D 1 ;"EAST" T-F 1 ;"NE" T-C 0 ;"NORTH" T-A 1 -1>)
      (CAPACITY 2)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-C
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" T-A 0 ;"WEST" 0 0 ;"SW" T-B 0 ;"SOUTH" T-D 0
	 ;"SE" T-F 0 ;"EAST" T-G 0 ;"NE" T-E 1 ;"NORTH" 0 0 -1>)
      (CAPACITY 3)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-D
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" T-B 1 ;"WEST" 0 0 ;"SW" 0 0 ;"SOUTH" 0 0
	 ;"SE" 0 0 ;"EAST" T-I 0 ;"NE" T-F 1 ;"NORTH" T-C 0 -1>)
      (CAPACITY 4)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-E
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" 0 0 ;"WEST" T-A 0 ;"SW" T-C 1 ;"SOUTH" T-F 0
	 ;"SE" T-G 1 ;"EAST" 0 0 ;"NE" 0 0 ;"NORTH" 0 0 -1>)
      (CAPACITY 5)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-F
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" T-C 0 ;"WEST" T-B 1 ;"SW" T-D 1 ;"SOUTH" 0 0
	 ;"SE" T-I 0 ;"EAST" T-H 0 ;"NE" T-G 1 ;"NORTH" T-E 0 -1>)
      (CAPACITY 6)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-G
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" T-E 1 ;"WEST" T-C 0 ;"SW" T-F 1 ;"SOUTH" T-I 0
	 ;"SE" T-H 1 ;"EAST" 0 0 ;"NE" 0 0 ;"NORTH" 0 0 -1>)
      (CAPACITY 7)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-H
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" T-G 1 ;"WEST" T-F 0 ;"SW" T-I 0 ;"SOUTH" 0 0
	 ;"SE" 0 0 ;"EAST" 0 0 ;"NE" 0 0 ;"NORTH" 0 0 -1>)
      (CAPACITY 8)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<ROOM T-I
      (IN ROOMS)
      (DESC "Translucent Room")
      (FLAGS RLANDBIT)
      (TMAZE <TABLE
         ;"NW" T-F 0 ;"WEST" T-D 0 ;"SW" 0 0 ;"SOUTH" 0 0
	 ;"SE" 0 0 ;"EAST" 0 0 ;"NE" T-H 0 ;"NORTH" T-G 0 -1>)
      (CAPACITY 9)
      (GLOBAL BLACK-PASSAGE)
      (ACTION TMAZE-F)>

<GLOBAL TMAZE-DIRS <TABLE "northwest" "west" "southwest" "south"
			  "southeast" "east" "northeast" "north">>

<OBJECT BLACK-PASSAGE
	(IN LOCAL-GLOBALS)
	(DESC "black passage")
	(SYNONYM PASSAGE)
	(ADJECTIVE BLACK)
	(ACTION BLACK-PASSAGE-F)>

<ROUTINE BLACK-PASSAGE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The passages are perfectly round and black; the walls seem to be made of
carbon." CR>)>>

<ROUTINE TMAZE-F (RARG "AUX" TBL (NEX 0) (FLG <>) (OFFS 0) (PLU <>))
	 <COND (<AND <IN? ,BANISH-SCROLL ,WINNER>
		     <EQUAL? ,HERE ,T-A>
		     ,TERROR-TRAPPED
		     <G? ,TERROR-POINT 0>>
		<TELL
"You hear a horrible anguished scream through the walls of the cavern as the
terror realizes that it is trapped and its scroll of power stolen!" CR CR>
		<SETG SCORE <+ ,SCORE ,TERROR-POINT>>
		<SETG TERROR-POINT 0>)>
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a peculiar room, whose cream-colored walls are thin and
translucent." CR>
		<SET TBL <GETP ,HERE ,P?TMAZE>>
		<REPEAT ()
			<COND (<EQUAL? <GET .TBL .OFFS> -1>
			       <RETURN>)
			      (<EQUAL? <GET .TBL <+ .OFFS 1>> 1>
			       <SET NEX <+ .NEX 1>>)>
			<SET OFFS <+ .OFFS 2>>>
		<COND (<EQUAL? .NEX 0>
		       <TELL
"There is not a single exit from this place." CR>
		       <RTRUE>)
		      (<EQUAL? .NEX 1>
		       <TELL
"An exit is">)
		      (T
		       <SET PLU T>
		       <TELL
"Passages go">)>
		<TELL " to the ">
		<SET OFFS 0>
		<REPEAT ()
			<COND (<EQUAL? <GET .TBL .OFFS> -1>
			       <RETURN>)
			      (<EQUAL? <GET .TBL <+ .OFFS 1>> 1>
			       <TELL <GET ,TMAZE-DIRS </ .OFFS 2>>>
			       <COND (<G? .NEX 2>
				      <SET FLG T>
				      <TELL ", ">)
				     (<EQUAL? .NEX 2>
				      <COND (.FLG <TELL ",">)>
				      <TELL " and ">)>
			       <SET NEX <- .NEX 1>>)>
			<SET OFFS <+ .OFFS 2>>>
		<TELL "
and ">
		<COND (.PLU <TELL "they are">)
		      (T <TELL "it is">)>
		<TELL
" very strange indeed, perfectly round and black as pitch." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<IN? ,TERROR ,HERE>
		       <COND (<VERB? WALK>
			      <TELL
"Your feet are leaden with fear, and cold sweat runs down your back as you
make your way to the door, but you make no progress. Your mind tells you
you are running, but you aren't getting anywhere." CR>)>)
		      (<VERB? WALK>
		       <COND (<AND <EQUAL? ,HERE ,T-A>
				   <EQUAL? ,PRSO ,P?UP>>
			      <GOTO ,DUNGEON>
			      <RTRUE>)
			     (<AND <G? ,PRSO ,P?UP>
				   <EQUAL? <GET <SET TBL <GETP ,HERE ,P?TMAZE>>
						<SET OFFS
						     <- <* <- ,PRSO
							      ,P?UP>
							   2>
							1>>>
					   1>>
			      <GOTO <GET .TBL <- .OFFS 1>>>
			      <COND (<IN? ,TERROR ,HERE>
				     <TELL
"An evil presence pervades the room, its source unseen. Fear seeps into
your mind, like fog. You look fearfully around. There is something
horrible here." CR>)
				    (<CONNECTED? ,HERE <LOC ,TERROR>>
				     <TELL
"You sense that near this place an evil presence lurks. It seems close by
and is moving." CR>)>
			      <RTRUE>)
			     (T
			      <TELL "You can't go that way." CR>)>)>)>>

<ROUTINE END-OF-WORLD ()
	 <TELL
"You suddenly feel weak and your knees buckle. Just as you collapse to the
ground, you find yourself in the presence of the Circle. They seem tense
and frightened and ask desperately about your recent doings. As you tell
your tale of the map and pencil, they recoil in horror. \"The Terror is
released!\" cries one. Belboz sinks into his throne. \"We are doomed!\"
he gasps. One by one, the wizards flee to prepare a hopeless defense." CR>
	 <SETG SCORE -10>
	 <FINISH>>

<ROUTINE DRAW-TMAZE ()
	 <FIXED-FONT-ON>
	 <TELL CR "B">
	 <ECN ,T-A ,T-H ;"Place holder">
	 <TELL "J" CR>
	 <CN ,T-A ,T-SOUTH>
	 <CN ,T-A ,T-SE>
	 <TELL "     ">
	 <CN ,T-E ,T-SW>
	 <CN ,T-E ,T-SOUTH>
	 <CN ,T-E ,T-SE>
	 <CRLF>
	 <CN ,T-A ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-A ,T-SE>
	 <TELL "   ">
	 <CN ,T-E ,T-SW>
	 <TELL " ">
	 <CN ,T-E ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-E ,T-SE>
	 <CRLF>
	 <CN ,T-A ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-A ,T-SE>
	 <TELL " ">
	 <CN ,T-E ,T-SW>
	 <TELL "  ">
	 <CN ,T-E ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-E ,T-SE>
	 <CRLF>
	 <CN ,T-A ,T-SOUTH>
	 <TELL "   K">
	 <ECN ,T-C ,T-E>
	 <TELL "V" CR>
	 <CN ,T-A ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-C ,T-SW>
	 <CN ,T-C ,T-SOUTH>
	 <CN ,T-C ,T-SE>
	 <TELL "  ">
	 <CN ,T-E ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-G ,T-SW>
	 <CN ,T-G ,T-SOUTH>
	 <CN ,T-G ,T-SE>
	 <CRLF>
	 <CN ,T-A ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-C ,T-SW>
	 <TELL " ">
	 <CN ,T-C ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-C ,T-SE>
	 <TELL " ">
	 <CN ,T-E ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-G ,T-SW>
	 <TELL " ">
	 <CN ,T-G ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-G ,T-SE>
	 <CRLF>
	 <CN ,T-A ,T-SOUTH>
	 <CN ,T-C ,T-SW>
	 <TELL "  ">
	 <CN ,T-C ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-C ,T-SE>
	 <CN ,T-E ,T-SOUTH>
	 <CN ,T-G ,T-SW>
	 <TELL "  ">
	 <CN ,T-G ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-G ,T-SE>
	 <CRLF>
	 <TELL "R">
	 <ECN ,T-B ,T-C>
	 <TELL "M">
	 <ECN ,T-F ,T-G>
	 <TELL "F">
	 <TELL CR " ">
	 <CN ,T-B ,T-SE>
	 <TELL "  ">
	 <CN ,T-C ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-F ,T-SW>
	 <TELL " ">
	 <CN ,T-F ,T-SE>
	 <TELL "  ">
	 <CN ,T-G ,T-SOUTH>
	 <TELL "  ">
	 <CN ,T-H ,T-SW>
	 <TELL CR "  ">
	 <CN ,T-B ,T-SE>
	 <TELL " ">
	 <CN ,T-C ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-F ,T-SW>
	 <TELL "   ">
	 <CN ,T-F ,T-SE>
	 <TELL " ">
	 <CN ,T-G ,T-SOUTH>
	 <TELL " ">
	 <CN ,T-H ,T-SW>
	 <TELL CR "   ">
	 <CN ,T-B ,T-SE>
	 <CN ,T-C ,T-SOUTH>
	 <CN ,T-F ,T-SW>
	 <TELL "     ">
	 <CN ,T-F ,T-SE>
	 <CN ,T-G ,T-SOUTH>
	 <CN ,T-H ,T-SW>
	 <TELL CR "    H">
	 <ECN ,T-D ,T-H ;"Place holder">
	 <TELL "P" CR CR>
	 <FIXED-FONT-OFF>
	 <RTRUE>>

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

<ROUTINE CN (L DIR)
	 <COND (<NOT <0? <GET <GETP .L ,P?TMAZE> .DIR>>>
		<TELL <GET ,T-DIR-TABLE .DIR>>)
	       (T <TELL " ">)>>

<ROUTINE ECN (L DN "AUX" (FLG <>))
	 <COND (<NOT <0? <GET <GETP .L ,P?TMAZE> ,T-EAST>>>
		<SET FLG T>
		<TELL "---">)
	       (T <TELL "   ">)>
	 <COND (<NOT <0? <GET <GETP .DN ,P?TMAZE> ,T-SOUTH>>>
		<COND (.FLG <TELL "+">)
		      (T <TELL "!">)>)
	       (.FLG <TELL "-">)
	       (T <TELL " ">)>
	 <COND (.FLG <TELL "---">)
	       (T <TELL "   ">)>>

<ROUTINE CONNECT (RM1 RM2 "OPTIONAL" (FLIP <>) "AUX" TBL RMX)
	 <SET TBL <GETP .RM1 ,P?TMAZE>>
	 <REPEAT ()
		 <COND (<EQUAL? <SET RMX <GET .TBL 0>> -1>
			<TELL
"The pencil doesn't seem to allow that line to be drawn." CR>
			<RTRUE>)
		       (<EQUAL? .RMX .RM2>
			<COND (<0? <GET .TBL 1>>
			       <COND (<NOT .FLIP>
				      <CONNECT .RM2 .RM1 T>
				      <SETG PENCIL-COUNT
					    <- ,PENCIL-COUNT 1>>
				      <TELL
"A thin line now connects the two spots on the map, but the
pencil point is " <GET ,PENCIL-TBL ,PENCIL-COUNT> "." CR>
				      <COND (<EQUAL? ,HERE .RM1 .RM2>
					     <DESCRIBE-NEW-EXIT .RM1 .RM2>)>)>
			       <PUT .TBL 1 1>
			       <COND (<AND <LOC ,TERROR>
					   <TWALK <LOC ,TERROR>>>
				      <SETG TERROR-TRAPPED <>>
				      <ENABLE <QUEUE I-TERROR -1>>)>)
			      (T
			       <TELL
"There is already a line connecting those spots." CR>)>
			<RTRUE>)>
		 <SET TBL <REST .TBL 4>>>>

<ROUTINE DISCONNECT (RM1 RM2 "OPTIONAL" (FLIP <>) "AUX" TBL RMX)
	 <SET TBL <GETP .RM1 ,P?TMAZE>>
	 <REPEAT ()
		 <COND (<EQUAL? <SET RMX <GET .TBL 0>> -1>
			<TELL
"Those two spots aren't connected on the map." CR>
			<RTRUE>)
		       (<EQUAL? .RMX .RM2>
			<COND (<0? <GET .TBL 1>>
			       <TELL
"Those two spots aren't connected on the map." CR>)
			      (T
			       <COND (<NOT .FLIP>
				      <DISCONNECT .RM2 .RM1 T>
				      <SETG ERASER-COUNT
					    <- ,ERASER-COUNT 1>>
				      <TELL
"The line between the two spots is erased, leaving the eraser
" <GET ,ERASER-TBL ,ERASER-COUNT> "." CR>
				      <COND (<EQUAL? ,HERE .RM1 .RM2>
					     <DESCRIBE-NEW-EXIT .RM1
								.RM2
								<>>)>)>
			       <PUT .TBL 1 0>)>
			<RTRUE>)>
		 <SET TBL <REST .TBL 4>>>>

<ROUTINE DESCRIBE-NEW-EXIT (RM1 RM2 "OPTIONAL" (MAKE? T)
			             "AUX" TMP TBL (OFFS 0))
	 <COND (<EQUAL? .RM2 ,HERE>
		<SET TMP .RM1>
		<SET RM1 .RM2>
		<SET RM2 .TMP>)>
	 <SET TBL <GETP .RM1 ,P?TMAZE>>
	 <REPEAT ()
		 <COND (<EQUAL? <SET TMP <GET .TBL .OFFS>> .RM2>
			<RETURN>)
		       (<EQUAL? .TMP -1>
			<TELL "*ERROR* BAD-EXIT DESCRIBE-NEW-EXIT" CR>
			<RETURN>)
		       (T
		        <SET OFFS <+ .OFFS 2>>)>>
	 <TELL "Suddenly, the ">
	 <COND (.MAKE? <TELL "wall">)
	       (T <TELL "black passage">)>
	 <TELL " to the ">
	 <TELL <GET ,TMAZE-DIRS </ .OFFS 2>>>
	 <COND (.MAKE?
		<TELL " opens to form a perfectly round and black passage">)
	       (T
		<TELL " closes off">)>
	 <TELL "!" CR>>
		

<ROUTINE CONNECTED? (RM1 RM2 "AUX" TBL RMX)
	 <SET TBL <GETP .RM1 ,P?TMAZE>>
	 <COND (<NOT .TBL> <RFALSE>)>
	 <REPEAT ()
		 <COND (<EQUAL? <SET RMX <GET .TBL 0>> -1>
			<RFALSE>)
		       (<EQUAL? .RMX .RM2>
			<COND (<0? <GET .TBL 1>>
			       <RFALSE>)
			      (T
			       <RTRUE>)>)>
		 <SET TBL <REST .TBL 4>>>>
		     
;<GLOBAL TERROR-ROOM ,T-I>

<GLOBAL TWAIT 0>

<GLOBAL TERROR-ARRIVES
"An evil presence, borne on a cold blast of air, seems to move beside
you, weighing you down with emanations of malice and hatred. A cold fear
covers you like fog.">

<GLOBAL TERROR-MOVED <>>

<ROUTINE I-TERROR ("AUX" RM NRM (FLG <>))
	 <COND (,TERROR-TRAPPED
		<SET RM <LOC ,TERROR>>
		<COND (<CONNECTED? ,HERE .RM>
		       <MOVE ,TERROR ,HERE>
		       <TELL ,TERROR-ARRIVES CR>)>)
	       ;(<PROB 5> <RFALSE>)
	       (<TWALK <SET RM <LOC ,TERROR>>>
		<SETG TERROR-TRAPPED <>>
		<SETG TWAIT 0>
		<MOVE ,TERROR <SET NRM <GET ,TMAZE-ROOMS <GET ,PATH-TBL 2>>>>
		<COND (<EQUAL? ,HERE .NRM>
		       <TELL ,TERROR-ARRIVES CR>
		       <SET FLG T>)
		      (<CONNECTED? ,HERE .NRM>
		       <TELL
"Somewhere near, an evil presence lurks, probing your mind. It
seems to be moving quickly." CR>
		       <SET FLG T>)
		      (<CONNECTED? ,HERE .RM>
		       <TELL
"You can no longer sense the evil presence nearby." CR>
		       <SET FLG T>)>
		<COND (<NOT ,TERROR-MOVED>
		       <SETG TERROR-MOVED T>
		       <SETG LOSSAGE <+ ,LOSSAGE 1>>
		       <SET FLG T>
		       <TELL
"You feel that two powerful, evil forces are searching each other out.
As they meet, the air lightens. Belboz appears before you. \"Something
has disturbed the ancient Terror. Krill himself knows this and will try
to use it to his purposes. Already, they may have joined together. You
must not allow the Terror to escape, or we are all doomed!\" He fades into
the gloom." CR>)>
		<COND (<EQUAL? .NRM ,T-A>
		       <END-OF-WORLD>
		       <COND (<EQUAL? ,HERE ,T-A>
			      <SET FLG T>
			      <TELL
"The presence seems to grow stronger each passing second,
beating you down with its awesome power." CR>)
			     (T
			      <SET FLG T>
			      <TELL
"At once, a strange and horrible feeling wells up inside of you.
An unseen yet awesomely powerful force, exuding pure evil, seems
to fill the very chamber." CR>)>)>
		.FLG) 
	       (<TNULL-F> <RTRUE>)
	       (<OR <G? <SETG TWAIT <+ ,TWAIT 1>> 6>
		    <NOT <SET RM <TWALK1>>>>
		<RTRUE>)
	       (T
		<SET NRM <LOC ,TERROR>>
		<COND (<EQUAL? .NRM ,T-I> <RTRUE>)
		      (<CONNECTED? .NRM ,T-I>
		       <MOVE ,TERROR ,T-I>)
		      (<CONNECTED? .NRM ,T-F>
		       <MOVE ,TERROR ,T-F>)
		      ;(T
		       <MOVE ,TERROR .RM>)>
		<COND (<IN? ,TERROR ,HERE>
		       <TELL ,TERROR-ARRIVES CR>)
		      (T
		       <TELL
"From somewhere nearby, an unseen force probes you, and you are gripped
by a sickening feeling." CR>)>
		<RTRUE>)>>

<GLOBAL TERROR-TRAPPED <>>

<GLOBAL TWALK-PATHS
	<LTABLE ;A <LTABLE>
		;B <LTABLE 1 3 4 6>
		;C <LTABLE 1 2 5 6 7 4>
		;D <LTABLE 2 3 6 9>
		;E <LTABLE 1 3 6 7>
		;F <LTABLE 3 5 2 4 7 8 9>
		;G <LTABLE 5 3 6 8 9>
		;H <LTABLE 6 7 9>
		;I <LTABLE 4 6 7 8>>>

<GLOBAL TMAZE-ROOMS <LTABLE T-A T-B T-C T-D T-E T-F T-G T-H T-I>>

<ROUTINE TNULL-F ()
	 <SETG TERROR-TRAPPED T>
	 <RFALSE>>

<ROUTINE TWALK (RM)
	 <SETG TWALK-LEVEL 0>
	 <SETG TTRIES 0>
	 <SETG PSTART .RM>
	 <PATH-OUT? .RM>>

<GLOBAL TTRIES 0>
<GLOBAL PSTART <>>

<CONSTANT TWALK-MAX 5>

;<GLOBAL SLOW-TIMES <LTABLE
"You feel a passing wave of anger permeating the walls of the room."
"The feeling of anger from a moment before is greater now."
"An intense surge of anger fills the very air."
"This is a bug. Report it."
"This is a bug. Report it."
"This is a bug. Report it.">>

<GLOBAL PATH-TBL <TABLE 0 0 0 0 0 0 0>>

<GLOBAL TWALK-LEVEL 0>

<ROUTINE TWALK1 ("AUX" TBL RM NRM (OFFS 1) CNT)
	 <SET RM <LOC ,TERROR>>
	 <SET TBL <GET ,TWALK-PATHS <GETP .RM ,P?CAPACITY>>>
	 <SET CNT <GET .TBL 0>>
	 <REPEAT ()
		 <COND (<G? .OFFS .CNT>
			<RFALSE>)
		       (<CONNECTED? .RM
				    <SET NRM <GET ,TMAZE-ROOMS
						  <GET .TBL .OFFS>>>>
			<RETURN .NRM>)>
		 <SET OFFS <+ .OFFS 1>>>>

<ROUTINE PATH-OUT? (RM "AUX" (OFFS 1) TBL (CNT 0) NRM)
	 <SETG TTRIES <+ ,TTRIES 1>>
	 ;<COND (<0? <MOD ,TTRIES 16>>
		<TELL <GET ,SLOW-TIMES </ ,TTRIES 32>> CR>)>
	 <SETG TWALK-LEVEL <+ ,TWALK-LEVEL 1>>
	 <PUT ,PATH-TBL ,TWALK-LEVEL <GETP .RM ,P?CAPACITY>>
	 <COND (<EQUAL? .RM ,T-A>
		<SETG TWALK-LEVEL <- ,TWALK-LEVEL 1>>
		<RTRUE>)
	       (<G? ,TWALK-LEVEL ,TWALK-MAX>
		<SETG TWALK-LEVEL <- ,TWALK-LEVEL 1>>
                <RFALSE>)>
	 <SET TBL <GET ,TWALK-PATHS <GETP .RM ,P?CAPACITY>>>
	 <COND (<0? <SET CNT <GET .TBL 0>>>
		<SETG TWALK-LEVEL <- ,TWALK-LEVEL 1>>
		<RTRUE>)>
	 <REPEAT ()
		 <COND (<G? .OFFS .CNT>
			<SETG TWALK-LEVEL <- ,TWALK-LEVEL 1>>
			<RFALSE>)
		       (<AND <CONNECTED? .RM
				    <SET NRM <GET ,TMAZE-ROOMS
						  <GET .TBL .OFFS>>>>
			     <NOT <EQUAL? .NRM ,PSTART>>
			     <PATH-OUT? .NRM>>
			<SETG TWALK-LEVEL <- ,TWALK-LEVEL 1>>
			<RTRUE>)>
		 <SET OFFS <+ .OFFS 1>>>>

<OBJECT LEGEND-BOOK
	(IN LIBRARY)
	(DESC "dusty book")
	(SYNONYM BOOK PAGE)
	(ADJECTIVE OLD DUSTY FIRST LEGEND)
	(FDESC
"Amid the tubes is an old and dusty book.")
	(FLAGS TAKEBIT READBIT OPENBIT CONTBIT)
	(SIZE 6)
	(ACTION LEGEND-BOOK-F)>

<ROUTINE LEGEND-BOOK-F ()
	 <COND (<AND <VERB? CLOSE>
		     <FSET? ,PRSO ,OPENBIT>>
		<FCLEAR ,PRSO ,OPENBIT>
		<TELL
"Closed." CR>)
	       (<VERB? READ EXAMINE LOOK-INSIDE OPEN>
		<FSET ,PRSO ,OPENBIT>
		<TELL
"The first page of the book was the table of contents. Only two chapter names
can be read: The Legend of the Unseen Terror and The Legend of the Great
Implementers." CR>)
	       (<VERB? TURN>
		<TELL
"Rather than turning pages, why don't you simply read the legends." CR>)>>

<OBJECT LEGEND-ONE
	(IN LEGEND-BOOK)
	(DESC "Legend of the Unseen Terror")
	(SYNONYM LEGEND TERROR)
	(ADJECTIVE UNSEEN)
	(FLAGS READBIT NDESCBIT)
	(GLOBAL TERROR)
	(TEXT
"This legend, written in an ancient tongue, goes something like this:
At one time a shapeless and formless manifestation of evil was disturbed
from millenia of sleep. It was so powerful that it required the combined
wisdom of the leading enchanters of that age to conquer it. The legend tells
how the enchanters lured the Terror \"to a recess deep within the earth\" by
placing there a powerful spell scroll. When it had reached the scroll, the
enchanters trapped it there with a spell that encased it in the living
rock. The Terror was so horrible that none would dare speak of it. A comment
at the end of the narration indicates that the story is considered to be quite
fanciful; no other chronicles of the age mention the Terror in any form.")>

<OBJECT LEGEND-TWO
	(IN LEGEND-BOOK)
	(DESC "Legend of the Great Implementers" )
	(SYNONYM LEGEND IMPLEMENTERS)
	(ADJECTIVE GREAT)
	(FLAGS READBIT NDESCBIT)
	(TEXT
"This legend, written in an ancient tongue, speaks of the creation
of the world. A more absurd account can hardly be imagined. The universe,
it seems, was created by \"Implementers\" who directed the running of great
engines. These engines produced this world and others, strange and wondrous,
as a test or puzzle for others of their kind. It goes on to state that these
beings stand ready to aid those entrapped within their creation. The great
magician-philosopher Helfax notes that a creation of this kind is morally
and logically indefensible and discards the theory as \"colossal claptrap
and kludgery.\"")
	(ACTION LEGEND-TWO-F)>

<ROUTINE LEGEND-TWO-F ()
	 <COND (<AND <VERB? ZIFMIA> <NOT ,IMP-SEEN>>
		<SETG IMP-SEEN T>
		<TELL
"The implementers of the world, Marc Blank and Dave Lebling, appear before
you, looking quite as confused as yourself. They speak:|
Dave: \"What's happening here?\"|
Marc: \"Uh, I dunno. YOU wrote this code, not me.\"|
Dave: \"Hmm. Another day, another bug. Let's see here...\"|
They disappear a moment later.|
Dave's voice: \"That should do it.\"" CR>)>>