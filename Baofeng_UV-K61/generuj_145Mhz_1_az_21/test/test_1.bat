@echo off
title test_1.ps1
del vysledek.txt
powershell -file test_1.ps1 > vysledek.txt
echo ulozeno do souboru vysledek.txt
pause
