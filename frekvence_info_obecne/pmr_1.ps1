cls
# vypise vsech frekvence pro pmr kanal 1 az 16 ( normalni ne digitalni )

$kanal_pmr_jedna=446.00625
$frekvence_krok=0.0125

<#
echo $kanal_pmr_jedna
echo $kanal_pmr_jedna.GetType()
echo $frekvence_krok
echo $frekvence_krok.GetType()
#>

$pole_out=@()

$napis_1="vypis frekvenci vsech PMR kanalu 1 - 16"
echo $napis_1
$pole_out+=$napis_1
echo ""
$pole_out+=""
$radek_1="PMR-01 = $kanal_pmr_jedna Mhz"
echo $radek_1
$pole_out+=$radek_1
$poc=2

for ($i = 1; $i -le 15; $i++){ 
$out = "PMR-"

if ( $poc -lt 10 ) {
$out = "PMR-0"
$out += [string] $poc
}else{
$out += [string] $poc
}

$out += " = "
[string] $pomocna = ( $kanal_pmr_jedna + ( $i * $frekvence_krok ))
$out+= $pomocna
$out += " Mhz "
echo $out
$pole_out+=$out
$poc++
}

# zapise vystup do souboru
$file_name = "PMR.txt"
Set-Content -Path $file_name -Encoding ASCII -Value $pole_out
Write-Host -ForegroundColor Yellow "ulozeno do souboru $file_name"

# ceka na zavreni okna
Read-Host -Prompt "Press ENTER = exit"



