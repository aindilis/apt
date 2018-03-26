APT

Auto (Pre|Post)processing Tool

APT is a system for cleaning text input.

After trying  numerous approaches  over the past  week trying  to meet
<REDACTED>'s needs,  including a GigaWord bigram  corpus, the Stanford
LexParser,  and  a combination  of  earlier  Kstem scripts,  and  hand
written scripts for this domain; it became clear that it was necessary
to solve the problem correctly and implement a preprocessing tool that
can be used with AutoMap.

The reason for  this is because individually writing  scripts for each
assignment fails because  of the complexity of the  process, you solve
maybe the 1st  or 2nd order problems, but the  other problems are more
severe than you expected.  It is  better to solve the problem once and
for all.

Consider a specific  string as input.  APT works by  allowing the user
to define a  number of text processing functions that  accept a string
and  return  a possibly  modified  string.   APT will  loop,  "firing"
applicable  functions   until  either  no  more   modifications  occur
(idempotency), or a timeout occurs (this inherently avoids some of the
problems  with  the   bad  worse  case  running   of  certain  regular
expressions  we experienced  with  the <REDACTED>  corpus).  The  user
specifies a dependency chart of functions and applicable functions are
those which have their dependencies met.

We  can  then  simply  develop  a  library  of  processing  functions,
automatically organized by  dependency information.  This will include
the previous NLP techniques mentioned earlier.

A full transparent history is maintained for each input string so that
the user can see the function application order, and what effects they
had.   This allows  quick debugging  and improved  quality  by fixing,
adding, and/or removing functions.


EXAMPLES


Here is an example of the current history log file format.  As you can
see it is clear which functions are making which changes.  

https://raw.githubusercontent.com/aindilis/apt/naster/README.md

<item>
	<record value="Internetbased" methods="c">
</item>
<item>
	<record value="DF xxx Susan Scott 08/09/2000" methods="c">
	<record value="DF xxx Susan Scott " methods="2,13">
	<record value="DF xxx Susan Scott" methods="m">
</item>
<item>
	<record value="Martin Cuilla 10/19/2000" methods="c">
	<record value="Martin Cuilla " methods="2,13">
	<record value="Martin Cuilla" methods="m">
</item>
<item>
	<record value="Roy Williams xxx B J Johnso=n=20and xxx Inside Texas Football" methods="c">
	<record value="Roy Williams xxx B J Johnso n and xxx Inside Texas Football" methods="1">
</item>
<item>
	<record value="PMTo Philippe xxx Bibi/HOU/ECT@ECTcc Jeffrey xxx Shankman/HOU/ECT@ECT Subject Message xxx Jeff Shankman I" methods="c">
	<record value="PMTo Philippe xxx  " methods="0,4">
	<record value="PMTo Philippe xxx" methods="m">
</item>
<item>
	<record value="Mike (Smith) Since" methods="c">
	<record value="Mike  Smith Since" methods="6,14,5">
	<record value="Mike Smith Since" methods="m">
</item>


STATUS

The system was  written overnight and as such is  not complete.  It is
however  sufficient  I  believe   for  <REDACTED>'s  needs.   We  will
implement each of the natural features when they become necessary.


https://frdcsa.org/frdcsa/minor/apt
