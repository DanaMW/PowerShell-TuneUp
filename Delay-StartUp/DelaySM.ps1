$FileVersion = "Version: 1.3.14"
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
    Say -ForeGroundColor RED "You need to create or edit BinMenu.json in" $Base
    break
}
$Base = $env:Base
if (!($Base)) { Set-Variable -Name Base -Value ($Config.basic.Base) -Scope Global }
if (!($Base)) { Say -ForeGroundColor RED "SET BASE environment variable in your profiles or in the json. This shit uses that!"; break }
Set-Location $Base.substring(0, 3)
Set-Location $Base
[string]$Editor = ($Config.basic.Editor)
[bool]$TestRun = ($Config.basic.TestRun)
[int]$StartDelay = ($Config.basic.StartDelay)
[int]$Delay = ($Config.basic.Delay)
[bool]$Prevent = ($Config.basic.Prevent)
[int]$WinWidth = ($Config.basic.WinWidth)
[int]$WinHeight = ($Config.basic.WinHeight)
[int]$BuffWidth = $WinWidth
[int]$BuffHeight = $WinHeight
if (!($BWHeight)) { $BWHeight = "37" }
if (!($BWWidth)) { $BWWidth = "66" }
$PosTest = Test-Path -path ($Base + "\Put-WinPosition.ps1")
$WinX = 690
$WinY = 205
if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY -Width 800 -Height 800  > $null }
$Script:ESC = [char]27
[string]$NormalLine = "$ESC[31m#===============================================================#$ESC[97m"
[string]$TitleLine = "$ESC[31m|$ESC[97m>-=-=-=-=-=-=-=<$ESC[36m[$ESC[41m$ESC[97mDelay-StartUp Settings Manager$ESC[40m$ESC[36m]$ESC[97m>-=-=-=-=-=-=-<$ESC[31m|$ESC[97m"
[string]$LeftLine = "$ESC[31m|"
[string]$RightLine = "$ESC[31m|"
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
    if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY > $null }
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
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine $NormalLine; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine $TitleLine; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine $NormalLine; $l++
    [int]$w = 1
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[31m($ESC[97mB$ESC[31m)$ESC[36mase Folder$ESC[97m................:$ESC[31m [$ESC[97m$Base$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[31m($ESC[97mS$ESC[31m)$ESC[36mtartUp Delay (Secs)$ESC[97m.......:$ESC[31m [$ESC[97m$StartDelay$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mDela$ESC[31m($ESC[97mY$ESC[31m)$ESC[36m Between Program Runs$ESC[97m.:$ESC[31m [$ESC[97m$Delay$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[31m($ESC[97mP$ESC[31m)$ESC[36mrevent From Running$ESC[97m.......:$ESC[31m [$ESC[97m$Prevent$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[31m($ESC[97mT$ESC[31m)$ESC[36mest Run Shooting Blanks$ESC[97m...:$ESC[31m [$ESC[97m$TestRun$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mWindow $ESC[31m($ESC[97mW$ESC[31m)$ESC[36midth$ESC[97m...............:$ESC[31m [$ESC[97m$WinWidth$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mWindow $ESC[31m($ESC[97mH$ESC[31m)$ESC[36meight$ESC[97m..............:$ESC[31m [$ESC[97m$WinHeight$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mSet Ed$ESC[31m($ESC[97mI$ESC[31m)$ESC[36mtor$ESC[97m.................:$ESC[31m [$ESC[97m$Editor$ESC[31m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mNum of Program Runs in JSON$ESC[97m..: $ESC[31m[$ESC[97m$AddCount$ESC[31m]"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mEdit the $ESC[31m($ESC[97mJ$ESC[31m)$ESC[36mSON Directly"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[31m($ESC[97mA$ESC[31m)$ESC[36mdd$ESC[31m, ($ESC[97mD$ESC[31m)$ESC[36melete$ESC[31m, ($ESC[97mE$ESC[31m)$ESC[36mdit$ESC[31m, ($ESC[97mV$ESC[31m)$ESC[36merify$ESC[31m, ($ESC[97mR$ESC[31m)$ESC[36mun Entry"; $l++
    [int]$v = 3
    [int]$i = 1
    [int]$w = 1
    while ($i -le $AddCount) {
        $RunItem = "RunItem-$i"
        $it1 = ($Config.$RunItem).name
        $it2 = ($Config.$RunItem).HostOnly
        if ($i -lt "10") {
            [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mView $ESC[31m[$ESC[97m$i$ESC[31m]$ESC[97m.: $it1 $ESC[36mHost$ESC[97m:$ESC[31m[$ESC[97m$it2$ESC[31m]$ESC[40m"
            $l++
        }
        if ($i -ge "10") {
            [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36mView $ESC[31m[$ESC[97m$i$ESC[31m]$ESC[97m: $it1 $ESC[36mHost$ESC[97m:$ESC[31m[$ESC[97m$it2$ESC[31m]$ESC[40m"
            $l++
        }
        $i++
        $a++
    }
    $w = 0
    [int]$pp = $l
    [Console]::SetCursorPosition($w, $pp); Say $NormalLine
    $pp++
    $BWHeight = ($pp + 5)
    PrettyLine
    [int]$u = ($pp - 1)
    While ($v -le $u) {
        [Console]::SetCursorPosition($w, $v); Say -NoNewline $LeftLine
        $v++
    }
    [int]$v = 3
    [int]$u = ($pp - 2)
    [int]$w = 64
    While ($v -le $u) {
        [Console]::SetCursorPosition($w, $v); Say -NoNewline $RightLine
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
    <#
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($ans, [ref]$OutNumber)) {
        FixLine
        $ValidOption = "NO"
        $DidIt = "NO"
        $MaxYes = (Get-Content $FileINI).count
        $MaxYes = ($MaxYes / 3)
        $MaxYes = [int][Math]::Ceiling($MaxYes)
        if ($OutNumber -gt 0 -and $OutNumber -le $MaxYes) {
    #>
    else { $Pop = Read-Host -Prompt "$ESC[31m[$ESC[36mYour Selection or Re$ESC[31m($ESC[97mL$ESC[31m)$ESC[36moad, $ESC[31m($ESC[97mQ$ESC[31m)$ESC[36muit$ESC[31m]$ESC[97m" }
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
        $go = ($Base + "\Delay-StartUp.json")
        Start-Process $Editor -ArgumentList $go -Verb RunAs
        PrettyLine
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
