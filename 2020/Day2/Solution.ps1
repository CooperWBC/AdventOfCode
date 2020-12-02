Clear-Host

#
# Puzzle 1
#

$Passwords = Get-Content -Path .\input.txt

$Passwords_Valid_1 = @()

$Passwords | ForEach-Object {

    $Instances_Min = $_.split(" ")[0].split("-")[0]
    $Instances_Max = $_.split(" ")[0].split("-")[1]
    $Letter = $_.split(" ")[1].replace(":","")
    $Password = $_.split(" ")[2]

    # First Pass
    # $Instances_Actual = ($Password.EnumerateRunes() | Where-Object {$_.Value -eq [byte][char]$Letter}).Count
    
    # Second Pass
    $Instances_Actual = ([char[]]$password -eq $letter).count

    if($Instances_Actual -ge $Instances_Min -and $Instances_Actual -le $Instances_Max) {
        $Passwords_Valid_1 += $_
    }
}

Write-Host "Valid Passwords: $($Passwords_Valid_1.count)"

#
# Puzzle 2
#

$Passwords_Valid_2 = @()

$Passwords | ForEach-Object {

    $Position_1 = $_.split(" ")[0].split("-")[0]
    $Position_2 = $_.split(" ")[0].split("-")[1]
    $Letter = $_.split(" ")[1].replace(":","")
    [char[]]$Password = $_.split(" ")[2]
    
    if(($Password[$Position_1-1] -eq $letter) -xor ($Password[$Position_2-1] -eq $letter)) {
        $Passwords_Valid_2 += $_
    }
}

Write-Host "Valid Passwords: $($Passwords_Valid_2.count)"