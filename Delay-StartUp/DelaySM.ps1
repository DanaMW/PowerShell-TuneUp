$FileVersion = "1.5.20"
$host.ui.RawUI.WindowTitle = "Delay-StartUp Settings Manager $FileVersion"
if (!($ScriptBase)) { $ScriptBase = (Split-Path -Parent $PSCommandPath) }
Function Get-ScriptDir { Split-Path -Parent $PSCommandPath }
Function MyConfig {
    $Script:MyConfig = ($ScriptBase + "\Delay-StartUp.json")
    $MyConfig
}
$Script:ConfigFile = MyConfig
try { $Script:Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "The Base configuration file is missing!"; break }
if (!($Config)) {
    Say -ForeGroundColor RED "The Delay-StartUp.json configuration file is missing!"
    Say -ForeGroundColor RED "You need to create or edit DelayStartUp.json in $BASE"
    break
}
$BASE = $env:Base
if (!($BASE)) { Set-Variable -Name Base -Value ($Config.Setup.Base) -Scope Global }
if (!($BASE)) { Say -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $BASE.substring(0, 3)
Set-Location $BASE
$ScriptBase = (Split-Path -Parent $PSCommandPath)
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
[bool]$SysShow = ($Config.Setup.SysShow)
[bool]$Pause = ($Config.Setup.Pause)
[int]$PauseSec = ($Config.Setup.PauseSec)
[string]$PauseOpt = ($Config.Setup.PauseOpt)
[int]$WinWidth = ($Config.Setup.WinWidth)
[int]$WinHeight = ($Config.Setup.WinHeight)
[int]$BuffWidth = $WinWidth
[int]$BuffHeight = $WinHeight
if (!($BWHeight)) { $BWHeight = "40" }
if (!($BWWidth)) { $BWWidth = "70" }
$PosTest = Test-Path -Path ($BASE + "\Put-WinPosition.ps1")
if (!($WinSMX)) { $WinSMX = 690 }
if (!($WinSMY)) { $WinSMY = 205 }
# Bad Error caused by below before/ Working now
if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinSMX -WinY $WinSMY -Width "100" -Height "50" | Out-Null }
[string]$NormalLine = "~RED~#~~DARKRED~===================================================================~~RED~#~"
[string]$TitleLine = "~DARKRED~|~~WHITE~>-=-=-=-=-=-=-=-=<~~CYAN~[~~RED~Delay-StartUp Settings Manager~~CYAN~]~~WHITE~>-=-=-=-=-=-=-=-<~~DARKRED~|~"
[string]$LeftLine = "~DARKRED~|~"
[string]$RightLine = "~DARKRED~|~"
while (1) {
    Function FlexWindow {
        $SaveError = $ErrorActionPreference
        $ErrorActionPreference = "SilentlyContinue"
        if (!($BWHeight)) { $BWHeight = "40" }
        if (!($BWWidth)) { $BWWidth = "94" }
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
        if (!($Fixer)) { }
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
        [Console]::SetCursorPosition($w, $pp); Say -NoNewLine "                                                                                       "
        [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 1)); Say -NoNewLine "                                                                                         "
        # [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 2)); Say -NoNewLine "                                                                                         "
        # [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
        # [Console]::SetCursorPosition($w, ($pp + 3)); Say -NoNewLine "                                                                                         "
        # [Console]::SetCursorPosition(0, 0); Say -NoNewLine ""
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
        Say $Rich5A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Say $rich5B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight5 = Read-Host -Prompt $boop
        PrettyLine
        Say $Rich6A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Say $rich6B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight6 = Read-Host -Prompt $boop
        PrettyLine
        $Fight1
        $Fight2
        $Fight3
        $Fight4
        $Fight5
        $Fight6
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
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Delay-Startup base folder~~WHITE~.......: ~~DARKRED~[~~WHITE~$ScriptBase~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Set Ed~~DARKRED~(~~WHITE~I~~DARKRED~)~~DARKCYAN~tor~WHITE~....................: ~~DARKRED~[~~WHITE~$Editor~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~S~~DARKRED~)~~DARKCYAN~tartUp Delay (Secs)~~WHITE~..........: ~~DARKRED~[~~WHITE~$StartDelay~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~DELAY~~DARKRED~)~~DARKCYAN~ Between Program Runs~~WHITE~....: ~~DARKRED~[~~WHITE~$Delay~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~P~~DARKRED~)~~DARKCYAN~revent From Running~~WHITE~..........: ~~DARKRED~[~~WHITE~$Prevent~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~N~~DARKRED~)~~DARKCYAN~otify with asay/notify~~WHITE~.......: ~~DARKRED~[~~WHITE~$Notify~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~T~~DARKRED~)~~DARKCYAN~est Run Shooting Blanks~~WHITE~......: ~~DARKRED~[~~WHITE~$TestRun~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~UP~~DARKRED~)~~DARKCYAN~Use Positioning for Window~~WHITE~..: ~~DARKRED~[~~WHITE~$WPosition~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~+~~DARKRED~)~~DARKCYAN~Toggle showing system Items~~WHITE~..: ~~DARKRED~[~~WHITE~$SysShow~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~Pause~~DARKRED~)~~DARKCYAN~ internal pause then run~~WHITE~.: ~~DARKRED~[~~WHITE~$Pause~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~PS~~DARKRED~)~~DARKCYAN~ Pause Seconds~~WHITE~..............: ~~DARKRED~[~~WHITE~$PauseSec~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKRED~(~~WHITE~PO~~DARKRED~)~~DARKCYAN~ Pause Option~~WHITE~...............: ~~DARKRED~[~~WHITE~$PauseOpt~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~W~~DARKRED~)~~DARKCYAN~idth~~WHITE~......................: ~~DARKRED~[~~WHITE~$WinWidth~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window ~~DARKRED~(~~WHITE~H~~DARKRED~)~~DARKCYAN~eight~~WHITE~.....................: ~~DARKRED~[~~WHITE~$WinHeight~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window Position ~~DARKRED~(~~WHITE~X~~DARKRED~)~~WHITE~.................: ~~DARKRED~[~~WHITE~$WinX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Window Position ~~DARKRED~(~~WHITE~Y~~DARKRED~)~~WHITE~.................: ~~DARKRED~[~~WHITE~$WinY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window Position ~~DARKRED~(~~WHITE~XX~~DARKRED~)~~WHITE~.: ~~DARKRED~[~~WHITE~$WinSMX~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Manager (this) Window Position ~~DARKRED~(~~WHITE~YY~~DARKRED~)~~WHITE~.: ~~DARKRED~[~~WHITE~$WinSMY~~DARKRED~]~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Programs in JSON~ ~DARKRED~[~~WHITE~$AddCount~~DARKRED~], (~~WHITE~TOG~~DARKRED~)~~DARKCYAN~gle ON~~darkred~/~~darkcyan~OFF~~DARKRED~, (~~WHITE~ADMIN~~DARKRED~)~~DARKCYAN~toggle.~"; $l++
    [Console]::SetCursorPosition($w, $l); WC "~DARKCYAN~Options~~white~: ~~DARKRED~(~~WHITE~J~~DARKRED~)~~DARKCYAN~SON ~~DARKRED~(~~WHITE~A~~DARKRED~)~~DARKCYAN~dd~~DARKRED~ (~~WHITE~D~~DARKRED~)~~DARKCYAN~elete~~DARKRED~ (~~WHITE~E~~DARKRED~)~DARKCYAN~dit~~DARKRED~ (~~WHITE~V~~DARKRED~)~~DARKCYAN~erify~~DARKRED~ (~~WHITE~R~~DARKRED~)~~DARKCYAN~un Entry~"; $l++
    [int]$v = 3
    [int]$w = 1
    [int]$i = 0
    if ($SysShow) {
        $StartUp = Get-CimInstance Win32_StartupCommand | Select-Object Name, command, Location, User; Start-Sleep -m 1000
        $su = ($StartUp).count
        $su = ($su - 1)
        while ($i -le $su) {
            $SUItem = $StartUp[$i]
            $su1 = $SUItem.name
            $su2 = "System"
            $su3 = $SUItem.command
            $su3 = "$su3".split('\')[-1]
            if ($i -lt "10") { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~cyan~ +~~DARKRED~]~~WHITE~.: $su1~ ~DARKRED~[~~yellow~Run:~~GREEN~$it2~~DARKRED~/~GREEN~$it5~~DARKRED~][~~DARKCYAN~$su3~~DARKRED~]~"; $l++ }
            if ($i -ge "10") { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~cyan~+~~DARKRED~]~~WHITE~.: $su1~ ~DARKRED~[~~yellow~Run:~~GREEN~$it2~~DARKRED~/~GREEN~$it5~~DARKRED~][~~DARKCYAN~$su3~~DARKRED~]~"; $l++ }
            $i++
            $a++
        }
    }
    [int]$i = 1
    while ($i -le $AddCount) {
        $RunItem = "RunItem-$i"
        $it1 = ($Config.$RunItem).name
        $it2 = ($Config.$RunItem).HostOnly
        $it3 = ($Config.$RunItem).RunPath
        $it3 = "$it3".split('\')[-1]
        $it4 = ($Config.$RunItem).goTime
        $it5 = ($Config.$RunItem).Admin
        if ($i -lt "10") { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~WHITE~$i~~DARKRED~]~~WHITE~.: $it1~ ~DARKRED~[~~yellow~Run:~~GREEN~$it2~~DARKRED~/~GREEN~$it5~~DARKRED~][~~yellow~Sec:~~GREEN~$it4~~DARKRED~][~~DARKCYAN~$it3~~DARKRED~]~"; $l++ }
        if ($i -ge "10") { [Console]::SetCursorPosition($w, $l); WC "~DARKRED~[~~WHITE~$i~~DARKRED~]~~WHITE~.: $it1~ ~DARKRED~[~~yellow~Run:~~GREEN~$it2~~DARKRED~/~GREEN~$it5~~DARKRED~][~~yellow~Sec:~~GREEN~$it4~~DARKRED~][~~DARKCYAN~$it3~~DARKRED~]~"; $l++ }
        $i++
        $j++
        $a++
    }
    $w = 0
    [int]$pp = $l
    [Console]::SetCursorPosition($w, $pp); WC $NormalLine
    $pp++
    $BWHeight = ($pp + 5)
    PrettyLine
    [int]$u = ($pp - 2)
    While ($v -le $u) {
        [Console]::SetCursorPosition($w, $v); WC $LeftLine
        $v++
    }
    [int]$v = 3
    [int]$u = ($pp - 2)
    [int]$w = 68
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
    else { $pop = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKRED~(~~WHITE~Run~~DARKRED~)~ ~DARKYELLOW~Delay-StartUp, Re~~DARKRED~(~~WHITE~L~~DARKRED~)~~DARKYELLOW~oad, ~~DARKRED~(~~WHITE~##~~DARKRED~)~~DARKYELLOW~ to run or view ~~DARKRED~(~~WHITE~Q~~DARKRED~)~~DARKYELLOW~uit~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $menuPrompt) }
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
            $vt5 = ($Config.$RI).goTime
            $vt6 = ($Config.$RI).Admin
            $tw = 1
            $tp = 20
            [Console]::SetCursorPosition($tw, $tp)
            $i = 1
            while ($i -le $MaxYes) {
                [Console]::SetCursorPosition($tw, $tp); Say "                                                              "
                $i++
                $tp++
            }
            $tw = 1
            $tp = 20
            [Console]::SetCursorPosition($tw, $tp); $tp++; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "    Name: $vt1"; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "     Run: $vt2"; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "   Admin: $vt6"; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "     Sec: $vt5"; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "                                                               "
            [Console]::SetCursorPosition($tw, $tp); Say " Program: $vt3"; $tp++;
            [Console]::SetCursorPosition($tw, $tp); Say "                                                               "; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "                                                               "
            [Console]::SetCursorPosition($tw, $tp); Say "Argument: $vt4"; $tp++;
            [Console]::SetCursorPosition($tw, $tp); Say "                                                               "; $tp++
            [Console]::SetCursorPosition($tw, $tp); Say "                                                               "
            [Console]::SetCursorPosition($tw, $tp); Read-Host -Prompt "[Enter to continue]"
        }
    }
    if ($pop -eq "B") {
        $blah = "Please enter the folder to set as BASE."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.Base = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        Set-Variable -Name Base -Value ($Config.Setup.Base) -Scope Global
    }
    if ($pop -eq "S") {
        $blah = "Please enter the seconds to delay start."
        $boop = "Seconds to delay start or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.StartDelay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$StartDelay = ($Config.Setup.StartDelay)
    }
    if ($pop -eq "DELAY") {
        $blah = "Please enter the seconds to delay between each."
        $boop = "Seconds to delay between or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.Delay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$Delay = ($Config.Setup.Delay)
    }
    if ($pop -eq "PAUSE") {
        if (($Config.Setup.Pause) -eq 0) { $Config.Setup.Pause = 1 }
        else { $Config.Setup.Pause = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$Pause = ($Config.Setup.Pause)
    }
    if ($pop -eq "PS") {
        $blah = "Please enter the seconds to Pause Internally."
        $boop = "Seconds to pause internally or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.PauseSec = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [int]$PauseSec = ($Config.Setup.PauseSec)
    }
    if ($pop -eq "PO") {
        $blah = "Please enter the Default Option to run."
        $boop = "Default option to run or ENTER to cancel"
        FuckOff
        if (($Fixer)) {
            $Config.Setup.PauseOpt = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [string]$PauseOpt = ($Config.Setup.PauseOpt)
    }
    if ($pop -eq "+") {
        if (($Config.Setup.SysShow) -eq 0) { $Config.Setup.SysShow = 1 }
        else { $Config.Setup.SysShow = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        [bool]$SysShow = ($Config.Setup.SysShow)
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
        if (($Fixer)) {
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
        if (($Fixer)) {
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
        if (($Fixer)) {
            $Config.Setup.Editor = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
        [string]$Editor = ($Config.Setup.Editor)
    }
    if ($pop -eq "J") {
        $go = ($ScriptBase + "\Delay-StartUp.json")
        Start-Process $Editor -ArgumentList $go -Verb RunAs
        PrettyLine
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
    if ($pop -eq "A") {
        SpinItems
        $qq = ($AddCount + 1)
        $RunItem = "RunItem-$qq"
        $test = @{Name = ""; HostOnly = ""; RunPath = ""; Argument = ""; goTime = ""; Admin = "" }
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
        if (!($q1)) { $q1 = $qq }
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
                $f5 = ($Config.$RunFix).goTime
                $f6 = ($Config.$RunFix).Admin
                $Fixer = @{ Admin = "$f6"; goTime = "$f5"; Argument = "$f4"; RunPath = "$f3"; HostOnly = "$f2"; Name = "$f1" }
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
            $Script:Fight5 = ($Config.$RunItem).goTime
            $Script:Fight6 = ($Config.$RunItem).Admin
            $rich1A = "Please enter the NAME or Title of the program for this entry."
            $rich1B = "Current Value: $Fight1"
            $rich2A = "Enter the HOSTNAME that this will run on. [Hostname, ON or OFF]"
            $rich2B = "Current Value: $Fight2"
            $Rich3A = "Please enter the COMPLETE PATH and FILENAME for this entry"
            $Rich3B = "Current Value: $Fight3"
            $rich4A = "Please enter any ARGUMENTS you need for this entry."
            $rich4B = "Current Value: $Fight4"
            $rich5A = "Please enter SECONDS to run this entry in."
            $rich5B = "Current Value: $Fight5"
            $rich6A = "Enter if it will run with ADMIN privileges [ON or OFF]."
            $rich6B = "Current Value: $Fight6"
            $boop = "[OK for No Change or - to Clear]"
            FightOn
            if (($Fight1)) {
                if ($Fight1 -eq "-") { $Fight1 = "" }
                $Config.$RunItem.Name = $Fight1
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if (($Fight2)) {
                if ($Fight2 -eq "-") { $Fight2 = "" }
                $Config.$RunItem.HostOnly = $Fight2
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if (($Fight3)) {
                if ($Fight3 -eq "-") { $Fight3 = "" }
                $Config.$RunItem.RunPath = $Fight3
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if (($Fight4)) {
                if ($Fight4 -eq "-") { $Fight4 = "" }
                $Config.$RunItem.Argument = $Fight4
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if (($Fight5)) {
                if ($Fight5 -eq "-") { $Fight5 = "" }
                $Config.$RunItem.goTime = $Fight5
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if (($Fight6)) {
                if ($Fight6 -eq "-") { $Fight6 = "" }
                $Config.$RunItem.Admin = $Fight6
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
            #$TestRun5 = ($Config.$RunItem).goTime
            if (($TestRun1)) { $GTG1 = "YES" }
            else { $GTG1 = "NO" }
            if (($TestRun2)) { $GTG2 = "YES" }
            else { $GTG2 = "NO" }
            if (($TestRun3)) {
                $Filetest = Test-Path -Path $TestRun3
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
    if ($pop -eq "ADMIN") {
        PrettyLine
        Say "Enter the Number of RunItem to Toggle ADMIN Off/ON."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $RunItem = "RunItem-$q1"
            $Toggle = ($Config.$RunItem).Admin
            if ($toggle -eq "OFF") {
                $Fight = "ON"
                $Config.$RunItem.Admin = $Fight
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($toggle -eq "ON") {
                $Fight = "OFF"
                $Config.$RunItem.Admin = $Fight
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($null -eq $toggle) {
                $Fight = "OFF"
                $Config.$RunItem.Admin = $Fight
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
            $TestRun5 = ($Config.$RunItem).goTime
            if ($TestRun2 -ne $env:USERDOMAIN -and $TestRun2 -ne "ON") {
                Say "You are running this on $env:USERDOMAIN and it is configured for $TestRun2..."
                [Console]::SetCursorPosition($w, ($pp + 1))
                $fool = Read-Host -Prompt "Y to continue this foolishness or [Enter to Cancel]"
                PrettyLine
                if ($Fool -eq "Y") {
                    Say "Test Running Entry $q1 $TestRun1"
                    if (($TestRun4)) { Start-Process -FilePath "$TestRun3" -ArgumentList $TestRun4 }
                    else { Start-Process -FilePath $TestRun3 }
                }
            }
            else {
                Say "Test Running Entry $q1 $TestRun1"
                if (($TestRun4)) { Start-Process -FilePath "$TestRun3" -ArgumentList $TestRun4 }
                else { Start-Process -FilePath $TestRun3 }
            }
        }
    }
    PrettyLine
    if ($pop -eq "L") { PrettyLine; & Start-Process "pwsh.exe" -ArgumentList "$PSScriptRoot\DelaySM.ps1 -NoLogo"; exit }
    if ($pop -eq "RUN") { PrettyLine; & Start-Process "pwsh.exe" -ArgumentList "$PSScriptRoot\Delay-StartUp.ps1 -NoLogo -NoProfile"; return }
    if ($pop -eq "Q") { return }
    $Pop = ""
    PrettyLine
}
