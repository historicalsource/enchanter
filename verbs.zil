"VERBS for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

"SUBTITLE DESCRIBE THE UNIVERSE"

"SUBTITLE SETTINGS FOR VARIOUS LEVELS OF DESCRIPTION"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

\

"SUBTITLE DESCRIBERS"

<ROUTINE V-LOOK ()
	 <COND (<AND ,PRSO <NOT <EQUAL? ,PRSO ,ROOMS>>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)>
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF> <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (ELSE
		<TELL "You see nothing special about the "
		      D ,PRSO "." CR>)>>

<GLOBAL LIT <>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL
"It is pitch black and there is evil in the darkness.">
		<CRLF>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS> <TELL D ,HERE CR>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,WINNER>>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in the " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V?
			    <FSET? ,HERE ,RMUNGBIT>
			    <SET STR <GETP ,HERE ,P?MUNGDESC>>>
		       <TELL .STR CR>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <COND (<AND <FSET? ,HERE ,RMUNGBIT>
				   <NOT <EQUAL? ,HERE ,ALTAR ,JUNCTION>>>
			      <TELL
"Everything you see is grey and lifeless, as though covered
with a veil of ash. Sound is muted and there is a faint acrid odor." CR>)>
		       <TELL .STR CR>)
		      (T <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <==? ,HERE .AV>> <FSET .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>
		<COND (<NOT <FSET? ,HERE ,LIGHTBIT>>
		       <RTRUE>)
		      (<G? ,TOD ,NIGHTFALL>
		       <TELL
"The stars shine down on you from a clear, dark sky." CR>)
		      (<G? ,TOD ,DUSK>
		       <TELL
"The darkening sky is lit by a waning moon." CR>)
		      (<AND <NOT <L? ,TOD ,DAWN>>
			    <L? ,TOD <+ ,DAWN 3>>>
		       <TELL
"The sun is rising over the lands to the east." CR>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (ELSE
		<TELL "You can't see anything in the dark." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE LIGHTED? (OBJ)
	 <COND (<AND <FSET? .OBJ ,LIGHTBIT>
		     <FSET? .OBJ ,ONBIT>>
		<TELL " (providing light)">)>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>
		<LIGHTED? .OBJ>)
	       (<0? .LEVEL>
		<TELL "There is " A .OBJ " here">
		<LIGHTED? .OBJ>
		<TELL ".">)
	       (ELSE
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL "A">
		<COND (<FSET? .OBJ ,VOWELBIT> <TELL "n">)>
		<COND (<EQUAL? .OBJ ,BREAD>
		       <COND (<L? <GETP .OBJ ,P?SIZE> 8>
			      <TELL " partially eaten">)>)
		      (<EQUAL? .OBJ ,WATER>
		       <COND (<L? <GETP .OBJ ,P?SIZE> 2>
			      <TELL " very">)>
		       <COND (<L? <GETP .OBJ ,P?SIZE> 3>
			      <TELL " small">)>)>
		<TELL " " D .OBJ>
		<LIGHTED? .OBJ>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? AV STR (PV? <>) (INV? <>))
	 #DECL ((OBJ) OBJECT (LEVEL) FIX)
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND (<NOT .Y> <RETURN <NOT .1ST?>>)
			      (<==? .Y .AV> <SET PV? T>)
			      (<==? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR>
				      <LIGHTED? .Y>
				      <CRLF>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,PLAYER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<==? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<EQUAL? .OBJ ,ADVENTURER>
		       <TELL "The adventurer is carrying:" CR>)
		      (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ
			     " is:" CR>)
		      (ELSE
		       <TELL "The " D .OBJ
			     " contains:" CR>)>)>>

\

"SUBTITLE SCORING"

<GLOBAL MOVES 0>
<GLOBAL SCORE 0>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your score is " N ,SCORE>
	 <TELL " of a possible " N ,SCORE-MAX ", in ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " move.">) (ELSE <TELL " moves.">)>
	 <CRLF>
	 <COND (<L? ,SCORE 0>
		<TELL
"This gives you the rank of Menace to Society." CR>)
	       (T
		<TELL
"This puts you in the class of " <GET ,RANKINGS </ ,SCORE 50>> "." CR>)>
	 ,SCORE>

<GLOBAL RANKINGS <TABLE
"Charlatan"
"Parlor Magician"
"Novice Enchanter"
"Intermediate Enchanter"
"Enchanter"
"Expert Enchanter"
"Master Enchanter"
"Candidate for membership in the Circle of Enchanters"
"Member of the Circle of Enchanters">> 

<ROUTINE FINISH ("OPTIONAL" (REPEATING <>))
	 <CRLF>
	 <COND (<NOT .REPEATING>
		<V-SCORE>
		<CRLF>)>
	 <TELL
"Would you like to restart the game from the beginning, restore a saved
game position, or end this session of the game?|
(Type RESTART, RESTORE, or QUIT):|
|
>">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTART>
	        <RESTART>
		<TELL "Failed." CR>
		<FINISH T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTORE>
		<COND (<RESTORE>
		       <TELL "Okay." CR>)
		      (T
		       <TELL "Failed." CR>
		       <FINISH T>)>)
	       (T
		<QUIT>)>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 #DECL ((ASK?) <OR ATOM <PRIMTYPE LIST>> (SCOR) FIX)
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL
"Do you wish to leave the game? (Y is affirmative): ">
			 <YES?>>
		    <NOT .ASK?>>
		<QUIT>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL
"ENCHANTER|
Infocom interactive fiction - a fantasy story|
Copyright (C) 1983, 1984, 1986 by Infocom, Inc. All rights reserved.|
ENCHANTER is a registered trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

