

	.FUNCT	MACHINERY-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The machinery is extremely noisy and complicated. Other than that, you can't imagine of what use it is to anybody."
?ELS5:	EQUAL?	PRSA,V?AVOID \?ELS9
	CALL	HAMMER-F
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?EXEX \FALSE
	PRINTR	"The machinery may or may not have been sped up, the facts being hard to determine."


	.FUNCT	ENGINE-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The room is filled with noise: crashing and smashing, gurgling of water, grinding of gears, and horrible screeching of metal. Huge devices of obscure purpose provide these effects. The most notable is a huge hammer that smashes continually against the stone floor: it makes any crossing of the room a dangerous enterprise. The whole construction brings to mind the words ""Infernal Machine."" Far off to the southeast is another room."
	IN?	DISPEL-SCROLL,CLOSET \?CND8
	PRINTI	" You can barely make out something on the floor of that room. It might be a scroll, but from here you can't tell for sure."
?CND8:	CRLF	
	IN?	TURTLE,CLOSET \TRUE
	PRINTR	"Across the room you can see the rainbow turtle, who frequently looks your way."


	.FUNCT	HAMMER-F
	EQUAL?	PRSA,V?WALK-AROUND,V?AVOID \?ELS5
	PRINTR	"It's hard to see how you'll avoid a painful experience."
?ELS5:	EQUAL?	PRSA,V?EXEX \FALSE
	SET	'HAMMER-EXEX,TRUE-VALUE
	PRINTR	"The crashing of the hammer has become more frequent."


	.FUNCT	SE-TOWER-F,RARG=0
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \FALSE
	EQUAL?	PRSO,P?UP \?ELS10
	CALL	QUEUE,I-CRASH,2
	PUT	STACK,0,1
	RFALSE	
?ELS10:	CALL	INT,I-CRASH
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	LIGHTS-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"The lights and displays hold no meaning for you. A random number generator may be controlling the whole thing, for all you know."


	.FUNCT	I-CRASH
	LOC	PLAYER
	EQUAL?	STACK,ENGINE-ROOM,CLOSET,SE-TOWER /?CND1
	CALL	INT,I-CRASH
	PUT	STACK,0,0
	RFALSE	
?CND1:	ZERO?	CRASH? \?PRD4
	PUSH	1
	JUMP	?PRD5
?PRD4:	PUSH	0
?PRD5:	SET	'CRASH?,STACK
	ZERO?	CRASH? \?THN9
	ZERO?	HAMMER-EXEX /?CND6
