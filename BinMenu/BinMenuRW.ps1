<#
.SYNOPSIS
        BinMenuRW
         Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 07, 2018
.DESCRIPTION
        This script creates the INI file you will need for BinMenu.ps1. You can edit in the $BASE folder in the
        script or you can pass it on the command line.
.EXAMPLE
        BinMenuRW (with no parameter will run the complete INI file routine using current folder as BASE. To be run after the MAKE routine.)
        BinMenuRW MAKE or BinMenuRW -MyArgs MAKE (will run the ceate exclude file routines using current folder as BASE.)
        BinMenuRW -MAKE [true/false or 0/1] -Base [<PathToAFolder>] -Editor [<Optional full path to a text editor>]
.NOTES
        Still under development.
#>
param([bool]$Make, [string]$Base, [string]$Editor)
$FileVersion = "0.3.2"
if ($Make -eq "" -or $Make -eq $false) { $MakeActive = $False }
if ($Make -ne "" -and $Make -eq $true) { $MakeActive = $True  }
else { $MakeActive = $false }

<# If you want to set BASE and/or EDITOR in the file do it HERE or include on command line. #>
$Base = "C:\bin"
$Editor = "C:\bin\NPP\Notepad++.exe"
#$Editor = "code.exe"
<#################################################>
if ($Base -eq "") { $Base = Get-ScriptDir }
$tmp = ($($base).Length - 1)
if ($($base.substring($tmp)) -ne '\') { $base = $("$base" + "\") }
$ScriptName = $MyInvocation.MyCommand.Name

#Let us begin
Clear-Host
<# Setting up Base Files.#>
$Filetxt = "$Base" + "BinMenuRW.txt"
$Filecsv = "$Base" + "BinMenuRW.csv"
$FileExc = "$Base" + "BinMenu.csv"
$FileMen = "$Base" + "BinMenu.ini"

<# Cleanup files for redoing. #>
<# Remember not to remove the Exclude file. (FileExc) You create that manually. #>
$Filetest = Test-Path -path $Filetxt
if ($Filetest -eq $true) { Remove-Item –path $Filetxt }
$Filetest = Test-Path -path $Filecsv
if ($Filetest -eq $true) { Remove-Item –path $Filecsv }
$Filetest = Test-Path -path $FileMen
if ($Filetest -eq $true) { Remove-Item –path $FileMen }
<# Reads in all valid (runable exe ) entries from your base folder. #>
Write-host ($fileVersion + "Reading in directory" + $Base)
Get-ChildItem -Path "$Base" -Recurse -Include *.exe | Select-Object `
@{ n = 'Foldername'; e = { ($_.PSPath -split '[\\]')[3] } } ,
Name,
FullName ` | Export-Csv -path $Filetxt -NoTypeInformation
Write-host "Writing raw files info"
Write-host "Reread and sorting file names"
<#Sorting the entries and eporting to file. This is the one you use to create the exclude file.#>
Write-host "Exporting all file names"
Import-Csv -Path $Filetxt | Sort-Object -Property "Foldername" | Export-Csv -NoTypeInformation $Filecsv


<# This is where, if toggled the make INI file routine is done. While manual before,
it should be all automatic for the most part now.#>
if ($MakeActive -eq $True) {
    Clear-Host
    Write-Host "Here we are going create a file. In this edit you will remove the"
    Write-Host "Complete line and the space created of the file name your want TO KEEP"
    Write-Host "Or show in your copy of the menu. Dont leave line spaces, move the line below"
    Write-Host "up to fill in. When Your done it should all automate to the menu if I got this."
    Write-Host ""
    Write-Host "[Press Any Key To Continue]"
    [void][System.Console]::ReadKey($true)
    $tmp = Read-Host -Prompt "[Choose an editor? (Enter for default)]"
    if ($tmp -ne "") {
        $Filetest = Test-Path -path $tmp
        if ($Filetest -eq $true) { $Editor = $tmp }
        else { Write-Error  "You defined an editor that was not found. Rerun $ScriptName" }
    }
    if ($Editor -ne "") {
        & $Editor $Filecsv
        $tmp = Read-Host -Prompt "Enter to continue"
    }
    else { & Start-Process $Filecsv -NoNewWindow -Wait }
    Copy-Item -path $Filecsv -Destination $FileExc
    $tmp = "$Base" + "BinMenuRW.PS1"
    & Start-Process pwsh.exe $tmp
    break
}

#Reading in the entries you removed
Write-Host "Time to read in valid menu entries..."
$writer = [System.IO.file]::CreateText($FileMen)
$i = 1
try {
    $Exlist = Import-Csv $FileExc | Select-Object FullName
    $ExList = $ExList -replace "@{FullName=", ""
    $ExList = $ExList -replace "}", ""
    Import-Csv $Filecsv | Foreach-Object {

        $tmpname = [Regex]::Escape($_.fullname)
        if ($Exlist -match $tmpname) {
            return
        }
        $tmpname = $_.name -replace "\\", ""
        if ($tmpname -eq "Totalcmd64.exe") { $tmpname = "Total Commander.exe" }
        $NameFix = $tmpname
        $NameFix = $NameFix.tolower()
        $NameFix = $NameFix.substring(0, 1).toupper() + $NameFix.substring(1)
        $NameFix = $NameFix.replace(".exe", "")
        Write-Host "Adding to Menu: " $NameFix
        $Writer.WriteLine("[" + $i + "A]=" + $NameFix)
        <# $Writer.WriteLine("[" + $i + "A]=" + $_.name.replace(".exe", "")) #>
        $Writer.WriteLine("[" + $i + "B]=" + $_.fullname)
        <# export-Csv -Path $FileMen -Append -Delimiter ", " -InputObject $_ #>
        $i++
    }
}
finally { $writer.close() }
Write-Host "Done Writing EXE files to the Menu ini."
Write-Host ""

#All files written so now we can clean up.
#Remember not to remove the Exclude file. (FileExc) You create that manually.
#Here remember not to remove the ini file either. (Fileini) The BinMenu read it.
$Filetest = Test-Path -path $Filetxt
if ($Filetest -eq $true) { Remove-Item –path $Filetxt }
$Filetest = Test-Path -path $Filecsv
if ($Filetest -eq $true) { Remove-Item –path $Filecsv }

#Lastly We read in any PowerShell scripts in the folder.
#ScripTRead Needs to be done!!

#Run the BinMenu.
$tmp = "$Base" + "BinMenu.PS1"
Start-Process pwsh.exe $tmp
