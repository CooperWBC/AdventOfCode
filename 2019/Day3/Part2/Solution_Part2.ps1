#
#  Advent of Code - Day 3 - Solutions
#
#  Link   : https://adventofcode.com/2019/day/3
#
#  Repo   : https://github.com/CooperWBC/2019-AdventOfCode
#

##############################################################################################################################################
#
# Define Functions

function Trace-WirePath {

    # Kudos to u/PendragonDaGreat for teaching me this solution through the solution posted on Reddit. I had never considered to use a hash table in this manner.
    #  * https://www.reddit.com/user/PendragonDaGreat/
    #  * https://www.reddit.com/r/adventofcode/comments/e5bz2w/2019_day_3_solutions/f9kfwvp/
    #  * https://github.com/Bpendragon/AdventOfCode/blob/master/src/2019/code/day03.ps1

    param(
        [string]$Wire
    )

    # Define wires starting coordinates
    $Location_X = 0
    $Location_Y = 0

    # Define a variable to store the total length of the wire.
    $Wire_length = 0

    # Parse wire into steps
    $Wire_Instructions = $Wire.split(",")

    # Create a empty hash table to store coordinates in.
    $results = @{}
    
    # Trace the path that the wire takes by incrementaly processsing each step and recording the generated coordinates.
    Foreach ($Wire_Instruction in $Wire_Instructions)
        {
            # Find the direction this step takes
            $Wire_Instruction_Direction = $Wire_Instruction.Substring(0,1)

            # Find the distance this step goes
            [int]$Wire_Instruction_Distance = $Wire_Instruction.Substring(1,$Wire_Instruction.Length-1)

            # 
            do {
                # Determine which direct we are moving and move one in that direction.
                Switch ($Wire_Instruction_Direction)
                    {
                        "R"
                            {
                                $Location_X++
                            }
                        "L"
                            {
                                $Location_X--
                            }
                        "U"
                            {
                                $Location_Y++
                            }
                        "D"
                            {
                                $Location_Y--
                            }
                    }

                # Increment total distance traveled on the wire.
                $Wire_length++

                # Decrement the distance we still need to travel this step.
                $Wire_Instruction_Distance--

                # Store the current coordinates in the hash table as a key and the distance traveled from the central port as the value. Only if the existing key value pair does not already exist in the hash table (or you will override the record of the wire length from the central port.
                #  < Insert Thanks to u/PendragonDaGreat >
                if(-not($results.ContainsKey("$Location_X,$Location_Y")))
                    {
                        $results["$Location_X,$Location_Y"] = $Wire_length
                    }
            }
            while ($Wire_Instruction_Distance -gt 0)
        }

    return $results
}

###############################################################################################################################################

# Enviroment Prep / Maintenance
Clear-Host
Get-Variable Input_*,Example*,trace*,wire*,location*,results* -ErrorAction SilentlyContinue | Remove-Variable

Write-Host "===== PART 2 - Do everything over again, but better. Then tackle the hard mode challange. =====" -ForegroundColor Yellow
Write-Host 

#
# Step 1 - Trace Wire Paths
#

# Get Wire Information
$Input_Wires = Get-Content .\input.txt

# Trace Wire Paths
$Trace_Wire_0 = Trace-WirePath -Wire $Input_Wires[0]
$Trace_Wire_1 = Trace-WirePath -Wire $Input_Wires[1]

#
# Step 2 - Find Intersections
#

### Option Best ###

#  < Insert Thanks to u/PendragonDaGreat >

Measure-Command -Expression {
    $Trace_Wire_Intersections = $Trace_Wire_0.Keys | Where-Object { $Trace_Wire_1.ContainsKey($_) }
}

    # Runtime of 2.5 Seconds

<#
 
### Option - Okay ###

Measure-Command -Expression {

# Define an empty array to hold coordinates and wire length information for each wire intersection.
$Trace_Wire_Intersections = [System.Collections.ArrayList]@()

# Define Write-Progress Variables
$Progress_Index = 1
$Progress_Total = $Trace_Wire_0.Count

foreach($key in $Trace_Wire_0.Keys)
    {
        # Progress Bar
        Write-Progress -Id 1 -Activity "Finding Wire Intersections" -Status "$Progress_Index of $Progress_Total" -PercentComplete (($Progress_Index / $Progress_Total) * 100)
        $Progress_Index++

        if($Trace_Wire_1.ContainsKey($key))
            {
                $Trace_Wire_Intersections.Add($key)
            }
    }
}

    # Runtime of 140.267 Seconds.

### Option - Worst

    # See .\Day3\Part1\Solution.ps1

    # Runtime of ~1 Hour, 45 Minutes.

#>

#
# Solution - Part 1 - What is the Manhattan distance from the central port to the closest intersection?
#

$Solutions_Part1 = @()

foreach ($Crossing in $Trace_Wire_Intersections)
    {

        # Get Components
        [int[]]$parts = $Crossing -split ","

        $Part_0 = $parts[0]
        $Part_1 = $parts[1]

        # Deal With Negative Numbers
        if($parts[0] -lt 0)
            {
                $Part_0 = $Part_0 * -1
            }
        if($parts[1] -lt 0)
            {
                $Part_1 = $Part_1 * -1
            }

        # Calculate Distance and add to Solutions Array
        $Solutions_Part1 += $Part_0+$Part_1

    }

#
# Solution - Part 2 - What is the fewest combined steps the wires must take to reach an intersection?
#

$Solutions_Part2 = @()

$Trace_Wire_Intersections | ForEach-Object {

    $Distance_Wire_0 = $Trace_Wire_0[$_]
    $Distance_Wire_1 = $Trace_Wire_1[$_]

    $Solutions_Part2 += $Distance_Wire_0+$Distance_Wire_1

}




Write-Host 
Write-Host "Solutions" -ForegroundColor Cyan
Write-Host "Part 1 - " -ForegroundColor DarkGreen -NoNewline
($Solutions_Part1 | Measure-Object -Minimum).Minimum
Write-Host "Part 2 - " -ForegroundColor DarkGreen -NoNewline
($Solutions_Part2 | Measure-Object -Minimum).Minimum



