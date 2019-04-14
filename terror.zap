

	.FUNCT	TERROR-F
	EQUAL?	PRSA,V?ZIFMIA \?ELS5
	PRINTR	"As you cast the zifmia spell, you are overpowered with such a sense of malice that you cannot continue. All in all, a good thing probably."
?ELS5:	EQUAL?	PRSA,V?VAXUM \?ELS9
	PRINTR	"The terror may be friendlier, but with friends like that...."
?ELS9:	EQUAL?	PRSA,V?GUNCHO \FALSE
	REMOVE	TERROR
	PRINTR	"The room fills with a horrible noise, darkens to pitch blackness, and then lightens. The weight of fear lifts."


	.FUNCT	TMAP-F
	EQUAL?	PRSA,V?KULCAD \?ELS5
	PRINTI	"At once, a maze of lines forms, connecting all of the spots on the map. Suddenly, the world becomes still and cold."
	CRLF	
	CRLF	
	CALL	END-OF-WORLD
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?PUT,V?CLOSE,V?OPEN \?ELS9
	PRINTR	"You can't do that."
?ELS9:	EQUAL?	PRSA,V?DRAW-ON \?ELS13
	IN?	PENCIL,WINNER \?ELS18
	CALL	WRITE-HINT
	RTRUE	
?ELS18:	PRINTR	"You have nothing to draw with."
?ELS13:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE,V?READ \FALSE
	PRINTI	"The map consists of a drawing with nine points, each represented by a strange character, with interconnecting thin pencil lines. Using your native alphabet, it looks like this:"
	CRLF	
	CALL	DRAW-TMAZE
	RSTACK	


	.FUNCT	PENCIL-F
	EQUAL?	PRSA,V?KULCAD \?ELS5
	PRINTI	"As the pencil dissolves into nothingness, everything becomes still and cold."
	CRLF	
	CRLF	
	CALL	END-OF-WORLD
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The pencil is very old and covered with finely inlaid runes. The point is "
	GET	PENCIL-TBL,PENCIL-COUNT
	PRINT	STACK
	PRINTI	" and the attached eraser is "
	GET	ERASER-TBL,ERASER-COUNT
	PRINT	STACK
	PRINTR	"."


	.FUNCT	BLACK-PASSAGE-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The passages are perfectly round and black; the walls seem to be made of carbon."


	.FUNCT	TMAZE-F,RARG,TBL,NEX=0,FLG=0,OFFS=0,PLU=0,?TMP1
	IN?	BANISH-SCROLL,WINNER \?CND1
	EQUAL?	HERE,T-A \?CND1
	ZERO?	TERROR-TRAPPED /?CND1
	GRTR?	TERROR-POINT,0 \?CND1
	PRINTI	"You hear a horrible anguished scream through the walls of the cavern as the terror realizes that it is trapped and its scroll of power stolen!"
	CRLF	
	CRLF	
	ADD	SCORE,TERROR-POINT >SCORE
	SET	'TERROR-POINT,0
?CND1:	EQUAL?	RARG,M-LOOK \?ELS12
	PRINTI	"This is a peculiar room, whose cream-colored walls are thin and translucent."
	CRLF	
	GETP	HERE,P?TMAZE >TBL
?PRG15:	GET	TBL,OFFS
	EQUAL?	STACK,-1 \?ELS19
	JUMP	?REP16
?ELS19:	ADD	OFFS,1
	GET	TBL,STACK
	EQUAL?	STACK,1 \?CND17
	INC	'NEX
?CND17:	ADD	OFFS,2 >OFFS
	JUMP	?PRG15
?REP16:	ZERO?	NEX \?ELS24
	PRINTR	"There is not a single exit from this place."
?ELS24:	EQUAL?	NEX,1 \?ELS28
	PRINTI	"An exit is"
	JUMP	?CND22
?ELS28:	SET	'PLU,TRUE-VALUE
	PRINTI	"Passages go"
?CND22:	PRINTI	" to the "
	SET	'OFFS,0
?PRG37:	GET	TBL,OFFS
	EQUAL?	STACK,-1 \?ELS41
	JUMP	?REP38
