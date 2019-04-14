

	.FUNCT	INSIDE-GATE-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	ZERO?	CASTLE-ENTER \?ELS5
	SET	'CASTLE-ENTER,TRUE-VALUE
	PRINTI	"As you pass through the gate, you feel that your mind is being probed. After a moment, it is released or, perhaps, discarded as uninteresting."
	CRLF	
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTR	"You are just inside what appears to be the main entrance to the castle. An iron gate, standing wide open, looms to the west. Through it, a narrow road can be seen winding through low, smoky hills. Before you, to the east, is a huge open courtyard. To the north and the south are archways leading to the interior of the castle."


	.FUNCT	IRON-GATE-F
	EQUAL?	PRSA,V?UNLOCK,V?OPEN \?ELS5
	PRINTR	"The gate is secure; it cannot be unlocked."
?ELS5:	EQUAL?	PRSA,V?CLOSE \?ELS9
	PRINTR	"It is too heavy to move."
?ELS9:	EQUAL?	PRSA,V?REZROV \FALSE
	ADD	SCORE,ENTRY-POINT >SCORE
	SET	'ENTRY-POINT,0
	PRINTI	"The chains of the iron gate fly into the air and vanish. The gate flies open and a blast of cold air fills your lungs."
	CRLF	
	FSET	IRON-GATE-CHAINS,INVISIBLE
	FSET	IRON-GATE,OPENBIT
	RTRUE	


	.FUNCT	ARCH-F
	EQUAL?	PRSA,V?THROUGH \FALSE
	EQUAL?	HERE,PEBBLED-PATH \?ELS10
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS10:	EQUAL?	HERE,INSIDE-GATE \?ELS12
	PRINTR	"You should specify a compass direction, since there are two archways."
?ELS12:	CALL	DO-WALK,P?NORTH
	RSTACK	


	.FUNCT	BED-F,RARG=0
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?WALK \?ELS10
	PRINTR	"You'll have to get up first. The bed is so comfy you would almost rather not."
?ELS10:	EQUAL?	PRSA,V?WEAR,V?CLIMB-ON,V?BOARD \?ELS14
	PRINTR	"You already are."
?ELS14:	EQUAL?	PRSA,V?PUSH,V?MOVE,V?TAKE /?THN21
	EQUAL?	PRSA,V?CLOSE,V?OPEN,V?RUB \FALSE
?THN21:	IN?	PRSO,WINNER /FALSE
	PRINTR	"You can't do that from your resting position."
?ELS5:	EQUAL?	RARG,M-END /FALSE
	EQUAL?	BED,PRSO,PRSI \FALSE
	EQUAL?	PRSA,V?WEAR,V?CLIMB-ON,V?BOARD \?ELS30
	MOVE	WINNER,BED
	SUB	MOVES,LAST-SLEEP
	LESS?	STACK,MOVES-PER-DAY \?ELS35
	PRINTR	"The bed is very comfortable and soft. In fact, you feel sort of sleepy just lying on it."
?ELS35:	PRINTI	"Lying on this soft bed puts you to sleep."
	CRLF	
	CALL	PERFORM,V?SLEEP
	RTRUE	
?ELS30:	EQUAL?	PRSA,V?WALK-TO \?ELS43
	CALL	PERFORM,V?BOARD,BED
	RTRUE	
?ELS43:	EQUAL?	PRSA,V?DROP,V?DISEMBARK \?ELS45
	IN?	WINNER,BED \?ELS45
	MOVE	WINNER,HERE
	PRINTR	"Ah, that was a comfortable bed! But you're now on your own feet again."
?ELS45:	EQUAL?	PRSA,V?EXAMINE \?ELS51
	EQUAL?	PRSO,BED \?ELS51
	PRINTR	"The feather bed looks as though it would be quite comfy to sleep on."
?ELS51:	EQUAL?	PRSA,V?SHAKE \FALSE
	EQUAL?	PRSO,BED \FALSE
	FIRST?	BEDPOST \FALSE
	PRINTR	"When you shake the bed, one of the bedposts rattles as though something were loose inside it."


	.FUNCT	BEDPOST-F
	EQUAL?	PRSA,V?SEARCH,V?EXAMINE \?ELS5
	FSET?	BEDPOST,OPENBIT \?ELS10
	PRINTR	"The bedpost is open."
