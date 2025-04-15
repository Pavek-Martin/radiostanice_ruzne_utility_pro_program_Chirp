cls
# vypise vsech frekvenci LPD kanalu - 1 az 69

$kanal_LPD_jedna=433.075
$frekvence_krok=0.025

<#
echo $kanal_LPD_jedna
echo $kanal_LPD_jedna.GetType() # Double
echo $frekvence_krok
echo $frekvence_krok.GetType()
#>

$pole_out=@()

$napis_1="vypis frekvenci vsech LPD kanalu 1 - 69"
echo $napis_1
$pole_out+=$napis_1
echo ""
$pole_out+=""
$radek_1="LPD-01 = $kanal_LPD_jedna Mhz"
echo $radek_1
$pole_out+=$radek_1
$poc=2

for ($i = 1; $i -le 68; $i++){ 
$out = "LPD-"

if ( $poc -lt 10 ) {
$out = "LPD-0"
$out += [string] $poc
}else{
$out += [string] $poc
}

$out += " = "
[string] $pomocna = ( $kanal_LPD_jedna + ( $i * $frekvence_krok ))
$d_pomocna = $pomocna.Length
#echo $d_pomocna

if ( $d_pomocna -eq 3 ){
$pomocna = $pomocna + ".000"
}elseif ( $d_pomocna -eq 5 ){
$pomocna = $pomocna + "00"
}elseif ( $d_pomocna -eq 6 ){
$pomocna = $pomocna + "0"
}

$out+= $pomocna

$out += " Mhz "
echo $out
$pole_out+=$out
$poc++
}

# zapise vystup do souboru
$file_name = "Pasmo_LPD.txt"
Set-Content -Path $file_name -Encoding ASCII -Value $pole_out
Write-Host -ForegroundColor Yellow "ulozeno do souboru $file_name"

# ceka na zavreni okna
Read-Host -Prompt "Press ENTER = exit"



