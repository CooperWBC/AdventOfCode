Clear-Host

#
# Puzzle 1
#

$BoardingPasses = Get-Content -Path .\2020\Day5\input.txt

$Seats = @()

$BoardingPasses | ForEach-Object {

    # Starting Point
    $POS_Seat = @{
        'Row_Lower'  = 0
        'Row_Upper'  = 127
        'Seat_Lower' = 0
        'Seat_Upper' = 7
        'Seat_ID' = ''
    }

    # Find Row
    [char[]]$_.Substring(0,7) | ForEach-Object {
        $Move = ($POS_Seat.Row_Upper - $POS_Seat.Row_Lower + 1) / 2
        if($_ -eq "B") {
            $POS_Seat.Row_Lower = $POS_Seat.Row_Lower + $Move
        }
        elseif ($_ -eq "F") {
            $POS_Seat.Row_Upper = $POS_Seat.Row_Upper - $Move
        }
    }

    # Find Seat
    [char[]]$_.Substring(7) | ForEach-Object {
        $Move = ($POS_Seat.Seat_Upper - $POS_Seat.Seat_Lower + 1) / 2
        if($_ -eq "R") {
            $POS_Seat.Seat_Lower = $POS_Seat.Seat_Lower + $Move
        }
        elseif ($_ -eq "L") {
            $POS_Seat.Seat_Upper = $POS_Seat.Seat_Upper - $Move
        }
    }
    
    # Find Seat ID
    $POS_Seat.Seat_ID = $POS_Seat.Row_Lower * 8 + $POS_Seat.Seat_Lower
    
    # Store Seat
    $Seats += $POS_Seat
}

Write-Host "Highest Seat ID : $( ($Seats.Seat_ID | Sort-Object -Descending)[0] )"

#
# Puzzle 2
#

$Index = $Seats.Seat_ID | Sort-Object | Select-Object -First 1
ForEach ($ID in ($Seats.Seat_ID | Sort-Object)) {
    if($ID -ne $Index) {
        $Seat_ID_Mine = $Index
        break
    }
    $Index++
}

Write-Host "My Seat ID : $Seat_ID_Mine"