?ELS10:	IN?	BEDPOST-BUTTON,BED \?ELS14
	PRINTR	"A careful examination reveals the outline of a small compartment, and near it an ornate carving which looks like a button. You could never have found it on your own."
?ELS14:	PRINTR	"A careful examination reveals a thin line which might well be the outline of a small compartment, but the mechanism for opening it is not discernable."
?ELS5:	EQUAL?	PRSA,V?OPEN \?ELS22
	PRINTR	"Maybe it can be opened, but it's unclear how."
?ELS22:	EQUAL?	PRSA,V?REZROV \?ELS26
	FSET	BEDPOST,OPENBIT
	IN?	CHARM-SCROLL,BEDPOST \?ELS31
	ADD	SCORE,CHARM-POINT >SCORE
	SET	'CHARM-POINT,0
	CALL	THIS-IS-IT,CHARM-SCROLL
	PRINT	POPS-OPEN
	CRLF	
	RTRUE	
?ELS31:	PRINTR	"The bedpost pops open."
?ELS26:	EQUAL?	PRSA,V?SHAKE \FALSE
	FIRST?	BEDPOST \FALSE
	PRINTR	"There is something rustling around inside the bedpost."


	.FUNCT	COMPARTMENT-F
	IN?	BEDPOST-BUTTON,BED /?ELS5
	EQUAL?	PRSA,V?SEARCH,V?EXAMINE \?ELS5
	PRINTR	"A very thin line indicates that a hidden compartment might be imbedded in the bedpost, but it's not clear how to open it."
?ELS5:	CALL	PERFORM,PRSA,BEDPOST
	RTRUE	


	.FUNCT	BEDPOST-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	FSET	BEDPOST,OPENBIT
	ADD	SCORE,CHARM-POINT >SCORE
	SET	'CHARM-POINT,0
	IN?	CHARM-SCROLL,BEDPOST \TRUE
	CALL	THIS-IS-IT,CHARM-SCROLL
	PRINT	POPS-OPEN
	CRLF	
	RTRUE	


	.FUNCT	CELL-F
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,DUNGEON \?ELS5
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?DROP \?ELS9
	EQUAL?	HERE,NORTH-CELL \?ELS9
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?SEARCH \FALSE
	EQUAL?	HERE,NORTH-CELL \FALSE
	CALL	PERFORM,V?LOOK
	RTRUE	


	.FUNCT	NORTH-CELL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a damp and unhealthy dungeon cell with writing on the walls. The rusty door of the cell is "
	FSET?	NORTH-CELL-DOOR,OPENBIT \?ELS10
	PRINTI	"open."
	JUMP	?CND8
?ELS10:	PRINTI	"closed."
?CND8:	ZERO?	NORTH-BLOCK-FLAG /?ELS19
	PRINTI	" A square block sits beside a passage in the eastern wall."
	JUMP	?CND17
?ELS19:	ZERO?	NORTH-BLOCK-FLAG \?CND17
	FSET?	NORTH-BLOCK,NDESCBIT /?CND17
	PRINTI	" A square block in the east wall seems to be loose."
?CND17:	CRLF	
	RTRUE	


	.FUNCT	CELL-DOOR-F
	EQUAL?	PRSA,V?OPEN \?ELS9
	FSET?	PRSO,OPENBIT \?THN6
?ELS9:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	PRSO,OPENBIT \FALSE
?THN6:	PRINTI	"The door is very rusty and reluctantly "
	FSET?	PRSO,OPENBIT \?ELS16
	FCLEAR	PRSO,OPENBIT
	PRINTI	"close"
	JUMP	?CND14
?ELS16:	FSET	PRSO,OPENBIT
	PRINTI	"open"
?CND14:	PRINTR	"s."


	.FUNCT	STONE-WALL-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTI	"The wall is covered with graffiti and scratchings marking time's passage."
	CRLF	
	EQUAL?	HERE,NORTH-CELL \TRUE
	ZERO?	NORTH-BLOCK-FLAG \TRUE
	FCLEAR	NORTH-BLOCK,NDESCBIT
	PRINTI	"You notice that the mortar holding a square block has been chipped away, and the block is loose."
	CRLF	
	RTRUE	


	.FUNCT	NORTH-BLOCK-F
	EQUAL?	PRSA,V?TAKE,V?MOVE \FALSE
	ZERO?	NORTH-BLOCK-FLAG \?ELS10
	SET	'NORTH-BLOCK-FLAG,TRUE-VALUE
	PRINTR	"You pull the block out of the crumbling wall, revealing a dark passage leading east."
