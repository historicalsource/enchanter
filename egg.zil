"EGG for
		 	    ENCHANTER
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"Where, if the player messes up, he gets it all over his face."

<ROOM JEWEL-ROOM
      (IN ROOMS)
      (DESC "Jewel Room")
      (LDESC
"This fabulous room commands a magnificent view of the Lonely Mountain
which lies to the north and west. The room itself is filled with
beautiful chests and cabinets which once contained precious jewels
and other objets d'art. These are empty. Winding stone stairs
lead down to the base of the tower.")
      (DOWN TO NW-TOWER)
      (FLAGS RLANDBIT ONBIT)
      (TEXT "You can see the Lonely Mountain to the northwest.")
      (GLOBAL STAIRS MOUNTAIN WINDOW)>

<OBJECT JEWEL-CHESTS
	(IN JEWEL-ROOM)
	(DESC "collection of chests and cabinets")
	(SYNONYM CHEST CHESTS CABINET)
	(ADJECTIVE BEAUTIFUL)
	(FLAGS NDESCBIT CONTBIT)
	(ACTION JEWEL-CHESTS-F)>

<ROUTINE JEWEL-CHESTS-F ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE>
		<TELL "There's nothing inside." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL "Don't bother. There's nothing inside anyway." CR>)
	       (<VERB? PUT>
		<TELL
"A waste of time. You'd probably forget where you put it." CR>)>>

