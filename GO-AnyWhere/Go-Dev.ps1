$FileVersion = "Version: 0.0.7"
Write-Host "Go $FileVersion Setting your location to Variable [DEV] $env:DEV"
$eh = $env:DEV[0] + $env:DEV[1] + $env:DEV[2]
Set-Location $eh
Set-Location $env:DEV
