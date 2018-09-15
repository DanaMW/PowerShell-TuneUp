Param([bool]$loud)
#Start-Process -Verb RunAs -FilePath "c:\Windows\System32\wevtutil.exe" -ArgumentList "el | Foreach-Object {wevtutil cl $_}"
$FileVersion = "Version: 0.1.5"
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if (!($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))) {
    Start-Process "pwsh.exe" -ArgumentList "$PSScriptRoot\ClearLogs.ps1" -Verb RunAs
    return
}
Write-Host ""
Write-Host "Running ClearWindows Logs $FileVersion"
$ClearSet = 0
& wevtutil el | Foreach-Object { $ClearSet++ }
Write-Host "You have $ClearSet logs on this machine. Setting Up the math."
$ClearSet = ($ClearSet / 100)
$i = 0
if ($loud -eq $True) {
    wevtutil el | Foreach-Object {
        Write-Host "Deleting: " $_
        wevtutil cl $_
        $i++
    }
}
else {
    wevtutil el | Foreach-Object {
        wevtutil cl $_
        $i++
        $p = ($i / $ClearSet)
        $p = [int][Math]::Ceiling($p)
        Write-Progress -Activity "Clearing Windows Logs" -Status "$p% Complete:" -PercentComplete $p
    }
}
$t = 0
While ($t -le 6) { Write-Host ""; $t++ }
Write-Host "ClearWindows Logs Processed $i log files."
Read-Host -Prompt "[Slap Enter to Exit]"
