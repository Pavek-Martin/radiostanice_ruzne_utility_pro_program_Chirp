@echo off
title test_1.ps1
del vysledek.txt
set v="test_1.txt"
powershell -file test_1.ps1 > %v%
echo ulozeno do souboru %v%
pause
