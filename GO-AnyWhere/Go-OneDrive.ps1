$FileVersion = "Version: 0.0.7"
Write-Host "Go $FileVersion Setting your location to Variable [ONEDRIVE] $env:ONEDRIVE"
$eh = $env:ONEDRIVE[0] + $env:ONEDRIVE[1] + $env:ONEDRIVE[2]
Set-Location $eh
Set-Location $env:ONEDRIVE
