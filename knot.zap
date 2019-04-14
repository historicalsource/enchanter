

	.FUNCT	JEWELLED-BOX-A
	IN?	HERE,JEWELLED-BOX \TRUE
	GRTR?	BOX-POINT,0 \TRUE
	ZERO?	ROPE-MAGIC? /?ELS8
	PRINTR	"The adventurer notes the box and tries to untie the rope from around it. His frustration is evident by the words he uses to describe the rope."
?ELS8:	PUTP	JEWELLED-BOX,P?LDESC,STR?126
	PRINTI	"The adventurer walks up to the box and becomes quickly entangled in the partly untied rope that is knotted around it. He looks like a cat who has been playing with a ball of yarn."
	CRLF	
	RTRUE	


	.FUNCT	JEWELLED-BOX-F
	IN?	MAGIC-ROPE,JEWELLED-BOX \?ELS5
	EQUAL?	PRSA,V?SHAKE \?ELS10
	PRINTR	"It seems that there's something inside, but it's not clear what."
?ELS10:	EQUAL?	PRSA,V?UNLOCK \?ELS14
	PRINTR	"Who said anything about its being locked?"
?ELS14:	EQUAL?	PRSA,V?REZROV \?ELS18
	ZERO?	ROPE-MAGIC? /?ELS23
	PRINTR	"The magic in the rope is strong enough to prevent the rezrov spell from working."
?ELS23:	PRINTI	"The rope dissolves and the jewelled box flies open!"
	CRLF	
	CALL	ROPE-DISSOLVES
	FSET	JEWELLED-BOX,OPENBIT
	RTRUE	
?ELS18:	EQUAL?	PRSA,V?LOOK-INSIDE,V?OPEN \?ELS32
	PRINTR	"With all that rope around it, you haven't a prayer."
?ELS32:	EQUAL?	PRSA,V?EXAMINE \?ELS36
	PRINTR	"It is closed and wrapped in tight coils of thin rope."
?ELS36:	EQUAL?	PRSA,V?CLOSE \?ELS40
	PRINTR	"It isn't open, which seems to be the problem at hand."
?ELS40:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,JEWELLED-BOX \FALSE
	PRINTR	"That won't work until the box is open."
?ELS5:	EQUAL?	PRSA,V?OPEN \FALSE
	IN?	PROTECTION-SCROLL,JEWELLED-BOX \FALSE
	CALL	THIS-IS-IT,PROTECTION-SCROLL
	RFALSE	


	.FUNCT	MAGIC-ROPE-F
	EQUAL?	PRSA,V?UNTIE \?ELS5
	PRINTI	"After a few moments of reflection, you tackle the knots, one at a time. Although you succeed with some regularity at untangling small areas of the rope, you "
	ZERO?	ROPE-MAGIC? /?ELS10
	PRINTI	"find that new knots seem to be forming as you watch, taunting you into deep despair."
	JUMP	?CND8
?ELS10:	PUTP	JEWELLED-BOX,P?LDESC,STR?126
	PRINTI	"can't make any headway against the enormous tangle. It would take forever to finish."
?CND8:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?GUNCHO \?ELS19
	REMOVE	MAGIC-ROPE
	REMOVE	JEWELLED-BOX
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" disappears, but unfortunately the "
	PRINTD	JEWELLED-BOX
	PRINTR	" disappears as well."
?ELS19:	EQUAL?	PRSA,V?REZROV \?ELS23
	CALL	JEWELLED-BOX-F
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?TAKE \?ELS25
	PRINTR	"The rope is so entangled around the box that the idea is ridiculous."
?ELS25:	EQUAL?	PRSA,V?MUNG,V?CUT \?ELS29
	ZERO?	PRSI \?ELS34
	PRINTR	"You can't hurt it with your bare hands."
?ELS34:	EQUAL?	PRSI,MAGIC-KNIFE \?ELS38
	CALL	ROPE-DISSOLVES
	PRINTR	"At the mere touch of the magic knife, the rope gives way. Before your eyes, the strands, now moving this way, now moving that way, untangle themselves into a single strand which falls to the floor alongside the box, where it dissolves into the air without a sound."
?ELS38:	FSET?	PRSI,WEAPONBIT \?ELS42
	ZERO?	ROPE-MAGIC? /?ELS47
	PRINTR	"The rope seems to be pretty strong stuff. You don't seem to be making the least progress in breaking it."
?ELS47:	PRINTR	"The rope cuts cleanly, and falls to pieces on the floor. It must have been pretty rotten."
?ELS42:	PRINTI	"You certainly won't get anywhere using the "
	PRINTD	PRSI
	PRINTR	"!"
?ELS29:	EQUAL?	PRSA,V?KULCAD \?ELS60
	SET	'ROPE-MAGIC?,FALSE-VALUE
	PRINTR	"Nothing obvious happens, but when you examine the rope, it lacks a certain something you saw in it before. It now looks sort of ordinary, like a clothesline."
?ELS60:	EQUAL?	PRSA,V?DROP \FALSE
	CALL	PERFORM,V?DROP,JEWELLED-BOX
	RTRUE	


	.FUNCT	ROPE-DISSOLVES
	SET	'ROPE-MAGIC?,FALSE-VALUE
	ADD	SCORE,BOX-POINT >SCORE
	SET	'BOX-POINT,0
	REMOVE	MAGIC-ROPE
	MOVE	PROTECTION-SCROLL,JEWELLED-BOX
	FCLEAR	JEWELLED-BOX,OPENBIT
	FSET	JEWELLED-BOX,TOUCHBIT
	PUTP	JEWELLED-BOX,P?LDESC,STR?129
	RTRUE	


	.FUNCT	MAGIC-KNIFE-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The dagger is inlaid with fine jewels. It would be a handsome addition to anyone's weapon collection."

	.ENDI