?ELS10:	PRINTR	"It's too heavy."


	.FUNCT	SECRET-PASSAGE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a crudely carved secret passage. It appears to have been hollowed out by (perhaps) generations of prisoners."
	ZERO?	NORTH-BLOCK-FLAG /?ELS10
	PRINTI	" A passage leads west."
	JUMP	?CND8
?ELS10:	PRINTI	" A square block in the western wall seems to be loose."
?CND8:	PRINTR	" A short, crudely hewn passage leads up."


	.FUNCT	SOUTH-GATE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This interior courtyard stands at the southern entrance to the castle, where a small rusty gate "
	FSET?	RUSTY-GATE,OPENBIT \?ELS10
	PRINTI	"is standing open and slowly swaying in a gentle sea breeze"
	JUMP	?CND8
?ELS10:	PRINTI	"stands closed"
?CND8:	PRINTR	". Beyond the gate can be seen a small meadow and, beyond that, a white beach on a misty sea. Passages enter the castle proper to the north, east, and west."


	.FUNCT	BANQUET-STUFF-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN,V?REZROV /?THN8
	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE \FALSE
?THN8:	FSET?	PRSO,CONTBIT \FALSE
	FCLEAR	PRSO,CONTBIT
	CALL	PERFORM,PRSA,PRSO
	FSET	PRSO,CONTBIT
	RTRUE	


	.FUNCT	BANQUET-ILLUSION-F
	EQUAL?	PRSA,V?KULCAD \?ELS5
	REMOVE	BANQUET-ILLUSION
	PRINTR	"The festive banquet setting dissolves, leaving a large hall littered with broken benches."
?ELS5:	EQUAL?	PRSA,V?BOARD,V?CLIMB-ON \?ELS9
	EQUAL?	PRSO,BENCHES,BTABLES \?ELS9
	PRINTR	"It's not worth the bother."
?ELS9:	EQUAL?	PRSA,V?MOVE,V?TAKE \FALSE
	IN?	BANQUET-ILLUSION,HERE \?ELS20
	PRINTR	"They seem to be protected by some magic; you can't budge them."
?ELS20:	PRINTR	"You realize there is no point in that."


	.FUNCT	BANQUET-FOOD-F
	EQUAL?	PRSA,V?TAKE,V?EAT \?ELS5
	PRINTR	"The food is quite delicious, but somehow unsatisfying."
?ELS5:	CALL	BANQUET-ILLUSION-F
	RSTACK	


	.FUNCT	GUARD-WARNING-F,RARG,LP
	LOC	PLAYER >LP
	EQUAL?	RARG,M-LOOK \?ELS5
	EQUAL?	LP,BANQUET-HALL \?ELS8
	FSET?	BANQUET-HALL,RMUNGBIT \?ELS11
	REMOVE	BANQUET-ILLUSION
	PRINTI	"This desolate hall is nearly empty, save for a few long benches which are scattered throughout the room. The walls seem to be scorched, and everywhere are signs of decay. A sickening odor pervades the room, and wisps of acrid black smoke can be seen to the north. A wide passage leads south, and a small one opens to the east."
	CRLF	
	JUMP	?CND6
?ELS11:	IN?	BANQUET-ILLUSION,BANQUET-HALL \?ELS15
	PRINTI	"A banquet has been set here for hundreds. Long benches fill the room, each covered with finest linen and set with golden cutlery and glittering crystal. Luscious food weighs down each table, and candles light the room with a festive glow. The room can be entered by a north-south corridor and a small opening to the east, from which an odd, acrid smell issues."
	CRLF	
	JUMP	?CND6
?ELS15:	PRINTI	"This hall is completely empty, except for some long benches which are scattered throughout the room."
	CRLF	
	JUMP	?CND6
?ELS8:	EQUAL?	LP,LIBRARY \FALSE
	GETP	LP,P?LDESC
	PRINT	STACK
	CRLF	
