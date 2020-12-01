#
#  Advent of Code - Day 2 - Solutions
#
#  Link   : https://adventofcode.com/2019/day/2
#
#  Repo   : https://github.com/CooperWBC/2019-AdventOfCode
#

# Enviroment Prep / Maintenance
Clear-Host
Get-Variable IntCode*,OpCode* -ErrorAction SilentlyContinue | Remove-Variable

Write-Host "===== PART 2 - Run 1202 Program Alarm =====" -ForegroundColor Yellow
Write-Host 

#
#  Problem  : Shit's broke yo, create an Opcode computer and run an IntCode Program from the 1202 Program Alarm State.
#
#  Guidance : See Notes.txt
#

# Retreive the IntCode Program
[int[]]$IntCode_Program = (Get-Content .\input.txt).Split(",")

# Update the IntCode Program to the "1202 Program Alarm" state it had before it caught fire.
$IntCode_Program[1] = 12 # NOUN
$IntCode_Program[2] = 2 # VERB

# Set Program Conditions
$IntCode_Program_Position = 0
$IntCode_Program_Status = "GO"

# Run Program
do {

    ### Step 0 : Sanitize Loop / Prep Enviroment ###
    
    Get-Variable OpCode* -ErrorAction SilentlyContinue | Remove-Variable

    $IntCode_Program_Instructions_Processed++

    Write-Host "Instruction"("{0:00}" -f $IntCode_Program_Instructions_Processed)"- " -NoNewline
    
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
                        Write-Host "Addition" -ForegroundColor Cyan
                        $OpCode_Result = $IntCode_Program[$OpCode_Location_Input_1] + $IntCode_Program[$OpCode_Location_Input_2]
                    }
                "2" # Multiplication
                    {
                        Write-Host "Multiplication" -ForegroundColor Green
                        $OpCode_Result = $IntCode_Program[$OpCode_Location_Input_1] * $IntCode_Program[$OpCode_Location_Input_2]
                    }
                "99" # Halt
                    {
                        Write-Host "Halt" -ForegroundColor Red
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

Write-Host
Write-Host "Result" -ForegroundColor Yellow -NoNewline
Write-Host " - " -ForegroundColor DarkGray -NoNewline
Write-Host $IntCode_Program[0]
Write-Host