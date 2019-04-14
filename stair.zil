"STAIR for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<ROOM LANDING
      (IN ROOMS)
      (DESC "Landing")
      (LDESC
"The wall is cylindrical here, with exits east and west. The eastern one
opens into a dark, enclosed space. The air is thick with acrid smoke, and
black, greasy ashes mar the floor. The mortar and stones of the walls
are stained and crumbly.")
      (EAST PER LANDING-EXIT-F)
      (WEST TO JUNCTION)
      (FLAGS ONBIT RLANDBIT RMUNGBIT)
      (PSEUDO "ASHES" ASHES-PSEUDO)>

<GLOBAL STAIR-SOLVED? <>>

<ROUTINE LANDING-EXIT-F ()
	 <COND (,STAIR-SOLVED?
		<TELL
"There is no floor there, and the pit beneath you is of great, if not
infinite, depth. You fall forever.">
		<FINISH>)
	       (ELSE ,ENDLESS-STAIR)>>

<ROOM ENDLESS-STAIR
      (IN ROOMS)
      (DESC "Winding Stair")
      (UP PER ENDLESS-UP)
      (DOWN PER ENDLESS-DOWN)
      (WEST PER ENDLESS-EXIT-F)
      (ACTION ENDLESS-STAIR-F)
      (ADVFCN ADVENTURER-DROPS-OUT)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROUTINE ADVENTURER-DROPS-OUT ()
	 <TELL
"The adventurer seems to have dropped out of existence. In a voice that seems
to recede into the void, you hear his final word: \"Restore....\" You muse
about how a mere adventurer might come to possess a spell of such power." CR>
	 <REMOVE ,ADVENTURER>
	 <QUEUE I-ADVENTURER 0>
	 <RTRUE>>  

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(SYNONYM STAIRS STEPS STAIR STAIRWAY)
	(ADJECTIVE SPIRAL WINDING)
	(DESC "stairs")
	(FLAGS NDESCBIT CLIMBBIT TOUCHBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<EQUAL? ,HERE ,JUNCTION>
		<TELL
"The stairs are to the east. You'll have to go there to get a look." CR>)
	       (<AND <EQUAL? ,HERE ,ENDLESS-STAIR>
		     <VERB? KULCAD>>
		<STAIR-DISPEL>)>>

<GLOBAL DROPPED-SOME? <>>

<ROUTINE STAIR-DISPEL ()
	 <QUEUE I-HUNGER 0>
	 <QUEUE I-THIRST 0>
	 <QUEUE I-TIRED 0>
	 <QUEUE I-TURTLE 0>
	 ;"Stop hunger and thirst. The loser has enough on his mind now..."
	 <SETG STAIR-SOLVED? T>
	 <SETG SCORE <+ ,SCORE ,STAIR-POINT>>
	 <SETG STAIR-POINT 0>
	 <SETG DROPPED-SOME? <DESTROY-ALL ,WINNER ,REAL-STAIR>>
	 <MOVE ,FLY-SCROLL ,WINNER>
	 <TELL
"The stairway begins to dissolve before your eyes, leaving a circular area
with exits east and west, but remarkable mainly for its absence of a floor.
Indeed, you find yourself standing in midair above a deep pit with the
sort of comical look which is found mainly among duped cartoon characters.
Frantically, you grab for the solid bannister">
	 <COND (,DROPPED-SOME? <TELL ", dropping your heavier possessions
in your desire to save yourself">)>
	 <TELL "! But the bannister shifts and dissolves
as well, leaving you grasping what appears to be an ornate scroll." CR>
	 <THIS-IS-IT ,FLY-SCROLL>
	 <ENABLE <QUEUE I-FALL-FOREVER 5>>
	 <ENABLE <QUEUE I-FALL -1>>
	 <DISABLE <INT I-TIRED>>
	 <GOTO ,REAL-STAIR <>>
	 <RTRUE>>

<ROUTINE ENDLESS-UP ()
	 <ENDLESS-UP-DOWN T>
	 ,ENDLESS-STAIR>

<ROUTINE ENDLESS-DOWN ()
	 <ENDLESS-UP-DOWN <>>
	 ,ENDLESS-STAIR>

<ROUTINE ENDLESS-UP-DOWN (UP?)
	 <FCLEAR ,ENDLESS-STAIR ,TOUCHBIT>
	 <STAIR-TO-TABLE ,STAIR-LOC>
	 <TELL "You ">
	 <COND (.UP?
		<TELL "climb">
		<SETG STAIR-LOC <+ ,STAIR-LOC 1>>)
	       (T
		<TELL "descend">
		<SETG STAIR-LOC <- ,STAIR-LOC 1>>)>
	 <TELL " the stairs, making one circuit of the tower." CR>
	 <TABLE-TO-STAIR ,STAIR-LOC>>

<ROUTINE ENDLESS-STAIR-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is a winding stair, stretching up and down out of sight. The walls are
mossy and damp.">
		<COND (<==? ,STAIR-LOC ,STAIR-START>
		       <TELL " An exit leads west to a landing.">)>
		<CRLF>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <EQUAL? ,WINNER ,PLAYER>>
		     <NOT <IN? ,WINNER <LOC ,PLAYER>>>>
		<REMOVE ,WINNER>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<RFALSE>)>>

<ROUTINE ENDLESS-EXIT-F ()
	 <COND (<==? ,STAIR-LOC ,STAIR-START> ,LANDING)
	       (T
		<TELL "You can't go that way." CR>
		<RFALSE>)>>

<ROUTINE STAIR-TO-TABLE (SLOC
			 "AUX" TBL (CNT 0)
			  (F <FIRST? ,ENDLESS-STAIR>) N)
	 <SET TBL ,STAIR-TABLE>
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

<ROUTINE TABLE-TO-STAIR (SLOC
			 "AUX" TBL (CNT 0))
	 <SET TBL ,STAIR-TABLE>
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,STAIR-TABLE-LENGTH>>
			<RETURN>)
		       (<==? <GET .TBL .CNT> .SLOC>
			<PUT .TBL .CNT 0>
			<MOVE <GET .TBL <+ .CNT 1>> ,ENDLESS-STAIR>)>
		 <SET CNT <+ .CNT 2>>>>

