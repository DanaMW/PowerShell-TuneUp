$DELY = "5"
$C = 1
$ESC = [char]27
& Write-Output ""
& Write-Output "$ESC[31m#==================================#"
& Write-Output "$ESC[31m|$ESC[36m-<$ESC[37mRunning Startup Delay Launcher$ESC[36m>-$ESC[31m|"
& Write-Output "$ESC[31m#==================================#"

Start-Sleep -s $DELY
& Write-Output " $ESC[31m[$ESC[37m$C$ESC[31m] $ESC[36mStarting uGet Download Manager"
& Set-Location "C:\bin\uget\bin\"
& Start-Process -FilePath "C:\bin\uget\bin\uget.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $DELY
& Write-Output " $ESC[31m[$ESC[37m$C$ESC[31m] $ESC[36mStarting Redragon Gaming Mouse"
& Set-Location "C:\Program Files (x86)\REDRAGON\Gaming Mouse\"
& Start-Process -FilePath "C:\Program Files (x86)\REDRAGON\Gaming Mouse\hid.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $DELY
& Write-Output " $ESC[31m[$ESC[37m$C$ESC[31m] $ESC[36mStarting OneDrive"
& Set-Location "C:\Users\Dana\AppData\Local\Microsoft\OneDrive\"
& Start-Process -FilePath "C:\Users\Dana\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $DELY
& Write-Output " $ESC[31m[$ESC[37m$C$ESC[31m] $ESC[36mStarting Console Emulater"
& Set-Location "C:\bin\ConEmu"
& Start-Process -FilePath "C:\bin\ConEmu\ConEmu64.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $DELY
& Write-Output " $ESC[31m[$ESC[37m$C$ESC[31m] $ESC[36mStarting Ditto"
& Set-Location "C:\bin\Ditto"
& Start-Process -FilePath "C:\bin\Ditto\Ditto.exe"
& Set-Location "$Env:HOME"

if ($env:Userdomain -eq "TINMAN") {
    $C++
    Start-Sleep -s $DELY
    & Write-Output " $ESC[31m[$ESC[37m$C$ESC[31m] $ESC[36mStarting Sound Blaster Control Panel"
    & Set-Location "c:\Program Files (x86)\Creative\Sound Blaster Audigy Fx\Sound Blaster Audigy Fx Control Panel\"
    & Start-Process -FilePath "c:\Program Files (x86)\Creative\Sound Blaster Audigy Fx\Sound Blaster Audigy Fx Control Panel\SBAdgyFx.exe"
    & Set-Location "$Env:HOME"
}

$C++
Start-Sleep -s $DELY
& Write-Output " $ESC[31m[$ESC[37m$C$ESC[31m] $ESC[36mStarting RainMeter"
& Set-Location "C:\Program Files\Rainmeter\"
& Start-Process -FilePath "C:\Program Files\Rainmeter\Rainmeter.exe"
& Set-Location "$Env:HOME"
exit
return

#[ FileVerson 0.0.4 ]
