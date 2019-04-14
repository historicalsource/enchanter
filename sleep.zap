

	.FUNCT	V-TIME,EL
	DIV	TOD,10 >EL
	PRINTI	"It would be "
	GET	TIME-TABLE,EL
	PRINT	STACK
	PRINTR	" now."


	.FUNCT	GLOBAL-SLEEP-F
	EQUAL?	PRSA,V?TAKE,V?WALK-TO \?ELS5
	IN?	WINNER,BEDROOM \?CND6
	MOVE	WINNER,BED
?CND6:	CALL	PERFORM,V?SLEEP
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?FIND \FALSE
	PRINTR	"Why not find a bed to sleep in?"


	.FUNCT	I-THIRST
	IGRTR?	'THIRST-COUNT,5 \?ELS5
	SET	'THIRST-COUNT,0
	CALL	QUEUE,I-THIRST,40
	SET	'WINNER,PLAYER
	CALL	JIGS-UP,STR?240,FALSE-VALUE
	RSTACK	
?ELS5:	GET	THIRST-TABLE,THIRST-COUNT
	PRINT	STACK
	CRLF	
	CALL	QUEUE,I-THIRST,10
	RSTACK	


	.FUNCT	I-HUNGER
	IGRTR?	'HUNGER-COUNT,5 \?ELS5
	SET	'HUNGER-COUNT,0
	CALL	QUEUE,I-HUNGER,47
	SET	'WINNER,PLAYER
	CALL	JIGS-UP,STR?247,FALSE-VALUE
	RSTACK	
?ELS5:	GET	HUNGER-TABLE,HUNGER-COUNT
	PRINT	STACK
	CRLF	
	CALL	QUEUE,I-HUNGER,10
	RSTACK	


	.FUNCT	I-TIRED,FORG=0
	IN?	WINNER,BED \?CND1
	PRINTI	"The bed sure is comfortable and you are becoming tired."
	CRLF	
	CALL	V-SLEEP,TRUE-VALUE
	RETURN	2
?CND1:	GRTR?	LOAD-ALLOWED,10 \?CND8
	SUB	LOAD-ALLOWED,10 >LOAD-ALLOWED
?CND8:	GRTR?	FUMBLE-NUMBER,1 \?CND11
	DEC	'FUMBLE-NUMBER
?CND11:	INC	'FUMBLE-PROB
	GRTR?	SPELL-MAX,1 \?CND14
	DEC	'SPELL-MAX
	ZERO?	SPELL-ROOM /?CND17
	DEC	'SPELL-ROOM
?CND17:	ZERO?	SPELL-ROOM \?CND14
	SET	'FORG,TRUE-VALUE
	CALL	FORGET-SPELL,DISPEL-SPELL
?CND14:	CALL	QUEUE,I-TIRED,10
	PUT	STACK,0,1
	INC	'AWAKE
	GRTR?	AWAKE,10 \?ELS27
	PRINTI	"You drop in your tracks from exhaustion."
	CRLF	
	CRLF	
	CALL	V-SLEEP
	RETURN	2
?ELS27:	PRINTI	"You are "
	GET	TIRED-TELL,AWAKE
	PRINT	STACK
	ZERO?	FORG /?CND36
	PRINTI	" and the spells you've memorized are becoming confused"
?CND36:	PRINTR	"."


	.FUNCT	V-DIAGNOSE
	LESS?	AWAKE,0 \?ELS3
	PRINTI	"You are wide awake"
	JUMP	?CND1
?ELS3:	PRINTI	"You are "
	GET	TIRED-TELL,AWAKE
	PRINT	STACK
?CND1:	PRINTI	". You are "
	GET	THIRST-TELL,THIRST-COUNT
	PRINT	STACK
	PRINTI	" and "
	GET	HUNGER-TELL,HUNGER-COUNT
	PRINT	STACK
	PRINTR	"."


	.FUNCT	V-SLEEP,TOLD?=0,TILL-TIRED,MUNGED?
	SUB	MOVES,LAST-SLEEP
	SUB	MOVES-PER-DAY,STACK >TILL-TIRED
	EQUAL?	HERE,REAL-STAIR,PIT \?ELS5
	PRINTR	"To sleep here would be fatal!"
?ELS5:	GRTR?	TILL-TIRED,10 \?ELS9
	PRINTR	"You settle down to sleep, but you really aren't tired, so you thrash around for a while and then give up."
?ELS9:	EQUAL?	HERE,ENGINE-ROOM,CLOSET,SE-TOWER \?ELS13
	PRINTR	"You try to sleep but it's too noisy."
?ELS13:	EQUAL?	HERE,BEDROOM \?ELS17
	IN?	WINNER,BED /?ELS17
	ZERO?	BED-WARNING \?ELS17
	GRTR?	AWAKE,10 /?ELS17
	SET	'BED-WARNING,TRUE-VALUE
	PRINTR	"You might try getting into the bed first. It would be more comfortable."
?ELS17:	GRTR?	TILL-TIRED,0 \?CND24
	IN?	WINNER,BED \?CND24
	ZERO?	TOLD? \?CND24
	PRINTI	"You're not all that tired, but the bed is very comfortable."
	CRLF	
?CND24:	INC	'REAL-SPELL-MAX
	SET	'SPELL-MAX,REAL-SPELL-MAX
	SET	'SPELL-ROOM,SPELL-MAX
	SET	'LAST-SLEEP,MOVES
	ADD	MOVES,MOVES-PER-SLEEP >MOVES
	ADD	TOD,MOVES-PER-SLEEP
	MOD	STACK,128 >TOD
	SET	'LOAD-ALLOWED,LOAD-MAX
	SET	'FUMBLE-NUMBER,7
	SET	'FUMBLE-PROB,8
	CALL	QUEUE,I-TIRED,MOVES-PER-DAY
	PUT	STACK,0,1
	SET	'AWAKE,-1
	CALL	FORGET-ALL
	FSET?	HERE,RMUNGBIT /?PRD31
	PUSH	0
	JUMP	?PRD32
