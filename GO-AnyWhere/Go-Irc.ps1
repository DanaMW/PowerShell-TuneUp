$FileVersion = "Version: 0.0.6"
Write-Host "Go $FileVersion Setting your location to Variable [IRC] $env:IRC"
Set-Location Set-Location $env:IRC[0] + $env:IRC[1] + $env:IRC[2]
Set-Location $env:IRC
