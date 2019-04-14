

	.FUNCT	MAPS-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"Most of the maps are murals painted onto the walls. The others are securely mounted."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The maps on the walls were made in the Elder days, when the face of the earth was different. You can recognize the ancient cities of Galepath and Mareilon on the shores of the Sea from your legends class at the University, but you have trouble discerning any other places. One map shows a proud castle standing on a cliff rising above the Sea. Largoneth it was, the once-proud home of Entharion the Wise, King of Quendor. As you realize that this place was the King's Map Room, you are filled with wonder at the ancient days."


	.FUNCT	ENTHARION-F
	EQUAL?	PRSA,V?WHO,V?EXAMINE \?ELS5
	PRINTR	"You can remember little of the legends of Entharion the Wise. Perhaps you should have paid more attention in Legends class."
?ELS5:	EQUAL?	PRSA,V?ZIFMIA \FALSE
	PRINTR	"Poor Entharion, he's been dead these many years. You would need more than a summoning spell to get him here."


	.FUNCT	GLOBE-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The globe represents the world as it was thought to be in the ancient days. Very little can be recognized of the seas or land masses."


	.FUNCT	PEDESTAL-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"A globe is sitting on it."


	.FUNCT	PURLOINED-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	ZERO?	DOOR-ILLUSION-GONE \?ELS10
	PRINTI	"A more incongruous place than this would be difficult to believe. The room itself is nothing more than a small room at the base of the northeast tower with a narrow passageway entering from the west. Standing in front of you to the north, however, is a door surpassing anything you could have imagined. For starters, its massive lock is wrapped in a dozen six-inch thick iron chains. In addition, a certain five-headed monster sporting razor-sharp spears for tongues seems to be imbedded within its heavy oak frame. One is almost embarrassed to mention the gargoyles spewing flame and sulphurous ash which ornament either side of the door, or the ninety-seven slimy groping tentacles which taunt you ever closer to certain death. A sign, floating serenely above the door and glowing hideously in purple letters, offers the following rude understatement: "
	GETP	FLOATING-SIGN,P?TEXT
	PRINT	STACK
	PRINTR	"."
?ELS10:	PRINTI	"This rather unobtrusive room at the base of the northwest tower sports a small passageway to the west and a small, rickety door to the north which is "
	FSET?	DOOR-REALITY,OPENBIT \?ELS21
	PRINTI	"open"
	JUMP	?CND19
?ELS21:	PRINTI	"closed"
?CND19:	PRINTR	"."
?ELS5:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \FALSE
	EQUAL?	PRSO,P?UP,P?NORTH \FALSE
	ZERO?	DOOR-ILLUSION-GONE \FALSE
	EQUAL?	WINNER,PLAYER \?ELS38
	CALL	PERFORM,V?OPEN,DOOR-ILLUSION
	RTRUE	
?ELS38:	PRINTR	"""I'd like to, but the door's closed."""


	.FUNCT	DOOR-ILLUSION-F
	ZERO?	DOOR-ILLUSION-GONE \FALSE
	EQUAL?	PRSA,V?KULCAD \?ELS10
	PRINTI	"As the last syllable of the kulcad spell echoes through the chamber, the door itself seems to dissolve. Slowly at first, then quickly, each of its rather unlovely ornaments turns pale, then transparent, then - nothing! What remains is a simple, wooden door which is standing shut. You move hesitantly toward the door. Nothing. You pause for a moment to regain your composure."
	CRLF	
	SET	'DOOR-KULCAD,TRUE-VALUE
	FSET	DOOR-ILLUSION,INVISIBLE
	FCLEAR	DOOR-REALITY,INVISIBLE
	FCLEAR	DOOR-REALITY,OPENBIT
	FCLEAR	DOOR-REALITY,LOCKEDBIT
	SET	'DOOR-ILLUSION-GONE,TRUE-VALUE
	REMOVE	MONSTERS-1
	REMOVE	MONSTERS-2
	REMOVE	MONSTERS-3
	RTRUE	
?ELS10:	EQUAL?	PRSA,V?SHOW \?ELS14
	EQUAL?	PRSI,ADVENTURER \?ELS14
	CALL	PERFORM,V?POINT,PRSO
	RTRUE	
?ELS14:	EQUAL?	PRSA,V?POINT \?ELS18
	IN?	ADVENTURER,HERE \?ELS18
	SET	'ADVENTURER-STAY,TRUE-VALUE
	ZERO?	ADVENTURER-CHARMED /?ELS25
	PRINTI	"As you motion toward the monstrous door, the adventurer follows the imaginary line which proceeds thence from your outstretched arm."
	CRLF	
	CRLF	
	CALL	NO-ILLUSIONS
	RTRUE	