?PRD31:	PUSH	1
?PRD32:	SET	'MUNGED?,STACK
	CALL	I-MUNG-ROOM,FALSE-VALUE
	CALL	I-MUNG-ROOM,FALSE-VALUE
	CALL	I-MUNG-ROOM,FALSE-VALUE
	ZERO?	MUNGED? \?ELS35
	FSET?	HERE,RMUNGBIT \?ELS35
	PRINTR	"You fall asleep quickly and begin to dream. The dream turns into a nightmare of decay and desolation, as your surroundings turn grey and lifeless. You feel a great weight, like a pile of ashes, constricting your movements, and then you bolt awake!"
?ELS35:	IN?	WINNER,BED \?CND33
	IN?	BEDPOST-BUTTON,BED /?CND33
	GRTR?	CHARM-POINT,0 \?CND33
	MOVE	BEDPOST-BUTTON,BED
	PRINTR	"You fall asleep quickly, the bed being so comfortable. You dream as well, of this very room. A beautiful damsel, obviously noble, is standing by the bed holding a scroll in one hand and resting the other on the bedpost. Turning to block your view, she does something you can't see. Then she gets in bed and turns out the light, but before she does you can see she is no longer carrying the scroll... You wake."
?CND33:	PRINTI	"Ah, sleep! It's been a long day, indeed. The rest will do you good. "
	IN?	WINNER,BED \?ELS50
	PRINTI	"You make yourself comfortable on the bed"
	JUMP	?CND48
?ELS50:	CALL	OUTSIDE?,HERE
	ZERO?	STACK /?ELS54
	PRINTI	"You spread your cloak under the open sky"
	JUMP	?CND48
?ELS54:	PRINTI	"You spread your cloak on the floor"
?CND48:	PRINTI	" and drift off, renewing your powers and refreshing your mind ... Time passes as you snore blissfully."
	CRLF	
	CRLF	
	CALL	OUTSIDE?,HERE
	ZERO?	STACK /?ELS67
	ZERO?	PROTECTED-FROM-EVIL \?ELS67
	RANDOM	100
	GRTR?	MOLESTED,STACK \?ELS67
	RANDOM	100
	GRTR?	MUNCHED,STACK \?ELS74
	CALL	JIGS-UP,STR?277
	RETURN	2
?ELS74:	CALL	ROB,WINNER
	CALL	ROB,HERE
	PRINTR	"You don't sleep too well, and you awake at least once with the feeling that something has jostled you in the dark."
?ELS67:	ZERO?	GALLERY-POINT /?ELS82
	ZERO?	GALLERY-DREAM \?ELS82
	SET	'GALLERY-DREAM,TRUE-VALUE
	PRINTR	"After a while, your sleep is disturbed by a strange dream. You are wandering in a darkened place, for you have no light or other possessions. You feel that you are being watched! You are surrounded by faces, their eyes following you. They drift in and out, staring at you with proud indifference. One face, brightly lit (unlike the rest), draws you closer and closer. As you touch it, you wake."
?ELS82:	ZERO?	GALLERY-POINT /?ELS88
	RANDOM	100
	GRTR?	70,STACK \?ELS88
	PRINTR	"Your sleep is disturbed by the strange dream of an earlier night. You are in the dark, with no light or other possessions. You are surrounded by many faces, their eyes following you. The one brightly lit face beckons you closer and closer. You wake, convinced that the dream holds a message for you."
?ELS88:	ZERO?	DOOR-KULCAD \?ELS94
	ZERO?	DOOR-DREAM \?ELS94
	FSET?	DOOR-REALITY,INVISIBLE \?ELS94
	SET	'DOOR-DREAM,TRUE-VALUE
	PRINTR	"You dream of a nondescript room in which a cartoonish figure casually opens a simple wooden door and ascends the flight of stairs which lies behind. The scene fades to black, but you awaken in a cold sweat."
?ELS94:	ZERO?	DOOR-KULCAD /?ELS100
	ZERO?	DOOR-DREAM-2 \?ELS100
	SET	'DOOR-DREAM-2,TRUE-VALUE
	PRINTR	"You dream of climbing in an unfamiliar place. You seem to climb forever, beyond reason. A fleeting hope arises in you, and you search furiously in your spell book and possessions for something. After a moment, you become frantic as you realize that you don't have it! You bolt awake in a cold sweat."
?ELS100:	ZERO?	PROTECTED-FROM-EVIL \?ELS106
	RANDOM	100
	GRTR?	50,STACK \?ELS106
	CALL	ROB,HERE,WARLOCK-TOWER
	RANDOM	100
	GRTR?	50,STACK \?CND109
	CALL	ROB,WINNER,WARLOCK-TOWER
?CND109:	LOC	WINNER
	EQUAL?	HERE,STACK /?CND112
	LOC	WINNER
	CALL	ROB,STACK,WARLOCK-TOWER
?CND112:	PRINTR	"You sleep fitfully. At one point it seems that some evil presence is searching nearby. The tense feeling passes, but it's replaced by one of foreboding."
?ELS106:	RANDOM	100
	GRTR?	50,STACK \?ELS118
	PRINTR	"You sleep uneventfully, dreamlessly, and awake refreshed."
?ELS118:	CALL	PICK-ONE,DREAMS
	PRINT	STACK
	PRINTR	" You awaken."

	.ENDI