<OBJECT EGG
	(IN JEWEL-ROOM)
	(DESC "beautiful, ornamented egg")
	(FDESC
"There is an ornamented egg here, both beautiful and complex. It is
carefully crafted and bears further examination.")
	(SYNONYM EGG)
	(ADJECTIVE BEAUTIFUL JEWELLED FABERGE ORNAME)
	(FLAGS TAKEBIT CONTBIT TRANSBIT TREASURE)
	(SIZE 8)
	(CAPACITY 10)
	(ACTION EGG-F)>

<OBJECT EGG-KNOB-1
	(IN EGG)
	(DESC "lapis handle")
	(SYNONYM HANDLE)
	(ADJECTIVE LAPIS)
	(FLAGS NDESCBIT)
	(TEXT "turned")
	(ACTION EGG-KNOB-F)>

<OBJECT EGG-KNOB-2
	(IN EGG)
	(DESC "emerald knob")
	(SYNONYM KNOB)
	(ADJECTIVE EMERALD)
	(FLAGS NDESCBIT VOWELBIT)
	(TEXT "twisted")
	(ACTION EGG-KNOB-F)>

<OBJECT EGG-KNOB-3
	(IN EGG)
	(DESC "silver slide")
	(SYNONYM SLIDE)
	(ADJECTIVE SILVER)
	(FLAGS NDESCBIT)
	(TEXT "shoved")
	(ACTION EGG-KNOB-F)>

<OBJECT EGG-KNOB-4
	(IN EGG)
	(DESC "golden crank")
	(SYNONYM CRANK)
	(ADJECTIVE GOLDEN)
	(FLAGS NDESCBIT)
	(TEXT "wound")
	(ACTION EGG-KNOB-F)>

<OBJECT EGG-KNOB-5
	(IN EGG)
	(DESC "diamond-studded button")
	(SYNONYM BUTTON)
	(ADJECTIVE DIAMOND)
	(FLAGS NDESCBIT)
	(TEXT "pushed")
	(ACTION EGG-KNOB-F)>

<ROUTINE EGG-KNOB-STATE (KNOB "OPTIONAL" (VER? <>))
	 <COND (<OR .VER? <FSET? .KNOB ,OPENBIT>>
		<TELL "The " D .KNOB>
		<COND (<FSET? .KNOB ,OPENBIT>
		       <TELL " has been ">)
		      (.VER?
		       <TELL " has not yet been ">)>
		<TELL <GETP .KNOB ,P?TEXT> ". ">)>>

<ROUTINE EGG-F ()
	 <COND (<AND <VERB? LOOK-INSIDE> <NOT <FSET? ,EGG ,OPENBIT>>>
		<TELL "The egg isn't open!" CR>)
	       (<VERB? EXAMINE>
		<TELL
"This ornamented egg is both beautiful and complex. The egg itself is
mother-of-pearl, but decorated with delicate gold traceries inlaid with
jewels and other precious metals. On the surface are a lapis handle, an
emerald knob, a silver slide, a golden crank, and a diamond-studded button
carefully and unobtrusively imbedded in the decorations. These various
protuberances are likely to be connected with some machinery inside." CR>
		<EGG-KNOB-STATE ,EGG-KNOB-1>
		<EGG-KNOB-STATE ,EGG-KNOB-2>
		<EGG-KNOB-STATE ,EGG-KNOB-3>
		<EGG-KNOB-STATE ,EGG-KNOB-4>
		<EGG-KNOB-STATE ,EGG-KNOB-5>
		<TELL "The " D ,PRSO " is ">
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL "open.">)
		      (ELSE <TELL "closed.">)>
		<CRLF>
		<RTRUE>)
	       (<AND <VERB? PUT> <==? ,PRSI ,EGG>>
		<TELL
"You can't put the " D ,PRSO " inside the egg without damaging it." CR>)
	       (<AND <VERB? REZROV> <NOT <FSET? ,EGG ,OPENBIT>>>
		<FSET ,EGG ,OPENBIT>
		<SETG SCORE <+ ,SCORE ,EGG-POINT>>
		<SETG EGG-POINT 0>
		<TELL
"The egg seems to come to life and each piece slides effortlessly in the
correct pattern. The egg opens">
		<COND (<IN? ,DAMAGED-SCROLL ,EGG>
		       <FCLEAR ,DAMAGED-SCROLL ,INVISIBLE>
		       <THIS-IS-IT ,DAMAGED-SCROLL>
		       <TELL ", revealing a shredded scroll inside,
nestled among a profusion of shredders, knives, and other sharp instruments,
cunningly connected to the knobs, buttons, etc. on the outside">)>
		<TELL "." CR>)
	       (<AND <VERB? LOOK-INSIDE>
		     <FSET? ,PRSO ,OPENBIT>
		     <NOT <FIRST? ,PRSO>>>
		<TELL
"On the inside of the egg are many complex cutting devices." CR>)
	       (<AND <VERB? OPEN> <NOT <FSET? ,EGG ,OPENBIT>>>
		<TELL
"That seems to be the problem." CR>)
	       (<AND <VERB? CLOSE> <FSET? ,EGG ,OPENBIT>>
		<FCLEAR ,EGG-KNOB-1 ,OPENBIT>
		<FCLEAR ,EGG-KNOB-2 ,OPENBIT>
		<FCLEAR ,EGG-KNOB-3 ,OPENBIT>
		<FCLEAR ,EGG-KNOB-4 ,OPENBIT>
		<FCLEAR ,EGG-KNOB-5 ,OPENBIT>
		<TELL
"As you close the egg, all of the pieces slide back into place, locking
it shut." CR>
		<FCLEAR ,EGG ,OPENBIT>)
	       (<VERB? MUNG>
		<TELL
"The egg is smashed into little tiny pieces by the force of your blow.">
		<COND (<IN? ,DAMAGED-SCROLL ,EGG>
		       <FCLEAR ,DAMAGED-SCROLL ,INVISIBLE>
		       <MOVE ,DAMAGED-SCROLL ,SCRAMBLED-EGG>
		       <TELL
" Inside the now broken egg are the remains of a small spell scroll,
damaged beyond hope of learning.">)>
		<CRLF>
		<MOVE ,SCRAMBLED-EGG <LOC ,EGG>>
		<REMOVE ,EGG>)>>

<ROUTINE EGG-KNOB-F ()
	 <COND (<VERB? REZROV OPEN TURN MOVE PUSH>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It's already in the open position." CR>)
		      (ELSE
		       <FSET ,PRSO ,OPENBIT>
		       <COND (<VERB? REZROV>
			      <SETG SCORE <+ ,SCORE ,EGG-POINT>>
			      <SETG EGG-POINT 0>
			      <TELL
"The " D ,PRSO " vibrates, moving this way and that, becoming almost
plastic, and finally moves to the open position." CR>)
			     (<FSET? ,EGG ,OPENBIT>
			      <TELL
"The " D ,PRSO " moves, and a cunning and diabolically engineered set
of gears, knives, grinders, and slicers moves across the interior of the
egg." CR>
			      <COND (<IN? ,DAMAGED-SCROLL ,EGG>
				     <TELL
"The scroll resting there is now shredded beyond recognition." CR>)>
			      <RTRUE>)
			     (ELSE
			      <TELL
"The " D ,PRSO " moves to the open position, after some resistance and
a few odd noises from some machinery which resides inside the egg." CR>
			      <COND (<AND <FSET? ,EGG-KNOB-1 ,OPENBIT>
					  <FSET? ,EGG-KNOB-2 ,OPENBIT>
					  <FSET? ,EGG-KNOB-3 ,OPENBIT>
					  <FSET? ,EGG-KNOB-4 ,OPENBIT>
					  <FSET? ,EGG-KNOB-5 ,OPENBIT>>
				     <SETG SCORE <+ ,SCORE ,EGG-POINT>>
				     <SETG EGG-POINT 0>
				     <FSET ,EGG ,OPENBIT>
				     <TELL "The egg falls open">
				     <COND (<IN? ,DAMAGED-SCROLL ,EGG>
					    <FCLEAR ,DAMAGED-SCROLL ,INVISIBLE>
					    <THIS-IS-IT ,DAMAGED-SCROLL>
					    <TELL
", revealing a shredded scroll inside">)>
				     <TELL "." CR>)>
			      <RTRUE>)>)>)
	       (<VERB? TAKE>
		<TELL
"The " D ,PRSO " is an integral part of the egg and thus cannot be taken." CR>)
	       (<VERB? EXAMINE>
		<EGG-KNOB-STATE ,PRSO T>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"The " D ,PRSO " closes easily, but more noises issue from the interior." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (ELSE
		       <TELL "It's already closed." CR>)>)
	       (<VERB? MUNG>
		<PERFORM ,V?MUNG ,EGG>
		<RTRUE>)>>

<OBJECT SCRAMBLED-EGG
	(DESC "scrambled egg")
	(SYNONYM EGG)
	(ADJECTIVE BROKEN SCRAMBLED)
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(ACTION SCRAMBLED-EGG-F)
	(CAPACITY 10)>

<ROUTINE SCRAMBLED-EGG-F ("AUX" (L <LOC ,SCRAMBLED-EGG>) F)
	 <COND (<VERB? KREBF>
		<COND (<SET F <FIRST? ,SCRAMBLED-EGG>>
		       <MOVE .F ,EGG>)>
		<THIS-IS-IT ,EGG>
		<REMOVE ,SCRAMBLED-EGG>
		<MOVE ,EGG .L>
		<TELL
"The egg is returned to its former pristine beauty!" CR>)>>

<OBJECT DAMAGED-SCROLL
	(IN EGG)
	(DESC "shredded scroll")
	(SYNONYM SCROLL)
	(ADJECTIVE SHREDDED)
	(TEXT
"The scroll is damaged beyond readability. You can make out the word
\"summon,\" in the title, but that's all.")
	(ACTION DAMAGED-SCROLL-F)
	(FLAGS TAKEBIT READBIT INVISIBLE)>

<ROUTINE DAMAGED-SCROLL-F ("AUX" (L <LOC ,DAMAGED-SCROLL>))
	 <COND (<VERB? KREBF>
		<REMOVE ,DAMAGED-SCROLL>
		<MOVE ,SUMMON-SCROLL .L>
		<THIS-IS-IT ,SUMMON-SCROLL>
		<SETG SCORE <+ ,SCORE ,REPAIR-POINT>>
		<SETG REPAIR-POINT 0>
		<TELL
"The scroll reforms, its slices and cuts rejoining, until there is a
whole scroll, somewhat faded, in its place!" CR>)>>