<GLOBAL STAIR-LOC 10000>
<CONSTANT STAIR-START 10000>

<CONSTANT STAIR-TABLE-LENGTH 70> ;"currently 33 takeable objects"

<GLOBAL STAIR-TABLE ;"length should be 2*number of takeable objects"
	<TABLE 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

\

<ROOM REAL-STAIR
      (IN ROOMS)
      (DESC "Winding Stair")
      (LDESC
"This is a circular room with no floor. There are exits east and west.
A crude drawing of stairsteps graces the ceiling. Downward is only
darkness.")
      (WEST PER REAL-STAIR-EXIT-F) ;"LANDING"
      (EAST PER REAL-STAIR-EXIT-F) ;"WARLOCK-TOWER"
      (DOWN PER REAL-STAIR-EXIT-F) ;"PIT"
      (FLAGS RLANDBIT)
      (ACTION PIT-F)
      (GLOBAL STAIRS)>

<ROUTINE REAL-STAIR-EXIT-F ()
	 <SETG FALL-COUNT 0>
	 <COND (,FLYING?
		<TELL "Effortlessly, you float ">
		<COND (<==? ,PRSO ,P?DOWN>
		       <SETG FALL-COUNT 1>
		       <TELL "downward." CR>
		       <DESTROY-ALL ,HERE ,PIT>
		       ,PIT)
		      (<==? ,PRSO ,P?EAST>
		       <SETG SCORE <+ ,SCORE ,FLY-POINT>>
		       <SETG FLY-POINT 0>
		       <STOP-FLYING>
		       <TELL "eastward and settle to the ground." CR>
		       ,WARLOCK-TOWER)
		      (<==? ,PRSO ,P?WEST>
		       <STOP-FLYING>
		       <TELL "westward and settle to the ground." CR>
		       ,LANDING)>)
	       (ELSE ;"I'm not sure this can happen"
		<TELL
"You must think you can fly." CR>
		<RFALSE>)>>

<ROOM PIT
      (IN ROOMS)
      (DESC "Bottomless Pit")
      (LDESC
"This is a circular pit of apparently infinite depth. The walls are of
crudely dressed stone. No floor is visible.")
      (UP PER PIT-EXIT-F)
      (DOWN PER PIT-EXIT-F)
      (ACTION PIT-F)
      (FLAGS RLANDBIT ONBIT)>

<ROUTINE PIT-EXIT-F ()
	 <COND (,FLYING?
		<TELL "Effortlessly, you float ">
		<COND (<==? ,PRSO ,P?DOWN>
		       <SETG FALL-COUNT <+ ,FALL-COUNT 1>>
		       <TELL "downward." CR>)
		      (T
		       <SETG FALL-COUNT <- ,FALL-COUNT 1>>
		       <TELL "upward." CR>)>
		<COND (<==? ,FALL-COUNT 0>
		       <DESTROY-ALL ,HERE ,REAL-STAIR>
		       ,REAL-STAIR)
		      (ELSE
		       <DESTROY-ALL ,HERE ,PIT>
		       <FCLEAR ,PIT ,TOUCHBIT>
		       ,PIT)>)
	       (ELSE
		<TELL
"You must think you can fly." CR>
		<RFALSE>)>>

<ROUTINE PIT-F ("OPTIONAL" RARG)
	 <COND (<==? .RARG ,M-BEG>
		<COND (<AND <VERB? DROP> <HELD? ,PRSO>>
		       <FSET ,PRSO ,NDESCBIT>
		       <FCLEAR ,PRSO ,TAKEBIT>
		       <TELL
"The " D ,PRSO " falls out of sight below you." CR>)
		      (<AND <VERB? TAKE EXAMINE> <NOT <HELD? ,PRSO>>>
		       <TELL
"The " D ,PRSO " is out of reach below you." CR>)>)>>

<GLOBAL FALL-COUNT 0>

<ROUTINE STOP-FLYING ()
	 <SETG FLYING? <>>
	 <QUEUE I-FALL 0>
	 <QUEUE I-FALL-FOREVER 0>
	 <QUEUE I-FLY 0>
	 <RTRUE>>

<ROUTINE I-FALL ()
	 <COND (,FLYING? <RTRUE>)>
	 <SETG FALL-COUNT <+ ,FALL-COUNT 1>>
	 <TELL
"You plummet downward, deeper into the pit, but the bottom is still not
visible.">
	 <COND (,DROPPED-SOME?
		<TELL " Far ahead of you fall your former possessions." CR>)>
	 <RTRUE>>

<ROUTINE I-FALL-FOREVER ()
	 <TELL
"You plummet deeper and deeper into the pit! Oddly enough, you never
seem to hit bottom. After many years, only tattered remnants of you
remain, still falling." CR>
	 <FINISH>>

<ROUTINE DESTROY-ALL (WHO WHERE "AUX" N X (DEST? <>))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .DEST?>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <NOT <EQUAL? .X ,WINNER>>
			     <G? <GETP .X ,P?SIZE> 4>>
			<REMOVE-ALL .X>
			<MOVE .X .WHERE>
			<FSET .X ,NDESCBIT>
			<FCLEAR .X ,TAKEBIT>
			<SET DEST? T>)>
		 <SET X .N>>>

<ROUTINE REMOVE-ALL (WHAT "AUX" N X)
	 <SET X <FIRST? .WHAT>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN>)>
		 <SET N <NEXT? .X>>
		 <REMOVE .X>
		 <SET X .N>>>