?THN9:	PRINTI	"""Crash!"" A huge hammer smashes against the stone floor"
	IN?	PLAYER,CLOSET \?CND13
	PRINTI	" outside"
?CND13:	PRINTI	"."
	CRLF	
?CND6:	ZERO?	FAST? \?THN25
	ZERO?	HAMMER-EXEX /?ELS24
?THN25:	PUSH	1
	JUMP	?CND20
?ELS24:	PUSH	2
?CND20:	CALL	QUEUE,I-CRASH,STACK
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	CROSS-ENGINE-ROOM
	EQUAL?	HASTED?,WINNER \?ELS5
	SET	'FAST?,TRUE-VALUE
	EQUAL?	WINNER,TURTLE \?ELS8
	PRINTI	"As the turtle starts across, he seems to set off something, for the machinery speeds up and the noise level becomes almost unbearable. Luckily, he makes it to the other side safely!"
	CRLF	
	RETURN	CLOSET
?ELS8:	PRINTI	"You zip across the room easily, but you must have touched something dangerous along the way, because the machinery speeds up, going faster and faster."
	CRLF	
	RETURN	CLOSET
?ELS5:	EQUAL?	WINNER,TURTLE \?ELS16
	CALL	INT,I-TURTLE
	PUT	STACK,0,0
	PRINTI	"The poor turtle starts, but he's just too slow. About halfway across the room he is dispatched by the enormous hammer, leaving only a rainbow colored smudge on the floor."
	EQUAL?	DEATH-CHEATED,TURTLE \?CND19
	SET	'DEATH-CHEATED,FALSE-VALUE
	CRLF	
	CRLF	
	PRINTI	"But wait! Amazingly, the smudge reforms into a turtle again! The revived turtle just has time to turn his head in wonderment when the hammer smashes down again, remaking the rainbow smudge."
?CND19:	PRINTI	" Even that disappears at the next blow of the hammer."
	CRLF	
	CALL	JIGS-UP,FALSE-VALUE,FALSE-VALUE
	RFALSE	
?ELS16:	ZERO?	FAST? \?THN28
	ZERO?	CRASH? /?ELS27
?THN28:	PRINTI	"You start across the room, but less than halfway across, the huge hammer crashes down, right on top of you!"
	CRLF	
	EQUAL?	DEATH-CHEATED,ME \?CND32
	PRINTI	"Startlingly, you revive from this fatal blow, but even more startlingly, the first thing you see is the same huge hammer descending upon you!"
	CRLF	
?CND32:	CALL	JIGS-UP,FALSE-VALUE,FALSE-VALUE
	RFALSE	
?ELS27:	SET	'FAST?,TRUE-VALUE
	PRINTI	"You make it across the room, but just barely; just as you duck through the door, a huge hammer crashes down behind, missing by an inch. Something you stepped on along the way clicked as well, and with a horrible screeching noise, the machinery speeds up, crashing faster and faster until it's twice as fast as before."
	CRLF	
	CRLF	
	RETURN	CLOSET


	.FUNCT	RECROSS-ENGINE-ROOM
	EQUAL?	WINNER,TURTLE \?ELS5
	EQUAL?	HASTED?,TURTLE \?ELS10
	IN?	DISPEL-SCROLL,CLOSET \?CND11
	SET	'TURTLE-REPORT?,TRUE-VALUE
?CND11:	PRINTI	"The turtle fairly zips across the engine room, dodging the giant hammers and gears. Suddenly he sets off a trap, and sharp spears fly at him from all directions! But they bounce harmlessly off his shell! He avoids one last crash of a huge hammer, but even at his speed, it's a near thing! With one more burst of speed, he reaches "
	IN?	PLAYER,ENGINE-ROOM \?ELS20
	PUSH	STR?284
	JUMP	?CND16
?ELS20:	PUSH	STR?285
?CND16:	PRINT	STACK
	PRINTI	" safely!"
	CRLF	
	RETURN	ENGINE-ROOM
?ELS10:	CALL	INT,I-TURTLE
	PUT	STACK,0,0
	PRINTI	"The turtle starts across the room, as hammers and gears slowly turn and crash. Partway across the room, he sets off a trap! Spears fly at him from all directions! They just bounce off his shell, and he is unhurt. Unfortunately, at about this time, a enormous hammer smashes down. This does not bounce off his shell, and the poor creature expires."
	CRLF	
	EQUAL?	DEATH-CHEATED,TURTLE \?CND27
	PRINTI	"Astoundingly, the turtle renews himself! Unfortunately, he makes it no further, for the hammer is still too much for even his armor."
	CRLF	
?CND27:	CALL	JIGS-UP,FALSE-VALUE,FALSE-VALUE
	RFALSE	
?ELS5:	IN?	DISPEL-SCROLL,WINNER \?CND34
	REMOVE	DISPEL-SPELL
	REMOVE	DISPEL-SCROLL
?CND34:	EQUAL?	HASTED?,WINNER \?ELS39
	PRINTI	"You rush across the engine room, your speed enabling you to avoid the gigantic hammers and gears; at this speed they appear to move with great deliberation. Unfortunately, you set off a trap, and many sharp spears fly at you from all directions! They seem to move pretty fast. Too fast, in fact. You can't dodge them, and you are severely skewered."
	JUMP	?CND37
?ELS39:	PRINTI	"You run across the room, trying to dodge the crashing machinery, and you are succeeding for a while until you set off a trap. A volley of sharp spears, powered by cunning machinery, comes at you from all directions. You are skewered! The huge hammer crashes down for the coup de grace."
?CND37:	CRLF	
	EQUAL?	DEATH-CHEATED,ME \?CND46
	PRINTI	"In an astounding feat of magic, you are reassembled and revived. In an even more astounding feat of trap design, you are dispatched again almost before you can take a breath."
	CRLF	
?CND46:	CALL	JIGS-UP,FALSE-VALUE,FALSE-VALUE
	RFALSE	


	.FUNCT	WAVES-F
	EQUAL?	PRSA,V?THROUGH,V?SWIM \FALSE
	PRINTR	"Don't press your luck. You'd probably drown."


	.FUNCT	SEA-STUFF-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"There's nothing much interesting to see."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"Why bother?"


	.FUNCT	NO-RESPONSE
	PRINTR	"You hear no response."


	.FUNCT	TURTLE-F,NEAR?
	LOC	PLAYER
	IN?	TURTLE,STACK /?PRD1
	PUSH	0
	JUMP	?PRD2
?PRD1:	PUSH	1
?PRD2:	SET	'NEAR?,STACK
	EQUAL?	WINNER,TURTLE \?ELS7
	MOVE	GLOBAL-TURTLE,GLOBAL-OBJECTS
	ZERO?	TURTLE-TIRED? /?CND8
	ZERO?	NEAR? /?ELS14
	PRINTR	"The turtle is asleep and appears oblivious to your words."
?ELS14:	CALL	NO-RESPONSE
	RTRUE	
?CND8:	CALL	QUEUE,I-TURTLE,-1
	PUT	STACK,0,1
	FSET	TURTLE,TOUCHBIT
	EQUAL?	TALK-TO-ANIMAL?,TURTLE /?ELS24
	ZERO?	NEAR? /?ELS27
	PRINTI	"The turtle looks at you quizzically. It's clear he would like to understand you, but he doesn't. He responds, but it's only snaps, hisses, and clicks to you."
	CRLF	
	JUMP	?CND25
?ELS27:	CALL	NO-RESPONSE
?CND25:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RTRUE	
?ELS24:	EQUAL?	PRSA,V?WALK \?ELS34
	SET	'TURTLE-FOLLOWS,FALSE-VALUE
	INC	'TF-COUNT
	IN?	TURTLE,INSIDE-GATE \?ELS39
	EQUAL?	PRSO,P?WEST \?ELS39
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	PRINTR	"""Uh, no thanks. I prefer to stay near my beach. I don't see much yummy seaweed out that way."""
?ELS39:	IN?	TURTLE,DIM-DESCENT \?ELS45
	EQUAL?	PRSO,P?DOWN,P?SOUTH \?ELS45
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	PRINTR	"""Uh, no thanks. It looks dark and scary down there, and I get a kind of bad feeling about it, like you get when you eat old seaweed."""
?ELS45:	EQUAL?	PRSO,P?UP \?ELS51
	LOC	TURTLE
	CALL	GLOBAL-IN?,STAIRS,STACK
	ZERO?	STACK /?ELS51
	ZERO?	NEAR? /FALSE
	PRINTI	"The turtle huffs and puffs up the stairs. ""Pretty steep stairs for a turtle, friend..."""
	CRLF	
	RFALSE	
