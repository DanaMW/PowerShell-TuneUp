[string]$DoWhat = $args
$FileVersion = "Version: 0.1.4"
if (!($DoWhat)) {
    asay "Reboot $FileVersion is rebooting this machine"
    Start-Sleep -s 1
    Say "Reboot $FileVersion is rebooting this machine"
    & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
    return
}
if ($DoWhat -eq "STOP") {
    asay "Reboot $FileVersion is shutting this machine down."
    Start-Sleep -s 1
    Say "Reboot $FileVersion is shutting this machine down."
    & shutdown.exe /S /T 3 /C "Because I Fucking Said So."
    return
}
if ($DoWhat -eq "SHUTDOWN") {
    asay "Reboot $FileVersion is shutting this machine down."
    Start-Sleep -s 1
    Say "Reboot $FileVersion is shutting this machine down."
    & shutdown.exe /S /T 3 /C "Because I Fucking Said So."
    return
}
if ($DoWhat -eq "REBOOT") {
    asay "Reboot $FileVersion is rebooting this machine"
    Start-Sleep -s 1
    Say "Reboot $FileVersion is rebooting this machine"
    & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
    return
}
if ($DoWhat -eq "RESTART") {
    asay "Reboot $FileVersion is rebooting this machine"
    Start-Sleep -s 1
    Say "Reboot $FileVersion is rebooting this machine"
    & shutdown.exe /R /T 3 /C "Because I Fucking Said So."
    return
}
Say "Reboot $FileVersion [It should not get to here so ERROR]"
Say "The parameter" $DoWhat.ToUpper() "did not match any options."
