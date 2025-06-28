@echo off

title pravdec zizkov, nahravka

set filename="REC_0000052.wav"
set a=00:00:09.000
set b=00:00:17.000

set count=2
set s=0.25
set v=200

echo --volume=%v%
echo --speed=%s%
echo --start=%a%
echo --ab-loop-count=%count%
echo --ab-loop-a=%a%
echo --ab-loop-b=%b%
echo --end=%b%
echo filename - %filename%

echo mpv --speed=%s% --volume=%v% --start=%a% --ab-loop-count=%count% --ab-loop-a=%a% --ab-loop-b=%b% --end=%b% %filename%
echo #######################################################################
echo # PREVADEC ZIZKOV \ RX 145.600 Mhz \ TX 145.000 Mhz \ T-CTSS 88,5 HZ  #
echo # BYLA MU POSLANA DTMF NULA A TOHLE ODVYSILAL MORSEOVKOU              #
echo # ---/-.-/-----/-.../-./.-/-/.../--.-/--.../----./                    #
echo #  O   K    0     B  N  A  T  S    Q    7     9                       #            
echo #######################################################################
mpv --speed=%s% --volume=%v% --start=%a% --ab-loop-count=%count% --ab-loop-a=%a% --ab-loop-b=%b% --end=%b% %filename%

sleep 2
:konec
@echo on

