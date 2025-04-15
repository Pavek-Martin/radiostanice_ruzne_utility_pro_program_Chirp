cls
# vypise vsech frekvence pro dPMR kanal 1 az 16 ( digitalni )

$kanal_dpmr_jedna=446.103125 # frekvence prvniho kanalu dPMR-01
$frekvence_krok=0.00625 # odskok mezi kanalama (vzdy stejny)

<#
echo $kanal_dpmr_jedna
echo $kanal_dpmr_jedna.GetType()
echo $frekvence_krok
echo $frekvence_krok.GetType()
#>

$pole_out=@()

$napis_1="vypis frekvenci vsech dPMR kanalu 1 - 16"
echo $napis_1
$pole_out+=$napis_1
echo ""
$pole_out+=""
$radek_1="dPMR-01 = $kanal_dpmr_jedna Mhz"
echo $radek_1
$pole_out+=$radek_1
$poc=2

for ($i = 1; $i -le 15; $i++){ 
$out = "dPMR-"

if ( $poc -lt 10 ) {
$out = "dPMR-0"
$out += [string] $poc
}else{
$out += [string] $poc
}

$out += " = "
[string] $pomocna = ( $kanal_dpmr_jedna + ( $i * $frekvence_krok ))
$out+= $pomocna
$out += " Mhz "
echo $out
$pole_out+=$out
$poc++
}

# zapise vystup do souboru
$file_name = "dPMR.txt"
Set-Content -Path $file_name -Encoding ASCII -Value $pole_out
Write-Host -ForegroundColor Yellow "ulozeno do souboru $file_name"

# ceka na zavreni okna
Read-Host -Prompt "Press ENTER = exit"



