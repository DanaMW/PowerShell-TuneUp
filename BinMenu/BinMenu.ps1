<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: September 03, 2018
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created by it's companion script BinMenuRW.ps1.
.EXAMPLE
        BinMenu.ps1 -Base [<PathToAFolder>]
.NOTES
        Still under development.
#>
$FileVersion = "Version: 0.7.5"
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
[string]$ConfigFile = MyConfig
try {
    $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
}
catch {
    Write-Error -Message "The Base configuration file is missing!"
    break
}
if (!($Config)) {
    Write-Error -Message "The Base configuration file is missing!"
    break
}
<# #[Config File read in]# #>
[string]$Base = ($Config.basic.Base)
[string]$Editor = ($Config.basic.Editor)
[bool]$ScriptRead = ($Config.basic.ScriptRead)
[bool]$MenuAdds = ($Config.basic.MenuAdds)
[int]$SortMethod = ($Config.basic.SortMethod)
[string]$SortDir = ($Config.basic.SortDir)
[int]$ExtraLine = ($Config.basic.ExtraLine)
if ($SortDir -eq "VERT" -and $SortMethod -eq 1) { [int]$SortMethod = 0 }
[bool]$DBug = ($Config.basic.DBug)
[int]$SPLine = ($Config.basic.SPLine)
[bool]$WPosition = ($Config.basic.WPosition)
[int]$AddCount = ($Config.AddItems.count)
<# #[Set-ConWin]#[Window Resizer]# #>
if ($WPosition -eq "$True") {
    [int]$WinWidth = [int]($Config.basic.WinWidth)
    [int]$WinHeight = [int]($Config.basic.WinHeight)
    [int]$BuffWidth = [int]($Config.basic.BuffWidth)
    [int]$BuffHeight = [int]($Config.basic.BuffHeight)
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
    <# End of the Window size routine #>
}
Clear-Host
if ($Base -eq "") { [string]$Base = Get-ScriptDir }
if ($base.substring(($base.length - 1)) -ne "\") { [string]$base = $base + "\" }
[string]$Fileini = "$Base" + "BinMenu.ini"
[String]$Filetmp = "$Base" + "BinTemp.del"
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
Set-Location $Base
Function DBFiles {
    Write-Host "Configfile: " $ConfigFile
    Write-Host "Config: " $config
    Write-Host "FileVersio: " $FileVersion
    Write-Host "Base: " $Base
    Write-Host "ScriptRead: " $ScriptRead
    Write-Host "MenuAdds: " $MenuAdds
    Write-Host "Fileini: " $Fileini
    Write-Host "FileTmp: " $filetmp
    Write-Host "Editor: " $Editor
    Write-Host "AddCount: " $AddCount
    Write-Host "WinWidth: " $WinWidth
    Write-Host "WinHeight: " $WinHeight
    Write-Host "BuffWidth: " $BuffWidth
    Write-Host "BuffHeight: " $BuffHeight
    Write-Host "SortMethod: " $SortMethod
    Write-Host "SortDir: " $SortDir
    Write-Host "ExtraLine: " $ExtraLine
    Write-Host "WPosition: " $WPosition
    Write-Host "DBug: " $DBug
    Write-Host "Example: " ($Config.AddItems[0].name)
    Write-Host "Example: " ($Config.AddItems[0].command)
    Write-Host "Example: " ($Config.AddItems[0].argument)
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
[string]$NormalLine = "$ESC[31m#=====================================================================================================#$ESC[97m"
[string]$FancyLine = "$ESC[31m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[97m"
[string]$TitleLine = "$ESC[31m#======================================<$ESC[96m[$ESC[41m $ESC[97mMy Bin Folder Menu $ESC[40m$ESC[96m]$ESC[31m>=======================================#$ESC[97m"
[string]$SpacerLine = "$ESC[31m|                                                                                                     $ESC[31m|$ESC[97m"
[string]$ProgramLine = "$ESC[31m#$ESC[96m[$ESC[33mProgram Menu$ESC[96m]$ESC[31m=======================================================================================#$ESC[97m"
[string]$Menu1Line = "$ESC[31m#$ESC[96m[$ESC[33mBuilt-in Menu$ESC[96m]$ESC[31m======================================================================================#$ESC[97m"
[string]$ScriptLine = "$ESC[31m#$ESC[96m[$ESC[33mScripts List$ESC[96m]$ESC[31m=======================================================================================#$ESC[97m"
[int]$LineCount = 0
[int]$lineCount = (Get-content $Fileini).count
if ($MenuAdds -eq "$True") {
    Write-Host "Adding MenuAdds Items"
    [int]$temp = ($LineCount / 3)
    [int]$temp1 = ($temp - 1)
    [int]$temp2 = ($temp + 1)
    [int]$J = 0
    while ($j -le ($AddCount - 1)) {
        $k = $($Config.AddItems[$j].name)
        $t = $(Select-String -Pattern $k $Fileini)
        if ($null -eq $t) {
            [string]$value1 = "[" + $temp2 + "A]=" + ($Config.AddItems[$j].name)
            (Add-Content $fileini $value1)[$temp1]
            $temp1++
            [string]$value2 = "[" + $temp2 + "B]=" + ($Config.AddItems[$j].command)
            (Add-Content $fileini $value2)[$temp1]
            $temp1++
            [string]$value3 = "[" + $temp2 + "C]=" + ($Config.AddItems[$j].argument)
            (Add-Content $fileini $value3)[$temp1]
            $temp1++
            $Temp2++
        }
        $j++
    }
}
if ($MenuAdds -ne "$False") {
    Write-Host "Removing MenuAdds Items"
    $wow = ($Config.AddItems[0].name)
    if (($wow)) {
        $name = "=" + ($Config.AddItems[0].name)
        [int]$it = (Select-String -SimpleMatch $name $Fileini).linenumber
        if (($it)) {
            $it = ($it -1)
            $q = 0
            While ($q -lt $it) {
                $tr = (Get-Content $fileini)[$q]
                (Add-Content ./BinMenu.no $tr)
                $q++
            }
            Remove-Item $Fileini
            Rename-Item -Path ./BinMenu.no -NewName $fileini
        }
    }
}
[int]$LineCount = 0
[int]$lineCount = (Get-content $Fileini).count
<# Setting up positioning #>
$temp = ($LineCount / 3)
$a = ($temp / 3)
[int]$a = [int][Math]::Ceiling($a)
[int]$temp = $a
[int]$b = ($temp * 2)
[int]$c = ($LineCount / 3)
$Row = @($a, $b, $c)
$Col = @(1, 34, 69)
[int]$pa = ($a + 5)
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
[int]$work = ($linecount / 3)
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
$d = @("A", "B", "C", "D", "E", "F", "G", "Z", "Q")
$f = @("Run an EXE directly", "Reload BinMenu", "Run INI Maker", "Run a PowerShell console", "System Informatio", "Run VS Code (New IDE)", "Run a PS1 script", "Run Settings Manager", "Quit BinMenu")
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
    #[Console]::SetCursorPosition(0, ($pa + 3))
    #Write-Host -NoNewLine "                                                                                                       "
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
    Get-ChildItem -Path $Base -Recurse -Include "*.exe" | Select-Object `
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
                $AddArg = Read-Host -Prompt "Add an Arguement? Input it [Enter to Skip]"
                $Writer.WriteLine("[" + $i + "C]=" + $AddArg)
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
    Param([string]$IntCom, [string]$Argue)
    if (!($IntCom)) {
        Write-Error "Error In Sent Param " + $IntCom
        return
    }
    [string]$moo = (Select-String -SimpleMatch $IntCom $Fileini)
    $cow = $moo -split "="
    if ((Get-Item $cow[1]) -is [System.IO.DirectoryInfo] -eq $true) { Invoke-Item $cow[1] }
    else {
        [string]$car = (Select-String -SimpleMatch $Argue $Fileini)
        $bus = $car -split "="
        if (($bus[1])) { Start-Process $cow[1] -ArgumentList $bus[1] -Verb RunAs }
        else { Start-Process $cow[1] -Verb RunAs }
    }
}
Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "A" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mWhat EXE to run? $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                $cmd = $cmd -split " "
                if (($cmd.count) -gt 1) {
                    $cmd1 = $cmd[0]
                    $tcmd = ".exe"
                    $cmd1 = "$cmd1$tcmd"
                    $cmd = "$cmd1 $cmd"
                }
                else {
                    $cmd = $cmd -replace ".ps1", ""
                    $tcmd = ".exe"
                    $cmd = "$cmd$tcmd"
                }
                start-Process "pwsh.exe" -Argumentlist $cmd -Verb RunAs
                FixLine
            }
        }
        "B" { Start-Process "pwsh.exe" -ArgumentList "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "C" { FixLine; MyMaker; Clear-Host; Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "D" { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        "E" {
            FixLine
            Start-Process "pwsh.exe" -ArguMentList "c:\bin\Get-SysInfo.ps1" -Verb RunAs; FixLine
            FixLine
        }
        "F" { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        "G" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mWhat script to run? $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                $cmd = $cmd -split " "
                if (($cmd.count) -gt 1) {
                    $cmd1 = $cmd[0]
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
        "Q" { Clear-Host; Return }
        "R" { Start-Process "pwsh.exe" -ArgumentList "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "Z" { Start-Process "pwsh.exe" -ArgumentList "c:\bin\BMSM.ps1" -Verb RunAs; FixLine }
        "1" { FixLine; TheCommand -IntCom "[1B]" -Argue "[1C]" ; FixLine }
        "2" { FixLine; TheCommand -IntCom "[2B]" -Argue "[2C]" ; FixLine }
        "3" { FixLine; TheCommand -IntCom "[3B]" -Argue "[3C]" ; FixLine }
        "4" { FixLine; TheCommand -IntCom "[4B]" -Argue "[4C]" ; FixLine }
        "5" { FixLine; TheCommand -IntCom "[5B]" -Argue "[5C]" ; FixLine }
        "6" { FixLine; TheCommand -IntCom "[6B]" -Argue "[6C]" ; FixLine }
        "7" { FixLine; TheCommand -IntCom "[7B]" -Argue "[7C]" ; FixLine }
        "8" { FixLine; TheCommand -IntCom "[8B]" -Argue "[8C]" ; FixLine }
        "9" { FixLine; TheCommand -IntCom "[9B]" -Argue "[9C]" ; FixLine }
        "10" { FixLine; TheCommand -IntCom "[10B]" -Argue "[10C]" ; FixLine }
        "11" { FixLine; TheCommand -IntCom "[11B]" -Argue "[11C]" ; FixLine }
        "12" { FixLine; TheCommand -IntCom "[12B]" -Argue "[12C]" ; FixLine }
        "13" { FixLine; TheCommand -IntCom "[13B]" -Argue "[13C]" ; FixLine }
        "14" { FixLine; TheCommand -IntCom "[14B]" -Argue "[14C]" ; FixLine }
        "15" { FixLine; TheCommand -IntCom "[15B]" -Argue "[15C]" ; FixLine }
        "16" { FixLine; TheCommand -IntCom "[16B]" -Argue "[16C]" ; FixLine }
        "17" { FixLine; TheCommand -IntCom "[17B]" -Argue "[17C]" ; FixLine }
        "18" { FixLine; TheCommand -IntCom "[18B]" -Argue "[18C]" ; FixLine }
        "19" { FixLine; TheCommand -IntCom "[19B]" -Argue "[19C]" ; FixLine }
        "20" { FixLine; TheCommand -IntCom "[20B]" -Argue "[20C]" ; FixLine }
        "21" { FixLine; TheCommand -IntCom "[21B]" -Argue "[21C]" ; FixLine }
        "22" { FixLine; TheCommand -IntCom "[22B]" -Argue "[22C]" ; FixLine }
        "23" { FixLine; TheCommand -IntCom "[23B]" -Argue "[23C]" ; FixLine }
        "24" { FixLine; TheCommand -IntCom "[24B]" -Argue "[24C]" ; FixLine }
        "25" { FixLine; TheCommand -IntCom "[25B]" -Argue "[25C]" ; FixLine }
        "26" { FixLine; TheCommand -IntCom "[26B]" -Argue "[26C]" ; FixLine }
        "27" { FixLine; TheCommand -IntCom "[27B]" -Argue "[27C]" ; FixLine }
        "28" { FixLine; TheCommand -IntCom "[28B]" -Argue "[28C]" ; FixLine }
        "29" { FixLine; TheCommand -IntCom "[29B]" -Argue "[29C]" ; FixLine }
        "30" { FixLine; TheCommand -IntCom "[30B]" -Argue "[30C]" ; FixLine }
        "31" { FixLine; TheCommand -IntCom "[31B]" -Argue "[31C]" ; FixLine }
        "32" { FixLine; TheCommand -IntCom "[32B]" -Argue "[32C]" ; FixLine }
        "33" { FixLine; TheCommand -IntCom "[33B]" -Argue "[33C]" ; FixLine }
        "34" { FixLine; TheCommand -IntCom "[34B]" -Argue "[34C]" ; FixLine }
        "35" { FixLine; TheCommand -IntCom "[35B]" -Argue "[35C]" ; FixLine }
        "36" { FixLine; TheCommand -IntCom "[36B]" -Argue "[36C]" ; FixLine }
        "37" { FixLine; TheCommand -IntCom "[37B]" -Argue "[37C]" ; FixLine }
        "38" { FixLine; TheCommand -IntCom "[38B]" -Argue "[38C]" ; FixLine }
        "39" { FixLine; TheCommand -IntCom "[39B]" -Argue "[39C]" ; FixLine }
        "40" { FixLine; TheCommand -IntCom "[40B]" -Argue "[40C]" ; FixLine }
        "41" { FixLine; TheCommand -IntCom "[41B]" -Argue "[41C]" ; FixLine }
        "42" { FixLine; TheCommand -IntCom "[42B]" -Argue "[42C]" ; FixLine }
        "43" { FixLine; TheCommand -IntCom "[43B]" -Argue "[43C]" ; FixLine }
        "44" { FixLine; TheCommand -IntCom "[44B]" -Argue "[44C]" ; FixLine }
        "45" { FixLine; TheCommand -IntCom "[45B]" -Argue "[45C]" ; FixLine }
        "46" { FixLine; TheCommand -IntCom "[46B]" -Argue "[46C]" ; FixLine }
        "47" { FixLine; TheCommand -IntCom "[47B]" -Argue "[47C]" ; FixLine }
        "48" { FixLine; TheCommand -IntCom "[48B]" -Argue "[48C]" ; FixLine }
        "49" { FixLine; TheCommand -IntCom "[49B]" -Argue "[49C]" ; FixLine }
        "50" { FixLine; TheCommand -IntCom "[50B]" -Argue "[50C]" ; FixLine }
        "51" { FixLine; TheCommand -IntCom "[51B]" -Argue "[51C]" ; FixLine }
        "52" { FixLine; TheCommand -IntCom "[52B]" -Argue "[52C]" ; FixLine }
        "53" { FixLine; TheCommand -IntCom "[53B]" -Argue "[53C]" ; FixLine }
        "54" { FixLine; TheCommand -IntCom "[54B]" -Argue "[54C]" ; FixLine }
        "55" { FixLine; TheCommand -IntCom "[55B]" -Argue "[55C]" ; FixLine }
        "56" { FixLine; TheCommand -IntCom "[56B]" -Argue "[56C]" ; FixLine }
        "57" { FixLine; TheCommand -IntCom "[57B]" -Argue "[57C]" ; FixLine }
        "58" { FixLine; TheCommand -IntCom "[58B]" -Argue "[58C]" ; FixLine }
        "59" { FixLine; TheCommand -IntCom "[59B]" -Argue "[59C]" ; FixLine }
        "60" { FixLine; TheCommand -IntCom "[60B]" -Argue "[60C]" ; FixLine }
        "61" { FixLine; TheCommand -IntCom "[61B]" -Argue "[61C]" ; FixLine }
        "62" { FixLine; TheCommand -IntCom "[62B]" -Argue "[61C]" ; FixLine }
        "63" { FixLine; TheCommand -IntCom "[63B]" -Argue "[63C]" ; FixLine }
        "64" { FixLine; TheCommand -IntCom "[64B]" -Argue "[64C]" ; FixLine }
        "65" { FixLine; TheCommand -IntCom "[65B]" -Argue "[65C]" ; FixLine }
        "66" { FixLine; TheCommand -IntCom "[66B]" -Argue "[66C]" ; FixLine }
        "67" { FixLine; TheCommand -IntCom "[67B]" -Argue "[67C]" ; FixLine }
        "68" { FixLine; TheCommand -IntCom "[68B]" -Argue "[68C]" ; FixLine }
        "69" { FixLine; TheCommand -IntCom "[69B]" -Argue "[69C]" ; FixLine }
        "70" { FixLine; TheCommand -IntCom "[70B]" -Argue "[70C]" ; FixLine }
        "71" { FixLine; TheCommand -IntCom "[71B]" -Argue "[71C]" ; FixLine }
        "72" { FixLine; TheCommand -IntCom "[72B]" -Argue "[72C]" ; FixLine }
        "73" { FixLine; TheCommand -IntCom "[73B]" -Argue "[73C]" ; FixLine }
        "74" { FixLine; TheCommand -IntCom "[74B]" -Argue "[74C]" ; FixLine }
        "75" { FixLine; TheCommand -IntCom "[75B]" -Argue "[75C]" ; FixLine }
        "76" { FixLine; TheCommand -IntCom "[76B]" -Argue "[76C]" ; FixLine }
        "77" { FixLine; TheCommand -IntCom "[77B]" -Argue "[77C]" ; FixLine }
        "78" { FixLine; TheCommand -IntCom "[78B]" -Argue "[78C]" ; FixLine }
        "79" { FixLine; TheCommand -IntCom "[79B]" -Argue "[79C]" ; FixLine }
        "80" { FixLine; TheCommand -IntCom "[80B]" -Argue "[80C]" ; FixLine }
        "81" { FixLine; TheCommand -IntCom "[81B]" -Argue "[81C]" ; FixLine }
        "82" { FixLine; TheCommand -IntCom "[82B]" -Argue "[82C]" ; FixLine }
        "83" { FixLine; TheCommand -IntCom "[83B]" -Argue "[83C]" ; FixLine }
        "84" { FixLine; TheCommand -IntCom "[84B]" -Argue "[84C]" ; FixLine }
        "85" { FixLine; TheCommand -IntCom "[85B]" -Argue "[85C]" ; FixLine }
        "86" { FixLine; TheCommand -IntCom "[86B]" -Argue "[86C]" ; FixLine }
        "87" { FixLine; TheCommand -IntCom "[87B]" -Argue "[87C]" ; FixLine }
        "88" { FixLine; TheCommand -IntCom "[88B]" -Argue "[88C]" ; FixLine }
        "89" { FixLine; TheCommand -IntCom "[89B]" -Argue "[89C]" ; FixLine }
        "90" { FixLine; TheCommand -IntCom "[90B]" -Argue "[90C]" ; FixLine }
        "91" { FixLine; TheCommand -IntCom "[91B]" -Argue "[91C]" ; FixLine }
        "92" { FixLine; TheCommand -IntCom "[92B]" -Argue "[92C]" ; FixLine }
        "93" { FixLine; TheCommand -IntCom "[93B]" -Argue "[93C]" ; FixLine }
        "94" { FixLine; TheCommand -IntCom "[94B]" -Argue "[94C]" ; FixLine }
        "95" { FixLine; TheCommand -IntCom "[95B]" -Argue "[95C]" ; FixLine }
        "96" { FixLine; TheCommand -IntCom "[96B]" -Argue "[96C]" ; FixLine }
        "97" { FixLine; TheCommand -IntCom "[97B]" -Argue "[97C]" ; FixLine }
        "98" { FixLine; TheCommand -IntCom "[98B]" -Argue "[98C]" ; FixLine }
        "99" { FixLine; TheCommand -IntCom "[99B]" -Argue "[99B]" ; FixLine }
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