?CND6:	IN?	GANG-OF-FOUR,LP /TRUE
	PRINTI	"To the "
	EQUAL?	LP,LIBRARY \?ELS35
	PRINTI	"south"
	JUMP	?CND33
?ELS35:	PRINTI	"north"
?CND33:	PRINTR	" you can hear the sound of a group of low, guttural voices."
?ELS5:	EQUAL?	RARG,M-BEG \?ELS45
	EQUAL?	WINNER,PLAYER \?ELS45
	EQUAL?	PRSA,V?WALK \?ELS45
	ZERO?	PROTECTED-FROM-EVIL \?ELS45
	IN?	GANG-OF-FOUR,LP \?ELS45
	EQUAL?	LP,LIBRARY \?ELS56
	EQUAL?	PRSO,P?SOUTH /?THN53
?ELS56:	EQUAL?	LP,BANQUET-HALL \FALSE
	EQUAL?	PRSO,P?NORTH \FALSE
?THN53:	PRINTI	"In your confused and fearful state, you have blundered right into the advancing guards! They grab you, not too gently, and take you away. You end up at a huge temple."
	CRLF	
	CRLF	
	CALL	QUEUE,I-GUARDS-ARRIVE,0
	CALL	QUEUE,I-GANG,0
	CALL	TAKE-TO-TOWER
	RTRUE	
?ELS45:	EQUAL?	RARG,M-END \FALSE
	RANDOM	100
	GRTR?	30,STACK \FALSE
	EQUAL?	LP,LIBRARY,BANQUET-HALL \FALSE
	IN?	GANG-OF-FOUR,LP /FALSE
	EQUAL?	WINNER,PLAYER \?CND65
	PRINTI	"The low, guttural voices seem to be coming in your direction."
	CRLF	
?CND65:	CALL	QUEUE,I-GUARDS-ARRIVE,2
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-GUARDS-ARRIVE,LP
	LOC	PLAYER >LP
	EQUAL?	LP,LIBRARY,BANQUET-HALL \FALSE
	PRINTI	"A group of four hunched and hairy shapes walks into your presence. "
	ZERO?	PROTECTED-FROM-EVIL \?ELS12
	MOVE	GANG-OF-FOUR,LP
	PRINTI	"They seem surprised to see you. After whispering a few guttural words to each other, they start to move toward you purposefully."
	CRLF	
	SET	'GANG-FOLLOWS,0
	CALL	QUEUE,I-GANG,1
	PUT	STACK,0,1
	RTRUE	
?ELS12:	PRINTR	"They don't seem to take much notice of you, and they soon depart."


	.FUNCT	I-GANG
	INC	'GANG-FOLLOWS
	LOC	PLAYER
	IN?	GANG-OF-FOUR,STACK \?ELS5
	REMOVE	GANG-OF-FOUR
	ZERO?	PROTECTED-FROM-EVIL /?ELS10
	PRINTR	"The group of hunched and hairy shapes glances at you disinterestedly, wanders around the room for a while, and then departs."
?ELS10:	PRINTI	"The group of hunched and hairy shapes takes you in their arms and escorts you into a huge temple."
	CRLF	
	CRLF	
	CALL	TAKE-TO-TOWER
	RTRUE	
?ELS5:	LOC	PLAYER
	FSET?	STACK,RMUNGBIT \?ELS19
	PRINTI	"The group of shapes follows you, intent on your capture! They seem to come alive in the desolation which fills this room."
	CRLF	
	LOC	PLAYER
	MOVE	GANG-OF-FOUR,STACK
	CALL	QUEUE,I-GANG,1
	RTRUE	
?ELS19:	LESS?	GANG-FOLLOWS,LOSSAGE \?ELS23
	PRINTI	"The group of shapes follows you into this undespoiled room, emboldened and eager for blood."
	CRLF	
	LOC	PLAYER
	MOVE	GANG-OF-FOUR,STACK
	CALL	QUEUE,I-GANG,1
	RTRUE	
