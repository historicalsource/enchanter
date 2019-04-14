

	.FUNCT	LANDING-EXIT-F
	ZERO?	STAIR-SOLVED? /?ELS5
	PRINTI	"There is no floor there, and the pit beneath you is of great, if not infinite, depth. You fall forever."
	CALL	FINISH
	RSTACK	
?ELS5:	RETURN	ENDLESS-STAIR


	.FUNCT	ADVENTURER-DROPS-OUT
	PRINTI	"The adventurer seems to have dropped out of existence. In a voice that seems to recede into the void, you hear his final word: ""Restore...."" You muse about how a mere adventurer might come to possess a spell of such power."
	CRLF	
	REMOVE	ADVENTURER
	CALL	QUEUE,I-ADVENTURER,0
	RTRUE	


	.FUNCT	STAIRS-F
	EQUAL?	HERE,JUNCTION \?ELS5
	PRINTR	"The stairs are to the east. You'll have to go there to get a look."
?ELS5:	EQUAL?	HERE,ENDLESS-STAIR \FALSE
	EQUAL?	PRSA,V?KULCAD \FALSE
	CALL	STAIR-DISPEL
	RSTACK	


	.FUNCT	STAIR-DISPEL
	CALL	QUEUE,I-HUNGER,0
	CALL	QUEUE,I-THIRST,0
	CALL	QUEUE,I-TIRED,0
	CALL	QUEUE,I-TURTLE,0
	SET	'STAIR-SOLVED?,TRUE-VALUE
	ADD	SCORE,STAIR-POINT >SCORE
	SET	'STAIR-POINT,0
	CALL	DESTROY-ALL,WINNER,REAL-STAIR >DROPPED-SOME?
	MOVE	FLY-SCROLL,WINNER
	PRINTI	"The stairway begins to dissolve before your eyes, leaving a circular area with exits east and west, but remarkable mainly for its absence of a floor. Indeed, you find yourself standing in midair above a deep pit with the sort of comical look which is found mainly among duped cartoon characters. Frantically, you grab for the solid bannister"
	ZERO?	DROPPED-SOME? /?CND3
	PRINTI	", dropping your heavier possessions in your desire to save yourself"
?CND3:	PRINTI	"! But the bannister shifts and dissolves as well, leaving you grasping what appears to be an ornate scroll."
	CRLF	
	CALL	THIS-IS-IT,FLY-SCROLL
	CALL	QUEUE,I-FALL-FOREVER,5
	PUT	STACK,0,1
	CALL	QUEUE,I-FALL,-1
	PUT	STACK,0,1
	CALL	INT,I-TIRED
	PUT	STACK,0,0
	CALL	GOTO,REAL-STAIR,FALSE-VALUE
	RTRUE	


	.FUNCT	ENDLESS-UP
	CALL	ENDLESS-UP-DOWN,TRUE-VALUE
	RETURN	ENDLESS-STAIR


	.FUNCT	ENDLESS-DOWN
	CALL	ENDLESS-UP-DOWN,FALSE-VALUE
	RETURN	ENDLESS-STAIR


	.FUNCT	ENDLESS-UP-DOWN,UP?
	FCLEAR	ENDLESS-STAIR,TOUCHBIT
	CALL	STAIR-TO-TABLE,STAIR-LOC
	PRINTI	"You "
	ZERO?	UP? /?ELS5
	PRINTI	"climb"
	INC	'STAIR-LOC
	JUMP	?CND3
?ELS5:	PRINTI	"descend"
	DEC	'STAIR-LOC
?CND3:	PRINTI	" the stairs, making one circuit of the tower."
	CRLF	
	CALL	TABLE-TO-STAIR,STAIR-LOC
	RSTACK	


	.FUNCT	ENDLESS-STAIR-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a winding stair, stretching up and down out of sight. The walls are mossy and damp."
	EQUAL?	STAIR-LOC,STAIR-START \?CND8
	PRINTI	" An exit leads west to a landing."
