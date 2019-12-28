$FileVersion = "Version: 1.3.23"
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
if (!($BASE)) { Set-Variable -Name Base -Value ($Config.basic.Base) -Scope Global }
if (!($BASE)) { Say -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $BASE.substring(0, 3)
Set-Location $BASE
[string]$Editor = ($Config.Basic.Editor)
[bool]$TestRun = ($Config.Basic.TestRun)
[int]$WinX = ($Config.Basic.WinX)
[int]$WinY = ($Config.Basic.WinY)
[int]$WinSMX = ($Config.Basic.WinSMX)
[int]$WinSMY = ($Config.Basic.WinSMY)
[int]$StartDelay = ($Config.Basic.StartDelay)
[int]$Delay = ($Config.Basic.Delay)
[bool]$Prevent = ($Config.Basic.Prevent)
[bool]$Notify = ($Config.Basic.Notify)
[int]$WinWidth = ($Config.Basic.WinWidth)
[int]$WinHeight = ($Config.Basic.WinHeight)
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
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~B~~DARKRED~)~~DARKCYAN~ase Folder~~WHITE~................: ~~DARKRED~[~~WHITE~$BASE~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Set Ed~~DARKRED~(~~WHITE~I~~DARKRED~)~~DARKCYAN~tor~WHITE~.................: ~~DARKRED~[~~WHITE~$Editor~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~S~~DARKRED~)~~DARKCYAN~tartUp Delay (Secs)~~WHITE~.......: ~~DARKRED~[~~WHITE~$StartDelay~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Dela~~DARKRED~(~~WHITE~Y~~DARKRED~)~ ~DARKCYAN~Between Program Runs~~WHITE~.: ~~DARKRED~[~~WHITE~$Delay~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~P~~DARKRED~)~~DARKCYAN~revent From Running~~WHITE~.......: ~~DARKRED~[~~WHITE~$Prevent~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~N~~DARKRED~)~~DARKCYAN~otify with asay/notify~~WHITE~....: ~~DARKRED~[~~WHITE~$Notify~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~T~~DARKRED~)~~DARKCYAN~est Run Shooting Blanks~~WHITE~...: ~~DARKRED~[~~WHITE~$TestRun~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~W~~DARKRED~)~~DARKCYAN~idth~~WHITE~...............: ~~DARKRED~[~~WHITE~$WinWidth~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~H~~DARKRED~)~~DARKCYAN~eight~~WHITE~..............: ~~DARKRED~[~~WHITE~$WinHeight~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window Position ~~DARKRED~(~~WHITE~X~~DARKRED~)~~WHITE~.................: ~~DARKRED~[~~WHITE~$WinX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window Position ~~DARKRED~(~~WHITE~Y~~DARKRED~)~~WHITE~.................: ~~DARKRED~[~~WHITE~$WinY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window Position ~~DARKRED~(~~WHITE~XX~~DARKRED~)~~WHITE~.: ~~DARKRED~[~~WHITE~$WinSMX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window Position ~~DARKRED~(~~WHITE~YY~~DARKRED~)~~WHITE~.: ~~DARKRED~[~~WHITE~$WinSMY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Num of Program Runs in JSON~~WHITE~..: ~~DARKRED~[~~WHITE~$AddCount~~DARKRED~]~"; $l++
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
        if ($i -lt "10") { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~WHITE~$i~~DARKRED~]~~WHITE~..: $it1~ ~DARKRED~[~~yellow~Host:~ ~GREEN~$it2~~DARKRED~][~~DARKCYAN~$it3~~DARKRED~]~"; $l++ }
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
    else { $pop = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~Your Selection Re~~DARKRED~(~~WHITE~L~~DARKRED~)~~DARKYELLOW~oad or ~~DARKRED~(~~WHITE~Q~~DARKRED~)~~DARKYELLOW~uit~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $menuPrompt) }
    if ($pop -eq "B") {
        $blah = "Please enter the folder to set as BASE."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Base = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        Set-Variable -Name Base -Value ($Config.basic.Base) -Scope Global
    }
    if ($pop -eq "S") {
        $blah = "Please enter the seconds to delay start."
        $boop = "Seconds to delay start or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.StartDelay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$StartDelay = ($Config.basic.StartDelay)
    }
    if ($pop -eq "Y") {
        $blah = "Please enter the seconds to delay between each."
        $boop = "Seconds to delay between or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Delay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$Delay = ($Config.basic.Delay)
    }
    if ($pop -eq "P") {
        if (($Config.basic.Prevent) -eq 0) { $Config.basic.Prevent = 1 }
        else { $Config.basic.Prevent = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$Prevent = ($Config.basic.Prevent)
    }
    if ($pop -eq "N") {
        if (($Config.basic.Notify) -eq 0) { $Config.basic.Notify = 1 }
        else { $Config.basic.Notify = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$Notify = ($Config.basic.Notify)
    }
    if ($pop -eq "T") {
        if (($Config.basic.TestRun) -eq 0) { $Config.basic.TestRun = 1 }
        else { $Config.basic.TestRun = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$TestRun = ($Config.basic.TestRun)
    }
    if ($pop -eq "W") {
        $blah = "Please enter The Console Window Width."
        $boop = "Number of console Width or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.BuffWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.basic.WinWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinWidth = ($Config.basic.WinWidth)
    }
    if ($pop -eq "H") {
        $blah = "Please enter The Console Height."
        $boop = "Number of console Height or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.BuffHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.basic.WinHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinHeight = ($Config.basic.WinHeight)
    }
    if ($pop -eq "I") {
        $blah = "Please enter the Complete path and file name to your text editor"
        $boop = "path-file for editor or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Editor = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [string]$Editor = ($Config.basic.Editor)
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
            $Config.basic.WinX = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinX = ($Config.basic.WinX)
    }
    if ($pop -eq "Y") {
        $blah = "Please enter the window position from TOP."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.WinY = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinY = ($Config.basic.WinY)
    }
    if ($pop -eq "XX") {
        $blah = "Please enter the window position from LEFT."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.WinSMX = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSMX = ($Config.basic.WinSMX)
    }
    if ($pop -eq "YY") {
        $blah = "Please enter the window position from TOP."
        $boop = "Number of window position or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.WinSMY = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$WinSMY = ($Config.basic.WinSMY)
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
            $rich2A = "Enter the HOSTNAME that this will run on. [Hostname, All or NONE]"
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
            if ($TestRun2 -ne $env:USERDOMAIN) {
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
