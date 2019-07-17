<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: April, 2018
        Last Modified Date: July 17, 2019
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created Internally.
        Also has great Settings Manager, it's companion script BinSM.ps1.
.EXAMPLE
        BinMenu.ps1
.NOTES
        Still under development.
#>
$FileVersion = "Version: 2.1.13"
$host.ui.RawUI.WindowTitle = "My BinMenu $FileVersion on $env:USERDOMAIN"
Function MyConfig {
    $MyConfig = (Split-Path -parent $PSCommandPath) + "\" + (Split-Path -leaf $PSCommandPath)
    $MyConfig = ($MyConfig -replace ".ps1", ".json")
    $MyConfig = $MyConfig.trimstart(" ")
    $MyConfig
}
[string]$ConfigFile = MyConfig
try { $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "The Base configuration file is missing!"; break }
if (!($Config)) {
    Say -ForeGroundColor RED "The BinMenu.json configuration file is missing!"
    Say -ForeGroundColor RED "You need to create or edit BinMenu.json in BASE directory"
    break
}
$Base = $env:Base
if (!($Base)) { Set-Variable -Name Base -Value ($Config.basic.Base) -Scope Global }
if (!($Base)) { Say -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $Base.substring(0, 3)
Set-Location $Base
[string]$ScriptName = ($Config.basic.ScriptName)
[string]$Editor = ($Config.basic.Editor)
if (!($editor)) { $editor = ($Base + "\npp\Notepad++.exe") }
[bool]$DeBug = ($Config.basic.DeBug)
[bool]$ScriptRead = ($Config.basic.ScriptRead)
[bool]$MenuAdds = ($Config.basic.MenuAdds)
[bool]$WPosition = ($Config.basic.WPosition)
[int]$WinWidth = ($Config.basic.WinWidth)
if (!($WinWidth)) { $WinWidth = 104 }
[int]$BuffWidth = $WinWidth
[int]$WinHeight = ($Config.basic.WinHeight)
if (!($WinHeight)) { $WinWidth = 36 }
[int]$BuffHeight = $WinHeight
[int]$WinX = ($Config.basic.WinX)
if (!($WinX)) { $WinX = 530 }
[int]$WinY = ($Config.basic.WinY)
if (!($WinY)) { $WinY = 200 }
$PosTest = Test-Path -path ($Base + "\Put-WinPosition.ps1")
Function FlexWindow {
    $SaveError = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"
    $pshost = Get-Host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    [int]$newsize.height = $BuffHeight
    [int]$newsize.width = $BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    [int]$newsize.height = $WinHeight
    [int]$newsize.width = $WinWidth
    $pswindow.windowsize = $newsize
    $ErrorActionPreference = $SaveError
}
if (($WPosition)) {
    FlexWindow
    if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY | Out-Null }
}
Function SpinItems {
    $si = 1
    $Sc = 50
    $Script:AddCount = 0
    While ($si -lt $sc) {
        $AddItem = "AddItem-$si"
        $Spin = ($Config.$AddItem).name
        if ($null -ne $Spin) { $Script:AddCount++; $si++ }
        else { $si = 50 }
    }
}
SpinItems
Function DeBug {
    Say "LineCount" $LineCount
    Say "A" $a
    Say "Temp" $temp
    Say "B" $b
    Say "C" $c
    Say "ROW" $Row
    Say "COL" $Col
    Say "PP" $pp
    Say "PMENU" $PMenu
    Say "WORK" $Work
    Say "WINHEIGHT" $WinHeight
    Say "BUFFHEIGHT" $BuffHeight
    Say "DeBug" $DeBug
    Read-Host -Prompt "Enter to leave DeBug"
    Clear-Host
}
#if (($DeBug)) { DeBug }
Function FixLine {
    Say "                                                                                                       "
    [Console]::SetCursorPosition(0, $pp); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, 0); Say ""
    [Console]::SetCursorPosition(0, ($pp + 1)); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, 0); Say ""
    [Console]::SetCursorPosition(0, ($pp + 2)); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, $pp); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, $pp)
}
Clear-Host
[string]$FileINI = ($Base + "\BinMenu.ini")
[string]$Filetmp = ($Base + "\BinTemp.del")
$Filetest = Test-Path -path $Filetmp
if (($Filetest)) { Remove-Item –path $Filetmp }
Set-Location $Base.substring(0, 3)
Set-Location $Base
SpinItems
$ESC = [char]27
$Filetest = Test-Path -path $FileINI
if (!($Filetest)) {
    Say "The File $FileINI is missing. We Can not continue without it."
    Say "We are going to run the INI creator function now"
    Read-Host -Prompt "[Enter to continue]"
    [bool]$NoINI = $True
    My-Maker
}
<# ########## MenuAdds Toggles ON ########## #>
if ($MenuAdds -eq 1) {
    [int]$LineCount = (Get-Content $FileINI).count
    [int]$temp = ($LineCount / 3)
    [int]$temp2 = ($temp + 1)
    [int]$J = 1
    while ($j -le $AddCount) {
        $AddItem = "AddItem-$j"
        $k = ($Config.$AddItem).name
        $t = $(Select-String -Pattern $k $FileINI)
        if ($null -eq $t) {
            $value1 = ("[" + $temp2 + "A]=") + ($Config.$AddItem).name
            (Add-Content $FileINI $value1)
            $value2 = ("[" + $temp2 + "B]=") + ($Config.$AddItem).command
            (Add-Content $FileINI $value2)
            $value3 = ("[" + $temp2 + "C]=") + ($Config.$AddItem).argument
            if (!($value3)) { (Add-Content $FileINI $value3) }
            else { (Add-Content $FileINI $value3) }
            $Temp2++
        }
        $j++
    }
}
<# ########## MenuAdds Toggle OFF ########## #>
if ($MenuAdds -eq 0) {
    $AddItem = "AddItem-1"
    $wow = ($Config.$AddItem).name
    if (($wow)) {
        $name = "=" + ($Config.$AddItem).name
        [int]$it = (Select-String -SimpleMatch $name $FileINI).linenumber
        if (($it)) {
            $it = ($it - 1)
            $q = 0
            While ($q -lt $it) {
                $tr = (Get-Content $FileINI)[$q]
                (Add-Content ./BinMenu.no $tr)
                $q++
            }
            Remove-Item $FileINI
            Rename-Item -Path ./BinMenu.no -NewName $FileINI
        }
    }
}
$ptemp = ($Base + "\*.ps1")
[int]$PCount = (Get-ChildItem -Path $ptemp).count
[int]$PCount = ($PCount - 1)
[string]$NormalLine = "$ESC[31m#=====================================================================================================#$ESC[97m"
[string]$FancyLine = "$ESC[31m|$ESC[97m>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<$ESC[36m[$ESC[41m $ESC[97mMy BinMenu Two $ESC[40m$ESC[36m]$ESC[97m>-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-<$ESC[31m|$ESC[97m"
[string]$PrettyLine = "$ESC[31m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[97m"
[string]$SpacerLine = "$ESC[31m|                                                                                                     $ESC[31m|$ESC[97m"
[string]$ProgramLine = "$ESC[31m#$ESC[36m[$ESC[33mProgram Menu$ESC[36m]$ESC[31m=======================================================================================#$ESC[97m"
[string]$Menu1Line = "$ESC[31m#$ESC[36m[$ESC[33mBuilt-in Menu$ESC[36m]$ESC[31m========================================================================$ESC[36m[$ESC[33mScripts:    $ESC[36m]$ESC[31m#$ESC[97m"
[string]$ScriptLine = "$ESC[31m#$ESC[36m[$ESC[33mScripts Menu$ESC[36m]$ESC[31m=======================================================================================#$ESC[97m"
[int]$pp = 0
[int]$LineCount = 0
[int]$LineCount = (Get-Content $FileINI).count
$temp = ($LineCount / 3)
$Work = $temp
$a = ($temp / 3)
$a = [int][Math]::Ceiling($a)
$temp = ($Work / 3)
$PMenu = [int][Math]::Ceiling($temp)
[int]$b = ($a * 2)
[int]$c = ($Work - $b)
$Row = @($a, $b, $c)
$Col = @(1, 34, 69)
[int]$pp = ($PMenu + 9)
[Console]::SetCursorPosition(0, $pp)
$WinHeight = ($pp + 4)
$BuffHeight = $WinHeight
if (($WPosition)) { FlexWindow }
if (($DeBug)) { DeBug }
[Console]::SetCursorPosition(0, 0); Say $NormalLine; $pp++
[Console]::SetCursorPosition(0, 1); Say $FancyLine; $pp++
[Console]::SetCursorPosition(0, 2); Say $Menu1Line; $pp++
[Console]::SetCursorPosition(98, 2); Say $PCount
[Console]::SetCursorPosition(0, 3); Say $SpacerLine; $pp++
[Console]::SetCursorPosition(0, 4); Say $SpacerLine; $pp++
[Console]::SetCursorPosition(0, 5); Say $SpacerLine; $pp++
[Console]::SetCursorPosition(1, 0)
Say "$ESC[36m[$ESC[97m" $FileVersion "$ESC[36m]$ESC[31m"
[Console]::SetCursorPosition(0, 6)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    [Console]::SetCursorPosition(85, 0)
    Say "$ESC[36m[$ESC[97m Administrator $ESC[36m]$ESC[31m"
    [Console]::SetCursorPosition(0, 6)
}
[int]$l = 3
$d = @("A", "B", "C", "D", "E", "F", "G", "Z", "Q")
$f = @("Run an EXE directly", "Reload BinMenu", "Run INI Maker", "Run a PowerShell console", "Script Window", "Run VS Code (New IDE)", "Run a PS1 script", "Run Settings Manager", "Quit BinMenu")
[int]$w = $Col[0]
[int]$c = 0
while ($c -le 8) {
    [Console]::SetCursorPosition($w, $l)
    [string]$tmp = $d[$c]
    Say "$ESC[31m[$ESC[97m$tmp$ESC[31m]$ESC[35m" $f[$c]
    if ($c -eq 2) { [int]$l = ($l - 3); [int]$w = $Col[1] }
    if ($c -eq 5) { [int]$l = ($l - 3); [int]$w = $Col[2] }
    $l++
    $c++
}
[int]$pp = 6
[Console]::SetCursorPosition(0, $pp)
Say $ProgramLine
$pp++
[int]$i = 0
[int]$l = $pp
while ($i -lt $PMenu) {
    [Console]::SetCursorPosition(0, $l)
    Say $SpacerLine
    $i++
    $l++
}
Say $NormalLine
[Console]::SetCursorPosition(0, $pp)
[int]$l = $pp
[int]$c = 0
[int]$w = $col[0]
[int]$i = 1
$Reader = New-Object IO.StreamReader ($fileINI, [Text.Encoding]::UTF8, $true, 4MB)
While ($i -le $Work) {
    if ($i -le $Work) {
        $Line = $Reader.ReadLine()
        if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
        $moo = $line.split("=")
        [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[31m[$ESC[97m$i$ESC[31m]$ESC[36m" $moo[1]
        $ltwo = $Reader.ReadLine()
        if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
        $lthree = $Reader.ReadLine()
        if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
    }
    if ($i -eq $Row[0]) { [int]$l = 6; [int]$w = $Col[1] }
    if ($i -eq $Row[1]) { [int]$l = 6; [int]$w = $Col[2] }
    $i++
    $c = ($c + 3)
    $L++
}
$Reader.close()
$pp = ($a + 8)
[Console]::SetCursorPosition(0, $pp)
$WinHeight = ($pp + 4)
$BuffHeight = $WinHeight
if (($WPosition)) { FlexWindow }
[Console]::SetCursorPosition(0, $pp)
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$menu = "$ESC[36m[$ESC[33mMake A Selection$ESC[36m]$ESC[97m"
Function MyMaker {
    Start-Process "pwsh.exe" -ArgumentList ($Base + "\BinIM.ps1") -Verb RunAs
    break
}
if (($NoINI)) { [bool]$NoINI = $False; MyMaker }
if (($WPosition)) { FlexWindow }
$menuPrompt += $menu
$ValidOption = "NO"
<# ########## Begin The Menu Loop ########## #>
While (1) {
    [Console]::SetCursorPosition(0, $pp)
    $ans = Read-Host $menuprompt
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($ans, [ref]$OutNumber)) {
        FixLine
        $ValidOption = "NO"
        $DidIt = "NO"
        $MaxYes = (Get-Content $FileINI).count
        $MaxYes = ($MaxYes / 3)
        $MaxYes = [int][Math]::Ceiling($MaxYes)
        if ($OutNumber -gt 0 -and $OutNumber -le $MaxYes) {
            [string]$IntCom = ("[" + $ans + "B]")
            [string]$Argue = ("[" + $ans + "C]")
            if (!($IntCom)) {
                Say -ForeGroundColor Red "Error In Sent Param" $IntCom
                Read-Host -Prompt "[Press Enter]"
                return
            }
            $moo = (Select-String -SimpleMatch $IntCom $FileINI)
            $cow = $moo -split "="
            $horn = $cow[1]
            if (($horn)) {
                if ($horn -match "shell:::") {
                    try { Start-Process "explorer.exe" -ArgumentList $horn -Verb RunAs }
                    catch { continue }
                    $ValidOption = "YES"
                    $DidIt = "YES"
                }
                elseif ((Get-Item $horn) -is [System.IO.DirectoryInfo] -eq $True) {
                    try { Invoke-Item $horn }
                    catch { continue }
                    $ValidOption = "YES"
                    $DidIt = "YES"
                }
                elseif ($DidIt -eq "NO") {
                    $car = $null
                    $truck = $null
                    $bus = $null
                    $car = (Select-String -SimpleMatch $Argue $FileINI)
                    #Say $car
                    #Read-Host
                    $bus = $car -split "="
                    $truck = $bus[1]
                    if (($truck)) {
                        [string]$MakeMove = Split-Path $truck
                        try { Start-Process $horn -ArgumentList $truck -Verb RunAs -WorkingDirectory $MakeMove }
                        catch { continue }
                        $ValidOption = "YES"
                        $DidIt = "YES"
                    }
                    else {
                        try { Start-Process $horn -Verb RunAs }
                        catch { continue }
                        $ValidOption = "YES"
                        $DidIt = "YES"
                    }
                }
                else { FixLine }
            }
        }
        else {
            if ($ValidOption -eq "NO") {
                FixLine
                Say -NoNewLine "Sorry, that is not an option. Feel free to try again."
                Start-Sleep -Milliseconds 500
                FixLine
                if (($WPosition)) { FlexWindow }
            }
            else { FixLine }
        }
    }
    else {
        $ValidOption = "NO"
        $DidIt = "NO"
        if ($ans -eq "A") {
            FixLine
            $cmd = $null; $cmd1 = $null
            $RMenu = "$ESC[31m[$ESC[97mWhat EXE to run? $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            $cmd = Read-Host -Prompt $RMenu
            FixLine
            if (($cmd)) {
                $cmd = ($cmd.split(".")[0] + ".EXE")
                FixLine
                $RMenu = "$ESC[31m[$ESC[97mAdd any parameters? $ESC[31m($ESC[97mEnter for none$ESC[31m)]$ESC[97m"
                $cmd1 = Read-Host -Prompt $RMenu
                FixLine
                if (($cmd1)) {
                    Start-Process $cmd -Argumentlist $cmd1 -Verb RunAs
                    FixLine
                }
                else {
                    Start-Process $cmd -Verb RunAs
                    FixLine
                }
            }
            FixLine
            $ValidOption = "YES"
        }
        elseif ($ans -eq "B") { Invoke-Item ($Base + "\BinMenu.lnk"); Clear-Host; return }
        elseif ($ans -eq "C") { FixLine; MyMaker; Clear-Host; Invoke-Item ($Base + "\BinMenu.lnk"); Clear-Host; return }
        elseif ($ans -eq "D") { FixLine; Start-Process "pwsh.exe" -Verb RunAs; $ValidOption = "YES" }
        elseif ($ans -eq "E") {
            FixLine
            $Filetest = Test-Path -path $Filetmp
            if (($Filetest)) { Remove-Item –path $Filetmp }
            Get-ChildItem -file $Base -Filter "*.ps1" | ForEach-Object { [string]$_.name } | Sort-Object | Out-File $Filetmp
            Start-Process pwsh.exe -ArgumentList ($Base + "\BinScript.Ps1") -Verb RunAs; FixLine
            $ValidOption = "YES"
        }
        elseif ($ans -eq "F") { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine; $ValidOption = "YES" }
        elseif ($ans -eq "G") {
            FixLine
            $cmd = $null; $cmd1 = $null
            Say "$ESC[31m[$ESC[33mQuickMenu$ESC[31m][$ESC[97m1$ESC[31m][$ESC[97mClearLogs$ESC[31m] [$ESC[97m2$ESC[31m][$ESC[97mReboot$ESC[31m] [$ESC[97m3$ESC[31m][$ESC[97mShut Down$ESC[31m] [$ESC[97m4$ESC[31m][$ESC[97mLogOff$ESC[31m] [$ESC[97m5$ESC[31m][$ESC[97mDo-Ghost$ESC[31m] [$ESC[97m6$ESC[31m][$ESC[97mComplete CheckDisk$ESC[31m]"
            $RMenu = "$ESC[31m[$ESC[97mType a PS1 script name to run, a QuickMenu option or $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            $cmd = Read-Host -Prompt $RMenu
            FixLine
            if (($cmd)) {
                $OneShot = "NO"
                if ($cmd -eq "1" -or $cmd -eq "2" -or $cmd -eq "3" -or $cmd -eq "4" -or $cmd -eq "5" -or $cmd -eq "6") { $QM = "YES" }
                if ($cmd -eq "clearlogs" -or $cmd -eq "reboot" -or $cmd -eq "Run-Ghost") { $OneShot = "YES" }
                if ($OneShot -eq "YES") {
                    $cmd = ($cmd.split(".")[0] + ".PS1")
                    Start-Process "pwsh.exe" -Argumentlist $cmd -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "1") {
                    Start-Process "pwsh.exe" -Argumentlist ($Base + "\clearlogs.ps1") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "2") {
                    Start-Process "pwsh.exe" -Argumentlist ($Base + "\reboot.ps1") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "3") {
                    Start-Process "pwsh.exe" -Argumentlist ($Base + "\reboot.ps1 STOP") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "4") {
                    Start-Process "pwsh.exe" -Argumentlist ($Base + "\reboot.ps1 LOGOFF") -Verb RunAs
                    FixLine
                    break
                }
                elseif ($QM -eq "YES" -and $cmd -eq "5") {
                    Start-Process "pwsh.exe" -Argumentlist ($Base + "\Run-Ghost.ps1") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "6") {
                    Start-Process "pwsh.exe" -Argumentlist ($Base + "\Run-CheckDisk.ps1") -WindowStyle Hidden -Verb RunAs
                    FixLine
                    break
                }
                else {
                    $RMenu = "$ESC[31m[$ESC[97mWant any parameters? $ESC[31m($ESC[97mEnter for none$ESC[31m)]$ESC[97m"
                    $cmd1 = Read-Host -Prompt $RMenu
                    FixLine
                    $cmd = ($cmd.split(".")[0] + ".PS1")
                    [string]$cmd = ("$cmd $cmd1")
                    Start-Process "pwsh.exe" -Argumentlist $cmd -Verb RunAs
                    FixLine
                }
            }
            FixLine
            $ValidOption = "YES"
        }
        elseif ($ans -eq "Q") { $Filetest = Test-Path -path $Filetmp; if (($Filetest)) { Remove-Item –path $Filetmp }; Clear-Host; Return }
        elseif ($ans -eq "R") { Invoke-Item ($Base + "\BinMenu.lnk"); Clear-Host; return }
        elseif ($ans -eq "Z") { Start-Process "pwsh.exe" -ArgumentList ($Base + '\BinSM.ps1') -Verb RunAs; FixLine; $ValidOption = "YES" }
        else {
            if ($ValidOption -eq "NO") {
                FixLine
                [Console]::SetCursorPosition(0, $pp)
                Say -NoNewLine "Sorry, that is not an option. Feel free to try again."
                Start-Sleep -Milliseconds 500
                FixLine
                if (($WPosition)) { FlexWindow }
            }
            else { FixLine }
        }
    }
    [Console]::SetCursorPosition(0, $pp)
    if (($WPosition)) {
        FlexWindow
        if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY | Out-Null }
    }
}
$Filetest = Test-Path -path $Filetmp
if (($Filetest)) { Remove-Item –path $Filetmp }
