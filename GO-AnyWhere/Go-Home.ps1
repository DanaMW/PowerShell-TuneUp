$FileVersion = "Version 0.1.0"
Say "Go $FileVersion Setting your location to Your Home $env:HOME"
Say "#====================#"
Say "|---<Welcome Home>---|"
Say "#====================#"
$eh = $env:HOME[0] + $env:HOME[1] + $env:HOME[2]
Set-Location $eh
Set-Location $env:HOME
