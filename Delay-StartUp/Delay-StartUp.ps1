<#
.SYNOPSIS
        Delay-StartUp
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: January 15, 2019
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
$FileVersion = "Version: 1.2.0"
$host.ui.RawUI.WindowTitle = "Delay-StartUp $FileVersion on $env:USERDOMAIN"
Function MyConfig {
    $MyConfig = (Split-Path -parent $PSCommandPath) + "\" + (Split-Path -leaf $PSCommandPath)
    $MyConfig = ($MyConfig -replace ".ps1", ".json")
    $MyConfig
}
$ConfigFile = MyConfig
try { $Config = Get-Content "$ConfigFile" -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "The Base configuration file is missing!"; break }
if (!($Config)) {
    Say -ForeGroundColor RED "The BinMenu.json configuration file is missing!"
    Say -ForeGroundColor RED "You need to create or edit BinMenu.json in" $env:BASE
    break
}
if (!($env:Base)) { Set-Variable -Name Base -Value ($Config.basic.Base) -Scope Global }
if (!($env:Base)) { Say -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $env:BASE.substring(0, 3)
Set-Location $env:BASE
[int]$StartDelay = ($Config.basic.StartDelay)
[int]$Delay = ($Config.basic.Delay)
[bool]$Prevent = ($Config.basic.Prevent)
[bool]$TestRun = ($Config.basic.TestRun)
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
if ($Prevent -eq "$True") {
    Clear-Host
    Write-Host ""
    Write-Host "The script setting PREVENT is set to $Prevent."
    Write-Host "This indicates we need to exit."
    Write-Host "Set PREVENT to 0 to allow this to run."
    Read-Host -Prompt "[Enter to Continue to exit]"
    Write-Host ""
    Read-Host -Prompt "[Enter to exit StartUp-Delay]"
}
if ($StartDelay -ne "0" -and $TestRun -ne "$True") {
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
if ($TestRun -eq "$True" -or $StartDelay -eq "0") { Clear-Host }
if ($StartDelay -eq "0") { [Console]::SetCursorPosition(0, 2); & Write-Output "No delay set, beginning StartUp-delay" }
[Console]::SetCursorPosition(0, 3); & Write-Output "#==================================#"
[Console]::SetCursorPosition(0, 4); & Write-Output "|- Running Delay-Startup Launcher -|"
[Console]::SetCursorPosition(0, 5); & Write-Output "#==================================#"
[int]$c = 1
[int]$a = 1
SpinItems
[Console]::SetCursorPosition(0, 6)
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
        if ($TestRun -eq "$True") {
            $X = $host.ui.rawui.CursorPosition.X
            $Y = $host.ui.rawui.CursorPosition.Y
            if (($RunArg)) {

                [Console]::SetCursorPosition(0, 0); Write-Host "                                                                                                                                                                                                                                                    "
                [Console]::SetCursorPosition(0, 0); Write-Host "Start-Process -FilePath $RunPath -ArgumentList $RunArg -WorkingDirectory $RunSplit"
            }
            else {
                [Console]::SetCursorPosition(0, 0); Write-Host "                                                                                                                                                                                                                                                    "
                [Console]::SetCursorPosition(0, 0); Write-Host -Message  "Start-Process -FilePath $RunPath -WorkingDirectory $RunSplit"
            }
            [Console]::SetCursorPosition($X, $Y)
        }
        else {
            if (($RunArg)) { & Start-Process -FilePath $RunPath -ArgumentList $RunArg -WorkingDirectory $RunSplit }
            else { & Start-Process -FilePath $RunPath -WorkingDirectory $RunSplit }
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
