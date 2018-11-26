param([string]$myargs)
$FileVersion = "Version: 0.1.0"
if ($myargs -eq "") {
    Write-Output " "
    Write-Output "ERROR No params on the commandlime"
    Write-Output " "
    Write-Output "Please use: NOTIFY <message to send to output>"
    Write-Output "or use: ASAY <message to send to output>"
    Write-Output " "
    Write-Output " "
    return
}
$TheArgs = "$myargs $args"
try {
    $command = 'D:\bin\snoretoast.exe -t "My Sysytem Message" -m "' + "$TheArgs" + '" -id DanaMW -p D:\bin\asay.png'
}
Catch {
    [System.Windows.Forms.MessageBox]::Show($_ , "Status")
}
if ($command -eq "") {
    Write-Output " "
    Write-Output "ERROR IN SCRIPT ASAY: Command is empty"
    Write-Output " "
    Write-Output " "
    return
}
Invoke-Expression $command