\

<ROOM WARLOCK-TOWER
      (IN ROOMS)
      (DESC "Warlock's Tower")
      (LDESC
"This is a room carved out of black basalt, eerily lit by flickering
fires and the dim glow of magic.")
      (DOWN "The pit yawns before you, and the izyuk spell has worn off!")
      (WEST "The pit yawns before you, and the izyuk spell has worn off!")
      (FLAGS RLANDBIT ONBIT)
      (ACTION WARLOCK-TOWER-F)>

<ROUTINE WARLOCK-TOWER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FSET ,WARLOCK-TOWER ,TOUCHBIT>
		<TELL
"As you enter, you realize that this is Krill's secret chamber,
protected by powerful illusions now broken by your skills. Before you
stands Krill, engaged in the casting of some complex and horrific magic.
Krill turns to face you, surprised and annoyed by your intrusion. You
have seen him before: cloaked in black, he sacrificed you at the Altar
before his hoard. His yellow eyes glisten and he breathes deeply. In a
voice as deep as the great caverns of the earth, he speaks: \"Fool!
Parlor magician! You dare to defile my chamber with your worm-like
presence. I shall not waste words with you. Goodbye, spell-monger!\"">
		<COND (<EQUAL? ,HASTED? ,PLAYER>
		       <TELL "
He pauses. \"Ah! You seem to be in a hurry, campfire-conjurer! Slow down
and enjoy the show!\" He waves his hand, and you are robbed of your energy.">)>
		<TELL "
Krill snaps his fingers loudly, and a giant dragon appears, breathing gouts
of flame. He moves ever closer, red eyes bulging with malice!" CR CR>
		<MOVE ,DRAGON ,HERE>
		<ENABLE <QUEUE I-DRAGON 2>>)>>

