Clear-Host

#
# Puzzle 1
#

$Directions = Get-Content -Path .\2015\Day1\input.txt
Write-Host "Floor: $(([char[]]$Directions | Where-Object {$_ -eq '('}).Count - ([char[]]$Directions | Where-Object {$_ -eq ')'}).Count)"

#
# Puzzle 1
#

$Floor = 0
$Position = 0

[char[]]$Directions | ForEach-Object {
    if ($_ -eq "(") {
        $Floor++
    }
    elseif ($_ -eq ")") {
        $Floor--
    }
    $Position++
    if($Floor -lt 0)
        {
            Write-Host "Position: $Position"
            break
        }
}