;<ROUTINE V-AGAIN ("AUX" OBJ)
	 <COND (<==? ,L-PRSA ,V?WALK>
		<SETG P-WALK-DIR ,L-PRSO>
		<PERFORM ,L-PRSA ,L-PRSO>)
	       (T
		<SET OBJ
		     <COND (<AND ,L-PRSO <NOT <LOC ,L-PRSO>>>
			    ,L-PRSO)
			   (<AND ,L-PRSI <NOT <LOC ,L-PRSI>>>
			    ,L-PRSI)>>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
		       <TELL "I can't see the " D .OBJ " anymore." CR>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

\

"SUBTITLE DEATH AND TRANSFIGURATION"

<GLOBAL DEATHS 0>
;<GLOBAL LUCKY 1>

"optional arg survive? says whether ozmoo allows you to survive this
experience."

<ROUTINE JIGS-UP (DESC "OPTIONAL" (SURVIVE? T)
		  "AUX" (BOTH <>) (OZMOOD? <>) (CHEATED? <>))
 	 <SET CHEATED? <EQUAL? ,DEATH-CHEATED ,WINNER ,ME>>
	 <SET OZMOOD? <AND .SURVIVE? .CHEATED?>>
	 <SETG DEATH-CHEATED <>>
	 <COND (.DESC <TELL .DESC CR>)>
	 <COND (<NOT <==? ,PLAYER ,WINNER>>
		<TELL "|
*** The " D ,WINNER " has died ***
|
|">
		<COND (.OZMOOD?
		       <TELL
"Fortunately the " D ,WINNER " has been magically protected from violent
death and appears to be none the worse for his horrible experience." CR>)
		      (ELSE
		       <COND (.CHEATED?
			      <TELL
"Unfortunately, even the ozmoo spell was not enough to protect the " D ,WINNER
" from this eventuality." CR>)>
		       <REMOVE ,WINNER>)>
		<SETG WINNER ,PLAYER>
		<SETG HERE <LOC ,WINNER>>
		<SETG LIT <LIT? ,HERE>>
		<RFATAL>)>
	 <FORGET-ALL>
	 <TELL "
|    ****  You have died  ****
|
|">
	 <COND (.OZMOOD?
		<TELL
"Fortunately, you had the foresight to protect yourself against this
eventuality by a judicious use of the ozmoo spell. You survive this
horrible experience none the worse for wear, if somewhat chastened." CR>)
	       (T
		<COND (.CHEATED?
		       <TELL
"Unfortunately, even the ozmoo spell was not enough to protect you from
this eventuality." CR>)>
		<COND (<G? <SETG DEATHS <+ ,DEATHS 1>> 3>
		       <TELL
"You awaken among the members of the Circle. Belboz the Necromancer
is exhausted, and the other members of the Circle are disgusted.
\"I told you Krill was too powerful for such as this,\" says one.
\"We must send someone who has a chance to defeat a warlock of
Krill's experience and guile.\" Acrimonious discussion begins, as
you are waved away to join the apprentices in the scullery. A long
acquaintance with potatoes and dirty pots is about to begin." CR>
		       <FINISH>)
		      (T
		       <TELL
"You awaken among the members of the Circle. Belboz the Necromancer
looks tired, and scattered about are the remains of the components of
a spell of great healing power. The other members of the Circle are
pleased to see you revived, but worried by the setback. \"I think
Krill is too powerful,\" says one. \"This inexperienced wizard will
never defeat one so puissant as he.\" Quiet discussion ensues, with
well-concealed acrimony beneath the surface." CR>
		<COND (<OR <HELD? ,DISPEL-SCROLL>
			   <HELD? ,BANISH-SCROLL>>
		       <COND (<AND <HELD? ,DISPEL-SCROLL>
				   <HELD? ,BANISH-SCROLL>>
			      <SET BOTH T>)>
		       <TELL
"Belboz tilts his head, as if sensing something amiss. He examines
your possessions and is taken aback: \"You have acquired ">
		       <COND (.BOTH <TELL "scrolls">)
			     (T <TELL "a scroll">)>
		       <TELL " of great power.
Using spells of this kind requires surpassing wisdom.\" With a wave
of his hand, the scroll">
		       <COND (.BOTH <TELL "s disappear">)
			     (T <TELL " disappears">)>
		       <TELL "." CR>
		       <COND (<HELD? ,DISPEL-SCROLL>
			      <REMOVE ,DISPEL-SCROLL>)>
		       <COND (<HELD? ,BANISH-SCROLL>
			      <REMOVE ,BANISH-SCROLL>)>)>
		<MOVE ,SPELL-BOOK ,WINNER>
		<FCLEAR ,SPELL-BOOK ,NDESCBIT>
		<FSET ,SPELL-BOOK ,TAKEBIT>
		<COND (<FSET? ,JUG ,TOUCHBIT>
		       <MOVE ,JUG ,EAST-FORK>)>
		<COND (<AND <FSET? ,BREAD ,TOUCHBIT>
			    <G? <GETP ,BREAD ,P?SIZE> 0>>
		       <MOVE ,BREAD ,EAST-FORK>)>
		<TELL
"Debate ensues, with Belboz returning frequently to the contents of the ancient
manuscript. His wishes prevail, and it is agreed to send you back...." CR>
		<SETG THIRST-COUNT 0>
		<SETG HUNGER-COUNT 0>
		<SETG LOCKED-IN-TOWER <>>)>)>
	 <CRLF>
	 <RANDOMIZE-OBJECTS>
	 <COND (<NOT .OZMOOD?>
		<KILL-INTERRUPTS>
		<GOTO ,EAST-FORK>)>
	 <SETG P-CONT <>>
	 <RFATAL>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (F <FIRST? ,WINNER>) N)
	 <REPEAT ()
		 <COND (.F
			<SET N <NEXT? .F>>
			<COND (<FSET? .F ,SCROLLBIT>
			       <MOVE .F ,HERE>)>
			<SET F .N>)
		       (ELSE <RETURN>)>>
	 <RTRUE>>

<ROUTINE KILL-INTERRUPTS ()
	 <SETG ADVENTURER-CHARMED <>>
	 <STOP-FLYING>
	 <QUEUE I-TURTLE 0>
	 <QUEUE I-TAKE-TO-ALTAR 0>
	 <QUEUE I-GANG 0>
	 <QUEUE I-GUARDS-ARRIVE 0>
	 <RTRUE>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE V-WALK-AROUND ()
	 <USE-DIRECTIONS>>

<ROUTINE USE-DIRECTIONS ()
	 <TELL "You should use compass directions if you wish to move." CR>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "You can't launch that by saying \"launch\"!" CR>)
	       (T <TELL "How in blazes does one launch that?" CR>)>>

;<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 #DECL ((ITM) ANY (TBL) TABLE (CNT LEN) FIX)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<==? <GET .TBL .CNT> .ITM>
			<COND (<==? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 #DECL ((PT) <OR FALSE TABLE> (PTS) FIX (STR) <OR STRING FALSE>
		(OBJ) OBJECT (RM) <OR FALSE OBJECT>)
	 <COND (<AND ,TRY-FLY <PRE-FLY>>
		<RTRUE>)>
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<==? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<==? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<==? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (<EQUAL? ,WINNER ,TURTLE>
			      <COND (<IN? ,TURTLE <LOC ,PLAYER>>
				     <TELL "\"I can't go that way.\"" CR>)
				    (ELSE <NO-RESPONSE>)>
			      <RFATAL>)
			     (<OUTSIDE? ,HERE>
			      <TELL "There's no path in that direction." CR>
			      <RFATAL>)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFATAL>)>)
		      (<==? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <EQUAL? ,WINNER ,PLAYER>
		     <NOT ,LIT>
		     <PROB 90>>
		<JIGS-UP
"Oh, no! Something has come up from behind you and feasted on your person!">
		<RFATAL>)
	       (<EQUAL? ,WINNER ,TURTLE>
		<COND (<IN? ,TURTLE <LOC ,PLAYER>>
		       <TELL "\"I can't go that way.\"" CR>)
		      (ELSE <NO-RESPONSE>)>
		<RFATAL>)
	       (T
		<TELL "You can't go that way." CR>
		<RFATAL>)>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>>

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>>

