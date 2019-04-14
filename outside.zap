

	.FUNCT	WEST-CASTLE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are outside the western entrance to the castle. To the east stands an iron gate which is "
	FSET?	IRON-GATE,OPENBIT \?ELS10
	PRINTI	"wide open"
	JUMP	?CND8
?ELS10:	PRINTI	"closed and chained"
?CND8:	PRINTR	". A winding road starts here and proceeds to the west."


	.FUNCT	UNDERGROWTH-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The undergrowth is thick. You would never get through it."
?ELS5:	EQUAL?	PRSA,V?MUNG,V?CUT \FALSE
	PRINTR	"You could spend a few days doing this without much progress."


	.FUNCT	PATH-SIGN-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
  - Shady Brook Trail -

    Old Lingolf House
        1000 feet
"
	CALL	FIXED-FONT-OFF
	RTRUE	


	.FUNCT	FOUNDATION-F
	EQUAL?	PRSA,V?THROUGH \?ELS5
	PRINTR	"No way."
?ELS5:	EQUAL?	PRSA,V?WHO \?ELS9
	PRINTR	"There's no way of knowing."
?ELS9:	EQUAL?	PRSA,V?LOOK-INSIDE,V?SEARCH \FALSE
	PRINTR	"There is nothing but stone there."


	.FUNCT	DISTANT-CASTLE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The castle is far to the east and flanked by dark towers. From this distance, not much detail can be discerned."
?ELS5:	EQUAL?	PRSA,V?WALK-TO \FALSE
	PRINTR	"There's no direct path from here, although roads lead there. Try specifying a compass direction in order to move around."


	.FUNCT	SHACK-OBJ-F
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,SHACK-ROOM \?ELS5
	CALL	GOTO,SHACK
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?DROP \FALSE
	EQUAL?	HERE,SHACK \FALSE
	CALL	GOTO,SHACK-ROOM
	RTRUE	


	.FUNCT	BATTERED-LANTERN-F
	EQUAL?	PRSA,V?ERASE-LINE \?ELS5
	PRINTR	"Aladdin you're not."
?ELS5:	EQUAL?	PRSA,V?LAMP-ON \?ELS9
	PRINTR	"The lamp seems to be broken, most likely beyond repair."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	PRINTR	"The lamp is made of brass and is old and battered. It doesn't seem likely that any use can be made of it."
?ELS13:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	FSET?	PRSO,ONBIT /FALSE
	PRINTR	"It isn't on!"


	.FUNCT	SHACK-STUFF
	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	PRINTR	"They are overturned and don't make good surfaces."


	.FUNCT	SHACK-OVEN-F
	EQUAL?	PRSA,V?LAMP-OFF,V?LAMP-ON \?ELS5
	PRINTR	"It's not working."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"Strangely, the oven is still slightly warm, as if it had been used recently."


	.FUNCT	BREAD-F,AMT,S
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"There's "
	GETP	BREAD,P?SIZE
	GET	BREAD-EXAMINES,STACK
	PRINT	STACK
	PRINTR	" left."
?ELS5:	EQUAL?	PRSA,V?EAT \?ELS9
	CALL	INT,I-HUNGER
	GET	STACK,C-TICK >S
	GRTR?	S,60 \?CND10
	PRINTR	"You aren't the least bit hungry."
?CND10:	GETP	BREAD,P?SIZE
	SUB	STACK,1 >AMT
	PUTP	BREAD,P?SIZE,AMT
	ADD	SCORE,EAT-POINT >SCORE
	SET	'EAT-POINT,0
	PRINTI	"Mmm. That tasted great! "
	GET	BREAD-AMTS,AMT
	PRINT	STACK
	CRLF	
	ZERO?	AMT \?CND19
	REMOVE	BREAD
?CND19:	ADD	S,47
	CALL	QUEUE,I-HUNGER,STACK
	SET	'HUNGER-COUNT,0
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?BURN \?ELS23
	EQUAL?	PRSI,ETERNAL-FLAME \?ELS23
	PRINTR	"Toast without jam? What a silly idea!"
?ELS23:	EQUAL?	PRSA,V?MUNG,V?CUT \FALSE
	EQUAL?	PRSI,MAGIC-KNIFE \FALSE
	PRINTR	"It seems silly to cut up your bread when it's more easily carried in one piece. Besides, you might get crumbs all over your spell book."


	.FUNCT	TREES-F
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \?ELS5
	PRINTR	"The trees are not suitable for climbing."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	HERE,RMUNGBIT \?ELS14
	PRINTR	"The trees are short and stunted and covered in a thick, grey ash. The roots themselves are blackened and foul-smelling."
