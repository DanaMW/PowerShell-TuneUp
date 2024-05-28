$FileVersion = "3.0.39"
$host.ui.RawUI.WindowTitle = ("BinMenu Settings Manager " + $FileVersion)
if (!($ReRun)) { $ReRun = 0 }
Function Get-ScriptDir { Split-Path -Parent $PSCommandPath }
Function MyConfig {
    $Script:MyConfig = ($(Get-ScriptDir) + "\BinMenu.json")
    $MyConfig
}
$Script:ConfigFile = MyConfig
Say "Reading from $Script:ConfigFile"
try { $Script:Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
catch { Write-Error -Message "The Base configuration file is missing!" }
if (!($Config)) { Write-Error -Message "The Base configuration file is missing!" }
$Base = $env:Base
if (!($Base)) { Set-Variable -Name Base -Value ($Config.Setup.Base) -Scope Global }
if (!($Base)) {
    #$ans = Read-Host -Prompt "Enter your Base directory (no trailing slash): "
    $ans = Put-Input "Enter your Base directory (no trailing slash): "
    if ($ans -eq "") { exit }
    Set-Variable -Name Base -Value $ans -Scope Global
}
if (!($Base)) { Say -ForeGroundColor RED "SET Base environment variable in your profiles or in the json. This shit uses that!"; break }
[string]$ScriptBase = ($Config.Setup.ScriptBase)
Set-Location $ScriptBase.substring(0, 3)
Set-Location $ScriptBase
[string]$Editor = ($Config.Setup.Editor)
[bool]$MenuAdds = ($Config.Setup.MenuAdds)
[bool]$Notify = ($Config.Setup.Notify)
[bool]$WPosition = ($Config.Setup.WPosition)
[int]$WinHeight = ($Config.Setup.WinHeight)
$BuffHeight = $WinHeight
[int]$WinWidth = ($Config.Setup.WinWidth)
$BuffWidth = $WinWidth
[int]$WinX = ($Config.Setup.WinX)
[int]$WinY = ($Config.Setup.WinY)
[int]$WinSX = ($Config.Setup.WinSX)
[int]$WinSY = ($Config.Setup.WinSY)
[int]$WinSMX = ($Config.Setup.WinSMX)
[int]$WinSMY = ($Config.Setup.WinSMY)
if (!($AWinHeight)) {
    $AWinHeight = 44
    $ABuffHeight = $AWinHeight
}
if (!($AWinWidth)) {
    $AWinWidth = 65
    $ABuffWidth = $AWinWidth
}
$PosTest = Test-Path -Path ($Base + "\Put-WinPosition.ps1")
if (!($WinSMX)) { $WinSMX = 1 }
if (!($WinSMX)) { $WinSMY = 1 }
if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinSMX -WinY $WinSMY -Width 550 -Height 650 | Out-Null }
while (1) {
    if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinSMX -WinY $WinSMY | Out-Null }
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
        $Script:AddCount
    }
    SpinItems
    Function FlexWindow {
        $SaveError = $ErrorActionPreference
        $ErrorActionPreference = "SilentlyContinue"
        $pshost = Get-Host
        $pswindow = $pshost.ui.rawui
        $newsize = $pswindow.buffersize
        [int]$newsize.height = $ABuffHeight
        [int]$newsize.width = $ABuffWidth
        $pswindow.buffersize = $newsize
        $newsize = $pswindow.windowsize
        [int]$newsize.height = $AWinHeight
        [int]$newsize.width = $AWinWidth
        $pswindow.windowsize = $newsize
        $ErrorActionPreference = $SaveError
    }
    FlexWindow
    if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinSMX -WinY $WinSMY | Out-Null }
    [string]$NormalLine = "~RED~#~~DARKRED~==============================================================~~RED~#~"
    [string]$TitleLine = "~DARKRED~|~~WHITE~>-=-=-=-=-=-=-=-<~~CYAN~[~~RED~BinMenu Settings Manager~~CYAN~]~~WHITE~>-=-=-=-=-=-=-=-=-<~~DARKRED~|~"
    [string]$LeftLine = "~DARKRED~|~"
    [string]$RightLine = "~DARKRED~|~"
    Function FuckOff {
        PrettyLine
        Say $blah
        [Console]::SetCursorPosition($w, ($pp + 1))
        #$Script:Fixer = Read-Host -Prompt $boop
        $Script:Fixer = Put-Input $boop
        if ($Fixer -eq "") { Clear-Variable -Name Fixer -Force -Scope Script }
        PrettyLine
        $Fixer
    }
    Function PrettyLine {
        [Console]::SetCursorPosition($w, $pp); Say -NoNewLine ""
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 1)); Say -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 2)); Say -NoNewLine "                                                                                         "
        #[Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        #[Console]::SetCursorPosition($w, ($pp + 3)); Say -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, $pp)
    }
    Function FightOn {
        PrettyLine; Say $Rich1
        [Console]::SetCursorPosition($w, ($pp + 1)); Say "Current Value:" $Fight1
        [Console]::SetCursorPosition($w, ($pp + 2)); $Script:Fight1 = Put-Input $boop
        if ($Fight1 -eq "") { Clear-Variable -Name Fight1 -Force -Scope Script }
        PrettyLine; Say $Rich2
        [Console]::SetCursorPosition($w, ($pp + 1)); Say "Current Value:" $Fight2
        [Console]::SetCursorPosition($w, ($pp + 2)); $Script:Fight2 = Put-Input $boop
        if ($Fight2 -eq "") { Clear-Variable -Name Fight2 -Force -Scope Script }
        PrettyLine; Say $Rich3
        [Console]::SetCursorPosition($w, ($pp + 1)); Say "Current Value:" $Fight3
        [Console]::SetCursorPosition($w, ($pp + 2)); $Script:Fight3 = Put-Input $boop
        if ($Fight3 -eq "") { Clear-Variable -Name Fight3 -Force -Scope Script }
        PrettyLine
        if ($Fight3 -eq "") { $Fight3 = "[No Argument]" }
        PrettyLine
        $Fight1; $Fight2; $Fight3
    }
    Clear-Host
    WC $NormalLine; WC $TitleLine; WC $NormalLine
    [int]$w = "1"; [int]$l = "3"; [int]$v = "3"
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~B~~DARKRED~)~~DARKCYAN~ase Folder~~WHITE~.................:~ ~DARKRED~[~~WHITE~$Base~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Set Ed~~DARKRED~(~~WHITE~I~~DARKRED~)~~DARKCYAN~tor~~WHITE~..................:~ ~DARKRED~[~~WHITE~$Editor~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~S~~DARKRED~)~~DARKCYAN~cript Base~~WHITE~.................:~ ~DARKRED~[~~WHITE~$ScriptBase~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~WHITE~N~~DARKRED~)~~DARKCYAN~otify with asay/notify~~WHITE~.....:~ ~DARKRED~[~~WHITE~$Notify~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Use Win ~~DARKRED~(~~WHITE~P~~DARKRED~)~~DARKCYAN~ositioning~~WHITE~.........:~ ~DARKRED~[~~WHITE~$WPosition~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~W~~DARKRED~)~~DARKCYAN~idth~~WHITE~................:~ ~DARKRED~[~~WHITE~$WinWidth~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~H~~DARKRED~)~DARKCYAN~eight~~WHITE~...............:~ ~DARKRED~[~~WHITE~$WinHeight~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~U~~DARKRED~)~~DARKCYAN~se Add Entries~~WHITE~.............:~ ~DARKRED~[~~WHITE~$MenuAdds~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~X~~DARKRED~)~ ~DARKCYAN~Position~~WHITE~................:~ ~DARKRED~[~~WHITE~$WinX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~Y~~DARKRED~)~ ~DARKCYAN~Position~~WHITE~................:~ ~DARKRED~[~~WHITE~$WinY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window ~~DARKRED~(~~WHITE~XX~~DARKRED~)~ ~DARKCYAN~Position~~WHITE~:~ ~DARKRED~[~~WHITE~$WinSMX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window ~~DARKRED~(~~WHITE~YY~~DARKRED~)~ ~DARKCYAN~Position~~WHITE~:~ ~DARKRED~[~~WHITE~$WinSMY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Scripts Window ~~DARKRED~(~~WHITE~XXX~~DARKRED~)~ ~DARKCYAN~Position~~WHITE~......:~ ~DARKRED~[~~WHITE~$WinSX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Scripts Window ~~DARKRED~(~~WHITE~YYY~~DARKRED~)~ ~DARKCYAN~Position~~WHITE~......:~ ~DARKRED~[~~WHITE~$WinSY~~DARKRED~]~"; $l++
    #[Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Number of Program Adds in JSON~~WHITE~: ~~DARKRED~[~~WHITE~$AddCount~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Options~~white~: ~~DARKRED~(~~WHITE~J~~DARKRED~)~~DARKCYAN~son~ ~DARKRED~(~~WHITE~A~~DARKRED~)~~DARKCYAN~dd~DARKRED~ (~~WHITE~D~DARKRED~)~~DARKCYAN~elete~~DARKRED~ (~~WHITE~E~~DARKRED~)~~DARKCYAN~dit~~DARKRED~ (~~WHITE~V~~DARKRED~)~~DARKCYAN~erify~~DARKRED~ (~~WHITE~R~~DARKRED~)~~DARKCYAN~un Entry~"; $l++
    [int]$i = 1; [int]$w = 1
    if ($MenuAdds -eq $True) {
        while ($i -le $AddCount) {
            $AddItem = "AddItem-$i"
            $it1 = ($Config.$AddItem).name
            $it2 = ($Config.$AddItem).Command
            $it2 = "$it2".split('\')[-1]
            if ($i -ge 10) { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~$i~~DARKRED~)~~WHITE~.:~ ~DARKRED~[~~WHITE~$it1~~DARKRED~] [~~GREEN~$it2~~DARKRED~]~" ; $l++ }
            else { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~WHITE~ $i~~DARKRED~)~~WHITE~.:~ ~DARKRED~[~~WHITE~$it1~~DARKRED~] [~~GREEN~$it2~~DARKRED~]~" ; $l++ }
            $i++
            $a++
        }
    }
    [int]$pp = $l; [int]$w = 0
    [Console]::SetCursorPosition($w, $pp); WC $NormalLine; $pp++
    $AWinHeight = ($pp + 4); $ABuffHeight = $AWinHeight
    PrettyLine; [int]$u = ($pp - 2)
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); WC $LeftLine; $v++ }
    [int]$v = 3; [int]$u = ($pp - 2); [int]$w = 63
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); WC $RightLine; $v++ }
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp)
    PrettyLine
    [Console]::SetCursorPosition($w, $pp)
    FlexWindow
    FlexWindow
    $pp = ($pp - 1)
    PrettyLine
    $pp++
    [Console]::SetCursorPosition($w, $pp)
    PrettyLine
    if ($ReRun -eq 1) { $ReRun = 0 }
    else { $pop = $($MenuPrompt = WCP "~DARKCYAN~[~~white~Run~ ~DARKYELLOW~BinMenu, Re~~DARKRED~(~~WHITE~L~~DARKRED~)~~DARKYELLOW~oad, ~DARKRED~(~~WHITE~#~~DARKRED~)~~DARKYELLOW~Number to view or ~~DARKRED~(~~WHITE~Q~~DARKRED~)~~DARKYELLOW~uit~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $menuPrompt) }
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($pop, [ref]$OutNumber)) {
        $MaxYes = $AddCount
        $MaxYes = [int][Math]::Ceiling($MaxYes)
        if ($OutNumber -gt 0 -and $OutNumber -le $MaxYes) {
            $v = $OutNumber
            $RI = "AddItem-$v"
            $vt1 = ($Config.$RI).name
            $vt2 = ($Config.$RI).Command
            $vt3 = ($Config.$RI).Argument
            $tw = 1
            $tp = 19
            [Console]::SetCursorPosition($tw, $tp)
            $i = 1
            while ($i -le $MaxYes) {
                [Console]::SetCursorPosition($tw, $tp); Say "                                                              "
                $i++
                $tp++
            }
            $tw = 1
            $tp = 19
            [Console]::SetCursorPosition($tw, $tp); $tp++; $tp++; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "    Name: $vt1"; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say " Command: $vt2"; $tp++; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "Argument: $vt3"; $tp++; $tp++
            [Console]::SetCursorPosition($tw, $tp); Read-Host -Prompt "[Enter to continue]"
        }
    }
    if ($pop -eq "B") {
        $blah = "Please enter the folder to set as Base"
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.Base = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        Set-Variable -Name Base -Value ($Config.Setup.Base) -Scope Global
    }
    if ($pop -eq "I") {
        $blah = "Please enter the Complete path and file name to your text editor"
        $boop = "path-file for editor or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.Editor = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [string]$Editor = ($Config.Setup.Editor)
    }
    if ($pop -eq "S") {
        $blah = "Please enter the folder where BinMenu is located."
        $boop = "BinMenu folder or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.ScriptBase = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [string]$ScriptBase = ($Config.Setup.ScriptBase)
    }
    if ($pop -eq "G") {
        if (($Config.Setup.DeBug) -eq 0) { $Config.Setup.DeBug = 1 }
        else { $Config.Setup.DeBug = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$DeBug = ($Config.Setup.DeBug)
        $pop = ""
    }
    if ($pop -eq "N") {
        if (($Config.Setup.Notify) -eq 0) { $Config.Setup.Notify = 1 }
        else { $Config.Setup.Notify = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$Notify = ($Config.Setup.Notify)
        $pop = ""
    }
    if ($pop -eq "P") {
        if (($Config.Setup.WPosition) -eq 1) { $Config.Setup.WPosition = 0 }
        else { $Config.Setup.WPosition = 1 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$WPosition = ($Config.Setup.WPosition)
    }
    if ($pop -eq "W") {
        $blah = "Please enter The Console Window Width."
        $boop = "Number of console Width or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.BuffWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.Setup.WinWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinWidth = ($Config.Setup.WinWidth)
        $BuffWidth = $WinWidth
    }
    if ($pop -eq "H") {
        $blah = "Please enter The Console Window Height."
        $boop = "Number of console Height or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.BuffHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.Setup.WinHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinHeight = ($Config.Setup.WinHeight)
        $BuffHeight = $WinHeight
    }
    if ($pop -eq "U") {
        if (($Config.Setup.MenuAdds) -eq 1) { $Config.Setup.MenuAdds = 0 }
        else { $Config.Setup.MenuAdds = 1 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$MenuAdds = ($Config.Setup.MenuAdds)
        if ($MenuAdds -eq 1) {
            $AWinHeight = 46
            if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinSMX -WinY $WinSMY -Width 550 -Height 800 | Out-Null }
        }
        $pop = ""
    }
    if ($pop -eq "X") {
        $blah = "Please enter the window position from LEFT."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.WinX = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinX = ($Config.Setup.WinX)
    }
    if ($pop -eq "Y") {
        $blah = "Please enter the window position from TOP."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.WinY = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinY = ($Config.Setup.WinY)
    }
    if ($pop -eq "XX") {
        $blah = "Please enter the window position from LEFT."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.WinSMX = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSMX = ($Config.Setup.WinSMX)
    }
    if ($pop -eq "YY") {
        $blah = "Please enter the window position from TOP."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.WinSMY = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSMY = ($Config.Setup.WinSMY)
    }
    if ($pop -eq "XXX") {
        $blah = "Please enter the window position from LEFT."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.WinSX = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSX = ($Config.Setup.WinSX)
    }
    if ($pop -eq "YYY") {
        $blah = "Please enter the window position from TOP."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.WinSY = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSY = ($Config.Setup.WinSY)
    }
    if ($pop -eq "J") {
        $go1 = ($ScriptBase + "\BinMenu.ini")
        $go2 = ($ScriptBase + "\BinMenu.json")
        $goall = "$go1 $go2"
        Start-Process $Editor -ArgumentList $goall -Verb RunAs
    }
    if ($pop -eq "A") {
        SpinItems
        $qq = ($AddCount + 1)
        $AddItem = "AddItem-$qq"
        $test = @{ Name = ""; Command = ""; Argument = "" }
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config | Add-Member -Type NoteProperty -Name $AddItem -Value $test
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        SpinItems
    }
    if ($pop -eq "D") {
        SpinItems
        [int]$qq = $AddCount
        PrettyLine
        Say "Enter the Number of AddItem to Delete."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter for $qq]"
        PrettyLine
        if ($q1 -eq "") { $q1 = $qq }
        $AddItem = "AddItem-$q1"
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config = $Config | Select-Object -Property * -ExcludeProperty $AddItem
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        while ($q1 -le $AddCount) {
            $AddItem = "AddItem-$q1"
            $Fix1 = ($q1 + 1)
            $AddFix = "AddItem-$Fix1"
            $fixcheck = ($Config.$AddFix).Name
            if (($fixcheck)) {
                <# Read #>
                $f1 = ($Config.$AddFix).Name
                $f2 = ($Config.$AddFix).Command
                $f3 = ($Config.$AddFix).Argument
                $Fixer = @{ Name = "$f1"; Command = "$f2"; Argument = "$f3" }
                <# Write #>
                $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
                $Config | Add-Member -Type NoteProperty -Name $AddItem -Value $Fixer
                $Config | ConvertTo-Json | Set-Content $ConfigFile
                <# Delete #>
                $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
                $Config = $Config | Select-Object -Property * -ExcludeProperty $AddFix
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            $q1++
        }
        SpinItems
    }
    if ($pop -eq "E") {
        PrettyLine
        Say "Enter the Number of AddItem to Edit."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $AddItem = "AddItem-$q1"
            $rich1 = "Please enter the NAME or Title of the program for this entry."
            $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
            $rich3 = "Please enter any ARGUMENTS you need for this entry."
            $boop = "[OK for No Change]"
            $Fight1 = ($Config.$AddItem).Name
            $Fight2 = ($Config.$AddItem).Command
            $Fight3 = ($Config.$AddItem).Argument
            if ($Fight3 -eq "") { $Fight3 = "[No Argument]" }
            FightOn
            PrettyLine
            if (($Fight1)) {
                $Config.$AddItem.Name = $Fight1
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if (($Fight2)) {
                $Config.$AddItem.Command = $Fight2
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if (($Fight3)) {
                $Config.$AddItem.Argument = $Fight3
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
        }
        PrettyLine
    }
    if ($pop -eq "V") {
        PrettyLine; Say "Enter the Number of RunItem to Verify."; [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        [Console]::SetCursorPosition($w, $pp); Say "                                                               "
        PrettyLine
        if (($q1)) {
            $AddItem = "AddItem-$q1"
            $GoodToGo = "ERROR"
            $TestRun1 = ($Config.$AddItem).Name
            $TestRun2 = ($Config.$AddItem).Command
            $TestRun3 = ($Config.$AddItem).Argument
            if (($TestRun1)) { $GTG1 = "YES" }
            else { $GTG1 = "NO" }
            if (($TestRun2)) {
                $Filetest = Test-Path -Path $TestRun2
                if (($Filetest)) { $GTG2 = "YES" }
                else { $GTG2 = "NO" }
            }
            PrettyLine
            if ($GTG1 -eq "YES" -and $GTG2 -eq "YES") { $GoodToGo = "Verified" }
            Read-Host -Prompt "$GoodToGo [Enter to Continue]"
        }
    }
    if ($pop -eq "R") {
        PrettyLine
        Say "Enter the Number of AddItem to Run."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $AddItem = "AddItem-$q1"
            $TestRun1 = ($Config.$AddItem).Name
            $TestRun2 = ($Config.$AddItem).Command
            $TestRun3 = ($Config.$AddItem).Argument
            Say "Test Running Entry" $q1 $TestRun1
            if (($TestRun3)) { Start-Process -FilePath $TestRun2 -ArgumentList $TestRun3 }
            else { Start-Process -FilePath $TestRun2 }
        }
    }
    PrettyLine
    if ($pop -eq "L") { Start-Process "pwsh.exe" -ArgumentList ($ScriptBase + '\BinSM.ps1') -Verb RunAs; Clear-Host; return }
    #if ($pop -eq "RUN") { Start-Process "pwsh.exe" -ArgumentList ($ScriptBase + '\BinMenu.lnk') -Verb RunAs; Clear-Host; return }
    if ($pop -eq "RUN") { Start-Process ($ScriptBase + '\BinMenu.lnk'); Clear-Host; return }
    if ($pop -eq "Q") { return }
    if ($pop -eq "QUIT") { return }
    FlexWindow
    PrettyLine
}
