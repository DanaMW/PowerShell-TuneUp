$StartDelay = 30
$Delay = 10
$C = 1
& Write-Output "Holding startup for $StartDelay seconds per your setting."
Start-Sleep -s $StartDelay
& Write-Output ""
& Write-Output "#==================================#"
& Write-Output "|-<Running Startup Delay Launcher>-|"
& Write-Output "#==================================#"

Start-Sleep -s $Delay
$info = "Starting uGet Download Manage"
& Write-Output " [$C]" $info
& Set-Location "C:\bin\uget\bin\"
& Start-Process -FilePath "C:\bin\uget\bin\uget.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
$info = "Starting Redragon Gaming Mouse"
& Write-Output " [$C]" $info
& Set-Location "C:\Program Files (x86)\REDRAGON\Gaming Mouse\"
& Start-Process -FilePath "C:\Program Files (x86)\REDRAGON\Gaming Mouse\hid.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
$info = "Starting OneDrive"
& Write-Output " [$C]" $info
& Set-Location "C:\Users\Dana\AppData\Local\Microsoft\OneDrive\"
& Start-Process -FilePath "C:\Users\Dana\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
$info = "Starting Console Emulater"
& Write-Output " [$C]" $info
& Set-Location "C:\bin\ConEmu"
& Start-Process -FilePath "C:\bin\ConEmu\ConEmu64.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
$info = "Starting Ditto"
& Write-Output " [$C]" $info
& Set-Location "C:\bin\Ditto"
& Start-Process -FilePath "C:\bin\Ditto\Ditto.exe"
& Set-Location "$Env:HOME"

if ($env:Userdomain -eq "TINMAN") {
    $C++
    $info = "Starting Sound Blaster Control Panel"
    Start-Sleep -s $Delay
    & Write-Output " [$C]" $info
    & Set-Location "c:\Program Files (x86)\Creative\Sound Blaster Audigy Fx\Sound Blaster Audigy Fx Control Panel\"
    & Start-Process -FilePath "c:\Program Files (x86)\Creative\Sound Blaster Audigy Fx\Sound Blaster Audigy Fx Control Panel\SBAdgyFx.exe"
    & Set-Location "$Env:HOME"
}

$C++
Start-Sleep -s $Delay
$info = "Starting RainMeter"
& Write-Output " [$C]" $info
& Set-Location "C:\Program Files\Rainmeter\"
& Start-Process -FilePath "C:\Program Files\Rainmeter\Rainmeter.exe"
& Set-Location "$Env:HOME"
exit
return

#[ FileVerson 0.0.6 ]
