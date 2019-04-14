

	.FUNCT	ALTAR-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"A close examination of the altar nearly sickens you. It fairly screams with the memory of the horrors it has seen since the coming of Krill. Its original white marble has been crusted with blood and desecrated by the minions of the evil Warlock."
?ELS5:	EQUAL?	HERE,TEMPLE \?ELS9
	EQUAL?	PRSA,V?CLIMB-ON,V?CLIMB-FOO,V?CLIMB-UP /?THN12
	EQUAL?	PRSA,V?WALK-TO \?ELS9
?THN12:	CALL	DO-WALK,P?UP
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?RUB,V?WALK-TO,V?CLIMB-ON /?THN16
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
?THN16:	PRINTR	"There is nothing you would like less than nearing the altar."


	.FUNCT	STATUE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It is an enormous statue of a loathsome creature, dark and vile, with dripping fangs and razor-sharp talons. It appears almost to be motioning with its outstretched talons for you to approach."
?ELS5:	EQUAL?	PRSA,V?RUB \FALSE
	PRINTR	"Your sensibilities are offended by the very idea."


	.FUNCT	GANG-OF-N-F
	EQUAL?	PRSA,V?GUNCHO \?ELS5
	PRINTR	"The majority of the mass of figures fades away into nothingness. Enough remain, however, to continue the service (or whatever it is)."
?ELS5:	EQUAL?	PRSA,V?FROTZ \?ELS9
	PRINTR	"A few select figures suddenly start to give off light, to the horror of the remaining ones, who rip them to shreds in an instant."
?ELS9:	EQUAL?	PRSA,V?VAXUM \?ELS13
	PRINTR	"Nothing seems to have happened, although a few of the figures seem to be chanting in a less guttural tone."
?ELS13:	EQUAL?	PRSA,V?ZIFMIA \?ELS17
	PRINTI	"Something appears to have snapped. The figures, who were so peacefully ignoring you, now seem to have taken a different, and less pleasant, tack."
	CRLF	
	CALL	TAKE-TO-TOWER
	RSTACK	
?ELS17:	EQUAL?	PRSA,V?CLEESH \FALSE
	PRINTR	"Some of the figures hunch down even more and scuttle off."


	.FUNCT	GUARDS-F
	EQUAL?	PRSA,V?VAXUM \?ELS5
	PRINTR	"The guards outside your cell cheer up a bit, upsetting a larger figure who could well be their boss. They are dismissed and replaced by other guards who don't seem to have the air of bonhomie shared by the others."
?ELS5:	EQUAL?	PRSA,V?CLEESH \?ELS9
	PRINTR	"A couple of the guards turn into newts, running this way and that. They are quickly replaced, however, by others. Perhaps turning into a newt is a commonplace around these parts."
?ELS9:	EQUAL?	PRSA,V?GUNCHO \?ELS13
	PRINTR	"A few guards disappear, seeming to vanish with distance while still standing in front of you. They are replaced quite quickly and efficiently by others. To judge by the reaction to your show of magical prowess, you would think these things happen every day."
?ELS13:	EQUAL?	PRSA,V?ZIFMIA \?ELS17
	PRINTI	"Oh, no. You've done it now. The guards approach, and they don't look very pleased."
	CRLF	
	CALL	QUEUE,I-TAKE-TO-ALTAR,1
	RSTACK	
?ELS17:	EQUAL?	PRSA,V?EXAMINE \?ELS21
	PRINTR	"They are hunched and hairy shapes, but more detail cannot be discerned."
?ELS21:	EQUAL?	PRSA,V?MUNG,V?ATTACK,V?KILL \?ELS25
	PRINTR	"You can't reach them from in here, and you wouldn't have a prayer even if you could."
?ELS25:	EQUAL?	PRSA,V?LISTEN \?ELS29
	PRINTR	"The guards make low, grumbling sounds that could pass for speech, but it is incomprehensible to you."
?ELS29:	EQUAL?	PRSA,V?HELLO,V?TELL \?ELS33
	PRINTR	"They go right on ignoring you. They don't seem to be much on conversation, although from time to time they grumble in an unsettling sort of way."
