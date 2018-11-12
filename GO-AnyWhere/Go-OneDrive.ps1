$FileVersion = "Version: 0.0.6"
Write-Host "Go $FileVersion Setting your location to Variable [ONEDRIVE] $env:ONEDRIVE"
Set-Location $env:ONEDRIVE[0] + $env:ONEDRIVE[1] + $env:ONEDRIVE[2]
Set-Location $env:ONEDRIVE