?CND8:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	RARG,M-ENTER \FALSE
	EQUAL?	WINNER,PLAYER /FALSE
	LOC	PLAYER
	IN?	WINNER,STACK /FALSE
	REMOVE	WINNER
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RFALSE	


	.FUNCT	ENDLESS-EXIT-F
	EQUAL?	STAIR-LOC,STAIR-START \?ELS5
	RETURN	LANDING
?ELS5:	PRINTI	"You can't go that way."
	CRLF	
	RFALSE	


	.FUNCT	STAIR-TO-TABLE,SLOC,TBL,CNT=0,F,N
	FIRST?	ENDLESS-STAIR >F /?KLU21
?KLU21:	SET	'TBL,STAIR-TABLE
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


	.FUNCT	TABLE-TO-STAIR,SLOC,TBL,CNT=0
	SET	'TBL,STAIR-TABLE
?PRG1:	LESS?	CNT,STAIR-TABLE-LENGTH \TRUE
	GET	TBL,CNT
	EQUAL?	STACK,SLOC \?CND3
	PUT	TBL,CNT,0
	ADD	CNT,1
	GET	TBL,STACK
	MOVE	STACK,ENDLESS-STAIR
?CND3:	ADD	CNT,2 >CNT
	JUMP	?PRG1


	.FUNCT	REAL-STAIR-EXIT-F
	SET	'FALL-COUNT,0
	ZERO?	FLYING? /?ELS5
	PRINTI	"Effortlessly, you float "
	EQUAL?	PRSO,P?DOWN \?ELS13
	SET	'FALL-COUNT,1
	PRINTI	"downward."
	CRLF	
	CALL	DESTROY-ALL,HERE,PIT
	RETURN	PIT
?ELS13:	EQUAL?	PRSO,P?EAST \?ELS17
	ADD	SCORE,FLY-POINT >SCORE
	SET	'FLY-POINT,0
	CALL	STOP-FLYING
	PRINTI	"eastward and settle to the ground."
	CRLF	
	RETURN	WARLOCK-TOWER
?ELS17:	EQUAL?	PRSO,P?WEST \FALSE
	CALL	STOP-FLYING
	PRINTI	"westward and settle to the ground."
	CRLF	
	RETURN	LANDING
?ELS5:	PRINTI	"You must think you can fly."
	CRLF	
	RFALSE	


	.FUNCT	PIT-EXIT-F
	ZERO?	FLYING? /?ELS5
	PRINTI	"Effortlessly, you float "
	EQUAL?	PRSO,P?DOWN \?ELS11
	INC	'FALL-COUNT
	PRINTI	"downward."
	CRLF	
	JUMP	?CND9
?ELS11:	DEC	'FALL-COUNT
	PRINTI	"upward."
	CRLF	
?CND9:	ZERO?	FALL-COUNT \?ELS22
	CALL	DESTROY-ALL,HERE,REAL-STAIR
	RETURN	REAL-STAIR
?ELS22:	CALL	DESTROY-ALL,HERE,PIT
	FCLEAR	PIT,TOUCHBIT
	RETURN	PIT
?ELS5:	PRINTI	"You must think you can fly."
	CRLF	
	RFALSE	


	.FUNCT	PIT-F,RARG
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?DROP \?ELS10
	CALL	HELD?,PRSO
	ZERO?	STACK /?ELS10
	FSET	PRSO,NDESCBIT
	FCLEAR	PRSO,TAKEBIT
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" falls out of sight below you."
?ELS10:	EQUAL?	PRSA,V?EXAMINE,V?TAKE \FALSE
	CALL	HELD?,PRSO
	ZERO?	STACK \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" is out of reach below you."


	.FUNCT	STOP-FLYING
	SET	'FLYING?,FALSE-VALUE
	CALL	QUEUE,I-FALL,0
	CALL	QUEUE,I-FALL-FOREVER,0
	CALL	QUEUE,I-FLY,0
	RTRUE	


	.FUNCT	I-FALL
	ZERO?	FLYING? \TRUE
	INC	'FALL-COUNT
	PRINTI	"You plummet downward, deeper into the pit, but the bottom is still not visible."
	ZERO?	DROPPED-SOME? /TRUE
	PRINTR	" Far ahead of you fall your former possessions."


	.FUNCT	I-FALL-FOREVER
	PRINTI	"You plummet deeper and deeper into the pit! Oddly enough, you never seem to hit bottom. After many years, only tattered remnants of you remain, still falling."
	CRLF	
	CALL	FINISH
	RSTACK	


	.FUNCT	DESTROY-ALL,WHO,WHERE,N,X,DEST?=0
	FIRST?	WHO >X /?KLU11
