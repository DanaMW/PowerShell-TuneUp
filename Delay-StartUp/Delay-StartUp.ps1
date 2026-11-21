<#
.SYNOPSIS
        Delay-StartUp
        Created By: Dana Meli-Wischman
        Created Date: August, 2018
 .DESCRIPTION
        This is just a way to delay the startup of programs in your startups.
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script c:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
        Command Line: pwsh.exe -File ($env:Base + "\Delay-StartUp.ps1")
.EXAMPLE
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script in c:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
        Command Line: pwsh.exe -File ($env:Base + "\Delay-StartUp.ps1")
.NOTES
        Still under development.
#>
$FileVersion = "1.5.24"
$FileDate = "11-21-2026"
$host.ui.RawUI.WindowTitle = "Delay-StartUp $FileVersion on $env:USERDOMAIN"
if (!($ScriptBase)) { $ScriptBase = (Split-Path -Parent $PSCommandPath) }
function MyConfig {
    $MyConfig = (Split-Path -Parent $PSCommandPath) + "\" + (Split-Path -Leaf $PSCommandPath)
    $MyConfig = ($MyConfig -replace "\.ps1$", ".json")
    $MyConfig
}
$ConfigFile = MyConfig
try { $Config = Get-Content "$ConfigFile" -Raw -ErrorAction Stop | ConvertFrom-Json }
catch { Write-Host -ForegroundColor RED "The Base configuration file is missing!"; exit 1 }
if (!($Config)) {
    Write-Host -ForegroundColor RED "The Delay-StartUp.json configuration file is missing!"
    Write-Host -ForegroundColor RED "You need to create or edit Delay-StartUp.json in $BASE"
    exit 1
}
$BASE = $env:Base
if (!($BASE)) { $BASE = $Config.Setup.Base }
if (!($BASE)) { Write-Host -ForegroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; exit 1 }
Set-Location $BASE.substring(0, 3)
Set-Location $BASE
if (!($ScriptBase)) { $ScriptBase = (Split-Path -Parent $PSCommandPath) }
[int]$StartDelay = ($Config.Setup.StartDelay)
[int]$Delay = ($Config.Setup.Delay)
[bool]$Prevent = ($Config.Setup.Prevent)
[bool]$Notify = ($Config.Setup.Notify)
[bool]$TestRun = ($Config.Setup.TestRun)
[bool]$PreventPause = ($Config.Setup.Pause)
[int]$PauseSec = ($Config.Setup.PauseSec)
[string]$PauseOpt = ($Config.Setup.PauseOpt)
[int]$WinX = ($Config.Setup.WinX)
if (!($WinX)) { $WinX = 1 }
[int]$WinY = ($Config.Setup.WinY)
if (!($WinY)) { $WinY = 1 }
[bool]$WPosition = ($Config.Setup.WPosition)
[int]$WinWidth = ($Config.Setup.WinWidth)
[int]$WinHeight = ($Config.Setup.WinHeight)
[int]$BuffWidth = $WinWidth
[int]$BuffHeight = $WinHeight
$PosTest = Test-Path -Path ($Base + "\Put-WinPosition.ps1")
function FlexWindow {
    $SaveError = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"
    $pshost = Get-Host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
    $ErrorActionPreference = $SaveError
}