<GLOBAL INDENTS
	<TABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

\

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND ;(<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are already wearing it." CR>)
		      (T <TELL "You already have it." CR>)>)
	       (<AND <LOC ,PRSO>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "You can't reach that." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSO ,ME>
		       <PERFORM ,V?DROP ,PRSI>
		       <RTRUE>)
		      (<NOT <==? ,PRSI <LOC ,PRSO>>>
		       <TELL "The " D ,PRSO " isn't in the " D ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<==? ,PRSO <LOC ,WINNER>>
		<TELL "You are in it!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<==? <ITAKE> T>
		<COND ;(<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are now wearing the " D ,PRSO "." CR>)
		      (T <TELL "Taken." CR>)>)>>

<GLOBAL FUMBLE-NUMBER 7>
<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL
", especially in light of your exhaustion.">)
			     (ELSE <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<TELL "You're holding too many things already." CR>
		<RFATAL>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<RTRUE>)>>

<ROUTINE V-PUT-ON ()
	 <COND (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T <TELL "There's no good surface on the " D ,PRSI "." CR>)>>

<ROUTINE PRE-PUT ()
	 <COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "I can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "The " D ,PRSI " isn't open." CR>)
	       (<==? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "The " D ,PRSO " is already in the " D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

;<ROUTINE PRE-DROP ()
	 <COND (<==? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have it." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE HELD? (OBJ)
	 <COND (<NOT .OBJ> <RFALSE>)
	       (<IN? .OBJ ,WINNER> <RTRUE>)
	       (<IN? .OBJ ,ROOMS> <RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS> <RFALSE>)
	       (T <HELD? <LOC .OBJ>>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,VICBIT>>
		<TELL "You can't give " A ,PRSO " to " A ,PRSI "!" CR>)
	       (T <TELL "The " D ,PRSI " refuses it politely." CR>)>>

<ROUTINE V-SGIVE ()
	 <TELL "**Bug" CR>>

<ROUTINE V-DROP () <COND (<IDROP> <TELL "Dropped." CR>)>>

<ROUTINE V-THROW () <COND (<IDROP> <TELL "Thrown." CR>)>>

<ROUTINE IDROP
	 ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>> <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "You're not carrying the " D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "The " D ,PRSO " is closed." CR>
		<RFALSE>)
	       (T <MOVE ,PRSO <LOC ,WINNER>> <RTRUE>)>>

\

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL "You must tell me how to do that to " A ,PRSO "." CR>)
	       (<NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL "It is already open." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "The " D ,PRSO " opens." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening the " D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <TELL "The " D ,PRSO " opens." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T <TELL "The " D ,PRSO " fails to open." CR>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T))
	 #DECL ((OBJ) OBJECT (F N) <OR FALSE OBJECT>)
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<TELL A .F>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>>

<ROUTINE V-CLOSE ()
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL "You must tell me how to do that to " A ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T <TELL "It is already closed." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The " D ,PRSO " is now closed." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T <TELL "It is already closed." CR>)>)
	       (ELSE
		<TELL "You cannot close that." CR>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<SET CNT <+ .CNT 1>>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

"WEIGHT:  Get sum of SIZEs of supplied object, recursing to the nth level."

<ROUTINE WEIGHT
	 (OBJ "AUX" CONT (WT 0))
	 #DECL ((OBJ) OBJECT (CONT) <OR FALSE OBJECT> (WT) FIX)
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND ;(<AND <==? .OBJ ,PLAYER> <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

<GLOBAL COPR-NOTICE
" a transcript of interaction with ENCHANTER|
ENCHANTER is a registered trademark of Infocom, Inc.|
Copyright (c) 1983 Infocom, Inc. All rights reserved.|">

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" ,COPR-NOTICE CR>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE PRE-MOVE ()
	 <COND (<OR <EQUAL? ,PRSO ,EGG-KNOB-1 ,EGG-KNOB-2 ,EGG-KNOB-3>
		    <EQUAL? ,PRSO ,EGG-KNOB-4 ,EGG-KNOB-5>>
		<RFALSE> ;"kludge")
	       (<HELD? ,PRSO>
		<TELL "I don't juggle objects!" CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving the " D ,PRSO " reveals nothing." CR>)
	       (T <TELL "You can't move the " D ,PRSO "." CR>)>>

<ROUTINE V-LAMP-ON
	 ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT> <TELL "It is already on." CR>)
		      (ELSE
		       <FSET ,PRSO ,ONBIT>
		       <TELL "The " D ,PRSO " is now on." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (T
		<TELL "You can't turn that on." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL "It is already off." CR>)
		      (ELSE
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (<NOT <EQUAL? ,ETERNAL-FLAME ,LANTERN>>
			      <FCLEAR ,PRSO ,LIGHTBIT>)>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL "The " D ,PRSO " is now off." CR>
		       <SETG LIT <LIT? ,HERE>>
		       <COND (<NOT <LIT? ,HERE <>>>
			      <COND (<OR <NOT <EQUAL? ,HERE ,GALLERY>>
					 <NOT <DESCRIBE-PORTRAIT-GALLERY>>>
				     <TELL "It is now pitch black." CR>)>)>)>)
	       (<FSET? ,PRSO ,ONBIT>
		<TELL "It's not easy to see how. It's glowing by magic." CR>)
	       (ELSE <TELL "You can't turn that off." CR>)>
	 <RTRUE>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 #DECL ((NUM) FIX)
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<EQUAL? <LOC ,PRSO> ,HERE ,WINNER>
		<TELL "It's already here!" CR>)
	       (T <TELL "You will probably be waiting quite a while." CR>)>>

<ROUTINE PRE-BOARD
	 ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in the " D .AV ", cretin!" CR>)
		      (T <RFALSE>)>)
	       (T
		<TELL "You can't get into the "
		      D
		      ,PRSO
		      "!" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD
	 ("AUX" AV)
	 #DECL ((AV) OBJECT)
	 <TELL "You are now in the " D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT <==? <LOC ,WINNER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (T
		<TELL "You are on your feet again." CR>
		<MOVE ,WINNER ,HERE>)>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" OLIT OHERE)
	 <SET OHERE ,HERE>
	 <SET OLIT ,LIT>
	 <MOVE ,WINNER .RM>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <EQUAL? ,WINNER ,PLAYER>
		     <NOT .OLIT>
		     <NOT ,LIT>
		     <PROB 85>>
		<JIGS-UP
"Oh, no! Something slithered alongside you and feasted on your person!">
		<RTRUE>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<SETG ADV-OLD-LOC <>>
		<COND (<AND <IN? ,ADVENTURER .OHERE>
			    ,ADVENTURER-CHARMED
			    <WINNER-HAS-TREASURE?>
			    <NOT <EQUAL? ,HERE ,T-A ,TEMPLE ,CLOSET>>
			    <NOT <EQUAL? ,HERE ,WEST-CASTLE>>>
		       <TELL
"The adventurer, proceeding cautiously, follows you. He seems to be
paying particular attention to your possessions." CR CR>
		       <MOVE ,ADVENTURER ,HERE>
		       <SETG ADVENTURER-STAY T>)>)>
	 <COND (<NOT <==? ,HERE .RM>> <RTRUE>)
	       (<NOT <==? ,PLAYER ,WINNER>>
		<COND (<AND <NOT <EQUAL? ,HERE ,CLOSET ,ENGINE-ROOM>>
			    <IN? ,PLAYER .OHERE ;"Used to be ,HERE">>
		       <TELL
"The " D ,WINNER ", ever the good friend, leaves you." CR>)
		      (<AND <NOT <EQUAL? ,HERE ,CLOSET ,ENGINE-ROOM>>
			    <IN? ,PLAYER ,HERE>>
		       <TELL
"The " D ,WINNER " returns to you." CR>)>)
	       (.V? <V-FIRST-LOOK>)>
	 <RTRUE>>

<ROUTINE WINNER-HAS-TREASURE? ()
	 <COND (<OR <IN? ,EGG ,WINNER>
		    <IN? ,MAGIC-KNIFE ,WINNER>
		    <IN? ,JEWELLED-BOX ,WINNER>
		    <IN? ,SILVER-SPOON ,WINNER>>
		<RTRUE>)>>

<ROUTINE V-BACK ()
	 <USE-DIRECTIONS>>

<ROUTINE V-POUR-ON () <TELL "You can't pour that on anything!" CR>>

<ROUTINE V-SPRAY () <V-SQUEEZE>>
<ROUTINE V-SSPRAY () <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-SQUEEZE
	 ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "The " D ,PRSO " does not understand this.">)
	       (ELSE <TELL "How singularly useless.">)>
	 <CRLF>>

