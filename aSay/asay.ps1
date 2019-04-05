param([string]$myargs)
$FileVersion = "Version: 0.1.3"
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
$prg = ($env:BASE + "\snoretoast.exe")
$png = ($env:BASE + "\asay.png")
$sys = "PowerShell Core System Message"
$command = "$prg -t `"$sys`" -m `"$TheArgs`" -id `"BinMess`" -p `"$png`""
try { Invoke-Expression $command -ErrorAction Stop }
Catch {
    Write-Output " "
    Write-Output "ERROR IN SCRIPT ASAY.PS1: Error while running $command"
    Write-Output " "
    Write-Output " "
    return
}
Finally { Say "" }
