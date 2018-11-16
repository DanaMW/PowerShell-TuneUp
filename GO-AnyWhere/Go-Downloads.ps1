$FileVersion = "Version: 0.0.6"
Write-Host "Go $FileVersion Setting your location to Variable [DOWNLOADS] $env:DOWNLOADS"
$eh = $env:DOWNLOADS[0] + $env:DOWNLOADS[1] + $env:DOWNLOADS[2]
Set-Location $eh
Set-Location $env:DOWNLOADS