<ROUTINE PRE-OIL ()
	 <TELL "You probably put spinach in your gas tank, too." CR>>

<ROUTINE V-OIL () <TELL "That's not very useful." CR>>

<ROUTINE V-ADVENT () <TELL "A hollow voice says \"Fool.\"" CR>>

<ROUTINE V-DRINK ("AUX" S)
	 <COND (<AND <EQUAL? ,PRSO ,WATER>
		     <FSET? ,PRSO ,RMUNGBIT>>
		<TELL
"Ooh! The water tastes terrible, and even the slightest amount makes you
ill." CR>)
	       (<AND <EQUAL? ,PRSO ,GLOBAL-WATER>
		     <EQUAL? ,HERE ,BEACH ,FOREST-2>>
	        <TELL "Ooh! That tastes terrible!" CR>)
	       (<NOT <EQUAL? ,PRSO ,WATER ,GLOBAL-WATER>>
		<TELL "You can't drink that!" CR>)
	       (T
		<SET S <GET <INT I-THIRST> ,C-TICK>>
		<COND (<G? .S 60>
		       <TELL "You aren't the least bit thirsty." CR>
		       <RTRUE>)>
		<QUEUE I-THIRST <+ .S 39>>
		<SETG THIRST-COUNT 0>
		<SETG SCORE <+ ,SCORE ,DRINK-POINT>>
		<SETG DRINK-POINT 0>
		<TELL
"The delicious spring water tasted great">
		<COND (<EQUAL? ,HERE ,SHADY-BROOK>
		       <TELL "." CR>)
		      (<EQUAL? ,PRSO ,WATER>
		       <PUTP ,PRSO ,P?SIZE <SET S <- <GETP ,PRSO ,P?SIZE> 1>>>
		       <COND (<EQUAL? .S 0>
			      <REMOVE ,WATER>)>
		       <TELL <GET ,JUG-FILLS .S> CR>)
		      (T <TELL "." CR>)>)>> 
		       
<GLOBAL JUG-FILLS <TABLE
", but the jug is now empty."
", and there's still some left."
", and there's plenty more."
", and there's lots more where that came from."
", and the jug's practically full.">>
 
<ROUTINE V-EAT ()
	 <TELL
"Did they teach you to eat that in survival school?" CR>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,VILLAIN>
		       <TELL "Insults of this nature won't help you." CR>)
		      (T
		       <TELL "What a loony!" CR>)>)
	       (T
		<TELL
"Such language from an enchanter!" CR>)>>

<ROUTINE V-LISTEN ()
	 <TELL "The " D ,PRSO " makes no sound." CR>>

<ROUTINE V-FOLLOW ()
	 <TELL "You're nuts!" CR>>

<ROUTINE V-STAY ()
	 <TELL "You will be lost without me!" CR>>

<ROUTINE V-PRAY ()
	 <TELL "If you pray enough, your prayers may be answered." CR>>

<ROUTINE V-LEAP ("AUX" TX S)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,VILLAIN>
			      <TELL "The "
				    D
				    ,PRSO
				    " is too big to jump over." CR>)
			     (T <V-SKIP>)>)
		      (T <TELL "That would be a good trick." CR>)>)
	       (<SET TX <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .TX>>
		<COND (<OR <==? .S 2>					 ;NEXIT
			   <AND <==? .S 4>				 ;CEXIT
				<NOT <VALUE <GETB .TX 1>>>>>
		       <TELL
"This was not a very safe place to try jumping." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      (T <V-SKIP>)>)
	       (ELSE <V-SKIP>)>>

<ROUTINE V-SKIP () <TELL "Wasn't that fun?" CR>>

<ROUTINE V-LEAVE () <DO-WALK ,P?OUT>>

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,VILLAIN>
		       <TELL "The "
			     D
			     ,PRSO
			     " bows his head to you in greeting." CR>)
		      (ELSE
		       <TELL
"I think that only schizophrenics say \"Hello\" to a "
			     D
			     ,PRSO
			     "." CR>)>)
	       (ELSE <TELL <PICK-ONE ,HELLOS> CR>)>>

