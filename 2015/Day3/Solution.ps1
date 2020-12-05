Clear-Host

#
# Puzzle 1
#

$Moves = Get-Content -Path .\2015\Day3\input.txt

$POS_X = 0
$POS_Y = 0

$Locations = @([System.Tuple]::Create($POS_X,$POS_Y))

[char[]]$Moves | ForEach-Object {
    switch ($_) {
        "^" {
            $POS_Y++
        }
        "v" {
            $POS_Y--
        }
        ">" {
            $POS_X++
        }
        "<" {
            $POS_X--
        }
    }
    $Locations += [System.Tuple]::Create($POS_X,$POS_Y)
}

Write-Host "Houses Getting Presents : $(($Locations | Select-Object -Unique).Count)"

#
# Puzzle 1
#

$POS_X_Santa = 0
$POS_Y_Santa = 0
$POS_X_RoboSanta = 0
$POS_Y_RoboSanta = 0

$Locations = @([System.Tuple]::Create($POS_X_Santa,$POS_Y_Santa))
$Locations += [System.Tuple]::Create($POS_X_RoboSanta,$POS_Y_RoboSanta)

$Santa = $true

[char[]]$Moves | ForEach-Object {


    switch ($_) {
        "^" {
            if ($Santa) {
                $POS_Y_Santa++
            }
            else {
                $POS_Y_RoboSanta++
            }
        }
        "v" {
            if ($Santa) {
                $POS_Y_Santa--
            }
            else {
                $POS_Y_RoboSanta--
            }
        }
        ">" {
            if ($Santa) {
                $POS_X_Santa++
            }
            else {
                $POS_X_RoboSanta++
            }
        }
        "<" {
            if ($Santa) {
                $POS_X_Santa--
            }
            else {
                $POS_X_RoboSanta--
            }
        }
    }

    if ($Santa) {
        $Locations += [System.Tuple]::Create($POS_X_Santa,$POS_Y_Santa)
    }
    else {
        $Locations += [System.Tuple]::Create($POS_X_RoboSanta,$POS_Y_RoboSanta)
    }

    if ($Santa) {
        $Santa = $false
    }
    else {
        $Santa = $true
    }
}

Write-Host "Houses Getting Presents : $(($Locations | Select-Object -Unique).Count)"