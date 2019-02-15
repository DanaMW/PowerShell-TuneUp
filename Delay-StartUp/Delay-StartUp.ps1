<#
.SYNOPSIS
        Delay-StartUp
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: February 14, 2019
.DESCRIPTION
        This is just a way to delay the startup of programs in your startups.
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script c:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
        Command Line: pwsh.exe -File ($env:BASE + "\Delay-StartUp.ps1")
.EXAMPLE
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script in c:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
        Command Line: pwsh.exe -File ($env:BASE + "\Delay-StartUp.ps1")
.NOTES
        Still under development.
#>
$FileVersion = "Version: 1.2.7"
$host.ui.RawUI.WindowTitle = "Delay-StartUp $FileVersion on $env:USERDOMAIN"
Function MyConfig {
    $MyConfig = (Split-Path -parent $PSCommandPath) + "\" + (Split-Path -leaf $PSCommandPath)
    $MyConfig = ($MyConfig -replace ".ps1", ".json")
    $MyConfig
}
$ConfigFile = MyConfig
try { $Config = Get-Content "$ConfigFile" -Raw | ConvertFrom-Json }
catch { Write-Host -ForeGroundColor RED "The Base configuration file is missing!"; break }
if (!($Config)) {
    Write-Host -ForeGroundColor RED "The BinMenu.json configuration file is missing!"
    Write-Host -ForeGroundColor RED "You need to create or edit BinMenu.json in" $env:BASE
    break
}
if (!($env:Base)) { Set-Variable -Name Base -Value ($Config.basic.Base) -Scope Global }
if (!($env:Base)) { Write-Host -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $env:BASE.substring(0, 3)
Set-Location $env:BASE
[int]$StartDelay = ($Config.basic.StartDelay)
[int]$Delay = [int]($Config.basic.Delay)
[bool]$Prevent = [bool]($Config.basic.Prevent)
[bool]$TestRun = [bool]($Config.basic.TestRun)
[int]$WinWidth = [int]($Config.basic.WinWidth)
[int]$WinHeight = [int]($Config.basic.WinHeight)
[int]$BuffWidth = [int]($Config.basic.BuffWidth)
[int]$BuffHeight = [int]($Config.basic.BuffHeight)
Function FlexWindow {
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    #
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    #
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
}
FlexWindow
Function SpinItems {
    $si = 1
    $Sc = 20
    $Script:AddCount = 0
    While ($si -lt $sc) {
        $RunItem = "RunItem-$si"
        $Spin = ($Config.$RunItem.name)
        if ($null -ne $Spin) { $Script:AddCount++; $si++ }
        else { $si = 20 }
    }
}
FlexWindow
if ($Prevent -eq $True) {
    Clear-Host
    Write-Host ""
    Write-Host "The script setting PREVENT is set to $Prevent."
    Write-Host "This indicates we need to exit."
    Write-Host "Set PREVENT to 0 to allow this to run."
    Write-Host ""
    Write-Host "Would you like to set it to zero now?"
    Write-Host "If not Settings Manager will run."
    Write-Host "(1) Set PREVENT to ZERO (Allow D-S to run) Then exit."
    Write-Host "(2) Set PREVENT to ZERO then run Delay-StartUp now."
    Write-Host "(3) Exit this and run DelaySM Settings Manager."
    Write-Host "(4) or (ENTER) Just exit do nothing."
    $DSPrompt = "[(1), (2), (3), (4) or (ENTER) to EXIT]"
    $ans = Read-Host -Prompt $DSPrompt
    if ($ans -eq "1") {
        [bool]$Prevent = 0
        $Config.basic.Prevent = [bool]$Prevent
        $Config |ConvertTo-Json | Set-Content $ConfigFile
        Write-Host 'Ok all set to run next time.[Run ($env:BASE + "\Delay-StartUp.ps1") to run now.'
        return
    }
    if ($ans -eq "2") {
        [bool]$Prevent = 0
        $Config.basic.Prevent = [bool]$Prevent
        $Config |ConvertTo-Json | Set-Content $ConfigFile
        Write-Host "Ok all set, Running Delay-StartUp for you now"
        Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\Delay-StartUp.ps1") -WorkingDirectory $env:BASE
        return
    }
    if ($ans -eq "3") {
        Write-Host "Running DelaySM for you now"
        Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\DelaySM.ps1") -WorkingDirectory $env:BASE
        return
    }
    return
}
if ($StartDelay -ne "0" -and $TestRun -ne $True) {
    Clear-Host
    [Console]::SetCursorPosition(0, 1); & Write-OutPut "You have StartDelay Set."
    [Console]::SetCursorPosition(0, 2); & Write-Output "Holding startup for $StartDelay"
    [int]$c = $StartDelay
    while ($c -gt 0) {
        [Console]::SetCursorPosition(20, 2); & Write-Output "      "
        [Console]::SetCursorPosition(20, 2); & Write-Output $c
        Start-Sleep -s 1
        $c = ($c - 1)
        [Console]::SetCursorPosition(0, 5); & Write-Output "                                               "
    }
    [Console]::SetCursorPosition(20, 2); & Write-Output "      "
    [Console]::SetCursorPosition(20, 2); & Write-Output "Done!"
}
FlexWindow
if ($TestRun -eq $True -or $StartDelay -eq "0") { Clear-Host }
if ($StartDelay -eq "0") { [Console]::SetCursorPosition(0, 2); & Write-Output "Without delay, beginning StartUp-delay" }
[Console]::SetCursorPosition(0, 3); & Write-Output "#==================================#"
[Console]::SetCursorPosition(0, 4); & Write-Output "|-<Running Delay-Startup Launcher>-|"
[Console]::SetCursorPosition(0, 5); & Write-Output "#==================================#"
[Console]::SetCursorPosition(0, 6); & Write-Output "  Startup Delay: $StartDelay - Run Delay: $Delay"
[int]$c = 1
[int]$a = 1
SpinItems
[Console]::SetCursorPosition(0, 7)
while ($c -le $AddCount) {
    $RunItem = "RunItem-$c"
    $Runname = ($Config.$RunItem).name
    $RunHost = ($Config.$RunItem).hostonly
    $RunPath = ($Config.$RunItem).runpath
    $RunSplit = (Split-Path -parent $RunPath)
    $RunSplit = ($RunSplit + "\")
    $RunArg = ($Config.$RunItem).argument
    if ($RunHost -eq "ALL" -or $RunHost -eq $env:USERDOMAIN) {
        & Write-Output " [$a] Starting $RunName [Host: $RunHost]"
        if ($TestRun -eq $True) {
            $X = $host.ui.rawui.CursorPosition.X
            $Y = $host.ui.rawui.CursorPosition.Y
            if (($RunArg)) {
                [Console]::SetCursorPosition(0, 0); Write-Host "                                                                                                                                                                                                                                                    "
                [Console]::SetCursorPosition(0, 1); Write-Host "                                                                                                                                                                                                                                         "
                $Filetest = Test-Path -path $RunPath
                [Console]::SetCursorPosition(0, 0); Write-Host "Start-Process -FilePath $RunPath -ArgumentList $RunArg"
                if ($Filetest -ne $True) {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); Write-Host "#==================================# File Was NOT Found!"
                }
                else {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); & Write-Output "#==================================# File OK!"
                }
                [Console]::SetCursorPosition(0, 4); & Write-Output "|-<Running Delay-Startup Launcher>-|"
            }
            else {
                [Console]::SetCursorPosition(0, 0); Write-Host "                                                                                                                                                                                                                                                    "
                [Console]::SetCursorPosition(0, 1); Write-Host "                                                                                                                                                                                                                                          "
                $Filetest = Test-Path -path $RunPath
                [Console]::SetCursorPosition(0, 0); Write-Host -Message "Start-Process -FilePath $RunPath"
                if ($Filetest -ne $True) {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); Write-Host "#==================================# File Was NOT Found!"
                }
                Else {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); & Write-Output "#==================================# File OK!"
                }
                [Console]::SetCursorPosition(0, 4); & Write-Output "|-<Running Delay-Startup Launcher>-|"
            }
            [Console]::SetCursorPosition($X, $Y)
        }
        else {
            if (($RunArg)) {
                try { & Start-Process -FilePath $RunPath -ArgumentList $RunArg -WorkingDirectory $RunSplit -ErrorAction SilentlyContinue }
                catch { Write-Host -ForeGroundColor RED "Could not run" $RunPath }
            }
            else {
                try { & Start-Process -FilePath $RunPath -WorkingDirectory $RunSplit -ErrorAction SilentlyContinue }
                catch { Write-Host -ForeGroundColor RED "Could not run" $RunPath }
            }
        }
        & Set-Location $env:BASE.substring(0, 3)
        & Set-Location $env:BASE
        if ($c -ne 0) { Start-Sleep -s $Delay }
        $a++
    }
    $c++
}
if ($tt -ne "") { $tt = "" }
Write-Host "All Programs Loaded, Exiting."
Start-Sleep -s 3
Exit
