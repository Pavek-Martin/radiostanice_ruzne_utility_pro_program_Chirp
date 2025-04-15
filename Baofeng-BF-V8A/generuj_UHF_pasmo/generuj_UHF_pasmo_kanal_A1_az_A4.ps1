cls

$vrsek="Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,RxDtcsCode,CrossMode,Mode,TStep,Skip,Power,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE"
#          ^^ tento redek je vzdy stejny
$pole_file_CSV_output = @()
$pole_file_CSV_output += $vrsek

$vloz_stred_1 = ",,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,"
$vloz_stred_2 = ",5.00,,"


############## zde edit zona ###################
$export_CSV_filename = "Baofeng_BF-V8A_UHF_pasmo_kanal_A1_az_A4.csv"

Remove-Item $export_CSV_filename -force -ErrorAction SilentlyContinue
sleep 1

$frekvence_min = 442.200000 # toto bude v CHipu na pametove pozici jedna, (dalsi pozice 2 bude toto plus krok atd.)
$frekvence_krok = 0.025
$max_pametova_pozice_v_chirp = 4
#
#
$pole_FM_nebo_NFM = @("FM","NFM")
$FM_nebo_NFM = $pole_FM_nebo_NFM[0] # [0]=FM; [1]=NFM
#
$pole_vykon = @("0.5W", "2.0W")
$vykon = $pole_vykon[0] # [0]=0.5W; [1]=2.0W
#

$komentar_kanalu_prefix = "UHF A/"

############### kone edit zony #################

$maska = "00000000000"

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

