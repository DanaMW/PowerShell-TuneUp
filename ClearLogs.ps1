Param([bool]$loud)
#Start-Process -Verb RunAs -FilePath "c:\Windows\System32\wevtutil.exe" -ArgumentList "el | Foreach-Object {wevtutil cl $_}"
$FileVersion = "Version: 0.1.0"
Write-Host ""
Write-Host "Running ClearWindows Logs " $FileVersion
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
        $p = ($i / 11.32)
        Write-Progress -Activity "Clearing Windows Logs" -Status "$p% Complete:" -PercentComplete $p
    }
}

Write-Host ""
Write-Host "ClearWindows Logs Processed $i log files."
Read-Host -Prompt "[Slap Enter to Exit]"
