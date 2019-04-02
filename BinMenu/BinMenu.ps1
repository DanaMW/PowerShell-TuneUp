<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: April 02, 2019
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created Internally.
        Also has great Settings Manager, it's companion script BinSM.ps1.
.EXAMPLE
        BinMenu.ps1
.NOTES
        Still under development.
#>
$FileVersion = "Version: 1.1.28"
$host.ui.RawUI.WindowTitle = "BinMenu $FileVersion on $env:USERDOMAIN"
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
    Say -ForeGroundColor RED "You need to create or edit BinMenu.json in" $env:BASE
    break
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
    #$Script:AddCount
}
SpinItems
if (!($env:Base)) { Set-Variable -Name Base -Value ($Config.basic.Base) -Scope Global }
if (!($env:Base)) { Say -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $env:BASE.substring(0, 3)
Set-Location $env:BASE
[string]$Editor = ($Config.basic.Editor)
if (!($editor)) { $editor = ($env:BASE + "\npp\Notepad++.exe") }
[bool]$ScriptRead = ($Config.basic.ScriptRead)
[bool]$MenuAdds = ($Config.basic.MenuAdds)
[bool]$WPosition = ($Config.basic.WPosition)
[int]$WinWidth = [int]($Config.basic.WinWidth)
[int]$WinHeight = [int]($Config.basic.WinHeight)
[int]$BuffWidth = [int]($Config.basic.BuffWidth)
[int]$BuffHeight = [int]($Config.basic.BuffHeight)
#[int]$MaxWinHeight = [int]($Config.basic.MaxWinHeight)
#if (!($MaxWinHeight)) { $MaxWinHeight = "50" }
#[int]$MaxWinWidth = [int]($Config.basic.MaxWinWidth)
#if (!($MaxWinWidth)) { $MaxWinWidth = "150" }
#[int]$MaxpWinHeight = [int]($Config.basic.MaxpWinHeight)
#if (!($MaxpWinHeight)) { $MaxpWinHeight = "60" }
#[int]$MaxpWinWidth = [int]($Config.basic.$MaxpWinWidth)
#if (!($MaxpWinWidth)) { $MaxpWinWidth = "160" }
Function FlexWindow {
    $pshost = Get-Host
    $pswindow = $pshost.ui.rawui
    #
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    #
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
    <#
    $newsize = $pswindow.maxwindowsize
    $newsize.height = [int]$MaxWinHeight
    $newsize.width = [int]$MaxWinWidth
    $pswindow.maxwindowsize = $newsize

    $newsize = $pswindow.maxphysicalwindowsize
    $newsize.height = [int]$MaxpWinHeight
    $newsize.width = [int]$MaxpWinWidth
    $pswindow.maxphysicalwindowsize = $newsize
    #>
}
if ($WPosition -eq $True) { FlexWindow }
Clear-Host
[string]$FileINI = ($env:BASE + "\BinMenu.ini")
[string]$Filetmp = ($env:BASE + "\BinTemp.del")
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $True) { Remove-Item –path $Filetmp }
Set-Location $env:BASE.substring(0, 3)
Set-Location $env:BASE
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
Clear-Host
$ptemp = ($env:BASE + "\*.ps1")
[int]$PCount = (Get-ChildItem -Path $ptemp).count
[string]$NormalLine = "$ESC[91m#=====================================================================================================#$ESC[97m"
[string]$FancyLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<$ESC[96m[$ESC[41m $ESC[97mMy Bin Folder Menu $ESC[40m$ESC[96m]$ESC[97m>-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=$ESC[91m|$ESC[97m"
[string]$SpacerLine = "$ESC[91m|                                                                                                     $ESC[91m|$ESC[97m"
[string]$ProgramLine = "$ESC[91m#$ESC[96m[$ESC[33mProgram Menu$ESC[96m]$ESC[91m=======================================================================================#$ESC[97m"
[string]$Menu1Line = "$ESC[91m#$ESC[96m[$ESC[33mBuilt-in Menu$ESC[96m]$ESC[91m======================================================================================#$ESC[97m"
#[string]$ScriptLine = "$ESC[91m#$ESC[96m[$ESC[33mScripts List$ESC[96m][$ESC[33m$PCount$ESC[96m]$ESC[91m=====================================================================================#$ESC[97m"
[string]$ScriptLine = "$ESC[91m#$ESC[96m[$ESC[33mScripts List$ESC[96m]$ESC[91m=======================================================================================#$ESC[97m"
[int]$LineCount = 0
[int]$LineCount = (Get-Content $FileINI).count
if ($MenuAdds -eq "True") {
    [int]$temp = ($LineCount / 3)
    Say "Adding $temp Menu-Adds Items"
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
if ($MenuAdds -ne "False") {
    Say "Removing MenuAdds Items"
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
[int]$pa = ($a + 3)
Clear-Host
Say $NormalLine
Say $FancyLine
Say $ProgramLine
[int]$i = 1
While ($i -le $a) { Say $SpacerLine; $i++ }
[int]$l = 3
[int]$c = 0
[int]$w = $col[0]
[int]$i = 1
[int]$work = ($LineCount / 3)
While ($i -le $work) {
    if ($i -le $work) {
        $Line = (Get-Content $FileINI)[$c]
        $moo = $line -split "="
        [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m$i$ESC[91m]$ESC[96m" $moo[1]
    }
    if ($i -eq $Row[0]) { [int]$l = 2; [int]$w = $Col[1] }
    if ($i -eq $Row[1]) { [int]$l = 2; [int]$w = $Col[2] }
    $i++
    $c = ($c + 3)
    $L++
}
[Console]::SetCursorPosition(0, $pa); Say $Menu1Line; Say $SpacerLine; Say $SpacerLine; Say $SpacerLine
if ($ScriptRead -eq $True) {
    Say $ScriptLine
    $PCount = (Get-ChildItem -file $env:BASE -Filter "*.ps1").count
    [Console]::SetCursorPosition(15, ($pa + 4)); Say -NoNewLine "$ESC[96m[$ESC[33m$PCount$ESC[96m]$ESC[91m"
    [Console]::SetCursorPosition(0, ($pa + 5))
}
else { Say $NormalLine }
[int]$pa = ($pa + 5)
[Console]::SetCursorPosition(0, $pa)
[int]$l = ($pa - 4)
$d = @("A", "B", "C", "D", "E", "F", "G", "Z", "Q")
$f = @("Run an EXE directly", "Reload BinMenu", "Run INI Maker", "Run a PowerShell console", "System Information", "Run VS Code (New IDE)", "Run a PS1 script", "Run Settings Manager", "Quit BinMenu")
[int]$w = $Col[0]
[int]$c = 0
while ($c -le 8) {
    [Console]::SetCursorPosition($w, $l)
    [string]$tmp = $d[$c]
    Say -NoNewLine "$ESC[91m[$ESC[97m$tmp$ESC[91m]$ESC[95m" $f[$c]
    if ($c -eq 2) { [int]$l = ($l - 3); [int]$w = $Col[1] }
    if ($c -eq 5) { [int]$l = ($l - 3); [int]$w = $Col[2] }
    $l++
    $c++
}
[Console]::SetCursorPosition(0, $pa)
if ($scriptRead -eq $True) {
    $cmd1 = "$ESC[92m[$ESC[97m"
    $cmd2 = "$ESC[92m]"
    Get-ChildItem -file $env:BASE -Filter "*.ps1" | ForEach-Object { [string]$_.name -Replace ".ps1", "" } | Sort-Object | ForEach-Object { $cmd1 + $_ + $cmd2 } | Out-File $Filetmp
    [int]$roll = @(Get-Content -Path $Filetmp).Count
    $roll--
    [int]$w = 0
    [int]$l = $pa
    [int]$i = 1
    [Console]::SetCursorPosition($w, $l)
    [int]$i = 0
    [int]$w = $col[0]
    [int]$t = 0
    $MaxLine = 95
    $c = 0
    [Console]::SetCursorPosition($w, $pa)
    while ($i -lt $roll) {
        $UserScripts = $null
        while ($c -lt $MaxLine) {
            $LineR = (Get-Content $Filetmp)[$i]
            $c = ($c + $LineR.length)
            $c = ($c - 15)
            if ($c -lt $MaxLine) { $UserScripts = $UserScripts + $LineR; $i++ }
            else { $c = $MaxLine }
            if ($i -eq $roll) { $c = $MaxLine }
        }
        [Console]::SetCursorPosition(0, $l); Say -NoNewLine "$ESC[91m|"
        [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[92mPS1$ESC[91m]$ESC[92m" $UserScripts
        [Console]::SetCursorPosition(102, $l); Say -NoNewLine "$ESC[91m|"
        $l++; $t++; $c = 0
    }
    $WinHeight = ($WinHeight + $t)
    $BuffHeight = ($BuffHeight + $t)
}
$pa = $l
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $True) { Remove-Item –path $Filetmp }
[int]$w = 0
[Console]::SetCursorPosition(0, $pa); Say $NormalLine
$pa++
$FixLine
$BuffHeight = ($pa + 4)
$WinHeight = ($pa + 4)
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
Function FixLine {
    Say -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa); Say -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
    [Console]::SetCursorPosition(0, ($pa + 1)); Say -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
    [Console]::SetCursorPosition(0, ($pa + 2)); Say -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa); Say -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa)
}
FixLine
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    [Console]::SetCursorPosition(78, 1); Say -NoNewLine "$ESC[96m[$ESC[33mAdministrator$ESC[96m]$ESC[91m"
    [Console]::SetCursorPosition(0, $pa)
}
[Console]::SetCursorPosition(10, 1); Say -NoNewLine "$ESC[96m[$ESC[33m$FileVersion$ESC[36m]$ESC[91m"
[Console]::SetCursorPosition(0, $pa)
Fixline
$menu = "$ESC[91m[$ESC[97mMake A Selection$ESC[91m]$ESC[97m"
Function MyMaker {
    Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\BinIM.ps1") -Verb RunAs
    break
}
if (($NoINI)) { [bool]$NoINI = $False; MyMaker }
if ($WPosition -eq $True) { FlexWindow }
$menuPrompt += $menu
$ValidOption = "NO"
While (1) {
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
                if ($WPosition -eq $True) { FlexWindow }
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
        elseif ($ans -eq "B") { Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\BinMenu.ps1") -WorkingDirectory  $env:BASE -Verb RunAs; Clear-Host; return }
        elseif ($ans -eq "C") { FixLine; MyMaker; Clear-Host; Start-Process "pwsh.exe" ($env:BASE + "\BinMenu.ps1") -Verb RunAs; Clear-Host; return }
        elseif ($ans -eq "D") { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        elseif ($ans -eq "E") { FixLine; Start-Process "pwsh.exe" -ArguMentList ($env:BASE + "\Get-SysInfo.ps1") -Verb RunAs; FixLine; FixLine }
        elseif ($ans -eq "F") { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        elseif ($ans -eq "G") {
            FixLine
            $cmd = $null; $cmd1 = $null
            Say "$ESC[91m[$ESC[33mQuickMenu$ESC[91m][$ESC[97m1$ESC[91m][$ESC[97mClearLogs$ESC[91m] [$ESC[97m2$ESC[91m][$ESC[97mReboot$ESC[91m] [$ESC[97m3$ESC[91m][$ESC[97mShut Down$ESC[91m] [$ESC[97m4$ESC[91m][$ESC[97mDo-Ghost$ESC[91m] [$ESC[97m5$ESC[91m][$ESC[97mComplete CheckDisk$ESC[91m]"
            $RMenu = "$ESC[91m[$ESC[97mType a PS1 script name to run, a QuickMenu option or $ESC[91m($ESC[97mEnter to Cancel$ESC[91m)]$ESC[97m"
            $cmd = Read-Host -Prompt $RMenu
            FixLine
            if (($cmd)) {
                $OneShot = "NO"
                if ($cmd -eq "1" -or $cmd -eq "2" -or $cmd -eq "3" -or $cmd -eq "4" -or $cmd -eq "5") { $QM = "YES" }
                if ($cmd -eq "clearlogs" -or $cmd -eq "reboot" -or $cmd -eq "Run-Ghost") { $OneShot = "YES" }
                if ($OneShot -eq "YES") {
                    $cmd = ($cmd.split(".")[0] + ".PS1")
                    Start-Process "pwsh.exe" -Argumentlist $cmd -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "1") {
                    Start-Process "pwsh.exe" -Argumentlist ($env:BASE + "\clearlogs.ps1") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "2") {
                    Start-Process "pwsh.exe" -Argumentlist ($env:BASE + "\reboot.ps1") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "3") {
                    Start-Process "pwsh.exe" -Argumentlist ($env:BASE + "\reboot.ps1 STOP") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "4") {
                    Start-Process "pwsh.exe" -Argumentlist ($env:BASE + "\Run-Ghost.ps1") -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "5") {
                    Start-Process "pwsh.exe" -Argumentlist ($env:BASE + "\Run-CheckDisk.ps1") -Verb RunAs
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
        elseif ($ans -eq "R") { Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\BinMenu.ps1") -WorkingDirectory  $env:BASE -Verb RunAs; Clear-Host; return }
        elseif ($ans -eq "Z") { Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\BinSM.ps1") -Verb RunAs; FixLine }
        else {
            if ($ValidOption -eq "NO") {
                FixLine
                Say -NoNewLine "Sorry, that is not an option. Feel free to try again."
                Start-Sleep -Milliseconds 500
                FixLine
                if ($WPosition -eq $True) { FlexWindow }
            }
            else { FixLine }
        }
    }
}
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $True) { Remove-Item –path $Filetmp }
