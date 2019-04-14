

	.FUNCT	V-SPELLS,CNT,S,ANY=0,OS=0,TMP
	GET	ALL-SPELLS,0 >CNT
	PRINTI	"The gnusto spell, the only thing you seem to have learned well after many years at the University, remains yours forever. Other than that, you have "
?PRG3:	ZERO?	CNT \?CND5
	ZERO?	OS /?CND8
	CALL	SPELL-PRINT,OS,ANY,TRUE-VALUE
	SET	'ANY,TRUE-VALUE
?CND8:	ZERO?	ANY \?ELS14
	PRINTI	"no spells memorized."
	JUMP	?CND12
?ELS14:	PRINTI	" committed to memory."
?CND12:	CRLF	
	RTRUE	
?CND5:	GET	ALL-SPELLS,CNT
	CALL	SPELL-TIMES,STACK >TMP
	ZERO?	TMP /?CND21
	ZERO?	OS /?CND24
	CALL	SPELL-PRINT,OS,ANY
	SET	'ANY,TRUE-VALUE
?CND24:	SET	'OS,TMP
?CND21:	DEC	'CNT
	JUMP	?PRG3


	.FUNCT	SPELL-TIMES,S
	GETP	S,P?COUNT
	GRTR?	STACK,0 \FALSE
	IN?	S,SPELL-BOOK \?ELS10
	RETURN	S
?ELS10:	EQUAL?	S,DISPEL-SPELL \?ELS12
	IN?	DISPEL-SPELL,DISPEL-SCROLL /?ELS12
	RETURN	S
?ELS12:	EQUAL?	S,BANISH-SPELL \FALSE
	IN?	BANISH-SPELL,BANISH-SCROLL /FALSE
	RETURN	S


	.FUNCT	SPELL-PRINT,S,ANY,PAND?=0,CNT
	ZERO?	ANY /?CND1
	ZERO?	PAND? /?ELS7
	PRINTI	" and "
	JUMP	?CND1
?ELS7:	PRINTI	", "
?CND1:	PRINTI	"the "
	PRINTD	S
	GETP	S,P?COUNT >CNT
	GRTR?	CNT,5 \?ELS19
	PRINTI	" many times"
	RETURN	S
?ELS19:	PRINTI	" "
	SUB	CNT,1
	GET	COUNTERS,STACK
	PRINT	STACK
	RETURN	S


	.FUNCT	SPELL-BOOK-F,F
	FIRST?	SPELL-BOOK >F /?KLU28
?KLU28:	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The title is ""My Spell Book"". The book looks pretty new, and it doesn't seem to have much written in it yet. There are some spells written in the book in glowing letters, with marginal notes about how to cast them and what their effects are."
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS9
	PRINTR	"Thanks to its magic properties, the spell book is always open to the right place at the right time, but it is also always closed. This innovation eliminates tedious page turning and hunting for spells in tight situations. Many wizardly lives have been saved by this small advance in magical technology."
?ELS9:	EQUAL?	PRSA,V?READ \FALSE
	ZERO?	LIT \?CND14
	PRINTI	"Though it is dark, the magic writing of your spells casts enough light that you can read them."
	CRLF	
?CND14:	PRINTI	"
My Spell Book

"
?PRG21:	ZERO?	F /TRUE
	PRINTI	"The "
	PRINTD	F
	PRINTI	" ("
	GETP	F,P?TEXT
	PRINT	STACK
	PRINTI	")."
	CRLF	
	NEXT?	F >F /?KLU29
?KLU29:	JUMP	?PRG21


	.FUNCT	SPELL-CHECK,TBL,WRD,OBJ=0
	EQUAL?	WRD,W?GNUSTO \?ELS3
	SET	'OBJ,WRITE-MAGIC-SPELL
	JUMP	?CND1
?ELS3:	EQUAL?	WRD,W?FROTZ \?ELS5
	SET	'OBJ,LIGHT-SPELL
	JUMP	?CND1
?ELS5:	EQUAL?	WRD,W?OZMOO \?ELS7
	SET	'OBJ,CHEAT-DEATH-SPELL
	JUMP	?CND1
?ELS7:	EQUAL?	WRD,W?ZIFMIA \?ELS9
	SET	'OBJ,SUMMON-SPELL
	JUMP	?CND1
?ELS9:	EQUAL?	WRD,W?VAXUM \?ELS11
	SET	'OBJ,CHARM-SPELL
	JUMP	?CND1
?ELS11:	EQUAL?	WRD,W?REZROV \?ELS13
	SET	'OBJ,OPEN-SPELL
	JUMP	?CND1
?ELS13:	EQUAL?	WRD,W?NITFOL \?ELS15
	SET	'OBJ,TALK-TO-ANIMALS-SPELL
	JUMP	?CND1
