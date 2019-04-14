"MAGIC for
			      ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"
"---Summary of magic spells---

  --Word--	--English--
  BLORB		STRONG-BOX-SPELL
  CLEESH	NEWT-SPELL
  EXEX		HASTE-SPELL
  FILFRE	CREDITS-SPELL
  FROTZ		LIGHT-SPELL
  GNUSTO	WRITE-MAGIC-SPELL
  GONDAR	QUENCH-SPELL
  GUNCHO	BANISH-SPELL
  IZYUK		FLY-SPELL
  KREBF		REPAIR-SPELL
  KULCAD	DISPEL-SPELL
  MELBOR	PROTECTION-SPELL
  NITFOL	TALK-TO-ANIMALS-SPELL
  OZMOO		CHEAT-DEATH-SPELL
  REZROV	OPEN-SPELL
  VAXUM		CHARM-SPELL
  ZIFMIA	SUMMON-SPELL
"

<OBJECT SPELL-BOOK
	(IN PLAYER)
	(SYNONYM BOOK)
	(ADJECTIVE SPELL)
	(DESC "spell book")
	(ACTION SPELL-BOOK-F)
	(FLAGS TOUCHBIT TAKEBIT READBIT CONTBIT OPENBIT)>

<OBJECT WRITE-MAGIC-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELL)
	(ADJECTIVE GNUSTO)
	(DESC "gnusto spell")
	(TEXT "write a magic spell into a spell book")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT LIGHT-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELL)
	(ADJECTIVE FROTZ)
	(DESC "frotz spell")
	(TEXT "cause something to give off light")
	(COUNT 1)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT CHEAT-DEATH-SCROLL
	(IN PORTRAIT-NICHE)
	(SYNONYM SCROLL)
	(ADJECTIVE BLACK)
	(DESC "black scroll")
	;(FDESC
"Nestled in the niche is a small black scroll.")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT CHEAT-DEATH-SPELL
	(IN CHEAT-DEATH-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE OZMOO)
	(DESC "ozmoo spell")
	(TEXT "survive unnatural death")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT VOWELBIT)>

<OBJECT SUMMON-SCROLL
	(SYNONYM SCROLL)
	(ADJECTIVE FADED WHOLE)
	(DESC "faded scroll")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT SUMMON-SPELL
	(IN SUMMON-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE ZIFMIA)
	(DESC "zifmia spell")
	(TEXT "magically summon a being")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT CHARM-SCROLL
	(IN BEDPOST)
	(SYNONYM SCROLL)
	(ADJECTIVE GOLD LEAF)
	(DESC "gold leaf scroll")
	(LDESC "A scroll ornamented in gold leaf is here.")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT CHARM-SPELL
	(IN CHARM-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE VAXUM)
	(DESC "vaxum spell")
	(TEXT "make a hostile creature your friend")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT OPEN-SCROLL
	(SYNONYM SCROLL)
	(ADJECTIVE SCRIBBLED)
	(DESC "scribbled scroll")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT OPEN-SPELL
	(IN OPEN-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE REZROV)
	(DESC "rezrov spell")
	(TEXT "open even locked or enchanted objects")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT QUENCH-SCROLL
	(IN RAT-HOLE)
	(SYNONYM SCROLL)
	(ADJECTIVE FRAYED)
	(DESC "frayed scroll")
	(FLAGS INVISIBLE READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT QUENCH-SPELL
	(IN QUENCH-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE GONDAR)
	(DESC "gondar spell")
	(TEXT "quench an open flame")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT TALK-TO-ANIMALS-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELL)
	(ADJECTIVE NITFOL)
	(DESC "nitfol spell")
	(TEXT "converse with the beasts in their own tongue")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT HASTE-SCROLL
	(IN SECRET-PASSAGE)
	(SYNONYM SCROLL)
	(ADJECTIVE STAINED)
	(FDESC
"Lying on the ground, and slightly damaged, is a stained scroll.")
	(DESC "stained scroll")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT HASTE-SPELL
	(IN HASTE-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE EXEX)
	(DESC "exex spell")
	(TEXT "make things move with greater speed")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT VOWELBIT)>

<OBJECT DISPEL-SCROLL
	(IN CLOSET)
	(SYNONYM SCROLL PAPER PARCHMENT)
	(ADJECTIVE OLD BRITTLE ROLLED)
	(DESC "brittle scroll")
	(LDESC "A scroll of old, brittle parchment is here.")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT DISPEL-SPELL
	(IN DISPEL-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE KULCAD)
	(DESC "kulcad spell")
	(TEXT "dispel a magic spell")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT PROTECTION-SCROLL
	(SYNONYM SCROLL)
	(ADJECTIVE VELLUM)
	(DESC "vellum scroll")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT PROTECTION-SPELL
	(IN PROTECTION-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE MELBOR)
	(DESC "melbor spell")
	(TEXT "protect magic users from harm by evil beings")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT STRONG-BOX-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELL)
	(ADJECTIVE BLORB)
	(DESC "blorb spell")
	(TEXT "safely protect a small object as though in a strong box")
	(COUNT 1)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT BANISH-SCROLL
	(IN T-I)
	(SYNONYM SCROLL)
	(ADJECTIVE POWERFUL)
	(DESC "powerful scroll")
	(LDESC "A scroll emanating power is here.")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>

