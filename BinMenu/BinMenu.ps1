<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 11, 2018
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created by it's companion script BinMenuRW.ps1.
.EXAMPLE
        BinMenu.ps1 -Base [<PathToAFolder>]
.NOTES
        Still under development.
#>
param([string]$Base)
$FileVersion = "0.3.1"
Function Get-ScriptDir {
    Split-Path -parent $PSCommandPath
}
Clear-Host
<# Set The BASE folder here or the script will use current by default #>
$Base = "C:\bin"
if ($Base -eq "") { $Base = Get-ScriptDir }
$tmp = $base.lenght
if ($($base.substring($tmp)) -ne "\") { $base = $base + "\" }
$Fileini = "$Base" + "BinMenu.ini"
$Filetest = Test-Path -path $Fileini
if ($Filetest -ne $true) {
    Write-Host "The File $Fileini missing. Can ot continue."
    Write-Host "Running BinMenuRW.ps1 file creator"
    Start-Process pwsh.exe "BinMenuRW.ps1" -Make $True
    return
    break
}
$Filetmp = "$Base" + "\BinTemp.del"
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
Set-Location $Base
$ESC = [char]27
$NormalLine = "$ESC[31m#=====================================================================================================#$ESC[97m"
$FancyLine = "$ESC[31m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[97m"
$TitleLine = "$ESC[31m#======================================<$ESC[96m[ $ESC[97mMy Bin Folder Menu $ESC[96m]$ESC[31m>=======================================#$ESC[97m"
$SpacerLine = "$ESC[31m|                                                                                                     $ESC[31m|$ESC[97m"
$LineCount = 0
try {
    $Reader = New-Object IO.StreamReader $Fileini
    while ($null -ne $Reader.ReadLine()) { $LineCount++ }
}
Finally { $Reader.Close() }
<# Setting up positioning #>
$temp = [int]($LineCount / 2)
$a = [int]($temp / 3)
$temp = [int]($a)
$b = [int]($temp * 2)
$c = [int]($LineCount / 2)
$Row = @($a, $b, $c)
$Col = @(1, 34, 68)
$pa = ($a + 5)
<# Draw the menu outline now. #>
Clear-Host
Write-Host $NormalLine
Write-Host $FancyLine
Write-Host $TitleLine
Write-Host $FancyLine
Write-Host $NormalLine
$i = 1
While ($i -le $a) { Write-Host $SpacerLine; $i++ }
<# Fill in the users menu options from file. #>
$l = 5
$c = 0
$w = 1
$i = 1
$work = [int]($linecount / 2)
While ($i -le $work) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[31m[$ESC[97m$i$ESC[31m]$ESC[96m" $moo[1]
    if ($i -eq $Row[0]) {$l = [int]4; $w = [int]$Col[1]  }
    if ($i -eq $Row[1]) {$l = [int]4; $w = [int]$Col[2]  }
    $i++
    $c++
    $c++
    $L++
}
<# Adding Built in menu options #>
[Console]::SetCursorPosition(0, $pa)
Write-Host $NormalLine
Write-Host $SpacerLine
Write-Host $SpacerLine
Write-Host $SpacerLine
Write-Host $NormalLine
$pa = $($pa + 5)
[Console]::SetCursorPosition(0, $pa)
$l = $($pa - 4)
$d = @("E", "R", "Q", "W", "P", "C", "S", "A", "I")
$f = @("Run an EXE directly", "Reload BinMenu", "Quit BinMenu", "Run BinMenuRW", "Run a PowerShell console", "Run VS Code (New IDE) ", "Run a PS1 script", "Alarm Clock", "System Information")
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
<#
 This whole function below needs to be re-written because it SUCKS
#>
[Console]::SetCursorPosition(0, $pa)
<# Reading In PowerShell Scripts #>
$cmd1 = "$ESC[92m[$ESC[97m"
#$cmd2 = "$ESC[92m][$ESC[97m"
$cmd3 = "$ESC[92m]"
Get-ChildItem -file $Base -Filter *.ps1| ForEach-Object { [string]$_ -Replace ".ps1", ""} | Sort-Object | ForEach-Object { ($cmd1 + $_ + $cmd3) } |  Out-File $Filetmp
$roll = @(Get-Content -Path $Filetmp).Count
$tmp = [int]($roll / 8)
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
while ($i -le $roll) {
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

<# Here i do the cleanup and reorder math #>
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
$w = 0
<# Then we draw the last line on the Menu #>
[Console]::SetCursorPosition(0, $pa)
Write-Host $NormalLine
$pa++
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
<# Here We do the infomation overlays #>
<# Administrator Add Area #>
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    [Console]::SetCursorPosition(78, 1)
    Write-host -NoNewLine "$ESC[96m[$ESC[33mAdministrator$ESC[96m]$ESC[31m"
    [Console]::SetCursorPosition(0, $pa)
}
<# Version Add Area #>
$FV = ("Version: " + $FileVersion)
[Console]::SetCursorPosition(10, 1)
Write-host -NoNewLine "$ESC[96m[$ESC[33m$FV$ESC[36m]$ESC[31m"
[Console]::SetCursorPosition(0, $pa)
<# Menu Title Area #>
[Console]::SetCursorPosition(3, 4)
Write-host -NoNewLine "$ESC[96m[$ESC[33mProgram Menu$ESC[96m]$ESC[31m"
[Console]::SetCursorPosition(0, $pa)
[Console]::SetCursorPosition(3, 19)
Write-host -NoNewLine "$ESC[96m[$ESC[33mBuilt-in Menu$ESC[96m]$ESC[31m"
[Console]::SetCursorPosition(0, $pa)
[Console]::SetCursorPosition(3, 23)
Write-host -NoNewLine "$ESC[96m[$ESC[33mScripts List$ESC[96m]$ESC[31m"
[Console]::SetCursorPosition(0, $pa)
Fixline
$menu = "$ESC[31m[$ESC[97mMake a selection$ESC[31m]$ESC[97m"
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
#Function TheCommand {
#    [Parameter(Mandatory = $False, ParameterSetName = 'IntCom')]
#    [ValidateNotNullOrEmpty()]
#    $IntCom = $_
#    Write-Host $IntCom
#    $TC = (Select-String -Pattern $IntCom $Fileini)
#    $cmd = $TC -split "="
#    Start-Process $cmd[1] -Verb RunAs
#}
#TheCommand
Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "E" {
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
        "R" { Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "W" { Start-Process "pwsh.exe" "c:\bin\BinMenuRW.ps1" -Verb RunAs; Clear-Host; return }
        "C" { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        "P" { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        "Q" { Clear-Host; Return }
        "S" {
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
        "A" { Start-Process "pwsh.exe" "c:\bin\Alarm-Clock.ps1" -Verb RunAs; Clear-Host; return }
        "I" { Start-Process "pwsh.exe" "c:\bin\System-Info.ps1" -Verb RunAs; Clear-Host; return }
        "1" { FixLine; $Line2 = (Select-String -Pattern "1B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "2" { FixLine; $Line2 = (Select-String -Pattern "2B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "3" { FixLine; $Line2 = (Select-String -Pattern "3B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "4" { FixLine; $Line2 = (Select-String -Pattern "4B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "5" { FixLine; $Line2 = (Select-String -Pattern "5B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "6" { FixLine; $Line2 = (Select-String -Pattern "6B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "7" { FixLine; $Line2 = (Select-String -Pattern "7B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "8" { FixLine; $Line2 = (Select-String -Pattern "8B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "9" { FixLine; $Line2 = (Select-String -Pattern "9B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "10" { FixLine; $Line2 = (Select-String -Pattern "10B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "11" { FixLine; $Line2 = (Select-String -Pattern "11B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "12" { FixLine; $Line2 = (Select-String -Pattern "12B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "13" { FixLine; $Line2 = (Select-String -Pattern "13B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "14" { FixLine; $Line2 = (Select-String -Pattern "14B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "15" { FixLine; $Line2 = (Select-String -Pattern "15B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "16" { FixLine; $Line2 = (Select-String -Pattern "16B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "17" { FixLine; $Line2 = (Select-String -Pattern "17B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "18" { FixLine; $Line2 = (Select-String -Pattern "18B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "19" { FixLine; $Line2 = (Select-String -Pattern "19B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "20" { FixLine; $Line2 = (Select-String -Pattern "20B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "21" { FixLine; $Line2 = (Select-String -Pattern "21B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "22" { FixLine; $Line2 = (Select-String -Pattern "22B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "23" { FixLine; $Line2 = (Select-String -Pattern "23B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "24" { FixLine; $Line2 = (Select-String -Pattern "24B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "25" { FixLine; $Line2 = (Select-String -Pattern "25B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "26" { FixLine; $Line2 = (Select-String -Pattern "26B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "27" { FixLine; $Line2 = (Select-String -Pattern "27B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "28" { FixLine; $Line2 = (Select-String -Pattern "28B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "29" { FixLine; $Line2 = (Select-String -Pattern "29B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "30" { FixLine; $Line2 = (Select-String -Pattern "30B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "31" { FixLine; $Line2 = (Select-String -Pattern "31B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "32" { FixLine; $Line2 = (Select-String -Pattern "32B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "33" { FixLine; $Line2 = (Select-String -Pattern "33B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "34" { FixLine; $Line2 = (Select-String -Pattern "34B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "35" { FixLine; $Line2 = (Select-String -Pattern "35B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "36" { FixLine; $Line2 = (Select-String -Pattern "36B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "37" { FixLine; $Line2 = (Select-String -Pattern "37B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "38" { FixLine; $Line2 = (Select-String -Pattern "38B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "39" { FixLine; $Line2 = (Select-String -Pattern "39B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "40" { FixLine; $Line2 = (Select-String -Pattern "40B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "41" { FixLine; $Line2 = (Select-String -Pattern "41B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "42" { FixLine; $Line2 = (Select-String -Pattern "42B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
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
