param([string]$MyArgs)
$FileVersion = "Version: 0.2.2"
if (!($MyArgs)) {
    Write-Output "ASay $FileVersion"
    Write-Output "ERROR No params on the command line"
    Write-Output " "
    Write-Output "Please use: ASAY <message to send to output> (without quotes)"
    Write-Output "or use: NOTIFY <message to send to output> (without quotes)"
    Write-Output " "
    return
}
$TheArgs = "$MyArgs $args"
$Fill = "                       "
$png = ($env:BASE + "\ASay.png")
$sys = "-<[ PowerShell Core System Notification ]>-"
$UID = ("ASay" + $(Get-Random -maximum 999 -minimum 100))
$ToastHeader = New-BTHeader -Id $UID -Title $sys
Toast -Text "$TheArgs", "$Fill" -AppLogo "$png" -Header $ToastHeader -UniqueIdentifier "$UID"