?ELS25:	PRINTR	"The adventurer seems frightened, and he backs up toward the door."
?ELS18:	EQUAL?	PRSA,V?UNLOCK,V?RUB,V?OPEN /?THN35
	EQUAL?	PRSA,V?ATTACK,V?KILL,V?MUNG /?THN35
	EQUAL?	PRSA,V?KNOCK \?ELS34
?THN35:	IGRTR?	'BEATEN-UP,4 \?CND37
	CALL	JIGS-UP,STR?132
	RTRUE	
?CND37:	CALL	PICK-ONE,ILLUSION-HACKS
	PRINT	STACK
	CRLF	
	CALL	PICK-ONE,SIGN-TEXTS
	PUTP	FLOATING-SIGN,P?TEXT,STACK
	RTRUE	
?ELS34:	EQUAL?	PRSA,V?REZROV \FALSE
	PRINTR	"As you cast the rezrov spell, the door shudders briefly, and a few tentacles pause in their unending motion. The two gargoyles look at each other, perplexed. After a tense moment, the sign above the door flashes briefly: ""Fat Chance""."


	.FUNCT	MIRROR-F
	FSET?	HERE,NDESCBIT \?ELS5
	EQUAL?	PRSA,V?KREBF \?ELS10
	FCLEAR	HERE,NDESCBIT
	PRINTR	"Shards of glass fly into the air, solving a jigsaw puzzle of a million pieces. The mirror is repaired!"
?ELS10:	PRINTR	"There's no mirror left here after the way you treated it."
?ELS5:	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE \?ELS18
	PRINTI	"The scene behind the ""mirror"" is an underground landscape."
	FSET?	ADVENTURER-LG,INVISIBLE /?CND21
	PRINTI	" A weary adventurer is standing there, dejected."
?CND21:	CRLF	
	RTRUE	
?ELS18:	EQUAL?	PRSA,V?ATTACK,V?MUNG \FALSE
	PRINTI	"The mirror here smashes into tiny shards. Behind the mirror is a bare rock wall."
	CRLF	
	CALL	NO-MORE-ADVENTURER
	FSET	HERE,NDESCBIT
	RTRUE	


	.FUNCT	SHARDS-F
	FSET?	HERE,NDESCBIT /?ELS5
	PRINTR	"There are no shards of glass here...yet."
?ELS5:	EQUAL?	PRSA,V?PUT,V?MOVE,V?TAKE /?THN10
	EQUAL?	PRSA,V?RUB \FALSE
?THN10:	PRINTR	"You would slice your fingers on them."


	.FUNCT	MIRROR-HALL-F,RARG,RM
	EQUAL?	RARG,M-LOOK \?ELS5
	GETP	HERE,P?COUNT >RM
	GET	MIRROR-HALL-TBL1,RM
	PRINT	STACK
	FSET?	HERE,NDESCBIT \?ELS10
	PRINTI	" Hall of Mirrors. Where there used to be a large mirror mounted on the wall is only an empty frame. Shards of mirror cover the floor."
	CRLF	
	JUMP	?CND8
?ELS10:	PRINTI	" Hall of Mirrors. The hall itself is astounding and not a little bit confusing. To be sure, its northern wall is glass, but it does not seem to reflect anything within the hall. Rather, it seems to be a window on another world. This other world appears to be a large underground labyrinth, filled with tunnels, caves, and peculiar rock formations."
	CRLF	
?CND8:	ZERO?	ADVENTURER-LOC /FALSE
	CALL	DESCRIBE-ADVENTURER
	RSTACK	
?ELS5:	EQUAL?	RARG,M-ENTER \?ELS24
	MOVE	GLOBAL-ADVENTURER,GLOBAL-OBJECTS
	RFALSE	
?ELS24:	EQUAL?	RARG,M-END \FALSE
	FSET?	HERE,NDESCBIT /FALSE
	ZERO?	ADVENTURER-SUMMONED \FALSE
	FSET?	ADVENTURER-LG,INVISIBLE \FALSE
	RANDOM	100
	GRTR?	15,STACK \FALSE
	SET	'ADVENTURER-LOC,HERE
	CALL	QUEUE,I-LG-ADVENTURER,-1
	PUT	STACK,0,1
	PRINTI	"From the other side of the ""mirror"" a bedraggled adventurer comes into view, carrying a brass lantern and an elvish sword, which is glowing dimly. He stops and stares in your direction."
	CRLF	
	SET	'ADVENTURER-SEEN,TRUE-VALUE
	FCLEAR	ADVENTURER-LG,INVISIBLE
	RTRUE	


	.FUNCT	MIRROR-STUFF-F
	FSET?	HERE,NDESCBIT \?ELS5
	CALL	GLOBAL-NOT-HERE-PRINT,MIRROR-STUFF
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The scene is an underground world, quite dissimilar from your own."


	.FUNCT	NO-MORE-ADVENTURER
	FSET	ADVENTURER-LG,INVISIBLE
	SET	'ADVENTURER-LOC,FALSE-VALUE
	CALL	QUEUE,I-LG-ADVENTURER,0
	RTRUE	


	.FUNCT	I-LG-ADVENTURER
	ZERO?	ADVENTURER-SUMMONED \?THN6
	EQUAL?	HERE,ADVENTURER-LOC /?ELS5