<OBJECT BANISH-SPELL
	(IN BANISH-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE GUNCHO)
	(DESC "guncho spell")
	(TEXT "banish the victim to another plane of existence")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT REPAIR-SCROLL
	(IN FOREST-1)
	(SYNONYM SCROLL)
	(ADJECTIVE CRUMPLED)
	(DESC "slightly crumpled scroll")
	(FDESC
"Discarded beneath a nearby tree is a slightly crumpled scroll.")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT REPAIR-SPELL
	(IN REPAIR-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE KREBF)
	(DESC "krebf spell")
	(TEXT "repair willful damage")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT NEWT-SCROLL
	(IN LILY-PAD)
	(SYNONYM SCROLL)
	(ADJECTIVE DAMP SOGGY)
	(DESC "damp scroll")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT INVISIBLE)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT NEWT-SPELL
	(IN NEWT-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE CLEESH)
	(DESC "cleesh spell")
	(TEXT "change a creature into a small amphibian")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<OBJECT FLY-SCROLL
	(SYNONYM SCROLL)
	(ADJECTIVE ORNATE)
	(DESC "ornate scroll")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT VOWELBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT FLY-SPELL
	(IN FLY-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE IZYUK)
	(DESC "izyuk spell")
	(TEXT "fly like a bird")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT VOWELBIT)>

<OBJECT CREDITS-SCROLL
	(IN MAP-ROOM)
	(FDESC "Lying on the floor is a purple scroll.")
	(SYNONYM SCROLL)
	(ADJECTIVE PURPLE)
	(DESC "purple scroll")
	(FLAGS READBIT SCROLLBIT BURNBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT CREDITS-SPELL
	(IN CREDITS-SCROLL)
	(SYNONYM SPELL)
	(ADJECTIVE FILFRE)
	(DESC "filfre spell")
	(TEXT "create gratuitous fireworks")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT READBIT SPELLBIT)>

<GLOBAL ALL-SPELLS
	<LTABLE WRITE-MAGIC-SPELL
		LIGHT-SPELL
		CHEAT-DEATH-SPELL
		SUMMON-SPELL
		CHARM-SPELL
		OPEN-SPELL
		TALK-TO-ANIMALS-SPELL
		HASTE-SPELL
		DISPEL-SPELL
		PROTECTION-SPELL
		STRONG-BOX-SPELL
		BANISH-SPELL
		REPAIR-SPELL
		NEWT-SPELL
		FLY-SPELL
		QUENCH-SPELL
		CREDITS-SPELL>>

<ROUTINE V-SPELLS ("AUX" (CNT <GET ,ALL-SPELLS 0>) S (ANY <>) (OS <>) TMP)
	 <TELL
"The gnusto spell, the only thing you seem to have learned well after many
years at the University, remains yours forever. Other than that, you have
">
	 <REPEAT ()
		 <COND (<==? .CNT 0>
			<COND (.OS
			       <SPELL-PRINT .OS .ANY T>
			       <SET ANY T>)>
			<COND (<NOT .ANY> <TELL "no spells memorized.">)
			      (T <TELL " committed to memory.">)>
			<CRLF>
			<RTRUE>)>
		 <COND (<SET TMP <SPELL-TIMES <GET ,ALL-SPELLS .CNT>>>
			<COND (.OS
			       <SPELL-PRINT .OS .ANY>
			       <SET ANY T>)>
			<SET OS .TMP>)>
		 <SET CNT <- .CNT 1>>>>

<ROUTINE SPELL-TIMES (S)
	 <COND (<G? <GETP .S ,P?COUNT> 0>
		<COND (<IN? .S ,SPELL-BOOK> .S)
		      (<AND <==? .S ,DISPEL-SPELL>
			    <NOT <IN? ,DISPEL-SPELL ,DISPEL-SCROLL>>>
		       .S)
		      (<AND <==? .S ,BANISH-SPELL>
			    <NOT <IN? ,BANISH-SPELL ,BANISH-SCROLL>>>
		       .S)>)>>

<ROUTINE SPELL-PRINT (S ANY "OPTIONAL" (PAND? <>) "AUX" CNT)
	 <COND (.ANY
		<COND (.PAND? <TELL " and ">)
		      (ELSE <TELL ", ">)>)>
	 <TELL "the " D .S>
	 <COND (<G? <SET CNT <GETP .S ,P?COUNT>> 5>
		<TELL " many times">)
	       (T
		<TELL " " <GET ,COUNTERS <- .CNT 1>>>)>
	 .S>

<GLOBAL COUNTERS <TABLE "once" "twice" "thrice" "four times" "five times">>

\

