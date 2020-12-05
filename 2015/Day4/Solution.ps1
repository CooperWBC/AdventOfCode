Clear-Host

#
# Puzzle 1
#

$Key = 'ckczppom'
#$Key = 'abcdef'

$Index = 0
#$Index = 609043

do {
    $Index++
    $String = $Key + $Index
}
while ( (Get-FileHash -Algorithm MD5 -InputStream ([IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($String)))).Hash -notlike "00000*" )

Write-Host "Loweset Positive Number : $Index"

#
# Puzzle 2
#

do {
    $Index++
    $String = $Key + $Index
}
while ( (Get-FileHash -Algorithm MD5 -InputStream ([IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($String)))).Hash -notlike "000000*" )

Write-Host "Loweset Positive Number : $Index"