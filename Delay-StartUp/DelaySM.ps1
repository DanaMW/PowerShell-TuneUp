$FileVersion = "Version: 1.3.9"
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
if (!($BWWidth)) { $BWWidth = "90" }
$PosTest = Test-Path -path ($Base + "\Put-WinPosition.ps1")
$WinX = 590
$WinY = 205
if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $WinX -WinY $WinY -Width 820 -Height 820  > $null }
$Script:ESC = [char]27
[string]$NormalLine = "$ESC[91m#=======================================================================================#$ESC[97m"
[string]$TitleLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=<$ESC[96m[$ESC[41m$ESC[97mDelay-StartUp Settings Manager$ESC[40m$ESC[96m]$ESC[96m>$ESC[97m-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[91m|$ESC[97m"
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
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m100$ESC[91m]$ESC[36m.................$ESC[93mBase Folder$ESC[97m:$ESC[97m [$ESC[92m$Base$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m101$ESC[91m]$ESC[36m........$ESC[93mStartUp delay (Secs)$ESC[97m:$ESC[97m [$ESC[92m$StartDelay$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m102$ESC[91m]$ESC[36m......$ESC[93mDelay between programs$ESC[97m:$ESC[97m [$ESC[92m$Delay$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m103$ESC[91m]$ESC[36m........$ESC[93mPrevent from running$ESC[97m:$ESC[97m [$ESC[92m$Prevent$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m104$ESC[91m]$ESC[36m....$ESC[93mTest run shooting blanks$ESC[97m:$ESC[97m [$ESC[92m$TestRun$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m105$ESC[91m]$ESC[36m................$ESC[93mWindow Width$ESC[97m:$ESC[97m [$ESC[92m$WinWidth$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m106$ESC[91m]$ESC[36m...............$ESC[93mWindow Height$ESC[97m:$ESC[97m [$ESC[92m$WinHeight$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m107$ESC[91m]$ESC[36m......................$ESC[93mEditor$ESC[97m:$ESC[97m [$ESC[92m$Editor$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[36m......$ESC[96mNum of Program Adds in JSON$ESC[97m:$ESC[97m [$ESC[96m" $AddCount "$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m108$ESC[91m]$ESC[36m...............$ESC[91mEdit the JSON$ESC[97m:$ESC[97m [$ESC[91mEdit Delay-StartUp.json Directly$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m109$ESC[91m]$ESC[36m...................$ESC[91mADD Entry$ESC[97m:$ESC[97m [$ESC[91mAdd A New Delayed Start Entry$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m110$ESC[91m]$ESC[36m................$ESC[91mDELETE Entry$ESC[97m:$ESC[97m [$ESC[91mDelete Existing Delayed Start Entry$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m111$ESC[91m]$ESC[36m..................$ESC[91mEdit Entry$ESC[97m:$ESC[97m [$ESC[91mEdit One Of The Current Entries$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m112$ESC[91m]$ESC[36m................$ESC[91mVerify Entry$ESC[97m:$ESC[97m [$ESC[91mVerify One Of The Current Entries$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m113$ESC[91m]$ESC[36m...................$ESC[91mRun Entry$ESC[97m:$ESC[97m [$ESC[91mTest Run One Of The Current Entries$ESC[97m]"; $l++
    [int]$v = 3
    [int]$i = 1
    [int]$w = 1
    while ($i -le $AddCount) {
        $RunItem = "RunItem-$i"
        $it1 = ($Config.$RunItem).name
        $it2 = ($Config.$RunItem).HostOnly
        if ($i -lt "10") {
            [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m....................$ESC[93mName$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]"
            [Console]::SetCursorPosition(($w + 65), $l); Say -NoNewLine "$ESC[97m[$ESC[93mHost$ESC[96m: $it2$ESC[97m]$ESC[40m"
            $l++
        }
        if ($i -ge "10") {
            [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m...................$ESC[93mName$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]"
            [Console]::SetCursorPosition(($w + 65), $l); Say -NoNewLine "$ESC[97m[$ESC[93mHost$ESC[96m: $it2$ESC[97m]$ESC[40m"
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
    [int]$w = 88
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
    $pop = Read-Host -Prompt "$ESC[91m[$ESC[97mNumber $ESC[96mto Edit, $ESC[91m($ESC[97mR$ESC[91m)$ESC[96meload, $ESC[91m($ESC[97mQ$ESC[91m)$ESC[96muit$ESC[91m]$ESC[97m"
    if ($pop -eq "100") {
        $blah = "Please enter the folder to set as BASE."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Base = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "101") {
        $blah = "Please enter the seconds to delay start."
        $boop = "Seconds to delay start or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.StartDelay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "102") {
        $blah = "Please enter the seconds to delay between each."
        $boop = "Seconds to delay between or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Delay = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "103") {
        if (($Config.basic.Prevent) -eq 0) { $Config.basic.Prevent = 1 }
        else { $Config.basic.Prevent = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "104") {
        if (($Config.basic.TestRun) -eq 0) { $Config.basic.TestRun = 1 }
        else { $Config.basic.TestRun = 0 }
        $Config | ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "105") {
        $blah = "Please enter The Console Window Width."
        $boop = "Number of console Width or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.BuffWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.basic.WinWidth = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "106") {
        $blah = "Please enter The Console Height."
        $boop = "Number of console Height or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.BuffHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Config.basic.WinHeight = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "107") {
        $blah = "Please enter the Complete path and file name to your text editor"
        $boop = "path-file for editor or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Editor = $Fixer
            $Config | ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "108") {
        $go = ($Base + "\Delay-StartUp.json")
        Start-Process $Editor -ArgumentList $go -Verb RunAs
        PrettyLine
    }
    if ($pop -eq "109") {
        SpinItems
        $qq = ($AddCount + 1)
        $RunItem = "RunItem-$qq"
        $test = @{Name = ""; HostOnly = ""; RunPath = ""; Argument = "" }
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config | Add-Member -Type NoteProperty -Name $RunItem -Value $test
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        SpinItems
    }
    if ($pop -eq "110") {
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
    if ($pop -eq "111") {
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
            $rich2A = "Enter the HOSTNAME that this will run on. [Also: All, NONE] "
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
    }
    if ($pop -eq "112") {
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
    if ($pop -eq "113") {
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
    if ($pop -eq "R") { PrettyLine; & Start-Process "pwsh.exe" -ArgumentList "$PSScriptRoot\DelaySM.ps1 -NoLogo -NoProfile"; return }
    if ($pop -eq "Q") { return }
    PrettyLine
}