?KLU11:	
?PRG1:	ZERO?	X \?CND3
	RETURN	DEST?
?CND3:	NEXT?	X >N /?KLU12
?KLU12:	EQUAL?	X,WINNER /?CND6
	GETP	X,P?SIZE
	GRTR?	STACK,4 \?CND6
	CALL	REMOVE-ALL,X
	MOVE	X,WHERE
	FSET	X,NDESCBIT
	FCLEAR	X,TAKEBIT
	SET	'DEST?,TRUE-VALUE
?CND6:	SET	'X,N
	JUMP	?PRG1


	.FUNCT	REMOVE-ALL,WHAT,N,X
	FIRST?	WHAT >X /?KLU6
?KLU6:	
?PRG1:	ZERO?	X /TRUE
	NEXT?	X >N /?KLU7
?KLU7:	REMOVE	X
	SET	'X,N
	JUMP	?PRG1


	.FUNCT	WARLOCK-TOWER-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	FSET	WARLOCK-TOWER,TOUCHBIT
	PRINTI	"As you enter, you realize that this is Krill's secret chamber, protected by powerful illusions now broken by your skills. Before you stands Krill, engaged in the casting of some complex and horrific magic. Krill turns to face you, surprised and annoyed by your intrusion. You have seen him before: cloaked in black, he sacrificed you at the Altar before his hoard. His yellow eyes glisten and he breathes deeply. In a voice as deep as the great caverns of the earth, he speaks: ""Fool! Parlor magician! You dare to defile my chamber with your worm-like presence. I shall not waste words with you. Goodbye, spell-monger!"""
	EQUAL?	HASTED?,PLAYER \?CND8
	PRINTI	" He pauses. ""Ah! You seem to be in a hurry, campfire-conjurer! Slow down and enjoy the show!"" He waves his hand, and you are robbed of your energy."
?CND8:	PRINTI	" Krill snaps his fingers loudly, and a giant dragon appears, breathing gouts of flame. He moves ever closer, red eyes bulging with malice!"
	CRLF	
	CRLF	
	MOVE	DRAGON,HERE
	CALL	QUEUE,I-DRAGON,2
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	GLOBAL-KRILL-F
	EQUAL?	PRSA,V?GIVE,V?HELLO,V?GUNCHO \?ELS5
	PRINTR	"Krill is not here, and lucky for you."
?ELS5:	EQUAL?	PRSA,V?ZIFMIA \?ELS9
	CALL	JIGS-UP,STR?85,FALSE-VALUE
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?WHO,V?EXAMINE \?ELS11
	PRINTR	"Krill is an evil warlock who was banished from the Circle of Enchanters. His malice was thought to be forever ended, his reign of terror a dim and frightful memory. But he has returned, and his power must be destroyed lest the Circle's great works be overthrown."
