<#
.SYNOPSIS
        Clearlogs (Clear Windows Logs)
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: March 21, 2021

.DESCRIPTION
        This is a simple script to clear all your windows logs. (That are not in use.)
        You Can run it in three ways. No Parameter, -Loud and -Silent
        Normal has a progress bar. Loud shows each log processed and silent just shows results.
        Command Line: ClearLogs.ps1 [[-loud] <bool>] [[-Silent] <bool>]

.EXAMPLE
        ClearLogs.ps1 (Normal operation)
        ClearLogs.ps1 -loud 1
        ClearLogs.ps1 -Silent 1

.NOTES
        Still under development.

#>
Param([bool]$loud, [bool]$Silent)
$HoldError = "$ErrorActionPreference"
$ErrorActionPreference = "SilentlyContinue"
$FileVersion = "0.2.21"
$host.ui.RawUI.WindowTitle = "Clear Windows Logs $FileVersion"
<# Test and if needed run as admin #>
Function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if (!($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))) {
    Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\ClearLogs.ps1") -Verb RunAs
    return
}
if (!($WinWidth)) {
    [int]$WinWidth = 70
    [int]$BuffWidth = $WinWidth
}
if (!($WinHeight)) {
    [int]$WinHeight = 25
    [int]$BuffHeight = $WinHeight
}
Function FlexWindow {
    $pshost = Get-Host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = $BuffHeight
    $newsize.width = $BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = $WinHeight
    $newsize.width = $WinWidth
    $pswindow.windowsize = $newsize
}
FlexWindow
Clear-Host
$PShost = Get-Host
$PSWin = $PShost.ui.rawui
$PSWin.CursorSize = 0
FlexWindow
[Console]::SetCursorPosition(0, 3); Say "Running ClearLogs $FileVersion"
$ClearSet = 0
FlexWindow
& wevtutil.exe el | ForEach-Object { $ClearSet++ }
[Console]::SetCursorPosition(0, 4); Say "Located $ClearSet logs. Setting Up the math."
$ClearSet = ($ClearSet / 100)
$i = 0
if (($loud)) {
    [Console]::SetCursorPosition(0, 5)
    wevtutil.exe el | ForEach-Object {
        Say "Deleting: " $_
        wevtutil.exe cl $_
        $i++
    }
    Say -NoNewline "ClearLogs Processed $i log files."
    Read-Host -Prompt "[Slap Enter To Exit]"
    return
}
elseif (($Silent)) {
    [Console]::SetCursorPosition(0, 5)
    wevtutil.exe el | ForEach-Object {
        wevtutil.exe cl $_
        $i++
    }
    Say -NoNewline "ClearLogs Processed $i log files."
    Read-Host -Prompt "[Slap Enter To Exit]"
    return
}
else {
    FlexWindow
    $ec = 0
    $OrgError = $ErrorActionPreference
    $ErrorActionPreference = "Ignore"
    Try {
        & wevtutil.exe el | ForEach-Object {
            Try { & wevtutil.exe cl "$_" }
            catch { Continue }
            if ($LastExitCode -ne 0) { $ec++ }
            $i++
            $p = ($i / $ClearSet); $p = [int][Math]::Ceiling($p)
            $j = ($p / 2); $j = [int][Math]::Floor($j)
            [Console]::SetCursorPosition(16, 6); Say -NoNewline "    "
            [Console]::SetCursorPosition(0, 6); Say -NoNewline "Delete count is: $i"
            [Console]::SetCursorPosition(16, 7); Say -NoNewline "    "
            [Console]::SetCursorPosition(0, 7); Say -NoNewline "PercentComplete: $p%"
            if ($p -eq ($h + 2)) { $h = $p }; $it = "#" * $j
            if (($p % 2) -eq 1 -and $h -le $p) { $tip = "="; $it = ($it + $tip) }
            if (($p % 2) -eq 0 -and $h -gt $p) { $tip = "#"; $it = ($it + $tip) }
            [Console]::SetCursorPosition(0, 9); Say -NoNewline "[$it"
            [Console]::SetCursorPosition(51, 9); Say -NoNewline "]"
            [Console]::SetCursorPosition(0, 8); Say -NoNewline "                                                             "
            [Console]::SetCursorPosition(0, 8); Say -NoNewLine ""
        }
    }
    Catch { Continue }
    if ($LastExitCode -ne 0) { $ec++ }
    $ErrorActionPreference = $OrgError
    $ans = ($i - $ec)
    Asay.ps1 ClearLogs Cleared $ans Log Files.
    $PShost = Get-Host
    $PSWin = $PShost.ui.rawui
    $PSWin.CursorSize = 25
    $ErrorActionPreference = "$HoldError"
    [Console]::SetCursorPosition(0, 11); Say -NoNewLine "Logs Located:" $i
    [Console]::SetCursorPosition(0, 12); Say -NoNewLine "Logs In Use :" $ec
    [Console]::SetCursorPosition(0, 14); Say -NoNewLine "ClearLogs Cleared $ans logs."
    [Console]::SetCursorPosition(0, 15); Read-Host -Prompt "[Slap Enter To Exit]"
    return
}
