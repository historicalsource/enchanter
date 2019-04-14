

	.FUNCT	JEWEL-CHESTS-F
	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE \?ELS5
	PRINTR	"There's nothing inside."
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS9
	PRINTR	"Don't bother. There's nothing inside anyway."
?ELS9:	EQUAL?	PRSA,V?PUT \FALSE
	PRINTR	"A waste of time. You'd probably forget where you put it."


	.FUNCT	EGG-KNOB-STATE,KNOB,VER?=0
	ZERO?	VER? \?THN6
	FSET?	KNOB,OPENBIT \FALSE
?THN6:	PRINTI	"The "
	PRINTD	KNOB
	FSET?	KNOB,OPENBIT \?ELS12
	PRINTI	" has been "
	JUMP	?CND10
?ELS12:	ZERO?	VER? /?CND10
	PRINTI	" has not yet been "
?CND10:	GETP	KNOB,P?TEXT
	PRINT	STACK
	PRINTI	". "
	RTRUE	


	.FUNCT	EGG-F
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	FSET?	EGG,OPENBIT /?ELS5
	PRINTR	"The egg isn't open!"
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS11
	PRINTI	"This ornamented egg is both beautiful and complex. The egg itself is mother-of-pearl, but decorated with delicate gold traceries inlaid with jewels and other precious metals. On the surface are a lapis handle, an emerald knob, a silver slide, a golden crank, and a diamond-studded button carefully and unobtrusively imbedded in the decorations. These various protuberances are likely to be connected with some machinery inside."
	CRLF	
	CALL	EGG-KNOB-STATE,EGG-KNOB-1
	CALL	EGG-KNOB-STATE,EGG-KNOB-2
	CALL	EGG-KNOB-STATE,EGG-KNOB-3
	CALL	EGG-KNOB-STATE,EGG-KNOB-4
	CALL	EGG-KNOB-STATE,EGG-KNOB-5
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" is "
	FSET?	PRSO,OPENBIT \?ELS18
	PRINTI	"open."
	JUMP	?CND16
?ELS18:	PRINTI	"closed."
?CND16:	CRLF	
	RTRUE	
?ELS11:	EQUAL?	PRSA,V?PUT \?ELS26
	EQUAL?	PRSI,EGG \?ELS26
	PRINTI	"You can't put the "
	PRINTD	PRSO
	PRINTR	" inside the egg without damaging it."
?ELS26:	EQUAL?	PRSA,V?REZROV \?ELS32
	FSET?	EGG,OPENBIT /?ELS32
	FSET	EGG,OPENBIT
	ADD	SCORE,EGG-POINT >SCORE
	SET	'EGG-POINT,0
	PRINTI	"The egg seems to come to life and each piece slides effortlessly in the correct pattern. The egg opens"
	IN?	DAMAGED-SCROLL,EGG \?CND37
	FCLEAR	DAMAGED-SCROLL,INVISIBLE
	CALL	THIS-IS-IT,DAMAGED-SCROLL
	PRINTI	", revealing a shredded scroll inside, nestled among a profusion of shredders, knives, and other sharp instruments, cunningly connected to the knobs, buttons, etc. on the outside"
?CND37:	PRINTR	"."
?ELS32:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS45
	FSET?	PRSO,OPENBIT \?ELS45
	FIRST?	PRSO /?ELS45
	PRINTR	"On the inside of the egg are many complex cutting devices."
?ELS45:	EQUAL?	PRSA,V?OPEN \?ELS51
	FSET?	EGG,OPENBIT /?ELS51
	PRINTR	"That seems to be the problem."
?ELS51:	EQUAL?	PRSA,V?CLOSE \?ELS57
	FSET?	EGG,OPENBIT \?ELS57
	FCLEAR	EGG-KNOB-1,OPENBIT
	FCLEAR	EGG-KNOB-2,OPENBIT
	FCLEAR	EGG-KNOB-3,OPENBIT
	FCLEAR	EGG-KNOB-4,OPENBIT
	FCLEAR	EGG-KNOB-5,OPENBIT
	PRINTI	"As you close the egg, all of the pieces slide back into place, locking it shut."
	CRLF	
	FCLEAR	EGG,OPENBIT
	RTRUE	
