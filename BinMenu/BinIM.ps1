Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
$Win32 = Add-Type -MemberDefinition @'
[DllImport("kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll", CharSet = CharSet.Auto)]
public static extern IntPtr SendMessage(IntPtr hWnd, int Msg, IntPtr wParam, IntPtr lParam);
'@ -Name "ConsoleIcon" -Namespace "Win32" -PassThru
$IconPath = "$PSScriptRoot\BinSM.ico"
$Icon = New-Object System.Drawing.Icon($IconPath)
$Hwnd = $Win32::GetConsoleWindow()
if ($Hwnd -ne [IntPtr]::Zero) {
    $WM_SETICON = 0x0080
    [void]$Win32::SendMessage($Hwnd, $WM_SETICON, [IntPtr]0, $Icon.Handle) # Small icon (title bar)
    [void]$Win32::SendMessage($Hwnd, $WM_SETICON, [IntPtr]1, $Icon.Handle) # Large icon (Alt+Tab / taskbar)
}
$TrayIcon = New-Object System.Windows.Forms.NotifyIcon
$TrayIcon.Icon = $Icon
$TrayIcon.Text = "BinIM"
$TrayIcon.Visible = $true
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
    $TrayIcon.Visible = $false
    $TrayIcon.Dispose()
} | Out-Null
#
$FileVersion = "3.0.40"
$FileDate = "11-23-2026"
#
$BASE = $env:Base
if (!($BASE)) { $BASE = $Config.Setup.Base }
if (!($Base)) {
    $Base = Put-Input "Enter the path to make your Base directory (No trailing slash)"
    if ($Base -eq "") { exit 1 }
}
if (!($Base)) { Say -ForeGroundColor RED "The Environment Variable Base must be set or this will not run, Set it or edit this script"; break }
$ScriptBase = ($Base + "\BinMenu")
Set-Location $ScriptBase.substring(0, 3)
Set-Location $ScriptBase
Clear-Host
$FileINI = ($ScriptBase + "\BinMenu.ini")
$Filetest = Test-Path -Path $FileINI
if (($Filetest)) { Remove-Item –Path $FileINI }
$FileTXT = ($ScriptBase + "\BinMenu.txt")
$Filetest = Test-Path -Path $FileTXT
if (($Filetest)) { Remove-Item –Path $FileTXT }
$FileCSv = ($ScriptBase + "\BinMenu.csv")
$Filetest = Test-Path -Path $FileCSV
if (($Filetest)) { Remove-Item –Path $FileCSV }
Say $fileVersion "Reading in directory" $Base
Get-ChildItem -Path $Base -Recurse -Include "*.exe" | Select-Object `
@{ n = 'Foldername'; e = { ([System.IO.Path]::GetRelativePath($Base, $_.FullName) -split '[\\]')[0] } },
Name,
FullName | Export-Csv -Path $FileTXT -NoTypeInformation
Say "Writing raw files info, Reread and sorting file names, Exporting all file names"
Import-Csv -Path $FileTXT | Sort-Object -Property "Foldername" | Export-Csv -NoTypeInformation $FileCSV
$writer = [System.IO.file]::CreateText($FileINI)
[int]$i = 1
try {
    Import-Csv $FileCSV | ForEach-Object {
        $tmpbase = $Base
        $tmpfolder = $_.Foldername
        $tmpname = $_.fullname
        if ($tmpfolder -eq "Blender" -and $tmpname -ne ($tmpbase + "\Blender\blender.exe")) { return }
        if ($tmpfolder -eq "ConEmu" -and $tmpname -ne ($tmpbase + "\conemu\conemu64.exe")) { return }
        if ($tmpfolder -eq "git" -and $tmpname -ne ($tmpbase + "\git\bin\bash.exe")) { return }
        if ($tmpfolder -eq "inkscape" -and $tmpname -ne ($tmpbase + "\inkscape\bin\inkscape.exe")) { return }
        if ($tmpfolder -eq "MusicBee" -and $tmpname -ne ($tmpbase + "\musicbee\musicbee.exe")) { return }
        if ($tmpfolder -eq "PulseAudio" -and $tmpname -ne ($tmpbase + "\PulseAudio\bin\pulseaudio.exe")) { return }
        if ($tmpfolder -eq "Rainmeter" -and $tmpname -ne ($tmpbase + "\rainmeter\rainmeter.exe")) { return }
        if ($tmpfolder -eq "tc" -and $tmpname -ne ($tmpbase + "\tc\TOTALCMD64.EXE")) { return }
        if ($tmpfolder -eq "uget" -and $tmpname -ne ($tmpbase + "\uget\bin\uget.exe")) { return }
        if ($tmpfolder -eq "wscc" -and $tmpname -ne ($tmpbase + "\wscc\wscc.exe")) { return }
        if ($tmpfolder -eq "yakyak" -and $tmpname -ne ($tmpbase + "\yakyak\yakyak.exe")) { return }
        if ($tmpfolder -eq "ImageMagick" -and $tmpname -ne ($tmpbase + "\ImageMagick\magick.exe")) { return }
        if ($tmpfolder -eq "HandBrake" -and $tmpname -ne ($tmpbase + "\HandBrake\HandBrake.exe")) { return }
        $NameFix = (Split-Path $tmpname -Leaf).ToLower()
        $NameFix = ($NameFix -replace '\s+', ' ').Trim()
        $NameFix = [regex]::Replace($NameFix, '(?<=^|[\s_-])[a-z]', { $args[0].Value.ToUpper() })
        if ($NameFix -eq "bash.exe") { $NameFix = "Git Bash.exe" }
        if ($NameFix -eq "Totalcmd64.exe") { $NameFix = "Total Commander.exe" }
        if ($NameFix -eq "conemu64.exe") { $NameFix = "Console Emulator.exe" }
        if ($NameFix -eq "magick.exe") { $NameFix = "ImageMagick.exe" }
        $Decidep = "Add $NameFix ? (Y/N/Q/(E)dit)[Enter is No]"
        Say "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
        Say $_
        Say $_.fullname
        Say "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
        $Decide = Read-Host -Prompt $Decidep
        if ($Decide -eq "Q") { $writer.close(); break }
        if ($Decide -eq "E") {
            $NameFix = Put-Input "Edit to your liking"
            if ($NameFix -eq "") { return }
            $Decide = "Y"
        }
        if ($Decide -eq "Y") {
            $NameFix = $NameFix -replace '\.exe$', ''
            Say "Adding to Menu: $NameFix"
            $Writer.WriteLine("[" + $i + "A]=" + $NameFix)
            $Writer.WriteLine("[" + $i + "B]=" + $_.fullname)
            $Writer.WriteLine("[" + $i + "C]=")
            $i++
            return
        }
        else { return }
    }
}
finally { $writer.close() }
Clear-Host
Say "Done Writing EXE files to the Menu ini."
Say ""
$Filetest = Test-Path -Path $FileTXT
if (($Filetest)) { Remove-Item –Path $FileTXT }
$Filetest = Test-Path -Path $FileCSV
if (($Filetest)) { Remove-Item –Path $FileCSV }
Clear-Host
Invoke-Item ($ScriptBase + "\BinMenu.lnk");
$TrayIcon.Dispose()
return
