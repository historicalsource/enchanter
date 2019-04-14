"GEARS for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"The mills of the gods grind slowly, but they grind exceeding fine."

<ROOM ENGINE-ROOM
      (IN ROOMS)
      (DESC "Engine Room")
      (DOWN TO SE-TOWER)
      (SE PER CROSS-ENGINE-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (ACTION ENGINE-ROOM-F)
      (PSEUDO "HAMMER" HAMMER-F "SPEARS" HAMMER-F)
      (GLOBAL MACHINERY VOICES)>

<OBJECT MACHINERY
	(IN LOCAL-GLOBALS)
	(DESC "machinery")
	(SYNONYM MACHINE)
	(ACTION MACHINERY-F)>

<ROUTINE MACHINERY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL 
"The machinery is extremely noisy and complicated. Other than that, you
can't imagine of what use it is to anybody." CR>)
	       (<VERB? AVOID>
		<HAMMER-F>
		<RTRUE>)
	       (<VERB? EXEX>
		<TELL
"The machinery may or may not have been sped up, the facts being hard to
determine." CR>)>>

<ROUTINE ENGINE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The room is filled with noise: crashing and smashing, gurgling of water,
grinding of gears, and horrible screeching of metal. Huge devices of obscure
purpose provide these effects. The most notable is a huge hammer that smashes
continually against the stone floor: it makes any crossing of the room a
dangerous enterprise. The whole construction brings to mind the words
\"Infernal Machine.\" Far off to the southeast is another room.">
		<COND (<IN? ,DISPEL-SCROLL ,CLOSET>
		       <TELL "
You can barely make out something on the floor of that room. It might be a
scroll, but from here you can't tell for sure.">)>
		<CRLF>
		<COND (<IN? ,TURTLE ,CLOSET>
		       <TELL
"Across the room you can see the rainbow turtle, who frequently looks your
way." CR>)>
		<RTRUE>)>>

<ROUTINE HAMMER-F ()
	 <COND (<VERB? AVOID WALK-AROUND>
		<TELL
"It's hard to see how you'll avoid a painful experience." CR>)
	       (<VERB? EXEX>
		<SETG HAMMER-EXEX T>
		<TELL
"The crashing of the hammer has become more frequent." CR>)>>

<ROUTINE SE-TOWER-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? WALK>>
		<COND (<==? ,PRSO ,P?UP>
		       <ENABLE <QUEUE I-CRASH 2>>)
		      (ELSE <DISABLE <INT I-CRASH>>)>
		<RFALSE>)>>

<ROOM CLOSET
      (IN ROOMS)
      (DESC "Control Room")
      (LDESC
"This is the control room for all the machinery nearby. The controls are all
magical, of course. The walls are covered by blinking lights and shifting
displays, interspersed with arcane dials and glowing buttons. It's all very
mysterious looking. The exit, to the northwest, leads into a room with
machinery which would surely crush you if you were to attempt to enter it.")
      (NW PER RECROSS-ENGINE-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "HAMMER" HAMMER-F "SPEARS" HAMMER-F)
      (GLOBAL MACHINERY VOICES)>

<OBJECT LIGHTS
	(IN CLOSET)
	(DESC "blinking display")
	(SYNONYM LIGHT LIGHTS DISPLAY)
	(ADJECTIVE BLINKING SHIFTING)
	(FLAGS NDESCBIT)
	(ACTION LIGHTS-F)>

<ROUTINE LIGHTS-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The lights and displays hold no meaning for you. A random number generator
may be controlling the whole thing, for all you know." CR>)>>

<OBJECT SWITCHES
	(IN CLOSET)
	(DESC "glowing button")
	(SYNONYM DIAL CONTROL BUTTON DIALS)
	(ADJECTIVE ARCANE GLOWING)
	(FLAGS NDESCBIT)
	(ACTION LIGHTS-F)>

<GLOBAL FAST? <>>
<GLOBAL CRASH? <>>
<GLOBAL HAMMER-EXEX <>>

<ROUTINE I-CRASH ()
	 <COND (<NOT <EQUAL? <LOC ,PLAYER> ,ENGINE-ROOM ,CLOSET ,SE-TOWER>>
		<DISABLE <INT I-CRASH>>
		<RFALSE>)>
	 <SETG CRASH? <NOT ,CRASH?>>
	 <COND (<OR ,CRASH? ,HAMMER-EXEX>
		<TELL
"\"Crash!\" A huge hammer smashes against the stone floor">
		<COND (<IN? ,PLAYER ,CLOSET>
		       <TELL " outside">)>
		<TELL "." CR>)>
	 <ENABLE <QUEUE I-CRASH <COND (<OR ,FAST? ,HAMMER-EXEX> 1) (ELSE 2)>>>>

<ROUTINE CROSS-ENGINE-ROOM ()
	 <COND (<==? ,HASTED? ,WINNER>
		<SETG FAST? T>
		<COND (<==? ,WINNER ,TURTLE>
		       <TELL
"As the turtle starts across, he seems to set off something, for the
machinery speeds up and the noise level becomes almost unbearable. Luckily,
he makes it to the other side safely!" CR>)
		      (ELSE
		       <TELL
"You zip across the room easily, but you must have touched something
dangerous along the way, because the machinery speeds up, going faster
and faster." CR>)>
		,CLOSET)
	       (<==? ,WINNER ,TURTLE>
		<DISABLE <INT I-TURTLE>>
		<TELL
"The poor turtle starts, but he's just too slow. About halfway across the
room he is dispatched by the enormous hammer, leaving only a rainbow colored
smudge on the floor.">
		<COND (<==? ,DEATH-CHEATED ,TURTLE>
		       <SETG DEATH-CHEATED <>>
		       <TELL CR CR
"But wait! Amazingly, the smudge reforms into a turtle again! The revived
turtle just has time to turn his head in wonderment when the hammer smashes
down again, remaking the rainbow smudge.">)>
		<TELL
" Even that disappears at the next blow of the hammer." CR>
		<JIGS-UP <> <>> ;"can't survive this one"
		<RFALSE>)
	       (<OR ,FAST? ,CRASH?>
		<TELL
"You start across the room, but less than halfway across, the huge hammer
crashes down, right on top of you!" CR>
		<COND (<==? ,DEATH-CHEATED ,ME>
		       <TELL
"Startlingly, you revive from this fatal blow, but even more startlingly,
the first thing you see is the same huge hammer descending upon you!" CR>)>
		<JIGS-UP <> <>>
		<RFALSE>)
	       (ELSE
		<SETG FAST? T>
		<TELL
"You make it across the room, but just barely; just as you duck through the
door, a huge hammer crashes down behind, missing by an inch. Something
you stepped on along the way clicked as well, and with a horrible screeching
noise, the machinery speeds up, crashing faster and faster until it's
twice as fast as before." CR CR>
		,CLOSET)>>

<ROUTINE RECROSS-ENGINE-ROOM ()
	 <COND (<EQUAL? ,WINNER ,TURTLE>
		<COND (<==? ,HASTED? ,TURTLE>
		       <COND (<IN? ,DISPEL-SCROLL ,CLOSET>
			      <SETG TURTLE-REPORT? T>)>
		       <TELL
"The turtle fairly zips across the engine room, dodging the giant
hammers and gears. Suddenly he sets off a trap, and sharp spears fly
at him from all directions! But they bounce harmlessly off his shell! He
avoids one last crash of a huge hammer, but even at his speed, it's a
near thing! With one more burst of speed, he reaches "
<COND (<IN? ,PLAYER ,ENGINE-ROOM> "you")
      (T "the other side")> " safely!" CR>
		       ,ENGINE-ROOM)
		      (ELSE
		       <DISABLE <INT I-TURTLE>>
		       <TELL
"The turtle starts across the room, as hammers and gears slowly turn and
crash. Partway across the room, he sets off a trap! Spears fly at him
from all directions! They just bounce off his shell, and he is unhurt.
Unfortunately, at about this time, a enormous hammer smashes down. This
does not bounce off his shell, and the poor creature expires." CR>
		       <COND (<==? ,DEATH-CHEATED ,TURTLE>
			      <TELL
"Astoundingly, the turtle renews himself! Unfortunately, he makes it
no further, for the hammer is still too much for even his armor." CR>)>
		       <JIGS-UP <> <>>
		       <RFALSE>)>)
	       (ELSE
		<COND (<IN? ,DISPEL-SCROLL ,WINNER>
		       <REMOVE ,DISPEL-SPELL>
		       <REMOVE ,DISPEL-SCROLL>)>
		<COND (<==? ,HASTED? ,WINNER>
		       <TELL
"You rush across the engine room, your speed enabling you to avoid the
gigantic hammers and gears; at this speed they appear to move with great
deliberation. Unfortunately, you set off a trap, and many sharp spears
fly at you from all directions! They seem to move pretty fast. Too fast,
in fact. You can't dodge them, and you are severely skewered.">)
		      (ELSE
		       <TELL
"You run across the room, trying to dodge the crashing machinery, and
you are succeeding for a while until you set off a trap. A volley of sharp
spears, powered by cunning machinery, comes at you from all directions.
You are skewered! The huge hammer crashes down for the coup de grace.">)>
		<CRLF>
		<COND (<==? ,DEATH-CHEATED ,ME>
		       <TELL
"In an astounding feat of magic, you are reassembled and revived.
In an even more astounding feat of trap design, you are dispatched again
almost before you can take a breath." CR>)>
		<JIGS-UP <> <>>
		<RFALSE>)>>

<ROOM MEADOW
      (IN ROOMS)
      (DESC "Meadow")
      (LDESC
"This is a meadow near the sea. There is a smell of salt in the air. Only
heather and thistles grow here. To the north is a gate leading into the
castle. A narrow path to the southeast leads to the shore of the Sea.")
      (SE TO BEACH)
      (NORTH TO SOUTH-GATE IF RUSTY-GATE IS OPEN)
      (SOUTH "There's no path there.")
      (EAST "There's no path there.")
      (WEST "There's no path there.")
      (NE "There's no path there.")
      (NW "There's no path there.")
      (SW "There's no path there.")
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL RUSTY-GATE MEADOW-OBJ BEACH-OBJ SEA)>

<OBJECT HEATHER
	(IN MEADOW)
	(DESC "local vegetation")
	(SYNONYM HEATHER THISTLE)
	(FLAGS NDESCBIT)
	(ACTION SEA-STUFF-F)>

<ROOM BEACH
      (IN ROOMS)
      (DESC "Beach")
      (LDESC
"This is a rocky beach along a grey and lifeless sea. There is
dead seaweed covering many rocks, and listless waves barely stir
the flotsam and jetsam here. There are many shells, but all are
broken. A narrow path to the northwest leads into a meadow.")
      (NW TO MEADOW)
      (FLAGS RLANDBIT ONBIT LIGHTBIT)
      (GLOBAL MEADOW-OBJ BEACH-OBJ SEA GLOBAL-WATER)
      (PSEUDO "WAVES" WAVES-F "ROCKS" SEA-STUFF-F)>

<ROUTINE WAVES-F ()
	 <COND (<VERB? SWIM THROUGH>
		<TELL "Don't press your luck. You'd probably drown." CR>)>>

<OBJECT SEA-STUFF
	(IN BEACH)
	(DESC "flotsam")
	(SYNONYM SEAWEED FLOTSAM SHELLS JETSAM)
	(ADJECTIVE DEAD BROKEN)
	(FLAGS NDESCBIT)
	(ACTION SEA-STUFF-F)>

<ROUTINE SEA-STUFF-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "There's nothing much interesting to see." CR>)
	       (<VERB? TAKE>
		<TELL "Why bother?" CR>)>>

<OBJECT TURTLE
	(IN BEACH)
	(DESC "rainbow turtle")
	(FDESC
"Crawling slowly along the beach is an enormous turtle, his enamelled shell
shining with all the colors of the rainbow.")
	(LDESC
"An enormous turtle is here, its enamelled shell shining with all the colors of
the rainbow.")
	(SYNONYM TURTLE SHELL)
	(ADJECTIVE RAINBOW ENAMELLED)
	(FLAGS VICBIT VILLAIN CONTBIT OPENBIT)
	(CAPACITY 6)
	(ACTION TURTLE-F)>

<OBJECT GLOBAL-TURTLE
	(DESC "rainbow turtle")
	(SYNONYM TURTLE)
	(ADJECTIVE RAINBOW)
	(FLAGS VICBIT VILLAIN TAKEBIT)
	(ACTION TURTLE-F)>

<ROUTINE NO-RESPONSE ()
	 <TELL
"You hear no response." CR>>

<ROUTINE TURTLE-F ("AUX" NEAR?)
	 <SET NEAR? <IN? ,TURTLE <LOC ,PLAYER>>>
	 <COND (<EQUAL? ,WINNER ,TURTLE>
		<MOVE ,GLOBAL-TURTLE ,GLOBAL-OBJECTS>
		<COND (,TURTLE-TIRED?
		       <COND (.NEAR?
			      <TELL
"The turtle is asleep and appears oblivious to your words." CR>)
			     (ELSE
			      <NO-RESPONSE>)>
		       <RTRUE>)>
		<ENABLE <QUEUE I-TURTLE -1>>
		<FSET ,TURTLE ,TOUCHBIT>
		<COND (<NOT <EQUAL? ,TALK-TO-ANIMAL? ,TURTLE>>
		       <COND (.NEAR?
			      <TELL
"The turtle looks at you quizzically. It's clear he would like to
understand you, but he doesn't. He responds, but it's only snaps, hisses,
and clicks to you." CR>)
			     (ELSE
			      <NO-RESPONSE>)>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>
		       <RTRUE>)
		      (<VERB? WALK>
		       <SETG TURTLE-FOLLOWS <>>
		       <SETG TF-COUNT <+ ,TF-COUNT 1>>
		       <COND (<AND <IN? ,TURTLE ,INSIDE-GATE>
				   <EQUAL? ,PRSO ,P?WEST>>
			      <SETG P-CONT <>>
			      <SETG QUOTE-FLAG <>>
			      <TELL
"\"Uh, no thanks. I prefer to stay near my beach. I don't see much
yummy seaweed out that way.\"" CR>)
			     (<AND <IN? ,TURTLE ,DIM-DESCENT>
				   <EQUAL? ,PRSO ,P?DOWN ,P?SOUTH>>
			      <SETG P-CONT <>>
			      <SETG QUOTE-FLAG <>>
			      <TELL
"\"Uh, no thanks. It looks dark and scary down there, and I get a kind
of bad feeling about it, like you get when you eat old seaweed.\"" CR>)
			     (<AND <EQUAL? ,PRSO ,P?UP>
				   <GLOBAL-IN? ,STAIRS <LOC ,TURTLE>>>
			      <COND (.NEAR?
				     <TELL
"The turtle huffs and puffs up the stairs. \"Pretty steep stairs
for a turtle, friend...\"" CR>)>
			      <RFALSE>)
			     (<AND <EQUAL? ,PRSO ,P?DOWN>
				   <GLOBAL-IN? ,STAIRS <LOC ,TURTLE>>>
			      <COND (.NEAR?
				     <TELL
"\"Those stairs are pretty steep. I'll follow you down, but I'm not
going alone!\"" CR>)>
			      <SETG P-CONT <>>
			      <SETG QUOTE-FLAG <>>
			      <RTRUE>)
			     (<AND <G? ,TF-COUNT 4>
				   <0? <MOD ,TF-COUNT 6>>>
			      <TURTLE-TIRES>
			      <RFALSE>)>)
		      (<VERB? WHO>
		       <COND (.NEAR?
			      <TELL "\"Never heard of him.\"" CR>)
			     (ELSE <NO-RESPONSE>)>)
		      (<VERB? THANK>
		       <TURTLE-THANKS .NEAR?>)
		      (<AND <VERB? STAY>
			    <EQUAL? ,PRSO ,GLOBAL-ROOM <>>>
		       <SETG TURTLE-FOLLOWS <>>
		       <COND (.NEAR?
			      <TELL
"The turtle hisses, \"Okay, I'll stay here for a while.\"" CR>)
			     (ELSE
			      <NO-RESPONSE>)>)
		      (<VERB? FOLLOW>
		       <COND (<EQUAL? ,PRSO ,ME <>>
			      <SETG TURTLE-FOLLOWS T>
			      <SETG TF-COUNT 0>
			      <SETG TURTLE-TIRED-TELL <>>
			      <COND (.NEAR?
				     <TELL
"The turtle hisses, \"I will follow you.\"" CR>)
				    (ELSE <NO-RESPONSE>)>)
			     (.NEAR?
			      <TELL
"The turtle hisses, \"I'd follow you, but not that!\"" CR>)
			     (ELSE <NO-RESPONSE>)>)
		      (<AND <VERB? TAKE BRING>
			    <NOT <IN? ,TURTLE <LOC ,PLAYER>>>>
		       <COND (<VERB? BRING>
			      <SETG PRSO ,PRSI>
			      <SETG PRSI <>>)>
		       <ITAKE <>>
		       <COND (<VERB? BRING>
			      <DO-WALK <COND (<EQUAL? ,HERE ,CLOSET> ,P?NW)
					     (T ,P?SE)>>
			      <RTRUE>)>
		       <COND (<AND <EQUAL? ,HERE ,CLOSET>
				   <IN? ,PLAYER ,ENGINE-ROOM>>
			      <TELL
"The turtle sticks his head through the door across the mechanical
wasteland.">
			      <COND (<IN? ,DISPEL-SCROLL ,TURTLE>
				     <TELL
" In his mouth is a scroll of some sort.">)>
			      <CRLF>)>
		       <RTRUE>)
		      (<VERB? TAKE>
		       <COND (<NOT <FSET? ,PRSO ,SCROLLBIT>>
			      <COND (.NEAR?
				     <TELL
"\"I don't think I can carry that too easily.\"" CR>)
				    (ELSE <NO-RESPONSE>)>)
			     (T <RFALSE>)>)
		      (<AND <VERB? OPEN> <FSET? ,PRSO ,DOORBIT>>
		       <COND (.NEAR?
			      <TELL
"\"I can't reach the latch. I'm a turtle, not an ostrich.\"" CR>)
			     (ELSE <NO-RESPONSE>)>)
		      (<VERB? HELLO>
		       <COND (.NEAR?
			      <TELL "\"" <PICK-ONE ,TURTLE-REMARKS> "\"" CR>)
			     (ELSE <NO-RESPONSE>)>)
		      (<OR <IN? ,TURTLE <LOC ,PLAYER>>
			   <IN? ,TURTLE <LOC <LOC ,PLAYER>>>>
		       <TELL
"\"I'm only a turtle, you know, even if I can talk!\"" CR>)
		      (ELSE
		       <NO-RESPONSE>
		       <RTRUE>)>)
	       (<AND <VERB? TELL>
		     <EQUAL? ,PRSO ,GLOBAL-TURTLE>>
		<COND (,TURTLE-TIRED?
		       <TELL "The turtle remains asleep." CR>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>
		       <RFATAL>)
		      (<OPPOSITE-SIDES?>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>
		       <TELL
"The turtle seems to bend its head as if to listen, but with all this
noise it's not very likely that he hears you." CR>)
		      (T
		       <SETG P-MERGED T>
		       <GLOBAL-NOT-HERE-PRINT ,GLOBAL-TURTLE>
		       <RTRUE>)>)
	       (<AND <EQUAL? ,PRSO ,GLOBAL-TURTLE>
		     <VERB? WAVE-AT YELL>
		     <OPPOSITE-SIDES?>>
		<TELL "The turtle takes notice, ">
		<COND (<EQUAL? ,HERE ,CLOSET>
		       <TELL
"then glances at the rapidly pounding hammer. With a motion which
might correspond to a shrug of the shoulder, he turns away, embarrassed." CR>
		       <RTRUE>)
		      (T
		       <TELL
"nods his head, and starts in your direction." CR>)>
		<SETG WINNER ,TURTLE>
		<SETG HERE <LOC ,TURTLE>>
		<DO-WALK <COND (<EQUAL? ,HERE ,CLOSET> ,P?NW)
			       (T ,P?SE)>>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSO ,GLOBAL-TURTLE>
		     <VERB? EXAMINE>
		     <OPPOSITE-SIDES?>>
		<TELL "He is standing on the other side of the machinery." CR>)
	       (<EQUAL? ,PRSO ,GLOBAL-TURTLE>
		<GLOBAL-NOT-HERE-PRINT ,GLOBAL-TURTLE>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB-FOO THROUGH>
		<TELL
"The turtle doesn't allow you to get on his back." CR>)
	       (<VERB? RUB>
		<TELL
"The turtle seems to appreciate the attention." CR>)
	       (<VERB? CLEESH>
		<TELL
"As he is already a reptile, the spell has little effect." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL "Come now, you can't do that!" CR>)
	       (<VERB? REZROV>
		<TELL
"The turtle's shell pops off his back. Mortified, he retrieves it." CR>)
	       (<VERB? GUNCHO>
		<COND (,TURTLE-TIRED?
		       <TELL
"The sleeping turtle seems to shrink to nothing, and vanishes!" CR>)
		      (T
		       <TELL
"The turtle barely has time to retract his head before he is consumed in
flame!" CR>)>
		<REMOVE ,TURTLE>)
	       (<VERB? VAXUM>
		<COND (,TURTLE-TIRED?
		       <TELL "The snoring sounds more friendly." CR>)
		      (T
		       <TELL
"The turtle seems to make a friendly gesture, but then again turtles are
pretty friendly anyway." CR>)>)
	       (<VERB? MUNG>
		<TELL
"The turtle's shell is so thick and hard that your blow has no effect.
The lovely colors on his back are not even marred.">
		<COND (,TURTLE-TIRED?
		       <TELL " He doesn't even wake up." CR>)
		      (T
		       <TELL " He does withdraw into his
shell briefly, but then emerges again." CR>)>)
	       (,TURTLE-TIRED?
		<TELL "The turtle remains asleep." CR>
		<SETG P-CONT <>>
		<RFATAL>)
	       (<AND <VERB? THANK> <EQUAL? ,TALK-TO-ANIMAL? ,TURTLE>>
		<TURTLE-THANKS T>)
	       (<AND <VERB? TAKE> <EQUAL? ,TURTLE ,PRSO>>
		<TELL
"The turtle is much too large to take." CR>)
	       (<VERB? GIVE>
		<TELL
"The turtle extends his head towards the " D ,PRSO ", but decides it's
not very interesting, and withdraws." CR>)
	       (<VERB? HELLO>
		<TELL "\"" <PICK-ONE ,TURTLE-REMARKS> "\"" CR>)>>

<ROUTINE TURTLE-THANKS (NEAR?)
	 <COND (<==? ,TURTLE-POINT 0>
		<MOVE ,TURTLE ,BEACH>
		<COND (.NEAR?
		       <TELL
"\"Glad to be of help. I think I'll get back to the beach, now.\"
The turtle departs." CR>)
		      (ELSE
		       <TELL
"There is no response." CR>)>)
	       (.NEAR?
		<TELL
"\"You're very welcome! It's nice to have someone to talk to for
a change.\"" CR>)
	       (ELSE <NO-RESPONSE>)>
	 <RTRUE>>

<ROUTINE OPPOSITE-SIDES? ()
	 <COND (<AND <EQUAL? ,HERE ,ENGINE-ROOM ,CLOSET>
		     <EQUAL? <LOC ,TURTLE> ,ENGINE-ROOM ,CLOSET>
		     <NOT <EQUAL? ,HERE <LOC ,TURTLE>>>>
		<RTRUE>)>>

<GLOBAL TURTLE-FOLLOWS <>>
<GLOBAL TF-COUNT 0>

<GLOBAL TURTLE-REMARKS
        <LTABLE 0
"Are you a magician? Are you going to do something about that annoying
Warlock, then?"
"How do you like my shell? A wizard did that to me about 75 years ago."
"It's nice to find a human who talks turtle. Not many do, you know. Most
people think turtles are boring, just because we talk slowly.">>

<GLOBAL TURTLE-REPORT? <>>

<ROUTINE I-TURTLE ("AUX" (LP <LOC ,PLAYER>))
	 <FSET ,TURTLE ,TOUCHBIT>
	 <COND (<AND ,TURTLE-FOLLOWS <NOT <IN? ,TURTLE .LP>>>
		<SETG TF-COUNT <+ ,TF-COUNT 1>>
		<COND (<EQUAL? .LP ,WEST-CASTLE ,DUNGEON ,BED>
		       <SETG TURTLE-FOLLOWS <>>
		       <TELL
"The turtle won't follow any further." CR>)
		      (<OR <AND <EQUAL? .LP ,CLOSET>
				<IN? ,TURTLE ,ENGINE-ROOM>>
			   <AND <EQUAL? .LP ,ENGINE-ROOM>
				<IN? ,TURTLE ,CLOSET>>>
		       <SETG TURTLE-FOLLOWS <>>
		       <TELL
"The turtle seems hesitant to follow you across the room. He looks at
you as if he wants an explicit order." CR>)
		      (ELSE
		       <MOVE ,TURTLE .LP>
		       <COND (<EQUAL? .LP ,ENDLESS-STAIR>
			      <TELL
"You notice that the turtle is no longer following you. In fact, he seems
to have vanished entirely." CR>
			      <REMOVE ,TURTLE>
			      <QUEUE I-TURTLE 0>
			      <SETG TURTLE-FOLLOWS <>>
			      <RTRUE>)
			     (<EQUAL? .LP ,ENGINE-ROOM>
			      <TELL
"\"Pretty steep stairs for a turtle, friend. But if you say so...\"" CR>)
			     (<EQUAL? ,HASTED? ,TURTLE>
			      <TELL
"The turtle, moving with terrific speed, follows you." CR>)
			     (<G? ,TF-COUNT 4>
			      <TURTLE-TIRES>)
			     (T
			      <TELL
"The turtle, at his own leisurely pace, follows you." CR>)>)>)
	       (<AND ,TURTLE-REPORT?
		     <IN? ,PLAYER <LOC ,TURTLE>>>
		<SETG TURTLE-REPORT? <>>
		<TELL
"The returned turtle reports that the door across the way opens into a room
with much magic in it: bright lights and other things he doesn't understand
too well. He says there is an object of rolled paper lying on the floor as
well." CR>)
	       (<AND <IN? ,DISPEL-SCROLL ,TURTLE>
		     <IN? ,TURTLE .LP>
		     <NOT <EQUAL? ,HERE ,CLOSET>>>
		<MOVE ,DISPEL-SCROLL .LP>
		<THIS-IS-IT ,DISPEL-SCROLL>
		<SETG SCORE <+ ,SCORE ,TURTLE-POINT>>
		<SETG TURTLE-POINT 0>
		<TELL
"The turtle drops a brittle scroll at your feet. \"Not bad, huh?\"" CR>)>>

<GLOBAL TURTLE-TIRED? <>>

<ROUTINE TURTLE-TIRES ()
	 <COND (<NOT ,TURTLE-FOLLOWS> <RFALSE>)>
	 <COND (<G? ,TF-COUNT 20>
		<SETG TURTLE-TIRED? T>
		<SETG TURTLE-FOLLOWS <>>
		<DISABLE <INT I-TURTLE>>
		<TELL
"The turtle has closed his shell, and fallen asleep. A quiet snoring
sound issues from somewhere within." CR>)
	       (<NOT ,TURTLE-TIRED-TELL>
		<SETG TURTLE-TIRED-TELL T>
		<TELL
"\"How long do you expect me to follow you around, anyway? I'm getting
kind of tired, too. You would if you had a shell as heavy as mine. It's
all right for now, though.\"" CR>)
	       (T
		<TELL
"The turtle, at his own leisurely pace, follows you." CR>)>>

<GLOBAL TURTLE-TIRED-TELL <>>