?ELS33:	ZERO?	GUARDS-HEARD \?ELS37
	EQUAL?	PRSA,V?NITFOL \?ELS37
	SET	'GUARDS-HEARD,TRUE-VALUE
	PRINTR	"The guards are having a delightful conversation, after a fashion:
Guard 1: ""Brgh! Last night, good bloodbath!""
Guard 2: ""Yes. Quite. Best in weeks. Have you seen the new sacrifice?""
Guard 1: ""Brggh! No! Just get here.""
Guard 2: ""It's a scrawny one. Not too much meat.""
Guard 1: ""Brrrgh! No meat! Not had good meal in many days!""
Guard 2: ""Perhaps tonight...""
Voice: ""Stop your yapping, both of you!""
The yapping stops abruptly."
?ELS37:	EQUAL?	PRSA,V?NITFOL \FALSE
	PRINTR	"The guards aren't speaking much."


	.FUNCT	TOWER-DOOR-F
	EQUAL?	PRSA,V?OPEN,V?UNLOCK \?ELS5
	ZERO?	LOCKED-IN-TOWER /?ELS5
	PRINTI	"The door is locked from the outside."
	ZERO?	PROTECTED-FROM-EVIL \?CND10
	PRINTI	" even if you could open it, the guards would undoubtedly return you with little difficulty"
?CND10:	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?KNOCK \?ELS18
	PRINTR	"It would only get the attention of the guards."
?ELS18:	EQUAL?	PRSA,V?REZROV \FALSE
	PRINTI	"The locked cell door opens with a powerful snap! Unfortunately, the guards seem to have heard the snap and approach!"
	CRLF	
	FSET	PRSO,OPENBIT
	SET	'LOCKED-IN-TOWER,FALSE-VALUE
	CALL	QUEUE,I-TAKE-TO-ALTAR,1
	RTRUE	


	.FUNCT	TOWER-S-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	SACRIFICED? /?ELS8
	PRINTI	"This prison cell is similar to the one in which you were held captive prior to your sacrifice."
	JUMP	?CND6
?ELS8:	PRINTI	"This is a small prison cell in the south tower of the temple."
?CND6:	PRINTI	" A window in the cell door looks out on the temple itself."
	CRLF	
	EQUAL?	ANYTHING-TAKEN,SCROLLS-TAKEN /TRUE
	GRTR?	ANYTHING-TAKEN,0 \TRUE
	GRTR?	SCROLLS-TAKEN,0 \TRUE
	PRINTR	"The guards must have brought your possessions here, but something is definitely missing!"


	.FUNCT	CELL-PSEUDO
	EQUAL?	PRSA,V?ESCAPE \?ELS5
	ZERO?	LOCKED-IN-TOWER /?ELS5
	PRINTR	"That poses a difficult problem. There's only one way out, and that would mean tackling a few hundred unpleasant creatures."
?ELS5:	EQUAL?	PRSA,V?DROP \?ELS11
	EQUAL?	HERE,TOWER-S \?ELS16
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS16:	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS11:	EQUAL?	PRSA,V?OPEN \?ELS20
	EQUAL?	HERE,TOWER-S \?ELS23
	CALL	PERFORM,V?OPEN,TOWER-S-DOOR
	RTRUE	
?ELS23:	CALL	PERFORM,V?OPEN,TOWER-N-DOOR
	RTRUE	