?THN6:	CALL	NO-MORE-ADVENTURER
	RFALSE	
?ELS5:	RANDOM	100
	GRTR?	25,STACK \FALSE
	PRINTI	"The adventurer, after checking his compass, walks off."
	CRLF	
	CALL	NO-MORE-ADVENTURER
	RTRUE	


	.FUNCT	DESCRIBE-ADVENTURER
	PRINTI	"A bedraggled adventurer, carrying a brass lantern and a dimly glowing elvish sword, can be seen through the ""mirror"". He "
	CALL	PICK-ONE,ADVENTURER-FEEBLES
	PRINT	STACK
	PRINTR	"."


	.FUNCT	GLOBAL-ADVENTURER-F
	EQUAL?	PRSA,V?ZIFMIA \?ELS5
	CALL	NO-ZIF
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?FOLLOW \?ELS7
	ZERO?	ADVENTURER-SUMMONED /?ELS7
	EQUAL?	ADV-OLD-LOC,HERE \?ELS14
	CALL	GOTO,ADV-NEW-LOC
	RTRUE	
?ELS14:	PRINTR	"You have lost track of him."
?ELS7:	CALL	GLOBAL-NOT-HERE-PRINT,GLOBAL-ADVENTURER
	RTRUE	


	.FUNCT	ADVENTURER-LG-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	CALL	DESCRIBE-ADVENTURER
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?WAVE-AT \?ELS7
	PRINTR	"He doesn't seem to notice your gesture."
?ELS7:	EQUAL?	PRSA,V?ZIFMIA \?ELS11
	PRINTI	"All at once, the bedraggled adventurer appears before you, brightly glowing sword in hand. His jaw has dropped and his eyes are bulging. His eyes dart this way and that, as if looking for a way to escape."
	CRLF	
	ADD	SCORE,SUMMON-POINT >SCORE
	SET	'SUMMON-POINT,0
	MOVE	ADVENTURER,HERE
	SET	'ADVENTURER-SUMMONED,TRUE-VALUE
	SET	'ADVENTURER-STAY,TRUE-VALUE
	CALL	QUEUE,I-ADVENTURER,-1
	PUT	STACK,0,1
	CALL	THIS-IS-IT,ADVENTURER
	RTRUE	
?ELS11:	EQUAL?	PRSA,V?CLEESH \?ELS15
	PRINTR	"The spell has no effect, perhaps because he isn't here."
?ELS15:	EQUAL?	PRSA,V?GUNCHO \FALSE
	PRINTI	"Behind the ""mirror"", the luckless adventurer seems to fade away. He shimmers briefly and then vanishes without a trace."
	CRLF	
	CALL	NO-MORE-ADVENTURER
	SET	'ADVENTURER-SUMMONED,TRUE-VALUE
	RETURN	ADVENTURER-SUMMONED


	.FUNCT	ADVENTURER-C
	EQUAL?	PRSA,V?TAKE \?ELS5
	CALL	PERFORM,V?ASK-FOR,ADVENTURER,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?READ \FALSE
	ZERO?	ADVENTURER-CHARMED \?ELS12
	PRINTR	"The adventurer pulls back as you approach."
?ELS12:	PRINTI	"The adventurer moves closer so that you might read it."
	CRLF	
	RFALSE	


	.FUNCT	ADVENTURER-D,RARG
	PRINTI	"There is a bedraggled and weary adventurer standing here. He is carrying "
	CALL	PRINT-CONTENTS,ADVENTURER
	ZERO?	ADVENTURER-CHARMED /?CND3
	PRINTI	". He seems pleased to see you and frequently smiles in your direction"
?CND3:	PRINTR	"."


	.FUNCT	SWORD-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The sword is of elvish workmanship and is glowing brightly."


	.FUNCT	ADVENTURER-ACTOR
	EQUAL?	PRSA,V?FOLLOW \?ELS5
	ZERO?	ADVENTURER-CHARMED /?ELS10
	PRINTR	"""Sorry, but I've got better things to do than follow you."""
?ELS10:	PRINTR	"""I'd sooner follow Dimwit Flathead!"""
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS19
	ZERO?	ADVENTURER-CHARMED \?ELS24
	PRINTR	"He glances suspiciously at it."
?ELS24:	EQUAL?	PRSO,DOOR-ILLUSION \?ELS28
	PRINTR	"""It's a door."""
?ELS28:	PRINTI	"""It's "
	CALL	PRINTA,PRSO
	PRINTR	"."""
