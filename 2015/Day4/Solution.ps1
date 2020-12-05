Clear-Host

#
# Puzzle 1
#

$Key = 'ckczppom'
$Index = 0

do {
    $Index++
    $String = $Key + $Index
}
while ( (Get-FileHash -Algorithm MD5 -InputStream ([IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($String)))).Hash -notlike "00000*" )

Write-Host "Loweset Positive Number - Five Leading Zeros : $Index"

#
# Puzzle 2
#

do {
    $Index++
    $String = $Key + $Index
}
while ( (Get-FileHash -Algorithm MD5 -InputStream ([IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($String)))).Hash -notlike "000000*" )

Write-Host "Loweset Positive Number - Six Leading Zeros : $Index"