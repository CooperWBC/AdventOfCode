Clear-Host

#
# Puzzle 1
#

$Passports = Get-Content -Path .\Day4\input.txt

$Array = @()
$Hash = @{}

# Parse input into Hash Tables
$Passports | ForEach-Object {

    # If blank link store hashtable, create new hash table, and return.
    if($_ -eq '') {
        $Array += $Hash
        $Hash = @{}
        return
    }

    # Populate Hash
    $_.Split(" ") | ForEach-Object {
        $Hash.Add($_.Split(":")[0],$_.Split(":")[1])
    }
    
}

# Store the final Hash (The gotcha of Day 4 Part 1)
$Array += $Hash

# Count Valid Passports
$Valid = @()
$Array | ForEach-Object {
    if($_.Count -eq 8) {
        $Valid += $_
    }
    elseif ($_.Count -eq 7 -and 'cid' -notin $_.Keys) {
        $Valid += $_
    }
}

Write-Host "Valid Passports: $($Valid.Count)"

#
# Puzzle 2
#

$Bad = @()

$Valid | ForEach-Object {

    # BYR: 1920 to 2002
    if($_.byr -lt 1920 -or $_.byr -gt 2002) {
        $Bad += $_
        return
    }
    # IYR: 2010 to 2020
    if($_.iyr -lt 2010 -or $_.iyr -gt 2020) {
        $Bad += $_
        return
    }
    # EYR: 2020 to 2030
    if($_.eyr -lt 2020 -or $_.eyr -gt 2030) {
        $Bad += $_
        return
    }
    # hgt: Ends in cm or in.
    # CM 150 to 193. In 59 to 79 (The gotcha of Day 4 Part 2)
    if($_.hgt -notlike "*cm" -and $_.hgt -notlike "*in") {
        $Bad += $_
        return
    }
    elseif ($_.hgt -like "*cm" -and ($_.hgt.Replace('cm','') -lt 150 -or $_.hgt.Replace('cm','') -gt 193) ) {
        $Bad += $_
        return
    }
    elseif ($_.hgt -like "*in" -and ($_.hgt.Replace('in','') -lt 59 -or $_.hgt.Replace('in','') -gt 76) ) {
        $Bad += $_
        return
    }
    # hcl: Starts with #, 6 Digits of Hex
    if($_.hcl -notlike "#*") {
        $Bad += $_
        return
    }
    else {
        try {
            [Convert]::ToInt64($_.hcl.Replace("#",""),16) | Out-Null
        }
        catch {
            $Bad += $_
            return
        }
    }
    # ecl: Possible values are amb blu brn gry grn hzl oth
    if($_.ecl -notin 'amb','blu','brn','gry','grn','hzl','oth') {
        $Bad += $_
        return
    }
    # pid: 9 Digit Number (Leading 0's Included)
    if($_.pid.length -ne 9) {
        $Bad += $_
        return
    }
}

Write-Host "Valid Passports: $($Valid.Count - $bad.Count)"

<#

Wrong Guesses...
    126 to low
    129 to high
Why god, why am I a good person!?

#
# The Validator™ - Used variations of this to validate the data validation logic.
#

Clear-Host; $Valid.hgt | ForEach-Object { 
    if($_ -notlike "*cm" -and $_ -notlike "*in")
        {
            Write-Host "$_ - Ending Wrong" -ForegroundColor Red
            return
        }
    elseif ($_ -like "*cm" -and ($_.Replace('cm','') -lt 150 -or $_.Replace('cm','') -gt 193) ) {
        Write-Host "$_ - CM Wrong" -ForegroundColor Yellow
        return
    }
    elseif ($_ -like "*in" -and ($_.Replace('in','') -lt 59 -or $_.Replace('in','') -gt 76) ) {
        Write-Host "$_ - IN Wrong" -ForegroundColor Cyan
        return
    }    
    Write-Host $_ -ForegroundColor Green
}

#>