?ELS15:	EQUAL?	WRD,W?EXEX \?ELS17
	SET	'OBJ,HASTE-SPELL
	JUMP	?CND1
?ELS17:	EQUAL?	WRD,W?KULCAD \?ELS19
	SET	'OBJ,DISPEL-SPELL
	JUMP	?CND1
?ELS19:	EQUAL?	WRD,W?MELBOR \?ELS21
	SET	'OBJ,PROTECTION-SPELL
	JUMP	?CND1
?ELS21:	EQUAL?	WRD,W?BLORB \?ELS23
	SET	'OBJ,STRONG-BOX-SPELL
	JUMP	?CND1
?ELS23:	EQUAL?	WRD,W?GUNCHO \?ELS25
	SET	'OBJ,BANISH-SPELL
	JUMP	?CND1
?ELS25:	EQUAL?	WRD,W?KREBF \?ELS27
	SET	'OBJ,REPAIR-SPELL
	JUMP	?CND1
?ELS27:	EQUAL?	WRD,W?CLEESH \?ELS29
	SET	'OBJ,NEWT-SPELL
	JUMP	?CND1
?ELS29:	EQUAL?	WRD,W?IZYUK \?ELS31
	SET	'OBJ,FLY-SPELL
	JUMP	?CND1
?ELS31:	EQUAL?	WRD,W?GONDAR \?ELS33
	SET	'OBJ,QUENCH-SPELL
	JUMP	?CND1
?ELS33:	EQUAL?	WRD,W?FILFRE \?CND1
	SET	'OBJ,CREDITS-SPELL
?CND1:	ZERO?	OBJ /TRUE
	CALL	OBJ-FOUND,OBJ,TBL
	RTRUE	


	.FUNCT	PRE-QUICK-CAST,MEM?,SPELL,SCROLL
	EQUAL?	PRSA,V?GNUSTO \?ELS5
	PUSH	WRITE-MAGIC-SPELL
	JUMP	?CND1
?ELS5:	EQUAL?	PRSA,V?FROTZ \?ELS7
	PUSH	LIGHT-SPELL
	JUMP	?CND1
?ELS7:	EQUAL?	PRSA,V?OZMOO \?ELS9
	PUSH	CHEAT-DEATH-SPELL
	JUMP	?CND1
?ELS9:	EQUAL?	PRSA,V?ZIFMIA \?ELS11
	PUSH	SUMMON-SPELL
	JUMP	?CND1
?ELS11:	EQUAL?	PRSA,V?VAXUM \?ELS13
	PUSH	CHARM-SPELL
	JUMP	?CND1
?ELS13:	EQUAL?	PRSA,V?REZROV \?ELS15
	PUSH	OPEN-SPELL
	JUMP	?CND1
?ELS15:	EQUAL?	PRSA,V?NITFOL \?ELS17
	PUSH	TALK-TO-ANIMALS-SPELL
	JUMP	?CND1
?ELS17:	EQUAL?	PRSA,V?EXEX \?ELS19
	PUSH	HASTE-SPELL
	JUMP	?CND1
?ELS19:	EQUAL?	PRSA,V?KULCAD \?ELS21
	PUSH	DISPEL-SPELL
	JUMP	?CND1
?ELS21:	EQUAL?	PRSA,V?MELBOR \?ELS23
	PUSH	PROTECTION-SPELL
	JUMP	?CND1
?ELS23:	EQUAL?	PRSA,V?BLORB \?ELS25
	PUSH	STRONG-BOX-SPELL
	JUMP	?CND1
?ELS25:	EQUAL?	PRSA,V?GUNCHO \?ELS27
	PUSH	BANISH-SPELL
	JUMP	?CND1
?ELS27:	EQUAL?	PRSA,V?GONDAR \?ELS29
	PUSH	QUENCH-SPELL
	JUMP	?CND1
?ELS29:	EQUAL?	PRSA,V?KREBF \?ELS31
	PUSH	REPAIR-SPELL
	JUMP	?CND1
?ELS31:	EQUAL?	PRSA,V?CLEESH \?ELS33
	PUSH	NEWT-SPELL
	JUMP	?CND1
?ELS33:	EQUAL?	PRSA,V?IZYUK \?ELS35
	PUSH	FLY-SPELL
	JUMP	?CND1
?ELS35:	EQUAL?	PRSA,V?FILFRE \?ELS37
	PUSH	CREDITS-SPELL
	JUMP	?CND1
?ELS37:	PRINTR	"**OOOPS!**"
?CND1:	SET	'SPELL,STACK
	FSET?	SPELL,RMUNGBIT \?CND42
	PRINTR	"The spell is defaced beyond recognition."
