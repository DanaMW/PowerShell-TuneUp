<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: April, 2018
        Last Modified Date: April 26, 2019
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created Internally.
        Also has great Settings Manager, it's companion script BinSM.ps1.
.EXAMPLE
        BinMenu.ps1
.NOTES
        Still under development.
#>
$FileVersion = "Version: 2.0.4"
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
[string]$ScriptMode = ($Config.basic.ScriptMode)
[bool]$ScriptRead = ($Config.basic.ScriptRead)
[bool]$MenuAdds = ($Config.basic.MenuAdds)
[bool]$WPosition = ($Config.basic.WPosition)
[int]$WinWidth = ($Config.basic.WinWidth)
[int]$BuffWidth = $WinWidth
[int]$WinHeight = ($Config.basic.WinHeight)
[int]$BuffHeight = $WinHeight
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
FlexWindow
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
    #$Script:AddCount
}
SpinItems
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
if ($Filetest -eq $True) { Remove-Item –path $Filetmp }
Set-Location $Base.substring(0, 3)
Set-Location $Base
SpinItems
$ESC = [char]27
$Filetest = Test-Path -path $FileINI
if ($Filetest -ne $True) {
    Say "The File $FileINI is missing. We Can not continue without it."
    Say "We are going to run the INI creator function now"
    Read-Host -Prompt "[Enter to continue]"
    [bool]$NoINI = $True
    My-Maker
}
Get-ChildItem -file $Base -Filter "*.ps1" | ForEach-Object { [string]$_.name } | Sort-Object | Out-File $Filetmp
<# ############## The menu variables for this menu ############# #>
$ptemp = ($Base + "\*.ps1")
[int]$PCount = (Get-ChildItem -Path $ptemp).count
[int]$PCount--
[string]$NormalLine = "$ESC[91m#=====================================================================================================#$ESC[97m"
[string]$FancyLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<$ESC[96m[$ESC[41m $ESC[97mMy BinMenu Two $ESC[40m$ESC[96m]$ESC[97m>-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=$ESC[91m|$ESC[97m"
[string]$PrettyLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[91m|$ESC[97m"
[string]$SpacerLine = "$ESC[91m|                                                                                                     $ESC[91m|$ESC[97m"
[string]$ProgramLine = "$ESC[91m#$ESC[96m[$ESC[33mProgram Menu$ESC[96m]$ESC[91m=======================================================================================#$ESC[97m"
[string]$Menu1Line = "$ESC[91m#$ESC[96m[$ESC[33mBuilt-in Menu$ESC[96m]$ESC[91m=======================================================================$ESC[96m[$ESC[33mScripts:     $ESC[96m]$ESC[91m#$ESC[97m"
[string]$ScriptLine = "$ESC[91m#$ESC[96m[$ESC[33mScripts Menu$ESC[96m]$ESC[91m=======================================================================================#$ESC[97m"
<# ########## END of menu variables ######### #>
if ($ScriptMode -eq "SM3") {
    [int]$LineCount = 0
    [int]$LineCount = (Get-Content $FileINI).count
    $temp = ($LineCount / 3)
    $a = ($temp / 3)
    [int]$a = [int][Math]::Ceiling($a)
    [int]$temp = $a
    [int]$b = ($temp * 2)
    [int]$c = ($LineCount / 3)
    $Row = @($a, $b, $c)
    $Col = @(1, 34, 69)
    [int]$pp = 0
    [int]$work = ($LineCount / 3)
    [int]$LineCount = 0
    [int]$LineCount = (Get-Content $FileINI).count
    [int]$PMenu = ($Work / 3)
    [int]$PMenu = ($PMenu - 1)
    [int]$pp = (9 + $PMenu)
    [Console]::SetCursorPosition(0, $pp)
    $WinHeight = ($pp + 4)
    $BuffHeight = $WinHeight
    if (($WPosition)) { FlexWindow }
}
if ($ScriptMode -eq "SM4") {
    [int]$LineCount = 0
    [int]$LineCount = (Get-Content $Filetmp).count
    [int]$a = ($LineCount / 3)
    [int]$a = [int][Math]::Ceiling($a)
    [int]$temp = $a
    [int]$b = ($temp * 2)
    [int]$c = ($LineCount / 3)
    $Row = @($a, $b, $c)
    $Col = @(1, 34, 69)
    [int]$pp = 0
    [int]$work = $LineCount
    [int]$LineCount = 0
    [int]$LineCount = (Get-Content $Filetmp).count
    [int]$PMenu = ($Work / 3)
    [int]$PMenu = ($PMenu - 1)
    <# ########## PP And Window Size ########## #>
    [int]$pp = (9 + $PMenu)
    [Console]::SetCursorPosition(0, $pp)
    $WinHeight = ($pp + 4)
    $BuffHeight = $WinHeight
    if ($ScriptMode -eq "SM4") { $WinHeight = ($WinHeight / 1.5) }
    if (($WPosition)) { FlexWindow }
}
<# ########## Begining Of Screen One ########## #>
Function ScreenOne {
    [Console]::SetCursorPosition(0, 0); Say $NormalLine; $pp++
    [Console]::SetCursorPosition(0, 1); Say $FancyLine; $pp++
    [Console]::SetCursorPosition(0, 2); Say $Menu1Line; $pp++
    [Console]::SetCursorPosition(97, 2); Say $PCount
    [Console]::SetCursorPosition(0, 3); Say $SpacerLine; $pp++
    [Console]::SetCursorPosition(0, 4); Say $SpacerLine; $pp++
    [Console]::SetCursorPosition(0, 5); Say $SpacerLine; $pp++
    [Console]::SetCursorPosition(1, 0)
    Say "$ESC[96m[$ESC[97m" $FileVersion "$ESC[36m]$ESC[91m"
    [Console]::SetCursorPosition(0, 6)
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        [Console]::SetCursorPosition(85, 0)
        Say "$ESC[96m[$ESC[97m Administrator $ESC[96m]$ESC[91m"
        [Console]::SetCursorPosition(0, 6)
    }
    [int]$l = 3
    $d = @("A", "B", "C", "D", "E", "F", "G", "Z", "Q")
    $f = @("Run an EXE directly", "Reload BinMenu", "Run INI Maker", "Run a PowerShell console", "Switch Program-Script Menus", "Run VS Code (New IDE)", "Run a PS1 script", "Run Settings Manager", "Quit BinMenu")
    [int]$w = $Col[0]
    [int]$c = 0
    while ($c -le 8) {
        [Console]::SetCursorPosition($w, $l)
        [string]$tmp = $d[$c]
        Say "$ESC[91m[$ESC[97m$tmp$ESC[91m]$ESC[95m" $f[$c]
        if ($c -eq 2) { [int]$l = ($l - 3); [int]$w = $Col[1] }
        if ($c -eq 5) { [int]$l = ($l - 3); [int]$w = $Col[2] }
        $l++
        $c++
    }
}
ScreenOne
<# ########## END Of Screen ONE ########## #>

<# ########## Begining Of Screen TWO ########## #>
Function ScreenTwo {
    if ($ScriptMode -eq "SM3") {
        [int]$pp = 6
        [Console]::SetCursorPosition(0, $pp)
        Say $ProgramLine
        $pp++
        [int]$i = 0
        [int]$l = 7
        while ($i -le $PMenu) {
            [Console]::SetCursorPosition(0, $l)
            Say $SpacerLine
            $i++
            $l++
            $pp++
        }
    }
    if ($ScriptMode -eq "SM4") {
        [int]$pp = 6
        [Console]::SetCursorPosition(0, $pp)
        Say $Scriptline
        $pp++
        [int]$i = 0
        [int]$l = 7
        while ($i -le $PMenu) {
            [Console]::SetCursorPosition(0, $l)
            Say $SpacerLine
            $i++
            $l++
            $pp++
        }
    }
}
ScreenTwo
<# ########## END Of Screen two ########## #>

<# ########## PP And Window Size ########## #>
[int]$pp = (9 + $PMenu)
[Console]::SetCursorPosition(0, $pp)
$WinHeight = ($pp + 4)
$BuffHeight = $WinHeight
if ($ScriptMode -eq "SM4") { $WinHeight = ($WinHeight / 1.5) }
if (($WPosition)) { FlexWindow }
<# ########## MenuAdds Toggles ON ########## #>
if ($MenuAdds -eq 1) {
    [int]$temp = ($LineCount / 3)
    #Say "Adding $temp Menu-Adds Items"
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
    #Say "Removing MenuAdds Items"
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
<# ########## Begining Of Screen THREE ########## #>
Function ScreenThree {
    if ($ScriptMode -eq "SM3") {
        $pp--
        [Console]::SetCursorPosition(0, $pp)
        Say $NormalLine
        [int]$l = 7
        [int]$c = 0
        [int]$w = $col[0]
        [int]$i = 1
        $Reader = New-Object IO.StreamReader ($fileINI, [Text.Encoding]::UTF8, $true, 4MB)
        While ($i -le $work) {
            if ($i -le $work) {
                #$Line = (Get-Content $FileINI)[$c]
                $Line = $Reader.ReadLine()
                if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
                $moo = $line.split("=")
                [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m$i$ESC[91m]$ESC[96m" $moo[1]
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
        [Console]::SetCursorPosition(0, $pp)
    }
}
ScreenThree
<# ########## Ending Of Screen THREE ########## #>

<# ########## Begining Of Screen FOUR ########## #>
Function ScreenFour {
    if ($ScriptMode -eq "SM4") {
        $pp--
        [Console]::SetCursorPosition(0, $pp)
        Say $NormalLine
        [int]$l = 7
        [int]$c = 0
        [int]$w = $col[0]
        [int]$i = 1
        [Int]$num = 100
        $Reader = New-Object IO.StreamReader ($filetmp, [Text.Encoding]::UTF8, $true, 4MB)
        While ($i -le $Work) {
            $Line = $Reader.ReadLine()
            if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
            [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m$Num$ESC[91m]$ESC[92m" $Line
            if ($i -eq $Row[0]) { [int]$l = 6; [int]$w = $Col[1] }
            if ($i -eq $Row[1]) { [int]$l = 6; [int]$w = $Col[2] }
            $i++
            $c = ($c + 3)
            $L++
            $num++
        }
        $Reader.close()
        [Console]::SetCursorPosition(0, $pp)
    }
}
ScreenFour
<# ########## END Of Screen FOUR ########## #>
ScreenOne
ScreenTwo
if ($ScriptMode -eq "SM3") { ScreenThree }
if ($ScriptMode -eq "SM4") { ScreenFour }
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$menu = "$ESC[91m[$ESC[97mMake A Selection$ESC[91m]$ESC[97m"
Function MyMaker {
    Start-Process "pwsh.exe" -ArgumentList ($Base + "\BinIM.ps1") -Verb RunAs
    break
}
if (($NoINI)) { [bool]$NoINI = $False; MyMaker }
if (($WPosition)) { FlexWindow }
$menuPrompt += $menu
$ValidOption = "NO"
Function SwitchScreen {
    if ($ScriptMode -eq "SM3") {
        $ScriptMode = "SM4"
    }
    else { $ScriptMode = "SM3" }
    ScreenOne
    ScreenTwo
    if ($ScriptMode -eq "SM3") { ScreenThree }
    if ($ScriptMode -eq "SM4") { ScreenFour }
}
<# ########## Begin The Menu Loop ########## #>
While (1) {
    [Console]::SetCursorPosition(0, $pp)
    $ans = Read-Host -Prompt $menuprompt
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($ans, [ref]$OutNumber)) {
        FixLine
        $ValidOption = "NO"
        $DidIt = "NO"
        $IntCom = ("[" + $ans + "B]")
        $Argue = ("[" + $ans + "C]")
        if (!($IntCom)) {
            Say -ForeGroundColor Red "Error In Sent Param" $IntCom
            Read-Host
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
                [string]$car = (Select-String -SimpleMatch $Argue $FileINI)
                $bus = $car -split "="
                $truck = $bus[1]
                if (($truck)) {
                    $MakeMove = Split-Path $truck
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
            $RMenu = "$ESC[91m[$ESC[97mWhat EXE to run? $ESC[91m($ESC[97mEnter to Cancel$ESC[91m)]$ESC[97m"
            $cmd = Read-Host -Prompt $RMenu
            FixLine
            if (($cmd)) {
                $cmd = ($cmd.split(".")[0] + ".EXE")
                FixLine
                $RMenu = "$ESC[91m[$ESC[97mAdd any parameters? $ESC[91m($ESC[97mEnter for none$ESC[91m)]$ESC[97m"
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
        elseif ($ans -eq "D") { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        elseif ($ans -eq "E") {
            FixLine
            if ($ScriptMode -eq "SM3") {
                $ScriptMode = "SM4"
            }
            else { $ScriptMode = "SM3" }
            ScreenOne
            ScreenTwo
            if ($ScriptMode -eq "SM3") { ScreenThree }
            if ($ScriptMode -eq "SM4") { ScreenFour }
            FixLine
            $ValidOption = "YES"
        }
        elseif ($ans -eq "F") { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        elseif ($ans -eq "G") {
            FixLine
            $cmd = $null; $cmd1 = $null
            Say "$ESC[91m[$ESC[33mQuickMenu$ESC[91m][$ESC[97m1$ESC[91m][$ESC[97mClearLogs$ESC[91m] [$ESC[97m2$ESC[91m][$ESC[97mReboot$ESC[91m] [$ESC[97m3$ESC[91m][$ESC[97mShut Down$ESC[91m] [$ESC[97m4$ESC[91m][$ESC[97mLogOff$ESC[91m] [$ESC[97m5$ESC[91m][$ESC[97mDo-Ghost$ESC[91m] [$ESC[97m6$ESC[91m][$ESC[97mComplete CheckDisk$ESC[91m]"
            $RMenu = "$ESC[91m[$ESC[97mType a PS1 script name to run, a QuickMenu option or $ESC[91m($ESC[97mEnter to Cancel$ESC[91m)]$ESC[97m"
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
                    $RMenu = "$ESC[91m[$ESC[97mWant any parameters? $ESC[91m($ESC[97mEnter for none$ESC[91m)]$ESC[97m"
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
        elseif ($ans -eq "Q") { $Filetest = Test-Path -path $Filetmp; if ($Filetest -eq $True) { Remove-Item –path $Filetmp }; Clear-Host; Return }
        elseif ($ans -eq "R") { Invoke-Item ($Base + "\BinMenu.lnk"); Clear-Host; return }
        elseif ($ans -eq "Z") { Start-Process "pwsh.exe" -ArgumentList ($Base + '\BinSM.ps1') -Verb RunAs; FixLine }
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
    if (($WPosition)) { FlexWindow }
    ScreenOne
    ScreenTwo
    if ($ScriptMode -eq "SM3") { ScreenThree }
    if ($ScriptMode -eq "SM4") { ScreenFour }
    if (($WPosition)) { FlexWindow }
}
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $True) { Remove-Item –path $Filetmp }
