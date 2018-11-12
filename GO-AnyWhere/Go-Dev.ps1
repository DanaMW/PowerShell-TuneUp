$FileVersion = "Version: 0.0.6"
Write-Host "Go $FileVersion Setting your location to Variable [DEV] $env:DEV"
Set-Location Set-Location $env:DEV[0] + $env:DEV[1] + $env:DEV[2]
Set-Location $env:DEV