?ELS23:	PRINTI	"Fortunately for you, the gang has stopped following! You relax for a moment and heave a sigh of relief."
	CRLF	
	REMOVE	GANG-OF-FOUR
	RFALSE	


	.FUNCT	GANG-OF-FOUR-F
	EQUAL?	PRSA,V?CLEESH \?ELS5
	PRINTI	"The group of shapes turns into a small convention of newts, who run away."
	CRLF	
	CALL	QUEUE,I-GANG,0
	REMOVE	GANG-OF-FOUR
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?VAXUM \?ELS9
	ZERO?	PROTECTED-FROM-EVIL \FALSE
	PRINTI	"The shapes, who were on the verge of reaching you, seem to waver in their resolve. After a moment's pause, they leave the room together, talking in a less guttural tone which might correspond to cheerfulness."
	CRLF	
	REMOVE	GANG-OF-FOUR
	CALL	QUEUE,I-GANG,0
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?GUNCHO \?ELS21
	PRINTI	"The shapes"
	ZERO?	PROTECTED-FROM-EVIL \?CND24
	PRINTI	", on the verge of reaching you,"
?CND24:	PRINTI	" disappear, seeming to dwindle into the distance while remaining in the same spot. Eventually you can see them no longer."
	CRLF	
	REMOVE	GANG-OF-FOUR
	RTRUE	
?ELS21:	EQUAL?	PRSA,V?ZIFMIA \?ELS32
	ZERO?	PROTECTED-FROM-EVIL /?ELS32
	CALL	QUEUE,I-GANG,2
	PUT	STACK,0,1
	PRINTR	"The shapes, previously ignoring you, now approach with menace in their eyes."
?ELS32:	EQUAL?	PRSA,V?FROTZ \?ELS38
	PRINTI	"The shapes glow brightly from the frotz spell. This apparently doesn't appeal to them, as they shriek with horror and attempt to avert their gaze from themselves. Within a moment, they have run screaming from the room."
	CRLF	
	REMOVE	GANG-OF-FOUR
	RTRUE	
?ELS38:	EQUAL?	PRSA,V?NITFOL \FALSE
	ZERO?	PROTECTED-FROM-EVIL \FALSE
	PRINTR	"The shapes, whose language you understand instinctively, say something on the order of ""Blood for sacrifice!"", ""Master pleased!"", and other not-so-soothing words as they approach."


	.FUNCT	LITTER-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"You have no use for those things."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"They look as if they haven't been disturbed in a long time."


	.FUNCT	RAT-NEST-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"What on earth for?"
?ELS5:	EQUAL?	PRSA,V?MUNG,V?RUB \?ELS9
	PRINTR	"You poke around in the nest, but there doesn't seem to be anything of interest in there."
?ELS9:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"There's nothing in there."


	.FUNCT	OVEN-F
	EQUAL?	PRSA,V?REACH-IN,V?EXAMINE,V?LOOK-INSIDE \?ELS5
	PRINTR	"The oven contains nothing of interest, unless of course you have a hankering for rat's nests."
?ELS5:	EQUAL?	PRSA,V?REZROV,V?OPEN \?ELS9
	FSET?	OVEN,OPENBIT \?ELS14
	PRINTR	"The oven is already open."
?ELS14:	FSET	OVEN,OPENBIT
	PRINTR	"Opened."
?ELS9:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	OVEN,OPENBIT /?ELS27
	PRINTR	"The oven is already closed."
?ELS27:	FCLEAR	OVEN,OPENBIT
	PRINTR	"Closed."


	.FUNCT	HEAP-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"That would be rather undignified."
?ELS5:	EQUAL?	PRSA,V?DIG,V?LOOK-INSIDE,V?SEARCH \FALSE
	PRINTR	"There is nothing but rotted food there."


	.FUNCT	JUNCTION-F,RARG
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	WINNER,PLAYER \FALSE
	ZERO?	PROTECTED-FROM-EVIL \FALSE
	PRINTI	"A host of hunched and hairy shapes walk into the hall before you can do anything and, seeing you, take you in their arms and escort you to the west into a huge temple."
	CRLF	
	CRLF	
	CALL	GOTO,TEMPLE
	RSTACK	


	.FUNCT	ADV-VS-GANG,L
	LOC	ADVENTURER >L
	IN?	WINNER,L \?ELS5
	IN?	GANG-OF-FOUR,L \?ELS5
	IN?	WINNER,LIBRARY \?ELS12
	PUSH	NORTH-GATE
	JUMP	?CND8
