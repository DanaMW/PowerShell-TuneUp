#FileVersion = 0.0.1
#Run as admin
#Start-Process -Verb RunAs -FilePath "c:\Windows\System32\wevtutil.exe" -ArgumentList "el | Foreach-Object {wevtutil cl $_}"
wevtutil el | Foreach-Object {wevtutil cl $_}