<GLOBAL HELLOS <LTABLE 0
"Hello."
"Good day."
"Nice weather we've been having lately."
"Good-bye.">>

<GLOBAL JUMPLOSS <LTABLE 0
"You should have looked before you leaped."
"I'm afraid that leap was a bit much for your weak frame.">>

<ROUTINE PRE-READ ()
	 <COND (<==? ,PRSO ,SPELL-BOOK> <RFALSE> ;"special case")
	       (<NOT ,LIT>
		<TELL "It is impossible to read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through " A ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "How can I read " A ,PRSO "?" CR>)
	       (ELSE <TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-LOOK-UNDER () <TELL "There is nothing but dust there." CR>>

<ROUTINE V-LOOK-BEHIND () <TELL "There is nothing behind the " D ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE
	 ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The "
			     D
			     ,PRSO
			     " is open.">)
		      (ELSE <TELL "The " D ,PRSO " is closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "There is nothing special to be seen." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO> <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (<FSET? ,PRSO ,SURFACEBIT>
			      <TELL "There is nothing on the " D ,PRSO "." CR>)
			     (T
			      <TELL "The " D ,PRSO " is empty." CR>)>)
		      (ELSE <TELL "The " D ,PRSO " is closed." CR>)>)
	       (ELSE <TELL "You can't look inside " A ,PRSO "." CR>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE V-REPENT () <TELL "It could very well be too late!" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL "Your blazing gaze is insufficient." CR>)
	       (<EQUAL? ,PRSI ,ETERNAL-FLAME> <RFALSE>)
	       (T <TELL "With " A ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND (<FSET? ,PRSO ,BURNBIT>
		<COND (<IN? ,PRSO ,WINNER>
		       <REMOVE ,PRSO>
		       <TELL "The " D ,PRSO " catches fire." CR>
		       <JIGS-UP
"Unfortunately, you were holding it at the time.">)
		      (T
		       <REMOVE ,PRSO>
		       <TELL "The " D ,PRSO
" catches fire and is consumed." CR>)
		      (ELSE <TELL "You don't have that." CR>)>)
	       (T <TELL "I don't think you can burn " A ,PRSO "." CR>)>>

<ROUTINE V-TURN () <TELL "This has no effect." CR>>

<ROUTINE V-PUMP () <TELL "It's not clear how." CR>>

<ROUTINE V-INFLATE () <TELL "How can you inflate that?" CR>>

<ROUTINE V-DEFLATE () <TELL "Come on, now!" CR>>

<ROUTINE V-LOCK () <TELL "It doesn't seem to work." CR>>

<ROUTINE V-PICK () <TELL "You can't pick that." CR>>

<ROUTINE V-UNLOCK () <V-LOCK>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<PERFORM ,V?KILL ,PRSO ,PRSI>)
	       (<AND <FSET? ,PRSO ,BURNBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<REMOVE ,PRSO>
		<TELL "Your skillful "
		      D
		      ,PRSI
		      "smanship slices the "
		      D
		      ,PRSO
		      " into innumerable
slivers which evaporate instantaneously."
		      CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"I doubt that the \"cutting edge\" of " A ,PRSI " is adequate." CR>)
	       (T
		<TELL "Strange concept, cutting the " D ,PRSO "...." CR>)>>

<ROUTINE PRE-HIT ()
	 <COND (<AND ,PRSI <NOT <IN? ,PRSI ,WINNER>>>
		<TELL "You don't have the " D ,PRSI "." CR>)>>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 #DECL ((STR) STRING)
	 <COND (<NOT ,PRSO> <TELL "There is nothing here to " .STR "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,VILLAIN>>
		     <NOT <FSET? ,PRSO ,VICBIT>>>
		<TELL "I've known strange people, but fighting a "
		      D
		      ,PRSO
		      "?" CR>)
	       (<OR <NOT ,PRSI> <==? ,PRSI ,HANDS>>
		<TELL "Trying to "
		      .STR
		      " a "
		      D
		      ,PRSO
		      " with your bare hands is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "You aren't even holding the " D ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to "
		      .STR
		      " the "
		      D
		      ,PRSO
		      " with a "
		      D
		      ,PRSI
		      " is suicidal." CR>)
	       (ELSE <TELL "You'd never survive the attack." CR>)>>

<ROUTINE V-ATTACK () <IKILL "attack">>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T <PERFORM ,V?ATTACK ,PRSI ,PRSO>)>>

<ROUTINE V-KICK () <HACK-HACK "Kicking the ">>

<ROUTINE V-WAVE () <HACK-HACK "Waving the ">>

<ROUTINE V-WAVE-AT () <TELL
"Despite your friendly nature, the " D ,PRSO " isn't likely to respond." CR>>

<ROUTINE V-RAISE () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-LOWER () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-RUB () <HACK-HACK "Fiddling with the ">>

<ROUTINE V-PUSH () <HACK-HACK "Pushing the ">>

<ROUTINE V-PUSH-TO () <TELL "You can't push things to that." CR>>

<ROUTINE V-MUNG ()
	 <COND (<NOT <FSET? ,PRSO ,VICBIT>>
		<HACK-HACK "Trying to damage the ">)
	       (<NOT ,PRSI>
		<TELL "Trying to break the "
		      D
		      ,PRSO
		      " with your bare hands is suicidal." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to destroy the "
		      D
		      ,PRSO
		      " with a "
		      D
		      ,PRSI
		      " is quite self-destructive." CR>)
	       (T <TELL "You can't." CR>)>>