?ELS12:	PUSH	EAST-HALL
?CND8:	MOVE	ADVENTURER,STACK
	PRINTR	"The adventurer softly, silently, and stealthily disappears."
?ELS5:	IN?	ADVENTURER,JUNCTION \FALSE
	LOC	WINNER
	EQUAL?	STACK,LIBRARY,BANQUET-HALL \FALSE
	PRINTI	"You hear yelling, oaths, and the crash of metal coming from the "
	IN?	WINNER,LIBRARY \?ELS27
	PUSH	STR?70
	JUMP	?CND23
?ELS27:	PUSH	STR?74
?CND23:	PRINT	STACK
	PRINTI	". It sounds like a swordfight! Suddenly, everything is quiet."
	CRLF	
	RANDOM	100
	GRTR?	70,STACK \?ELS34
	IN?	WINNER,LIBRARY \?ELS39
	PUSH	NORTH-GATE
	JUMP	?CND35
?ELS39:	PUSH	EAST-HALL
?CND35:	MOVE	ADVENTURER,STACK
	SET	'ADV-OLD-LOC,HERE
	LOC	ADVENTURER >ADV-NEW-LOC
	PRINTI	"Then the adventurer, running at an impressive speed, tears by you heading "
	IN?	WINNER,LIBRARY \?ELS48
	PUSH	STR?74
	JUMP	?CND44
?ELS48:	PUSH	STR?70
?CND44:	PRINT	STACK
	PRINTR	". He seems to have been in a fight."
?ELS34:	REMOVE	ADVENTURER
	MOVE	SKELETON,TOWER-S
	CALL	QUEUE,I-ADVENTURER,0
	RSTACK	


	.FUNCT	SKELETON-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"They're quite heavy, and you don't need them anyway."
?ELS5:	EQUAL?	PRSA,V?KILL,V?ATTACK,V?MUNG \FALSE
	PRINTR	"Show some respect! Especially considering that he got that way because of you!"


	.FUNCT	VOICES-F
	EQUAL?	HERE,ENGINE-ROOM,SE-TOWER \?ELS5
	EQUAL?	PRSA,V?EXAMINE,V?LISTEN \FALSE
	PRINTR	"The noise is loud and screeching."
?ELS5:	EQUAL?	HERE,COURTYARD-3,ALTAR \?ELS14
	EQUAL?	PRSA,V?LISTEN \FALSE
	PRINTR	"The voices are chanting something horrifying."
?ELS14:	EQUAL?	PRSA,V?LISTEN \?ELS23
	PRINTR	"You can't make out what they are saying, though it would be fair to say it's not too pleasant."
?ELS23:	EQUAL?	PRSA,V?ZIFMIA \?ELS27
	PRINTI	"The voices seem to be approaching. I hope you know what you're doing."
	CRLF	
	CALL	QUEUE,I-GUARDS-ARRIVE,1
	PUT	STACK,0,1
	RTRUE	
?ELS27:	EQUAL?	PRSA,V?NITFOL \FALSE
	PRINTR	"You can't use that spell on voices, only beings."


	.FUNCT	TUBES-PSEUDO
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	PRINTR	"They are all empty."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"As you touch each one, it crumbles to ash."


	.FUNCT	ASHES-PSEUDO
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"The ash slips through your fingers."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	EQUAL?	HERE,LIBRARY \?ELS14
	PRINTR	"The ashes have rat tracks in them. Little rat thoroughfares head here and there, but most head in one direction."
?ELS14:	PRINTR	"The ashes are black and greasy."
?ELS9:	EQUAL?	PRSA,V?LOOK-INSIDE,V?SEARCH \FALSE
	PRINTI	"You find nothing of interest in the ashes"
	EQUAL?	HERE,LIBRARY \?CND25
	PRINTI	", other than rat tracks heading this way and that"
?CND25:	PRINTR	"."


	.FUNCT	RAT-TRACKS-F
	EQUAL?	PRSA,V?EXAMINE,V?FOLLOW \FALSE
	PRINTI	"There are plenty of rat tracks here, going in various directions. One prominent rodentine thoroughfare stands out though, going as it does into a small hole in the wall."
	CRLF	
	MOVE	RAT-HOLE,HERE
	RTRUE	


	.FUNCT	RAT-HOLE-F,OBJ
	FIRST?	RAT-HOLE >OBJ /?KLU50
