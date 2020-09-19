param([string]$MyArgs)
$FileVersion = "Version: 0.2.4"
if (!($MyArgs)) {
    Write-Output "Notify $FileVersion"
    Write-Output "ERROR No params on the command line"
    Write-Output " "
    Write-Output "Please use: NOTIFY <message to send to output> (without quotes)"
    Write-Output "Or use: ASAY <message to send to output> (without quotes)"
    Write-Output " "
    return
}
$TheArgs = "$MyArgs $args"
$Fill = "                       "
$png = ($env:BASE + "\Notify.png")
$sys = "-<[ PowerShell Core System Notification ]>-"
$UID = ("Notify" + $(Get-Random -maximum 999 -minimum 100))
$ToastHeader = New-BTHeader -Id $UID -Title $sys
#New-BurntToastNotification -Text "$TheArgs", "$Fill" -AppLogo "$png" -Header $ToastHeader -UniqueIdentifier "$UID"
Toast -Text "$TheArgs", "$Fill" -AppLogo "$png" -Header $ToastHeader -UniqueIdentifier "$UID"
