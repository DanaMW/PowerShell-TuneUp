<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: April, 2018
        Last Modified Date: June 06, 2021

.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created Internally.
        Also has great Settings Manager, it's companion script BinSM.ps1.

.EXAMPLE
        BinMenu.ps1

.NOTES
        Still under development.

#>
$FileVersion = "3.0.24"
$host.ui.RawUI.WindowTitle = "My BinMenu $FileVersion on $env:USERDOMAIN"
# Register-EngineEvent PowerShell.Exiting -Action { exit }
# Register-EngineEvent PowerShell.Exiting -SupportEvent -Action `
# { Clear-Host; return }
Function MyConfig {
    $MyConfig = (Split-Path -Parent $PSCommandPath) + "\" + (Split-Path -Leaf $PSCommandPath)
    $MyConfig = ($MyConfig -replace ".ps1", ".json")
    $MyConfig = $MyConfig.trimstart(" ")
    $MyConfig
}
[string]$ConfigFile = MyConfig
Say "Reading from config files."
try { $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "The Base configuration file is missing!"; break }
if (!($Config)) {
    Say -ForeGroundColor RED "The BinMenu.json configuration file is missing!"
    Say -ForeGroundColor RED "You need to create or edit BinMenu.json in Base directory"
    break
}
$Base = $env:Base
if (!($Base)) { Set-Variable -Name Base -Value ($Config.Setup.Base) -Scope Global }
if (!($Base)) {
    $ans = Put-Input "Enter your Base directory (no trailing slash): "
    if ($ans -eq "") { EXIT }
    Set-Variable -Name Base -Value $ans -Scope Global
}
if (!($Base)) { Say -ForeGroundColor RED "SET Base environment variable in your profiles or in the json. This shit uses that!"; break }
[string]$ScriptBase = ($Config.Setup.ScriptBase)
if (!($ScriptBase)) { $ScriptBase = (Split-Path -Parent $PSCommandPath) }
Set-Location $ScriptBase.substring(0, 3)
Set-Location $ScriptBase
[string]$Editor = ($Config.Setup.Editor)
[bool]$DeBug = ($Config.Setup.DeBug)
[bool]$Notify = ($Config.Setup.Notify)
[bool]$MenuAdds = ($Config.Setup.MenuAdds)
[bool]$WPosition = ($Config.Setup.WPosition)
[int]$WinWidth = ($Config.Setup.WinWidth)
[int]$BuffWidth = $WinWidth
[int]$WinHeight = ($Config.Setup.WinHeight)
[int]$BuffHeight = $WinHeight
[int]$WinX = ($Config.Setup.WinX)
if (!($WinX)) { $WinX = 1 }
[int]$WinY = ($Config.Setup.WinY)
if (!($WinY)) { $WinY = 1 }
$PosTest = Test-Path -Path ($Base + "\Put-WinPosition.ps1")
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
[string]$FileINI = ($ScriptBase + "\BinMenu.ini")
[string]$Filetmp = ($ScriptBase + "\BinTemp.del")
$Filetest = Test-Path -Path $Filetmp
if (($Filetest)) { Remove-Item -Path $Filetmp }
Set-Location $ScriptBase.substring(0, 3)
Set-Location $ScriptBase
SpinItems
$Filetest = Test-Path -Path $FileINI
if (!($Filetest)) {
    Say "The File $FileINI is missing. We Can not continue without it."
    Say "We are going to run the INI creator function now"
    Read-Host -Prompt "[Enter to continue]"
    [bool]$NoINI = $True
    My-Maker
}
<# ########## MenuAdds Toggles ON ########## #>
if (($MenuAdds)) {
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
if (!($MenuAdds)) {
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
[string]$NormalLine = "~RED~#~~DARKRED~=====================================================================================================~~RED~#~"
[string]$FancyLine = "~DARKRED~|~~WHITE~>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<~~CYAN~[~ ~RED~My BinMenu III~ ~CYAN~]~~WHITE~>-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-<~~DARKRED~|~"
[string]$PrettyLine = "~DARKRED~|~~WHITE~=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=~~DARKRED~|~"
[string]$SpacerLine = "~DARKRED~|                                                                                                     |~"
[string]$ProgramLine = "~RED~#~~CYAN~[~~DARKYELLOW~Program Menu~~CYAN~]~~DARKRED~=======================================================================================~~RED~#~"
[string]$Menu1Line = "~RED~#~~CYAN~[~~DARKYELLOW~Built-in Menu~~CYAN~]~~DARKRED~========================================================================~~CYAN~[~~DARKYELLOW~Scripts:~    ~CYAN~]~~RED~#~"
[string]$ScriptLine = "~RED~#~~CYAN~[~~DARKYELLOW~Scripts Menu~~CYAN~]~~DARKRED~=======================================================================================~~RED~#~"
[int]$pp = 0
[int]$LineCount = 0
[int]$LineCount = (Get-Content $FileINI).count
if ($LineCount -eq 0) { $LineCount = 1 }
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
[Console]::SetCursorPosition(0, 0); WC $NormalLine; $pp++
[Console]::SetCursorPosition(0, 1); WC $FancyLine; $pp++
[Console]::SetCursorPosition(0, 2); WC $Menu1Line; $pp++
[Console]::SetCursorPosition(98, 2); Say $PCount
[Console]::SetCursorPosition(0, 3); WC $SpacerLine; $pp++
[Console]::SetCursorPosition(0, 4); WC $SpacerLine; $pp++
[Console]::SetCursorPosition(0, 5); WC $SpacerLine; $pp++
[Console]::SetCursorPosition(1, 0)
WC "~CYAN~[~~WHITE~ $FileVersion ~~CYAN~]~"
[Console]::SetCursorPosition(0, 6)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    [Console]::SetCursorPosition(85, 0)
    WC "~CYAN~[~~WHITE~ Administrator ~~CYAN~]~"
    [Console]::SetCursorPosition(0, 6)
}
[int]$l = 3
$d = @("A", "B", "C", "D", "E", "F", "G", "Z", "Q")
$f = @("Run any program", "Reload BinMenu (R also)", "Run BinMenu INI Maker", "Pick an OS console", "Script Window", "Run VS Code", "Run a PS1 script", "Run Settings Manager", "Quit BinMenu")
[int]$w = $Col[0]
[int]$c = 0
while ($c -le 8) {
    [Console]::SetCursorPosition($w, $l)
    [string]$tmp = $d[$c]
    [string]$tmpf = $f[$c]
    WC "~DARKRED~[~~WHITE~$tmp~~DARKRED~]~ ~MAGENTA~$tmpf~"
    if ($c -eq 2) { [int]$l = ($l - 3); [int]$w = $Col[1] }
    if ($c -eq 5) { [int]$l = ($l - 3); [int]$w = $Col[2] }
    $l++
    $c++
}
[int]$pp = 6
[Console]::SetCursorPosition(0, $pp)
WC $ProgramLine
$pp++
if ($PMenu -lt $a) { $PMenu = $a }
[int]$i = 0
[int]$l = $pp
while ($i -lt $PMenu) {
    [Console]::SetCursorPosition(0, $l)
    WC $SpacerLine
    $i++
    $l++
}
WC $NormalLine
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
        [string]$tmpm = $moo[1]
        if ($i -le 9) { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~WHITE~ $i~~DARKRED~]~ ~DARKCYAN~$tmpm~" }
        else { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~WHITE~$i~~DARKRED~]~ ~DARKCYAN~$tmpm~" }
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
Function MyMaker {
    Start-Process "pwsh.exe" -ArgumentList ($ScriptBase + "\BinIM.ps1") -Verb RunAs
    break
}
if (($NoINI)) { [bool]$NoINI = $False; MyMaker }
if (($WPosition)) { FlexWindow }
$ValidOption = "NO"
<# ########## Begin The Menu Loop ########## #>
While (1) {
    [Console]::SetCursorPosition(0, $pp)
    $ans = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~Make A Selection~~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $menuPrompt)
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
                    $bus = $car -split "="
                    $truck = $bus[1]
                    if (($truck)) {
                        [string]$MakeMove = Split-Path $truck
                        try { Start-Process "$horn" -ArgumentList "$truck" -Verb RunAs -WorkingDirectory "$MakeMove" }
                        catch { continue }
                        $ValidOption = "YES"
                        $DidIt = "YES"
                    }
                    else {
                        try { Start-Process "$horn" -Verb RunAs }
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
            $cmd = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~What EXE to run?~~DARKCYAN~]~ ~DARKRED~(~~WHITE~Enter to Cancel~~DARKRED~)~~WHITE~: "; Read-Host -Prompt $menuPrompt)
            FixLine
            if (($cmd)) {
                $cmd = ($cmd.split(".")[0] + ".EXE")
                FixLine
                $cmd1 = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~Add any parameters?~~DARKCYAN~]~ ~DARKRED~(~~WHITE~Enter for none~~DARKRED~)~~WHITE~: "; Read-Host -Prompt $menuPrompt)
                FixLine
                if (($cmd1)) { Start-Process $cmd -ArgumentList $cmd1 -Verb RunAs; FixLine }
                else { Start-Process $cmd -Verb RunAs; FixLine }
            }
            FixLine
            $ValidOption = "YES"
        }
        elseif ($ans -eq "B") { Invoke-Item ($ScriptBase + "\BinMenu.lnk"); Clear-Host; return }
        elseif ($ans -eq "C") { FixLine; MyMaker; Clear-Host; Invoke-Item ($ScriptBase + "\BinMenu.lnk"); Clear-Host; return }
        elseif ($ans -eq "D") {
            FixLine
            WC "~DARKCYAN~[~~DARKYELLOW~QuickMenu~~DARKCYAN~]~~DARKRED~(~~WHITE~1~~DARKRED~)~ ~GREEN~PowerShell ~~DARKRED~(~~WHITE~2~~DARKRED~)~ ~GREEN~CMD ~~DARKRED~(~~WHITE~3~~DARKRED~)~ ~GREEN~Ubuntu ~~DARKRED~(~~WHITE~4~~DARKRED~)~ ~GREEN~Fedora ~~DARKRED~(~~WHITE~5~~DARKRED~)~ ~GREEN~Total Commander ~~DARKRED~(~~WHITE~6~~DARKRED~)~ ~GREEN~Windows Terminal~"
            $cmd = $null; $cmd1 = $null
            $cmd = $($RMenu = WCP "~DARKCYAN~[~~DARKYELLOW~Type a QuickMenu option or Enter to Cancel~~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $RMenu)
            FixLine
            if (($cmd)) {
                if ($cmd -eq "1" -or $cmd -eq "1+" -or $cmd -eq "2" -or $cmd -eq "2+" -or $cmd -eq "3" -or $cmd -eq "3+" -or $cmd -eq "4" -or $cmd -eq "4+" -or $cmd -eq "5" -or $cmd -eq "5+" -or $cmd -eq "6" -or $cmd -eq "6+"  ) {
                    $QM = "YES"
                    $ValidOption = "YES"
                }
                if ($QM -eq "YES" -and $cmd -eq "1") { Start-Process "pwsh.exe" -ArgumentList '-NoLogo -WorkingDirectory D:\bin' -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "1+") { Start-Process "pwsh.exe" -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "2") { Start-Process "cmd.exe" -ArgumentList "/k autoexec.bat" -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "2+") { Start-Process "cmd.exe" -ArgumentList "/k autoexec.bat" -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "3") { Start-Process "ubuntu"; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "3+") { Start-Process "ubuntu"; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "4") { Start-Process "Fedora"; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "4+") { Start-Process "Fedora"; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "5") { Start-Process "pwsh.exe" -ArgumentList "D:\bin\tc.ps1" -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "5+") { Start-Process "pwsh.exe" -ArgumentList "D:\bin\tc.ps1" -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "6") { Start-Process "wt.exe"; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "6+") { Start-Process "wt.exe" -Verb RunAs; FixLine }
                else {
                    FixLine
                    $ValidOption = "NO"
                }
            }
        }
        elseif ($ans -eq "E") {
            FixLine
            $Filetest = Test-Path -Path $Filetmp
            if (($Filetest)) { Remove-Item -Path $Filetmp }
            Get-ChildItem -File $Base -Filter "*.ps1" | ForEach-Object { [string]$_.name } | Sort-Object | Out-File $Filetmp
            Start-Process pwsh.exe -ArgumentList ($ScriptBase + "\BinScript.Ps1") -Verb RunAs; FixLine
            $ValidOption = "YES"
        }
        elseif ($ans -eq "F") { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine; $ValidOption = "YES" }
        elseif ($ans -eq "G") {
            FixLine
            WC "~DARKCYAN~[~~DARKYELLOW~QuickMenu~~DARKCYAN~]~~DARKRED~(~~WHITE~1~~DARKRED~)~ ~GREEN~ClearLogs ~~DARKRED~(~~WHITE~2~~DARKRED~)~ ~GREEN~Reboot ~~DARKRED~(~~WHITE~3~~DARKRED~)~ ~GREEN~Shutdown ~~DARKRED~(~~WHITE~4~~DARKRED~)~ ~GREEN~LogOff ~~DARKRED~(~~WHITE~5~~DARKRED~)~ ~GREEN~Do-Ghost ~~DARKRED~(~~WHITE~6~~DARKRED~)~ ~GREEN~Run CheckDisk~"
            $cmd = $null; $cmd1 = $null
            $cmd = $($RMenu = WCP "~DARKCYAN~[~~DARKYELLOW~Type a PS1 script name to run~~DARKCYAN~,~ ~DARKYELLOW~a QuickMenu option or Enter to Cancel~~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $RMenu)
            FixLine
            if (($cmd)) {
                $OneShot = "NO"
                if ($cmd -eq "1" -or $cmd -eq "2" -or $cmd -eq "3" -or $cmd -eq "4" -or $cmd -eq "5" -or $cmd -eq "6") { $QM = "YES" }
                if ($cmd -eq "clearlogs" -or $cmd -eq "reboot" -or $cmd -eq "Run-Ghost") { $OneShot = "YES" }
                if ($OneShot -eq "YES") {
                    $cmd = ($cmd.split(".")[0] + ".PS1")
                    Start-Process "pwsh.exe" -ArgumentList $cmd -Verb RunAs
                    FixLine
                }
                elseif ($QM -eq "YES" -and $cmd -eq "1") { Start-Process "pwsh.exe" -ArgumentList ($Base + "\clearlogs.ps1") -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "2") { Start-Process "pwsh.exe" -ArgumentList ($Base + "\reboot.ps1 REBOOT") -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "3") { Start-Process "pwsh.exe" -ArgumentList ($Base + "\reboot.ps1 STOP") -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "4") { Start-Process "pwsh.exe" -ArgumentList ($Base + "\reboot.ps1 LOGOFF") -Verb RunAs; FixLine; break }
                elseif ($QM -eq "YES" -and $cmd -eq "5") { Start-Process "pwsh.exe" -ArgumentList ($Base + "\Run-Ghost.ps1") -Verb RunAs; FixLine }
                elseif ($QM -eq "YES" -and $cmd -eq "6") { Start-Process "pwsh.exe" -ArgumentList ($Base + "\Run-CheckDisk.ps1") -WindowStyle Hidden -Verb RunAs; FixLine; break }
                else {
                    $cmd1 = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~Want any parameters?~~DARKCYAN~]~ ~DARKRED~(~~WHITE~Enter for none~~DARKRED~)~~WHITE~: "; Read-Host -Prompt $menuPrompt)
                    FixLine
                    $cmd = ($cmd.split(".")[0] + ".PS1")
                    [string]$cmd = ("$cmd $cmd1")
                    Start-Process "pwsh.exe" -ArgumentList $cmd -Verb RunAs
                    FixLine
                }
            }
            FixLine
            $ValidOption = "YES"
        }
        elseif ($ans -eq "Q") {
            $Filetest = Test-Path -Path $Filetmp
            if (($Filetest)) { Remove-Item -Path $Filetmp }
            Clear-Host
            Return
        }
        elseif ($ans -eq "R") { Invoke-Item ($ScriptBase + "\BinMenu.lnk"); Clear-Host; return }
        elseif ($ans -eq "Z") { Start-Process "pwsh.exe" -ArgumentList ($ScriptBase + '\BinSM.ps1') -Verb RunAs; FixLine; $ValidOption = "YES" }
        else {
            if ($ValidOption -eq "NO") {
                FixLine
                [Console]::SetCursorPosition(0, $pp)
                Say -NoNewLine -ForeGroundColor Yellow "Sorry, that is not an option. Feel free to try again."
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
$Filetest = Test-Path -Path $Filetmp
if (($Filetest)) { Remove-Item -Path $Filetmp }
