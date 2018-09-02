<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 30, 2018
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created by it's companion script BinMenuRW.ps1.
.EXAMPLE
        BinMenu.ps1 -Base [<PathToAFolder>]
.NOTES
        Still under development.
#>
$FileVersion = "Version: 0.7.0"
$host.ui.RawUI.WindowTitle = "BinMenu $FileVersion on $env:USERDOMAIN"
Function Get-ScriptDir {
    Split-Path -parent $PSCommandPath
}
Function MyConfig {
    $MyConfig = (Split-Path -parent $PSCommandPath) + "\" + (Split-Path -leaf $PSCommandPath)
    $MyConfig = ($MyConfig -replace ".ps1", ".json")
    $MyConfig = $MyConfig.trimstart(" ")
    $MyConfig
}
$ConfigFile = MyConfig
try {
    $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
}
catch {
    Write-Error -Message "The Base configuration file is missing!"
}
if (!($Config)) {
    Write-Error -Message "The Base configuration file is missing!"
}
<# #[Set-ConWin]#[Window Resizer]# #>
[int]$WinWidth = ($Config.basic.WinWidth)
[int]$WinHeight = ($Config.basic.WinHeight)
[int]$BuffWidth = ($Config.basic.BuffWidth)
[int]$BuffHeight = ($Config.basic.BuffHeight)
$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.buffersize
$newsize.height = $BuffHeight
$newsize.width = $BuffWidth
$pswindow.buffersize = $newsize
$newsize = $pswindow.windowsize
$newsize.height = $WinHeight
$newsize.width = $WinWidth
$pswindow.windowsize = $newsize
Clear-Host
$Base = ($Config.basic.Base)
if ($Base -eq "") {
    Write-Error "Config Read did not work out. Using current folder."
    Start-Sleep -s 5
    $Base = Get-ScriptDir
}
if ($base.substring(($base.length - 1)) -ne "\") { $base = $base + "\" }
[string]$Fileini = "$Base" + "BinMenu.ini"
[String]$Filetmp = "$Base" + "BinTemp.del"
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
Set-Location $Base
[string]$Editor = ($Config.basic.Editor)
[bool]$ScriptRead = ($Config.basic.ScriptRead)
[bool]$MenuAdds = ($Config.basic.MenuAdds)
[int]$SortMethod = ($Config.basic.SortMethod)
[string]$SortDir = ($Config.basic.SortDir)
[int]$ExtraLine = ($Config.basic.ExtraLine)
if ($SortDir -eq "VERT" -and $SortMethod -eq 1) { $SortMethod = 0 }
[bool]$DBug = ($Config.basic.DBug)
[int]$SPLine = ($Config.basic.SPLine)
[int]$AddCount = ($Config.AddItems.count)
Function DBFiles {
    Write-Host "Configfile: $ConfigFile"
    Write-Host "Config: $config"
    Write-Host "FileVersion: $FileVersion"
    Write-Host "Base: $Base"
    Write-Host "ScriptRead: $ScriptRead"
    Write-Host "MenuAdds: $MenuAdds"
    Write-Host "Fileini: $Fileini"
    Write-Host "FileTmp: $filetmp"
    Write-Host "Editor: $Editor"
    Write-Host "AddCount: $AddCount"
    Write-Host "WinWidth: $WinWidth"
    Write-Host "WinHeight: $WinHeight"
    Write-Host "BuffWidth: $BuffWidth"
    Write-Host "BuffHeight: $BuffHeight"
    Write-Host "SortMethod: $SortMethod"
    Write-Host "SortDir: $SortDir"
    Write-Host "ExtraLine: $ExtraLine"
    Write-Host "DBug: $DBug"
    Write-Host "Example: ($Config.AddItems[0].name)"
    Write-Host "Example: ($Config.AddItems[0].command)"
    Read-host -prompt "[Enter To Continue]"
}
if ($DBug -eq "$True") { DBFiles }
$ESC = [char]27
$Filetest = Test-Path -path $Fileini
if ($Filetest -ne $true) {
    Write-Host "The File $Fileini is missing. We Can not continue without it."
    Write-Host "We are going to run the INI creator function now"
    Read-Host -Prompt "[Enter to continue]"
    [bool]$NoINI = $True
    My-Maker
}
Clear-Host
$NormalLine = "$ESC[31m#=====================================================================================================#$ESC[97m"
$FancyLine = "$ESC[31m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[97m"
$TitleLine = "$ESC[31m#======================================<$ESC[96m[$ESC[41m $ESC[97mMy Bin Folder Menu $ESC[40m$ESC[96m]$ESC[31m>=======================================#$ESC[97m"
$SpacerLine = "$ESC[31m|                                                                                                     $ESC[31m|$ESC[97m"
$ProgramLine = "$ESC[31m#$ESC[96m[$ESC[33mProgram Menu$ESC[96m]$ESC[31m=======================================================================================#$ESC[97m"
$Menu1Line = "$ESC[31m#$ESC[96m[$ESC[33mBuilt-in Menu$ESC[96m]$ESC[31m======================================================================================#$ESC[97m"
$ScriptLine = "$ESC[31m#$ESC[96m[$ESC[33mScripts List$ESC[96m]$ESC[31m=======================================================================================#$ESC[97m"
[int]$LineCount = 0
try {
    $Reader = New-Object IO.StreamReader $Fileini
    while ($null -ne $Reader.ReadLine()) { $LineCount++ }
}
Finally { $Reader.Close() }
if ($MenuAdds = $True) {
    Write-Host "Adding User Added Files to the INI"
    $temp = [int]($LineCount / 2)
    $temp1 = ($temp - 1)
    $temp2 = ($temp + 1)
    $J = 0
    while ($j -le ($AddCount - 1)) {
        $k = $($Config.AddItems[$j].name)
        $t = $(Select-String -Pattern $k $Fileini)
        if ($null -eq $t) {
            $value1 = "[" + $temp2 + "A]=" + [string]($Config.AddItems[$j].name)
            (Add-Content $fileini $value1)[$temp1]
            $temp1++
            $value2 = "[" + $temp2 + "B]=" + [string]($Config.AddItems[$j].command)
            (Add-Content $fileini $value2)[$temp1]
            $temp1++
            $Temp2++
        }
        $j++
    }
}
[int]$LineCount = 0
try {
    $Reader = New-Object IO.StreamReader $Fileini
    while ($null -ne $Reader.ReadLine()) { $LineCount++ }
}
Finally { $Reader.Close() }
<# Setting up positioning #>
$temp = ($LineCount / 2)
$a = ($temp / 3)
$a = [int][Math]::Ceiling($a)
$temp = $a
$b = ($temp * 2)
$c = ($LineCount / 2)
$Row = @($a, $b, $c)
$Col = @(1, 34, 69)
$pa = ($a + 5)
Function DBVariables {
    Write-Host "Vline $Vline"
    Write-Host "L $l"
    Write-Host "roll $roll"
    Write-Host "tmp $tmp"
    Write-Host "I $i"
    Write-Host "W $w"
    Write-Host "T $t"
    Write-host "Linecount" $linecount
    Write-host "A" $a
    Write-host "Temp" $temp
    Write-host "B" $b
    Write-host "C" $c
    Write-host "Row" $row
    $pop = Read-host -prompt "[Enter]"
    if (!($pop)) { Write-Host "Error"}
}
if ($DBug -eq "$True") { DBVariables }
<# Draw the menu outline now. #>
Clear-Host
Write-Host $NormalLine
Write-Host $FancyLine
Write-Host $TitleLine
Write-Host $FancyLine
Write-Host $ProgramLine
[int]$i = 1
While ($i -le $a) { Write-Host $SpacerLine; $i++ }
<# Fill in the users menu options from file. #>
[int]$l = 5
[int]$c = 0
[int]$w = $col[0]
[int]$i = 1
[int]$work = ($linecount / 2)
While ($i -le $work) {
    if ($i -le $work) {
        $Line = (Get-Content $Fileini)[$c]
        $moo = $line -split "="
        [Console]::SetCursorPosition($w, $l)
        Write-host -NoNewLine "$ESC[31m[$ESC[97m$i$ESC[31m]$ESC[96m" $moo[1]
    }
    if ($i -eq $Row[0]) { [int]$l = 4; [int]$w = $Col[1]  }
    if ($i -eq $Row[1]) { [int]$l = 4; [int]$w = $Col[2]  }
    $i++
    $c++
    $c++
    $L++
}
<# Adding Built in menu options #>
[Console]::SetCursorPosition(0, $pa)
Write-Host $Menu1Line
Write-Host $SpacerLine
Write-Host $SpacerLine
Write-Host $SpacerLine
if ($ScriptRead -eq "$True") { Write-Host $ScriptLine }
else { Write-Host $NormalLine }
[int]$pa = ($pa + 5)
[Console]::SetCursorPosition(0, $pa)
[int]$l = ($pa - 4)
$d = @("A", "B", "C", "D", "E", "F", "G", "H", "Q")
$f = @("Run an EXE directly", "Reload BinMenu", "Run INI Maker", "Run a PowerShell console", "Edit INI, JSON and ps1", "Run VS Code (New IDE)", "Run a PS1 script", "System Information", "Quit BinMenu")
[int]$w = $Col[0]
[int]$c = 0
while ($c -le 8) {
    [Console]::SetCursorPosition($w, $l)
    [string]$tmp = $d[$c]
    Write-host -NoNewLine "$ESC[31m[$ESC[97m$tmp$ESC[31m]$ESC[95m" $f[$c]
    if ($c -eq 2) { [int]$l = ($l - 3); [int]$w = $Col[1] }
    if ($c -eq 5) { [int]$l = ($l - 3); [int]$w = $Col[2] }
    $l++
    $c++
}
[Console]::SetCursorPosition(0, $pa)
<# Reading In PowerShell Scripts IF $ScriptRead is $true #>
if ($scriptRead -eq "$True") {
    $cmd1 = "$ESC[92m[$ESC[97m"
    $cmd3 = "$ESC[92m]"
    if ($SortMethod -eq 0) { Get-ChildItem -file $Base -Filter *.ps1| ForEach-Object { [string]$_ -Replace ".ps1", ""} | Sort-Object | ForEach-Object { ($cmd1 + $_ + $cmd3) } |  Out-File $Filetmp }
    if ($SortMethod -eq 1) { Get-ChildItem -file $Base -Filter *.ps1| ForEach-Object { [string]$_ -Replace ".ps1", ""} | Get-Random -Count "1000" | ForEach-Object { ($cmd1 + $_ + $cmd3) } |  Out-File $Filetmp }
    if ($SortMethod -eq 2) { Get-ChildItem -file $Base -Filter *.ps1| ForEach-Object { [string]$_ -Replace ".ps1", ""} | Sort-Object length | ForEach-Object { ($cmd1 + $_ + $cmd3) } |  Out-File $Filetmp }
    [int]$roll = @(Get-Content -Path $Filetmp).Count
    if ($ExtraLine -gt 0) { $roll = ($roll + $ExtraLine) }
    [int]$tmp = ($roll / $SPLine)
    [int]$tmp = [int][Math]::Ceiling($tmp)
    [int]$w = 0
    [int]$l = $pa
    [int]$i = 1
    if ($ExtraLine -gt 0) {
        [int]$tmp = ($tmp + $ExtraLine)
       #[int]$pa = ($pa + $ExtraLine)
    }
    [Console]::SetCursorPosition($w, $l)
    While ($i -le $tmp) { Write-Host $SpacerLine; $i++ }
    [int]$pa = ($pa + $tmp)
    [int]$i = 0
    [int]$w = $col[0]
    [int]$c = 0
    [int]$t = 1
    [Console]::SetCursorPosition($w, $pa)
    if ($SortDir -eq "HORZ") {
        while ($i -lt $roll) {
            while ($t -le $tmp) {
                $t++
                [int]$c = 1
                $UserScripts = ""
                while ($c -le $SPLine) {
                    $LineR = [string](Get-Content $Filetmp)[$i]
                    $i++
                    $UserScripts = ($UserScripts + $LineR)
                    $c++
                }
                [Console]::SetCursorPosition($w, $l)
                Write-host -NoNewLine "$ESC[31m[$ESC[92mPS1$ESC[31m]$ESC[92m" $UserScripts
                $l++
            }
        }
    }
    if ($SortDir -eq "VERT") {
        [int]$Vline = $tmp
        [int]$tmp = ($roll / $tmp)
        [int]$i = 0
        [int]$w = $col[0]
        [int]$c = 0
        [int]$t = 1
        [int]$d = 1
        If ($DBug -eq "$True") { DBVariables }
        while ($i -lt $roll) {
            while ($d -le $Vline) {
                $d++
                $LineV = [string](Get-Content $Filetmp)[$i]
                [Console]::SetCursorPosition($w, $l)
                Write-host -NoNewLine $LineV
                $i++
                $l++
                if ($LineV.length -gt $c) { $c = $lineV.length }
                if ($d -eq ($Vline + 1)) {
                    if ($LineV.length -gt $c) { $c = $lineV.length }
                    [int]$w = ($w + $c - 15)
                    [int]$l = ($l - $Vline)
                    if ($i -lt $roll) { [int]$d = 1 }
                    $c = ""
                }
            }
        }
    }
}
<# Here i do the cleanup and reorder math #>
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
[int]$w = 0
<# Then we draw the last line on the Menu id $ScriptRead is $True #>
if ($ScriptRead -eq $true) {
    [Console]::SetCursorPosition(0, $pa)
    Write-Host $NormalLine
    $pa++
}
$FixLine
<# All done fucking around now we just line up the tasks and work #>
<# Now we do the Menu trigger, sorta functions and all the triggers #>
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
Function FixLine {
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa)
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, ($pa + 1))
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, ($pa + 2))
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, ($pa + 3))
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa)
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa)
}
FixLine
<# Here We do the Administrator overlay #>
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    [Console]::SetCursorPosition(78, 1)
    Write-host -NoNewLine "$ESC[96m[$ESC[33mAdministrator$ESC[96m]$ESC[31m"
    [Console]::SetCursorPosition(0, $pa)
}
<# Version Add Area #>
[Console]::SetCursorPosition(10, 1)
Write-host -NoNewLine "$ESC[96m[$ESC[33m$FileVersion$ESC[36m]$ESC[31m"
[Console]::SetCursorPosition(0, $pa)
Fixline
$menu = "$ESC[31m[$ESC[97mMake A Selection$ESC[31m]$ESC[97m"
Function Invoke-Menu {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $True, HelpMessage = "I have no idea how to help you.")]
        [ValidateNotNullOrEmpty()]
        [string]$Menu,
        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [Alias("cls")]
        [switch]$ClearScreen
    )
    $menuPrompt += $menu
    FixLine
    Read-Host -Prompt $menuprompt
}
Function MyMaker {
    Clear-Host
    <# Setting up INI File.#>
    $Filetest = Test-Path -path $FileINI
    if ($Filetest -eq $true) { Remove-Item –path $FileINI }
    $FileTXT = ("$Base" + "BinMenu.txt")
    $Filetest = Test-Path -path $FileTXT
    if ($Filetest -eq $true) { Remove-Item –path $FileTXT }
    $FileCSv = ("$Base" + "BinMenu.csv")
    $Filetest = Test-Path -path $FileCSV
    if ($Filetest -eq $true) { Remove-Item –path $FileCSV }
    <# Reads in all valid (runable exe ) entries from your base folder. #>
    Write-host $fileVersion "Reading in directory" $Base
    Get-ChildItem -Path "$Base" -Recurse -Include *.exe | Select-Object `
    @{ n = 'Foldername'; e = { ($_.PSPath -split '[\\]')[3] } } ,
    Name,
    FullName ` | Export-Csv -path $FileTXT -NoTypeInformation
    Write-host "Writing raw files info, Reread and sorting file names, Exporting all file names"
    Import-Csv -Path $FileTXT | Sort-Object -Property "Foldername" | Export-Csv -NoTypeInformation $FileCSV
    $writer = [System.IO.file]::CreateText($FileINI)
    [int]$i = 1
    try {
        Import-Csv $Filecsv | Foreach-Object {
            $tmpname = [Regex]::Escape($_.fullname)
            if ($tmpname -match "git" -and $tmpname -ne "c:\\bin\\git\\bin\\bash\.exe") { return }
            if ($tmpname -match "wscc" -and $tmpname -ne "C:\\bin\\wscc\\wscc\.exe") { return }
            $tmpname = $_.name -replace "\\", ""
            if ($tmpname -eq "Totalcmd64.exe") { $tmpname = "Total Commander.exe" }
            $NameFix = $tmpname
            $NameFix = $NameFix.tolower()
            $NameFix = $NameFix.substring(0, 1).toupper() + $NameFix.substring(1)
            $Decidep = "Add to BinMenu [" + $_.fullname + "][" + $NameFix + "(Y N)[Enter is No]"
            $Decide = Read-Host -Prompt $Decidep
            if ($Decide -eq "Y") {
                $NameFix = $NameFix.replace(".exe", "")
                Write-Host "Adding to Menu: " $NameFix
                $Writer.WriteLine("[" + $i + "A]=" + $NameFix)
                $Writer.WriteLine("[" + $i + "B]=" + $_.fullname)
                $i++
                return
            }
            else { return }
        }
    }
    finally { $writer.close() }
    Write-Host "Done Writing EXE files to the Menu ini."
    Write-Host ""
    $Filetest = Test-Path -path $FileTXT
    if ($Filetest -eq $true) { Remove-Item –path $FileTXT }
    $Filetest = Test-Path -path $FileCSV
    if ($Filetest -eq $true) { Remove-Item –path $FileCSV }
}
if ($NoINI) {
    [bool]$NoINI = $False
    MyMaker
}
Function TheCommand {
    Param([string]$IntCom)
    if ($IntCom -eq "") {
        Write-Error "Error In Sent Param " + $IntCom
        Write-Error $_
        return
    }
    $moo = (Select-String -Pattern $IntCom $Fileini)
    $cow = $moo -split "="
    #Write-Host ($cow[1])
    #Write-Host ((Get-Item $cow[1]) -is [System.IO.DirectoryInfo] -eq $true)
    #$pop = Read-host -prompt "[Enter]"
    if ((Get-Item $cow[1]) -is [System.IO.DirectoryInfo] -eq $true) { Invoke-Item $cow[1] }
    else { Start-Process $cow[1] -Verb RunAs }
}
Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "A" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mWhat EXE to run? $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                #FixCommand -IntLet $cmd -UpCk "EXE"
                $cmd1 = $cmd -replace ".exe", ""
                $tcmd = ".exe"
                $cmd = "$cmd1$tcmd"
                Start-Process "$cmd" -Verb RunAs
                FixLine
            }
        }
        "B" { Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "C" { FixLine; MyMaker; Clear-Host; Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "D" { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        "E" {
            FixLine
            Start-Process $editor -ArgumentList "$FileINI $ConfigFile c:\bin\BinMenu.ps1" -Verb RunAs
            FixLine
        }
        "F" { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        "G" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mWhat script to run? $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                $cmd = $cmd -split " "
                if ($cmd.count -gt 1) {
                    $cmd1 = $cmd[0]
                    $cmd = $cmd.trimstart($cmd1)
                    $tcmd = ".ps1"
                    $cmd1 = "$cmd1$tcmd"
                    $cmd = "$cmd1 $cmd"
                }
                else {
                    $cmd = $cmd -replace ".ps1", ""
                    $tcmd = ".ps1"
                    $cmd = "$cmd$tcmd"
                }
                start-Process "pwsh.exe" -Argumentlist $cmd -Verb RunAs
                FixLine
            }
            FixLine
        }
        "H" { Start-Process "pwsh.exe" "c:\bin\Get-SysInfo.ps1" -Verb RunAs; FixLine }
        "Q" { Clear-Host; Return }
        "R" { Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "1" { FixLine; TheCommand -IntCom "1B" ; FixLine }
        "2" { FixLine; TheCommand -IntCom "2B" ; FixLine }
        "3" { FixLine; TheCommand -IntCom "3B" ; FixLine }
        "4" { FixLine; TheCommand -IntCom "4B" ; FixLine }
        "5" { FixLine; TheCommand -IntCom "5B" ; FixLine }
        "6" { FixLine; TheCommand -IntCom "6B" ; FixLine }
        "7" { FixLine; TheCommand -IntCom "7B" ; FixLine }
        "8" { FixLine; TheCommand -IntCom "8B" ; FixLine }
        "9" { FixLine; TheCommand -IntCom "9B" ; FixLine }
        "10" { FixLine; TheCommand -IntCom "10B" ; FixLine }
        "11" { FixLine; TheCommand -IntCom "11B" ; FixLine }
        "12" { FixLine; TheCommand -IntCom "12B" ; FixLine }
        "13" { FixLine; TheCommand -IntCom "13B" ; FixLine }
        "14" { FixLine; TheCommand -IntCom "14B" ; FixLine }
        "15" { FixLine; TheCommand -IntCom "15B" ; FixLine }
        "16" { FixLine; TheCommand -IntCom "16B" ; FixLine }
        "17" { FixLine; TheCommand -IntCom "17B" ; FixLine }
        "18" { FixLine; TheCommand -IntCom "18B" ; FixLine }
        "19" { FixLine; TheCommand -IntCom "19B" ; FixLine }
        "20" { FixLine; TheCommand -IntCom "20B" ; FixLine }
        "21" { FixLine; TheCommand -IntCom "21B" ; FixLine }
        "22" { FixLine; TheCommand -IntCom "22B" ; FixLine }
        "23" { FixLine; TheCommand -IntCom "23B" ; FixLine }
        "24" { FixLine; TheCommand -IntCom "24B" ; FixLine }
        "25" { FixLine; TheCommand -IntCom "25B" ; FixLine }
        "26" { FixLine; TheCommand -IntCom "26B" ; FixLine }
        "27" { FixLine; TheCommand -IntCom "27B" ; FixLine }
        "28" { FixLine; TheCommand -IntCom "28B" ; FixLine }
        "29" { FixLine; TheCommand -IntCom "29B" ; FixLine }
        "30" { FixLine; TheCommand -IntCom "30B" ; FixLine }
        "31" { FixLine; TheCommand -IntCom "31B" ; FixLine }
        "32" { FixLine; TheCommand -IntCom "32B" ; FixLine }
        "33" { FixLine; TheCommand -IntCom "33B" ; FixLine }
        "34" { FixLine; TheCommand -IntCom "34B" ; FixLine }
        "35" { FixLine; TheCommand -IntCom "35B" ; FixLine }
        "36" { FixLine; TheCommand -IntCom "36B" ; FixLine }
        "37" { FixLine; TheCommand -IntCom "37B" ; FixLine }
        "38" { FixLine; TheCommand -IntCom "38B" ; FixLine }
        "39" { FixLine; TheCommand -IntCom "39B" ; FixLine }
        "40" { FixLine; TheCommand -IntCom "40B" ; FixLine }
        "41" { FixLine; TheCommand -IntCom "41B" ; FixLine }
        "42" { FixLine; TheCommand -IntCom "42B" ; FixLine }
        "43" { FixLine; TheCommand -IntCom "43B" ; FixLine }
        "44" { FixLine; TheCommand -IntCom "44B" ; FixLine }
        "45" { FixLine; TheCommand -IntCom "45B" ; FixLine }
        "46" { FixLine; TheCommand -IntCom "46B" ; FixLine }
        "47" { FixLine; TheCommand -IntCom "47B" ; FixLine }
        "48" { FixLine; TheCommand -IntCom "48B" ; FixLine }
        "49" { FixLine; TheCommand -IntCom "49B" ; FixLine }
        "50" { FixLine; TheCommand -IntCom "50B" ; FixLine }
        "51" { FixLine; TheCommand -IntCom "51B" ; FixLine }
        "52" { FixLine; TheCommand -IntCom "52B" ; FixLine }
        "53" { FixLine; TheCommand -IntCom "53B" ; FixLine }
        "54" { FixLine; TheCommand -IntCom "54B" ; FixLine }
        "55" { FixLine; TheCommand -IntCom "55B" ; FixLine }
        "56" { FixLine; TheCommand -IntCom "56B" ; FixLine }
        "57" { FixLine; TheCommand -IntCom "57B" ; FixLine }
        "58" { FixLine; TheCommand -IntCom "58B" ; FixLine }
        "59" { FixLine; TheCommand -IntCom "59B" ; FixLine }
        "60" { FixLine; TheCommand -IntCom "60B" ; FixLine }
        "61" { FixLine; TheCommand -IntCom "61B" ; FixLine }
        "62" { FixLine; TheCommand -IntCom "62B" ; FixLine }
        "63" { FixLine; TheCommand -IntCom "63B" ; FixLine }
        "64" { FixLine; TheCommand -IntCom "64B" ; FixLine }
        "65" { FixLine; TheCommand -IntCom "65B" ; FixLine }
        "66" { FixLine; TheCommand -IntCom "66B" ; FixLine }
        "67" { FixLine; TheCommand -IntCom "67B" ; FixLine }
        "68" { FixLine; TheCommand -IntCom "68B" ; FixLine }
        "69" { FixLine; TheCommand -IntCom "69B" ; FixLine }
        "70" { FixLine; TheCommand -IntCom "70B" ; FixLine }
        "71" { FixLine; TheCommand -IntCom "71B" ; FixLine }
        "72" { FixLine; TheCommand -IntCom "72B" ; FixLine }
        "73" { FixLine; TheCommand -IntCom "73B" ; FixLine }
        "74" { FixLine; TheCommand -IntCom "74B" ; FixLine }
        "75" { FixLine; TheCommand -IntCom "75B" ; FixLine }
        "76" { FixLine; TheCommand -IntCom "76B" ; FixLine }
        "77" { FixLine; TheCommand -IntCom "77B" ; FixLine }
        "78" { FixLine; TheCommand -IntCom "78B" ; FixLine }
        "79" { FixLine; TheCommand -IntCom "79B" ; FixLine }
        "80" { FixLine; TheCommand -IntCom "80B" ; FixLine }
        "81" { FixLine; TheCommand -IntCom "81B" ; FixLine }
        "82" { FixLine; TheCommand -IntCom "82B" ; FixLine }
        "83" { FixLine; TheCommand -IntCom "83B" ; FixLine }
        "84" { FixLine; TheCommand -IntCom "84B" ; FixLine }
        "85" { FixLine; TheCommand -IntCom "85B" ; FixLine }
        "86" { FixLine; TheCommand -IntCom "86B" ; FixLine }
        "87" { FixLine; TheCommand -IntCom "87B" ; FixLine }
        "88" { FixLine; TheCommand -IntCom "88B" ; FixLine }
        "89" { FixLine; TheCommand -IntCom "89B" ; FixLine }
        "90" { FixLine; TheCommand -IntCom "90B" ; FixLine }
        "91" { FixLine; TheCommand -IntCom "91B" ; FixLine }
        "92" { FixLine; TheCommand -IntCom "92B" ; FixLine }
        "93" { FixLine; TheCommand -IntCom "93B" ; FixLine }
        "94" { FixLine; TheCommand -IntCom "94B" ; FixLine }
        "95" { FixLine; TheCommand -IntCom "95B" ; FixLine }
        "96" { FixLine; TheCommand -IntCom "96B" ; FixLine }
        "97" { FixLine; TheCommand -IntCom "97B" ; FixLine }
        "98" { FixLine; TheCommand -IntCom "98B" ; FixLine }
        "99" { FixLine; TheCommand -IntCom "99B" ; FixLine }
        Default {
            FixLine
            Write-Host -NoNewLine "Sorry, that is not an option. Feel free to try again."
            Start-Sleep -milliseconds 1500
            FixLine
        }
    } #switch
} While ($True)
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
