Clear-Host

#
# Puzzle 1
#

##### Parse Input #####

$Rules_Raw = Get-Content -Path .\2020\Day7\input.txt

$Rules_Parsed = @()

ForEach ($Rule in $Rules_Raw) {

    $Hash = @{}
    $Hash.Add("BagName",$Rule.Split(" bags contain ")[0])

    if(-not($Rule.Split(" bags contain ")[1] -eq 'no other bags.')) {
        $Rule.Split(" bags contain ")[1].Replace(".","").Replace(" bags","").Replace(" bag","").Split(", ") | ForEach-Object {
            $Hash.Add($_.Substring(2),$_.Substring(0,1))
        }
    }

    $Rules_Parsed += $Hash
}

##### FUNCTIONS #####

function  Get-BagContainers {
    param (
        [Parameter(Mandatory=$true)][string]$BagName
    )
    
    [string[]]$Results += ($Rules_Parsed | Where-Object {$BagName -in $_.Keys}).BagName
    
    if ($Results.Count -ne 0) {
        
        ($Rules_Parsed | Where-Object {$BagName -in $_.Keys}).BagName | ForEach-Object {
            $Results += Get-BagContainers -BagName $_
        }
    }
    
    return $Results
}

##### WORK #####

$Results = (Get-BagContainers -BagName 'shiny gold' | Select-Object -Unique).Count

Write-Host "Total Bags the Shiny Gold Bag could be inside of : $Results"

#
# Puzzle 2
#

##### FUNCTIONS #####

function Get-BagContents {
    param (
        [Parameter(Mandatory=$true)][string]$BagName
    )

    $Contains = 0

    $Rules = $Rules_Parsed | Where-Object {$_.BagName -eq $BagName}
    
    if (($Rules.Keys | Where-Object {$_ -ne 'BagName'}).Count -gt '0') {

        $Rules.Keys | Where-Object {$_ -ne 'BagName'} | ForEach-Object {
            $Contains = $Contains + $Rules.$_ + ( (Get-BagContents -BagName $_) * $Rules.$_ )
        }
    }
    else {
        $Contains = 0
    }

    return $Contains
}

##### WORK #####

$Results = Get-BagContents -BagName 'Shiny Gold'

Write-Host "Total Bags that could be inside of the Shiny Gold Bag : $Results"