cls

$frekvence = 145.000 # tady menit cislo amenit taky krok
#$frekvence = 400.000
#$frekvence = 500.000

$krok = 0.0025 # 0.0025 = 2500Hz coz je minimalni krok

$max = 99 # maximalne 999

# LPD
<#
$frekvence_min = 433.075 # toto bude v CHipu na pametove pozici jedna, (dalsi pozice 2 bude toto plus $frekvence_krok atd.)
$frekvence_krok = 0.025 # pro pmr vzdy stejny
$max = 69 # max. polozek v chirp
#>


$pole_out = @()

$maska = "00000000" # nechat jak je

for ( $aa = 1; $aa -le $max; $aa++){
# uprava zaokrouhlenim
$x = $frekvence
[string] $x2 = [Math]::Ceiling($x * 10000) / 10000 # tohle mi poradil Microsoft copilot AI :)

if ($x2.Length -eq 3 ){ # pouze pro cela cisla 
$x2 = $x2 + ".000000" # nechat jak je
}

# doplni zbyvajici nuly na konci, vzdy do celkove delky 10 znaku (3 cisla + tecka + 6 desetin = 10 znaku celkem) 
if ($x2.Length -lt 10 ){
$x2 += $maska.Substring(0, 10 - $x2.Length)
}

echo $x2
$pole_out += $x2

$frekvence += $krok

}

# export do souboru
Set-Content "output.txt" -Encoding ASCII -Value $pole_out
echo "toto ulozeno do souboru - output.txt"
sleep 10