?ELS14:	PRINTR	"The trees are mostly short and stunted."


	.FUNCT	HOVEL-F
	EQUAL?	HERE,VILLAGE \FALSE
	EQUAL?	PRSA,V?WALK-TO,V?THROUGH \FALSE
	CALL	DO-WALK,P?SOUTH
	RTRUE	


	.FUNCT	HOVEL-KLUDGE
	PRINTI	"It is dark and smoky in here, but this is a place of great disorder, and its odor is indescribable. A pile of rags sits near a small pot which is bubbling and steaming over a tiny fire. The pile of rags sports a gnarled hand which busies itself with the noisome stew. A closer look reveals a withered crone at the other end of the hand."
	CRLF	
	ZERO?	CRONE-MOVE \?ELS5
	CRLF	
	PRINTI	"The creature looks you over keenly and speaks: ""I should have thought they would send someone more ... more ..."" She laughs in an unsettling way. ""They've all left! A great storm is brewing in the east, my friend, and all have fled before it!"" She starts to chuckle. ""Take this and begone!"" With a wave of her hand, you find yourself reeling out of the door of the hovel, holding some sort of scroll in your hand."
	CRLF	
	MOVE	OPEN-SCROLL,WINNER
	SET	'CRONE-MOVE,MOVES
	RFALSE	
?ELS5:	SUB	MOVES,CRONE-MOVE
	LESS?	STACK,20 \?ELS9
	PRINTI	"As you enter the crone's hovel, she booms at you: ""Are you here again? What a wizard!"" Her emphasis on the word ""wizard"" is filled with derision. ""Make a small effort, would you, to make your Circle proud of you?"" The same horrible emphasis on ""proud"" fills you with revulsion. ""Go!"" You find yourself back in the village."
	CRLF	
	RFALSE	
?ELS9:	SET	'CRONE-MOVE,MOVES
	PRINTI	"As you enter, the woman in rags wags her head slowly. ""You've returned, have you? You need help perhaps? Well, I've given you all the help in my meager store. You want more? Leave me!"" You find yourself in the village."
	CRLF	
	RFALSE	


	.FUNCT	GLOBAL-CRONE-F
	EQUAL?	PRSA,V?ZIFMIA \?ELS5
	PRINTR	"Slowly, the old woman, swathed in rags, appears before you. She seems to be staring through you and speaks slowly and sullenly: ""I thought I might see you again, my friend! I gave you all the aid that I can. The rest is up to you..."" She disappears."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINTR	"The crone was presumably the village wise woman and its last remaining inhabitant."
?ELS9:	PRINTR	"The crone isn't here."


	.FUNCT	LONG-ROAD-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are walking along the road. It wends its way through low hills, sparse forests, and occasional subsistence farms. To the west, things seem lighter and more pleasant. To the east they seem oppressive and dark. A worn sign sits beside the road here."
	EQUAL?	ROAD-LOC,ROAD-START \?CND8
	PRINTI	" The deserted village is to the east."
?CND8:	CRLF	
	RTRUE	


	.FUNCT	FARM-PSEUDO
	EQUAL?	PRSA,V?THROUGH,V?EXAMINE \FALSE
	PRINTR	"It's a poor, run-down farm, and not of interest."


	.FUNCT	LONG-ROAD-SIGN-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	SUB	ROAD-LOC,ROAD-START
	GRTR?	STACK,11 \?ELS10
	PRINTR	"The sign is too worn to be read."
?ELS10:	PRINTI	""""
	SUB	ROAD-LOC,ROAD-START
	GET	SIGN-TBL,STACK
	PRINT	STACK
	PRINTR	""""


	.FUNCT	LONG-ROAD-EXIT-F
	EQUAL?	ROAD-LOC,ROAD-START \?ELS5
	EQUAL?	PRSO,P?EAST \?ELS5
	RETURN	WEST-FORK
?ELS5:	FCLEAR	LONG-ROAD,TOUCHBIT
	CALL	ROAD-TO-TABLE,ROAD-LOC
	EQUAL?	PRSO,P?WEST \?ELS12
	INC	'ROAD-LOC
	JUMP	?CND10
?ELS12:	EQUAL?	PRSO,P?EAST \?CND10
	DEC	'ROAD-LOC
?CND10:	CALL	TABLE-TO-ROAD,ROAD-LOC
	RETURN	LONG-ROAD


	.FUNCT	ROAD-TO-TABLE,SLOC,TBL,CNT=0,F,N
	FIRST?	LONG-ROAD >F /?KLU21
?KLU21:	SET	'TBL,ROAD-TABLE
?PRG1:	ZERO?	F /TRUE
	NEXT?	F >N /?KLU22
?KLU22:	EQUAL?	F,WINNER \?ELS11
	JUMP	?CND9