if (($WPosition)) {
    FlexWindow
    if (($PosTest)) { Put-WinPosition.ps1 -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY | Out-Null }
}
function SpinItems {
    $si = 1
    $Sc = 20
    $Script:AddCount = 0
    while ($si -lt $sc) {
        $RunItem = "RunItem-$si"
        $Spin = ($Config.$RunItem.name)
        if ($null -ne $Spin) { $Script:AddCount++; $si++ }
        else { $si = 20 }
    }
}
if (($WPosition)) {
    FlexWindow
    if (($PosTest)) { Put-WinPosition.ps1 -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY | Out-Null }
}
if (($Prevent)) {
    Clear-Host
    Write-Host " "
    Write-Host " Delay-StartUp Slow Down Program Launcher"
    Write-Host " Prevent is set to 1, true, thats why the slow down."
    Write-Host " Options:"
    Write-Host " [0] Set PREVENT to true then run Delay-StartUp. (Default)"
    Write-Host " [1] Set PREVENT to false then exit."
    Write-Host " [2] Set PREVENT to false then run Delay-StartUp."
    Write-Host " [3] Exit slow down then run Settings Manager."
    Write-Host " [4] or ENTER just exit or do nothing."
    if ([string]::IsNullOrWhiteSpace($PauseOpt)) { $PauseOpt = "0" }
    if ($PreventPause) {
        if ($PauseSec -le 0) { $PauseSec = 30 }
        Write-Host " Set to auto proceed in $PauseSec seconds with option $PauseOpt."
    }
    $DSPrompt = " [0, 1, 2, 3, 4 or ENTER to EXIT]: "
    if ($PreventPause) {
        $ans = Put-Pause -Prompt $DSPrompt -Max ($PauseSec * 1000) -Default "0" -Echo 1
    }
    else {
        $ans = Put-Pause -Prompt $DSPrompt -Max 0 -Default "0"
    }
    if ($ans -eq "0") { Write-Host "Running Delay-StartUp for you now" }
    if ($ans -eq "1") {
        [bool]$Prevent = 0
        $Config.Setup.Prevent = [bool]$Prevent
        $Config | ConvertTo-Json -Depth 5 | Set-Content $ConfigFile
        return
    }
    if ($ans -eq "2") {
        [bool]$Prevent = 0
        $Config.Setup.Prevent = [bool]$Prevent
        $Config | ConvertTo-Json -Depth 5 | Set-Content $ConfigFile
        Write-Host "Ok all set, Running Delay-StartUp for you now"
        $argList = @("-NoLogo", "-NoProfile", "-WorkingDirectory", "`"$ScriptBase`"", "-File", "`"$ScriptBase\Delay-StartUp.ps1`"")
        Start-Process "pwsh.exe" -ArgumentList $argList
        return
    }
    if ($ans -eq "3") {
        Write-Host "Running DelaySM for you now"
        $argList = @("-NoLogo", "-NoProfile", "-WorkingDirectory", "`"$ScriptBase`"", "-File", "`"$ScriptBase\DelaySM.ps1`"")
        Start-Process "pwsh.exe" -ArgumentList $argList
        return
    }
    if ($ans -eq "4") { return }
    if ($ans -ne "0") { return }

}
if ($StartDelay -ne "0") {
    Clear-Host
    [Console]::SetCursorPosition(0, 1); & Write-Output " You have StartDelay Set."
    [Console]::SetCursorPosition(0, 2); & Write-Output " Holding startup for $StartDelay"
    [int]$c = $StartDelay
    while ($c -gt 0) {
        [Console]::SetCursorPosition(20, 2); & Write-Output "      "
        [Console]::SetCursorPosition(20, 2); & Write-Output $c
        Start-Sleep -s 1
        $c = ($c - 1)
        [Console]::SetCursorPosition(0, 5); & Write-Output "                                               "
    }
    [Console]::SetCursorPosition(20, 2); & Write-Output "      "
    [Console]::SetCursorPosition(20, 2); & Write-Output " Done!"
}
if (($WPosition)) {
    FlexWindow
    if (($PosTest)) { Put-WinPosition.ps1 -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY | Out-Null }
}
if ($StartDelay -eq "0") {
    Clear-Host
    [Console]::SetCursorPosition(0, 3); & Write-Output " Without delay, beginning the end of the delays"
}
[Console]::SetCursorPosition(0, 4); & Write-Output " Running Slow Down Program Launcher."
[Console]::SetCursorPosition(0, 5); & Write-Output " Startup Delay: $StartDelay - Run Delay: $Delay"
[int]$c = 1
[int]$a = 1
SpinItems
[Console]::SetCursorPosition(0, 7)
while ($c -le $AddCount) {
    $RunItem = "RunItem-$c"
    $Runname = ($Config.$RunItem).Name
    $RunHost = ($Config.$RunItem).HostOnly
    $RunTime = ($Config.$RunItem).goTime
    $isAdmin = ($Config.$RunItem).Admin
    $RunPath = ($Config.$RunItem).RunPath
    # $RunSplit = (Split-Path -Parent $RunPath)
    $RunSplit = if ($RunPath) { (Split-Path -Parent $RunPath) + "\" } else { $BASE }
    # $RunSplit = ($RunSplit + "\")
    $RunArg = ($Config.$RunItem).Argument
    if ($RunHost -eq "ON" -or $RunHost -eq $env:USERDOMAIN) {
        & Write-Output " [$a] Starting $RunName [Run: $RunHost][Secs: $RunTime]"
        if ($TestRun -eq $True) {
            $X = $host.ui.rawui.CursorPosition.X
            $Y = $host.ui.rawui.CursorPosition.Y
            if (($RunArg)) {
                [Console]::SetCursorPosition(0, 0); Write-Host "                                                                                                                                                                                                                                                    "
                [Console]::SetCursorPosition(0, 1); Write-Host "                                                                                                                                                                                                                                         "
                $Filetest = Test-Path -Path $RunPath
                [Console]::SetCursorPosition(0, 0); Write-Host " Start-Process -FilePath $RunPath -ArgumentList $RunArg"
                if ($Filetest -ne $True) {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); Write-Host " File Was NOT Found!"
                }
                else {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); & Write-Output " File Setup OK."
                }
                [Console]::SetCursorPosition(0, 4); & Write-Output " Running Delay-Startup Launcher"
            }
            else {
                [Console]::SetCursorPosition(0, 0); Write-Host "                                                                                                                                                                                                                                                    "
                [Console]::SetCursorPosition(0, 1); Write-Host "                                                                                                                                                                                                                                          "
                $Filetest = Test-Path -Path $RunPath
                [Console]::SetCursorPosition(0, 0); Write-Host " Start-Process -FilePath $RunPath"
                if ($Filetest -ne $True) {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); Write-Host " File Was NOT Found!"
                }
                else {
                    [Console]::SetCursorPosition(0, 3); Write-Host "                                                                     "
                    [Console]::SetCursorPosition(0, 3); & Write-Output " File Setup OK."
                }
                [Console]::SetCursorPosition(0, 4); & Write-Output " Running Delay-Startup Launcher"
            }
            [Console]::SetCursorPosition($X, $Y)
        }
        else {
            if ([int]$RunTime -gt 0) {
                Start-Sleep -Seconds $RunTime
            }
            $procParams = @{
                FilePath         = $RunPath
                WorkingDirectory = $RunSplit
                ErrorAction      = 'Stop'
            }
            if ($RunArg) { $procParams.ArgumentList = $RunArg }
            if ($isAdmin -eq "ON") { $procParams.Verb = 'RunAs' }
            try {
                Start-Process @procParams
            }
            catch {
                Write-Host -ForegroundColor RED "Could not run $RunPath"
                Write-Host -ForegroundColor YELLOW "$($procParams.Verb)"
                Write-Host -ForegroundColor GRAY "Args: [$RunArg] | Admin: [$isAdmin] | Dir: [$RunSplit]"
            }
        }
        & Set-Location $BASE.substring(0, 3)
        & Set-Location $BASE
        if ($c -lt $AddCount) { Start-Sleep -s $Delay }
        $a++
    }
    $c++
}
Write-Host "All Programs Loaded, Exiting."
Start-Sleep -s 1
if (($Notify)) { Notify "Delay-StartUp All Programs Loaded, Exiting." }
exit
