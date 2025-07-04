﻿cls

<#
145.500 - 145.550 Mhz krok 2,5K

1 	145.500.0
2 	145.502.5
3 	145.505.0
.
.
.

21 145.550.0
#>

$vrsek = "Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,RxDtcsCode,CrossMode,Mode,TStep,Skip,Power,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE"
# toje je upne stejne pro obe vysilacky, jak malou tak velkou ten $vrsek !

$pole_file_CSV_output = @()
$pole_file_CSV_output += $vrsek

$vloz_stred_1 = ",,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,"

$vloz_stred_2 = ",5.00,," # az se zjisti jak na to
$vloz_stred_3 = ",5.00,S," # bude prekakova skenovani

############## zde edit zona ###################
$export_CSV_filename = "Baofeng_UK-K61_145Mhz_1_az_21.csv"

Remove-Item $export_CSV_filename -force -ErrorAction SilentlyContinue
sleep 1
#
$frekvence_min = 145.500 # toto bude v CHipu na pametove pozici jedna, (dalsi pozice 2 bude toto plus $frekvence_krok atd.)
$frekvence_krok = 0.0025 # pro pmr vzdy stejny

$max_pametova_pozice_v_chirp = 21# max. polozek v chirp
#
$pole_AM_nebo_FM = @( "AM", "FM" )
#                      [0]   [1]
$AM_nebo_FM = $pole_AM_nebo_FM[1] # [0]=AM; [1]=FM
#
$pole_vykon = @( "1.0W", "5.0W" )
#                  [0]     [1]
$vykon = $pole_vykon[1] # [0]=1.0W; [1]=5.0W
#
$pole_skenovat = @( 0, 1 )
#                  [0] [1]
$preskocit_skenovani = $pole_skenovat[0] # [0]=nebude preskakovat skenovani; [1]=bude preskakovat skenovani kanalu

############### konec edit zony #################

$komentar_pametove_pozice = "145Mhz-"
$maska = "00000000"

for ( $pametova_pozice = 1; $pametova_pozice -le $max_pametova_pozice_v_chirp; $pametova_pozice++ ){
#echo $pametova_pozice
$radek = [string] $pametova_pozice
$radek +=","
$radek += $komentar_pametove_pozice
#$radek += " "
$radek += [string] $pametova_pozice
$radek +=","

# uprava zaokrouhlenim >>
$x = $frekvence_min
[string] $x2 = [Math]::Ceiling($x * 10000) / 10000 # tohle mi poradil Microsoft copilot AI :)
#  napred vynasobit  krat 1000 aby se posunula desetina mista a pak vysledek opet zpatky vydeli 
# cele cislo napr. "434"
if ($x2.Length -eq 3 ){
$x2 = $x2 + ".000000"
}

# libovolne desetine cislo napr. "433.9, 433,85, 433.925"
if ($x2 -gt 3 ){
$x2 += $maska.Substring(0,10 - $x2.Length)
}

$radek += $x2
# konec radku frekvence <<<
$radek += $vloz_stred_1
$radek += $AM_nebo_FM

# vyhodnoceni polozky preskocit scanovani
if ( $preskocit_skenovani -eq 0 ){ 
$radek += $vloz_stred_2
}else{
$radek += $vloz_stred_3
}

$radek += $vykon
$radek += ","
# pridano sloupec comment
$radek += $komentar_pametove_pozice
#$radek += " "
$radek += $pametova_pozice
$radek += ",,,,"

$frekvence_min += $frekvence_krok # pricte dalsi frekvencni krok

#echo $radek
$pole_file_CSV_output += $radek
}

echo $pole_file_CSV_output
#echo "---"
#echo "46,LPD 69,434.775000,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,FM,5.00,,1.0W,,,,, toto je v cvs"

# export do souboru *.CSV
Set-Content $export_CSV_filename -Encoding ASCII -Value $pole_file_CSV_output
echo ""
echo "HOTOVO, toto ulozeno do souboru : $export_CSV_filename"
sleep 5



