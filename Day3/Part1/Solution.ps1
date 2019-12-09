#
#  Advent of Code - Day 3 - Solutions
#
#  Link   : https://adventofcode.com/2019/day/3
#
#  Repo   : https://github.com/CooperWBC/2019-AdventOfCode
#

# Enviroment Prep / Maintenance
Clear-Host
Get-Variable Input_* -ErrorAction SilentlyContinue | Remove-Variable

Write-Host "===== PART 1 - Manhatten Distance =====" -ForegroundColor Yellow
Write-Host 

# Get Wire Information
$Input_Wires = Get-Content .\input.txt

# Trace Wire Paths
Get-Date
Trace-WirePath -Wire $Input_Wires[0] -Name Wire_0
Trace-WirePath -Wire $Input_Wires[1] -Name Wire_1
Get-Date

# Retreive Traces for Experimentation.  Use ArrayList because I have a need for speed.
[System.Collections.ArrayList]$trace_wire_0 = Get-Content .\Wire_0.txt
[System.Collections.ArrayList]$trace_wire_1 = Get-Content .\Wire_1.txt

# Create an empty arraylist to hold matches
$trace_cross_locations = [System.Collections.ArrayList]@()

$index = 0
$total = $trace_wire_0.Count

Clear-Host

Get-Date
foreach ($location in $trace_wire_0)
    {
        Write-Progress -Id 1 -Activity "Finding Cross Points" -Status "$index of $total" -PercentComplete (($index / $total)*100)
        $index++

        if($trace_wire_1.Contains($location))
            {
                $trace_cross_locations.Add($location)
            }
    }
Get-Date

# Calculate possible Solutions

$Solutions = [System.Collections.ArrayList]@()

foreach ($Crossing in $trace_cross_locations)
    {

        # Discard the central plug
        if($Crossing -eq "0,0")
            {
                continue
            }

        # Get Components
        [int[]]$parts = $Crossing -split ","

        $Part_0 = $parts[0]
        $Part_1 = $parts[1]

        # Remove Negative Numbers
        if($parts[0] -lt 0)
            {
                $Part_0 = $Part_0 * -1
            }
        if($parts[1] -lt 0)
            {
                $Part_1 = $Part_1 * -1
            }

        # Calculate Distance and add to Solutions Array
        $Solutions.Add($Part_0+$Part_1)

    }

# Find the closest
$Solutions | Measure-Object -Minimum



# Functions
function Trace-WirePath {

    param(
        [string]$Wire,
        [string]$Name
    )

    # Define starting point and output.
    $Location_X = 0
    $Location_Y = 0

    "$Location_X,$Location_Y" | Out-File -FilePath ".\$Name.txt" -Force

    # Parse wire into steps
    $Steps = $wire.split(",")

    # Trace the path that the wire takes by processing each step and recording it's location increment by increment.
    Foreach ($Step in $Steps)
        {
            # Find the direction this step takes
            $Direction = $Step.Substring(0,1)

            # Find the distance this step goes
            [int]$Distance = $Step.Substring(1,$Step.Length-1)

            # Walk this distance step by step and output location as you go.
            Switch ($Direction)
                {
                    "R"
                        {
                            do {
                                # Move one step
                                $Location_X++
                                # Output Location
                                "$Location_X,$Location_Y" | Out-File -FilePath ".\$Name.txt" -Append
                                # Decrement Distance
                                $Distance--     
                            }
                            while($Distance -gt 0)
                        }
                    "L"
                        {
                            do {
                                # Move one step
                                $Location_X--
                                # Output Location
                                "$Location_X,$Location_Y" | Out-File -FilePath ".\$Name.txt" -Append
                                # Decrement Distance
                                $Distance--     
                            }
                            while($Distance -gt 0)
                        }
                    "U"
                        {
                            do {
                                # Move one step
                                $Location_Y++
                                # Output Location
                                "$Location_X,$Location_Y" | Out-File -FilePath ".\$Name.txt" -Append
                                # Decrement Distance
                                $Distance--     
                            }
                            while($Distance -gt 0)
                        }
                    "D"
                        {
                            do {
                                # Move one step
                                $Location_Y--
                                # Output Location
                                "$Location_X,$Location_Y" | Out-File -FilePath ".\$Name.txt" -Append
                                # Decrement Distance
                                $Distance--     
                            }
                            while($Distance -gt 0)
                        }
                }
        }
}