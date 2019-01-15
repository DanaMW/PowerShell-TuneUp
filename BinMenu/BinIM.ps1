$FileVersion = "Version: 1.1.10"
if (!($env:BASE)) { Say -ForeGroundColor RED "The Environment Variable BASE must be set or this will not run, Set it or edit this script"; break }
Set-Location $env:BASE.substring(0, 3)
Set-Location $env:BASE
Clear-Host
$FileINI = ($env:BASE + "\BinMenu.ini")
$Filetest = Test-Path -path $FileINI
if ($Filetest -eq $True) { Remove-Item –path $FileINI }
$FileTXT = ($env:BASE + "\BinMenu.txt")
$Filetest = Test-Path -path $FileTXT
if ($Filetest -eq $True) { Remove-Item –path $FileTXT }
$FileCSv = ($env:BASE + "\BinMenu.csv")
$Filetest = Test-Path -path $FileCSV
if ($Filetest -eq $True) { Remove-Item –path $FileCSV }
Say $fileVersion "Reading in directory" $env:BASE
Get-ChildItem -Path $env:BASE -Recurse -Include "*.exe" | Select-Object `
@{ n = 'Foldername'; e = { ($_.PSPath -split '[\\]')[3] } } ,
Name,
FullName ` | Export-Csv -path $FileTXT -NoTypeInformation
Say "Writing raw files info, Reread and sorting file names, Exporting all file names"
Import-Csv -Path $FileTXT | Sort-Object -Property "Foldername" | Export-Csv -NoTypeInformation $FileCSV
$writer = [System.IO.file]::CreateText($FileINI)
[int]$i = 1
try {
    Import-Csv $FileCSV | Foreach-Object {
        $tmpname = [Regex]::Escape($_.fullname)
        $tmpbase = $env:base.replace("\", "\\")
        if ($tmpname -match "git" -and $tmpname -ne ($tmpbase + "\\git\\bin\\bash\.exe")) { return }
        if ($tmpname -match "wscc" -and $tmpname -ne ($tmpbase + "\\wscc\\wscc\.exe")) { return }
        if ($tmpname -match "wscc" -and $tmpname -ne ($tmpbase + "\\wscc\\SysInternals Suite\\procexp64\.exe")) { return }
        $tmpname = $_.name -replace "\\", ""
        if ($tmpname -eq "Totalcmd64.exe") { $tmpname = "Total Commander.exe" }
        $NameFix = $tmpname
        $NameFix = $NameFix.tolower()
        $NameFix = $NameFix.substring(0, 1).toupper() + $NameFix.substring(1)
        $Decidep = "Add $NameFix ? (Y)es-(N)o-[Enter is No]"
        Say "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
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
Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\BinMenu.ps1") -Verb RunAs
return
