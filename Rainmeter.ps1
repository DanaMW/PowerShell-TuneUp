# Rainmeter
#
# This just kills and restarts rainmeter for me because the skin (Gadgets) locks up on my machine sometimes.
#
$FileVersion = "0.0.5"
Say "Restart Rainmeter " $+ $FileVersion $+ ", for when that fucker jams up!."
Say "Checking for Rainmeter.exe"
#
#if (Get-Process | Where-Object { $_.name -eq "Rainmeter" }) {
#    Say "Found Rainmeter."
#} # -ErrorAction SilentlyContinue
#if (Get-Process | Where-Object { $_.path -eq "D:\bin\Rainmeter\Rainmeter.exe" }) {
#    Say "I found rainmeter"
#
#} # -ErrorAction SilentlyContinue
#
if (Get-CimInstance Win32_Process | Where-Object { $_ -like "*Rainmeter*" }) {
    Say "Found a running Rainmeter."
    # get path
    Say "Killing Rainmeter"
    Stop-Process -Name Rainmeter
    Say "Running Rainmeter. See ya."
    & "D:/bin/Rainmeter/Rainmeter.exe"
}
else {
    Say "Rainmeter is not currently running."
    # you could exit below
    # Say "See ya."
    # return
    Say "Running Rainmeter. See ya."
    & "D:/bin/Rainmeter/Rainmeter.exe"
}
