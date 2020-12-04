Clear-Host

#
# Puzzle 1
#

$Course = Get-Content -Path .\Day3\input.txt

$MAX_X = $Course[0].Length - 1 
$MAX_Y = $Course.Count - 1 

$POS_X = 0
$POS_Y = 0

$count_trees = 0

while ($POS_Y -lt $MAX_Y) {

    # Move
    $POS_X = $POS_X + 3
    $POS_Y = $POS_Y + 1

    # Fix X
    if($POS_X -gt $MAX_X) {
        $POS_X = $POS_X - ($Course[0].Length)
    }

    # Check for Tree
    if($Course[$POS_Y].Chars($POS_X) -eq "#") {
        $count_trees++
    }
}

Write-Host "Trees: $count_trees"

#
# Puzzle 2
#

$Slope_1 = [PSCustomObject]@{
    "X"=1
    "Y"=1
}
$Slope_2 = [PSCustomObject]@{
    "X"=3
    "Y"=1
}
$Slope_3 = [PSCustomObject]@{
    "X"=5
    "Y"=1
}
$Slope_4 = [PSCustomObject]@{
    "X"=7
    "Y"=1
}
$Slope_5 = [PSCustomObject]@{
    "X"=1
    "Y"=2
}
$Slopes = $Slope_1,$Slope_2,$Slope_3,$Slope_4,$Slope_5

$results = @()

$Slopes | ForEach-Object {

    $POS_X = 0
    $POS_Y = 0
    
    $count_trees = 0

    while ($POS_Y -lt $MAX_Y) {

        # Move
        $POS_X = $POS_X + $_.X
        $POS_Y = $POS_Y + $_.Y
    
        # Fix X
        if($POS_X -gt $MAX_X) {
            $POS_X = $POS_X - ($Course[0].Length)
        }
    
        # Check for Tree
        if($Course[$POS_Y].Chars($POS_X) -eq "#") {
            $count_trees++
        }
    }

    $results += $count_trees
}

$solution = 1

$results| ForEach-Object {
    $solution = $solution * $_
}

Write-Host "Solution: $solution"