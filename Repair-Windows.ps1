Param([string]$RunFix)
$FileVersion = "Version: 0.1.5"
$host.ui.RawUI.WindowTitle = "Fix Windows Version " + $FileVersion
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if (!($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))) {
    Start-Process "pwsh.exe" -ArgumentList "$PSScriptRoot\Repair-Windows.ps1" -Verb RunAs
    exit
    break
}
$ESC = [char]27
$Scan = "SFC.EXE /SCANNOW"
$Check = "DISM.EXE /Online /Cleanup-Image /ScanHealth"
#sources\install.wim:1
$Repair = "DISM.EXE /Online /Cleanup-Image /RestoreHealth /Source:WIM:E:\sources\install.wim:1"
$Reset = "DISM.EXE /Online /Cleanup-Image /StartComponentCleanup /Source:WIM:E:\sources\install.wim:1"
Set-Location "C:"; Set-Location "C:\Windows"
$nline = "$ESC[31m#=====================================================================#$ESC[37m"
$dline = "$ESC[31m| $ESC[37m| $ESC[31m#=============================================================$ESC[31m# $ESC[37m| $ESC[31m|"
$fline = "$ESC[31m| $ESC[37m#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-# $ESC[31m| $ESC[37m"
$tline = "$ESC[31m| $ESC[37m#=-=-=-=-=-=-=-=-=-=-=<$ESC[36m[$ESC[37m Fix Windows Script $ESC[36m]$ESC[31m$ESC[37m>-=-=-=-=-=-=-=-=-=-=#$ESC[31m |$ESC[37m"
$sline = "$ESC[31m| $ESC[37m| $ESC[31m|                                                             $ESC[31m| $ESC[37m|$ESC[31m |$ESC[37m"
<# #[Set-ConWin]#[Window Resizer]# #>
$tmpHeight = 22
$tmpWidth = 72
if ($tmpWidth -eq "") { $tmpWidth = 107 }
if ($tmpHeight -eq "") { $tmpHeight = 45 }
$pshost = (get-host); $pswindow = ($pshost.ui.rawui); $newsize = ($pswindow.buffersize);
$newsize.height = "2000"
$tmp = ($tmpWidth * 2)
$newsize.width = "$tmp"
$pswindow.buffersize = ($newsize); $newsize = ($pswindow.windowsize); $newsize.height = ($tmpHeight); $newsize.width = ($tmpWidth); $pswindow.windowsize = ($newsize)
if ($RunFix -eq "SCAN") { $RunFix = "Scan" }
if ($RunFix -eq "CHECK") { $RunFix = "Check" }
if ($RunFix -eq "REPAIR") { $RunFix = "Repair" }
if ($RunFix -eq "RESET") { $RunFix = "Reset" }
if ($RunFix -eq "") { $RunFix = "HelpOnly" }
if ($RunFix -eq "HelpOnly") {
    Clear-Host
    [Console]::SetCursorPosition(0, 0)
    Say $nline; $tline; $dline
    $i = 1
    while ($i -lt "14") { Say $sline; $i++ }
    Say $dline; $fline; $nline
    [Console]::SetCursorPosition(7, 3); Say -NoNewLine "OK, This Script is Designed to help you"
    [Console]::SetCursorPosition(7, 4); Say -NoNewLine "Scan, Check and/or Repair your Windows 10 PC."
    [Console]::SetCursorPosition(7, 5); Say -NoNewLine "If this is your first time running it you"
    [Console]::SetCursorPosition(7, 6); Say -NoNewLine "need to run it in a certain order. The order is:"
    [Console]::SetCursorPosition(7, 7); Say -NoNewLine "1 Scan, 2 Check, 3 Repair 4 Reset"
    [Console]::SetCursorPosition(7, 8); Say -NoNewLine "After each run you need to reboot. Normally you need"
    [Console]::SetCursorPosition(7, 9); Say -NoNewLine "only run $ESC[31m[$ESC[36m Do-Repair SCAN $ESC[31m]$ESC[37m to check it"
    [Console]::SetCursorPosition(7, 10); Say -NoNewLine "For a good check run that, reboot, then run"
    [Console]::SetCursorPosition(7, 11); Say -NoNewLine "$ESC[31m[$ESC[36m Do-Repair CHECK $ESC[31m]$ESC[37m. Then reboot again. After both your"
    [Console]::SetCursorPosition(7, 12); Say -NoNewLine "PC should be in good shape and your done even if it said"
    [Console]::SetCursorPosition(7, 13); Say -NoNewLine "it fixed or repaired errors, thats its job."
    [Console]::SetCursorPosition(7, 14); Say -NoNewLine "Pick number 1 SCAN on the next menu then run"
    [Console]::SetCursorPosition(7, 15); Say -NoNewLine "$ESC[31m[$ESC[36m Do-Repair CHECK $ESC[31m]$ESC[37m next after rebooting"
    [Console]::SetCursorPosition(0, 19)
    $RunFix = ""
    Read-Host -Prompt "$ESC[31m[$ESC[37mEnter to Continue$ESC[31m]"
}
If ($RunFix -eq "") {
    Clear-Host
    [Console]::SetCursorPosition(0, 0)
    Say $nline; $tline; $dline
    $i = 1
    while ($i -lt "7") { Say $sline; $i++ }
    Say $dline; $fline; $nline
    [Console]::SetCursorPosition(7, 3); Say -NoNewLine "You Must Run this in a certain order:"
    [Console]::SetCursorPosition(7, 4); Say -NoNewLine "$ESC[31m[$ESC[37m1$ESC[31m] [$ESC[37m Do-Repair SCAN  $ESC[31m][$ESC[37mOK to run anytime$ESC[31m]"
    [Console]::SetCursorPosition(7, 5); Say -NoNewLine "$ESC[31m[$ESC[37m2$ESC[31m] [$ESC[37m Do-Repair CHECK $ESC[31m][$ESC[37mOK to run anytime$ESC[31m]"
    [Console]::SetCursorPosition(7, 6); Say -NoNewLine "$ESC[31m[$ESC[37m3$ESC[31m] [$ESC[37m Do-Repair REPAIR$ESC[31m][$ESC[37mOnly if the last two dont do it$ESC[31m]"
    [Console]::SetCursorPosition(7, 7); Say -NoNewLine "$ESC[31m[$ESC[37m4$ESC[31m] [$ESC[37m Do-Repair RESET $ESC[31m][$ESC[37mRedoes your machine, last resort$ESC[31m]"
    [Console]::SetCursorPosition(7, 8); Say -NoNewLine "$ESC[31m[$ESC[37mH$ESC[31m] $ESC[37mHelp or $ESC[31m[$ESC[37mQ$ESC[31m] $ESC[37mQuit"
    [Console]::SetCursorPosition(0, 12)
    $cmd = Read-Host -Prompt "$ESC[31m[$ESC[37mSelect 1, 2, 3, 4, H or Q$ESC[31m]$ESC[37m"
    if ($cmd -eq "1") { $RunFix = "SCAN" }
    if ($cmd -eq "2") { $RunFix = "CHECK" }
    if ($cmd -eq "3") { $RunFix = "REPAIR" }
    if ($cmd -eq "4") { $RunFix = "RESET" }
    if ($cmd -eq "H") {
        Start-Process "pwsh.exe" -ArgumentList "./Repair-Windows.ps1" -Verb RunAs
        Exit
        break
    }
    if ($cmd -eq "Q") {
        Clear-Host
        exit
        break
    }
    #if ($cmd -eq "") { return }
    #else {
    #    Start-Process "pwsh.exe" ($env:BASE + "\Repair-Windows.ps1") -Verb RunAs
    #    try { $command = "stop-process -Id $PID" }
    #    Catch { [System.Windows.Forms.MessageBox]::Show($_ , 'Status') }
    #    Invoke-Expression $command
    #}
}
Clear-Host
$pa = 0
[Console]::SetCursorPosition(0, $pa)
Say $nline; $tline; $dline
$i = 1
while ($i -lt "5") { Say $sline; $i++ }
Say $dline; $fline; $nline
[Console]::SetCursorPosition(11, 3); "[1] Scan -- [2] Check -- [3] Repair -- [4] Reset"
[Console]::SetCursorPosition(16, 5); "   Currently Running the Process: $RunFix"
$pa = 10
[Console]::SetCursorPosition(0, $pa)
if ($RunFix -eq "Scan") { Invoke-Expression $Scan }
if ($RunFix -eq "Check") { Invoke-Expression $Check }
if ($RunFix -eq "Repair") { Invoke-Expression $Repair }
if ($RunFix -eq "Reset") { Invoke-Expression $Reset }
Read-Host -prompt "[Enter To Continue]"
