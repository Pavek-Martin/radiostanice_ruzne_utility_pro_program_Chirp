cls

$vrsek = "Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,RxDtcsCode,CrossMode,Mode,TStep,Skip,Power,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE"
# toje je upne stejne pro obe vysilacky, jak malou tak velkou ten $vrsek !

$pole_file_CSV_output = @()
$pole_file_CSV_output += $vrsek

$vloz_stred_1 = ",,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,"

$vloz_stred_2 = ",5.00,," # bez preskakovani kanalu pri skenu ,,
$vloz_stred_3 = ",5.00,S," # bude presakovat pri skenovani ,S,
$export_CSV_filename = "Baofeng_UK-K61_"

############## zde uzivatelska edit zona ###################
# da se manipulovat se 4mi hodnotamy : $pasmo; $AM_nebo_FM; $vykon; $preskocit_skenovani


$pole_pasmo = @( "PMR" ,"LPD", "UHF" )
$pasmo = $pole_pasmo[2] # [0]=PMR; [1]=LPD; [2]=UHF
# je tim myslen, UHF kanal 6-9 ( A/1 az A/4 ), u UHF kanalu 1-5 a VHF kanalu 1-5 jsou ruzne frekvencni odskoky, cili nelze pouzit !
# mozna case pujde jeste doplnit i o dalsi pasma kde je pravidelny odskok mezi kanalama, zatim takhle


$pole_AM_nebo_FM = @( "AM", "FM" )
$AM_nebo_FM = $pole_AM_nebo_FM[1] # [0]=AM; [1]=FM


$pole_vysilaci_vykon = @( "1.0W", "5.0W" )
$vysilaci_vykon = $pole_vysilaci_vykon[1] # [0]=1.0W; [1]=5.0W


$pole_skenovat = @( 0, 1 )
$preskocit_skenovani = $pole_skenovat[0] # [0]=nebude preskakovat skenovani; [1]=bude preskakovat skenovani kanalu
# preskakovani skenovani zle nastavit pouze pro vsechno najenednou, nikoliv jednotlive, tzn. vypnout nebo zapnout vsechny polozky


############### zde konec edit zony #################

if ( $pasmo -like "PMR" ) {
#echo "vybrano PMR pasmo "
$frekvence_min = 446.006250
$frekvence_krok = 0.0125
$nasobek = 1000000
$export_CSV_filename += "PMR"
$komentar_pametove_pozice = "PMR"
$max_pametova_pozice_v_chirp = 16 # da se upravovat, pro PMR
}elseif ( $pasmo -like "LPD" ) {
#echo "vybrano LPD pasmo "
$frekvence_min = 433.075
$frekvence_krok = 0.025
$nasobek = 10000
$export_CSV_filename += "LPD"
$komentar_pametove_pozice = "LPD"
$max_pametova_pozice_v_chirp = 69 # da se upravovat, pro LPD
}elseif ( $pasmo -like "UHF" ) {
#echo "vybrano UHF pasmo "
$frekvence_min = 442.200000
$frekvence_krok = 0.025
$nasobek = 1000000
$export_CSV_filename += "UHF"
$komentar_pametove_pozice = "UHF"
$max_pametova_pozice_v_chirp = 4 # s timhle nehejbat ! aby bylo UHF A/1 - A/4
}else{
echo "CHYBA VYBERU PASMA"
echo "vyber radek 17,18 nebo 19"
echo "konec"
sleep 3
exit
}

$export_CSV_filename += "_pasmo_kanal_1_az_"
$export_CSV_filename += [string] $max_pametova_pozice_v_chirp
$export_CSV_filename += ".csv"

$maska = "00000000"

for ( $pametova_pozice = 1; $pametova_pozice -le $max_pametova_pozice_v_chirp; $pametova_pozice++ ){
#echo $pametova_pozice
$radek = [string] $pametova_pozice
$radek +=","
$radek += $komentar_pametove_pozice
$radek += " "
# upraveno pro UHF 6-9
if ( $pasmo -like "UHF" ){
$pro_UHF_1 = [string] (( $pametova_pozice + 5 ))
$pro_UHF_1 += " A/"
$pro_UHF_1 += [string] $pametova_pozice
$radek += $pro_UHF_1
}else{
$radek += [string] $pametova_pozice
}

$radek +=","

# uprava zaokrouhlenim
$x = $frekvence_min
[string] $x2 = [Math]::Ceiling($x * $nasobek) / $nasobek # tohle mi poradil Microsoft copilot AI :)
#  napred vynasobit  krat 1000 aby se posunula desetina mista, zaokrouhlit  a pak vysledek opet zpatky vydelit /1000
# podminka pro cele cislo napr. "434" bylo pri pasmu LPD
if ($x2.Length -eq 3 ){
$x2 = $x2 + ".000000" # takze prida desetiny mista aby se to pak libylo programu Chirp, jinak by rval
}

# libovolne desetine cislo napr. "433.9, 433,85, 433.925"
if ($x2 -gt 3 ){
$x2 += $maska.Substring(0,10 - $x2.Length) # veme cast $maska a doplni retezec aby byl vzdy stejne dlouhy pro Chirp
}

$radek += $x2
# konec uprava zaokrolovani ( a doplneni nul ) pro polozku vysilaci frekvence - Mhz
$radek += $vloz_stred_1
$radek += $AM_nebo_FM

# vyhodnoceni polozky preskocit scanovani
if ( $preskocit_skenovani -eq 0 ){ 
$radek += $vloz_stred_2
}else{
$radek += $vloz_stred_3
}

$radek += $vysilaci_vykon
$radek += ","
# pridano sloupec comment
$radek += $komentar_pametove_pozice
$radek += " "

# upraveno pro UHF 6-9 
if ( $pasmo -like "UHF" ){
$radek += $pro_UHF_1 # pamatuje si hodnotu z predsle podminky a je zde potreba to same
}else{
$radek += [string] $pametova_pozice
}

$radek += ",,,," # na kazdem konci radku toto

$frekvence_min += $frekvence_krok # pricte dalsi frekvencni krok pro for cyklus
# jinak tady je vydet, ze pricita vzdy stejnou sumu, cili nepouzitelne jinde napr. pasmo VHF, apod.

#echo $radek
$pole_file_CSV_output += $radek
}

echo $pole_file_CSV_output

#echo "4,UHF 6 A/1,442.200000,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,FM,5.00,,5.0W,UHF 6 A/1,,,, CVS"
#echo "4,UHF 6 A/1,442.200000,,0.000000,,88.5,88.5,023,NN,023,Tone->Tone,FM,5.00,S,5.0W,UHF 6 A/1,,,, CVS preskocit scan "
#echo "1,UHF 6 A/1,442.200000,,0.000000,DTCS,88.5,88.5,031,RN,023,Tone->Tone,FM,5.00,S,5.0W,UHF 6 A/1,,,, CVS ALL radek" 


# paklize by jiz existoval soubor CVS stejneho nazvu tak napred vymaze stary ( je to pro pripad nejake chyby zapisu apod.)
Remove-Item  $export_CSV_filename -Force -ErrorAction SilentlyContinue
sleep 1

# export do souboru *.CSV, zapise novy soubor CVS
Set-Content $export_CSV_filename -Encoding ASCII -Value $pole_file_CSV_output
echo ""
Write-Host -ForegroundColor Yellow "HOTOVO, toto ulozeno do souboru : $export_CSV_filename"
sleep 5