?ELS19:	EQUAL?	PRSA,V?THROUGH,V?OPEN \?ELS36
	EQUAL?	PRSO,DOOR-ILLUSION \?ELS36
	ZERO?	ADVENTURER-CHARMED /?ELS43
	SET	'WINNER,PLAYER
	LOC	WINNER >HERE
	CALL	PERFORM,V?POINT,DOOR-ILLUSION
	RTRUE	
?ELS43:	PRINTR	"The adventurer looks at you suspiciously. ""Can't you open it yourself?"""
?ELS36:	EQUAL?	PRSA,V?HELLO \?ELS50
	ZERO?	ADVENTURER-CHARMED /?ELS55
	PRINTR	"""Hello. Nice to meet you."""
?ELS55:	ZERO?	PRSO /?ELS60
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" steps away from you."
?ELS60:	PRINTR	"The adventurer steps warily away."
?ELS50:	EQUAL?	PRSA,V?UNTIE \?ELS69
	EQUAL?	PRSO,MAGIC-ROPE \?ELS69
	ZERO?	ADVENTURER-CHARMED /?ELS69
	PRINTR	"The adventurer tries to untie the rope, but he only becomes entangled. He gives up and glares suspiciously at you."
?ELS69:	EQUAL?	PRSA,V?ATTACK,V?MUNG \?ELS75
	EQUAL?	PRSO,DOOR-ILLUSION \?ELS75
	PRINTR	"He pauses as if searching for the right thing to say. ""I've known strange people, but fighting a wooden door?"""
?ELS75:	EQUAL?	PRSA,V?MUNG,V?CUT \?ELS81
	EQUAL?	PRSO,MAGIC-ROPE \?ELS81
	ZERO?	ADVENTURER-CHARMED \?ELS88
	PRINTR	"""Not bloody likely! There's magic there!"""
?ELS88:	ZERO?	ROPE-MAGIC? \?ELS92
	CALL	ROPE-DISSOLVES
	MOVE	JEWELLED-BOX,ADVENTURER
	LOC	ADVENTURER
	MOVE	PROTECTION-SCROLL,STACK
	PRINTR	"The adventurer draws his sword and slices the rope cleanly into so much fluff. He opens the box, revealing a scroll! He drops this on the ground disdainfully but retains the box."
?ELS92:	ZERO?	PRSI /?THN97
	EQUAL?	PRSI,SWORD \?ELS96
?THN97:	PRINTR	"""Ooo! Nice idea!"" He slashes at the rope with his sword, but to no avail. The rope is impervious to the magic of this weapon! He looks crestfallen."
?ELS96:	PRINTR	"""I doubt that would work."""
?ELS81:	EQUAL?	PRSA,V?SSHOW,V?SGIVE /FALSE
	EQUAL?	PRSA,V?SHOW,V?GIVE \?ELS108
	EQUAL?	PRSI,ME \?ELS108
	EQUAL?	PRSA,V?GIVE \?ELS113
	CALL	PERFORM,V?ASK-FOR,ADVENTURER,PRSO
	RTRUE	
?ELS113:	ZERO?	ADVENTURER-CHARMED /?ELS115
	PRINTI	"The "
	PRINTD	ADVENTURER
	PRINTI	" allows you a quick look at the "
	PRINTD	PRSO
	PRINTR	"."
?ELS115:	PRINTI	"The "
	PRINTD	ADVENTURER
	PRINTR	" gives you a suspicious look and attempts to conceal his possessions."
?ELS108:	PRINTR	"""I'll do what I please, thank you."""


	.FUNCT	ADVENTURER-F
	EQUAL?	WINNER,ADVENTURER \?ELS5
	CALL	ADVENTURER-ACTOR
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?WAVE-AT \?ELS7
	ZERO?	ADVENTURER-CHARMED /?ELS12
	PRINTR	"The adventurer waves right back."
?ELS12:	PRINTR	"The adventurer steps back a few paces."
?ELS7:	EQUAL?	PRSA,V?FOLLOW \?ELS21
	PRINTR	"He's right here!"
?ELS21:	EQUAL?	PRSA,V?KILL,V?ATTACK \?ELS25
	SET	'ADVENTURER-CHARMED,FALSE-VALUE
	CALL	JIGS-UP,STR?150
	RSTACK	
?ELS25:	EQUAL?	PRSA,V?NITFOL \?ELS27
	PRINTR	"He already speaks your language, but now a bit better."
?ELS27:	EQUAL?	PRSA,V?GUNCHO \?ELS31
	PRINTI	"The adventurer blurs as though you were seeing him from a distance, wavers like a mirage, and then vanishes."
	CRLF	
	REMOVE	ADVENTURER
	CALL	QUEUE,I-ADVENTURER,0
	RSTACK	
