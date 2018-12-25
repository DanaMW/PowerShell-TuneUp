param([string]$myargs)
$FileVersion = "Version: 0.1.1"
if (!($myargs)) {
    Write-Output "Notify" $FileVersion
    Write-Output "ERROR No params on the commandlime"
    Write-Output " "
    Write-Output "Please use: NOTIFY <message to send to output>"
    Write-Output "or use: ASAY <message to send to output>"
    Write-Output " "
    Write-Output " "
    return
}
$TheArgs = "$myargs $args"
$command = 'D:\bin\snoretoast.exe -t "My Sysytem Message" -m "' + "$TheArgs" + '" -id DanaMW -p D:\bin\asay.png'
try { Invoke-Expression $command -ErrorAction Stop }
Catch {
    Write-Output " "
    Write-Output "ERROR IN SCRIPT ASAY: Error while running $command"
    Write-Output " "
    Write-Output " "
    return
}
Finally { Say "" }