?CND42:	LOC	SPELL >SCROLL
	ZERO?	SCROLL /?CND47
	FSET?	SCROLL,SCROLLBIT \?CND47
	IN?	SCROLL,WINNER \?ELS54
	REMOVE	SCROLL
	EQUAL?	PRSO,KRILL /?CND55
	PRINTI	"As you cast the spell, the "
	PRINTD	SCROLL
	PRINTI	" vanishes!"
	CRLF	
?CND55:	PUTP	SPELL,P?COUNT,1
	JUMP	?CND47
?ELS54:	FSET?	SPELL,TOUCHBIT /?THN62
	IN?	SCROLL,HERE \?ELS61
?THN62:	PRINTI	"You don't have the "
	PRINTD	SPELL
	PRINTR	" memorized, nor do you have the scroll on which it is written."
?ELS61:	PRINTI	"The "
	PRINTD	SPELL
	PRINTR	" is not committed to memory, and you haven't seen any scroll on which it is written."
?CND47:	GETP	SPELL,P?COUNT >MEM?
	EQUAL?	SPELL,WRITE-MAGIC-SPELL /FALSE
	GRTR?	MEM?,0 /?ELS76
	PRINTI	"You don't have the "
	PRINTD	SPELL
	PRINTR	" committed to memory!"
?ELS76:	SUB	MEM?,1
	PUTP	SPELL,P?COUNT,STACK
	INC	'SPELL-ROOM
	EQUAL?	PRSA,V?GUNCHO,V?KULCAD \FALSE
	CALL	QUEUE,MORE-PROBE,1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	SCROLL-F,SPELL
	EQUAL?	PRSA,V?TAKE \?ELS5
	FIRST?	PRSO >SPELL /?KLU41
?KLU41:	FSET	SPELL,TOUCHBIT
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?CUT \?ELS7
	EQUAL?	PRSI,MAGIC-KNIFE \?ELS7
	REMOVE	PRSO
	PRINTR	"The magic dagger reduces the scroll to shreds. The shreds shrivel up into tiny spitballs. The spitballs evaporate."
?ELS7:	EQUAL?	PRSA,V?BURN \?ELS13
	EQUAL?	PRSI,ETERNAL-FLAME \?ELS13
	REMOVE	PRSO
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" burns cheerily. Interestingly, the flame is sort of purple and rather bright. Not even ashes remain."
?ELS13:	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	FIRST?	PRSO >SPELL \?ELS24
	FSET?	SPELL,RMUNGBIT \?CND25
	PRINTR	"The scroll is defaced. The spell on it cannot be read."