?ELS31:	EQUAL?	PRSA,V?FROTZ \?ELS35
	PRINTI	"The adventurer is now bathed in light, much to his amazement."
	CRLF	
	SET	'ADVENTURER-CHARMED,FALSE-VALUE
	FSET	ADVENTURER,LIGHTBIT
	FSET	ADVENTURER,ONBIT
	RTRUE	
?ELS35:	EQUAL?	PRSA,V?VAXUM \?ELS39
	SET	'ADVENTURER-STAY,TRUE-VALUE
	SET	'ADVENTURER-CHARMED,TRUE-VALUE
	CALL	QUEUE,I-ADVENTURER-UNCHARM,20
	PUT	STACK,0,1
	PRINTR	"The adventurer smiles at you with an air of good will."
?ELS39:	EQUAL?	PRSA,V?HELLO \?ELS43
	ZERO?	ADVENTURER-CHARMED /?ELS48
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" waves back and says ""Hello!"""
?ELS48:	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" keeps his distance, eyeing you cautiously."
?ELS43:	EQUAL?	PRSA,V?SEARCH \?ELS57
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" isn't inclined to allow himself to be searched."
?ELS57:	EQUAL?	PRSA,V?MUNG \?ELS61
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" dodges your blow and becomes very wary of you."
	CRLF	
	SET	'ADVENTURER-CHARMED,FALSE-VALUE
	RTRUE	
?ELS61:	EQUAL?	PRSA,V?GIVE \?ELS65
	EQUAL?	PRSI,ADVENTURER \?ELS65
	ZERO?	ADVENTURER-CHARMED \?ELS72
	PRINTI	"The "
	PRINTD	PRSI
	PRINTI	" eyes you suspiciously. Why, he thinks, is this sorcerer handing me something"
	FSET?	PRSO,TREASURE \?CND75
	PRINTI	", especially something valuable"
?CND75:	PRINTR	"?"
?ELS72:	ZERO?	SAILOR? /?ELS83
	SUB	MOVES,SAILOR?
	LESS?	STACK,2 \?ELS83
	MOVE	PRSO,ADVENTURER
	PRINTI	"A wide smile comes over his face as he takes the "
	PRINTD	PRSO
	PRINTR	", as though your action resolved for him some great mystery."
?ELS83:	FSET?	PRSO,TREASURE \?ELS89
	PRINTI	"The "
	PRINTD	PRSI
	PRINTI	" gratefully accepts the offer of the "
	PRINTD	PRSO
	PRINTI	". He is fascinated by its beauty and stops to thank you."
	CRLF	
	MOVE	PRSO,ADVENTURER
	RTRUE	
?ELS89:	PRINTI	"The "
	PRINTD	PRSI
	PRINTR	" refuses your offer politely."
?ELS65:	EQUAL?	PRSA,V?SHOW \?ELS97
	EQUAL?	PRSI,ADVENTURER \?ELS97
	ZERO?	ADVENTURER-CHARMED \?ELS104
	PRINTR	"He ignores you pointedly."
?ELS104:	EQUAL?	PRSO,DOOR-ILLUSION /FALSE
	FSET?	PRSO,TREASURE \?ELS110
	PRINTI	"His eyes light up at the sight of the "
	PRINTD	PRSO
	PRINTI	"."
	CRLF	
	SET	'ADVENTURER-STAY,TRUE-VALUE
	RETURN	ADVENTURER-STAY
?ELS110:	PRINTR	"He yawns briefly, indicating his disinterest."
?ELS97:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSI,ADVENTURER \FALSE
	CALL	PERFORM,V?ASK-FOR,PRSI,PRSO
	RTRUE	


	.FUNCT	I-ADVENTURER-UNCHARM
	SET	'ADVENTURER-CHARMED,FALSE-VALUE
	IN?	ADVENTURER,HERE \FALSE
	PRINTR	"The adventurer looks at you as if seeing you for the first time. It's not clear that he likes what he sees, either."


	.FUNCT	I-ADVENTURER,L,NL
	LOC	ADVENTURER >L
	FSET?	L,ONBIT \?ELS3
	FCLEAR	LANTERN,ONBIT
	JUMP	?CND1
?ELS3:	FSET	LANTERN,ONBIT
?CND1:	INC	'ADVENTURER-MOVE
	ZERO?	ADVENTURER-MOVE /TRUE
	GETP	L,P?ADVFCN
	CALL	STACK
	ZERO?	STACK \TRUE
	ZERO?	ADVENTURER-STAY /?ELS14
	SET	'ADVENTURER-STAY,FALSE-VALUE
	EQUAL?	HERE,L \FALSE
	ZERO?	ADVENTURER-CHARMED /FALSE
	PRINTI	"The adventurer"
	CALL	PICK-ONE,ADVENTURER-LOITERS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS14:	EQUAL?	L,MIRROR-HALL-1,MIRROR-HALL-2,MIRROR-HALL-3 /?THN27
	EQUAL?	L,MIRROR-HALL-4,NORTH-GATE \?ELS26
