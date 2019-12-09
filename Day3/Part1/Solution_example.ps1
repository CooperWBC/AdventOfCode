#
#  Advent of Code - Day 3 - Solutions
#
#  Link   : https://adventofcode.com/2019/day/3
#
#  Repo   : https://github.com/CooperWBC/2019-AdventOfCode
#

# Enviroment Prep / Maintenance
Clear-Host
Get-Variable Input_*,Example* -ErrorAction SilentlyContinue | Remove-Variable

Write-Host "===== PART 1 - Manhatten Distance =====" -ForegroundColor Yellow
Write-Host 

#
# EXAMPLE 1
#

# Get Wire Information
$Example1_Input_Wires = Get-Content .\Example1.txt

# Trace Wire Paths
Get-Date
Trace-WirePath -Wire $Example1_Input_Wires[0] -Name Example1_Wire_0
Trace-WirePath -Wire $Example1_Input_Wires[1] -Name Example1_Wire_1
Get-Date
#>

# Retreive Traces for Experimentation.  Use ArrayList because I have a need for speed.
[System.Collections.ArrayList]$example1_trace_wire_0 = Get-Content .\Example1_Wire_0.txt
[System.Collections.ArrayList]$example1_trace_wire_1 = Get-Content .\Example1_Wire_1.txt

# Create an empty arraylist to hold matches
$example1_trace_cross_locations = [System.Collections.ArrayList]@()

$example1_index = 0
$example1_total = $example1_trace_wire_0.Count

# Example 1
Get-Date
foreach ($location in $example1_trace_wire_0)
    {
        Write-Progress -Id 1 -Activity "Finding Cross Points" -Status "$index of $total" -PercentComplete (($index / $total)*100)
        $index++

        if($example1_trace_wire_1.Contains($location))
            {
                $example1_trace_cross_locations.Add($location)
            }
    }
Get-Date

# Calculate possible Solutions

$Example1_Solutions = [System.Collections.ArrayList]@()

foreach ($Crossing in $example1_trace_cross_locations)
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
        $Example1_Solutions.Add($Part_0+$Part_1)

    }

# Find the closest
$Example1_Solutions | Measure-Object -Minimum


#############################################################################################################################################

#
# EXAMPLE 2
#

# Get Wire Information
$Example2_Input_Wires = Get-Content .\Example2.txt

# Trace Wire Paths
Get-Date
Trace-WirePath -Wire $Example2_Input_Wires[0] -Name Example2_Wire_0
Trace-WirePath -Wire $Example2_Input_Wires[1] -Name Example2_Wire_1
Get-Date
#>

# Retreive Traces for Experimentation.  Use ArrayList because I have a need for speed.
[System.Collections.ArrayList]$Example2_trace_wire_0 = Get-Content .\Example2_Wire_0.txt
[System.Collections.ArrayList]$Example2_trace_wire_1 = Get-Content .\Example2_Wire_1.txt

# Create an empty arraylist to hold matches
$Example2_trace_cross_locations = [System.Collections.ArrayList]@()

$Example2_index = 0
$Example2_total = $Example2_trace_wire_0.Count

# Example 1
Get-Date
foreach ($location in $Example2_trace_wire_0)
    {
        Write-Progress -Id 1 -Activity "Finding Cross Points" -Status "$index of $total" -PercentComplete (($index / $total)*100)
        $index++

        if($Example2_trace_wire_1.Contains($location))
            {
                $Example2_trace_cross_locations.Add($location)
            }
    }
Get-Date

# Calculate possible Solutions

$Example2_Solutions = [System.Collections.ArrayList]@()

foreach ($Crossing in $Example2_trace_cross_locations)
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
        $Example2_Solutions.Add($Part_0+$Part_1)

    }

# Find the closest
$Example2_Solutions | Measure-Object -Minimum



##############################################################################################################################################

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