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
        break
    }
    $Index++
}

Write-Host "            Deviant : $Number"

#
# Puzzle 2
#

$Index = 0

While ($true) {
    $SUM = $XMAS[$Index]
    $Index_Loop = $Index + 1
    While ($SUM -lt $Number) {
        $SUM = $SUM + $XMAS[$Index_Loop]
        $Index_Loop++
    }
    if($SUM -eq $Number) {
            Write-Host "     Sequence Start : $Index"
            Write-Host "       Sequence End : $Index_Loop"
            $MIN = $XMAS[$Index..$Index_Loop] | Sort-Object | Select-Object -First 1
            $MAX = $XMAS[$Index..$Index_Loop] | Sort-Object | Select-Object -Last 1
            break
    }
    $Index++
}

Write-Host "Encryption Weakness : $($MIN+$MAX)"