?ELS11:	CALL	GLOBAL-NOT-HERE-PRINT,GLOBAL-KRILL
	RTRUE	


	.FUNCT	DRAGON-F
	EQUAL?	PRSA,V?GONDAR \?ELS5
	PRINTI	"The dragon's flame is doused in a torrent of water as you cast the gondar spell! He disappears with a torturous scream."
	REMOVE	DRAGON
	CALL	SECOND-ACT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?NITFOL,V?VAXUM \?ELS9
	PRINTI	"The dragon pauses and roars out a benevolent greeting, which, to your chagrin, fries you to a delicate crisp."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?GUNCHO \?ELS13
	PRINTI	"Unfortunately, the dragon is practically on top of you, and before you can finish saying the guncho spell he blasts you to beyond well-done."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS13:	EQUAL?	PRSA,V?CLEESH \?ELS17
	PRINTR	"The dragon, being reptilian himself, is unaffected."
?ELS17:	EQUAL?	PRSA,V?MUNG,V?ATTACK,V?KILL \FALSE
	PRINTR	"Your strength isn't nearly enough to best the dragon!"


	.FUNCT	SECOND-ACT,GUNCH=0
	CRLF	
	PRINTI	"Krill "
	ZERO?	GUNCH /?ELS5
	PRINTI	"seems shaken, but regains his composure."
	JUMP	?CND3
?ELS5:	PRINTI	"seems to be somewhat amused."
?CND3:	CRLF	
	CRLF	
	PRINTI	"""A fine spell, wizard-worm, but your luck has ended!"" With another snap of his fingers, he summons a being whose essence is evil. It has a shape which is masked by its blackness and exudes a foul, fetid odor. In its hand is a large battle axe. At a signal from Krill, it advances!"
	CRLF	
	CALL	QUEUE,I-SHAPE,2
	PUT	STACK,0,1
	MOVE	SHAPE,HERE
	RTRUE	


	.FUNCT	I-DRAGON
	IN?	DRAGON,HERE \?CND1
	EQUAL?	DEATH-CHEATED,ME /?THN7
	ZERO?	PROTECTED-FROM-EVIL /?CND4
?THN7:	PRINT	NO-LONGER-PROTECTED
	CRLF	
?CND4:	PRINTI	"The dragon engulfs you in flame. As you perish, you can hear Krill's mocking laughter."
	CRLF	
	CALL	FINISH
?CND1:	CALL	QUEUE,I-DRAGON,0
	RTRUE	


	.FUNCT	SHAPE-F
	EQUAL?	PRSA,V?VAXUM \?ELS5
	PRINTI	"The monster hesitates, stops, smiles, and disappears."
	CRLF	
	CALL	THIRD-ACT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?CLEESH \?ELS9
	PRINTI	"The monster hesitates, trembles, then turns into a newt. Poor monster. Its battle axe, now unsupported, falls on it, slicing it neatly in half."
	CRLF	
	CALL	THIRD-ACT
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?NITFOL \?ELS13
	PRINTI	"""Yum, yum!"" are the last words you hear."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS13:	EQUAL?	PRSA,V?GUNCHO \?ELS17
	PRINTI	"The monster pauses for a moment as you begin the guncho spell, then swiftly cleaves you with its axe before you can finish!"
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS17:	EQUAL?	PRSA,V?MUNG,V?ATTACK,V?KILL \FALSE
	PRINTR	"Your effort is useless. It is still coming closer!"


	.FUNCT	THIRD-ACT
	REMOVE	SHAPE
	CRLF	
	PRINTI	"Krill seems to be losing patience.

""I am through playing games, carnival-clown! You shall return to your Circle, but I am afraid that all the little pieces will prove hard to reassemble!"" He laughs hideously and starts a guttural chant which shakes the very tower."
	CRLF	
	SET	'KRILL-KILL,TRUE-VALUE
	CALL	QUEUE,I-BYE,2
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-SHAPE
	IN?	SHAPE,HERE \?CND1
	EQUAL?	DEATH-CHEATED,ME /?THN7
	ZERO?	PROTECTED-FROM-EVIL /?CND4
?THN7:	PRINT	NO-LONGER-PROTECTED
	CRLF	
?CND4:	PRINTI	"The monster hits you with its battle axe! You fall, dead, as the laughter of Krill reaches a crescendo!"
	CRLF	
	CALL	FINISH
