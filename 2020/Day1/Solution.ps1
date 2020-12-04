Clear-Host

#
# Puzzle 1
#

[int[]]$Numbers = Get-Content -Path .\Day1\input.txt

:outer foreach($Number in $Numbers) {
    $Number_1 = $Number
    foreach($Number in $Numbers) {
        $Number_2 = $Number
        if(($Number_1 + $Number_2) -eq 2020) {
            Write-Host "$Number_1 + $Number_2 = $($Number_1 + $Number_2)"
            Write-Host "$Number_1 * $Number_2 = $($Number_1 * $Number_2)"
            break outer
        }
    }
}

#
# Puzzle 2
#

Get-Variable Number,Number_* | Remove-Variable

:outer foreach($Number in $Numbers) {
    $Number_1 = $Number
    foreach($Number in $Numbers) {
        $Number_2 = $Number
        foreach($Number in $Numbers) {
            $Number_3 = $Number
            if(($Number_1 + $Number_2 + $Number_3) -eq 2020) {
                Write-Host "$Number_1 + $Number_2 + $Number_3 = $($Number_1 + $Number_2 + $Number_3)"
                Write-Host "$Number_1 * $Number_2 * $Number_3 = $($Number_1 * $Number_2 * $Number_3)"
                break outer
            }
        }
    }
}