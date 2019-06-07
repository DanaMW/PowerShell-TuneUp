param([string]$myargs)
$FileVersion = "Version: 0.2.0"
if (!($myargs)) {
    Write-Output "ASay" $FileVersion
    Write-Output "ERROR No params on the command line"
    Write-Output " "
    Write-Output "Please use: ASAY <message to send to output>"
    Write-Output "or use: NOTIFY <message to send to output>"
    Write-Output " "
    Write-Output " "
    return
}
$TheArgs = "$myargs $args"
$png = ($env:BASE + "\asay.png")
#$sys = "PowerShell Core System Message"
$UID = "BinMess"
New-BurntToastNotification -Text "$TheArgs" -AppLogo "$png" -UniqueIdentifier "$UID"