?ELS57:	EQUAL?	PRSA,V?MUNG \FALSE
	PRINTI	"The egg is smashed into little tiny pieces by the force of your blow."
	IN?	DAMAGED-SCROLL,EGG \?CND66
	FCLEAR	DAMAGED-SCROLL,INVISIBLE
	MOVE	DAMAGED-SCROLL,SCRAMBLED-EGG
	PRINTI	" Inside the now broken egg are the remains of a small spell scroll, damaged beyond hope of learning."
?CND66:	CRLF	
	LOC	EGG
	MOVE	SCRAMBLED-EGG,STACK
	REMOVE	EGG
	RTRUE	


	.FUNCT	EGG-KNOB-F
	EQUAL?	PRSA,V?TURN,V?OPEN,V?REZROV /?THN6
	EQUAL?	PRSA,V?PUSH,V?MOVE \?ELS5
?THN6:	FSET?	PRSO,OPENBIT \?ELS12
	PRINTR	"It's already in the open position."
?ELS12:	FSET	PRSO,OPENBIT
	EQUAL?	PRSA,V?REZROV \?ELS21
	ADD	SCORE,EGG-POINT >SCORE
	SET	'EGG-POINT,0
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" vibrates, moving this way and that, becoming almost plastic, and finally moves to the open position."
?ELS21:	FSET?	EGG,OPENBIT \?ELS25
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" moves, and a cunning and diabolically engineered set of gears, knives, grinders, and slicers moves across the interior of the egg."
	CRLF	
	IN?	DAMAGED-SCROLL,EGG \TRUE
	PRINTR	"The scroll resting there is now shredded beyond recognition."
?ELS25:	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" moves to the open position, after some resistance and a few odd noises from some machinery which resides inside the egg."
	CRLF	
	FSET?	EGG-KNOB-1,OPENBIT \TRUE
	FSET?	EGG-KNOB-2,OPENBIT \TRUE
	FSET?	EGG-KNOB-3,OPENBIT \TRUE
	FSET?	EGG-KNOB-4,OPENBIT \TRUE
	FSET?	EGG-KNOB-5,OPENBIT \TRUE
	ADD	SCORE,EGG-POINT >SCORE
	SET	'EGG-POINT,0
	FSET	EGG,OPENBIT
	PRINTI	"The egg falls open"
	IN?	DAMAGED-SCROLL,EGG \?CND44
	FCLEAR	DAMAGED-SCROLL,INVISIBLE
	CALL	THIS-IS-IT,DAMAGED-SCROLL
	PRINTI	", revealing a shredded scroll inside"
?CND44:	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS52
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" is an integral part of the egg and thus cannot be taken."
?ELS52:	EQUAL?	PRSA,V?EXAMINE \?ELS56
	CALL	EGG-KNOB-STATE,PRSO,TRUE-VALUE
	CRLF	
	RTRUE	
?ELS56:	EQUAL?	PRSA,V?CLOSE \?ELS58
	FSET?	PRSO,OPENBIT \?ELS63
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" closes easily, but more noises issue from the interior."
	CRLF	
	FCLEAR	PRSO,OPENBIT
	RTRUE	
?ELS63:	PRINTR	"It's already closed."
?ELS58:	EQUAL?	PRSA,V?MUNG \FALSE
	CALL	PERFORM,V?MUNG,EGG
	RTRUE	


	.FUNCT	SCRAMBLED-EGG-F,L,F
	LOC	SCRAMBLED-EGG >L
	EQUAL?	PRSA,V?KREBF \FALSE
	FIRST?	SCRAMBLED-EGG >F \?CND6
	MOVE	F,EGG
?CND6:	CALL	THIS-IS-IT,EGG
	REMOVE	SCRAMBLED-EGG
	MOVE	EGG,L
	PRINTR	"The egg is returned to its former pristine beauty!"


	.FUNCT	DAMAGED-SCROLL-F,L
	LOC	DAMAGED-SCROLL >L
	EQUAL?	PRSA,V?KREBF \FALSE
	REMOVE	DAMAGED-SCROLL
	MOVE	SUMMON-SCROLL,L
	CALL	THIS-IS-IT,SUMMON-SCROLL
	ADD	SCORE,REPAIR-POINT >SCORE
	SET	'REPAIR-POINT,0
	PRINTR	"The scroll reforms, its slices and cuts rejoining, until there is a whole scroll, somewhat faded, in its place!"

	.ENDI
