"GALLERY for
		 	    ENCHANTER
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<ROOM GALLERY
      (IN ROOMS)
      (DESC "Gallery")
      (WEST TO DIM-DESCENT)
      (EAST TO SOUTH-GATE)
      (FLAGS RLANDBIT ONBIT)
      (ADVFCN GALLERY-A)
      (ACTION GALLERY-F)>

<GLOBAL PORTRAIT-COMMENT <>>

<ROUTINE GALLERY-A ()
	 <COND (<AND <IN? ,ADVENTURER ,HERE>
		     <NOT ,PORTRAIT-COMMENT>
		     <NOT <FSET? ,FLATHEAD-PORTRAIT ,INVISIBLE>>
		     ,ADVENTURER-CHARMED>
		<SETG PORTRAIT-COMMENT T>
		<TELL
"The adventurer stops and stares at the portraits. \"I've met him!\" he
gasps, pointing at the Wizard of Frobozz. He doesn't appear eager to
meet him again, though. \"And there's old Flathead! What a sight!\" He
glances at the other portraits briefly and then re-checks his map." CR>)>>

<ROUTINE GALLERY-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <LIT? ,HERE <>>>>
		<COND (<AND ,SUPER-BRIEF
			    <NOT <ZERO? ,GALLERY-POINT>>>
		       <DESCRIBE-PORTRAIT-GALLERY>)>
		<FCLEAR ,HERE ,TOUCHBIT>)
	       (<EQUAL? .RARG ,M-LOOK>
		<COND (<LIT? ,HERE <>>
		       <COND (<NOT <ZERO? ,GALLERY-POINT>>
			      <REMOVE ,LIGHTED-PORTRAIT>)>
		       <SETG VISITED-GALLERY? T>
		       <TELL
"The east-west corridor opens into a gallery. The walls are lined with
portraits, some of apparently great value. All of the eyes seem to follow
you as you pass, and the entire room is subtly disturbing." CR>
		       <COND (<IN? ,PORTRAIT-NICHE ,GALLERY>
			      <TELL
"A small niche can be seen in the wall behind the spot where a painting
had been hanging." CR>)>)
		      (<NOT <DESCRIBE-PORTRAIT-GALLERY>>
		       <TELL "It is pitch black." CR>)>)>>

<ROUTINE DESCRIBE-PORTRAIT-GALLERY ()
	 <COND (<AND <IN? ,ETERNAL-FLAME ,PORTRAIT-NICHE>
		     <FSET? ,ETERNAL-FLAME ,ONBIT>>
		<COND (<NOT <ZERO? ,GALLERY-POINT>>
		       <MOVE ,LIGHTED-PORTRAIT ,HERE>)>
		<COND (,VISITED-GALLERY?
		       <TELL
"An eerie orange glow casts a pale, flickering light on the portrait
gallery.">)
		      (T
		       <SETG VISITED-GALLERY? T>
		       <TELL
"The east-west corridor opens into a portrait gallery. The gallery is lit
by an eerie orange glow.">)>
		<TELL
" The eyes of the figures portrayed on the canvases seem to be faintly
illuminated and follow your every movement. After a moment, the source of
light becomes clear: a single lighted portrait flickers as if a flame were
burning behind it." CR>)>>

<GLOBAL VISITED-GALLERY? <>>

<OBJECT PORTRAITS
	(IN GALLERY)
	(DESC "portraits of unknown persons")
	(SYNONYM PORTRAIT PERSON CANVAS PAINTING)
	(ADJECTIVE UNKNOWN)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION PORTRAITS-F)>

<ROUTINE PORTRAITS-F ()
	 <COND (<VERB? TAKE MOVE>
		<TELL
"The portraits are large and extremely heavy; they can be neither taken
nor moved." CR>)
	       (<VERB? LOOK-BEHIND LOOK-UNDER>
		<TELL
"There are hundreds of canvases here; you look behind one or two at random
but find nothing of interest." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The portraits represent a wide cross-section of races. Elves, gnomes, dwarves,
wizards, warlocks, and just plain folk are all here. Some of them are known
to you, such as Lord Dimwit Flathead of the Great Underground Empire, depicted
here in excessive detail, and the Wizard of Frobozz, shown in a typical pose
of anguished bewilderment." CR>
		<FCLEAR ,FLATHEAD-PORTRAIT ,INVISIBLE>
		<FCLEAR ,FROBOZZ-PORTRAIT ,INVISIBLE>
		<RTRUE>)>>

<OBJECT FLATHEAD-PORTRAIT
	(IN GALLERY)
	(SYNONYM PORTRAIT)
	(ADJECTIVE FLATHEAD DIMWIT)
	(DESC "Flathead portrait")
	(FLAGS NDESCBIT INVISIBLE VILLAIN)
	(ACTION FLATHEAD-PORTRAIT-F)>

<ROUTINE FLATHEAD-PORTRAIT-F ()
	 <COND (<VERB? ZIFMIA>
		<TELL
"Poor Flathead, the years have not been kind to him. Just as well, probably."
CR>)
	       (<VERB? EXAMINE>
		<TELL
"This rather dull man stumbled into royalty in the Great Underground Empire,
and much to everyone's chagrin. Named by his people Lord Dimwit Flathead the
Excessive, he was best known for his outrageousness in style, policy, and
engineering. His portrait captures him in the classic pose of imbecility,
astride his gaudy throne." CR>)>>

<OBJECT FROBOZZ-PORTRAIT
	(IN GALLERY)
	(SYNONYM PORTRAIT)
	(ADJECTIVE WIZARD FROBOZZ)
	(DESC "Frobozz portrait")
	(FLAGS NDESCBIT INVISIBLE VILLAIN)
	(ACTION FROBOZZ-PORTRAIT-F)>

<ROUTINE FROBOZZ-PORTRAIT-F ()
	 <COND (<VERB? ZIFMIA>
		<TELL
"The Wizard doesn't seem to respond to the summons. Perhaps he is too busy
molesting adventurers in ZORK II." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The Wizard of Frobozz was a former member of the Circle of Enchanters, but
he was removed for forgetfulness bordering on senility. The lively wit of his
youth having been replaced by a semisadistic mischievousness coupled with
an inability to pronounce words beginning with other than the letter \"F\",
he was \"retired\" to a small, unoccupied corner of the Great Underground
Empire, hopefully out of harm's way." CR>)>>

<OBJECT LIGHTED-PORTRAIT
	(DESC "lighted portrait")
	(SYNONYM PORTRAIT CANVAS PAINTING)
	(ADJECTIVE LIGHTED ILLUMINATED LIT)
	(FLAGS NDESCBIT TAKEBIT)
	(SIZE 60)
	(ACTION LIGHTED-PORTRAIT-F)>

<ROUTINE LIGHTED-PORTRAIT-F ()
	 <COND (<AND <VERB? LOOK-BEHIND> <NOT <FSET? ,PRSO ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE ,GALLERY-POINT>>
		<SETG GALLERY-POINT 0>
		<MOVE ,PORTRAIT-NICHE ,HERE>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL
"Behind the portrait is a small niche. You find that the portrait is much
lighter than the others and place it on the ground.">
		<FCLEAR ,HERE ,ONBIT> ;"Added to make room dark hereafter."
		<COND (<FIRST? ,PORTRAIT-NICHE>
		       <TELL " Sitting in the niche is ">
		       <PRINT-CONTENTS ,PORTRAIT-NICHE>
		       <TELL ".">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<COND (<NOT <FSET? ,PRSO ,TOUCHBIT>>
		       <TELL
"The portrait, of an obscure adventurer, is not notable except for the
fact that it is lighted from behind by a flickering orange light." CR>)
		      (T
		       <TELL
"The portrait, of some obscure personage carrying a brass lantern and
an elvish sword of great antiquity, is mediocre at best." CR>)>)
	       (<AND <VERB? MOVE TAKE>
		     <NOT <FSET? ,PRSO ,TOUCHBIT>>>
		<FCLEAR ,PRSO ,NDESCBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<SETG SCORE <+ ,SCORE ,GALLERY-POINT>>
		<SETG GALLERY-POINT 0>
		<MOVE ,PORTRAIT-NICHE ,HERE>
		<TELL
"The portrait is quite light. You remove it from the wall and place it on
the ground, revealing a small niche in the wall">
		<COND (<FIRST? ,PORTRAIT-NICHE>
		       <TELL ", in which sits
">
		       <PRINT-CONTENTS ,PORTRAIT-NICHE>)>
		<TELL "." CR>)>>

<OBJECT PORTRAIT-NICHE
	(DESC "niche")
	(SYNONYM NICHE)
	(ADJECTIVE SMALL)
	(CAPACITY 30)
	(FLAGS CONTBIT OPENBIT NDESCBIT SEARCHBIT)
	(ACTION PORTRAIT-NICHE-F)>

<ROUTINE PORTRAIT-NICHE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "You can't do that." CR>)>>

<OBJECT ETERNAL-FLAME
	(IN PORTRAIT-NICHE)
	(DESC "black candle")
	(SYNONYM CANDLE FLAME)
	(ADJECTIVE BLACK)
	(FLAGS TAKEBIT LIGHTBIT ONBIT)
	(ACTION ETERNAL-FLAME-F)>

<ROUTINE ETERNAL-FLAME-F ()
	 <COND (<VERB? GONDAR KULCAD>
		<TELL
"The flame flickers for a moment, then goes out." CR>
		<FCLEAR ,ETERNAL-FLAME ,ONBIT>
		<FCLEAR ,ETERNAL-FLAME ,LIGHTBIT>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON>
		     <NOT <FSET? ,ETERNAL-FLAME ,ONBIT>>>
		<TELL "You can't relight the candles." CR>)
	       (<VERB? LAMP-OFF>
		<TELL
"The flame cannot be extinguished, no matter how hard you try." CR>)>>