?ELS41:	ADD	OFFS,1
	GET	TBL,STACK
	EQUAL?	STACK,1 \?CND39
	DIV	OFFS,2
	GET	TMAZE-DIRS,STACK
	PRINT	STACK
	GRTR?	NEX,2 \?ELS48
	SET	'FLG,TRUE-VALUE
	PRINTI	", "
	JUMP	?CND46
?ELS48:	EQUAL?	NEX,2 \?CND46
	ZERO?	FLG /?CND53
	PRINTI	","
?CND53:	PRINTI	" and "
?CND46:	DEC	'NEX
?CND39:	ADD	OFFS,2 >OFFS
	JUMP	?PRG37
?REP38:	PRINTI	" and "
	ZERO?	PLU /?ELS65
	PRINTI	"they are"
	JUMP	?CND63
?ELS65:	PRINTI	"it is"
?CND63:	PRINTR	" very strange indeed, perfectly round and black as pitch."
?ELS12:	EQUAL?	RARG,M-BEG \FALSE
	IN?	TERROR,HERE \?ELS81
	EQUAL?	PRSA,V?WALK \FALSE
	PRINTR	"Your feet are leaden with fear, and cold sweat runs down your back as you make your way to the door, but you make no progress. Your mind tells you you are running, but you aren't getting anywhere."
?ELS81:	EQUAL?	PRSA,V?WALK \FALSE
	EQUAL?	HERE,T-A \?ELS95
	EQUAL?	PRSO,P?UP \?ELS95
	CALL	GOTO,DUNGEON
	RTRUE	
?ELS95:	GRTR?	PRSO,P?UP \?ELS99
	GETP	HERE,P?TMAZE >TBL
	SUB	PRSO,P?UP
	MUL	STACK,2
	SUB	STACK,1 >OFFS
	GET	TBL,OFFS
	EQUAL?	STACK,1 \?ELS99
	SUB	OFFS,1
	GET	TBL,STACK
	CALL	GOTO,STACK
	IN?	TERROR,HERE \?ELS104
	PRINTR	"An evil presence pervades the room, its source unseen. Fear seeps into your mind, like fog. You look fearfully around. There is something horrible here."
?ELS104:	LOC	TERROR
	CALL	CONNECTED?,HERE,STACK
	ZERO?	STACK /TRUE
	PRINTR	"You sense that near this place an evil presence lurks. It seems close by and is moving."
