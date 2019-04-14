"MAIN for
		 	    ENCHANTER
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<GLOBAL DEBUG <>>

<ROUTINE GO () 
	 <PUTB ,P-LEXV 0 59>
;"put interrupts on clock chain"
	 <ENABLE <QUEUE I-TIRED ,MOVES-PER-DAY>>
	 <ENABLE <QUEUE I-THIRST 41>>
	 <ENABLE <QUEUE I-HUNGER 67>>
	 <ENABLE <QUEUE I-TIME -1>>
	 <ENABLE <QUEUE I-SCURRY 5>>
	 <ENABLE <QUEUE I-MUNG-ROOM 50>>
;"make sure guards arrive messages happen before adventurer ones"
	 <ENABLE <QUEUE I-GUARDS-ARRIVE 0>>
	 <ENABLE <QUEUE I-ADVENTURER 0>>
	 ;"clean up junk compiler can't do"
	 
;"set up and go"
	 <SETG LIT T>
	 <SETG WINNER ,PLAYER>
	 <SETG HERE ,WEST-FORK>
	 <SETG P-IT-OBJECT <>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<TELL 

"It must be the warlock Krill. The odd disappearances, the mysterious
dissolution of regions sacred to the Circle, the lessening of the Powers --
these could only be his handiwork. The Circle gathers and its leader, the
esteemed Belboz, reveals to them an ancient document which portends evil days
much like our own.|
|
\"Krill's evil must be unmade,\" he begins, \"but to send a powerful Enchanter
is ill-omened. It would be ruinous to reveal oversoon our full powers.\" A
ripple of concern spreads over the face of each Enchanter. Belboz pauses, and
collects his resolve. \"Have hope! This has been written by a hand far wiser
than mine!\"|
|
He recites a short spell and you appear. Belboz approaches, transfixing you
with his gaze, and hands you the document. The other Enchanters await his
decree. \"These words, written ages ago, can have only one meaning.
You, a novice Enchanter with but a few simple spells in your Book, must seek
out Krill, explore the Castle he has overthrown, and learn his secrets. Only
then may his vast evil be lessened or, with good fortune, destroyed.\"|
|
The Circle rises and intones a richly woven spell, whose many textures imbue
the small, darkened chamber with warmth and hope. There is a surge of power;
you are Sent." CR>
		<CRLF>
		<V-VERSION>
		<CRLF>)>
	 <MOVE ,WINNER ,HERE>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>    


<ROUTINE MAIN-LOOP ("AUX" TRASH)
	<REPEAT ()
	     <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP) 
   #DECL ((CNT OCNT ICNT NUM) FIX (V) <OR 'T FIX FALSE> (OBJ) <OR FALSE OBJECT>
	  (OBJ1) OBJECT (TBL) TABLE (PTBL) <OR FALSE ATOM>)
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT <ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<0? .OCNT> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<0? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ> <1? .ICNT>> <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<==? ,PRSA ,V?WALK> <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <TELL "It's too dark to see." CR>)
			 (T
			  <TELL "There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<OR ,P-OFLAG ,P-MERGED>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
			  <TELL "!" CR>
			  <SET V <>>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT T>)>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
				  <COND (<G? ,P-NOT-HERE 0>
					 <TELL "The ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
						<TELL "other ">)>
					 <TELL "object">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "s">)>
					 <TELL " that you mentioned ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "are">)
					       (T <TELL "is">)>
					 <TELL "n't here." CR>)
					(<NOT .TMP>
					 <TELL
"I don't know what you're referring to." CR>)>
				  <RETURN>)
				 (T
				  <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
					(T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
				  <SETG PRSO <COND (.PTBL .OBJ1) (T .OBJ)>>
				  <SETG PRSI <COND (.PTBL .OBJ) (T .OBJ1)>>
				  <COND (<VERB? MAKE-LINE ERASE-LINE> T)
					(<OR <G? .NUM 1>
					     <EQUAL? <GET <GET ,P-ITBL ,P-NC1>
							  0>
						     ,W?ALL>>
					 <COND (<EQUAL? .OBJ1
							,NOT-HERE-OBJECT>
						<SETG P-NOT-HERE
						      <+ ,P-NOT-HERE 1>>
						<AGAIN>)
					       (<AND <EQUAL? ,P-GETFLAGS
							     ,P-ALL>
						     <VERB? TAKE>
						     <NOT <EQUAL?
							   <LOC .OBJ1>
							   ,WINNER
							   ,HERE
							   .OBJ>>>
						<AGAIN>)
					       (<AND <VERB? TAKE>
						     ,PRSI
						     <EQUAL? <GET <GET ,P-ITBL
								       ,P-NC1>
								  0>
							     ,W?ALL>
						     <NOT <IN? ,PRSO ,PRSI>>>
						<AGAIN>)
					       (T
						<COND (<EQUAL? .OBJ1 ,IT>
						       <PRINTD ,P-IT-OBJECT>)
						      (T <PRINTD .OBJ1>)>
						<TELL ": ">)>)>
				  <SET TMP T>
				  <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
				  <COND (<==? .V ,M-FATAL> <RETURN>)>)>>)>
	    <COND (<NOT <==? .V ,M-FATAL>>
		   ;<COND (<==? <LOC ,WINNER> ,PRSO>
			  <SETG PRSO <>>)> ;"why is this done? -- pdl"
		   <COND (<LOC ,WINNER>
			  <SET V
			       <APPLY <GETP <LOC ,WINNER> ,P?ACTION>
				      ,M-END>>)>)>
	    <COND (<VERB? ;AGAIN ;WALK SAVE RESTORE SCORE VERSION> T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>)>
	    <COND (<==? .V ,M-FATAL> <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE SAVE VERSION
			  TIME QUIT RESTART SCORE SCRIPT UNSCRIPT RESTORE> T)
		  (T <SET V <CLOCKER>>)>)>>
 
