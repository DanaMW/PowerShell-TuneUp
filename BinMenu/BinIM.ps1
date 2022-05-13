$FileVersion = "3.0.30"
$Base = $env:Base
if (!($Base)) {
    $Base = Put-Input "Enter the path to make your Base directory (No trailing slash)"
    if ($Base -eq "") { EXIT }
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
@{ n = 'Foldername'; e = { ($_.PSPath -split '[\\]')[3] } } ,
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
        $NameFix = Split-Path $tmpname -Leaf
        #$NameFix = $NameFix.tolower()
        $namesplit = $NameFix.split(" ")
        if (($namesplit[2])) {
            $namesplit[0].substring(0, 1).toupper() + $namesplit[0].substring(1) | Out-Null
            $namesplit[1].substring(0, 1).toupper() + $namesplit[1].substring(1) | Out-Null
            $namesplit[2].substring(0, 1).toupper() + $namesplit[2].substring(1) | Out-Null
            $NameFix = ($namesplit[0] + " " + $namesplit[1] + " " + $namesplit[2])
        }
        elseif (($namesplit[1])) {
            $namesplit[0].substring(0, 1).toupper() + $namesplit[0].substring(1) | Out-Null
            $namesplit[1].substring(0, 1).toupper() + $namesplit[1].substring(1) | Out-Null
            $NameFix = ($namesplit[0] + " " + $namesplit[1])
        }
        else { $NameFix = $NameFix.substring(0, 1).toupper() + $NameFix.substring(1) }
        if ($NameFix -eq "bash.exe") { $NameFix = "Git Bash.exe" }
        if ($NameFix -eq "Totalcmd64.exe") { $NameFix = "Total Commander.exe" }
        if ($NameFix -eq "conemu64.exe") { $NameFix = "Console Emulator.exe" }
        if ($NameFix -eq "yakyak.exe") { $NameFix = "YakYak.exe" }
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
            $NameFix = $NameFix.replace(".exe", "")
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
return
