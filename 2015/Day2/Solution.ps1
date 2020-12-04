Clear-Host

#
# Puzzle 1
#

$Dimensions = Get-Content -Path .\2015\Day2\input.txt

$Total_Paper = 0

$Dimensions | ForEach-Object {

    $Measurement_L = [int]$_.Split("x")[0]
    $Measurement_W = [int]$_.Split("x")[1]
    $Measurement_H = [int]$_.Split("x")[2]
    
    $area_1 = 2 * ($Measurement_L * $Measurement_W)
    $area_2 = 2 * ($Measurement_W * $Measurement_H)
    $area_3 = 2 * ($Measurement_L * $Measurement_H)

    $Total_Paper = $Total_Paper + $area_1 + $area_2 + $area_3 + (($area_1,$area_2,$area_3 | Sort-Object)[0]/2)

}

Write-Host "Total Paper : $Total_Paper"

#
# Puzzle 2
#

$Total_Ribbon = 0

$Dimensions | ForEach-Object {

    $Measurement_L = [int]$_.Split("x")[0]
    $Measurement_W = [int]$_.Split("x")[1]
    $Measurement_H = [int]$_.Split("x")[2]

    (Get-Variable -Name Mea*).value | Sort-Object | Select-Object -First 2 | ForEach-Object {
        $Total_Ribbon = $Total_Ribbon + (2 * $_)
    }

    $Total_Ribbon = $Total_Ribbon + ($Measurement_L * $Measurement_W * $Measurement_H)
}
 
Write-Host "Total Ribbon : $Total_Ribbon"