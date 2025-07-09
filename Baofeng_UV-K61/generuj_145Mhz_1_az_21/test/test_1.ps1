cls

$frekvence = 145.000 # tady menit cislo amenit taky krok
#$frekvence = 400.000
#$frekvence = 500.000

$krok = 0.0025 # 0.0025 = 2500Hz coz je minimalni krok

$max = 999 # maximalne 999

# LPD
<#
$frekvence_min = 433.075 # toto bude v CHipu na pametove pozici jedna, (dalsi pozice 2 bude toto plus $frekvence_krok atd.)
$frekvence_krok = 0.025 # pro pmr vzdy stejny
$max = 69 # max. polozek v chirp
#>


$maska = "00000000" # nechat jak je

for ( $aa = 1; $aa -le $max; $aa++){
# uprava zaokrouhlenim
$x = $frekvence
echo "      $x -- puvodni vypoctena hodnota"
[string] $x2 = [Math]::Ceiling($x * 10000) / 10000 # tohle mi poradil Microsoft copilot AI :)
echo "      $x2 -- puvodni hodnota po zaokrouhleni"

#$x2 = "145.2325000000" # test, pro delsi nz 10 znaku celkem

if ($x2.Length -eq 3 ){ # pouze pro cela cisla 
$x2 = $x2 + ".000000" # nechat jak je
}

# doplni zbyvajici nuly na konci, vzdy do celkove delky 10 znaku (3 cisla + tecka + 6 desetin = 10 znaku celkem) 
if ($x2.Length -lt 10 ){
$x2 += $maska.Substring(0, 10 - $x2.Length)
} else { # pokud by bylo nahodou vice nez 10 znaku
#echo "bylo vice naz 10 znaku !"
$x2 = $x2.Substring(0, 10) # delsi nez 10 znaku zkrati na 10
} 
# osetreno proti cemukoliv

[string] $aa2 = $aa

if ($aa2.Length -eq 1 ){
$aa2 = "00" + $aa2
} elseif ( $aa2.Length -eq 2 ) {
$aa2 = "0" + $aa2
}

echo "$aa2 - $x2 -- finalni upravene hodnota pro export do programu Chirp"
#echo $x2

echo ""

$frekvence += $krok
}

sleep 10

