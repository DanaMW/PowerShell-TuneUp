<#
.SYNOPSIS
        Reboot
        Created By: Dana Meli-Wischman
        Created Date: May, 2019
        Last Modified Date: Sep 09, 2024

.DESCRIPTION
        This script is designed to be sort of like linux reboot.
        There are restart and logoff and shutdown options included.

.EXAMPLE
        Reboot.ps1 HELP

.EXAMPLE
        Reboot.ps1 (Reboot alone times out to no reboot but you can trigger one.)

.EXAMPLE
        Reboot.ps1 ? (new) (Is a reboot required.)

.EXAMPLE
        Reboot.ps1 S

.EXAMPLE
        Reboot.ps1 STOP

.EXAMPLE
        Reboot.ps1 SHUTDOWN

.EXAMPLE
        Reboot.ps1 R

.EXAMPLE
        Reboot.ps1 RESTART

.EXAMPLE
        Reboot.ps1 REBOOT

.EXAMPLE
        Reboot.ps1 L

.EXAMPLE
        Reboot.ps1 LOGOFF

.NOTES
        Still under development.

#>
[string]$DoWhat = $args
$FileVersion = "0.1.9"
if ($DoWhat -eq "HELP" -or $DoWhat -eq "H") {
        Say ""
        Say "Reboot $FileVersion help."
        Say ""
        Say "Reboot S"
        Say "Reboot STOP"
        Say "Reboot SHUTDOWN"
        Say "Reboot R"
        Say "Reboot RESTART"
        Say "Reboot REBOOT"
        Say "Reboot L"
        Say "Reboot LOGOFF"
        Say "Reboot ? (Is reboot required.)"
        Say "Reboot H"
        Say "Reboot HELP"
        Say ""
        return
}
if ($DoWhat -eq "S") {
        asay.ps1 "Reboot $FileVersion is shutting this machine down."
        Start-Sleep -s 1
        Say "Reboot $FileVersion is shutting this machine down."
        & shutdown.exe /S /T 3 /C "Because I Fucking Said So."
        return
}
if ($DoWhat -eq "STOP") {
        asay.ps1 "Reboot $FileVersion is shutting this machine down."
        Start-Sleep -s 1
        Say "Reboot $FileVersion is shutting this machine down."
        & shutdown.exe /S /T 3 /C "Because I Fucking Said So."
        return
}
if ($DoWhat -eq "SHUTDOWN") {
        asay.ps1 "Reboot $FileVersion is shutting this machine down."
        Start-Sleep -s 1
        Say "Reboot $FileVersion is shutting this machine down."
        & shutdown.exe /S /T 3 /C "Because I Fucking Said So."
        return
}
if ($DoWhat -eq "R") {
        asay.ps1 "Reboot $FileVersion is rebooting this machine"
        Start-Sleep -s 1
        Say "Reboot $FileVersion is rebooting this machine"
        & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
        return
}
if ($DoWhat -eq "REBOOT") {
        asay.ps1 "Reboot $FileVersion is rebooting this machine"
        Start-Sleep -s 1
        Say "Reboot $FileVersion is rebooting this machine"
        & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
        return
}
if ($DoWhat -eq "RESTART") {
        asay.ps1 "Reboot $FileVersion is rebooting this machine"
        Start-Sleep -s 1
        Say "Reboot $FileVersion is rebooting this machine"
        & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
        return
}
if ($DoWhat -eq "L") {
        asay.ps1 "Reboot $FileVersion is logging you off this machine"
        Start-Sleep -s 1
        Say "Reboot $FileVersion is logging you off this machine"
        & shutdown.exe /L
        return
}
if ($DoWhat -eq "LOGOFF") {
        asay.ps1 "Reboot $FileVersion is logging you off this machine"
        Start-Sleep -s 1
        Say "Reboot $FileVersion is logging you off this machine"
        & shutdown.exe /L
        return
}
if ($DoWhat -eq "?") {
        Pending.ps1
        return
}
if ($DoWhat -eq "PENDING") {
        Pending.ps1
        return
}
$Ans = Put-Pause -Prompt "(Y)es to reboot: " -Max 3000 -Echo 1
if ($Ans -eq "Y") {
        asay.ps1 "Reboot $FileVersion is rebooting this machine"
        Start-Sleep -s 1
        Say "Reboot $FileVersion is rebooting this machine"
        & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
        return
}
else {
        Say "Reboot $FileVersion" '[Try "Reboot Help" if you are lost.]'
        if (($DoWhat)) { Say "The parameter" $DoWhat.ToUpper() "did not match any options." }
        else { Say "You are just spinning your wheels there buddy." }
}
