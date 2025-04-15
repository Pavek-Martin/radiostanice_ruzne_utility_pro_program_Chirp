@echo off

REM nejakej nemeckej opakovac, nebo tak neco, relace kazdej 10 minut v morseovce ( na vterinu presne ) 439,100 Hmz
REM -../-.../-----/.-../.-/..-
REM  D   B     0    L   A  U 
REM Delta,Bravo,Zero,Lima,Alfa,Uniform ( americka hlaskovaci tabulka )
REM a kazdou celou hodinu relace systetickou reci v US hlaskovaci abecede (totez co v morseovce )
REM plus nejaky dalsi infomace samozdrejme nemecky ( neco o frekvenci snad rika )
REM obcas se do toho kecaj nejaky dve nemci, normalne uz na zivo

set filename="REC_0000042.wav"
set a=00:00:50.000
set b=00:00:54.000

REM set end=00:00:54.001
REM set end=00:00:54.000
REM "end" muze bejt stejne jako "b" ( takze staci jenom "b" )
REM asi spracovava ty parametry postupne ( cekal bych ze bude delat bordel kdyz bude "end" uplne stejny jako "b")
REM ale nedeje se tak

set count=2
REM count je 2 a pritom opakuje 3x ( nazjisteno proc ? )       


echo "1 = 1"
echo "2 = 0.5"
echo "3 = 0.33"
echo "4 = 0.25"

REM echo "cokoliv jineho pro ukonceni programu"
set /p volba="zadej rychost 1 - 4 a nebo Enter = konec ?:

REM EQU - equal
REM NEQ - not equal
REM LSS - less than
REM LEQ - less than or equal
REM GTR - greater than
REM GEQ - greater than or equal

if %volba% LSS 1 (
REM volba < 0 napr -1, -2 atd.
echo chyba min.
sleep 2
goto konec
REM skok na navesti :konec
)

if %volba% GTR 4 (
REM volba > 3 a nebo napr. "abcd" apod. proste ne cislo
echo chyba max.
sleep 2
goto konec
)

REM nejni ostereny proti napr. volba=1.2 apod.

if %volba%==1 (set s=1)
if %volba%==2 (set s=0.5)
if %volba%==3 (set s=0.33)
if %volba%==4 (set s=0.25)

echo --speed=%s%
echo --start=%a%
echo --ab-loop-count=%count%
echo --ab-loop-a=%a%
echo --ab-loop-b=%b%
echo --end=%b%
echo filename - %filename%

echo mpv --speed=%s% --start=%a%  --ab-loop-count=%count% --ab-loop-a=%a% --ab-loop-b=%b% --end=%b% %filename%
mpv --speed=%s% --start=%a%  --ab-loop-count=%count% --ab-loop-a=%a% --ab-loop-b=%b% --end=%b% %filename%
sleep 2
:konec
@echo on

