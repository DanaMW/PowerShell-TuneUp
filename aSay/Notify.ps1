param([string]$MyArgs)
$FileVersion = "0.2.8"
if (!($MyArgs)) {
    Write-Output "Notify $FileVersion"
    Write-Output "ERROR No params on the command line"
    Write-Output " "
    Write-Output "Use: ASAY <message> (without quotes)"
    Write-Output "Use: NOTIFY <message> (without quotes)"
    Write-Output "Use quotes if there are punctuation or special characters in the <message>"
    Write-Output " "
    return
}
$TheArgs = "$MyArgs $args"
$Fill = "                       "
$png = ($env:BASE + "\notify.png")
$sys = "-<[ PowerShell $env:USERDOMAIN System Notification ]>-"
$UID = ("Notify" + $(Get-Random -Maximum 999 -Minimum 100))
$ToastHeader = New-BTHeader -Id $UID -Title $sys
#New-BurntToastNotification -Text "$TheArgs", "$Fill" -AppLogo "$png" -Header $ToastHeader -UniqueIdentifier "$UID"
Toast -Text "$TheArgs", "$Fill" -AppLogo "$png" -Header $ToastHeader -UniqueIdentifier "$UID"
