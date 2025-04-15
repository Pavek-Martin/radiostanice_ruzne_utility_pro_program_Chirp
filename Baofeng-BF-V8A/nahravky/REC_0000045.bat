@echo off

REM nejakej nemeckej opakovac, nebo tak neco, relace kazdej 10 minut v morseovce ( na vterinu presne ) 439,100 Hmz
REM -../-.../-----/.-../.-/..-
REM  D   B     0    L   A  U ( tohle hledat na internetu )
REM Delta,Bravo,Zero,Lima,Alfa,Uniform ( americka hlaskovaci tabulka )
REM a kazdou celou hodinu relace systetickou reci v US hlaskovaci abecede (totez co v morseovce )
REM plus nejaky dalsi infomace samozdrejme nemecky ( neco o frekvenci snad rika )
REM obcas se do toho kecaj nejaky dve nemci, normalne uz na zivo

set filename="REC_0000045.wav"
set a=00:00:37.000
set b=00:00:49.000
REM set end=00:00:54.001
REM set end=00:00:54.000
REM "end" muze bejt stejne jako "b" ( takze staci jenom "b" )
REM asi spracovava ty parametry postupne ( cekal bych ze bude delat bordel kdyz bude "end" uplne stejny jako "b")
REM ale nedeje se tak
set count=1
REM count je 2 a pritom opakuje 3x ( nazjisteno proc ? )
set s=0.8
REM keca docela neprirozene ryche takze 80 procent rychlosti pouze

REM set v=90
set v=120
REM hlasitost zvysena o 20 procent (default: 100.000)

echo --volume=%v%
echo --speed=%s%
echo --start=%a%
echo --ab-loop-count=%count%
echo --ab-loop-a=%a%
echo --ab-loop-b=%b%
echo --end=%b%
echo filename - %filename%

echo mpv --speed=%s% --volume=%v% --start=%a% --ab-loop-count=%count% --ab-loop-a=%a% --ab-loop-b=%b% --end=%b% %filename%
mpv --speed=%s% --volume=%v% --start=%a% --ab-loop-count=%count% --ab-loop-a=%a% --ab-loop-b=%b% --end=%b% %filename%

sleep 2
:konec
@echo on