?CND1:	CALL	QUEUE,I-SHAPE,0
	RTRUE	


	.FUNCT	I-BYE
	EQUAL?	HERE,WARLOCK-TOWER \FALSE
	CRLF	
	PRINTI	"Krill finishes his spell and his harsh laughter is all that remains! You are in a void, without sight, sound, or sensation. You scream at the top of your lungs, but nothing happens. You break into a cold sweat as you ponder the infinite, beyond all help and hope!"
	CRLF	
	CALL	FINISH
	RSTACK	


	.FUNCT	KRILL-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"Krill is not a pretty sight! Enough said."
?ELS5:	EQUAL?	PRSA,V?GUNCHO \?ELS9
	ZERO?	KRILL-KILL /?ELS9
	PRINTI	"Krill recoils as he hears the first words of the guncho spell. For a few seconds he continues with the spell he was casting, trying to finish before you. He fumbles some syllables! Then he steps back and, with his hands outstretched toward you, lets out a bloodcurdling scream. His face twisted, and his body vibrating with the effort of resisting the enchantment, he utters a spell of power, and is gone! After a quiet moment, a rumble begins deep in the earth. It strengthens as the tower starts to sway. The floor gives way beneath you and you tumble down towards the sea ... then you are surrounded by a burst of light.

You realize that you are with the Circle. The Eldest of the Circle, Belboz, rises and speaks: ""The evil of Krill is ended this day. From beyond hope, you have proved yourself great and worthy. Our hearts are gladdened at your return."" A chair appears at his right hand and he motions for you to sit beside him. He smiles warmly. ""Join with us,"" he says, ""and tell us of your quest!""

Here ends the first chapter of the Enchanter saga, in which, by virtue of your skills, you have joined the Circle of Enchanters. Further adventures await you as the Enchanter series continues."
	CRLF	
	CRLF	
	ADD	SCORE,WARLOCK-POINT >SCORE
	USL	
	CALL	FINISH
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?CLEESH \?ELS15
	PRINTR	"Krill shimmers for a moment, then laughs heartily. The laugh sounds vaguely like a croak, but perhaps it is only your imagination."
?ELS15:	EQUAL?	PRSA,V?VAXUM \?ELS19
	PRINTR	"The spell seems to have no influence over Krill. You wouldn't much like to see him smile, anyway."
?ELS19:	EQUAL?	PRSA,V?GUNCHO \?ELS23
	PRINTI	"The look of surprise on Krill's face as you recite the first few syllables of the guncho spell is exceeded only by your look of disappointment as you are "
	IN?	SHAPE,HERE \?ELS30
	PUSH	STR?88
	JUMP	?CND26
?ELS30:	PUSH	STR?89
?CND26:	PRINT	STACK
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS23:	EQUAL?	PRSA,V?HELLO \FALSE
	PRINTR	"Krill grins and the sight is ghastly."


	.FUNCT	I-MUNG-ROOM,TELL?=1,RM,TBL
	CALL	QUEUE,I-MUNG-ROOM,20
	PUT	STACK,0,1
	SET	'TBL,MUNG-ROOM-TABLE
?PRG1:	GET	TBL,0 >RM
	ZERO?	RM /?REP2
	FSET?	RM,RMUNGBIT /?CND6
	JUMP	?REP2
?CND6:	ADD	TBL,2 >TBL
	JUMP	?PRG1
?REP2:	ZERO?	RM /?CND11
	FSET	RM,RMUNGBIT
	FCLEAR	RM,TOUCHBIT
	ZERO?	TELL? /?CND11
	EQUAL?	RM,HERE \?CND11
	PRINTI	"Suddenly, you sense a great wind of evil magic blowing around you. You are weighed down by its power, and only your sorcerous training permits you to withstand it. When you regain your composure, your surroundings have changed."
	CRLF	
?CND11:	RETURN	RM

	.ENDI