?KLU50:	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"You can't see anything in the rat hole."
?ELS5:	EQUAL?	PRSA,V?REACH-IN \?ELS9
	PRINTI	"You reach around for a moment and come up "
	ZERO?	OBJ \?ELS16
	PRINTR	"empty."
?ELS16:	PRINTI	"with something. It's "
	CALL	PRINTA,OBJ
	PRINTI	"."
	CRLF	
	CALL	THIS-IS-IT,OBJ
	FCLEAR	OBJ,INVISIBLE
	ADD	SCORE,QUENCH-POINT >SCORE
	SET	'QUENCH-POINT,0
	FSET	RAT-HOLE,NDESCBIT
	MOVE	OBJ,WINNER
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS24
	PRINTR	"It's too dark to see anything inside the hole."
?ELS24:	EQUAL?	PRSA,V?PUT \?ELS28
	EQUAL?	PRSI,RAT-HOLE \?ELS28
	FIRST?	RAT-HOLE \?ELS35
	PRINTR	"Something's blocking up the hole from inside."
?ELS35:	GETP	PRSO,P?SIZE
	GRTR?	STACK,5 \?ELS39
	PRINTR	"It won't fit."
?ELS39:	FSET	PRSO,INVISIBLE
	MOVE	PRSO,PRSI
	PRINTR	"Done."
?ELS28:	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINTR	"How absurd!"


	.FUNCT	NORTH-GATE-OBJ-F
	EQUAL?	PRSA,V?REZROV \?ELS5
	FSET?	PRSO,OPENBIT /?ELS5
	PRINTI	"The rusted north gate magically creaks open far enough for you to leave."
	CRLF	
	FSET	PRSO,OPENBIT
	FCLEAR	PRSO,LOCKEDBIT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	PRSO,LOCKEDBIT \FALSE
	PRINTR	"The gate is rusted shut."


	.FUNCT	FOREST-1-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	IN?	REPAIR-SCROLL,HERE \FALSE
	FSET?	REPAIR-SCROLL,TOUCHBIT /FALSE
	CALL	THIS-IS-IT,REPAIR-SCROLL
	RFALSE	


	.FUNCT	SWAMP-F,RARG=0
	EQUAL?	RARG,M-END \FALSE
	EQUAL?	PRSA,V?TELL /FALSE
	PRINTI	"The sounds of frogs and other swamp dwellers fill the air."
	EQUAL?	TALK-TO-ANIMAL?,FROG \?CND10
	FSET?	NEWT-SCROLL,INVISIBLE /?ELS15
	PRINTI	" The frogs are discussing "
	CALL	PICK-ONE,FROG-TALKS
	PRINT	STACK
	JUMP	?CND10
?ELS15:	PRINTI	" The frogs say ""Look under the lily pad. Breep!"""
?CND10:	CRLF	
	RFALSE	


	.FUNCT	SWAMP-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	CALL	PERFORM,V?LOOK
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINTR	"There is probably quicksand there. At best you would get horribly muddy."


	.FUNCT	FROG-F
	EQUAL?	WINNER,FROG \?ELS5
	EQUAL?	PRSA,V?HELLO /?ELS5
	PRINTR	"""Breep! No, thank you. Breep!"""
?ELS5:	EQUAL?	PRSA,V?LISTEN,V?HELLO \FALSE
	PRINTI	"""Breep! "
	EQUAL?	TALK-TO-ANIMAL?,FROG \?CND14
	CALL	PICK-ONE,FROGGERS
	PRINT	STACK
	PRINTI	" "
?CND14:	PRINTR	"Breep!"""


	.FUNCT	LILY-PAD-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"There's not much to say about the lily pads except that they seem to make a cheery home for the frogs."
?ELS5:	EQUAL?	PRSA,V?CLIMB-ON,V?THROUGH \?ELS9
	PRINTR	"You sink into the goo, crushing a lily pad."
?ELS9:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	FSET?	NEWT-SCROLL,INVISIBLE \?ELS18
	FCLEAR	NEWT-SCROLL,INVISIBLE
	MOVE	NEWT-SCROLL,WINNER
	PRINTR	"There is a damp scroll there, which you take into your hand."
?ELS18:	PRINTR	"There is nothing there but goo."

	.ENDI
