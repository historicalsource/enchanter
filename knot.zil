"KNOT for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"Another knotty problem for our brave would-be magic user...."

<ROOM KNOT-ROOM
      (IN ROOMS)
      (DESC "Closet")
      (LDESC
"This small room must have been a closet of some sort. To the north
is a passage leading out into a courtyard. Another exit is
to the south.")
      (SOUTH TO DIM-DESCENT)
      (NORTH TO COURTYARD-1)
      (FLAGS RLANDBIT)>
      
<ROUTINE JEWELLED-BOX-A ()
	 <COND (<AND <IN? ,HERE ,JEWELLED-BOX>
		     <G? ,BOX-POINT 0>>
		<COND (,ROPE-MAGIC?
		       <TELL
"The adventurer notes the box and tries to untie the rope from around it.
His frustration is evident by the words he uses to describe the rope." CR>)
		      (T
		       <PUTP ,JEWELLED-BOX ,P?LDESC
"A jewelled box, wrapped in a partly untied tangle of rope, is
on the ground.">
		       <TELL
"The adventurer walks up to the box and becomes quickly entangled in the
partly untied rope that is knotted around it. He looks like a cat who has
been playing with a ball of yarn." CR>)>)>
	 <RTRUE>>

<OBJECT JEWELLED-BOX
	(IN KNOT-ROOM)
	(SYNONYM BOX)
	(ADJECTIVE JEWELLED)
	(DESC "jewelled box")
	(FDESC
"In the exact center of the room is a large, jewelled box. It is wrapped
in tight coils of thin rope. You try to follow the strands with your
eye, but become hopelessly lost in the jumble of thousands of loops and
knots.")
	(LDESC
"A jewelled box, wrapped tightly in rope, is on the ground.")
	(FLAGS TAKEBIT CONTBIT OPENBIT TREASURE)
	(CAPACITY 40)
	(SIZE 40)
	(ADVFCN JEWELLED-BOX-A)
	(ACTION JEWELLED-BOX-F)>

<ROUTINE JEWELLED-BOX-F ()
	 <COND (<IN? ,MAGIC-ROPE ,JEWELLED-BOX>
		<COND (<VERB? SHAKE>
		       <TELL
"It seems that there's something inside, but it's not clear what." CR>)
		      (<VERB? UNLOCK>
		       <TELL
"Who said anything about its being locked?" CR>)
		      (<VERB? REZROV>
		       <COND (,ROPE-MAGIC?
			      <TELL
"The magic in the rope is strong enough to prevent the rezrov spell from
working." CR>)
			     (T
			      <TELL
"The rope dissolves and the jewelled box flies open!" CR>
			      <ROPE-DISSOLVES>
			      <FSET ,JEWELLED-BOX ,OPENBIT>)>)
		      (<VERB? OPEN LOOK-INSIDE>
		       <TELL
"With all that rope around it, you haven't a prayer." CR>)
		      (<VERB? EXAMINE>
		       <TELL
"It is closed and wrapped in tight coils of thin rope." CR>)
		      (<VERB? CLOSE>
		       <TELL
"It isn't open, which seems to be the problem at hand." CR>)
		      (<AND <VERB? PUT> <EQUAL? ,PRSI ,JEWELLED-BOX>>
		       <TELL
"That won't work until the box is open." CR>)>)
	       (<AND <VERB? OPEN>
		     <IN? ,PROTECTION-SCROLL ,JEWELLED-BOX>>
		<THIS-IS-IT ,PROTECTION-SCROLL>
		<RFALSE>)>>

<OBJECT MAGIC-ROPE
	(IN JEWELLED-BOX)
	(SYNONYM ROPE KNOT COIL COILS)
	(ADJECTIVE TIGHT THIN STRAND)
	(DESC "tangle of rope")
	(FLAGS NDESCBIT VICBIT)
	(ACTION MAGIC-ROPE-F)>

<GLOBAL ROPE-MAGIC? T>

<ROUTINE MAGIC-ROPE-F ()
	 <COND (<VERB? UNTIE>
		<TELL
"After a few moments of reflection, you tackle the knots, one at a time.
Although you succeed with some regularity at untangling small areas of the
rope, you ">
		<COND (,ROPE-MAGIC?
		       <TELL
"find that new knots seem to be forming as you watch, taunting you
into deep despair.">)
		      (ELSE
		       <PUTP ,JEWELLED-BOX ,P?LDESC
"A jewelled box, wrapped in a partly untied tangle of rope, is
on the ground.">
		       <TELL
"can't make any headway against the enormous tangle. It would take
forever to finish.">)>
		<CRLF>)
	       (<VERB? GUNCHO>
		<REMOVE ,MAGIC-ROPE>
		<REMOVE ,JEWELLED-BOX>
		<TELL
"The " D ,PRSO " disappears, but unfortunately the " D ,JEWELLED-BOX
" disappears as well." CR>)
	       (<VERB? REZROV>
		<JEWELLED-BOX-F>
		<RTRUE>)
	       (<VERB? TAKE>
		<TELL
"The rope is so entangled around the box that the idea is ridiculous." CR>)
	       (<VERB? CUT MUNG>
		<COND (<NOT ,PRSI>
		       <TELL "You can't hurt it with your bare hands." CR>)
		      (<EQUAL? ,PRSI ,MAGIC-KNIFE>
		       <ROPE-DISSOLVES>
		       <TELL 
"At the mere touch of the magic knife, the rope gives way. Before your
eyes, the strands, now moving this way, now moving that way, untangle
themselves into a single strand which falls to the floor alongside the
box, where it dissolves into the air without a sound." CR>)
		      (<FSET? ,PRSI ,WEAPONBIT>
		          ;"only other weapon is adventurer's sword?"
		       <COND (,ROPE-MAGIC?
			      <TELL
"The rope seems to be pretty strong stuff. You don't seem to be making
the least progress in breaking it." CR>)
			     (ELSE
			      <TELL
"The rope cuts cleanly, and falls to pieces on the floor. It must have
been pretty rotten." CR>)>)
		      (T <TELL
"You certainly won't get anywhere using the " D ,PRSI "!" CR>)>)
	       (<VERB? KULCAD>
		<SETG ROPE-MAGIC? <>>
		<TELL
"Nothing obvious happens, but when you examine the rope, it lacks a
certain something you saw in it before. It now looks sort of ordinary,
like a clothesline." CR>)
	       (<VERB? DROP>
		<PERFORM ,V?DROP ,JEWELLED-BOX>
		<RTRUE>)>>

<ROUTINE ROPE-DISSOLVES ()
	 <SETG ROPE-MAGIC? <>>
	 <SETG SCORE <+ ,SCORE ,BOX-POINT>>
	 <SETG BOX-POINT 0>
	 <REMOVE ,MAGIC-ROPE>
	 <MOVE ,PROTECTION-SCROLL ,JEWELLED-BOX>
	 <FCLEAR ,JEWELLED-BOX ,OPENBIT>
	 <FSET ,JEWELLED-BOX ,TOUCHBIT>
	 <PUTP ,JEWELLED-BOX ,P?LDESC
	       "A jewelled box is sitting on the ground.">>

<OBJECT MAGIC-KNIFE
	(SYNONYM KNIFE DAGGER BLADE)
	(ADJECTIVE MAGIC SACRIFICIAL)
	(DESC "sacrificial dagger")
	(FLAGS TAKEBIT TOUCHBIT WEAPONBIT TREASURE)
	(SIZE 10)
	(ACTION MAGIC-KNIFE-F)>

<ROUTINE MAGIC-KNIFE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The dagger is inlaid with fine jewels. It would be a handsome addition
to anyone's weapon collection." CR>)>>
	 
	 