?THN27:	CALL	NEXT-HALL,L,TRUE-VALUE >NL
	CALL	TREASURE-HERE?,NL
	ZERO?	STACK /?ELS33
	CALL	MOVE-ADVENTURER,NL
	RSTACK	
?ELS33:	LESS?	ADVENTURER-MOVE,5 \?ELS35
	CALL	NEXT-HALL,L,FALSE-VALUE
	CALL	MOVE-ADVENTURER,STACK
	RSTACK	
?ELS35:	CALL	ADVENTURER-DECIDE,L
	RSTACK	
?ELS26:	RANDOM	100
	GRTR?	25,STACK \?ELS39
	EQUAL?	HERE,L \?ELS39
	PRINTI	"The adventurer "
	ZERO?	ADVENTURER-CHARMED /?ELS48
	ZERO?	SAILOR? \?ELS54
	RANDOM	100
	GRTR?	16,STACK \?ELS54
	SET	'SAILOR?,MOVES
	PRINTR	"waves at you and asks ""Hello, Sailor?"" Strange, you've never even been to sea."
?ELS54:	CALL	PICK-ONE,ADVENTURER-NICE
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS48:	CALL	PICK-ONE,ADVENTURER-QUIPS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS39:	CALL	ADVENTURER-TAKE,L
	ZERO?	STACK /?ELS68
	SET	'ADVENTURER-STAY,FALSE-VALUE
	RTRUE	
?ELS68:	ZERO?	ADV-HASTE \?ELS73
	EQUAL?	HASTED?,ADVENTURER \?ELS73
	SET	'ADV-HASTE,TRUE-VALUE
	CALL	ADVENTURER-DECIDE,L
	CALL	I-ADVENTURER
	RTRUE	
?ELS73:	SET	'ADV-HASTE,FALSE-VALUE
	CALL	ADVENTURER-DECIDE,L
	RTRUE	


	.FUNCT	MOVE-ADVENTURER,RM,L,CNT=0,OBJ,DIR
	LOC	ADVENTURER >L
	EQUAL?	L,NORTH-GATE \?ELS3
	EQUAL?	RM,PURLOINED-ROOM \?ELS3
	CALL	TREASURE-HERE?,RM
	ZERO?	STACK \?ELS3
	FSET	PURLOINED-ROOM,VILLAIN
	EQUAL?	HERE,L \TRUE
	PRINTR	"The adventurer starts toward the east but, seeing nothing of interest, changes his mind."
?ELS3:	EQUAL?	RM,TEMPLE \?ELS12
	EQUAL?	HERE,L \?CND13
	PRINTI	"The adventurer looks as if he might go into the temple, but then he thinks better of it."
	CRLF	
?CND13:	FSET	TEMPLE,VILLAIN
	RTRUE	
?ELS12:	EQUAL?	RM,T-A \?ELS19
	EQUAL?	HERE,L \?CND20
	PRINTI	"The adventurer starts to descend further, but chickens out. He won't make Dungeon Master at that rate!"
	CRLF	
?CND20:	FSET	T-A,VILLAIN
	SET	'RM,DIM-DESCENT
	JUMP	?CND1
?ELS19:	EQUAL?	RM,WEST-CASTLE \?CND1
	EQUAL?	HERE,L \?CND27
	PRINTI	"The adventurer peers through the gate, but he decides against passing through."
	CRLF	
?CND27:	FSET	WEST-CASTLE,VILLAIN
	SET	'RM,COURTYARD-1
?CND1:	EQUAL?	HERE,L \?ELS34
	PRINTI	"The adventurer "
	EQUAL?	HASTED?,ADVENTURER \?ELS39
	PRINTI	"rockets out of"
	JUMP	?CND37
?ELS39:	PRINTI	"leaves"
?CND37:	PRINTI	" the room"
	CALL	DOOR-FROM?,L,RM >OBJ
	ZERO?	OBJ /?CND48
	PRINTI	" through the "
	PRINTD	OBJ
?CND48:	PRINTI	", heading "
	CALL	DIR-FROM,L,RM >DIR
	EQUAL?	DIR,P?UP,P?DOWN /?CND55
	PRINTI	"to "
?CND55:	CALL	DIR-PRINT,DIR
	SET	'ADV-NEW-LOC,RM
	SET	'ADV-OLD-LOC,L
	PRINTI	"."
	CRLF	
	JUMP	?CND32
?ELS34:	EQUAL?	HERE,RM \?CND32
	EQUAL?	HERE,PURLOINED-ROOM \?ELS66
	FSET?	MAP-ROOM,VILLAIN /?ELS66
	CALL	TREASURE-HERE?,HERE
	ZERO?	STACK /?ELS66
	PRINTI	"An adventurer peeks into the room, sees the "
	CALL	TREASURE-HERE?,HERE
	PRINTD	STACK
	PRINTI	", and enters."
	CRLF	
	JUMP	?CND32