?ELS99:	PRINTR	"You can't go that way."


	.FUNCT	END-OF-WORLD
	PRINTI	"You suddenly feel weak and your knees buckle. Just as you collapse to the ground, you find yourself in the presence of the Circle. They seem tense and frightened and ask desperately about your recent doings. As you tell your tale of the map and pencil, they recoil in horror. ""The Terror is released!"" cries one. Belboz sinks into his throne. ""We are doomed!"" he gasps. One by one, the wizards flee to prepare a hopeless defense."
	CRLF	
	SET	'SCORE,-10
	CALL	FINISH
	RSTACK	


	.FUNCT	DRAW-TMAZE
	CALL	FIXED-FONT-ON
	CRLF	
	PRINTI	"B"
	CALL	ECN,T-A,T-H
	PRINTI	"J"
	CRLF	
	CALL	CN,T-A,T-SOUTH
	CALL	CN,T-A,T-SE
	PRINTI	"     "
	CALL	CN,T-E,T-SW
	CALL	CN,T-E,T-SOUTH
	CALL	CN,T-E,T-SE
	CRLF	
	CALL	CN,T-A,T-SOUTH
	PRINTI	" "
	CALL	CN,T-A,T-SE
	PRINTI	"   "
	CALL	CN,T-E,T-SW
	PRINTI	" "
	CALL	CN,T-E,T-SOUTH
	PRINTI	" "
	CALL	CN,T-E,T-SE
	CRLF	
	CALL	CN,T-A,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-A,T-SE
	PRINTI	" "
	CALL	CN,T-E,T-SW
	PRINTI	"  "
	CALL	CN,T-E,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-E,T-SE
	CRLF	
	CALL	CN,T-A,T-SOUTH
	PRINTI	"   K"
	CALL	ECN,T-C,T-E
	PRINTI	"V"
	CRLF	
	CALL	CN,T-A,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-C,T-SW
	CALL	CN,T-C,T-SOUTH
	CALL	CN,T-C,T-SE
	PRINTI	"  "
	CALL	CN,T-E,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-G,T-SW
	CALL	CN,T-G,T-SOUTH
	CALL	CN,T-G,T-SE
	CRLF	
	CALL	CN,T-A,T-SOUTH
	PRINTI	" "
	CALL	CN,T-C,T-SW
	PRINTI	" "
	CALL	CN,T-C,T-SOUTH
	PRINTI	" "
	CALL	CN,T-C,T-SE
	PRINTI	" "
	CALL	CN,T-E,T-SOUTH
	PRINTI	" "
	CALL	CN,T-G,T-SW
	PRINTI	" "
	CALL	CN,T-G,T-SOUTH
	PRINTI	" "
	CALL	CN,T-G,T-SE
	CRLF	
	CALL	CN,T-A,T-SOUTH
	CALL	CN,T-C,T-SW
	PRINTI	"  "
	CALL	CN,T-C,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-C,T-SE
	CALL	CN,T-E,T-SOUTH
	CALL	CN,T-G,T-SW
	PRINTI	"  "
	CALL	CN,T-G,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-G,T-SE
	CRLF	
	PRINTI	"R"
	CALL	ECN,T-B,T-C
	PRINTI	"M"
	CALL	ECN,T-F,T-G
	PRINTI	"F"
	CRLF	
	PRINTI	" "
	CALL	CN,T-B,T-SE
	PRINTI	"  "
	CALL	CN,T-C,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-F,T-SW
	PRINTI	" "
	CALL	CN,T-F,T-SE
	PRINTI	"  "
	CALL	CN,T-G,T-SOUTH
	PRINTI	"  "
	CALL	CN,T-H,T-SW
	CRLF	
	PRINTI	"  "
	CALL	CN,T-B,T-SE
	PRINTI	" "
	CALL	CN,T-C,T-SOUTH
	PRINTI	" "
	CALL	CN,T-F,T-SW
	PRINTI	"   "
	CALL	CN,T-F,T-SE
	PRINTI	" "
	CALL	CN,T-G,T-SOUTH
	PRINTI	" "
	CALL	CN,T-H,T-SW
	CRLF	
	PRINTI	"   "
	CALL	CN,T-B,T-SE
	CALL	CN,T-C,T-SOUTH
	CALL	CN,T-F,T-SW
	PRINTI	"     "
	CALL	CN,T-F,T-SE
	CALL	CN,T-G,T-SOUTH
	CALL	CN,T-H,T-SW
	CRLF	
	PRINTI	"    H"
	CALL	ECN,T-D,T-H
	PRINTI	"P"
	CRLF	
	CRLF	
	CALL	FIXED-FONT-OFF
	RTRUE	


	.FUNCT	FIXED-FONT-ON
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	FIXED-FONT-OFF
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	CN,L,DIR
	GETP	L,P?TMAZE
	GET	STACK,DIR
	ZERO?	STACK /?ELS5
	GET	T-DIR-TABLE,DIR
	PRINT	STACK
	RTRUE	
?ELS5:	PRINTI	" "
	RTRUE	


	.FUNCT	ECN,L,DN,FLG=0
	GETP	L,P?TMAZE
	GET	STACK,T-EAST
	ZERO?	STACK /?ELS3
	SET	'FLG,TRUE-VALUE
	PRINTI	"---"
	JUMP	?CND1
?ELS3:	PRINTI	"   "
?CND1:	GETP	DN,P?TMAZE
	GET	STACK,T-SOUTH
	ZERO?	STACK /?ELS12
	ZERO?	FLG /?ELS15
	PRINTI	"+"
	JUMP	?CND10
?ELS15:	PRINTI	"!"
	JUMP	?CND10
