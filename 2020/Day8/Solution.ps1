Clear-Host

#
# Puzzle 1
#

$BootCode = Get-Content -Path .\2020\Day8\input.txt

$Index_Current = 0
$Index_History = @()
$Accumulator = 0

While ($Index_Current -notin $Index_History) {

    $Index_History += $Index_Current

    $Instruction = $BootCode[$Index_Current]

    $Operation = $Instruction.split(' ')[0]
    [int]$Argument = $Instruction.split(' ')[1]

    switch ($Operation) {
        "acc" {
            #Write-Host "$Index_Current : ACC : $Argument"
            $Accumulator = $Accumulator + $Argument
            $Index_Current++
        }
        "jmp" {
            #Write-Host "$Index_Current : JMP : $Argument"
            $Index_Current = $Index_Current + $Argument
        }
        "nop" {
            #Write-Host "$Index_Current : NOP : $Argument"
            $Index_Current++
        }
    }
}

Write-Host "Accumulator @ Loop : $Accumulator"

#
# Puzzle 2
#

ForEach ($Index in $Index_History) {

    $BootCode = Get-Content -Path .\2020\Day8\input.txt

    $Instruction_Broken = $BootCode[$Index]

    if ($Instruction_Broken -notlike "acc*") {

        if($Instruction_Broken -like 'jmp*') {
            $Instruction_Fixed = $Instruction_Broken.Replace('jmp','nop')
        }
        elseif ($Instruction_Broken -like 'nop*') {
            $Instruction_Fixed = $Instruction_Broken.Replace('nop','jmp')
        }

        $BootCode[$Index] = $Instruction_Fixed
    }
    
    $Index_Current = 0
    $Index_History = @()
    $Accumulator = 0

    While ($Index_Current -notin $Index_History -and $Index_Current -lt $BootCode.Count) {

        $Index_History += $Index_Current

        $Instruction = $BootCode[$Index_Current]

        $Operation = $Instruction.split(' ')[0]
        [int]$Argument = $Instruction.split(' ')[1]

        switch ($Operation) {
            "acc" {
                $Accumulator = $Accumulator + $Argument
                $Index_Current++
            }
            "jmp" {
                $Index_Current = $Index_Current + $Argument
            }
            "nop" {
                $Index_Current++
            }
        }      
    }
    
    if ($Index_Current -ge $BootCode.Count) {
        Write-Host "Accumulator @ End : $Accumulator"
        break
    }
}