<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 24, 2018
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created by it's companion script BinMenuRW.ps1.
.EXAMPLE
        BinMenu.ps1 -Base [<PathToAFolder>]
.NOTES
        Still under development.
#>
param([string]$Base)
$FileVersion = "Version: 0.6.0"
Function Get-ScriptDir {
    Split-Path -parent $PSCommandPath
}
Function MyConfig {
    $tmp = (Split-Path -parent $PSCommandPath) + "\" + (Split-Path -leaf $PSCommandPath)
    $tmp = ($tmp -replace ".ps1", ".json")
    $tmp
}
$ConfigFile = MyConfig
try { $Config = Get-Content "$ConfigFile" -Raw | ConvertFrom-Json }
catch { Write-Error -Message "The Base configuration file is missing!" -Stop }
if (!($Config)) { Write-Error -Message "The Base configuration file is missing!" -Stop }
<# #[Set-ConWin]#[Window Resizer]# #>
$tmpHeight = 40
$tmpWidth = 104
if ($tmpWidth -eq "") { $tmpWidth = 107 }
if ($tmpHeight -eq "") { $tmpHeight = 45 }
$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.buffersize
$newsize.height = 2000
$tmp = ($tmpWidth * 2)
$newsize.width = $tmp
$pswindow.buffersize = $newsize
$newsize = $pswindow.windowsize
$newsize.height = $tmpHeight
$newsize.width = $tmpWidth
$pswindow.windowsize = $newsize
Clear-Host
$Base = [String]($Config.basic.Base)
if ($Base -eq "") {
    Write-Error "Config Read did not work out. Using current folder."
    Start-Sleep-s 5
    $Base = Get-ScriptDir
}
$tmp = $base.length
if ($base.substring(($tmp - 1)) -ne "\") { $base = $base + "\" }
$Fileini = "$Base" + "BinMenu.ini"
$Filetmp = "$Base" + "BinTemp.del"
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
Set-Location $Base
$IAmWho = $env:USERDOMAIN
$Editor = [string]($Config.basic.Editor)
$ScriptRead = [bool]($Config.basic.ScriptRead)
$MenuAdds = [bool]($Config.basic.MenuAdds)
$AddCount = [int]($Config.AddItems.count)
Function DBFiles {
    Write-Host "Configfile: " $ConfigFile
    Write-Host "Config " $config
    Write-Host "FileVersion " $FileVersion
    Write-Host "Base " $Base
    Write-Host "ScriptRead " $ScriptRead
    Write-Host "MenuAdds " $MenuAdds
    Write-Host "Fileini " $Fileini
    Write-Host "FileTmp " $filetmp
    Write-Host "Editor " $Editor
    Write-Host "AddCount " $AddCount
    Write-Host ($Config.AddItems[0].command)
    $pop = Read-host -prompt "[Enter]"
    #break
}
#DBFiles
$ESC = [char]27
$host.ui.RawUI.WindowTitle = "BinMenu v.$FileVersion on $IAmWho"
$Filetest = Test-Path -path $Fileini
if ($Filetest -ne $true) {
    Write-Host "The File $Fileini is missing. We Can not continue without it."
    Write-Host "We are going to run the INI creator function now"
    Read-Host -Prompt "[Enter to continue]"
    $NoINI = $true
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
$LineCount = 0
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
    $k = $($Config.AddItems[0].name)
    $t = $(Select-String -Pattern $k $Fileini)
    if ($null -eq $t) {
        $J = 0
        while ($j -le ($AddCount - 1)) {
            $value1 = "[" + $temp2 + "A]=" + [string]($Config.AddItems[$j].name)
            (Add-Content $fileini $value1)[$temp1]
            $temp1++
            $value2 = "[" + $temp2 + "B]=" + [string]($Config.AddItems[$j].command)
            (Add-Content $fileini $value2)[$temp1]
            $temp1++; $j++; $Temp2++
        }
    }
}
$LineCount = 0
try {
    $Reader = New-Object IO.StreamReader $Fileini
    while ($null -ne $Reader.ReadLine()) { $LineCount++ }
}
Finally { $Reader.Close() }
<# Setting up positioning #>
$temp = [int]($LineCount / 2)
$a = ($temp / 3)
$a = [int][Math]::Ceiling($a)
$temp = [int]($a)
$b = [int]($temp * 2)
$c = [int]($LineCount / 2)
$Row = @($a, $b, $c)
$Col = @(1, 34, 68)
$pa = ($a + 5)
Function DBVariables {
    Write-host "Linecount" $linecount
    Write-host "A" $a
    Write-host "Temp" $temp
    Write-host "B" $b
    Write-host "C" $c
    Write-host "Row" $row
    $pop = Read-host -prompt "[Enter]"
    #break
}
#DBVariables
<# Draw the menu outline now. #>
Clear-Host
Write-Host $NormalLine
Write-Host $FancyLine
Write-Host $TitleLine
Write-Host $FancyLine
Write-Host $ProgramLine
$i = 1
While ($i -le $a) { Write-Host $SpacerLine; $i++ }
<# Fill in the users menu options from file. #>
$l = 5
$c = 0
$w = 1
$i = 1
$work = [int]($linecount / 2)
While ($i -le $work) {
    if ($i -le $work) {
        $Line = (Get-Content $Fileini)[$c]
        $moo = $line -split "="
        [Console]::SetCursorPosition($w, $l)
        Write-host -NoNewLine "$ESC[31m[$ESC[97m$i$ESC[31m]$ESC[96m" $moo[1]
    }
    if ($i -eq $Row[0]) {$l = [int]4; $w = [int]$Col[1]  }
    if ($i -eq $Row[1]) {$l = [int]4; $w = [int]$Col[2]  }
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
$pa = $($pa + 5)
[Console]::SetCursorPosition(0, $pa)
$l = $($pa - 4)
$d = @("A", "B", "C", "D", "E", "F", "G", "H", "Q")
$f = @("Run an EXE directly", "Reload BinMenu", "Run INI Maker", "Run a PowerShell console", "Edit INI and JSON", "Run VS Code (New IDE)", "Run a PS1 script", "System Information", "Quit BinMenu")
$w = [int]$Col[0]
$c = 0
while ($c -le 8) {
    [Console]::SetCursorPosition($w, $l)
    $tmp = $d[$c]
    Write-host -NoNewLine "$ESC[31m[$ESC[97m$tmp$ESC[31m]$ESC[95m" $f[$c]
    if ($c -eq 2) { $l = [int]($l - 3); $w = [int]$Col[1] }
    if ($c -eq 5) { $l = [int]($l - 3); $w = [int]$Col[2] }
    $l++
    $c++
}
[Console]::SetCursorPosition(0, $pa)
<# Reading In PowerShell Scripts IF $ScriptRead is $true #>
if ($scriptRead -eq "$true") {
    $cmd1 = "$ESC[92m[$ESC[97m"
    $cmd3 = "$ESC[92m]"
    Get-ChildItem -file $Base -Filter *.ps1| ForEach-Object { [string]$_ -Replace ".ps1", ""} | Sort-Object | ForEach-Object { ($cmd1 + $_ + $cmd3) } |  Out-File $Filetmp
    $roll = @(Get-Content -Path $Filetmp).Count
    $tmp = ($roll / 8)
    $tmp = [int][Math]::Ceiling($tmp)
    $w = 0
    $l = $pa
    $i = 1
    [Console]::SetCursorPosition($w, $l)
    While ($i -le $tmp) { Write-Host $SpacerLine; $i++ }
    $pa = ($pa + $tmp)
    $i = 0
    $w = 1
    $c = 0
    $t = 1
    [Console]::SetCursorPosition($w, $pa)
    while ($i -lt $roll) {
        while ($t -le $tmp) {
            $t++
            $c = 1
            $UserScripts = ""
            while ($c -le 8) {
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
<# Here i do the cleanup and reorder math #>
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
$w = 0
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
    $i = 1
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
    $NoINI = $false
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
    if (((Get-Item $cow[1]) -is [System.IO.DirectoryInfo]) -eq $True) {
        Invoke-Item $cow[1]
    }
    else { Start-Process $cow[1] -Verb RunAs }
}
Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "A" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mExact Command Line $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                if ($cmd -match "ps1") {
                    FixLine
                    $temp = $cmd -split ' '
                    $cmd = $cmd.trimstart($temp[0])
                    $cmd1 = $temp[0] -replace '.ps1', ''
                    $tmp = ".ps1"
                    $cmd1 = $($cmd1 + $tmp)
                    Start-Process "pwsh.exe" -Argumentlist "$cmd1 $cmd" -Verb RunAs
                    FixLine
                }
                else { Start-Process "$cmd" -Verb RunAs }
                FixLine
            }
            FixLine
        }
        "B" { Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "C" { FixLine; MyMaker; Clear-Host; Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "D" { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        "E" {
             FixLine
             $tmp = "$FileINI $ConfigFile"
              Start-Process $editor -ArgumentList $tmp -Verb RunAs; FixLine
        }
        "F" { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        "G" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mWhat script to run? $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                $temp = $cmd -split ' '
                $cmd = $cmd.trimstart($temp[0])
                $cmd1 = $temp[0] -replace '.ps1', ''
                $tmp = ".ps1"
                $cmd1 = $($cmd1 + $tmp)
                Start-Process "pwsh.exe" -Argumentlist "$cmd1 $cmd" -Verb RunAs
                FixLine
            }
            FixLine
        }
        "H" { Start-Process "pwsh.exe" "c:\bin\Get-SysInfo.ps1" -Verb RunAs; FixLine }
        "Q" { Clear-Host; Return }
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
