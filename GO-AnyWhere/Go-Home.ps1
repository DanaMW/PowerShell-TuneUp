$FileVersion = "Version 0.0.6"
Write-Host "Go $FileVersion Setting your location to Your Home $env:HOME"
Write-Host "#====================#"
Write-Host "|---<Welcome Home>---|"
Write-Host "#====================#"
$eh = $env:HOME[0] + $env:HOME[1] + $env:HOME[2]
Set-Location $eh
Set-Location $env:HOME
