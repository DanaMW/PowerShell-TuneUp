#FileVerson 0.0.7
<#
.SYNOPSIS
        StartUpDelay
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 06, 2018
.DESCRIPTION
        This is just a way to delay the startup of programs in your startups.
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script in C:\Users\$UserName\Start Menu\Programs\Startup\
.EXAMPLE
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script in C:\Users\$UserName\Start Menu\Programs\Startup\
.NOTES
        Still under development.
#>
#Your Settings Here
$StartDelay = 30
$Delay = 10
#End
$C = 1
& Write-Output "Holding startup for $StartDelay seconds per your setting."
Start-Sleep -s $StartDelay
& Write-Output ""
& Write-Output "#==================================#"
& Write-Output "|-<Running Startup Delay Launcher>-|"
& Write-Output "#==================================#"

Start-Sleep -s $Delay
& Write-Output " [$C] Starting uGet Download Manage"
& Set-Location "C:\bin\uget\bin\"
& Start-Process -FilePath "C:\bin\uget\bin\uget.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
& Write-Output " [$C] Starting Redragon Gaming Mouse"
& Set-Location "C:\Program Files (x86)\REDRAGON\Gaming Mouse\"
& Start-Process -FilePath "C:\Program Files (x86)\REDRAGON\Gaming Mouse\hid.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
& Write-Output " [$C] Starting OneDrive"
& Set-Location "C:\Users\Dana\AppData\Local\Microsoft\OneDrive\"
& Start-Process -FilePath "C:\Users\Dana\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
& Write-Output " [$C]  Starting Console Emulater"
& Set-Location "C:\bin\ConEmu"
& Start-Process -FilePath "C:\bin\ConEmu\ConEmu64.exe"
& Set-Location "$Env:HOME"

$C++
Start-Sleep -s $Delay
& Write-Output " [$C] Starting Ditto"
& Set-Location "C:\bin\Ditto"
& Start-Process -FilePath "C:\bin\Ditto\Ditto.exe"
& Set-Location "$Env:HOME"

if ($env:Userdomain -eq "TINMAN") {
    $C++
    Start-Sleep -s $Delay
    & Write-Output " [$C] Starting Sound Blaster Control Panel"
    & Set-Location "c:\Program Files (x86)\Creative\Sound Blaster Audigy Fx\Sound Blaster Audigy Fx Control Panel\"
    & Start-Process -FilePath "c:\Program Files (x86)\Creative\Sound Blaster Audigy Fx\Sound Blaster Audigy Fx Control Panel\SBAdgyFx.exe"
    & Set-Location "$Env:HOME"
}

$C++
Start-Sleep -s $Delay
& Write-Output " [$C] Starting RainMeter"
& Set-Location "C:\Program Files\Rainmeter\"
& Start-Process -FilePath "C:\Program Files\Rainmeter\Rainmeter.exe"
& Set-Location "$Env:HOME"
exit
return

#[ FileVerson 0.0.7 ]