?ELS51:	EQUAL?	PRSO,P?DOWN \?ELS61
	LOC	TURTLE
	CALL	GLOBAL-IN?,STAIRS,STACK
	ZERO?	STACK /?ELS61
	ZERO?	NEAR? /?CND64
	PRINTI	"""Those stairs are pretty steep. I'll follow you down, but I'm not going alone!"""
	CRLF	
?CND64:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RTRUE	
?ELS61:	GRTR?	TF-COUNT,4 \FALSE
	MOD	TF-COUNT,6
	ZERO?	STACK \FALSE
	CALL	TURTLE-TIRES
	RFALSE	
?ELS34:	EQUAL?	PRSA,V?WHO \?ELS75
	ZERO?	NEAR? /?ELS80
	PRINTR	"""Never heard of him."""
?ELS80:	CALL	NO-RESPONSE
	RSTACK	
?ELS75:	EQUAL?	PRSA,V?THANK \?ELS87
	CALL	TURTLE-THANKS,NEAR?
	RSTACK	
?ELS87:	EQUAL?	PRSA,V?STAY \?ELS89
	EQUAL?	PRSO,GLOBAL-ROOM,FALSE-VALUE \?ELS89
	SET	'TURTLE-FOLLOWS,FALSE-VALUE
	ZERO?	NEAR? /?ELS96
	PRINTR	"The turtle hisses, ""Okay, I'll stay here for a while."""
?ELS96:	CALL	NO-RESPONSE
	RSTACK	