?CND25:	PRINTI	"The scroll reads """
	PRINTD	SPELL
	PRINTI	": "
	GETP	SPELL,P?TEXT
	PRINT	STACK
	PRINTI	"""."
	EQUAL?	SPELL,BANISH-SPELL,DISPEL-SPELL \?CND32
	PRINTI	" The spell seems very long and extremely complicated."
?CND32:	CRLF	
	RTRUE	
?ELS24:	PRINTR	"Nothing useful can be made out on the scroll."


	.FUNCT	SPELL-F,MEM?,FORGET=0
	EQUAL?	PRSA,V?READ \?ELS5
	IN?	PRSO,SPELL-BOOK /FALSE
	LOC	PRSO
	IN?	STACK,WINNER /FALSE
	PRINTR	"You can't do that without having the spell in your book or on a scroll in your hand."
?ELS5:	EQUAL?	PRSA,V?LEARN,V?MEMORIZE \?ELS16
	IN?	PRSO,SPELL-BOOK /?ELS21
	LOC	PRSO
	IN?	STACK,WINNER \?ELS26
	PRINTR	"You haven't written that spell into your book yet. Until you do, you can't memorize the spell."
?ELS26:	CALL	V-LEARN
	RSTACK	
?ELS21:	IN?	SPELL-BOOK,WINNER /?ELS32
	PRINTR	"You don't have your spell book. How do you expect to memorize a spell without a spell book?"
?ELS32:	EQUAL?	PRSO,WRITE-MAGIC-SPELL \?ELS36
	PRINTR	"You already know that spell by heart."
?ELS36:	ZERO?	LIT \?ELS40
	PRINTR	"It will be hard to learn that spell in the dark."
?ELS40:	GETP	PRSO,P?COUNT >MEM?
	ZERO?	SPELL-ROOM \?ELS47
	EQUAL?	SPELL-MAX,1 \?ELS50
	PRINTR	"You can't concentrate well enough to learn the spell."
?ELS50:	EQUAL?	MEM?,SPELL-MAX \?ELS54
	JUMP	?CND45
?ELS54:	CALL	FORGET-SPELL,PRSO
	INC	'MEM?
	PUTP	PRSO,P?COUNT,MEM?
	SET	'FORGET,TRUE-VALUE
	JUMP	?CND45
?ELS47:	DEC	'SPELL-ROOM
	INC	'MEM?
	PUTP	PRSO,P?COUNT,MEM?
?CND45:	PRINTI	"Using your best study habits, you learn the "
	PRINTD	PRSO
	GRTR?	MEM?,1 \?CND61
	PRINTI	" yet another time"
?CND61:	PRINTI	"."
	CRLF	
	ZERO?	FORGET /TRUE
	PRINTR	"You have so much buzzing around in your head, though, that it's likely that something may have been forgotten in the shuffle."
?ELS16:	EQUAL?	PRSA,V?DROP,V?TAKE \FALSE
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	FORGET-SPELL,SPL,NSPL,F,CNT,TBL,NUM=0,SP=0
	FIRST?	SPELL-BOOK >F /?KLU26
?KLU26:	SET	'TBL,FORGET-TBL
?PRG1:	ZERO?	F \?ELS5
	JUMP	?REP2
?ELS5:	GETP	F,P?COUNT >CNT
	GRTR?	CNT,0 \?CND3
?PRG8:	SET	'SP,F
	PUT	TBL,1,F
	INC	'NUM
	ADD	TBL,2 >TBL
	DLESS?	'CNT,1 \?PRG8
?CND3:	NEXT?	F >F /?KLU27
?KLU27:	JUMP	?PRG1
?REP2:	GRTR?	NUM,0 \?CND13
	GETP	SP,P?COUNT
	EQUAL?	STACK,NUM \?CND13
	SUB	NUM,1
	PUTP	SP,P?COUNT,STACK
	RTRUE	
?CND13:	PUT	FORGET-TBL,0,NUM
	ZERO?	NUM /TRUE
?PRG21:	CALL	RANDOM-ELEMENT,FORGET-TBL >NSPL
	EQUAL?	NSPL,SPL /?PRG21
	GETP	NSPL,P?COUNT
	SUB	STACK,1
	PUTP	NSPL,P?COUNT,STACK
	RTRUE	


	.FUNCT	FORGET-ALL,F
	SET	'SPELL-ROOM,SPELL-MAX
	FIRST?	SPELL-BOOK >F /?KLU8
?KLU8:	
?PRG1:	ZERO?	F /TRUE
	PUTP	F,P?COUNT,0
	NEXT?	F >F /?KLU9
?KLU9:	JUMP	?PRG1


	.FUNCT	V-CAST,VRB
	FSET?	PRSO,SPELLBIT /?ELS5
	PRINTI	"You might as well be casting with a fly rod, as to try to cast "
	CALL	PRINTA,PRSO
	PRINTR	"."
?ELS5:	EQUAL?	PRSO,WRITE-MAGIC-SPELL \?ELS14
	PUSH	V?GNUSTO
	JUMP	?CND10
?ELS14:	EQUAL?	PRSO,LIGHT-SPELL \?ELS16
	PUSH	V?FROTZ
	JUMP	?CND10
?ELS16:	EQUAL?	PRSO,CHEAT-DEATH-SPELL \?ELS18
	PUSH	V?OZMOO
	JUMP	?CND10
?ELS18:	EQUAL?	PRSO,SUMMON-SPELL \?ELS20
	PUSH	V?ZIFMIA
	JUMP	?CND10
?ELS20:	EQUAL?	PRSO,CHARM-SPELL \?ELS22
	PUSH	V?VAXUM
	JUMP	?CND10
?ELS22:	EQUAL?	PRSO,OPEN-SPELL \?ELS24
	PUSH	V?REZROV
	JUMP	?CND10
?ELS24:	EQUAL?	PRSO,TALK-TO-ANIMALS-SPELL \?ELS26
	PUSH	V?NITFOL
	JUMP	?CND10
?ELS26:	EQUAL?	PRSO,HASTE-SPELL \?ELS28
	PUSH	V?EXEX
	JUMP	?CND10
?ELS28:	EQUAL?	PRSO,DISPEL-SPELL \?ELS30
	PUSH	V?KULCAD
	JUMP	?CND10
?ELS30:	EQUAL?	PRSO,PROTECTION-SPELL \?ELS32
	PUSH	V?MELBOR
	JUMP	?CND10
?ELS32:	EQUAL?	PRSO,STRONG-BOX-SPELL \?ELS34
	PUSH	V?BLORB
	JUMP	?CND10
?ELS34:	EQUAL?	PRSO,BANISH-SPELL \?ELS36
	PUSH	V?GUNCHO
	JUMP	?CND10
?ELS36:	EQUAL?	PRSO,QUENCH-SPELL \?ELS38
	PUSH	V?GONDAR
	JUMP	?CND10
?ELS38:	EQUAL?	PRSO,REPAIR-SPELL \?ELS40
	PUSH	V?KREBF
	JUMP	?CND10
?ELS40:	EQUAL?	PRSO,NEWT-SPELL \?ELS42
	PUSH	V?CLEESH
	JUMP	?CND10
?ELS42:	EQUAL?	PRSO,FLY-SPELL \?ELS44
	PUSH	V?IZYUK
	JUMP	?CND10
?ELS44:	EQUAL?	PRSO,CREDITS-SPELL \?ELS46
	PUSH	V?FILFRE
	JUMP	?CND10
?ELS46:	PRINTR	"**OOPS**"
?CND10:	SET	'VRB,STACK
	ZERO?	PRSI \?ELS53
	EQUAL?	VRB,V?KREBF,V?FILFRE \?ELS53
	CALL	PERFORM,VRB
	RTRUE	
?ELS53:	ZERO?	PRSI \?ELS57
	PRINTR	"You might as well be casting it away as not cast it on something."
?ELS57:	CALL	PERFORM,VRB,PRSI
	RTRUE	


	.FUNCT	V-LEARN
	PRINTR	"You don't have that spell, if indeed that is a spell."


	.FUNCT	V-MEMORIZE
	CALL	V-LEARN
	RSTACK	


	.FUNCT	V-GNUSTO,SCROLL
	IN?	SPELL-BOOK,WINNER /?ELS5
	PRINTR	"The spell quests around in your hands, looking for your spell book, and not finding it, fades reluctantly."
?ELS5:	FSET?	PRSO,SPELLBIT /?ELS9
	PRINTI	"You can't inscribe "
	EQUAL?	PRSO,ME \?ELS14
	PRINTI	"yourself"
	JUMP	?CND12
?ELS14:	CALL	PRINTA,PRSO
?CND12:	PRINTR	" in your spell book!"
?ELS9:	IN?	PRSO,SPELL-BOOK \?ELS24
	PRINTR	"You already have that spell inscribed in your book!"
?ELS24:	FSET?	PRSO,RMUNGBIT \?ELS28
	PRINTR	"The spell is defaced beyond recognition."
?ELS28:	LOC	PRSO >SCROLL
	FSET?	SCROLL,SCROLLBIT \?ELS37
	CALL	HELD?,SCROLL
	ZERO?	STACK /?ELS37
	EQUAL?	PRSO,DISPEL-SPELL,BANISH-SPELL,CREDITS-SPELL \?ELS42
	PRINTI	"Your spell book begins to glow softly. In a spectacular effort of magic, the powers of the gnusto spell attempt to copy the "
	PRINTD	PRSO
	PRINTI	" into your book, but the spell is too long, too complicated, and too powerful. The glow fades, but fortunately the "
	PRINTD	SCROLL
	PRINTI	" remains intact."
	CRLF	
	EQUAL?	PRSO,DISPEL-SPELL,BANISH-SPELL \TRUE
	CALL	MORE-PROBE,FALSE-VALUE
	RTRUE	
?ELS42:	REMOVE	SCROLL
	MOVE	PRSO,SPELL-BOOK
	PUTP	PRSO,P?COUNT,0
	PRINTI	"Your spell book begins to glow softly. Slowly, ornately, the words of the "
	PRINTD	PRSO
	PRINTR	" are inscribed, glowing even more brightly than the book itself. The book's brightness fades, but the spell remains! However, the scroll on which it was written vanishes as the last word is copied."
?ELS37:	PRINTR	"You must have a legible spell scroll in your hands before the gnusto spell will work on it."


	.FUNCT	MORE-PROBE,CAST?=1
	EQUAL?	HERE,PIT,REAL-STAIR,ENDLESS-STAIR /TRUE
	EQUAL?	HERE,WARLOCK-TOWER /TRUE
	IGRTR?	'PROBE,3 \?ELS9
	PRINTI	"The warlock Krill appears before you, clad in deepest black. ""You are a fool, wizard-worm! You and your Circle!"" He spits in your face, causing a wound through which a foul poison enters your body. Krill's demonic laughter is the last sound you hear."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS9:	CRLF	
	GET	PROBE-TBL,PROBE
	PRINT	STACK
	CRLF	
	ZERO?	CAST? \?THN19
	EQUAL?	PROBE,2 \?CND16
	IN?	KRILL,HERE /?CND16
?THN19:	ZERO?	BELBOZ-WARNING \?CND16
	SET	'BELBOZ-WARNING,TRUE-VALUE
	CRLF	
	PRINTI	"Belboz appears before you, hard and stern. ""While you have quested for Krill's lair, the Circle has not been idle. We have tried to shield your presence from him, but "
	ZERO?	CAST? /?ELS30
	PRINTI	"your use of such a powerful spell might endanger us all!"
	JUMP	?CND28
?ELS30:	PRINTI	"your foolish attempt to copy such a powerful spell cannot be ignored!"
?CND28:	PRINTI	" As we have sensed it, so surely must Krill! Be careful, brave Enchanter!"" His image fades."
	CRLF	
?CND16:	INC	'LOSSAGE
	RTRUE	


	.FUNCT	V-FROTZ,OLIT
	SET	'OLIT,LIT
	IN?	PRSO,LOCAL-GLOBALS /?ELS5
	FSET?	PRSO,TAKEBIT /?THN8
	FSET?	PRSO,VICBIT \?ELS5
?THN8:	FSET	PRSO,LIGHTBIT
	FSET	PRSO,ONBIT
	PRINTI	"There is an almost blinding flash of light as the "
	PRINTD	PRSO
	PRINTI	" begins to glow! It slowly fades to a less painful level, but the "
	PRINTD	PRSO
	PRINTI	" is now quite usable as a light source."
	CRLF	
	ADD	SCORE,LIGHT-POINT >SCORE
	SET	'LIGHT-POINT,0
	CALL	LIT?,HERE >LIT
	ZERO?	OLIT \TRUE
	ZERO?	LIT /TRUE
	CRLF	
	CALL	PERFORM,V?LOOK
	RTRUE	
?ELS5:	CALL	V-VAXUM
	RSTACK	


	.FUNCT	V-OZMOO
	PRINTI	"A huge puff of orange smoke envelops "
	SET	'DEATH-CHEATED,PRSO
	EQUAL?	PRSO,ME \?ELS7
	CALL	QUEUE,I-DEATH-CHEATED-END,8
	PUT	STACK,0,1
	PRINTR	"you, but you feel no different."
?ELS7:	PRINTI	"the "
	PRINTD	PRSO
	PRINTR	". Other than that, not much happens."


	.FUNCT	I-DEATH-CHEATED-END
	SET	'DEATH-CHEATED,FALSE-VALUE
	EQUAL?	DEATH-CHEATED,ME \TRUE
	PRINTR	"You feel a bit lightheaded for a moment, but the feeling quickly passes."


	.FUNCT	V-ZIFMIA
	FSET?	PRSO,TAKEBIT /?THN6
	IN?	PRSO,LOCAL-GLOBALS \?ELS5
?THN6:	PRINTR	"The zifmia spell is for summoning beings, not things!"
?ELS5:	FSET?	PRSO,VICBIT \?ELS11
	IN?	PRSO,HERE /?ELS11
	CALL	NO-ZIF
	RSTACK	
?ELS11:	CALL	V-VAXUM
	RSTACK	


	.FUNCT	NO-ZIF
	PRINTR	"If you will remember from Thaumaturgy 201, summoning of beings works only if the being can be seen, unless the being possesses great magic of his own."


	.FUNCT	V-VAXUM
	PRINTR	"Although you complete the spell, nothing seems to have happened."


	.FUNCT	V-GONDAR
	CALL	V-VAXUM
	RSTACK	


	.FUNCT	V-REZROV
	FSET?	PRSO,CONTBIT \?ELS5
	FSET?	PRSO,OPENBIT \?ELS8
	PRINTI	"It's open already. Why bother?"
	CRLF	
	JUMP	?CND6
?ELS8:	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" opens. Kind of like swatting a fly with a sledge hammer, if you ask me."
	CRLF	
?CND6:	FSET	PRSO,OPENBIT
	RTRUE	
?ELS5:	CALL	V-VAXUM
	RSTACK	


	.FUNCT	I-TALK-TO-ANIMAL
	EQUAL?	TALK-TO-ANIMAL?,TURTLE \?CND1
	ZERO?	TURTLE-FOLLOWS /?CND1
	SET	'TURTLE-FOLLOWS,FALSE-VALUE
	IN?	TURTLE,HERE \?CND1
	PRINTI	"The turtle no longer seems to understand you, loses interest in you, and stops following."
	CRLF	
?CND1:	SET	'TALK-TO-ANIMAL?,FALSE-VALUE
	RETURN	TALK-TO-ANIMAL?


	.FUNCT	V-NITFOL
	FSET?	PRSO,VILLAIN \?ELS5
	SET	'TALK-TO-ANIMAL?,PRSO
	CALL	QUEUE,I-TALK-TO-ANIMAL,20
	PUT	STACK,0,1
	EQUAL?	PRSO,ME \?ELS10
	PRINTR	"You now understand everything you say to yourself, which is more than I can do. You didn't study too hard in Thaumaturgy 101, did you? This spell should be cast on the creature you wish to talk to!"
?ELS10:	EQUAL?	PRSO,FROG \?ELS17
	PRINTI	"One of the frogs"
	JUMP	?CND15
?ELS17:	PRINTI	"The "
	PRINTD	PRSO
?CND15:	PRINTR	" looks at you for a moment, and you look at it. ""Hello,"" it says."
?ELS5:	PRINTI	"This seems to have no effect on "
	CALL	PRINTA,PRSO
	PRINTR	"."


	.FUNCT	I-HASTE
	EQUAL?	HASTED?,ME \?CND1
	ADD	HUNGER-COUNT,2 >HUNGER-COUNT
	CALL	QUEUE,I-HUNGER,3
	PUT	STACK,0,1
	ADD	THIRST-COUNT,2 >THIRST-COUNT
	CALL	QUEUE,I-THIRST,4
	PUT	STACK,0,1
	CALL	QUEUE,I-TIRED,5
	PUT	STACK,0,1
	PRINTI	"The effects of the exex spell have worn off. You are ravenous, parched, and tired."
	CRLF	
?CND1:	SET	'HASTED?,FALSE-VALUE
	RETURN	HASTED?


	.FUNCT	V-EXEX
	ZERO?	HASTED? /?ELS5
	PRINTR	"Nothing seems to happen. Perhaps the spell needs time before it can be cast again."
?ELS5:	FSET?	PRSO,VILLAIN \?ELS10
	SET	'HASTED?,PRSO
	EQUAL?	PRSO,ME \?ELS15
	SET	'HASTED?,PLAYER
	EQUAL?	HERE,WARLOCK-TOWER \?ELS20
	PRINTR	"Krill, nobody's fool, hears you start the exex spell and hastily improvises one of his own which entirely counteracts it. The spell acts so well, in fact, that you are frozen solid."
?ELS20:	CALL	QUEUE,I-HASTE,45
	PUT	STACK,0,1
	PRINTR	"You feel energetic and zippy."
?ELS15:	CALL	QUEUE,I-HASTE,15
	PUT	STACK,0,1
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" shimmers, then vibrates in place for a few seconds, but doesn't take any notice of the change."
?ELS10:	CALL	V-VAXUM
	RSTACK	


	.FUNCT	V-KULCAD
	PRINTI	"It appears that the "
	PRINTD	PRSO
	PRINTR	" was real, since nothing happens."


	.FUNCT	V-MELBOR
	EQUAL?	PRSO,ME \?ELS5
	SET	'PROTECTED-FROM-EVIL,TRUE-VALUE
	PRINTR	"A wave of warmth courses through you, leaving you with a feeling of great internal strength."
?ELS5:	CALL	V-VAXUM
	RSTACK	


	.FUNCT	V-BLORB,OBJ
	ZERO?	STRONG-BOX-FLAG /?CND1
	CALL	V-VAXUM
	RTRUE	
?CND1:	FSET?	PRSO,TAKEBIT /?THN10
	EQUAL?	PRSO,ADVENTURER \?ELS9
?THN10:	EQUAL?	PRSO,ADVENTURER,TURTLE \?ELS14
	REMOVE	PRSO
	EQUAL?	PRSO,ADVENTURER \?ELS17
	CALL	QUEUE,I-ADVENTURER,0
	JUMP	?CND12
?ELS17:	CALL	QUEUE,I-TURTLE,0
	JUMP	?CND12
?ELS14:	MOVE	PRSO,STRONG-BOX
?CND12:	SET	'STRONG-BOX-FLAG,TRUE-VALUE
	MOVE	STRONG-BOX,HERE
	PRINTI	"A glowing strong box forms out of the air, carefully enclosing the "
	PRINTD	PRSO
	PRINTR	", which disappears from view. The strong box rests on the ground."
?ELS9:	CALL	V-VAXUM
	RSTACK	


	.FUNCT	STRONG-BOX-F,OBJ
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"The strong box is apparently stuck to the ground, or welded there, or tied with magical ropes. It won't move."
?ELS5:	EQUAL?	PRSA,V?KULCAD,V?REZROV,V?OPEN \FALSE
	SET	'STRONG-BOX-FLAG,FALSE-VALUE
	FIRST?	STRONG-BOX >OBJ \?CND10
	MOVE	OBJ,HERE
	CALL	THIS-IS-IT,OBJ
?CND10:	REMOVE	STRONG-BOX
	EQUAL?	PRSA,V?OPEN \?ELS19
	PUSH	STR?122
	JUMP	?CND15
?ELS19:	EQUAL?	PRSA,V?REZROV \?ELS21
	PUSH	STR?123
	JUMP	?CND15
?ELS21:	EQUAL?	PRSA,V?KULCAD \?PRD17
	PUSH	STR?124
	JUMP	?CND15
?PRD17:	PUSH	0
?CND15:	PRINT	STACK
	PRINTI	" the strong box, it vanishes, and "
	ZERO?	OBJ /?ELS26
	PRINTI	"the "
	PRINTD	OBJ
	PRINTI	" re"
	JUMP	?CND24
?ELS26:	PRINTI	"nothing "
?CND24:	PRINTR	"appears in its place."


	.FUNCT	V-GUNCHO
	FSET?	PRSO,VICBIT \?ELS5
	REMOVE	PRSO
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" disappears, fading with stately speed into a misty shadow, shimmering and wavering, which then is gone."
?ELS5:	CALL	V-VAXUM
	RSTACK	


	.FUNCT	V-KREBF
	ZERO?	PRSO /?THN6
	EQUAL?	PRSO,GLOBAL-ROOM \?ELS5
?THN6:	FSET?	HERE,RMUNGBIT \?ELS12
	FCLEAR	HERE,RMUNGBIT
	FCLEAR	HERE,TOUCHBIT
	PRINTR	"There is a slow brightening of the illumination, and color flows back into your surroundings. There is a touch of spring in the air."
?ELS12:	PRINTR	"Nothing happens. Perhaps there was no damage here to repair."
?ELS5:	FSET?	PRSO,SCROLLBIT \?CND21
	FIRST?	PRSO \?CND21
	FIRST?	PRSO >PRSO /?KLU46
?KLU46:	
?CND21:	FSET?	PRSO,RMUNGBIT /?ELS30
	PRINTR	"Nothing happens."
?ELS30:	FCLEAR	PRSO,RMUNGBIT
	FSET?	PRSO,SPELLBIT \?ELS39
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" becomes readable again."
?ELS39:	PRINTR	"Nothing obvious happens."


	.FUNCT	V-CLEESH
	EQUAL?	PRSO,ME \?ELS5
	PRINTI	"You are turned into a newt, and scurry off to find your friends in the swamp. You are distracted by various yummy insects along the way, but eventually settle into a nice gooey part of the morass and live happily ever after, at least until you are devoured by a heron."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS5:	EQUAL?	PRSO,ADVENTURER,ADVENTURER-LG \?ELS9
	CALL	NO-MORE-ADVENTURER
	CALL	QUEUE,I-ADVENTURER,0
	REMOVE	ADVENTURER
	PRINTR	"The adventurer turns into a fairly large newt, which scuttles off and is lost to sight."
?ELS9:	FSET?	PRSO,VICBIT \?ELS13
	FSET?	PRSO,VILLAIN \?ELS13
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" looks sort of green and slimy for a moment, but he gets better."
?ELS13:	PRINTI	"Turning the "
	PRINTD	PRSO
	PRINTR	" into a newt is a remarkable idea."


	.FUNCT	V-IZYUK
	ZERO?	PRSO /?THN6
	EQUAL?	PRSO,ME \?ELS5
?THN6:	SET	'FLYING?,TRUE-VALUE
	CALL	QUEUE,I-FLY,4
	PUT	STACK,0,1
	CALL	QUEUE,I-FALL-FOREVER,0
	PRINTR	"Your descent slows, and you are floating serenely in midair. The tower surrounds you, with wide-cut openings to the east and west. You could probably fly in either direction if you wished."
?ELS5:	PRINTI	"You can't make the "
	PRINTD	PRSO
	PRINTR	" fly!"


	.FUNCT	I-FLY
	SET	'FLYING?,FALSE-VALUE
	LOC	WINNER
	EQUAL?	STACK,PIT,REAL-STAIR \?ELS5
	PRINTI	"The izyuk spell has worn off! You plummet deeper and deeper into the pit! Oddly enough, you never seem to hit bottom. After many years, only tattered remnants of you remain, still falling."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS5:	PRINTR	"You settle gently to the ground."


	.FUNCT	V-FILFRE
	PRINTI	"In a blinding burst of pyrotechnics, the air lights up with fireworks and dazzling explosions of multicolored fire! In sizzling sparks and roiling smoke is written:
"
	CALL	FIXED-FONT-ON
	PRINTI	"
  Enchanter
     by
Dave Lebling
     and
 Marc Blank

Copyright 1983, by Infocom, Inc.

"
	CALL	FIXED-FONT-OFF
	PRINTR	"After a while, the smoke dissipates and the lights dim. You remain slightly dazzled for a while, but fortunately, this wears off."

	.ENDI