?ELS20:	EQUAL?	PRSA,V?SEARCH \FALSE
	CALL	PERFORM,V?LOOK
	RTRUE	


	.FUNCT	TEMPLE-F,RARG
	EQUAL?	RARG,M-END \FALSE
	IN?	PLAYER,TEMPLE \FALSE
	ZERO?	PROTECTED-FROM-EVIL \FALSE
	ZERO?	LETTER-OF-TRANSIT \FALSE
	CRLF	
	CALL	TAKE-TO-TOWER
	RSTACK	


	.FUNCT	TAKE-TO-TOWER
	SET	'LOCKED-IN-TOWER,TRUE-VALUE
	SET	'WINNER,PLAYER
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'ADVENTURER-CHARMED,FALSE-VALUE
	CALL	QUEUE,I-TURTLE,0
	PRINTI	"A low noise begins behind you, and you turn to see hundreds of hunched and hairy shapes. A guttural chant issues from their throats. Near you stands a figure draped in a robe of deepest black, brandishing a vicious dagger. The chant grows louder as the robed figure approaches the altar. As the shapes grab you, the figure in black speaks: ""Take the victim to the tower. I shall prepare for the sacrifice!"" The figures, whose form you can barely guess, take you from here through the northern door and into a prison cell. They "
	CALL	BLT,PLAYER,TOWER-S >ANYTHING-TAKEN
	ZERO?	ANYTHING-TAKEN /?CND3
	PRINTI	"take your possessions from you and "
?CND3:	PRINTI	"close the door with a crash!"
	CRLF	
	CRLF	
	SET	'SCROLLS-TAKEN,0
	CALL	GOTO,TOWER-N
	IN?	DISPEL-SCROLL,TOWER-S \?CND10
	REMOVE	DISPEL-SCROLL
	SET	'SCROLLS-TAKEN,1
?CND10:	IN?	BANISH-SCROLL,TOWER-S \?CND13
	REMOVE	BANISH-SCROLL
	INC	'SCROLLS-TAKEN
?CND13:	CALL	QUEUE,I-TAKE-TO-ALTAR,4
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-TAKE-TO-ALTAR
	ZERO?	PROTECTED-FROM-EVIL /?CND1
	PRINTR	"A gang of hunched and hairy shapes appear, look around cursorily, and then depart."
?CND1:	CRLF	
	PRINTI	"A host of hunched and hairy shapes appear through the window. The cell door opens and you are marched solemnly to the temple and, from there, up the steps to the altar. The large, black figure approaches menacingly. He reaches into his cloak and pulls out a "
	ZERO?	DAGGER-SEEN /?ELS11
	PRINTI	"blood-drenched scimitar"
	JUMP	?CND9
?ELS11:	PRINTI	"great, glowing dagger"
?CND9:	PRINTI	". He pulls you onto the altar, and with a murmur of approval from the throng, he plunges the blade into your heart!"
	CRLF	
	SET	'SACRIFICED?,TRUE-VALUE
	EQUAL?	DEATH-CHEATED,ME /?ELS25
	SET	'WINNER,PLAYER
	CALL	JIGS-UP,FALSE-VALUE,FALSE-VALUE
	RSTACK	
?ELS25:	SET	'LOCKED-IN-TOWER,FALSE-VALUE
	CRLF	
	PRINTI	"You feel yourself filled with a strange warmth as your eyes slowly open. You are lying on the altar"
	ZERO?	DAGGER-SEEN \?CND30
	PRINTI	", a glowing dagger in your chest"
?CND30:	PRINTI	". You are in no pain, however. The large figure is gone, but the throng of shapes, taking no notice of your movement, is chanting in the temple below."
	ZERO?	DAGGER-SEEN \?CND37
	PRINTI	" You slowly remove the dagger from your chest, but you are not harmed. The blade shines faintly in the light of the flickering torches."
?CND37:	CRLF	
	CRLF	
	ADD	SCORE,TEMPLE-POINT >SCORE
	SET	'TEMPLE-POINT,0
	ZERO?	DAGGER-SEEN \?CND42
	SET	'DAGGER-SEEN,TRUE-VALUE
	MOVE	MAGIC-KNIFE,WINNER
?CND42:	CALL	QUEUE,I-LETTER-OF-TRANSIT,10
	PUT	STACK,0,1
	SET	'LETTER-OF-TRANSIT,TRUE-VALUE
	CALL	GOTO,ALTAR
	RSTACK	


	.FUNCT	I-LETTER-OF-TRANSIT
	EQUAL?	HERE,TEMPLE \?ELS3
	CALL	QUEUE,I-LETTER-OF-TRANSIT,3
	RFALSE	
?ELS3:	SET	'LETTER-OF-TRANSIT,FALSE-VALUE
	RFALSE	

	.ENDI
