cls

# ke kzadymu souboru *.img v adresari vytvori davkovej soubor *.bat, ktere otevre program chirp a vne uz rovnou prislusnej soubor *.img

#$cesta_program_chirp = "C:\Program Files (x86)\CHIRP\chirpwx.exeeeeeeeee" # testovaci
$cesta_program_chirp = "C:\Program Files (x86)\CHIRP\chirpwx.exe" # tady editovat cestu

if (-not ( Test-Path $cesta_program_chirp )){
echo "nenalezen soubor $cesta_program_chirp"
echo "konec"
sleep 5
Exit
}

$img = @()
$img += @(Get-ChildItem *.img -Name) 
#echo $img
$d_img = $img.Length
#echo $d_img

# "C:\Program Files (x86)\CHIRP\chirpwx.exe" "Baofeng_BF-V8A_20250210-pmr-1-az-10-lidi_1-lidi_2-nemci_1-firma_hostivar-S_16-pmr.img"
for ( $aa = 0; $aa -le $d_img -1; $aa++){
$radek = ""
$radek += '"'
$radek += $cesta_program_chirp
$radek += '" "'
$pom = $img[$aa]
$radek += $pom
$radek += '"'
#echo $radek

$file_bat = $pom.Substring(0,$pom.Length -4) + ".BAT" # schvalene pripona velkym pismem, aby se to pak podle toho dobre hledalo
echo $file_bat

# smaze pripadnej starej *.bat soubor, pokud je
Remove-Item -Path $file_bat -ErrorAction SilentlyContinue
sleep 1
# a zapise novej
Set-Content -Path $file_bat -Encoding ASCII -Value $radek
sleep 1
}

echo "hotovo, bylo vytoreno $d_img novych souboru"
sleep 10
