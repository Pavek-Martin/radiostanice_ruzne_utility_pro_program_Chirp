cls

<#
LPD pasmo prvnich 16 kanalu pro Baofeng BF-V8a ( pokracuje takto az do kanalu 102, krok vzdy 0,025 )
CH 	FRQ [MHz]
1 	433,075
2 	433,100
3 	433,125
4 	433,150
5 	433,175
6 	433,200
7 	433,225
8 	433,250
9 	433,275
10 	433,300
11 	433,325
12 	433,350
13 	433,375
14 	433,400
15 	433,425
16 	433,450
#>


<# toto je obsah vyexportovaneho souboru v aplikaci CHip, export do CSV souboru

Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,RxDtcsCode,CrossMode,Mode,TStep,Skip,Power,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE
1,,443.075000,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,FM,5.00,,0.5W,pmr 1,,,,
2,,433.100000,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,0.5W,pmr 2,,,,
3,,433.125000,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 3,,,,
4,,446.043750,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 4,,,,
5,,446.056250,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 5,,,,
6,,446.068750,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 6,,,,
7,,446.081250,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 7,,,,
8,,446.093750,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 8,,,,
9,,446.106250,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 9,,,,
10,,446.118750,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W, pmr 10,,,,
11,,446.131250,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 11,,,,
12,,446.143750,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 12,,,,
13,,446.156250,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 13,,,,
14,,446.168750,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 14,,,,
15,,468.545000,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,S,2.0W,firma hostivar,,,,
16,,446.193750,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,NFM,5.00,,2.0W,pmr 16,,,,
#>

$vrsek="Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,RxDtcsCode,CrossMode,Mode,TStep,Skip,Power,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE"
#          ^^ tento redek je vzdy stejny
$pole_file_CSV_output = @()
$pole_file_CSV_output += $vrsek

$vloz_stred_1 = ",,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,"
$vloz_stred_2 = ",5.00,,"

############## zde edit zona ###################
$export_CSV_filename = "Baofeng_BF-V8A_LPD_pasmo_kanal_1_az_16.csv"

Remove-Item $export_CSV_filename -force -ErrorAction SilentlyContinue
sleep 1

$frekvence_min = 433.075000 # toto bude v CHipu na pametove pozici jedna, (dalsi pozice 2 bude toto plus krok atd.)
$frekvence_krok = 0.025
$max_pametova_pozice_v_chirp = 16
#

#
$pole_FM_nebo_NFM = @("FM","NFM")
$FM_nebo_NFM = $pole_FM_nebo_NFM[1] # [0]=FM; [1]=NFM
#
$pole_vykon = @("0.5W", "2.0W")
$vykon = $pole_vykon[0] # [0]=0.5W; [1]=2.0W
#

$komentar_kanalu_prefix = "LPD "

############### kone edit zony #################

$maska = "000000000000000000"

for ( $pametova_pozice = 1; $pametova_pozice -le $max_pametova_pozice_v_chirp; $pametova_pozice++ ){
#echo $pametova_pozice
$radek = [string] $pametova_pozice
$radek +=",,"

#$radek += [string] $frekvence_min
$s_frekvence_min = [string] $frekvence_min
#echo $s_frekvence_min
$d_s_frekvence_min = $s_frekvence_min.Length 
#echo $d_s_frekvence_min"<"

if ( $d_s_frekvence_min -lt 10 ) {
#musi bej delka 10
$s_frekvence_min += $maska.Substring(0,10 - $d_s_frekvence_min )
}


#echo $s_frekvence_min"<<"
$radek += $s_frekvence_min
$radek += $vloz_stred_1
$radek += $FM_nebo_NFM
$radek += $vloz_stred_2
$radek += $vykon
$radek += ","
$radek += $komentar_kanalu_prefix
$radek += [string] $pametova_pozice # toto bude komentar kanalu sulfix ( LPD 1 az LPD 16 )

$radek += ",,,,"

$frekvence_min = $frekvence_min + $frekvence_krok # pricte dalsi frekvencni krok

#echo $radek
$pole_file_CSV_output += $radek
}

echo $pole_file_CSV_output

# export do souboru *.CSV
Set-Content $export_CSV_filename -Encoding ASCII -Value $pole_file_CSV_output
echo ""
echo "HOTOVO, toto ulozen do souboru : $export_CSV_filename"
sleep 5

