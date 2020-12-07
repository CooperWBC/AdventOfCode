Clear-Host

#
# Puzzle 1
#

$CustomsForms = Get-Content -Path .\2020\Day6\input.txt

$Sums = @()
$Answers = @()

$CustomsForms | ForEach-Object {

    if($_ -eq '') {
        $Sums += ($Answers | Select-Object -Unique).Count
        $Answers = @()
        return
    }

    $Answers += [char[]]$_
}

$Sums += ($Answers | Select-Object -Unique).Count

Write-Host "Total Yes Answers : $(($Sums | Measure-Object -Sum).Sum)"

#
# Puzzle 2
#

$Sums = @()
$Group_Answers = @()

$CustomsForms+'' | ForEach-Object {

    if($_ -eq '') {
        
        $Answers = @()
        $Characters = @()

        $Group_Answers | ForEach-Object {
            $Characters += [char[]]$_
        }

        [Object[]]$Unique_Chars = $Characters | Select-Object -Unique

        ForEach ($Char in $Unique_Chars) {
            if(($Characters | Where-Object {$_ -eq $Char} | Measure-Object).Count -eq $Group_Answers.Count) {
                $Answers += $Char
            }
        }

        $Sums += ($Answers | Select-Object -Unique).Count
        $Group_Answers = @()

        return
    }
    
    $Group_Answers += $_
}

Write-Host "Group Yes Answers : $(($Sums | Measure-Object -Sum).Sum)"