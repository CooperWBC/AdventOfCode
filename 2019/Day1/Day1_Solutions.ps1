#
#  Advent of Code - Day 1
#
#  Link   : https://adventofcode.com/2019/day/1
#
#  Repo   : https://github.com/CooperWBC/2019-AdventOfCode
#

# Enviroment Prep / Maintenance
Clear-Host
Get-Variable Modules,Fuel* -ErrorAction SilentlyContinue | Remove-Variable

Write-Host "===== PART 1 =====" -ForegroundColor Cyan

#
#  PART 1
#
#  Problem  : "Calculate the fuel needed for the mass of each module (your puzzle input), then add together
#              all the fuel values."
#
#  Guidance : "Fuel required to launch a given module is based on its mass. Specifically, to find the fuel
#              required for a module, take its mass, divide by three, round down, and subtract 2."
#

# Get the mass of the individual modules from the input text file.
$Modules = Get-Content .\input.txt

# Calculate the fuel needed for all modules.
$Modules | ForEach-Object {

    $FuelNeeded_Part1 = $FuelNeeded_Part1 + [math]::Floor( $_ / 3 ) - 2

}

# Display Results
Write-Host
Write-Host "Total Fuel Required : " -ForegroundColor Yellow -NoNewline
Write-Host $FuelNeeded_Part1 -ForegroundColor Green
Write-Host

# Enviroment Prep / Maintenance
Write-Host "===== PART 2 =====" -ForegroundColor Cyan

#
#  PART 2
#
#  Problem  : "Apparently, you forgot to include additional fuel for the fuel you just added. Fuel itself
#              requires fuel just like a module"
#
#  Guidance : "take its mass, divide by three, round down, and subtract 2. However, that fuel also requires
#              fuel, and that fuel requires fuel, and so on. Any mass that would require negative fuel should
#              instead be treated as if it requires zero fuel; the remaining mass, if any, is instead handled
#              by wishing really hard, which has no mass and is outside the scope of this calculation.
#

# Recursive functions you say....

function Calculate-FuelNeeded {

    Param(
        [string]$Mass
    )

    $FuelNeeded_Initital = [math]::Floor( $Mass / 3 ) - 2
    
    if ($FuelNeeded_Initital -gt 0)
        {
            $FuelNeeded_Additional = Calculate-FuelNeeded -Mass $FuelNeeded_Initital
        }
    elseif($FuelNeeded_Initital -lt 0)
        {
            $FuelNeeded_Initital = 0
            $FuelNeeded_Additional = 0
        }
    
    $FuelNeeded_Total = $FuelNeeded_Initital + $FuelNeeded_Additional

    return $FuelNeeded_Total
    
}

# Calculate the fuel needed for all modules.
$Modules | ForEach-Object {

    $FuelNeeded_Part2 = $FuelNeeded_Part2 + (Calculate-FuelNeeded -Mass $_)

}

# Display Results
Write-Host
Write-Host "Total Fuel Required : " -ForegroundColor Yellow -NoNewline
Write-Host $FuelNeeded_Part2 -ForegroundColor Green