?ELS12:	ZERO?	FLG /?ELS24
	PRINTI	"-"
	JUMP	?CND10
?ELS24:	PRINTI	" "
?CND10:	ZERO?	FLG /?ELS36
	PRINTI	"---"
	RTRUE	
?ELS36:	PRINTI	"   "
	RTRUE	


	.FUNCT	CONNECT,RM1,RM2,FLIP=0,TBL,RMX
	GETP	RM1,P?TMAZE >TBL
?PRG1:	GET	TBL,0 >RMX
	EQUAL?	RMX,-1 \?ELS5
	PRINTR	"The pencil doesn't seem to allow that line to be drawn."
?ELS5:	EQUAL?	RMX,RM2 \?CND3
	GET	TBL,1
	ZERO?	STACK \?ELS12
	ZERO?	FLIP \?CND13
	CALL	CONNECT,RM2,RM1,TRUE-VALUE
	DEC	'PENCIL-COUNT
	PRINTI	"A thin line now connects the two spots on the map, but the pencil point is "
	GET	PENCIL-TBL,PENCIL-COUNT
	PRINT	STACK
	PRINTI	"."
	CRLF	
	EQUAL?	HERE,RM1,RM2 \?CND13
	CALL	DESCRIBE-NEW-EXIT,RM1,RM2
?CND13:	PUT	TBL,1,1
	LOC	TERROR
	ZERO?	STACK /TRUE
	LOC	TERROR
	CALL	TWALK,STACK
	ZERO?	STACK /TRUE
	SET	'TERROR-TRAPPED,FALSE-VALUE
	CALL	QUEUE,I-TERROR,-1
	PUT	STACK,0,1
	RTRUE	
?ELS12:	PRINTR	"There is already a line connecting those spots."
?CND3:	ADD	TBL,4 >TBL
	JUMP	?PRG1


	.FUNCT	DISCONNECT,RM1,RM2,FLIP=0,TBL,RMX
	GETP	RM1,P?TMAZE >TBL
?PRG1:	GET	TBL,0 >RMX
	EQUAL?	RMX,-1 \?ELS5
	PRINTR	"Those two spots aren't connected on the map."
?ELS5:	EQUAL?	RMX,RM2 \?CND3
	GET	TBL,1
	ZERO?	STACK \?ELS12
	PRINTR	"Those two spots aren't connected on the map."
?ELS12:	ZERO?	FLIP \?CND17
	CALL	DISCONNECT,RM2,RM1,TRUE-VALUE
	DEC	'ERASER-COUNT
	PRINTI	"The line between the two spots is erased, leaving the eraser "
	GET	ERASER-TBL,ERASER-COUNT
	PRINT	STACK
	PRINTI	"."
	CRLF	
	EQUAL?	HERE,RM1,RM2 \?CND17
	CALL	DESCRIBE-NEW-EXIT,RM1,RM2,FALSE-VALUE
?CND17:	PUT	TBL,1,0
	RTRUE	
?CND3:	ADD	TBL,4 >TBL
	JUMP	?PRG1


	.FUNCT	DESCRIBE-NEW-EXIT,RM1,RM2,MAKE?=1,TMP,TBL,OFFS=0
	EQUAL?	RM2,HERE \?CND1
	SET	'TMP,RM1
	SET	'RM1,RM2
	SET	'RM2,TMP
?CND1:	GETP	RM1,P?TMAZE >TBL
?PRG4:	GET	TBL,OFFS >TMP
	EQUAL?	TMP,RM2 \?ELS8
	JUMP	?REP5
?ELS8:	EQUAL?	TMP,-1 \?ELS10
	PRINTI	"*ERROR* BAD-EXIT DESCRIBE-NEW-EXIT"
	CRLF	
	JUMP	?REP5
?ELS10:	ADD	OFFS,2 >OFFS
	JUMP	?PRG4
?REP5:	PRINTI	"Suddenly, the "
	ZERO?	MAKE? /?ELS19
	PRINTI	"wall"
	JUMP	?CND17