<GLOBAL L-PRSA <>>  
 
<GLOBAL L-PRSO <>>  
 
<GLOBAL L-PRSI <>>  

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>



%<COND (<GASSIGNED? PREDGEN>

'<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <EQUAL? ,IT .I .O>
		    <NOT <ACCESSIBLE? ,P-IT-OBJECT>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND
		(<SET V <APPLY <GETP ,WINNER ,P?ACTION>>> .V)
		(<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>> .V)
		(<SET V <APPLY <GET ,PREACTIONS .A>>> .V)
		(<AND .I <SET V <APPLY <GETP .I ,P?ACTION>>>> .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <LOC .O>
		      <SET V <APPLY <GETP <LOC .O> ,P?CONTFCN>>>>
		 .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <SET V <APPLY <GETP .O ,P?ACTION>>>>
		 .V)
		(<SET V <APPLY <GET ,ACTIONS .A>>> .V)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>)
       (T
	
'<PROG ()

<SETG DEBUG <>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<COND (,DEBUG
	       <TELL "** PERFORM: PRSA = ">
	       <PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL " | PRSO = " D .O>)>
	       <COND (.I <TELL " | PRSI = " D .I>)>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <EQUAL? ,IT .I .O>
		    <NOT <ACCESSIBLE? ,P-IT-OBJECT>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<SET V <D-APPLY "Actor"
				      <GETP ,WINNER ,P?ACTION>>> .V)
		     (<SET V <D-APPLY "Room (M-BEG)"
				      <GETP <LOC ,WINNER> ,P?ACTION>
				      ,M-BEG>> .V)
		     (<SET V <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>> .V)
		     (<AND .I <SET V <D-APPLY "PRSI"
					      <GETP .I ,P?ACTION>>>> .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <LOC .O>
			   <SET V <D-APPLY "Container"
					   <GETP <LOC .O> ,P?CONTFCN>>>>
		      .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>>>
		      .V)
		     (<SET V <D-APPLY <>
				      <GET ,ACTIONS .A>>> .V)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<DEFINE D-APPLY (STR FCN "OPTIONAL" FOO "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL CR "  Default ->" CR>)
			    (T <TELL CR "  " .STR " -> ">)>)>
	       <SET RES
		    <COND (<ASSIGNED? FOO>
			   <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       <COND (<AND ,DEBUG .STR>
		      <COND (<==? .RES 2>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

>)>	;"DON'T REMOVE"

<GLOBAL TOD 0>
<GLOBAL DAWN 0>
<GLOBAL SUNRISE 10>
<GLOBAL DUSK 81>
<GLOBAL NIGHTFALL 97>

<ROUTINE I-TIME ()
	 <COND (<AND <==? ,HASTED? ,ME>
		     <==? <MOD ,MOVES 2> 0>>
		<RTRUE>)
	       (<G? <SETG TOD <+ ,TOD 1>> 127>
		<SETG TOD 0>
		<SETG NIGHTFALL <- ,NIGHTFALL 20>>
		<SETG LOSSAGE <+ ,LOSSAGE 1>>
		<SETG DUSK <- ,DUSK 20>>
		<SETG MOLESTED <+ ,MOLESTED 5>>
		<SETG MUNCHED <+ ,MUNCHED 5>>
		<COND (<L? ,NIGHTFALL 0>
		       <TELL
"Belboz appears before you, in a magical sending. He speaks, his voice
soft and saddened. \"You have failed. Universal night has now fallen.
Krill and his creatures now may freely roam the earth. The power of the
Circle is diminished, if not broken. I go to prepare the last defense.\"
The sending vanishes." CR>
		       <FINISH>)>)>
	 <COND (<AND <EQUAL? ,TOD ,NIGHTFALL>
		     <FSET? <LOC ,PLAYER> ,ONBIT>>
		<TELL
"The darkened sky is now full of bright stars. It is night." CR>
		<COND (<L? ,NIGHTFALL 97>
		       <TELL
"Today seemed shorter than yesterday, somehow." CR>)>
		<RTRUE>)
	       (<AND <EQUAL? ,TOD ,SUNRISE>
		     <FSET? <LOC ,PLAYER> ,ONBIT>>
		<TELL
"The sun has now risen above the hills." CR>)
	       (<AND <EQUAL? ,TOD ,DUSK>
		     <FSET? <LOC ,PLAYER> ,ONBIT>>
		<TELL
"The sun starts to set behind the Lonely Mountain in the west." CR>
		<COND (<L? ,NIGHTFALL 97>
		       <TELL
"The day is coming to an end earlier than you would have expected." CR>)>
		<RTRUE>)>>