?ELS66:	PRINTI	"A bedraggled adventurer "
	EQUAL?	HASTED?,ADVENTURER \?ELS77
	PRINTI	"speeds"
	JUMP	?CND75
?ELS77:	PRINTI	"walks"
?CND75:	PRINTI	" into the room from "
	CALL	DIR-FROM,RM,L
	CALL	DIR-PRINT,STACK
	CALL	DOOR-FROM?,RM,L >OBJ
	ZERO?	OBJ /?CND86
	PRINTI	", coming through the "
	PRINTD	OBJ
?CND86:	PRINTI	"."
	CRLF	
?CND32:	MOVE	ADVENTURER,RM
	FSET	RM,VILLAIN
	EQUAL?	RM,PURLOINED-ROOM /FALSE
	CALL	ADVENTURER-TAKE,RM
	RSTACK	


	.FUNCT	DOOR-FROM?,HERE,THERE,P,L,TX
	SET	'P,0
?PRG1:	NEXTP	HERE,P >P
	ZERO?	P /FALSE
	LESS?	P,LOW-DIRECTION /?PRG1
	GETPT	HERE,P >TX
	PTSIZE	TX >L
	EQUAL?	L,DEXIT \?PRG1
	GETB	TX,REXIT
	EQUAL?	STACK,THERE \?PRG1
	GETB	TX,DEXITOBJ
	RSTACK	


	.FUNCT	ADVENTURER-TAKE,RM,F,N,TR=0,CNT=0,OBJ
	FIRST?	RM >F /?KLU47
?KLU47:	
?PRG1:	ZERO?	F \?ELS5
	JUMP	?REP2
?ELS5:	NEXT?	F >N /?KLU48
?KLU48:	FSET?	F,TAKEBIT \?CND8
	FSET?	F,INVISIBLE /?CND8
	EQUAL?	F,STRONG-BOX /?CND8
	FSET?	F,TREASURE /?THN13
	RANDOM	100
	GRTR?	25,STACK \?CND8
?THN13:	GETP	F,P?ADVFCN
	CALL	STACK
	ZERO?	STACK \?CND8
	MOVE	F,ADVENTURER
	INC	'CNT
	SET	'OBJ,F
	FSET?	F,TREASURE \?CND15
	SET	'TR,TRUE-VALUE
?CND15:	
?CND8:	SET	'F,N
	JUMP	?PRG1
?REP2:	EQUAL?	HERE,RM \FALSE
	GRTR?	CNT,0 \FALSE
	PRINTI	"The adventurer stoops over and picks up "
	EQUAL?	CNT,1 \?ELS32
	PRINTI	"the "
	PRINTD	OBJ
	JUMP	?CND30
?ELS32:	PRINTI	"some objects"
?CND30:	ZERO?	TR /?CND39
	PRINTI	" and seems pleased by his discovery"
?CND39:	PRINTR	"."


	.FUNCT	DIR-FROM,HERE,THERE,P,L,TX,O
	SET	'P,0
?PRG1:	NEXTP	HERE,P >P
	ZERO?	P /FALSE
	EQUAL?	P,P?IN \?ELS7
	JUMP	?PRG1
?ELS7:	LESS?	P,LOW-DIRECTION /?PRG1
	GETPT	HERE,P >TX
	PTSIZE	TX >L
	EQUAL?	L,DEXIT,UEXIT,CEXIT \?PRG1
	GETB	TX,REXIT
	EQUAL?	STACK,THERE \?PRG1
	RETURN	P


	.FUNCT	DIR-PRINT,DIR,CNT=0
?PRG1:	GET	DIR-STRINGS,CNT
	EQUAL?	STACK,DIR \?CND3
	EQUAL?	DIR,P?UP,P?DOWN /?CND6
	PRINTI	"the "
?CND6:	ADD	CNT,1
	GET	DIR-STRINGS,STACK
	PRINT	STACK
	RTRUE	
?CND3:	INC	'CNT
	JUMP	?PRG1


	.FUNCT	ADVENTURER-DECIDE,L,P,S,TX
	NEXTP	L,0 >P
	PUT	ADV-POSS,0,0
?PRG1:	LESS?	P,LOW-DIRECTION \?ELS5
	JUMP	?REP2
?ELS5:	GETPT	L,P >TX
	PTSIZE	TX >S
	EQUAL?	S,UEXIT /?THN11
	EQUAL?	S,DEXIT \?ELS14
	GETB	TX,DEXITOBJ
	FSET?	STACK,LOCKEDBIT \?THN11
?ELS14:	EQUAL?	S,CEXIT \?CND3
	GETB	TX,CEXITFLAG
	VALUE	STACK
	ZERO?	STACK /?CND3