?ELS89:	EQUAL?	PRSA,V?FOLLOW \?ELS103
	EQUAL?	PRSO,ME,FALSE-VALUE \?ELS108
	SET	'TURTLE-FOLLOWS,TRUE-VALUE
	SET	'TF-COUNT,0
	SET	'TURTLE-TIRED-TELL,FALSE-VALUE
	ZERO?	NEAR? /?ELS113
	PRINTR	"The turtle hisses, ""I will follow you."""
?ELS113:	CALL	NO-RESPONSE
	RSTACK	
?ELS108:	ZERO?	NEAR? /?ELS120
	PRINTR	"The turtle hisses, ""I'd follow you, but not that!"""
?ELS120:	CALL	NO-RESPONSE
	RSTACK	
?ELS103:	EQUAL?	PRSA,V?BRING,V?TAKE \?ELS127
	LOC	PLAYER
	IN?	TURTLE,STACK /?ELS127
	EQUAL?	PRSA,V?BRING \?CND130
	SET	'PRSO,PRSI
	SET	'PRSI,FALSE-VALUE
?CND130:	CALL	ITAKE,FALSE-VALUE
	EQUAL?	PRSA,V?BRING \?CND133
	EQUAL?	HERE,CLOSET \?ELS140
	PUSH	P?NW
	JUMP	?CND136
?ELS140:	PUSH	P?SE
?CND136:	CALL	DO-WALK,STACK
	RTRUE	
?CND133:	EQUAL?	HERE,CLOSET \TRUE
	IN?	PLAYER,ENGINE-ROOM \TRUE
	PRINTI	"The turtle sticks his head through the door across the mechanical wasteland."
	IN?	DISPEL-SCROLL,TURTLE \?CND150
	PRINTI	" In his mouth is a scroll of some sort."
?CND150:	CRLF	
	RTRUE	
?ELS127:	EQUAL?	PRSA,V?TAKE \?ELS156
	FSET?	PRSO,SCROLLBIT /FALSE
	ZERO?	NEAR? /?ELS166
	PRINTR	"""I don't think I can carry that too easily."""
?ELS166:	CALL	NO-RESPONSE
	RSTACK	
?ELS156:	EQUAL?	PRSA,V?OPEN \?ELS175
	FSET?	PRSO,DOORBIT \?ELS175
	ZERO?	NEAR? /?ELS182
	PRINTR	"""I can't reach the latch. I'm a turtle, not an ostrich."""
?ELS182:	CALL	NO-RESPONSE
	RSTACK	
?ELS175:	EQUAL?	PRSA,V?HELLO \?ELS189
	ZERO?	NEAR? /?ELS194
	PRINTI	""""
	CALL	PICK-ONE,TURTLE-REMARKS
	PRINT	STACK
	PRINTR	""""
?ELS194:	CALL	NO-RESPONSE
	RSTACK	
?ELS189:	LOC	PLAYER
	IN?	TURTLE,STACK /?THN202
	LOC	PLAYER
	LOC	STACK
	IN?	TURTLE,STACK \?ELS201
?THN202:	PRINTR	"""I'm only a turtle, you know, even if I can talk!"""
?ELS201:	CALL	NO-RESPONSE
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?TELL \?ELS209
	EQUAL?	PRSO,GLOBAL-TURTLE \?ELS209
	ZERO?	TURTLE-TIRED? /?ELS216
	PRINTI	"The turtle remains asleep."
	CRLF	
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RETURN	2
?ELS216:	CALL	OPPOSITE-SIDES?
	ZERO?	STACK /?ELS223
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	PRINTR	"The turtle seems to bend its head as if to listen, but with all this noise it's not very likely that he hears you."
?ELS223:	SET	'P-MERGED,TRUE-VALUE
	CALL	GLOBAL-NOT-HERE-PRINT,GLOBAL-TURTLE
	RTRUE	
?ELS209:	EQUAL?	PRSO,GLOBAL-TURTLE \?ELS229
	EQUAL?	PRSA,V?YELL,V?WAVE-AT \?ELS229
	CALL	OPPOSITE-SIDES?
	ZERO?	STACK /?ELS229
	PRINTI	"The turtle takes notice, "
	EQUAL?	HERE,CLOSET \?ELS236
	PRINTR	"then glances at the rapidly pounding hammer. With a motion which might correspond to a shrug of the shoulder, he turns away, embarrassed."
?ELS236:	PRINTI	"nods his head, and starts in your direction."
	CRLF	
