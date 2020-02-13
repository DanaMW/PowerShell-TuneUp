$FileVersion = "Version: 1.3.30"
$host.ui.RawUI.WindowTitle = "Delay-StartUp Settings Manager $FileVersion"
Function Get-ScriptDir { Split-Path -parent $PSCommandPath }
Function MyConfig {
    $Script:MyConfig = $(Get-ScriptDir) + "\Delay-StartUp.json"
    $MyConfig
}
$Script:ConfigFile = MyConfig
try { $Script:Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "The Base configuration file is missing!"; break }
if (!($Config)) {
    Say -ForeGroundColor RED "The BinMenu.json configuration file is missing!"
    Say -ForeGroundColor RED "You need to create or edit BinMenu.json in" $BASE
    break
}
$BASE = $env:Base
if (!($BASE)) { Set-Variable -Name Base -Value ($Config.Setup.Base) -Scope Global }
if (!($BASE)) { Say -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $BASE.substring(0, 3)
Set-Location $BASE
[string]$Editor = ($Config.Setup.Editor)
[bool]$TestRun = ($Config.Setup.TestRun)
[int]$WinX = ($Config.Setup.WinX)
[int]$WinY = ($Config.Setup.WinY)
[int]$WinSMX = ($Config.Setup.WinSMX)
[int]$WinSMY = ($Config.Setup.WinSMY)
[bool]$WPosition = ($Config.Setup.WPosition)
[int]$StartDelay = ($Config.Setup.StartDelay)
[int]$Delay = ($Config.Setup.Delay)
[bool]$Prevent = ($Config.Setup.Prevent)
[bool]$Notify = ($Config.Setup.Notify)
[int]$WinWidth = ($Config.Setup.WinWidth)
[int]$WinHeight = ($Config.Setup.WinHeight)
[int]$BuffWidth = $WinWidth
[int]$BuffHeight = $WinHeight
if (!($BWHeight)) { $BWHeight = "37" }
if (!($BWWidth)) { $BWWidth = "66" }
$PosTest = Test-Path -path ($BASE + "\Put-WinPosition.ps1")
if (!($WinSMX)) { $WinSMX = 690 }
if (!($WinSMY)) { $WinSMY = 205 }
if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinSMX -WinY $WinSMY -Width 800 -Height 800 | Out-Null }
[string]$NormalLine = "~RED~+~~DARKRED~===============================================================~~RED~+~"
[string]$TitleLine = "~DARKRED~|~~WHITE~>-=-=-=-=-=-=-=<~~CYAN~[~~RED~Delay-StartUp Settings Manager~~CYAN~]~~WHITE~>-=-=-=-=-=-=-<~~DARKRED~|~"
[string]$LeftLine = "~DARKRED~|~"
[string]$RightLine = "~DARKRED~|~"
while (1) {
    Function FlexWindow {
        $SaveError = $ErrorActionPreference
        $ErrorActionPreference = "SilentlyContinue"
        if (!($BWHeight)) { $BWHeight = "37" }
        if (!($BWWidth)) { $BWWidth = "90" }
        $pshost = Get-Host
        $pswindow = $pshost.ui.rawui
        $newsize = $pswindow.buffersize
        $newsize.height = $BWHeight
        $newsize.width = $BWWidth
        $pswindow.buffersize = $newsize
        $newsize = $pswindow.windowsize
        $newsize.height = $BWHeight
        $newsize.width = $BWWidth
        $pswindow.windowsize = $newsize
        $ErrorActionPreference = $SaveError
    }
    FlexWindow
    if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinSMX -WinY $WinSMY | Out-Null }
    FlexWindow
    Function FuckOff {
        PrettyLine
        Say $blah
        [Console]::SetCursorPosition($w, ($pp + 1))
        $Script:Fixer = Read-Host -Prompt $boop
        PrettyLine
        $Fixer
    }
    Function SpinItems {
        $si = 1
        $Sc = 20
        $Script:AddCount = 0
        While ($si -lt $sc) {
            $RunItem = "RunItem-$si"
            $Spin = ($Config.$RunItem.name)
            if ($null -ne $Spin) { $Script:AddCount++; $si++ }
            else { $si = 20 }
        }
        $Script:AddCount
    }
    SpinItems
    Function PrettyLine {
        [Console]::SetCursorPosition($w, $pp); Say -NoNewLine "                                                             "
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 1)); Say -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 2)); Say -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 3)); Say -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, $pp)
    }
    Function FightOn {
        PrettyLine
        Say $Rich1A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Say $rich1B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight1 = Read-Host -Prompt $boop
        PrettyLine
        Say $Rich2A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Say $rich2B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight2 = Read-Host -Prompt $boop
        PrettyLine
        Say $Rich3A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Say $rich3B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight3 = Read-Host -Prompt $boop
        PrettyLine
        Say $Rich4A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Say $rich4B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight4 = Read-Host -Prompt $boop
        PrettyLine
        $Fight1
        $Fight2
        $Fight3
        $Fight4
    }
    Clear-Host
    SpinItems
    [int]$l = 0
    [int]$w = 0
    [Console]::SetCursorPosition($w, $l); WC $NormalLine; $l++
    [Console]::SetCursorPosition($w, $l); WC $TitleLine; $l++
    [Console]::SetCursorPosition($w, $l); WC $NormalLine; $l++
    [int]$w = 1
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~B~~DARKRED~)~~DARKCYAN~ase Folder~~WHITE~...................: ~~DARKRED~[~~WHITE~$BASE~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Set Ed~~DARKRED~(~~WHITE~I~~DARKRED~)~~DARKCYAN~tor~WHITE~....................: ~~DARKRED~[~~WHITE~$Editor~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~S~~DARKRED~)~~DARKCYAN~tartUp Delay (Secs)~~WHITE~..........: ~~DARKRED~[~~WHITE~$StartDelay~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~DELAY~~DARKRED~)~~DARKCYAN~ Between Program Runs~~WHITE~....: ~~DARKRED~[~~WHITE~$Delay~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~P~~DARKRED~)~~DARKCYAN~revent From Running~~WHITE~..........: ~~DARKRED~[~~WHITE~$Prevent~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~N~~DARKRED~)~~DARKCYAN~otify with asay/notify~~WHITE~.......: ~~DARKRED~[~~WHITE~$Notify~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~T~~DARKRED~)~~DARKCYAN~est Run Shooting Blanks~~WHITE~......: ~~DARKRED~[~~WHITE~$TestRun~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~UP~~DARKRED~)~~DARKCYAN~Use Positioning for Window~~WHITE~..: ~~DARKRED~[~~WHITE~$WPosition~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~W~~DARKRED~)~~DARKCYAN~idth~~WHITE~......................: ~~DARKRED~[~~WHITE~$WinWidth~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~H~~DARKRED~)~~DARKCYAN~eight~~WHITE~.....................: ~~DARKRED~[~~WHITE~$WinHeight~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window Position ~~DARKRED~(~~WHITE~X~~DARKRED~)~~WHITE~.................: ~~DARKRED~[~~WHITE~$WinX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window Position ~~DARKRED~(~~WHITE~Y~~DARKRED~)~~WHITE~.................: ~~DARKRED~[~~WHITE~$WinY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window Position ~~DARKRED~(~~WHITE~XX~~DARKRED~)~~WHITE~.: ~~DARKRED~[~~WHITE~$WinSMX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window Position ~~DARKRED~(~~WHITE~YY~~DARKRED~)~~WHITE~.: ~~DARKRED~[~~WHITE~$WinSMY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Programs in JSON~ ~DARKRED~[~~WHITE~$AddCount~~DARKRED~], (~~WHITE~TOG~~DARKRED~)~~DARKCYAN~gle ON~~darkred~/~~darkcyan~OFF~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Options~~white~: ~~DARKRED~(~~WHITE~J~~DARKRED~)~~DARKCYAN~SON ~~DARKRED~(~~WHITE~A~~DARKRED~)~~DARKCYAN~dd~~DARKRED~ (~~WHITE~D~~DARKRED~)~~DARKCYAN~elete~~DARKRED~ (~~WHITE~E~~DARKRED~)~DARKCYAN~dit~~DARKRED~ (~~WHITE~V~~DARKRED~)~~DARKCYAN~erify~~DARKRED~ (~~WHITE~R~~DARKRED~)~~DARKCYAN~un Entry~"; $l++
    [int]$v = 3
    [int]$i = 1
    [int]$w = 1
    while ($i -le $AddCount) {
        $RunItem = "RunItem-$i"
        $it1 = ($Config.$RunItem).name
        $it2 = ($Config.$RunItem).HostOnly
        $it3 = ($Config.$RunItem).RunPath
        $it3 = "$it3".split('\')[-1]
        if ($i -lt "10") { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~WHITE~ $i~~DARKRED~]~~WHITE~.: $it1~ ~DARKRED~[~~yellow~Host:~ ~GREEN~$it2~~DARKRED~][~~DARKCYAN~$it3~~DARKRED~]~"; $l++ }
        if ($i -ge "10") { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~WHITE~$i~~DARKRED~]~~WHITE~.: $it1~ ~DARKRED~[~~yellow~Host:~ ~GREEN~$it2~~DARKRED~][~~DARKCYAN~$it3~~DARKRED~]~"; $l++ }
        $i++
        $a++
    }
    $w = 0
    [int]$pp = $l
    [Console]::SetCursorPosition($w, $pp); WC $NormalLine
    $pp++
    $BWHeight = ($pp + 5)
    PrettyLine
    [int]$u = ($pp - 1)
    While ($v -le $u) {
        [Console]::SetCursorPosition($w, $v); WC $LeftLine
        $v++
    }
    [int]$v = 3
    [int]$u = ($pp - 2)
    [int]$w = 64
    While ($v -le $u) {
        [Console]::SetCursorPosition($w, $v); WC $RightLine
        $v++
    }
    [int]$pp = ($l + 1)
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp)
    FlexWindow
    FlexWindow
    [Console]::SetCursorPosition($w, $pp)
    if (($Drop2Edit)) {
        $Pop = "E"
        $Drop2Edit = 0
    }
    else { $pop = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~Option, Re~~DARKRED~(~~WHITE~L~~DARKRED~)~~DARKYELLOW~oad, ~DARKRED~(~~WHITE~#~~DARKRED~)~~DARKYELLOW~Number to view or ~~DARKRED~(~~WHITE~Q~~DARKRED~)~~DARKYELLOW~uit~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $menuPrompt) }
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($pop, [ref]$OutNumber)) {
        $MaxYes = $AddCount
        $MaxYes = [int][Math]::Ceiling($MaxYes)
        if ($OutNumber -gt 0 -and $OutNumber -le $MaxYes) {
            $v = $OutNumber
            $RI = "RunItem-$v"
            $vt1 = ($Config.$RI).name
            $vt2 = ($Config.$RI).HostOnly
            $vt3 = ($Config.$RI).RunPath
            $vt4 = ($Config.$RI).Argument
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
            [Console]::SetCursorPosition($tw, $tp); Say "    Host: $vt2"; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say " Program: $vt3"; $tp++; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "Argument: $vt4"; $tp++; $tp++
            [Console]::SetCursorPosition($tw, $tp); Read-Host -Prompt "[Enter to continue]"
        }
    }
    if ($pop -eq "B") {
        $blah = "Please enter the folder to set as BASE."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.Base = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        Set-Variable -Name Base -Value ($Config.Setup.Base) -Scope Global
    }
    if ($pop -eq "S") {
        $blah = "Please enter the seconds to delay start."
        $boop = "Seconds to delay start or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.StartDelay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$StartDelay = ($Config.Setup.StartDelay)
    }
    if ($pop -eq "DELAY") {
        $blah = "Please enter the seconds to delay between each."
        $boop = "Seconds to delay between or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.Delay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$Delay = ($Config.Setup.Delay)
    }
    if ($pop -eq "P") {
        if (($Config.Setup.Prevent) -eq 0) { $Config.Setup.Prevent = 1 }
        else { $Config.Setup.Prevent = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$Prevent = ($Config.Setup.Prevent)
    }
    if ($pop -eq "N") {
        if (($Config.Setup.Notify) -eq 0) { $Config.Setup.Notify = 1 }
        else { $Config.Setup.Notify = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$Notify = ($Config.Setup.Notify)
    }
    if ($pop -eq "T") {
        if (($Config.Setup.TestRun) -eq 0) { $Config.Setup.TestRun = 1 }
        else { $Config.Setup.TestRun = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$TestRun = ($Config.Setup.TestRun)
    }
    if ($pop -eq "UP") {
        if (($Config.Setup.WPosition) -eq 0) { $Config.Setup.WPosition = 1 }
        else { $Config.Setup.WPosition = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$WPosition = ($Config.Setup.WPosition)
    }
    if ($pop -eq "W") {
        $blah = "Please enter The Console Window Width."
        $boop = "Number of console Width or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.BuffWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.Setup.WinWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinWidth = ($Config.Setup.WinWidth)
    }
    if ($pop -eq "H") {
        $blah = "Please enter The Console Height."
        $boop = "Number of console Height or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.BuffHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.Setup.WinHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinHeight = ($Config.Setup.WinHeight)
    }
    if ($pop -eq "I") {
        $blah = "Please enter the Complete path and file name to your text editor"
        $boop = "path-file for editor or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.Editor = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [string]$Editor = ($Config.Setup.Editor)
    }
    if ($pop -eq "J") {
        $go = ($BASE + "\Delay-StartUp.json")
        Start-Process $Editor -ArgumentList $go -Verb RunAs
        PrettyLine
    }
    if ($pop -eq "X") {
        $blah = "Please enter the window position from LEFT."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.WinX = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinX = ($Config.Setup.WinX)
    }
    if ($pop -eq "Y") {
        $blah = "Please enter the window position from TOP."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.WinY = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinY = ($Config.Setup.WinY)
    }
    if ($pop -eq "XX") {
        $blah = "Please enter the window position from LEFT."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.WinSMX = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSMX = ($Config.Setup.WinSMX)
    }
    if ($pop -eq "YY") {
        $blah = "Please enter the window position from TOP."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.Setup.WinSMY = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSMY = ($Config.Setup.WinSMY)
    }
    if ($pop -eq "A") {
        SpinItems
        $qq = ($AddCount + 1)
        $RunItem = "RunItem-$qq"
        $test = @{Name = ""; HostOnly = ""; RunPath = ""; Argument = "" }
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config | Add-Member -Type NoteProperty -Name $RunItem -Value $test
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        SpinItems
        $Drop2Edit = 1
    }
    if ($pop -eq "D") {
        SpinItems
        [int]$qq = $AddCount
        PrettyLine
        Say "Enter the Number of RunItem to remove."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter for $qq]"
        PrettyLine
        if ($q1 -eq "") { $q1 = $qq }
        $RunItem = "RunItem-$q1"
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config = $Config | Select-Object -Property * -ExcludeProperty $RunItem
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        while ($q1 -le $AddCount) {
            $RunItem = "RunItem-$q1"
            $Fix1 = ($q1 + 1)
            $RunFix = "RunItem-$Fix1"
            $fixcheck = ($Config.$RunFix).Name
            if (($fixcheck)) {
                <# Read #>
                $f1 = ($Config.$RunFix).Name
                $f2 = ($Config.$RunFix).HostOnly
                $f3 = ($Config.$RunFix).RunPath
                $f4 = ($Config.$RunFix).Argument
                $Fixer = @{ Argument = "$f4"; RunPath = "$f3"; HostOnly = "$f2"; Name = "$f1" }
                <# Write #>
                $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
                $Config | Add-Member -Type NoteProperty -Name $RunItem -Value $Fixer
                $Config | ConvertTo-Json | Set-Content $ConfigFile
                <# Delete #>
                $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
                $Config = $Config | Select-Object -Property * -ExcludeProperty $RunFix
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            $q1++
        }
        SpinItems
    }
    if ($pop -eq "E") {
        PrettyLine
        Say "Enter the Number of RunItem to Edit."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $RunItem = "RunItem-$q1"
            $Script:Fight1 = ($Config.$RunItem).Name
            $Script:Fight2 = ($Config.$RunItem).HostOnly
            $Script:Fight3 = ($Config.$RunItem).RunPath
            $Script:Fight4 = ($Config.$RunItem).Argument
            $rich1A = "Please enter the NAME or Title of the program for this entry."
            $rich1B = "Current Value: $Fight1"
            $rich2A = "Enter the HOSTNAME that this will run on. [Hostname, ON or OFF]"
            $rich2B = "Current Value: $Fight2"
            $Rich3A = "Please enter the COMPLETE PATH and FILENAME for this entry"
            $Rich3B = "Current Value: $Fight3"
            $rich4A = "Please enter any ARGUMENTS you need for this entry."
            $rich4B = "Current Value: $Fight4"
            $boop = "[ENTER for No Change or - to Clear]"
            FightOn
            if ($Fight1 -ne "") {
                if ($Fight1 -eq "-") { $Fight1 = "" }
                $Config.$RunItem.Name = $Fight1
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight2 -ne "") {
                if ($Fight2 -eq "-") { $Fight2 = "" }
                $Config.$RunItem.HostOnly = $Fight2
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight3 -ne "") {
                if ($Fight3 -eq "-") { $Fight3 = "" }
                $Config.$RunItem.RunPath = $Fight3
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight4 -ne "") {
                if ($Fight4 -eq "-") { $Fight4 = "" }
                $Config.$RunItem.Argument = $Fight4
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
        }
        $Pop = ""
    }
    if ($pop -eq "V") {
        PrettyLine
        Say "Enter the Number of RunItem to Verify."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $RunItem = "RunItem-$q1"
            $GoodToGo = "ERROR"
            $TestRun1 = ($Config.$RunItem).Name
            $TestRun2 = ($Config.$RunItem).HostOnly
            $TestRun3 = ($Config.$RunItem).RunPath
            #$TestRun4 = ($Config.$RunItem).Argument
            if (($TestRun1)) { $GTG1 = "YES" }
            else { $GTG1 = "NO" }
            if (($TestRun2)) { $GTG2 = "YES" }
            else { $GTG2 = "NO" }
            if (($TestRun3)) {
                $Filetest = Test-Path -path $TestRun3
                if ($Filetest -eq $true) { $GTG3 = "YES" }
                else { $GTG3 = "NO" }
            }
            if ($GTG1 -eq "YES" -and $GTG2 -eq "YES" -and $GTG3 -eq "YES") { $GoodToGo = "Verified" }
            Read-Host -Prompt "$GoodToGo [Enter to Continue]"
        }
    }
    if ($pop -eq "TOG") {
        PrettyLine
        Say "Enter the Number of RunItem to Toggle Off/ON."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $RunItem = "RunItem-$q1"
            $Toggle = ($Config.$RunItem).HostOnly
            if ($toggle -eq "OFF") {
                $Fight = "ON"
                $Config.$RunItem.HostOnly = $Fight
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($toggle -eq "ON") {
                $Fight = "OFF"
                $Config.$RunItem.HostOnly = $Fight
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($toggle -eq $env:USERDOMAIN) {
                $Fight = "OFF"
                $Config.$RunItem.HostOnly = $Fight
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
        }
        $Pop = ""
    }
    if ($pop -eq "R") {
        PrettyLine
        Say "Enter the Number of RunItem to Execute."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $RunItem = "RunItem-$q1"
            $TestRun1 = ($Config.$RunItem).Name
            $TestRun2 = ($Config.$RunItem).HostOnly
            $TestRun3 = ($Config.$RunItem).RunPath
            $TestRun4 = ($Config.$RunItem).Argument
            if ($TestRun2 -ne $env:USERDOMAIN -and $TestRun2 -ne "ON") {
                Say "You are running this on $env:USERDOMAIN and it is configured for $TestRun2..."
                [Console]::SetCursorPosition($w, ($pp + 1))
                $fool = Read-Host -Prompt "Y to continue this foolishness or [Enter to Cancel]"
                PrettyLine
                if ($Fool -eq "Y") {
                    Say "Test Running Entry $q1 $TestRun1"
                    if ($TestRun4 -ne "") { Start-Process -FilePath "$TestRun3" -ArgumentList $TestRun4 }
                    else { Start-Process -FilePath $TestRun3 }
                }
            }
            else {
                Say "Test Running Entry $q1 $TestRun1"
                if ($TestRun4 -ne "") { Start-Process -FilePath "$TestRun3" -ArgumentList $TestRun4 }
                else { Start-Process -FilePath $TestRun3 }
            }
        }
    }
    PrettyLine
    if ($pop -eq "L") { PrettyLine; & Start-Process "pwsh.exe" -ArgumentList "$PSScriptRoot\DelaySM.ps1 -NoLogo -NoProfile"; return }
    if ($pop -eq "Q") { return }
    $Pop = ""
    PrettyLine
}
