

	.FUNCT	GALLERY-A
	IN?	ADVENTURER,HERE \FALSE
	ZERO?	PORTRAIT-COMMENT \FALSE
	FSET?	FLATHEAD-PORTRAIT,INVISIBLE /FALSE
	ZERO?	ADVENTURER-CHARMED /FALSE
	SET	'PORTRAIT-COMMENT,TRUE-VALUE
	PRINTR	"The adventurer stops and stares at the portraits. ""I've met him!"" he gasps, pointing at the Wizard of Frobozz. He doesn't appear eager to meet him again, though. ""And there's old Flathead! What a sight!"" He glances at the other portraits briefly and then re-checks his map."


	.FUNCT	GALLERY-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	CALL	LIT?,HERE,FALSE-VALUE
	ZERO?	STACK \?ELS5
	ZERO?	SUPER-BRIEF /?CND8
	ZERO?	GALLERY-POINT /?CND8
	CALL	DESCRIBE-PORTRAIT-GALLERY
?CND8:	FCLEAR	HERE,TOUCHBIT
	RTRUE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LIT?,HERE,FALSE-VALUE
	ZERO?	STACK /?ELS19
	ZERO?	GALLERY-POINT /?CND20
	REMOVE	LIGHTED-PORTRAIT
?CND20:	SET	'VISITED-GALLERY?,TRUE-VALUE
	PRINTI	"The east-west corridor opens into a gallery. The walls are lined with portraits, some of apparently great value. All of the eyes seem to follow you as you pass, and the entire room is subtly disturbing."
	CRLF	
	IN?	PORTRAIT-NICHE,GALLERY \FALSE
	PRINTR	"A small niche can be seen in the wall behind the spot where a painting had been hanging."
?ELS19:	CALL	DESCRIBE-PORTRAIT-GALLERY
	ZERO?	STACK \FALSE
	PRINTR	"It is pitch black."


	.FUNCT	DESCRIBE-PORTRAIT-GALLERY
	IN?	ETERNAL-FLAME,PORTRAIT-NICHE \FALSE
	FSET?	ETERNAL-FLAME,ONBIT \FALSE
	ZERO?	GALLERY-POINT /?CND8
	MOVE	LIGHTED-PORTRAIT,HERE
?CND8:	ZERO?	VISITED-GALLERY? /?ELS13
	PRINTI	"An eerie orange glow casts a pale, flickering light on the portrait gallery."
	JUMP	?CND11
?ELS13:	SET	'VISITED-GALLERY?,TRUE-VALUE
	PRINTI	"The east-west corridor opens into a portrait gallery. The gallery is lit by an eerie orange glow."
?CND11:	PRINTR	" The eyes of the figures portrayed on the canvases seem to be faintly illuminated and follow your every movement. After a moment, the source of light becomes clear: a single lighted portrait flickers as if a flame were burning behind it."


	.FUNCT	PORTRAITS-F
	EQUAL?	PRSA,V?MOVE,V?TAKE \?ELS5
	PRINTR	"The portraits are large and extremely heavy; they can be neither taken nor moved."
?ELS5:	EQUAL?	PRSA,V?LOOK-UNDER,V?LOOK-BEHIND \?ELS9
	PRINTR	"There are hundreds of canvases here; you look behind one or two at random but find nothing of interest."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The portraits represent a wide cross-section of races. Elves, gnomes, dwarves, wizards, warlocks, and just plain folk are all here. Some of them are known to you, such as Lord Dimwit Flathead of the Great Underground Empire, depicted here in excessive detail, and the Wizard of Frobozz, shown in a typical pose of anguished bewilderment."
	CRLF	
	FCLEAR	FLATHEAD-PORTRAIT,INVISIBLE
	FCLEAR	FROBOZZ-PORTRAIT,INVISIBLE
	RTRUE	


	.FUNCT	FLATHEAD-PORTRAIT-F
	EQUAL?	PRSA,V?ZIFMIA \?ELS5
	PRINTR	"Poor Flathead, the years have not been kind to him. Just as well, probably."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"This rather dull man stumbled into royalty in the Great Underground Empire, and much to everyone's chagrin. Named by his people Lord Dimwit Flathead the Excessive, he was best known for his outrageousness in style, policy, and engineering. His portrait captures him in the classic pose of imbecility, astride his gaudy throne."


	.FUNCT	FROBOZZ-PORTRAIT-F
	EQUAL?	PRSA,V?ZIFMIA \?ELS5
	PRINTR	"The Wizard doesn't seem to respond to the summons. Perhaps he is too busy molesting adventurers in ZORK II."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The Wizard of Frobozz was a former member of the Circle of Enchanters, but he was removed for forgetfulness bordering on senility. The lively wit of his youth having been replaced by a semisadistic mischievousness coupled with an inability to pronounce words beginning with other than the letter ""F"", he was ""retired"" to a small, unoccupied corner of the Great Underground Empire, hopefully out of harm's way."


	.FUNCT	LIGHTED-PORTRAIT-F
	EQUAL?	PRSA,V?LOOK-BEHIND \?ELS5
	FSET?	PRSO,TOUCHBIT /?ELS5
	ADD	SCORE,GALLERY-POINT >SCORE
	SET	'GALLERY-POINT,0
	MOVE	PORTRAIT-NICHE,HERE
	FSET	PRSO,TOUCHBIT
	PRINTI	"Behind the portrait is a small niche. You find that the portrait is much lighter than the others and place it on the ground."
	FCLEAR	HERE,ONBIT
	FIRST?	PORTRAIT-NICHE \?CND10
	PRINTI	" Sitting in the niche is "
	CALL	PRINT-CONTENTS,PORTRAIT-NICHE
	PRINTI	"."
?CND10:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS18
	FSET?	PRSO,TOUCHBIT /?ELS23
	PRINTR	"The portrait, of an obscure adventurer, is not notable except for the fact that it is lighted from behind by a flickering orange light."
?ELS23:	PRINTR	"The portrait, of some obscure personage carrying a brass lantern and an elvish sword of great antiquity, is mediocre at best."
?ELS18:	EQUAL?	PRSA,V?TAKE,V?MOVE \FALSE
	FSET?	PRSO,TOUCHBIT /FALSE
	FCLEAR	PRSO,NDESCBIT
	FSET	PRSO,TOUCHBIT
	ADD	SCORE,GALLERY-POINT >SCORE
	SET	'GALLERY-POINT,0
	MOVE	PORTRAIT-NICHE,HERE
	PRINTI	"The portrait is quite light. You remove it from the wall and place it on the ground, revealing a small niche in the wall"
	FIRST?	PORTRAIT-NICHE \?CND36
	PRINTI	", in which sits "
	CALL	PRINT-CONTENTS,PORTRAIT-NICHE
?CND36:	PRINTR	"."


	.FUNCT	PORTRAIT-NICHE-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTR	"You can't do that."


	.FUNCT	ETERNAL-FLAME-F
	EQUAL?	PRSA,V?KULCAD,V?GONDAR \?ELS5
	PRINTI	"The flame flickers for a moment, then goes out."
	CRLF	
	FCLEAR	ETERNAL-FLAME,ONBIT
	FCLEAR	ETERNAL-FLAME,LIGHTBIT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LAMP-ON \?ELS9
	FSET?	ETERNAL-FLAME,ONBIT /?ELS9
	PRINTR	"You can't relight the candles."
?ELS9:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	PRINTR	"The flame cannot be extinguished, no matter how hard you try."

	.ENDI
