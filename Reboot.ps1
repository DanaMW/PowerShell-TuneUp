[string]$DoWhat = $args
$FileVersion = "Version: 0.1.5"
if (!($DoWhat)) {
    asay.ps1 "Reboot $FileVersion is rebooting this machine"
    Start-Sleep -s 1
    Say "Reboot $FileVersion is rebooting this machine"
    & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
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
if ($DoWhat -eq "LOGOFF") {
    asay.ps1 "Reboot $FileVersion is logging you off this machine"
    Start-Sleep -s 1
    Say "Reboot $FileVersion is logging you off this machine"
    & shutdown.exe /L
    return
}
Say "Reboot $FileVersion [It should not get to here so ERROR]"
Say "The parameter" $DoWhat.ToUpper() "did not match any options."
