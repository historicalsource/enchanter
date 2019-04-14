"TEMPLE for
		 	    ENCHANTER
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<ROOM TEMPLE
      (IN ROOMS)
      (DESC "Temple")
      (LDESC
"This is the interior of a huge temple of primitive construction. A few
flickering torches cast a sallow illumination over the altar, which, atop
a row of stairs, is still drenched with the blood of human sacrifice. Behind
the altar is an enormous statue of a demon which seems to reach towards you
with dripping fangs and razor-sharp talons. Two open doorways lead out of the
temple to the east and west, while two wooden doors stand at the north and
south. A mass of hunched figures in the temple are chanting a haunting tune.
They don't seem interested in your presence.")
      (NORTH TO TOWER-N IF TOWER-N-DOOR IS OPEN)
      (SOUTH TO TOWER-S IF TOWER-S-DOOR IS OPEN)
      (WEST TO COURTYARD-3)
      (EAST TO COURTYARD-7)
      (UP TO ALTAR)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STAIRS TOWER-N-DOOR TOWER-S-DOOR STATUE TEMPLE-OBJ)
      (ACTION TEMPLE-F)
      (PSEUDO "ALTAR" ALTAR-PSEUDO)>

<ROUTINE ALTAR-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"A close examination of the altar nearly sickens you. It fairly screams with
the memory of the horrors it has seen since the coming of Krill. Its original
white marble has been crusted with blood and desecrated by the minions of the
evil Warlock." CR>)
	       (<AND <EQUAL? ,HERE ,TEMPLE>
		     <VERB? CLIMB-UP CLIMB-FOO CLIMB-ON WALK-TO>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? CLIMB-ON WALK-TO RUB CLIMB-UP CLIMB-FOO>
		<TELL
"There is nothing you would like less than nearing the altar." CR>)>>

<OBJECT STATUE
	(IN LOCAL-GLOBALS)
	(DESC "statue")
	(SYNONYM STATUE TALONS FANGS)
	(ADJECTIVE RAZOR-SHARP DRIPPING ENORMOUS)
	(FLAGS NDESCBIT)
	(ACTION STATUE-F)>

<ROUTINE STATUE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is an enormous statue of a loathsome creature, dark and vile, with
dripping fangs and razor-sharp talons. It appears almost to be motioning
with its outstretched talons for you to approach." CR>)
	       (<VERB? RUB>
		<TELL
"Your sensibilities are offended by the very idea." CR>)>> 

<OBJECT GANG-OF-N
	(IN TEMPLE)
	(DESC "huddled mass, yearning to drink blood")
	(SYNONYM MASS FIGURE SHAPES MEN)
	(ADJECTIVE HUDDLED HAIRY)
	(FLAGS NDESCBIT VICBIT)
	(ACTION GANG-OF-N-F)>

