$FileVersion = "Version: 2.0.4"
$Base = $env:BASE
if (!($Base)) {
    $Base = ReadHost -Prompt = "Enter the path to make your BASE directory (No trailing \)"
}
if (!($Base)) { Say -ForeGroundColor RED "The Environment Variable BASE must be set or this will not run, Set it or edit this script"; break }
Set-Location $Base.substring(0, 3)
Set-Location $Base
Clear-Host
$FileINI = ($Base + "\BinMenu.ini")
$Filetest = Test-Path -path $FileINI
if ($Filetest -eq $True) { Remove-Item –path $FileINI }
$FileTXT = ($Base + "\BinMenu.txt")
$Filetest = Test-Path -path $FileTXT
if ($Filetest -eq $True) { Remove-Item –path $FileTXT }
$FileCSv = ($Base + "\BinMenu.csv")
$Filetest = Test-Path -path $FileCSV
if ($Filetest -eq $True) { Remove-Item –path $FileCSV }
Say $fileVersion "Reading in directory" $Base
Get-ChildItem -Path $Base -Recurse -Include "*.exe" | Select-Object `
@{ n = 'Foldername'; e = { ($_.PSPath -split '[\\]')[3] } } ,
Name,
FullName | Export-Csv -path $FileTXT -NoTypeInformation
Say "Writing raw files info, Reread and sorting file names, Exporting all file names"
Import-Csv -Path $FileTXT | Sort-Object -Property "Foldername" | Export-Csv -NoTypeInformation $FileCSV
$writer = [System.IO.file]::CreateText($FileINI)
[int]$i = 1
try {
    Import-Csv $FileCSV | ForEach-Object {

        $tmpbase = $Base
        $tmpname = $_.fullname
        if ($tmpname -match "conemu" -and $tmpname -ne ($tmpbase + "\conemu\conemu64.exe")) { return }
        if ($tmpname -match "git" -and $tmpname -ne ($tmpbase + "\git\bin\bash.exe")) { return }
        if ($tmpname -match "musicbee" -and $tmpname -ne ($tmpbase + "\musicbee\musicbee.exe")) { return }
        if ($tmpname -match "rainmeter" -and $tmpname -ne ($tmpbase + "\rainmeter\rainmeter.exe")) { return }
        if ($tmpname -match "tc" -and $tmpname -ne ($tmpbase + "\tc\TOTALCMD64.EXE")) { return }
        if ($tmpname -match "uget" -and $tmpname -ne ($tmpbase + "\uget\bin\uget.exe")) { return }
        if ($tmpname -match "wscc" -and $tmpname -ne ($tmpbase + "\wscc\wscc.exe")) { return }
        if ($tmpname -match "yakyak" -and $tmpname -ne ($tmpbase + "\yakyak\yakyak.exe")) { return }
        $NameFix = Split-Path $tmpname -Leaf
        $NameFix = $NameFix.tolower()
        $NameFix = $NameFix.substring(0, 1).toupper() + $NameFix.substring(1)
        if ($NameFix -eq "bash.exe") { $NameFix = "Git Bash.exe" }
        if ($NameFix -eq "procexp64.exe") { $NameFix = "Process Explorer.exe" }
        if ($NameFix -eq "Totalcmd64.exe") { $NameFix = "Total Commander.exe" }
        $Decidep = "Add $NameFix ? (Y)es-(N)o-[Enter is No]"
        Say "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
        Say $_
        Say "["$_.fullname"]"
        $Decide = Read-Host -Prompt $Decidep
        if ($Decide -eq "Y") {
            $NameFix = $NameFix.replace(".exe", "")
            Say "Adding to Menu: " $NameFix
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
$Filetest = Test-Path -path $FileTXT
if ($Filetest -eq $True) { Remove-Item –path $FileTXT }
$Filetest = Test-Path -path $FileCSV
if ($Filetest -eq $True) { Remove-Item –path $FileCSV }
Clear-Host
Start-Process "pwsh.exe" -ArgumentList ($Base + "\BinMenu.ps1") -Verb RunAs
return
#>