<ROUTINE HACK-HACK
	 (STR)
	 #DECL ((STR) STRING)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS> <VERB? WAVE RAISE LOWER>>
		<TELL "The " D ,PRSO " isn't here!" CR>)
	       (T <TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE 0
	 " doesn't do anything."
	 " doesn't accomplish anything."
	 " has no desirable effect.">>

<ROUTINE WORD-TYPE
	 (OBJ WORD "AUX" SYNS)
	 #DECL ((OBJ) OBJECT (WORD SYNS) TABLE)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE V-KNOCK
	 ()
	 <COND (<WORD-TYPE ,PRSO ,W?DOOR>
		<TELL "I don't think that anybody's home." CR>)
	       (ELSE <TELL "Why knock on " A ,PRSO "?" CR>)>>

<ROUTINE V-YELL () <TELL "Aarrrrrgggggggghhhhhhhhhhh!" CR>>

<ROUTINE V-PLUG () <TELL "This has no effect." CR>>

<ROUTINE V-EXORCISE () <TELL "You can't do that with mere words!" CR>>

\

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "Be real." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (T <TELL "There's no point in shaking that." CR>)>>

<ROUTINE PRE-DIG ()
	 <COND (<NOT ,PRSI> <SETG PRSI ,HANDS>)>
	 <COND (<FSET? ,PRSO ,TOOLBIT>
		<SETG PRSI ,PRSO>
		<SETG PRSO ,GROUND>)>
	 <COND (<FSET? ,PRSI ,TOOLBIT> <RFALSE>)
	       (ELSE
		<TELL "Digging with the " D ,PRSI " is very silly." CR>)>>

<ROUTINE V-DIG ()
	 <TELL "The ground is unsuitable for digging here." CR>>

<ROUTINE V-SMELL ()
	 <TELL "It smells just like " A ,PRSO "." CR>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)
	 <COND (<SET TX <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TX <- <PTSIZE .TX> 1>>)>>

<ROUTINE V-SWIM ()
	 <COND (<AND <NOT ,PRSO>
		     <GLOBAL-IN? ,GLOBAL-WATER ,HERE>>
		<SETG PRSO ,GLOBAL-WATER>)>
	 <COND (<EQUAL? ,PRSO ,GLOBAL-WATER ,SEA>
		<TELL "You'd probably drown." CR>)
	       (<EQUAL? ,PRSO ,WATER>
		<TELL "This is a very small brook. Forget it." CR>)
	       (T <TELL "There's nothing to swim in!" CR>)>>

<ROUTINE V-UNTIE () <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE PRE-TIE
	 ()
	 <COND (<==? ,PRSI ,WINNER>
		<TELL "You can't tie it to yourself." CR>)>>

<ROUTINE V-TIE () <TELL "You can't tie the " D ,PRSO " to that." CR>>

<ROUTINE V-TIE-UP () <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-MELT () <TELL "I'm not sure that " A ,PRSO " can be melted." CR>>

<ROUTINE V-MUMBLE
	 ()
	 <TELL "You'll have to speak up if you expect me to hear you!" CR>>

<ROUTINE V-ALARM ()
	 <TELL "The " D ,PRSO " isn't sleeping." CR>>

<ROUTINE V-ZORK ()
	 <TELL
"ZORK (R) - A trilogy of fantasy classics from INFOCOM. " CR>>

