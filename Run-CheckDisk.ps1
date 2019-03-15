$FileVersion = "Version: 0.0.1"
Say "Running Complete CheckDisk" $FileVersion
Say "Setting CHKNTFS back to the defaults, then wait time 3 seconds"
CHKNTFS /D
CHKNTFS /T:3
Say "Setting the harddisks to DIRTY so they will be checked on reboot."
FSUTIL dirty set D:
FSUTIL dirty set C:
Say "OK, rebooting to get this shit cleaned up."
Start-Sleep -s 3
Start-Process -FilePath "D:\bin\reboot.ps1" -ArgumentList "REBOOT" -Verb RunAs
return