?THN11:	GETB	TX,REXIT >S
	GET	ADV-POSS,0
	ADD	STACK,1 >TX
	PUT	ADV-POSS,0,TX
	PUT	ADV-POSS,TX,S
?CND3:	NEXTP	L,P >P
	JUMP	?PRG1
?REP2:	GET	ADV-POSS,0 >S
	ZERO?	S \?ELS21
	PRINTI	"**BUG: Can't move from "
	LOC	ADVENTURER
	PRINTD	STACK
	PRINTR	"!"
?ELS21:	EQUAL?	S,1 \?ELS25
	GET	ADV-POSS,1
	CALL	MOVE-ADVENTURER,STACK
	RSTACK	
?ELS25:	SET	'P,0
?PRG28:	IGRTR?	'P,S \?ELS32
	JUMP	?REP29
?ELS32:	GET	ADV-POSS,P >TX
	FSET?	TX,VILLAIN /?PRG28
	CALL	MOVE-ADVENTURER,TX
	RTRUE	
?REP29:	CALL	RANDOM-ELEMENT,ADV-POSS
	CALL	MOVE-ADVENTURER,STACK
	RSTACK	


	.FUNCT	NEXT-HALL,RM,L-R=1,TBL,OFFS=0,NR
	SET	'TBL,HALL-TBL
?PRG1:	GET	TBL,OFFS >NR
	EQUAL?	NR,RM \?CND3
	ZERO?	L-R /?ELS8
	ADD	OFFS,1
	GET	TBL,STACK
	RSTACK	
?ELS8:	SUB	OFFS,1
	GET	TBL,STACK
	RSTACK	
?CND3:	INC	'OFFS
	JUMP	?PRG1


	.FUNCT	TREASURE-HERE?,RM,F
	FIRST?	RM >F /?KLU10
?KLU10:	
?PRG1:	ZERO?	F /FALSE
	FSET?	F,TREASURE \?ELS7
	RETURN	F
?ELS7:	NEXT?	F >F /?KLU11
?KLU11:	JUMP	?PRG1


	.FUNCT	PURLOINED-ROOM-A,TX
	CALL	TREASURE-HERE?,PURLOINED-ROOM >TX
	ZERO?	TX /?ELS3
	SET	'ADVENTURER-STAY,TRUE-VALUE
	EQUAL?	HERE,PURLOINED-ROOM \FALSE
	MOVE	TX,ADVENTURER
	FSET?	DOOR-REALITY,INVISIBLE \FALSE
	PRINTI	"The adventurer stops to pick up the "
	PRINTD	TX
	PRINTI	". As he rises, he casts a cursory glance at the door, then he notices you. "
	ZERO?	ADVENTURER-CHARMED /?ELS15
	PRINTI	"He smiles at you as he pockets the "
	PRINTD	TX
	PRINTI	"."
	CRLF	
	RFALSE	
?ELS15:	PRINTI	"He straightens quickly, glaring at you with distrust."
	CRLF	
	RFALSE	
?ELS3:	ZERO?	ADVENTURER-NOTES-DOOR \FALSE
	SET	'ADVENTURER-NOTES-DOOR,TRUE-VALUE
	SET	'ADVENTURER-STAY,TRUE-VALUE
	FSET?	DOOR-REALITY,INVISIBLE \FALSE
	PRINTI	"The adventurer glances around the room in a businesslike way and makes a few notes on his map."
	CRLF	
	RFALSE	


	.FUNCT	NO-ILLUSIONS
	FSET	DOOR-ILLUSION,INVISIBLE
	FCLEAR	DOOR-REALITY,INVISIBLE
	FCLEAR	DOOR-REALITY,LOCKEDBIT
	FSET	DOOR-REALITY,OPENBIT
	SET	'DOOR-ILLUSION-GONE,TRUE-VALUE
	PRINTI	"The seemingly fearless adventurer shrugs and walks purposefully toward the door, ignoring all harm to his person in the form of knives, tentacles, and molten lead. As three buckets of the latter pour over his head, he casts you a perplexed look.
""Did you try the doorknob?"" he asks, as twenty-seven knives delicately skewer him.
Before you can answer, he reaches for one of the gargoyle heads which, by sheerest coincidence, has just flooded him in red-orange flame, and turns it gently.
""I think it's unlocked,"" he says, stoically ignoring the host of human-sized rats which feed on his incinerated torso.
His left hand, broken and bloodied, pulls at the gargoyle head.
""I'm going on ahead!"" he cries, opening a simple wooden door.
Wooden door? You rub your eyes for a moment and look again as he goes through it. Yes, just a plain wooden door."
	CRLF	
	ADD	SCORE,DOOR-POINT >SCORE
	SET	'DOOR-POINT,0
	MOVE	ADVENTURER,MAP-ROOM
	SET	'ADVENTURER-STAY,TRUE-VALUE
	RETURN	ADVENTURER-STAY

	.ENDI