\

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<V-CLIMB-UP ,P?UP T>)
	       (T
		<TELL "You can't climb onto the " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-FOO ()
	 <V-CLIMB-UP ,P?UP T>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X)
	 #DECL ((DIR) FIX (OBJ) <OR ATOM FALSE> (X) TABLE)
	 <COND (<GETPT ,HERE .DIR>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<NOT .OBJ>
		<TELL "You can't go that way." CR>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Climbing the walls is to no avail." CR>)
	       (ELSE <TELL "Bizarre!" CR>)>>

<ROUTINE V-LIE-DOWN ()
	 <COND (<EQUAL? ,HERE ,BEDROOM>
		<PERFORM ,V?BOARD ,BED>
		<RTRUE>)
	       (T
		<PERFORM ,V?SLEEP>
		<RTRUE>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <V-CLIMB-UP ,P?DOWN>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "Why would you send for the " D ,PRSO "?" CR>)
	       (ELSE <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-WIND ()
	 <TELL "You cannot wind up " A ,PRSO "." CR>>

<ROUTINE V-COUNT ()
    <TELL "You have lost your mind." CR>>

<ROUTINE V-PUT-UNDER ()
         <TELL "You can't put anything under that." CR>>

;"Fix this"

<ROUTINE V-PLAY ()
         <COND (<EQUAL? ,PRSO ,KRILL ,GLOBAL-KRILL>
	        <TELL
"You are so engrossed in the role of the " D ,PRSO " that
you kill yourself, just as he would have done!" CR>
	        <JIGS-UP <>>)
	       (T <TELL "How peculiar!" CR>)>>

<ROUTINE V-ENTER ()
	 <DO-WALK ,P?IN>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-CROSS ()
	 <TELL "You can't cross that!" CR>>

<ROUTINE V-SEARCH ()
	 <TELL "You find nothing unusual." CR>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS>
		<TELL
"Within six feet of your head, assuming you haven't left that
somewhere." CR>)
	       (<==? ,PRSO ,ME>
		<TELL "You're around here somewhere..." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it!" CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <IN? ,PRSO ,LOCAL-GLOBALS>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT ,ROAD>>
		<TELL "It's right in front of you." CR>)
	       (<FSET? .L ,VILLAIN>
		<TELL "The " D .L " has it." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's in the " D .L "." CR>)
	       (ELSE
		<TELL "Beats me, but it's not here." CR>)>>

<ROUTINE V-TELL ()
	 <COND (<EQUAL? ,PRSO ,TURTLE ,ADVENTURER ,FROG>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL
"The " D, PRSO " looks at you expectantly, as though he thought you were
about to talk." CR>)>)
	       (T
		<TELL "You can't talk to the " D ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that the " D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a pig." CR>>

<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W> <RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT> <RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RETURN <>>)>>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,VICBIT>>
		<TELL "You must address the " D .V " directly." CR>)
	       (<==? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (ELSE
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<TELL
"Talking to yourself is said to be a sign of impending mental
collapse." CR>)>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL "You hit your head against the "
			    D ,PRSO
			    " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (ELSE <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-WEAR ()
	 <COND ;(<FSET? ,PRSO ,WEARBIT> <PERFORM ,V?TAKE ,PRSO> <RTRUE>)
	       (ELSE
		<TELL "You can't wear the " D ,PRSO "." CR>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "You can't throw anything off that!" CR>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <EQUAL? ,PRSO ,INTNUM>
		     <EQUAL? ,P-NUMBER 4338>>
		<TELL N ,SERIAL CR>)
	       (,PRSO <TELL "I don't understand that sentence." CR>)
	       (ELSE
		<TELL "Verifying disk..." CR>
		<COND (<VERIFY> <TELL "The disk is correct." CR>)
		      (T <TELL CR "** Disk Failure **" CR>)>)>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (ELSE
		<TELL "You are already standing, I think." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "It's here!" CR>)
	       (T <TELL "You should supply a direction!" CR>)>>

;"Finds the room on the other side of a door"

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX)
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET TX <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TX> ,DEXIT>
				    <EQUAL? <GETB .TX ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE V-DRINK-FROM ()
	 <COND (<EQUAL? ,PRSO ,GLOBAL-WATER>
		<PERFORM ,V?DRINK ,PRSO>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSO ,JUG>
		     <IN? ,WATER ,JUG>>
		<PERFORM ,V?DRINK ,WATER>
		<RTRUE>)
	       (T <TELL "How peculiar!" CR>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Are you so very tired, then?" CR>>

<ROUTINE V-MAKE-LINE-TO ()
	 <COND (<AND <FSET? ,PRSO ,POINTBIT>
		     <FSET? ,PRSI ,POINTBIT>>
		<COND (<NOT <IN? ,PENCIL ,WINNER>>
		       <TELL
"You're not holding anything you can make it with." CR>)
		      (<EQUAL? ,PENCIL-COUNT 0>
		       <TELL
"There's not enough left of the pencil to make a line with." CR>)
		      (T
		       <CONNECT <GET ,TMAZE-ROOMS <GETP ,PRSO ,P?POINT>>
				<GET ,TMAZE-ROOMS <GETP ,PRSI ,P?POINT>>>)>)
	       (T <TELL "That's silly." CR>)>>

<ROUTINE V-MAKE-LINE ()
	 <COND (<AND ,PRSI <FSET? ,PRSI ,POINTBIT>>
		<PERFORM ,V?MAKE-LINE-TO ,PRSO ,PRSI>
		<RFATAL>)
	       (<AND ,PRSI <NOT <EQUAL? ,PRSI ,PENCIL>>>
		<TELL
"You won't write anything with that!" CR>)
	       (<NOT <2OBJS?>> <RFATAL>)
	       (T
		<PERFORM ,V?MAKE-LINE-TO <GET ,P-PRSO 1> <GET ,P-PRSO 2>>
		<RFATAL>)>>

<ROUTINE V-ERASE-LINE-TO ()
	 <COND (<AND <FSET? ,PRSO ,POINTBIT>
		     <FSET? ,PRSI ,POINTBIT>>
		<COND (<NOT <IN? ,PENCIL ,WINNER>>
		       <TELL
"You're not holding anything you can erase it with." CR>)
		      (<EQUAL? ,ERASER-COUNT 0>
		       <TELL
"There's not enough left of the eraser." CR>)
		      (T
		       <DISCONNECT <GET ,TMAZE-ROOMS
					<GETP ,PRSO ,P?POINT>>
				   <GET ,TMAZE-ROOMS
					<GETP ,PRSI ,P?POINT>>>)>)
	       (T <TELL "That's silly." CR>)>>

<ROUTINE V-ERASE-LINE ()
	 <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,PENCIL>>>
		<TELL
"You won't erase anything with that!" CR>)
	       (<EQUAL? <GET ,P-PRSO 0> 1>
		<COND (<EQUAL? <GET ,P-PRSO 1> ,PENCIL>
		       <TELL
"If you want to erase one of the pencil lines, you should specify the
line. For example, \"ERASE THE LINE BETWEEN X AND Z.\"" CR>)
		      (<FSET? <GET ,P-PRSO 1> ,POINTBIT>
		       <TELL "You can't seem to erase the marking." CR>)
		      (T
		       <TELL "You can't erase that!" CR>)>)
	       (<NOT <2OBJS?>> <RFATAL>)
	       (T
		<PERFORM ,V?ERASE-LINE-TO <GET ,P-PRSO 1> <GET ,P-PRSO 2>>
		<RFATAL>)>>

<ROUTINE 2OBJS? ()
	 <COND (<NOT <EQUAL? <GET ,P-PRSO 0> 2>>
		<PUT ,P-PRSO 0 1>
		<TELL "That sentence doesn't make sense." CR>
		<RFALSE>)
	       (T <RTRUE>)>>		 

<GLOBAL YUKS
	<LTABLE 0
	 "No spell would help with that!"
	 "It would take more magic than you've got!"
	 "You can't be serious."
	 "You must have had a silliness spell cast upon you.">>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <COND (<OR <NOT <FSET? ,PRSO ,CONTBIT>>
		    <FSET? ,PRSO ,VILLAIN>>
		<TELL "What a maroon!" CR>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's not open." CR>)
	       (<OR <NOT <SET OBJ <FIRST? ,PRSO>>>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL "It's empty." CR>)
	       (T
		<TELL
"You reach into the " D ,PRSO " and feel something." CR>
		<RTRUE>)>>

<ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) (HIDE? <>) "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<RIPOFF .X .WHERE>
			<COND (.HIDE? <FSET .X ,NDESCBIT>)>
			<SET ROBBED? .X>)>
		 <SET X .N>>>

<ROUTINE BLT (WHO WHERE "AUX" N X (CNT 0))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .CNT>)>
		 <SET N <NEXT? .X>>
		 <MOVE .X .WHERE>
		 <SET CNT <+ .CNT 1>>
		 <SET X .N>>>

<ROUTINE RIPOFF (X WHERE)
	 <COND (<AND <NOT <FSET? .X ,INVISIBLE>>
		     <NOT <FSET? .X ,SCROLLBIT>>
		     <NOT <EQUAL? .X ,BREAD ,JUG>>
		     <FSET? .X ,TOUCHBIT>
		     <FSET? .X ,TAKEBIT>>
		<COND (<==? .X ,STRONG-BOX> <RFALSE>)
		      (<AND .WHERE <IN? .X .WHERE>>
		       <RFALSE>)
		      (.WHERE <MOVE .X .WHERE>)
		      (ELSE <REMOVE .X>)>
		<RTRUE>)>>

<ROUTINE V-POINT ()
	 <COND (<IN? ,ADVENTURER ,HERE>
		<COND (<IN? ,PRSO ,ADVENTURER>
		       <PERFORM ,V?ASK-FOR ,ADVENTURER ,PRSO>
		       <RTRUE>)
		      (,ADVENTURER-CHARMED
		       <TELL
"The adventurer nods as if in approval of the " D ,PRSO "." CR>)
		      (T
		       <TELL
"The adventurer backs off from the " D ,PRSO "." CR>)>)
	       (T <TELL "Not much use in that...." CR>)>>

<ROUTINE V-ASK-FOR ()
	 <COND (<EQUAL? ,PRSO ,ADVENTURER>
		<COND (<NOT <IN? ,PRSI ,PRSO>>
		       <TELL "He's not holding that!" CR>)
		      (,ADVENTURER-CHARMED
		       <COND (<FSET? ,PRSI ,TREASURE>
			      <TELL
"The adventurer politely refuses, indicating its great beauty and value." CR>)
			     (<EQUAL? ,PRSI ,LANTERN ,SWORD>
			      <TELL
"The adventurer refuses, indicating its utter necessity in his travels." CR>)
			     (T
			      <MOVE ,PRSI ,WINNER>
			      <TELL
"The adventurer, not seeing any use in keeping the " D ,PRSI " anyway, hands
it to you gladly." CR>)>)
		      (T
		       <TELL
"The adventurer waves you off with an aggressive gesture." CR>)>)
	       (T <TELL "The " D ,PRSO " is not likely to oblige." CR>)>>

<ROUTINE V-THANK ()
	 <COND (<AND ,PRSO <FSET? ,PRSO ,VILLAIN>>
		<TELL "The " D ,PRSO " seems less than overjoyed." CR>)
	       (T
		<TELL
"The Circle will revoke your certificate if you keep this up." CR>)>> 

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>)
		      (T
		       <TELL "There's nothing to fill it with." CR>)>)
	       (T <TELL "I don't see how you propose to do that." CR>)>>

<ROUTINE V-ESCAPE ()
	 <TELL "There is no escape from the " D ,PRSO "!" CR>>

<ROUTINE V-WRITE-WITH ()
	 <COND (<EQUAL? ,PRSO ,PENCIL>
		<COND (<IN? ,TMAP ,WINNER>
		       <WRITE-HINT>
		       <RTRUE>)
		      (T
		       <TELL "There's nothing good to write on." CR>)>)
	       (T <TELL "You can't write with that!" CR>)>>

<ROUTINE WRITE-HINT ()
	 <TELL
"You can't draw on it arbitrarily. Rather, the pencil seems to home in on
various points on the map, daring you to draw a line between them." CR>>

<ROUTINE V-WRITE-ON ("AUX" SPELL)
	 <COND (<OR <EQUAL? ,PRSI ,PENCIL>
		    <AND <NOT ,PRSI> <IN? ,PENCIL ,WINNER>>>
		<COND (<EQUAL? ,PRSO ,TMAP>
		       <WRITE-HINT>)
		      (<AND <FSET? ,PRSO ,SCROLLBIT>
			    <FIRST? ,PRSO>>
		       <SET SPELL <FIRST? ,PRSO>>
		       <FSET .SPELL ,RMUNGBIT>
		       <TELL
"You've written on the scroll all right, but you've also defaced the spell
written on it." CR>)
		      (T
		       <TELL "You can't write on that!" CR>)>
		<RTRUE>)
	       (,PRSI
		<TELL "You can't write with that!" CR>)
	       (T
		<TELL "You have nothing to write with!" CR>)>>

<ROUTINE V-AVOID ()
	 <TELL "Perhaps that is unavoidable." CR>>

<ROUTINE V-SHOW ()
	 <TELL "I doubt the " D ,PRSI " is interested." CR>>

<ROUTINE PRE-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW () <V-SGIVE>>

<ROUTINE PRE-BRING ()
	 <COND (<NOT <EQUAL? ,PRSO ,ME>>
		<TELL "I don't understand that sentence." CR>
		<RTRUE>)>>

<ROUTINE V-BRING ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "Are you talking to yourself again?" CR>)
	       (T
		<TELL "\"You can get it yourself!\"" CR>)>>
	       
<ROUTINE V-DRAW-ON ()
	 <COND (<FSET? ,PRSO ,SCROLLBIT>
		<PERFORM ,V?WRITE-ON ,PRSO>
		<RTRUE>)
	       (T <TELL "You can't draw on that!" CR>)>>  

<ROUTINE V-SHARPEN ()
	 <COND (<EQUAL? ,PRSI ,MAGIC-KNIFE ,SWORD>
		<COND (<EQUAL? ,PRSO ,MAGIC-KNIFE ,SWORD>
		       <TELL "It's plenty sharp already." CR>)
		      (<EQUAL? ,PRSO ,PENCIL>
		       <TELL
"The pencil can't be sharpened. Perhaps it is magical." CR>)
		      (T
		       <TELL "You can't sharpen that." CR>)>)
	       (T
		<TELL "You'll never sharpen anything with that!" CR>)>>

<ROUTINE V-FORGET ()
	 <TELL
"You might also try not thinking about a purple hippopotamus!" CR>>

<ROUTINE PRE-FLY ()
	 <COND (,FLYING? <RFALSE>)
	       (,PRSO
		<TELL "What a loon!" CR>
		<RTRUE>)
	       (T
		<TELL
"You are probably a loon, although you can't fly." CR>)>>

<ROUTINE V-HIDE ()
	 <COND (<NOT ,PRSO>
		<TELL
"You'll have to say which direction you want to go." CR>
		<RFATAL>)
	       (<OR <EQUAL? ,PRSI ,ADVENTURER>
		    <AND <NOT ,PRSI> <IN? ,ADVENTURER ,HERE>>>
		<COND (<FSET? ,PRSO ,TREASURE>
		       <TELL
"Too late. The adventurer has already noticed the " D ,PRSO "." CR>)
		      (T
		       <TELL
"He isn't interested in that anyway." CR>)>)
	       (<AND ,PRSI <FSET? ,PRSI ,VICBIT>>
		<TELL
"Why? The " D ,PRSI " isn't interested in it." CR>)
	       (<NOT ,PRSI>
		<TELL
"From what? From whom? Why?" CR>)>>

<ROUTINE V-CHASTISE ()
	 <TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT THE
OBJECT, LOOK INSIDE THE OBJECT, LOOK FOR THE OBJECT, etc." CR>>

<ROUTINE V-GAG ()
	 <COND (<NOT <EQUAL? ,PRSO ,ME>>
		<TELL "What a concept!" CR>)
	       (<NOT <EQUAL? ,PRSI ,SILVER-SPOON>>
		<TELL "With a " D ,PRSO "?" CR>)
	       (T <TELL "Grody to the max! Like, totally!" CR>)>>

<ROUTINE V-GROSS-OUT ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "Let's not be disgusting!" CR>)
	       (T
		<TELL "Gag me with a spoon!" CR>)>>

<ROUTINE V-WHO ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (T <TELL "That's not a person!" CR>)>>
	       