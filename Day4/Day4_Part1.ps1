#
#  Advent of Code - Day 4 - Solutions
#
#  Link   : https://adventofcode.com/2019/day/4
#
#  Repo   : https://github.com/CooperWBC/2019-AdventOfCode
#

#
# Password Hints
#
# 1 : It is a six-digit number.
# 2 : The value is within the range given in your puzzle input.
# 3 : Two adjacent digits are the same (like 22 in 122345).
# 4 : Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
#
# Puzzle Input = 273025-767253
#

##############################################################################################################################################
#
# Define Functions

function Test-Increase {

    param(
    [int]$test
    )

    # https://stackoverflow.com/questions/19963872/how-can-i-convert-a-number-into-an-array-of-digits
    [int[]]$Array = ($test -split '') -ne ''

    $failure = $false

    0..4 | ForEach-Object {

        <#
        $first = $Array[$_]
        $Second = $Array[$_+1]

        Write-Host $Array[$_] -ForegroundColor Yellow -NoNewline
        Write-Host " : " -NoNewline
        Write-Host $Array[$_+1] -ForegroundColor Yellow -NoNewline
        Write-Host " : " -NoNewline
        $first -le $Second
        #>

        if(-NOT($Array[$_] -le $Array[$_+1]))
            {
                $failure = $true
            }
    }

    if($failure)
        {
            return $false
        }
    else
        {
            return $true
        }

}

function Test-Double {

    param(
    [int]$test
    )

    # https://stackoverflow.com/questions/19963872/how-can-i-convert-a-number-into-an-array-of-digits
    [int[]]$Array = ($test -split '') -ne ''

    $double = $false

    0..4 | ForEach-Object {

        if($Array[$_] -eq $Array[$_+1])
            {
                $double = $true
            }
    }

    if($double)
        {
            return $true
        }
    else
        {
            return $false
        }

}

<#
# Function Test
$test = 103356
Test-Increase $test
Test-Double $test
#>

##############################################################################################################################################

# Enviroment Prep / Maintenance
Clear-Host
Get-Variable Password*,test,ProgressBar*,Solutions -ErrorAction SilentlyContinue | Remove-Variable

# Start the Clock
Measure-Command -Expression {


    # List Possibilities

    $Password_All = 273025..767253

    $ProgressBar_Index = 1
    $ProgressBar_Maximum = 767253 - 273025
    $Password_Possible_Solutions = @()


    $Password_All | ForEach-Object {

        Write-Progress -Activity "Reticulating Splines" -Status "$ProgressBar_Index of $ProgressBar_Maximum" -Id 1 -PercentComplete (($ProgressBar_Index / $ProgressBar_Maximum) * 100)
        $ProgressBar_Index++

        if((Test-Increase $_) -and (Test-Double $_))
            {
                $Password_Possible_Solutions += $_
            }
    }

} -OutVariable stopwatch