<ROUTINE GANG-OF-N-F ()
	 <COND (<VERB? GUNCHO>
		<TELL
"The majority of the mass of figures fades away into nothingness.
Enough remain, however, to continue the service (or whatever
it is)." CR>)
	       (<VERB? FROTZ>
		<TELL
"A few select figures suddenly start to give off light, to the horror of
the remaining ones, who rip them to shreds in an instant." CR>)
	       (<VERB? VAXUM>
		<TELL
"Nothing seems to have happened, although a few of the figures seem
to be chanting in a less guttural tone." CR>)
	       (<VERB? ZIFMIA>
		<TELL
"Something appears to have snapped. The figures, who were so peacefully
ignoring you, now seem to have taken a different, and less pleasant, tack." CR>
		<TAKE-TO-TOWER>)
	       (<VERB? CLEESH>
		<TELL
"Some of the figures hunch down even more and scuttle off." CR>)>>

<ROOM ALTAR
      (IN ROOMS)
      (DESC "Sacrificial Altar")
      (LDESC
"This is the altar of the temple. Acrid smoke fills the air, and a feeling
of lurking evil is all around. A low droning, just at the lowest end of
your perception, causes your hair to stand on end. Behind the altar is an
enormous statue of a demon which reaches toward you with dripping fangs
and razor-sharp talons. The fangs and talons are blood-red. In the
temple below is a mass of hunched figures, chanting in hideous tones.")      
      (DOWN TO TEMPLE)
      (FLAGS RLANDBIT ONBIT RMUNGBIT)
      (GLOBAL STAIRS STATUE VOICES)
      (PSEUDO "ALTAR" ALTAR-PSEUDO)>

<ROOM TOWER-N
      (IN ROOMS)
      (DESC "Cell")
      (LDESC 
"This is a small prison cell in the north tower of the temple. Hideous shapes
can be seen through the iron-barred window in the prison door. From the temple,
a bloodcurdling chant can be heard.")
      (SOUTH TO TEMPLE IF TOWER-N-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (TEXT
"Hideous shapes chanting in unison can be seen through the cell window.")
      (GLOBAL TOWER-N-DOOR WINDOW GUARDS)
      (PSEUDO "CELL" CELL-PSEUDO)>

<OBJECT GUARDS
	(IN LOCAL-GLOBALS)
	(DESC "guards")
	(SYNONYM GUARD GUARDS SHAPE SHAPES)
	(ADJECTIVE HIDEOUS HAIRY)
	(FLAGS VICBIT)
	(ACTION GUARDS-F)>

<ROUTINE GUARDS-F ()
	 <COND (<VERB? VAXUM>
		<TELL
"The guards outside your cell cheer up a bit, upsetting a larger figure who
could well be their boss. They are dismissed and replaced by other guards
who don't seem to have the air of bonhomie shared by the others." CR>)
	       (<VERB? CLEESH>
		<TELL
"A couple of the guards turn into newts, running this way and that. They
are quickly replaced, however, by others. Perhaps turning into a newt is
a commonplace around these parts." CR>)
	       (<VERB? GUNCHO>
		<TELL
"A few guards disappear, seeming to vanish with distance while still
standing in front of you. They are replaced quite quickly
and efficiently by others. To judge by the reaction to your show of magical
prowess, you would think these things happen every day." CR>)
	       (<VERB? ZIFMIA>
		<TELL
"Oh, no. You've done it now. The guards approach, and they don't look
very pleased." CR>
		<QUEUE I-TAKE-TO-ALTAR 1>)
	       (<VERB? EXAMINE>
		<TELL
"They are hunched and hairy shapes, but more detail cannot be discerned." CR>)
	       (<VERB? KILL ATTACK MUNG>
		<TELL
"You can't reach them from in here, and you wouldn't have a prayer even
if you could." CR>)
	       (<VERB? LISTEN>
		<TELL
"The guards make low, grumbling sounds that could pass for speech, but it
is incomprehensible to you." CR>)
	       (<VERB? TELL HELLO>
		<TELL
"They go right on ignoring you. They don't seem to be much on conversation,
although from time to time they grumble in an unsettling sort of way." CR>)
	       (<AND <NOT ,GUARDS-HEARD> <VERB? NITFOL>>
		<SETG GUARDS-HEARD T>
		<TELL
"The guards are having a delightful conversation, after a fashion:|
Guard 1: \"Brgh! Last night, good bloodbath!\"|
Guard 2: \"Yes. Quite. Best in weeks. Have you seen the new sacrifice?\"|
Guard 1: \"Brggh! No! Just get here.\"|
Guard 2: \"It's a scrawny one. Not too much meat.\"|
Guard 1: \"Brrrgh! No meat! Not had good meal in many days!\"|
Guard 2: \"Perhaps tonight...\"|
Voice: \"Stop your yapping, both of you!\"|
The yapping stops abruptly." CR>)
	       (<VERB? NITFOL>
		<TELL "The guards aren't speaking much." CR>)>>

<GLOBAL GUARDS-HEARD <>>

<OBJECT TOWER-N-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "north cell door")
	(SYNONYM DOOR)
	(ADJECTIVE NORTH CELL PRISON)
	(FLAGS CONTBIT DOORBIT)
	(ACTION TOWER-DOOR-F)>

<OBJECT TOWER-S-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "south cell door")
	(SYNONYM DOOR)
	(ADJECTIVE SOUTH CELL PRISON)
	(FLAGS CONTBIT DOORBIT)
	(ACTION TOWER-DOOR-F)>
	
<ROUTINE TOWER-DOOR-F ()
	 <COND (<AND <VERB? UNLOCK OPEN>
		     ,LOCKED-IN-TOWER>
		<TELL
"The door is locked from the outside.">
		<COND (<NOT ,PROTECTED-FROM-EVIL>
		       <TELL " even if you could open it, the guards
would undoubtedly return you with little difficulty">)>
		<TELL "." CR>)
	       (<VERB? KNOCK>
		<TELL
"It would only get the attention of the guards." CR>)
	       (<VERB? REZROV>
		<TELL
"The locked cell door opens with a powerful snap! Unfortunately, the
guards seem to have heard the snap and approach!" CR>
		<FSET ,PRSO ,OPENBIT>
		<SETG LOCKED-IN-TOWER <>>
		<QUEUE I-TAKE-TO-ALTAR 1>
		<RTRUE>)>>

<ROOM TOWER-S
      (IN ROOMS)
      (DESC "Cell")
      (NORTH TO TEMPLE IF TOWER-S-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (TEXT
"Hideous shapes chanting in unison can be seen through the cell window.")
      (ACTION TOWER-S-F)
      (GLOBAL TOWER-S-DOOR WINDOW)
      (PSEUDO "CELL" CELL-PSEUDO)>

<ROUTINE TOWER-S-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (,SACRIFICED?
		       <TELL
"This prison cell is similar to the one in which you were held captive
prior to your sacrifice.">)
		      (ELSE
		       <TELL 
"This is a small prison cell in the south tower of the temple.">)>
		<TELL " A window in the cell door looks out on the
temple itself." CR>
		<COND (<EQUAL? ,ANYTHING-TAKEN ,SCROLLS-TAKEN> <RTRUE>)
		      (<AND <G? ,ANYTHING-TAKEN 0> <G? ,SCROLLS-TAKEN 0>>
		       <TELL
"The guards must have brought your possessions here, but something is
definitely missing!" CR>)>
		<RTRUE>)>>

<ROUTINE CELL-PSEUDO ()
	 <COND (<AND <VERB? ESCAPE>
		     ,LOCKED-IN-TOWER>
	        <TELL
"That poses a difficult problem. There's only one way out, and that would
mean tackling a few hundred unpleasant creatures." CR>)
	       (<VERB? DROP>
		<COND (<EQUAL? ,HERE ,TOWER-S>
		       <DO-WALK ,P?NORTH>)
		      (T <DO-WALK ,P?SOUTH>)>)
	       (<VERB? OPEN>
		<COND (<EQUAL? ,HERE ,TOWER-S>
		       <PERFORM ,V?OPEN ,TOWER-S-DOOR>)
		      (T
		       <PERFORM ,V?OPEN ,TOWER-N-DOOR>)>
		<RTRUE>)
	       (<VERB? SEARCH>
		<PERFORM ,V?LOOK>
		<RTRUE>)>> 

<ROUTINE TEMPLE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,PLAYER ,TEMPLE>
		     <NOT ,PROTECTED-FROM-EVIL>
		     <NOT ,LETTER-OF-TRANSIT>>
		<CRLF>
		<TAKE-TO-TOWER>)>>

<GLOBAL LOCKED-IN-TOWER <>>

<ROUTINE TAKE-TO-TOWER ()
	 <SETG LOCKED-IN-TOWER T>
	 <SETG WINNER ,PLAYER>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <SETG ADVENTURER-CHARMED <>>
	 <QUEUE I-TURTLE 0>
	 <TELL
"A low noise begins behind you, and you turn to see hundreds of hunched
and hairy shapes. A guttural chant issues from their throats. Near you
stands a figure draped in a robe of deepest black, brandishing a vicious
dagger. The chant grows louder as the robed figure approaches the altar. As the
shapes grab you, the figure in black speaks: \"Take the victim to the tower.
I shall prepare for the sacrifice!\" The figures, whose form you can barely
guess, take you from here through the northern door and into a prison cell.
They ">
	 <COND (<SETG ANYTHING-TAKEN <BLT ,PLAYER ,TOWER-S>>
		<TELL "take your possessions from you and ">)>
	 <TELL "close the door with a crash!" CR CR>
	 <SETG SCROLLS-TAKEN 0>
	 <GOTO ,TOWER-N>
	 <COND (<IN? ,DISPEL-SCROLL ,TOWER-S>
		<REMOVE ,DISPEL-SCROLL>
		<SETG SCROLLS-TAKEN 1>)>
	 <COND (<IN? ,BANISH-SCROLL ,TOWER-S>
		<REMOVE ,BANISH-SCROLL>
		<SETG SCROLLS-TAKEN <+ ,SCROLLS-TAKEN 1>>)>
	 <ENABLE <QUEUE I-TAKE-TO-ALTAR 4>>
	 <RTRUE>>

<GLOBAL ANYTHING-TAKEN <>>

<GLOBAL SCROLLS-TAKEN <>>

<GLOBAL SACRIFICED? <>>

<ROUTINE I-TAKE-TO-ALTAR ()
	 <COND (,PROTECTED-FROM-EVIL
		<TELL
"A gang of hunched and hairy shapes appear, look around cursorily, and then
depart." CR>
		<RTRUE>)>
	 <TELL CR
"A host of hunched and hairy shapes appear through the window. The cell door
opens and you are marched solemnly to the temple and, from there, up the steps
to the altar. The large, black figure approaches menacingly. He reaches into
his cloak and pulls out a ">
	 <COND (,DAGGER-SEEN <TELL "blood-drenched scimitar">)
	       (T <TELL "great, glowing dagger">)>
	 <TELL ". He pulls you onto the altar,
and with a murmur of approval from the throng, he plunges the blade into
your heart!" CR>
	 <SETG SACRIFICED? T>
	 <COND (<NOT <==? ,DEATH-CHEATED ,ME>>
		<SETG WINNER ,PLAYER>
		<JIGS-UP <> <>>)
	       (T
		<SETG LOCKED-IN-TOWER <>>
		<TELL CR
"You feel yourself filled with a strange warmth as your eyes slowly open.
You are lying on the altar">
		<COND (<NOT ,DAGGER-SEEN>
		       <TELL ", a glowing dagger in your chest">)>
		<TELL ". You are in no
pain, however. The large figure is gone, but the throng of shapes, taking
no notice of your movement, is chanting in the temple below.">
		<COND (<NOT ,DAGGER-SEEN>
		       <TELL " You slowly remove
the dagger from your chest, but you are not harmed. The blade shines faintly
in the light of the flickering torches.">)>
		<CRLF>
		<CRLF>
		<SETG SCORE <+ ,SCORE ,TEMPLE-POINT>>
		<SETG TEMPLE-POINT 0>
		<COND (<NOT ,DAGGER-SEEN>
		       <SETG DAGGER-SEEN T>
		       <MOVE ,MAGIC-KNIFE ,WINNER>)>
		<ENABLE <QUEUE I-LETTER-OF-TRANSIT 10>>
		<SETG LETTER-OF-TRANSIT T>
		<GOTO ,ALTAR>)>> 
      
<GLOBAL DAGGER-SEEN <>>

<GLOBAL LETTER-OF-TRANSIT <>>

<ROUTINE I-LETTER-OF-TRANSIT ()
	 <COND (<EQUAL? ,HERE ,TEMPLE> <QUEUE I-LETTER-OF-TRANSIT 3>)
	       (T
		<SETG LETTER-OF-TRANSIT <>>)>
	 <RFALSE>>