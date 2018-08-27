Param([bool]$loud)
#Start-Process -Verb RunAs -FilePath "c:\Windows\System32\wevtutil.exe" -ArgumentList "el | Foreach-Object {wevtutil cl $_}"
$FileVersion = "0.0.5"
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
else { wevtutil el | Foreach-Object { wevtutil cl $_; $i++ } }
Write-Host ""
Write-Host "ClearWindows Logs Processed $i log files."
$pop = Read-Host -Prompt "[Slap Enter to Exit]"
if ($null -ne $pop) { $pop = "" }