?ELS19:	PRINTI	"black passage"
?CND17:	PRINTI	" to the "
	DIV	OFFS,2
	GET	TMAZE-DIRS,STACK
	PRINT	STACK
	ZERO?	MAKE? /?ELS33
	PRINTI	" opens to form a perfectly round and black passage"
	JUMP	?CND31
?ELS33:	PRINTI	" closes off"
?CND31:	PRINTR	"!"


	.FUNCT	CONNECTED?,RM1,RM2,TBL,RMX
	GETP	RM1,P?TMAZE >TBL
	ZERO?	TBL /FALSE
?PRG4:	GET	TBL,0 >RMX
	EQUAL?	RMX,-1 /FALSE
	EQUAL?	RMX,RM2 \?CND6
	GET	TBL,1
	ZERO?	STACK \TRUE
	RFALSE	
?CND6:	ADD	TBL,4 >TBL
	JUMP	?PRG4


	.FUNCT	I-TERROR,RM,NRM,FLG=0
	ZERO?	TERROR-TRAPPED /?ELS5
	LOC	TERROR >RM
	CALL	CONNECTED?,HERE,RM
	ZERO?	STACK /FALSE
	MOVE	TERROR,HERE
	PRINT	TERROR-ARRIVES
	CRLF	
	RTRUE	
?ELS5:	LOC	TERROR >RM
	CALL	TWALK,RM
	ZERO?	STACK /?ELS15
	SET	'TERROR-TRAPPED,FALSE-VALUE
	SET	'TWAIT,0
	GET	PATH-TBL,2
	GET	TMAZE-ROOMS,STACK >NRM
	MOVE	TERROR,NRM
	EQUAL?	HERE,NRM \?ELS18
	PRINT	TERROR-ARRIVES
	CRLF	
	SET	'FLG,TRUE-VALUE
	JUMP	?CND16
?ELS18:	CALL	CONNECTED?,HERE,NRM
	ZERO?	STACK /?ELS22
	PRINTI	"Somewhere near, an evil presence lurks, probing your mind. It seems to be moving quickly."
	CRLF	
	SET	'FLG,TRUE-VALUE
	JUMP	?CND16
?ELS22:	CALL	CONNECTED?,HERE,RM
	ZERO?	STACK /?CND16
	PRINTI	"You can no longer sense the evil presence nearby."
	CRLF	
	SET	'FLG,TRUE-VALUE
?CND16:	ZERO?	TERROR-MOVED \?CND29
	SET	'TERROR-MOVED,TRUE-VALUE
	INC	'LOSSAGE
	SET	'FLG,TRUE-VALUE
	PRINTI	"You feel that two powerful, evil forces are searching each other out. As they meet, the air lightens. Belboz appears before you. ""Something has disturbed the ancient Terror. Krill himself knows this and will try to use it to his purposes. Already, they may have joined together. You must not allow the Terror to escape, or we are all doomed!"" He fades into the gloom."
	CRLF	
?CND29:	EQUAL?	NRM,T-A \?CND34
	CALL	END-OF-WORLD
	EQUAL?	HERE,T-A \?ELS39
	SET	'FLG,TRUE-VALUE
	PRINTI	"The presence seems to grow stronger each passing second, beating you down with its awesome power."
	CRLF	
	RETURN	FLG
?ELS39:	SET	'FLG,TRUE-VALUE
	PRINTI	"At once, a strange and horrible feeling wells up inside of you. An unseen yet awesomely powerful force, exuding pure evil, seems to fill the very chamber."
	CRLF	
?CND34:	RETURN	FLG
?ELS15:	CALL	TNULL-F
	ZERO?	STACK \TRUE
	IGRTR?	'TWAIT,6 /TRUE
	CALL	TWALK1 >RM
	ZERO?	RM /TRUE
	LOC	TERROR >NRM
	EQUAL?	NRM,T-I /TRUE
	CALL	CONNECTED?,NRM,T-I
	ZERO?	STACK /?ELS58
	MOVE	TERROR,T-I
	JUMP	?CND54