<ROUTINE SPELL-BOOK-F ("AUX" (F <FIRST? ,SPELL-BOOK>))
	 <COND (<VERB? EXAMINE>
		<TELL

"The title is \"My Spell Book\". The book looks pretty new, and it
doesn't seem to have much written in it yet. There are some spells
written in the book in glowing letters, with marginal notes about how to
cast them and what their effects are." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"Thanks to its magic properties, the spell book is always open to the
right place at the right time, but it is also always closed. This
innovation eliminates tedious page turning
and hunting for spells in tight situations. Many wizardly lives have
been saved by this small advance in magical technology." CR>)
	       (<VERB? READ>
		<COND (<NOT ,LIT>
		       <TELL
"Though it is dark, the magic writing of your spells casts enough light
that you can read them." CR>)>
		<TELL "|
My Spell Book|
|
">
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)>
			<TELL "The " D .F " (" <GETP .F ,P?TEXT> ")." CR>
			<SET F <NEXT? .F>>>)>>

<ROUTINE SPELL-CHECK (TBL WRD "AUX" (OBJ <>))
	 <COND (<EQUAL? .WRD ,W?GNUSTO>
		<SET OBJ ,WRITE-MAGIC-SPELL>)
	       (<EQUAL? .WRD ,W?FROTZ>
		<SET OBJ ,LIGHT-SPELL>)
	       (<EQUAL? .WRD ,W?OZMOO>
		<SET OBJ ,CHEAT-DEATH-SPELL>)
	       (<EQUAL? .WRD ,W?ZIFMIA>
		<SET OBJ ,SUMMON-SPELL>)
	       (<EQUAL? .WRD ,W?VAXUM>
		<SET OBJ ,CHARM-SPELL>)
	       (<EQUAL? .WRD ,W?REZROV>
		<SET OBJ ,OPEN-SPELL>)
	       (<EQUAL? .WRD ,W?NITFOL>
		<SET OBJ ,TALK-TO-ANIMALS-SPELL>)
	       (<EQUAL? .WRD ,W?EXEX>
		<SET OBJ ,HASTE-SPELL>)
	       (<EQUAL? .WRD ,W?KULCAD>
		<SET OBJ ,DISPEL-SPELL>)
	       (<EQUAL? .WRD ,W?MELBOR>
		<SET OBJ ,PROTECTION-SPELL>)
	       (<EQUAL? .WRD ,W?BLORB>
		<SET OBJ ,STRONG-BOX-SPELL>)
	       (<EQUAL? .WRD ,W?GUNCHO>
		<SET OBJ ,BANISH-SPELL>)
	       (<EQUAL? .WRD ,W?KREBF>
		<SET OBJ ,REPAIR-SPELL>)
	       (<EQUAL? .WRD ,W?CLEESH>
		<SET OBJ ,NEWT-SPELL>)
	       (<EQUAL? .WRD ,W?IZYUK>
		<SET OBJ ,FLY-SPELL>)
	       (<EQUAL? .WRD ,W?GONDAR>
		<SET OBJ ,QUENCH-SPELL>)
	       (<EQUAL? .WRD ,W?FILFRE>
		<SET OBJ ,CREDITS-SPELL>)>
	 <COND (.OBJ
		<OBJ-FOUND .OBJ .TBL>)>
	 <RTRUE>>

<ROUTINE PRE-QUICK-CAST ("AUX" MEM? SPELL SCROLL)
	 <SET SPELL
	      <COND (<VERB? GNUSTO> ,WRITE-MAGIC-SPELL)
		    (<VERB? FROTZ> ,LIGHT-SPELL)
		    (<VERB? OZMOO> ,CHEAT-DEATH-SPELL)
		    (<VERB? ZIFMIA> ,SUMMON-SPELL)
		    (<VERB? VAXUM> ,CHARM-SPELL)
		    (<VERB? REZROV> ,OPEN-SPELL)
		    (<VERB? NITFOL> ,TALK-TO-ANIMALS-SPELL)
		    (<VERB? EXEX> ,HASTE-SPELL)
		    (<VERB? KULCAD> ,DISPEL-SPELL)
		    (<VERB? MELBOR> ,PROTECTION-SPELL)
		    (<VERB? BLORB> ,STRONG-BOX-SPELL)
		    (<VERB? GUNCHO> ,BANISH-SPELL)
		    (<VERB? GONDAR> ,QUENCH-SPELL)
		    (<VERB? KREBF> ,REPAIR-SPELL)
		    (<VERB? CLEESH> ,NEWT-SPELL)
		    (<VERB? IZYUK> ,FLY-SPELL)
		    (<VERB? FILFRE> ,CREDITS-SPELL)
		    (ELSE <TELL "**OOOPS!**" CR> <RTRUE>)>>
	 <COND (<FSET? .SPELL ,RMUNGBIT>
		<TELL
"The spell is defaced beyond recognition." CR>
		<RTRUE>)>
	 <SET SCROLL <LOC .SPELL>>
	 <COND (<AND .SCROLL <FSET? .SCROLL ,SCROLLBIT>>
		<COND (<IN? .SCROLL ,WINNER>
		       <REMOVE .SCROLL>
		       <COND (<NOT <EQUAL? ,PRSO ,KRILL>>
			      <TELL
"As you cast the spell, the " D .SCROLL " vanishes!" CR>)>
		       <PUTP .SPELL ,P?COUNT 1>)
		      (<OR <FSET? .SPELL ,TOUCHBIT>
			   <IN? .SCROLL ,HERE>>
		       <TELL
"You don't have the " D .SPELL " memorized, nor do you have the scroll
on which it is written." CR>
		       <RTRUE>)
		      (T
		       <TELL
"The " D .SPELL " is not committed to memory, and you haven't seen any scroll
on which it is written." CR>
		       <RTRUE>)>)>
	 <SET MEM? <GETP .SPELL ,P?COUNT>>
	 <COND (<EQUAL? .SPELL ,WRITE-MAGIC-SPELL>
		<RFALSE> ;"Always memorized")
	       (<NOT <G? .MEM? 0>>
		<TELL
"You don't have the " D .SPELL " committed to memory!" CR>
		<RTRUE>)
	       (ELSE
		<PUTP .SPELL ,P?COUNT <- .MEM? 1>>
		<SETG SPELL-ROOM <+ ,SPELL-ROOM 1>>
		<COND (<VERB? KULCAD GUNCHO>
		       <ENABLE <QUEUE MORE-PROBE 1>>)>
		<RFALSE>)>>

<ROUTINE SCROLL-F ("AUX" SPELL)
	 <COND (<VERB? TAKE>
		<SET SPELL <FIRST? ,PRSO>>
		<FSET .SPELL ,TOUCHBIT>
		<RFALSE>)
	       (<AND <VERB? CUT> <==? ,PRSI ,MAGIC-KNIFE>>
		<REMOVE ,PRSO>
		<TELL
"The magic dagger reduces the scroll to shreds. The shreds shrivel up into
tiny spitballs. The spitballs evaporate." CR>)
	       (<AND <VERB? BURN> <==? ,PRSI ,ETERNAL-FLAME>>
		<REMOVE ,PRSO>
		<TELL
"The " D ,PRSO " burns cheerily. Interestingly, the flame is sort of
purple and rather bright. Not even ashes remain." CR>)
	       (<VERB? EXAMINE READ>
		<COND (<SET SPELL <FIRST? ,PRSO>>
		       <COND (<FSET? .SPELL ,RMUNGBIT>
			      <TELL
"The scroll is defaced. The spell on it cannot be read." CR>
			      <RTRUE>)>
		       <TELL
"The scroll reads \"" D .SPELL ": " <GETP .SPELL ,P?TEXT> "\".">
		       <COND (<EQUAL? .SPELL ,BANISH-SPELL ,DISPEL-SPELL>
			      <TELL
" The spell seems very long and extremely complicated.">)>
		       <CRLF>)
		      (ELSE
		       <TELL
"Nothing useful can be made out on the scroll." CR>)>)>>
 
<ROUTINE SPELL-F ("AUX" MEM? (FORGET <>))
	 <COND (<VERB? READ>
		<COND (<AND <NOT <IN? ,PRSO ,SPELL-BOOK>>
			    <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		       <TELL
"You can't do that without having the spell in your book or on
a scroll in your hand." CR>)>)
	       (<VERB? MEMORIZE LEARN>
		<COND (<NOT <IN? ,PRSO ,SPELL-BOOK>>
		       <COND (<IN? <LOC ,PRSO> ,WINNER>
			      <TELL
"You haven't written that spell into your book yet. Until you do, you
can't memorize the spell." CR>)
			     (T
			      <V-LEARN>)>)
		      (<NOT <IN? ,SPELL-BOOK ,WINNER>>
		       <TELL
"You don't have your spell book. How do you expect to memorize a spell
without a spell book?" CR>)
		      (<EQUAL? ,PRSO ,WRITE-MAGIC-SPELL>
		       <TELL
"You already know that spell by heart." CR>)
		      (<NOT ,LIT>
		       <TELL
"It will be hard to learn that spell in the dark." CR>)
		      (T
		       <SET MEM? <GETP ,PRSO ,P?COUNT>>
		       <COND (<0? ,SPELL-ROOM>
			      <COND (<EQUAL? ,SPELL-MAX 1>
				     <TELL
"You can't concentrate well enough to learn the spell." CR>
				     <RTRUE>)
				    (<EQUAL? .MEM? ,SPELL-MAX> T)
				    (T
				     <FORGET-SPELL ,PRSO>
				     <SET MEM? <+ .MEM? 1>>
				     <PUTP ,PRSO ,P?COUNT .MEM?>
				     <SET FORGET T>)>)
			     (T
			      <SETG SPELL-ROOM <- ,SPELL-ROOM 1>>
			      <SET MEM? <+ .MEM? 1>>
			      <PUTP ,PRSO ,P?COUNT .MEM?>)>
		       <TELL
"Using your best study habits, you learn the " D ,PRSO>
		       <COND (<G? .MEM? 1>
			      <TELL " yet another time">)>
		       <TELL "." CR>
		       <COND (.FORGET
			      <TELL
"You have so much buzzing around in your head, though, that it's
likely that something may have been forgotten in the shuffle." CR>)>
		       <RTRUE>)>)
	       (<VERB? TAKE DROP>
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE FORGET-SPELL (SPL "AUX" NSPL F CNT TBL (NUM 0) (SP <>))
	 <SET F <FIRST? ,SPELL-BOOK>>
	 <SET TBL ,FORGET-TBL>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (<G? <SET CNT <GETP .F ,P?COUNT>> 0>
			<REPEAT ()
				<SET SP .F>
				<PUT .TBL 1 .F>
				<SET NUM <+ .NUM 1>>
				<SET TBL <REST .TBL 2>>
				<COND (<L? <SET CNT <- .CNT 1>> 1>
				       <RETURN>)>>)>
		 <SET F <NEXT? .F>>>
	 <COND (<AND <G? .NUM 0>
		     <EQUAL? <GETP .SP ,P?COUNT> .NUM>>
		<PUTP .SP ,P?COUNT <- .NUM 1>>
		<RTRUE>)>
	 <PUT ,FORGET-TBL 0 .NUM>
	 <COND (<0? .NUM> <RTRUE>)>
	 <REPEAT ()
		 <COND (<NOT <EQUAL? <SET NSPL
					  <RANDOM-ELEMENT ,FORGET-TBL>>
				     .SPL>>
			<PUTP .NSPL ,P?COUNT <- <GETP .NSPL ,P?COUNT> 1>>
			;<TELL "[" D .NSPL " forgotten]" CR>
			<RTRUE>)>>>

<GLOBAL FORGET-TBL <LTABLE 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE FORGET-ALL ("AUX" F)
	 <SETG SPELL-ROOM ,SPELL-MAX>
	 <SET F <FIRST? ,SPELL-BOOK>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (ELSE
			<PUTP .F ,P?COUNT 0>
			<SET F <NEXT? .F>>)>>>

<GLOBAL REAL-SPELL-MAX 4>
<GLOBAL SPELL-MAX 4>  ;"max spells memorizable"
<GLOBAL SPELL-ROOM 1> ;"number can memorize now (starts at 1 because loser
		        memorized three already)"

<ROUTINE V-CAST ("AUX" VRB)
	 <COND (<NOT <FSET? ,PRSO ,SPELLBIT>>
		<TELL
"You might as well be casting with a fly rod, as to try to cast " A ,PRSO "." CR>)
	       (ELSE
		<SET VRB
		     <COND (<==? ,PRSO ,WRITE-MAGIC-SPELL> ,V?GNUSTO)
			   (<==? ,PRSO ,LIGHT-SPELL> ,V?FROTZ)
			   (<==? ,PRSO ,CHEAT-DEATH-SPELL> ,V?OZMOO)
			   (<==? ,PRSO ,SUMMON-SPELL> ,V?ZIFMIA)
			   (<==? ,PRSO ,CHARM-SPELL> ,V?VAXUM)
			   (<==? ,PRSO ,OPEN-SPELL> ,V?REZROV)
			   (<==? ,PRSO ,TALK-TO-ANIMALS-SPELL> ,V?NITFOL)
			   (<==? ,PRSO ,HASTE-SPELL> ,V?EXEX)
			   (<==? ,PRSO ,DISPEL-SPELL> ,V?KULCAD)
			   (<==? ,PRSO ,PROTECTION-SPELL> ,V?MELBOR)
			   (<==? ,PRSO ,STRONG-BOX-SPELL> ,V?BLORB)
			   (<==? ,PRSO ,BANISH-SPELL> ,V?GUNCHO)
			   (<==? ,PRSO ,QUENCH-SPELL> ,V?GONDAR)
			   (<==? ,PRSO ,REPAIR-SPELL> ,V?KREBF)
			   (<==? ,PRSO ,NEWT-SPELL> ,V?CLEESH)
			   (<==? ,PRSO ,FLY-SPELL> ,V?IZYUK)
			   (<==? ,PRSO ,CREDITS-SPELL> ,V?FILFRE)
			   (ELSE <TELL "**OOPS**" CR> <RTRUE>)>>
		<COND (<AND <NOT ,PRSI>
			    <EQUAL? .VRB ,V?KREBF ,V?FILFRE>>
		       <PERFORM .VRB>)
		      (<NOT ,PRSI>
		       <TELL
"You might as well be casting it away as not cast it on something." CR>)
		      (T <PERFORM .VRB ,PRSI>)>
		<RTRUE>)>>

<ROUTINE V-LEARN ()
	 <TELL
"You don't have that spell, if indeed that is a spell." CR>>

<ROUTINE V-MEMORIZE () <V-LEARN>>

"SPELL VERBS"

<ROUTINE V-GNUSTO ("AUX" SCROLL) ;"write magic"
	 <COND (<NOT <IN? ,SPELL-BOOK ,WINNER>>
		<TELL
"The spell quests around in your hands, looking for your spell book, and
not finding it, fades reluctantly." CR>)
	       (<NOT <FSET? ,PRSO ,SPELLBIT>>
		<TELL
"You can't inscribe ">
		<COND (<EQUAL? ,PRSO ,ME> <TELL "yourself">)
		      (T <TELL A ,PRSO>)>
		<TELL " in your spell book!" CR>)
	       (<IN? ,PRSO ,SPELL-BOOK>
		<TELL
"You already have that spell inscribed in your book!" CR>)
	       (<FSET? ,PRSO ,RMUNGBIT>
		<TELL
"The spell is defaced beyond recognition." CR>)
	       (ELSE
		<SET SCROLL <LOC ,PRSO>>
		<COND (<AND <FSET? .SCROLL ,SCROLLBIT>
			    <HELD? .SCROLL>> 
		       <COND (<EQUAL? ,PRSO ,DISPEL-SPELL ,BANISH-SPELL
				      ,CREDITS-SPELL>
			      <TELL
"Your spell book begins to glow softly. In a spectacular effort of magic,
the powers of the gnusto spell attempt to copy the " D ,PRSO " into your
book, but the spell is too long, too complicated, and too powerful. The
glow fades, but fortunately the "
D .SCROLL " remains intact." CR>
			      <COND (<EQUAL? ,PRSO ,DISPEL-SPELL ,BANISH-SPELL>
				     <MORE-PROBE <>>)>
			      <RTRUE>)
			     (ELSE
			      <REMOVE .SCROLL>
			      <MOVE ,PRSO ,SPELL-BOOK>
			      <PUTP ,PRSO ,P?COUNT 0>
			      <TELL
"Your spell book begins to glow softly. Slowly, ornately, the words of
the " D ,PRSO " are inscribed, glowing even more brightly than
the book itself. The book's brightness fades, but the spell remains!
However, the scroll on which it was written vanishes as the last word
is copied." CR>)>
		       T)
		      (T
		       <TELL
"You must have a legible spell scroll in your hands before the gnusto spell
will work on it." CR>)>)>>

<ROUTINE MORE-PROBE ("OPTIONAL" (CAST? T))
	 <COND (<OR <EQUAL? ,HERE ,PIT ,REAL-STAIR ,ENDLESS-STAIR>
		    <EQUAL? ,HERE ,WARLOCK-TOWER>>
		<RTRUE>)
	       (<G? <SETG PROBE <+ ,PROBE 1>> 3>
		<TELL 
"The warlock Krill appears before you, clad in deepest black. \"You are a
fool, wizard-worm! You and your Circle!\" He spits in your face, causing a
wound through which a foul poison enters your body. Krill's demonic laughter
is the last sound you hear." CR>
		<FINISH>)
	       (T
		<TELL CR <GET ,PROBE-TBL ,PROBE> CR>
		<COND (<OR .CAST? 
			   <AND <EQUAL? ,PROBE 2> <NOT <IN? ,KRILL ,HERE>>>>
		       <COND (<NOT ,BELBOZ-WARNING>
			      <SETG BELBOZ-WARNING T>
			      <TELL CR 
"Belboz appears before you, hard and stern. \"While you have quested for
Krill's lair, the Circle has not been idle. We have tried to shield your
presence from him, but ">
			      <COND (.CAST?
				     <TELL
"your use of such a powerful spell might endanger us all!">)
				    (T
				     <TELL 
"your foolish attempt to copy such a powerful spell cannot be ignored!">)>
			      <TELL "
As we have sensed it, so surely must Krill! Be careful, brave Enchanter!\"
His image fades." CR>)>)>
		<SETG LOSSAGE <+ ,LOSSAGE 1>>
		<RTRUE>)>>

<GLOBAL BELBOZ-WARNING <>>

<GLOBAL LOSSAGE 0>

<GLOBAL PROBE 0>

<GLOBAL PROBE-TBL <LTABLE
"A dull aching fills your head, and your mind is again probed, more deeply
than when you entered the castle."
"Your head is filled with a heavy sensation, as though an enormous weight
were being borne by it. Your mind is again probed, this time very deeply,
testing and learning. The feeling passes after a long moment."
"A knife seems to split your head apart. A deep, black presence seems to enter
and probe, deep and sure. After what seems like an eternity, it passes, leaving
you with a throbbing headache.">>

<ROUTINE V-FROTZ ("AUX" OLIT) ;"light"
	 <SET OLIT ,LIT>
	 <COND (<AND <NOT <IN? ,PRSO ,LOCAL-GLOBALS>>
		     <OR <FSET? ,PRSO ,TAKEBIT>
			 <FSET? ,PRSO ,VICBIT>>>
		<FSET ,PRSO ,LIGHTBIT>
		<FSET ,PRSO ,ONBIT>
		<TELL
"There is an almost blinding flash of light as the " D ,PRSO " begins to
glow! It slowly fades to a less painful level, but the " D ,PRSO " is now
quite usable as a light source." CR>
		<SETG SCORE <+ ,SCORE ,LIGHT-POINT>>
		<SETG LIGHT-POINT 0>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT> ,LIT>
		       <CRLF>
		       <PERFORM ,V?LOOK>)>
		<RTRUE>)
	       (T
		<V-VAXUM>)>>

<GLOBAL ENTRY-POINT 20>
<GLOBAL LIGHT-POINT 20>
<GLOBAL QUENCH-POINT 25>
<GLOBAL EGG-POINT 5>
<GLOBAL REPAIR-POINT 10>
<GLOBAL GALLERY-POINT 25>
<GLOBAL TEMPLE-POINT 35>
<GLOBAL BOX-POINT 25>
<GLOBAL CHARM-POINT 20>
<GLOBAL SUMMON-POINT 10>
<GLOBAL DOOR-POINT 35>
<GLOBAL TERROR-POINT 50>
<GLOBAL TURTLE-POINT 25>
<GLOBAL EAT-POINT 10>
<GLOBAL DRINK-POINT 15>
<GLOBAL STAIR-POINT 10>
<GLOBAL FLY-POINT 10>
<GLOBAL WARLOCK-POINT 50>

<GLOBAL SCORE-MAX 400>

<ROUTINE V-OZMOO () ;"cheat-death"
	 <TELL "A huge puff of orange smoke envelops ">
	 <SETG DEATH-CHEATED ,PRSO>
	 <COND (<EQUAL? ,PRSO ,ME>
		<ENABLE <QUEUE I-DEATH-CHEATED-END 8>>
		<TELL "you, but you feel no
different." CR>)
	       (T
		<TELL "the " D ,PRSO ". Other than that,
not much happens." CR>)>>

<GLOBAL DEATH-CHEATED <>>

<ROUTINE I-DEATH-CHEATED-END ()
	 <SETG DEATH-CHEATED <>>
	 <COND (<==? ,DEATH-CHEATED ,ME>
		<TELL
"You feel a bit lightheaded for a moment, but the feeling quickly
passes." CR>)>
	 <RTRUE>>

<GLOBAL IMP-SEEN <>>

<ROUTINE V-ZIFMIA () ;"summon"
	 <COND (<OR <FSET? ,PRSO ,TAKEBIT>
		    <IN? ,PRSO ,LOCAL-GLOBALS>>
		<TELL
"The zifmia spell is for summoning beings, not things!" CR>)
	       (<AND <FSET? ,PRSO ,VICBIT> <NOT <IN? ,PRSO ,HERE>>>
		<NO-ZIF>)
	       (T
		<V-VAXUM>)>>

<ROUTINE NO-ZIF ()
	 <TELL
"If you will remember from Thaumaturgy 201, summoning of beings works only
if the being can be seen, unless the being possesses great magic of his own."
CR>>

<ROUTINE V-VAXUM () ;"charm"
	 <TELL 
"Although you complete the spell, nothing seems to have happened." CR>>

<ROUTINE V-GONDAR () <V-VAXUM>>

<ROUTINE V-REZROV () ;"open"
	 <COND (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"It's open already. Why bother?" CR>)
		      (T
		       <TELL
"The " D ,PRSO " opens. Kind of like swatting a fly with a sledge hammer,
if you ask me." CR>)>
		<FSET ,PRSO ,OPENBIT>)
	       (T <V-VAXUM>)>>

<GLOBAL TALK-TO-ANIMAL? <>>

<ROUTINE I-TALK-TO-ANIMAL ()
	 <COND (<AND <==? ,TALK-TO-ANIMAL? ,TURTLE> ,TURTLE-FOLLOWS>
		<SETG TURTLE-FOLLOWS <>>
		<COND (<IN? ,TURTLE ,HERE>
		       <TELL
"The turtle no longer seems to understand you, loses interest in you,
and stops following." CR>)>)>
	 <SETG TALK-TO-ANIMAL? <>>>

<ROUTINE V-NITFOL () ;"talk to animal"
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<SETG TALK-TO-ANIMAL? ,PRSO>
		<ENABLE <QUEUE I-TALK-TO-ANIMAL 20>>
		<COND (<==? ,PRSO ,ME>
		       <TELL
"You now understand everything you say to yourself, which is more than
I can do. You didn't study too hard in Thaumaturgy 101, did you? This
spell should be cast on the creature you wish to talk to!" CR>)
		      (ELSE
		       <COND (<EQUAL? ,PRSO ,FROG>
			      <TELL "One of the frogs">)
			     (T <TELL "The " D ,PRSO>)>
		       <TELL
" looks at you for a moment, and you look at it. \"Hello,\" it says." CR>)>)
	       (ELSE
		<TELL "This seems to have no effect on " A ,PRSO "." CR>)>>

<GLOBAL HASTED? <>>

<ROUTINE I-HASTE ()
	 <COND (<==? ,HASTED? ,ME>
		<SETG HUNGER-COUNT <+ ,HUNGER-COUNT 2>>
		<ENABLE <QUEUE I-HUNGER 3>>
		<SETG THIRST-COUNT <+ ,THIRST-COUNT 2>>
		<ENABLE <QUEUE I-THIRST 4>>
		<ENABLE <QUEUE I-TIRED 5>>
		<TELL
"The effects of the exex spell have worn off. You are ravenous, parched,
and tired." CR>)>
	 <SETG HASTED? <>>>

<ROUTINE V-EXEX () ;"haste"
	 <COND (,HASTED?
		<TELL
"Nothing seems to happen. Perhaps the spell needs time before it can be
cast again." CR>)
	       (<FSET? ,PRSO ,VILLAIN>
		<SETG HASTED? ,PRSO>
		<COND (<==? ,PRSO ,ME>
		       <SETG HASTED? ,PLAYER>
		       <COND (<EQUAL? ,HERE ,WARLOCK-TOWER>
			      <TELL
"Krill, nobody's fool, hears you start the exex spell and hastily
improvises one of his own which entirely counteracts it. The spell
acts so well, in fact, that you are frozen solid." CR>)
			     (T
			      <ENABLE <QUEUE I-HASTE 45>>
			      <TELL
"You feel energetic and zippy." CR>)>)
		      (ELSE
		       <ENABLE <QUEUE I-HASTE 15>>
		       <TELL
"The " D ,PRSO " shimmers, then vibrates in place for a few seconds, but
doesn't take any notice of the change." CR>)>)
	       (ELSE
		<V-VAXUM>)>>

<ROUTINE V-KULCAD () ;"dispel"
	 <TELL
"It appears that the " D ,PRSO " was real, since nothing happens." CR>
	 <RTRUE>>

<ROUTINE V-MELBOR () ;"protection"
	 <COND (<EQUAL? ,PRSO ,ME>
		<SETG PROTECTED-FROM-EVIL T>
		<TELL
"A wave of warmth courses through you, leaving you with a feeling of great
internal strength." CR>)
	       (T <V-VAXUM>)>>

<GLOBAL PROTECTED-FROM-EVIL <>>

<GLOBAL STRONG-BOX-FLAG <>>

<ROUTINE V-BLORB ("AUX" OBJ) ;"strong-box"
	 <COND (,STRONG-BOX-FLAG
		<V-VAXUM>
		<RTRUE>)>
	 <COND (<OR <FSET? ,PRSO ,TAKEBIT>
		    <EQUAL? ,PRSO ,ADVENTURER>>
		<COND (<EQUAL? ,PRSO ,ADVENTURER ,TURTLE>
		       <REMOVE ,PRSO>
		       <COND (<EQUAL? ,PRSO ,ADVENTURER>
			      <QUEUE I-ADVENTURER 0>)
			     (T
			      <QUEUE I-TURTLE 0>)>)
		      (T <MOVE ,PRSO ,STRONG-BOX>)>
		<SETG STRONG-BOX-FLAG T>
		<MOVE ,STRONG-BOX ,HERE>
		<TELL
"A glowing strong box forms out of the air, carefully enclosing
the " D ,PRSO ", which disappears from view. The strong box rests on
the ground." CR>)
	       (ELSE <V-VAXUM>)>>

<OBJECT STRONG-BOX
	(SYNONYM BOX SAFE)
	(ADJECTIVE STRONG)
	(DESC "strong box")
	(LDESC "There is a faintly glowing strong box here.")
	(FLAGS TAKEBIT TRYTAKEBIT CONTBIT ONBIT)
	(ACTION STRONG-BOX-F)>

<ROUTINE STRONG-BOX-F ("AUX" OBJ)
	 <COND (<VERB? TAKE>
		<TELL
"The strong box is apparently stuck to the ground, or welded there,
or tied with magical ropes. It won't move." CR>)
	       (<VERB? OPEN REZROV KULCAD>
		<SETG STRONG-BOX-FLAG <>>
		<COND (<SET OBJ <FIRST? ,STRONG-BOX>>
		       <MOVE .OBJ ,HERE>
		       <THIS-IS-IT .OBJ>)>
		<REMOVE ,STRONG-BOX>
		<TELL <COND (<VERB? OPEN> "As you open")
			    (<VERB? REZROV> "The rezrov spell bursts")
			    (<VERB? KULCAD> "The kulcad spell dispels")>
" the strong box, it vanishes, and ">
		<COND (.OBJ <TELL "the " D .OBJ " re">)
		      (T <TELL "nothing ">)>
		<TELL "appears in
its place." CR>)>>

<ROUTINE V-GUNCHO () ;"banish"
	 <COND (<FSET? ,PRSO ,VICBIT>
		<REMOVE ,PRSO>
		<TELL
"The " D ,PRSO " disappears, fading with stately speed into a misty
shadow, shimmering and wavering, which then is gone." CR>)
	       (ELSE <V-VAXUM>)>>

<ROUTINE V-KREBF ()
	 <COND (<OR <NOT ,PRSO> <==? ,PRSO ,GLOBAL-ROOM>>
		<COND (<FSET? ,HERE ,RMUNGBIT>
		       <FCLEAR ,HERE ,RMUNGBIT>
		       <FCLEAR ,HERE ,TOUCHBIT>
		       <TELL
"There is a slow brightening of the illumination, and color flows back
into your surroundings. There is a touch of spring in the air." CR>)
		      (ELSE
		       <TELL
"Nothing happens. Perhaps there was no damage here to repair." CR>)>)
	       (ELSE
		<COND (<AND <FSET? ,PRSO ,SCROLLBIT>
			    <FIRST? ,PRSO>>
		       <SETG PRSO <FIRST? ,PRSO>>)>
		<COND (<NOT <FSET? ,PRSO ,RMUNGBIT>>
		       <TELL "Nothing happens." CR>)
		      (T
		       <FCLEAR ,PRSO ,RMUNGBIT>
		       <COND (<FSET? ,PRSO ,SPELLBIT>
			      <TELL
"The " D ,PRSO " becomes readable again." CR>)
			     (T <TELL "Nothing obvious happens." CR>)>)>)>>

<ROUTINE V-CLEESH ()
	 <COND (<==? ,PRSO ,ME>
		<TELL
"You are turned into a newt, and scurry off to find your friends in the
swamp. You are distracted by various yummy insects along the way, but
eventually settle into a nice gooey part of the morass and live happily
ever after, at least until you are devoured by a heron." CR>
		<FINISH>)
	       (<EQUAL? ,PRSO ,ADVENTURER ,ADVENTURER-LG>
		<NO-MORE-ADVENTURER>
		<QUEUE I-ADVENTURER 0>
		<REMOVE ,ADVENTURER>
		<TELL
"The adventurer turns into a fairly large newt, which scuttles off and
is lost to sight." CR>)
	       (<AND <FSET? ,PRSO ,VICBIT>
		     <FSET? ,PRSO ,VILLAIN>>
		<TELL
"The " D ,PRSO " looks sort of green and slimy for a moment, but he
gets better." CR>)
	       (T
		<TELL
"Turning the " D ,PRSO " into a newt is a remarkable idea." CR>)>>

<ROUTINE V-IZYUK ()
	 <COND (<OR <NOT ,PRSO> <==? ,PRSO ,ME>>
		<SETG FLYING? T>
		<ENABLE <QUEUE I-FLY 4>>
		<QUEUE I-FALL-FOREVER 0>
		<TELL
"Your descent slows, and you are floating serenely in midair. The tower
surrounds you, with wide-cut openings to the east and west. You could
probably fly in either direction if you wished." CR>)
	       (ELSE
		<TELL
"You can't make the " D ,PRSO " fly!" CR>)>>

<GLOBAL FLYING? <>>

<ROUTINE I-FLY ()
	 <SETG FLYING? <>>
	 <COND (<EQUAL? <LOC ,WINNER> ,PIT ,REAL-STAIR>
		<TELL
"The izyuk spell has worn off! You plummet deeper and deeper into the
pit! Oddly enough, you never seem to hit bottom. After many years, only
tattered remnants of you remain, still falling." CR>
		<FINISH>)
	       (ELSE
		<TELL
"You settle gently to the ground." CR>)>>

<ROUTINE V-FILFRE ()
	 <TELL
"In a blinding burst of pyrotechnics, the air lights up with fireworks
and dazzling explosions of multicolored fire! In sizzling sparks and
roiling smoke is written:|
">
	 <FIXED-FONT-ON>
	 <TELL "|
  Enchanter|
     by|
Dave Lebling|
     and|
 Marc Blank|
|
Copyright 1983, by Infocom, Inc.|
|
">
	 <FIXED-FONT-OFF>
	 <TELL
"After a while, the smoke dissipates and the lights dim. You remain
slightly dazzled for a while, but fortunately, this wears off." CR>>