?CND234:	SET	'WINNER,TURTLE
	LOC	TURTLE >HERE
	EQUAL?	HERE,CLOSET \?ELS247
	PUSH	P?NW
	JUMP	?CND243
?ELS247:	PUSH	P?SE
?CND243:	CALL	DO-WALK,STACK
	RTRUE	
?ELS229:	EQUAL?	PRSO,GLOBAL-TURTLE \?ELS251
	EQUAL?	PRSA,V?EXAMINE \?ELS251
	CALL	OPPOSITE-SIDES?
	ZERO?	STACK /?ELS251
	PRINTR	"He is standing on the other side of the machinery."
?ELS251:	EQUAL?	PRSO,GLOBAL-TURTLE \?ELS257
	CALL	GLOBAL-NOT-HERE-PRINT,GLOBAL-TURTLE
	RTRUE	
?ELS257:	EQUAL?	PRSA,V?THROUGH,V?CLIMB-FOO,V?CLIMB-UP \?ELS259
	PRINTR	"The turtle doesn't allow you to get on his back."
?ELS259:	EQUAL?	PRSA,V?RUB \?ELS263
	PRINTR	"The turtle seems to appreciate the attention."
?ELS263:	EQUAL?	PRSA,V?CLEESH \?ELS267
	PRINTR	"As he is already a reptile, the spell has little effect."
?ELS267:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS271
	PRINTR	"Come now, you can't do that!"
?ELS271:	EQUAL?	PRSA,V?REZROV \?ELS275
	PRINTR	"The turtle's shell pops off his back. Mortified, he retrieves it."
?ELS275:	EQUAL?	PRSA,V?GUNCHO \?ELS279
	ZERO?	TURTLE-TIRED? /?ELS282
	PRINTI	"The sleeping turtle seems to shrink to nothing, and vanishes!"
	CRLF	
	JUMP	?CND280
?ELS282:	PRINTI	"The turtle barely has time to retract his head before he is consumed in flame!"
	CRLF	
?CND280:	REMOVE	TURTLE
	RTRUE	
?ELS279:	EQUAL?	PRSA,V?VAXUM \?ELS291
	ZERO?	TURTLE-TIRED? /?ELS296
	PRINTR	"The snoring sounds more friendly."
?ELS296:	PRINTR	"The turtle seems to make a friendly gesture, but then again turtles are pretty friendly anyway."
?ELS291:	EQUAL?	PRSA,V?MUNG \?ELS305
	PRINTI	"The turtle's shell is so thick and hard that your blow has no effect. The lovely colors on his back are not even marred."
	ZERO?	TURTLE-TIRED? /?ELS312
	PRINTR	" He doesn't even wake up."
?ELS312:	PRINTR	" He does withdraw into his shell briefly, but then emerges again."
?ELS305:	ZERO?	TURTLE-TIRED? /?ELS321
	PRINTI	"The turtle remains asleep."
	CRLF	
	SET	'P-CONT,FALSE-VALUE
	RETURN	2
?ELS321:	EQUAL?	PRSA,V?THANK \?ELS328
	EQUAL?	TALK-TO-ANIMAL?,TURTLE \?ELS328
	CALL	TURTLE-THANKS,TRUE-VALUE
	RSTACK	
?ELS328:	EQUAL?	PRSA,V?TAKE \?ELS332
	EQUAL?	TURTLE,PRSO \?ELS332
	PRINTR	"The turtle is much too large to take."
?ELS332:	EQUAL?	PRSA,V?GIVE \?ELS338
	PRINTI	"The turtle extends his head towards the "
	PRINTD	PRSO
	PRINTR	", but decides it's not very interesting, and withdraws."