?ELS58:	CALL	CONNECTED?,NRM,T-F
	ZERO?	STACK /?CND54
	MOVE	TERROR,T-F
?CND54:	IN?	TERROR,HERE \?ELS63
	PRINT	TERROR-ARRIVES
	CRLF	
	RTRUE	
?ELS63:	PRINTR	"From somewhere nearby, an unseen force probes you, and you are gripped by a sickening feeling."


	.FUNCT	TNULL-F
	SET	'TERROR-TRAPPED,TRUE-VALUE
	RFALSE	


	.FUNCT	TWALK,RM
	SET	'TWALK-LEVEL,0
	SET	'TTRIES,0
	SET	'PSTART,RM
	CALL	PATH-OUT?,RM
	RSTACK	


	.FUNCT	TWALK1,TBL,RM,NRM,OFFS=1,CNT
	LOC	TERROR >RM
	GETP	RM,P?CAPACITY
	GET	TWALK-PATHS,STACK >TBL
	GET	TBL,0 >CNT
?PRG1:	GRTR?	OFFS,CNT /FALSE
	GET	TBL,OFFS
	GET	TMAZE-ROOMS,STACK >NRM
	CALL	CONNECTED?,RM,NRM
	ZERO?	STACK /?CND3
	RETURN	NRM
?CND3:	INC	'OFFS
	JUMP	?PRG1


	.FUNCT	PATH-OUT?,RM,OFFS=1,TBL,CNT=0,NRM
	INC	'TTRIES
	INC	'TWALK-LEVEL
	GETP	RM,P?CAPACITY
	PUT	PATH-TBL,TWALK-LEVEL,STACK
	EQUAL?	RM,T-A \?ELS3
	DEC	'TWALK-LEVEL
	RTRUE	
?ELS3:	GRTR?	TWALK-LEVEL,TWALK-MAX \?CND1
	DEC	'TWALK-LEVEL
	RFALSE	
?CND1:	GETP	RM,P?CAPACITY
	GET	TWALK-PATHS,STACK >TBL
	GET	TBL,0 >CNT
	ZERO?	CNT \?CND6
	DEC	'TWALK-LEVEL
	RTRUE	
?CND6:	
?PRG9:	GRTR?	OFFS,CNT \?ELS13
	DEC	'TWALK-LEVEL
	RFALSE	
?ELS13:	GET	TBL,OFFS
	GET	TMAZE-ROOMS,STACK >NRM
	CALL	CONNECTED?,RM,NRM
	ZERO?	STACK /?CND11
	EQUAL?	NRM,PSTART /?CND11
	CALL	PATH-OUT?,NRM
	ZERO?	STACK /?CND11
	DEC	'TWALK-LEVEL
	RTRUE	
?CND11:	INC	'OFFS
	JUMP	?PRG9


	.FUNCT	LEGEND-BOOK-F
	EQUAL?	PRSA,V?CLOSE \?ELS5
	FSET?	PRSO,OPENBIT \?ELS5
	FCLEAR	PRSO,OPENBIT
	PRINTR	"Closed."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE,V?READ /?THN12
	EQUAL?	PRSA,V?OPEN \?ELS11
?THN12:	FSET	PRSO,OPENBIT
	PRINTR	"The first page of the book was the table of contents. Only two chapter names can be read: The Legend of the Unseen Terror and The Legend of the Great Implementers."
?ELS11:	EQUAL?	PRSA,V?TURN \FALSE
	PRINTR	"Rather than turning pages, why don't you simply read the legends."


	.FUNCT	LEGEND-TWO-F
	EQUAL?	PRSA,V?ZIFMIA \FALSE
	ZERO?	IMP-SEEN \FALSE
	SET	'IMP-SEEN,TRUE-VALUE
	PRINTR	"The implementers of the world, Marc Blank and Dave Lebling, appear before you, looking quite as confused as yourself. They speak:
Dave: ""What's happening here?""
Marc: ""Uh, I dunno. YOU wrote this code, not me.""
Dave: ""Hmm. Another day, another bug. Let's see here...""
They disappear a moment later.
Dave's voice: ""That should do it."""

	.ENDI