?ELS11:	FSET?	F,TAKEBIT \?CND9
?PRG14:	GET	TBL,CNT
	ZERO?	STACK \?ELS18
	PUT	TBL,CNT,SLOC
	ADD	CNT,1
	PUT	TBL,STACK,F
	ADD	CNT,2 >CNT
	REMOVE	F
	JUMP	?CND9
?ELS18:	ADD	CNT,2 >CNT
	JUMP	?PRG14
?CND9:	SET	'F,N
	JUMP	?PRG1


	.FUNCT	TABLE-TO-ROAD,SLOC,TBL,CNT=0
	SET	'TBL,ROAD-TABLE
?PRG1:	LESS?	CNT,ROAD-TABLE-LENGTH \TRUE
	GET	TBL,CNT
	EQUAL?	STACK,SLOC \?CND3
	PUT	TBL,CNT,0
	ADD	CNT,1
	GET	TBL,STACK
	MOVE	STACK,LONG-ROAD
?CND3:	ADD	CNT,2 >CNT
	JUMP	?PRG1


	.FUNCT	ROAD-F
	EQUAL?	PRSA,V?TAKE,V?FOLLOW \?ELS5
	PRINTR	"You should supply a compass direction in which to follow the path."
?ELS5:	EQUAL?	PRSA,V?DROP \FALSE
	CALL	OUTSIDE?,HERE
	ZERO?	STACK /?ELS14
	PRINTR	"It's much safer to stay on the path, especially in these times."
?ELS14:	PRINTR	"You'll have to give a direction."


	.FUNCT	HILLS-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The hills are mostly low and shrouded in a fine mist-like haze. They stretch out mainly to the west."
?ELS5:	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	CALL	PERFORM,V?LEAVE,ROAD
	RTRUE	


	.FUNCT	MOUNTAIN-F
	EQUAL?	PRSA,V?LEAP \?ELS5
	EQUAL?	HERE,VISTA \?ELS5
	CALL	JIGS-UP,STR?343
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB-FOO \?ELS9
	EQUAL?	HERE,VISTA \?ELS14
	PRINTR	"You are here!"
?ELS14:	EQUAL?	HERE,VILLAGE,MOUNTAIN-TRAIL \?ELS18
	CALL	DO-WALK,P?UP
	RSTACK	
?ELS18:	PRINTR	"There's no way up the mountain from here."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The mountain is tall and proud, and its shining peak stands above the low-hanging clouds."


	.FUNCT	OUTSIDE?,RM
	FSET?	RM,LIGHTBIT \FALSE
	EQUAL?	RM,SHACK,INSIDE-GATE /FALSE
	EQUAL?	RM,PEBBLED-PATH,COURTYARD-1 /FALSE
	EQUAL?	RM,COURTYARD-2,COURTYARD-3,COURTYARD-4 /FALSE
	EQUAL?	RM,COURTYARD-5,COURTYARD-6,COURTYARD-7 /FALSE
	EQUAL?	RM,SHACK-ROOM,BEDROOM \TRUE
	RFALSE	


	.FUNCT	I-SCURRY
	RANDOM	20
	ADD	15,STACK
	CALL	QUEUE,I-SCURRY,STACK
	PUT	STACK,0,1
	RANDOM	100
	GRTR?	25,STACK \FALSE
	CALL	OUTSIDE?,HERE
	ZERO?	STACK /?ELS10
	LESS?	NIGHTFALL,70 \?ELS15
	RANDOM	100
	GRTR?	50,STACK \?ELS15
	PRINTR	"You hear noises in the brambles. Snorting noises are followed by loud crashing and finally a hideous squeal of triumph."
?ELS15:	PRINTR	"You hear a rustling in the brambles nearby, and you catch a glimpse of something small and furry as it scurries away."
?ELS10:	EQUAL?	HERE,PIT,REAL-STAIR,PURLOINED-ROOM /FALSE
	EQUAL?	HERE,WARLOCK-TOWER /FALSE
	GETP	HERE,P?TMAZE
	ZERO?	STACK \FALSE
	LOC	WINNER
	EQUAL?	STACK,DUNGEON,NORTH-CELL /?THN32
	LOC	WINNER
	EQUAL?	STACK,SECRET-PASSAGE \?ELS31
?THN32:	PRINTR	"You hear, almost beyond your hearing, the soft rattle of chains, and a cold wind blows over the back of your neck."
?ELS31:	GRTR?	TOD,NIGHTFALL \?ELS37
	CALL	PICK-ONE,NIGHT-GLIMPSES
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS37:	CALL	PICK-ONE,GLIMPSES
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	GLIMPSE-F
	GRTR?	MOVES,0 \?ELS5
	PRINTR	"You can't see that anymore."
?ELS5:	PRINTR	"You see no such thing."

	.ENDI
