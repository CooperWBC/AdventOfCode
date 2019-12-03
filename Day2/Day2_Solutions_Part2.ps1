#
#  Advent of Code - Day 2 - Solutions
#
#  Link   : https://adventofcode.com/2019/day/2
#
#  Repo   : https://github.com/CooperWBC/2019-AdventOfCode
#

# Enviroment Prep / Maintenance
Clear-Host

function Run-Computer {

    Param(
        [int]$Noun,
        [int]$Verb
    )

    Get-Variable IntCode*,OpCode* -ErrorAction SilentlyContinue | Remove-Variable -ErrorAction SilentlyContinue

    # Retreive the IntCode Program
    [int[]]$IntCode_Program = (Get-Content .\input.txt).Split(",")

    # Update the IntCode Program to the "1202 Program Alarm" state it had before it caught fire.
    $IntCode_Program[1] = $Noun
    $IntCode_Program[2] = $Verb

    # Set Program Conditions
    $IntCode_Program_Position = 0
    $IntCode_Program_Status = "GO"

    # Run Program
    do {

        ### Step 0 : Sanitize Loop / Prep Enviroment ###
    
        Get-Variable OpCode* -ErrorAction SilentlyContinue | Remove-Variable -ErrorAction SilentlyContinue

        $IntCode_Program_Instructions_Processed++
    
        ### Step 1 : Parse OpCode ###

            # What do I need to do?
            $OpCode_Instruction      = $IntCode_Program[$IntCode_Program_Position]
    
            # Where do I get my inputs?
            $OpCode_Location_Input_1 = $IntCode_Program[$IntCode_Program_Position+1]
            $OpCode_Location_Input_2 = $IntCode_Program[$IntCode_Program_Position+2]

            # Where do I store the results?
            $OpCode_Output_Location  = $IntCode_Program[$IntCode_Program_Position+3]
    
        ### Part 2 : Execute OpCode ###

            # Run the OpCode
            switch($OpCode_Instruction)
                {
                    "1" # Addition
                        {
                            $OpCode_Result = $IntCode_Program[$OpCode_Location_Input_1] + $IntCode_Program[$OpCode_Location_Input_2]
                        }
                    "2" # Multiplication
                        {
                            $OpCode_Result = $IntCode_Program[$OpCode_Location_Input_1] * $IntCode_Program[$OpCode_Location_Input_2]
                        }
                    "99" # Halt
                        {
                            $IntCode_Program_Status = "HALT"
                        }
                }

            # Evaluate for request to halt program.
            if($IntCode_Program_Status -eq "HALT")
                {
                    break
                }

            # Save Results
            $IntCode_Program[$OpCode_Output_Location] = $OpCode_Result

        ### Step 3 : Increment Program Position to queue up the next OpCode ###
    
        $IntCode_Program_Position = $IntCode_Program_Position + 4

    }
    while ($IntCode_Program_Status -eq "GO")

    return $IntCode_Program[0]

}


$Noun = 40

do {

$Verb = 59
    
    do{
        
        $result = Run-Computer -Noun $Noun -Verb $Verb

        "Noun = "+("{0:00}" -f $noun)+" | "+"Verb = "+("{0:00}" -f $Verb)+" | "+"Result = "+("{0:00000000}" -f $result)

        if($result -eq 19690720)
            {
                Write-Host SUCCESS -ForegroundColor Cyan

                $Solution = 100 * $Noun + $Verb

                Write-Host "Solution = $Solution"

                $Verb = 999
                $noun = 999
            }

        $Verb++
    }
    while($Verb -lt 100)


$Noun++

}
while($Noun -lt 100)


