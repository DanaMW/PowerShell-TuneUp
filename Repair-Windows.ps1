Param([string]$RunFix)
$FileVersion = "Version: 0.1.9"
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
$Scan = "SFC.EXE /SCANNOW"
$Check = "DISM.EXE /Online /Cleanup-Image /ScanHealth"
$Repair = "DISM.EXE /Online /Cleanup-Image /RestoreHealth /Source:WIM:E:\sources\install.wim:1"
$Reset = "DISM.EXE /Online /Cleanup-Image /StartComponentCleanup /Source:WIM:E:\sources\install.wim:1"
Set-Location "C:"; Set-Location "C:\Windows"
$nline = "~RED~+=====================================================================+~"
$dline = "~RED~| ~~WHITE~| ~~RED~+=============================================================+ ~~WHITE~| ~~RED~|~"
$fline = "~RED~| ~~WHITE~+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+ ~~RED~|~"
$tline = "~RED~| ~~WHITE~+=-=-=-=-=-=-=-=-=-=-=<~~CYAN~[ ~~YELLOW~Fix Windows Script ~~CYAN~]~~WHITE~>-=-=-=-=-=-=-=-=-=-=+ ~~RED~|~"
$sline = "~RED~| ~~WHITE~| ~~RED~|                                                             | ~~WHITE~| ~~RED~|~"
<# #[Set-ConWin]#[Window Resizer]# #>
$tmpHeight = 22
$tmpWidth = 72
if ($tmpWidth -eq "") { $tmpWidth = 107 }
if ($tmpHeight -eq "") { $tmpHeight = 45 }
$pshost = (get-host)
$pswindow = ($pshost.ui.rawui)
$newsize = ($pswindow.buffersize)
$newsize.height = "2000"
$tmp = ($tmpWidth * 2)
$newsize.width = "$tmp"
$pswindow.buffersize = ($newsize)
$newsize = ($pswindow.windowsize)
$newsize.height = ($tmpHeight)
$newsize.width = ($tmpWidth)
$pswindow.windowsize = ($newsize)
if ($RunFix -eq "SCAN") { $RunFix = "Scan" }
if ($RunFix -eq "CHECK") { $RunFix = "Check" }
if ($RunFix -eq "REPAIR") { $RunFix = "Repair" }
if ($RunFix -eq "RESET") { $RunFix = "Reset" }
if ($RunFix -eq "") { $RunFix = "HelpOnly" }
if ($RunFix -eq "HelpOnly") {
    Clear-Host
    [Console]::SetCursorPosition(0, 0)
    WC $nline
    WC $tline
    WC $dline
    $i = 1
    while ($i -lt "14") {
        WC $sline
        $i++
    }
    WC $dline
    WC $fline
    WC $nline
    [Console]::SetCursorPosition(7, 3); WC "~WHITE~OK, This Script is Designed to help you~"
    [Console]::SetCursorPosition(7, 4); WC "~WHITE~Scan, Check and/or Repair your Windows 10 PC.~"
    [Console]::SetCursorPosition(7, 5); WC "~WHITE~If this is your first time running it you~"
    [Console]::SetCursorPosition(7, 6); WC "~WHITE~need to run it in a certain order. The order is:~"
    [Console]::SetCursorPosition(7, 7); WC "~WHITE~(1)Scan, (2)Check, (3)Repair (4)Reset~"
    [Console]::SetCursorPosition(7, 8); WC "~WHITE~After each run you need to reboot. Normally you need~"
    [Console]::SetCursorPosition(7, 9); WC "~WHITE~only run ~~CYAN~[~~YELLOW~Repair-Windows SCAN~~CYAN~] ~~WHITE~to check it.~"
    [Console]::SetCursorPosition(7, 10); WC "~WHITE~For a good check run that, reboot, then run~"
    [Console]::SetCursorPosition(7, 11); WC "~CYAN~[~~YELLOW~Repair-Windows CHECK~~CYAN~]~~WHITE~. Then reboot again. After both your~"
    [Console]::SetCursorPosition(7, 12); WC "~WHITE~PC should be in good shape and your done even if it said~"
    [Console]::SetCursorPosition(7, 13); WC "~WHITE~it fixed or repaired errors, thats its job.~"
    [Console]::SetCursorPosition(7, 14); WC "~WHITE~Pick number 1 SCAN on the next menu then run~"
    [Console]::SetCursorPosition(7, 15); WC "~CYAN~[~~YELLOW~Repair-Windows CHECK~~CYAN~] ~~WHITE~next after rebooting~"
    [Console]::SetCursorPosition(0, 19)
    $RunFix = ""
    $menuPrompt = WCP "~CYAN~[~~darkyellow~Enter to Continue~~CYAN~]~~WHITE~:~ "
    Read-Host -Prompt $menuPrompt
}
If ($RunFix -eq "") {
    Clear-Host
    [Console]::SetCursorPosition(0, 0)
    WC $nline
    WC $tline
    WC $dline
    $i = 1
    while ($i -lt "7") {
        WC $sline
        $i++
    }
    WC $dline
    WC $fline
    WC $nline
    [Console]::SetCursorPosition(7, 3); WC "You Must Run this in a certain order:"
    [Console]::SetCursorPosition(7, 4); WC "(1) Repair-Windows SCAN   [OK to run anytime]"
    [Console]::SetCursorPosition(7, 5); WC "(2) Repair-Windows CHECK  [OK to run anytime]"
    [Console]::SetCursorPosition(7, 6); WC "(3) Repair-Windows REPAIR [Only if the last two don't do it]"
    [Console]::SetCursorPosition(7, 7); WC "(4) Repair-Windows RESET  [Redoes your machine, last resort]"
    [Console]::SetCursorPosition(7, 8); WC "(H)elp or (Q)uit"
    [Console]::SetCursorPosition(0, 12)
    $menuPrompt = WCP "~CYAN~[~~darkyellow~Select 1, 2, 3, 4, H or Q~~CYAN~]~~WHITE~:~ "
    $cmd = Read-Host -Prompt $menuPrompt
    if ($cmd -eq "1") { $RunFix = "SCAN" }
    if ($cmd -eq "2") { $RunFix = "CHECK" }
    if ($cmd -eq "3") { $RunFix = "REPAIR" }
    if ($cmd -eq "4") { $RunFix = "RESET" }
    if ($cmd -eq "H") { Start-Process "pwsh.exe" -ArgumentList "$PSScriptRoot\Repair-Windows.ps1" -Verb RunAs; break }
    if ($cmd -eq "Q") { Clear-Host; break }
}
Clear-Host
$pa = 0
[Console]::SetCursorPosition(0, $pa)
WC $nline
WC $tline
WC $dline
$i = 1
while ($i -lt "5") {
    WC $sline
    $i++
}
WC $dline
WC $fline
WC $nline
[Console]::SetCursorPosition(11, 3); WC "~cyan~[~~white~1~~cyan~] ~~green~Scan ~-- ~cyan~[~~white~2~~cyan~] ~~green~Check ~-- ~cyan~[~~white~3~~cyan~] ~~green~Repair ~-- ~cyan~[~~white~4~~cyan~] ~~green~Reset~"
[Console]::SetCursorPosition(16, 5); WC "   ~cyan~Currently Running the Process~~white~: ~~white~$RunFix~"
$pa = 10
[Console]::SetCursorPosition(0, $pa)
if ($RunFix -eq "Scan") { Invoke-Expression $Scan }
if ($RunFix -eq "Check") { Invoke-Expression $Check }
if ($RunFix -eq "Repair") { Invoke-Expression $Repair }
if ($RunFix -eq "Reset") { Invoke-Expression $Reset }
$menuPrompt = WCP "~CYAN~[~~darkyellow~Enter To Continue~~CYAN~]~~WHITE~:~ "
Read-Host -prompt $menuPrompt
