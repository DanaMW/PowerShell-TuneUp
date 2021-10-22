$FileVersion = "0.0.3 "
<# Start_Setup #>
$Backgrounds = "D:/Pictures/Desktop/"
$Hold = 30000
<# End Setup #>
$Image = Get-ChildItem -Path $BackGrounds
$File = $Image | Get-Random -Count 1
Function Set-WallPaper ([string]$File) {
    try {
        Set-ItemProperty -Path "HKCU:Control Panel\Desktop" -Name WallPaper -Value $File
        Say $MyTime "Setting File" $File
        Start-Sleep -s 5
        rundll32.exe user32.dll, UpdatePerUserSystemParameters , 1 , True
    }
    catch { return $false }
}
while (1) {
    $Image = Get-ChildItem -Path $BackGrounds
    $File = $Image | Get-Random -Count 1
    Say $File
    Set-ItemProperty -Path "HKCU:Control Panel\Desktop" -Name WallPaper -Value $File
    Start-Sleep -s 5
    RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters , 1 , True
    $ans = Put-Pause.ps1 -Max $Hold -Echo 0
    if ($ans -eq "Q") { return }
}
