# Rainmeter
$FileVersion = "0.0.4"
Say "Restart Rainmeter " $+ $FileVersion $+ ", for when that fucker jams up!."
Say "Checking for Rainmeter.exe"
#if (Get-Process | Where-Object { $_.name -eq "Rainmeter" }) {
#    Say "Found Rainmeter."
#} # -ErrorAction SilentlyContinue
#if (Get-Process | Where-Object { $_.path -eq "D:\bin\Rainmeter\Rainmeter.exe" }) {
#    Say "I found rainmeter"
#
#} # -ErrorAction SilentlyContinue
if (Get-CimInstance Win32_Process | Where-Object { $_ -like "*Rainmeter*" }) {
    Say "Found Rainmeter running."
    # get path
    Say "Killing Rainmeter"
    Stop-Process -Name Rainmeter
    Say "Running Rainmeter. See ya."
    & "D:/bin/Rainmeter/Rainmeter.exe"
}
else {
    Say "Rainmeter is not currently running."
    Say "Running Rainmeter. See ya."
    & "D:/bin/Rainmeter/Rainmeter.exe"
}