?ELS338:	EQUAL?	PRSA,V?HELLO \FALSE
	PRINTI	""""
	CALL	PICK-ONE,TURTLE-REMARKS
	PRINT	STACK
	PRINTR	""""


	.FUNCT	TURTLE-THANKS,NEAR?
	ZERO?	TURTLE-POINT \?ELS3
	MOVE	TURTLE,BEACH
	ZERO?	NEAR? /?ELS6
	PRINTR	"""Glad to be of help. I think I'll get back to the beach, now."" The turtle departs."
?ELS6:	PRINTR	"There is no response."
?ELS3:	ZERO?	NEAR? /?ELS15
	PRINTR	"""You're very welcome! It's nice to have someone to talk to for a change."""
?ELS15:	CALL	NO-RESPONSE
	RTRUE	


	.FUNCT	OPPOSITE-SIDES?
	EQUAL?	HERE,ENGINE-ROOM,CLOSET \FALSE
	LOC	TURTLE
	EQUAL?	STACK,ENGINE-ROOM,CLOSET \FALSE
	LOC	TURTLE
	EQUAL?	HERE,STACK \TRUE
	RFALSE


	.FUNCT	I-TURTLE,LP
	LOC	PLAYER >LP
	FSET	TURTLE,TOUCHBIT
	ZERO?	TURTLE-FOLLOWS /?ELS5
	IN?	TURTLE,LP /?ELS5
	INC	'TF-COUNT
	EQUAL?	LP,WEST-CASTLE,DUNGEON,BED \?ELS12
	SET	'TURTLE-FOLLOWS,FALSE-VALUE
	PRINTR	"The turtle won't follow any further."
?ELS12:	EQUAL?	LP,CLOSET \?ELS20
	IN?	TURTLE,ENGINE-ROOM /?THN17
?ELS20:	EQUAL?	LP,ENGINE-ROOM \?ELS16
	IN?	TURTLE,CLOSET \?ELS16
?THN17:	SET	'TURTLE-FOLLOWS,FALSE-VALUE
	PRINTR	"The turtle seems hesitant to follow you across the room. He looks at you as if he wants an explicit order."
?ELS16:	MOVE	TURTLE,LP
	EQUAL?	LP,ENDLESS-STAIR \?ELS31
	PRINTI	"You notice that the turtle is no longer following you. In fact, he seems to have vanished entirely."
	CRLF	
	REMOVE	TURTLE
	CALL	QUEUE,I-TURTLE,0
	SET	'TURTLE-FOLLOWS,FALSE-VALUE
	RTRUE	
?ELS31:	EQUAL?	LP,ENGINE-ROOM \?ELS35
	PRINTR	"""Pretty steep stairs for a turtle, friend. But if you say so..."""
?ELS35:	EQUAL?	HASTED?,TURTLE \?ELS39
	PRINTR	"The turtle, moving with terrific speed, follows you."
?ELS39:	GRTR?	TF-COUNT,4 \?ELS43
	CALL	TURTLE-TIRES
	RSTACK	
?ELS43:	PRINTR	"The turtle, at his own leisurely pace, follows you."
?ELS5:	ZERO?	TURTLE-REPORT? /?ELS49
	LOC	TURTLE
	IN?	PLAYER,STACK \?ELS49
	SET	'TURTLE-REPORT?,FALSE-VALUE
	PRINTR	"The returned turtle reports that the door across the way opens into a room with much magic in it: bright lights and other things he doesn't understand too well. He says there is an object of rolled paper lying on the floor as well."
?ELS49:	IN?	DISPEL-SCROLL,TURTLE \FALSE
	IN?	TURTLE,LP \FALSE
	EQUAL?	HERE,CLOSET /FALSE
	MOVE	DISPEL-SCROLL,LP
	CALL	THIS-IS-IT,DISPEL-SCROLL
	ADD	SCORE,TURTLE-POINT >SCORE
	SET	'TURTLE-POINT,0
	PRINTR	"The turtle drops a brittle scroll at your feet. ""Not bad, huh?"""


	.FUNCT	TURTLE-TIRES
	ZERO?	TURTLE-FOLLOWS /FALSE
	GRTR?	TF-COUNT,20 \?ELS8
	SET	'TURTLE-TIRED?,TRUE-VALUE
	SET	'TURTLE-FOLLOWS,FALSE-VALUE
	CALL	INT,I-TURTLE
	PUT	STACK,0,0
	PRINTR	"The turtle has closed his shell, and fallen asleep. A quiet snoring sound issues from somewhere within."
?ELS8:	ZERO?	TURTLE-TIRED-TELL \?ELS12
	SET	'TURTLE-TIRED-TELL,TRUE-VALUE
	PRINTR	"""How long do you expect me to follow you around, anyway? I'm getting kind of tired, too. You would if you had a shell as heavy as mine. It's all right for now, though."""
?ELS12:	PRINTR	"The turtle, at his own leisurely pace, follows you."

	.ENDI