<OBJECT KRILL
	(IN WARLOCK-TOWER)
	(DESC "warlock Krill")
	(LDESC
"The warlock Krill, robed in black, stands before you, in eager anticipation
of your death.")
	(SYNONYM KRILL WARLOCK)
	(FLAGS VICBIT)
	(ACTION KRILL-F)>

<OBJECT GLOBAL-KRILL
	(IN GLOBAL-OBJECTS)
	(DESC "warlock Krill")
	(SYNONYM KRILL WARLOCK)
	(ACTION GLOBAL-KRILL-F)>

<ROUTINE GLOBAL-KRILL-F ()
	 <COND (<VERB? GUNCHO HELLO GIVE>
		<TELL
"Krill is not here, and lucky for you." CR>)
	       (<VERB? ZIFMIA>
		<JIGS-UP
"The warlock Krill appears before you, staring in astonishment. \"Who is
it that disturbs my slumber? Oh, it is only you, secondary-school sorcerer!\"
He points a finger and chants a spell. You are cast into the endless void!"
<>>)
	       (<VERB? EXAMINE WHO>
		<TELL
"Krill is an evil warlock who was banished from the Circle of Enchanters.
His malice was thought to be forever ended, his reign of terror a dim and
frightful memory. But he has returned, and his power must be destroyed lest
the Circle's great works be overthrown." CR>)
	       (T
		<GLOBAL-NOT-HERE-PRINT ,GLOBAL-KRILL>
		<RTRUE>)>> 

<OBJECT DRAGON
	(DESC "dragon")
	(SYNONYM DRAGON FLAME FLAMES)
	(LDESC
"A dragon, spouting flame, approaches!")
	(FLAGS VICTIM)
	(ACTION DRAGON-F)>

<ROUTINE DRAGON-F ()
	 <COND (<VERB? GONDAR>
		<TELL
"The dragon's flame is doused in a torrent of water as you cast the
gondar spell! He disappears with a torturous scream.">
		<REMOVE ,DRAGON>
		<SECOND-ACT>)
	       (<VERB? VAXUM NITFOL>
		<TELL
"The dragon pauses and roars out a benevolent greeting, which, to your
chagrin, fries you to a delicate crisp." CR>
		<FINISH>)
	       (<VERB? GUNCHO>
		<TELL
"Unfortunately, the dragon is practically on top of you, and before you
can finish saying the guncho spell he blasts you to beyond well-done." CR>
		<FINISH>)
	       (<VERB? CLEESH>
		<TELL
"The dragon, being reptilian himself, is unaffected." CR>)
	       (<VERB? KILL ATTACK MUNG>
		<TELL
"Your strength isn't nearly enough to best the dragon!" CR>)>>      

<ROUTINE SECOND-ACT ("OPTIONAL" (GUNCH <>))
	 <TELL CR
"Krill ">
	 <COND (.GUNCH <TELL "seems shaken, but regains his composure.">)
	       (T <TELL "seems to be somewhat amused.">)>
	 <TELL CR CR
"\"A fine spell, wizard-worm, but your luck has ended!\" With another snap
of his fingers, he summons a being whose essence is evil. It has a shape which
is masked by its blackness and exudes a foul, fetid odor. In its hand
is a large battle axe. At a signal from Krill, it advances!" CR>
	 <ENABLE <QUEUE I-SHAPE 2>>
	 <MOVE ,SHAPE ,HERE>>

<GLOBAL NO-LONGER-PROTECTED
"Krill looks your way and spits: \"You were fortunate, wizard-worm, to have
survived our last encounter. But your trivial spells of protection will not
save you now!\"">

<ROUTINE I-DRAGON ()
	 <COND (<IN? ,DRAGON ,HERE>
		<COND (<OR <==? ,DEATH-CHEATED ,ME>
			   ,PROTECTED-FROM-EVIL>
		       <TELL ,NO-LONGER-PROTECTED CR>)>
		<TELL
"The dragon engulfs you in flame. As you perish, you can hear Krill's
mocking laughter." CR>
		<FINISH>)>
	 <QUEUE I-DRAGON 0>
	 <RTRUE>>    
   
<OBJECT SHAPE
	(DESC "monster")
	(SYNONYM MONSTER SHAPE BEING)
	(ACTION SHAPE-F)>

<ROUTINE SHAPE-F ()
	 <COND (<VERB? VAXUM>
		<TELL
"The monster hesitates, stops, smiles, and disappears." CR>
		<THIRD-ACT>)
	       (<VERB? CLEESH>
		<TELL
"The monster hesitates, trembles, then turns into a newt. Poor monster. Its
battle axe, now unsupported, falls on it, slicing it neatly in half." CR>
		<THIRD-ACT>)
	       (<VERB? NITFOL>
		<TELL
"\"Yum, yum!\" are the last words you hear." CR>
		<FINISH>)
	       (<VERB? GUNCHO>
		<TELL
"The monster pauses for a moment as you begin the guncho spell, then swiftly
cleaves you with its axe before you can finish!" CR>
		<FINISH>)
	       (<VERB? KILL ATTACK MUNG>
		<TELL
"Your effort is useless. It is still coming closer!" CR>)>>

<ROUTINE THIRD-ACT ()
	 <REMOVE ,SHAPE>
	 <TELL CR
"Krill seems to be losing patience.|
|
\"I am through playing games, carnival-clown! You shall return to your
Circle, but I am afraid that all the little pieces will prove hard to
reassemble!\" He laughs hideously and starts a guttural chant which
shakes the very tower." CR>
	 <SETG KRILL-KILL T>
	 <ENABLE <QUEUE I-BYE 2>>
	 <RTRUE>>

<GLOBAL KRILL-KILL <>>

<ROUTINE I-SHAPE ()
	 <COND (<IN? ,SHAPE ,HERE>
		<COND (<OR <==? ,DEATH-CHEATED ,ME>
			   ,PROTECTED-FROM-EVIL>
		       <TELL ,NO-LONGER-PROTECTED CR>)>
		<TELL
"The monster hits you with its battle axe! You fall, dead, as the
laughter of Krill reaches a crescendo!" CR>
		<FINISH>)>
	 <QUEUE I-SHAPE 0>
	 <RTRUE>>

<ROUTINE I-BYE ()
	 <COND (<EQUAL? ,HERE ,WARLOCK-TOWER>
		<TELL CR
"Krill finishes his spell and his harsh laughter is all that remains!
You are in a void, without sight, sound, or sensation. You scream at the
top of your lungs, but nothing happens. You break into a cold sweat as you
ponder the infinite, beyond all help and hope!" CR>
		<FINISH>)>>

<ROUTINE KRILL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Krill is not a pretty sight! Enough said." CR>)
	       (<AND <VERB? GUNCHO> ,KRILL-KILL>
		<TELL
"Krill recoils as he hears the first words of the guncho spell. For a few
seconds he continues with the spell he was casting, trying to finish before
you. He fumbles some syllables! Then he steps
back and, with his hands outstretched toward you, lets out a bloodcurdling
scream. His face twisted, and his body vibrating with the effort of resisting
the enchantment, he utters a spell
of power, and is gone! After a quiet moment, a rumble begins deep in the
earth. It strengthens as the tower starts to sway. The floor gives way
beneath you and you tumble down towards the sea ... then you are surrounded
by a burst of light.|
|
You realize that you are with the Circle. The Eldest of the Circle, Belboz,
rises and speaks: \"The evil of Krill is ended this day. From beyond hope,
you have proved yourself great and worthy. Our hearts are gladdened at your
return.\" A chair appears at his right hand and he motions for you to
sit beside him. He smiles warmly. \"Join with us,\" he says, \"and tell us
of your quest!\"|
|
Here ends the first chapter of the Enchanter saga, in which, by virtue of your
skills, you have joined the Circle of Enchanters. Further adventures await you
as the Enchanter series continues." CR CR>
		<SETG SCORE <+ ,SCORE ,WARLOCK-POINT>>
		<USL>
		<FINISH>)
	       (<VERB? CLEESH>
		<TELL
"Krill shimmers for a moment, then laughs heartily. The laugh sounds
vaguely like a croak, but perhaps it is only your imagination." CR>)
	       (<VERB? VAXUM>
		<TELL
"The spell seems to have no influence over Krill. You wouldn't much
like to see him smile, anyway." CR>)    
	       (<VERB? GUNCHO>
		<TELL
"The look of surprise on Krill's face as you recite the first few
syllables of the guncho spell is exceeded only by your look of disappointment
as you are "
		  <COND (<IN? ,SHAPE ,HERE> "sliced into bits by the monster!")
			(T "incinerated by the dragon!")>
		  CR>
		<FINISH>)
	       (<VERB? HELLO>
		<TELL "Krill grins and the sight is ghastly." CR>)>>

<ROUTINE I-MUNG-ROOM ("OPTIONAL" (TELL? T) "AUX" RM TBL)
	 <ENABLE <QUEUE I-MUNG-ROOM 20>>
	 <SET TBL ,MUNG-ROOM-TABLE>
	 <REPEAT ()
		 <COND (<SET RM <GET .TBL 0>>
			<COND (<NOT <FSET? .RM ,RMUNGBIT>>
			       <RETURN>)>
			<SET TBL <REST .TBL 2>>)
		       (T <RETURN>)>>
	 <COND (.RM
		<FSET .RM ,RMUNGBIT>
		<FCLEAR .RM ,TOUCHBIT>
		<COND (<AND .TELL? <==? .RM ,HERE>>
		       <TELL
"Suddenly, you sense a great wind of evil magic blowing around you. You
are weighed down by its power, and only your sorcerous training permits
you to withstand it. When you regain your composure, your surroundings
have changed." CR>)>)>
	 .RM>

