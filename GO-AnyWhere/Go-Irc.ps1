$FileVersion = "Version: 0.1.0"
Say "Go $FileVersion Setting your location to Variable [IRC] $env:IRC"
$eh = $env:IRC[0] + $env:IRC[1] + $env:IRC[2]
Set-Location $eh
Set-Location $env:IRC
