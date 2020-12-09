Clear-Host

#
# Puzzle 1
#

[long[]]$XMAS = Get-Content -Path .\2020\Day9\input.txt
$Premble = 25
$Index = 25

ForEach ($Number in $XMAS[$Index..$XMAS.Count]) {
    $Pass = $false
    $Candidates = $XMAS[($Index-$Premble)..($Index-1)]
    ForEach ($Candidate_1 in $Candidates) {
        ForEach ($Candidate_2 in $Candidates) {
            if (($Candidate_1 + $Candidate_2) -eq $Number) {
                $Pass = $true
            }
        }
    }
    if(!$Pass) {
        Write-Host "Deviant : $Number"
        break
    }
    $Index++
}

#
# Puzzle 2
#