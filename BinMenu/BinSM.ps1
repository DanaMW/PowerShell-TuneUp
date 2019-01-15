while (1) {
    $FileVersion = [string]"Version: 1.1.7"
    $host.ui.RawUI.WindowTitle = ("BinMenu Settings Manager " + $FileVersion)
    Function Get-ScriptDir { Split-Path -parent $PSCommandPath }
    Function MyConfig {
        $Script:MyConfig = ($(Get-ScriptDir) + "\BinMenu.json")
        $MyConfig
    }
    $Script:ConfigFile = MyConfig
    try { $Script:Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
    catch { Write-Error -Message "The Base configuration file is missing!" }
    if (!($Config)) { Write-Error -Message "The Base configuration file is missing!" }
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
    [string]$Base = ($Config.basic.Base)
    [bool]$ScriptRead = ($Config.basic.ScriptRead)
    [string]$Editor = ($Config.basic.Editor)
    [bool]$MenuAdds = ($Config.basic.MenuAdds)
    [bool]$WPosition = ($Config.basic.WPosition)
    [int]$BuffHeight = ($Config.basic.BuffHeight)
    [int]$BuffWidth = ($Config.basic.BuffWidth)
    [int]$WinHeight = ($Config.basic.WinHeight)
    [int]$WinWidth = ($Config.basic.WinWidth)
    if (!($ABuffHeight)) { $ABuffHeight = 44 }
    if (!($ABuffWidth)) { $ABuffWidth = 90 }
    if (!($AWinHeight)) { $AWinHeight = 44 }
    if (!($AWinWidth)) { $AWinWidth = 90 }
    #if (!($AMaxWinHeight)) { $AMaxWinHeight = 50 }
    #if (!($AMaxWinWidth)) { $AMaxWinWidth = 150 }
    #if (!($AMaxpWinHeight)) { $AMaxpWinHeight = 60 }
    #if (!($AMaxpWinWidth)) { $AMaxpWinWidth = 160 }
    Function FlexWindow {
        $pshost = get-host
        $pswindow = $pshost.ui.rawui
        #
        $newsize = $pswindow.buffersize
        $newsize.height = [int]$ABuffHeight
        $newsize.width = [int]$ABuffWidth
        $pswindow.buffersize = $newsize
        #
        $newsize = $pswindow.windowsize
        $newsize.height = [int]$AWinHeight
        $newsize.width = [int]$AWinWidth
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
    FlexWindow
    $Script:ESC = [char]27
    [string]$NormalLine = "$ESC[91m#=======================================================================================#$ESC[97m"
    [string]$TitleLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<$ESC[96m[$ESC[41m$ESC[97mBinMenu Settings Manager$ESC[40m$ESC[96m]$ESC[96m>$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-$ESC[91m|$ESC[97m"
    [string]$LeftLine = "$ESC[31m|"
    [string]$RightLine = "$ESC[31m|"
    Function FuckOff {
        PrettyLine
        Say $blah
        [Console]::SetCursorPosition($w, ($pp + 1))
        $Script:Fixer = Read-Host -Prompt $boop
        PrettyLine
        $Fixer
    }
    Function PrettyLine {
        [Console]::SetCursorPosition($w, $pp); Say -NoNewLine ""
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
        PrettyLine; Say $Rich1
        [Console]::SetCursorPosition($w, ($pp + 1)); Say "Current Value:" $Fight1
        [Console]::SetCursorPosition($w, ($pp + 2)); $Script:Fight1 = Read-Host -Prompt $boop
        PrettyLine; Say $Rich2
        [Console]::SetCursorPosition($w, ($pp + 1)); Say "Current Value:" $Fight2
        [Console]::SetCursorPosition($w, ($pp + 2)); $Script:Fight2 = Read-Host -Prompt $boop
        PrettyLine; Say $Rich3
        [Console]::SetCursorPosition($w, ($pp + 1)); Say "Current Value:" $Fight3
        [Console]::SetCursorPosition($w, ($pp + 2)); $Script:Fight3 = Read-Host -Prompt $boop
        PrettyLine
        if ($Fight3 -eq "") { $Fight3 = "[No Argument]" }
        PrettyLine
        $Fight1; $Fight2; $Fight3
    }
    Clear-Host
    Say $NormalLine; Say $TitleLine; Say $NormalLine
    [int]$w = "1"; [int]$l = "3"; [int]$v = "3"
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m100$ESC[91m]$ESC[36m..............$ESC[93mBase Folder$ESC[97m:$ESC[97m [$ESC[92m$Base$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m101$ESC[91m]$ESC[36m..........$ESC[93mRead in Scripts$ESC[97m:$ESC[97m [$ESC[92m$ScriptRead$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m102$ESC[91m]$ESC[36m...........$ESC[93mDefined Editor$ESC[97m:$ESC[97m [$ESC[92m$Editor$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m103$ESC[91m]$ESC[36m....................$ESC[93mDebug$ESC[97m:$ESC[97m [$ESC[92m$DBug$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m104$ESC[91m]$ESC[36m......$ESC[93mUse Win Positioning$ESC[97m:$ESC[97m [$ESC[92m$WPosition$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m105$ESC[91m]$ESC[36m.............$ESC[93mWindow Width$ESC[97m:$ESC[97m [$ESC[92m$WinWidth$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m106$ESC[91m]$ESC[36m............$ESC[93mWindow Height$ESC[97m:$ESC[97m [$ESC[92m$WinHeight$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m107$ESC[91m]$ESC[36m.............$ESC[93mBuffer Width$ESC[97m:$ESC[97m [$ESC[92m$BuffWidth$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m108$ESC[91m]$ESC[36m............$ESC[93mBuffer Height$ESC[97m:$ESC[97m [$ESC[92m$BuffHeight$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m109$ESC[91m]$ESC[36m..........$ESC[93mUse Add Entries$ESC[97m:$ESC[97m [$ESC[92m$MenuAdds$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[96mNumber of Program Adds in JSON$ESC[97m: $ESC[97m[$ESC[96m" $AddCount "$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m110$ESC[91m]$ESC[36m.............$ESC[91mEdit the INI$ESC[97m:$ESC[97m [$ESC[91mEdit BinMenu.ini Directly$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m111$ESC[91m]$ESC[36m................$ESC[91mADD Entry$ESC[97m:$ESC[97m [$ESC[91mAdd New Item$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m112$ESC[91m]$ESC[36m.............$ESC[91mDELETE Entry$ESC[97m:$ESC[97m [$ESC[91mDelete Existing Item$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m113$ESC[91m]$ESC[36m...............$ESC[91mEdit Entry$ESC[97m:$ESC[97m [$ESC[91mEdit Run Entry$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m114$ESC[91m]$ESC[36m.............$ESC[91mVerify Entry$ESC[97m:$ESC[97m [$ESC[91mVerify One Of The Current Entries$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[91m[$ESC[97m115$ESC[91m]$ESC[36m................$ESC[91mRun Entry$ESC[97m:$ESC[97m [$ESC[91mTest Run One Of The Current Entries$ESC[97m]"; $l++
    [int]$i = 1; [int]$w = 1
    if ($MenuAdds -eq "$True") {
        while ($i -le $AddCount) {
            $AddItem = "AddItem-$i"
            $it1 = ($Config.$AddItem).name
            if ($i -ge 10) { [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m................Name$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]$ESC[40m" ; $l++ }
            else { [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m.................Name$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]$ESC[40m"; $l++ }
            $i++
            $a++
        }
    }
    [int]$pp = $l; [int]$w = 0
    [Console]::SetCursorPosition($w, $pp); Say $NormalLine; $pp++
    $ABuffHeight = ($pp + 4); $AWinHeight = ($pp + 4)
    PrettyLine; [int]$u = ($pp - 2)
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Say -NoNewline $LeftLine; $v++ }
    [int]$v = 3; [int]$u = ($pp - 2); [int]$w = 88
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Say -NoNewline $RightLine; $v++ }
    [int]$w = 0; [Console]::SetCursorPosition($w, $pp); PrettyLine; [Console]::SetCursorPosition($w, $pp)
    FlexWindow; FlexWindow; $pp = ($pp - 1); PrettyLine; $pp++
    [Console]::SetCursorPosition($w, $pp); PrettyLine
    $pop = Read-Host -Prompt "$ESC[91m[$ESC[97mNum $ESC[96mto Edit, $ESC[97mX $ESC[96mReload, $ESC[97mQ $ESC[96mQuit$ESC[91m]$ESC[97m"
    if ($pop -eq "100") {
        $blah = "Please enter the folder to set as BASE"
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Base = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "101") {
        if (($Config.basic.ScriptRead) -eq 1) {
            [bool]$Config.basic.ScriptRead = 0
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [int]$poptmp = [int]($Config.basic.WinHeight); $poptmp = ($poptmp - 10)
            [int]$Config.basic.WinHeight = [int]$poptmp
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [int]$poptmp = [int]($Config.basic.BuffHeight); $poptmp = ($poptmp - 10)
            [int]$Config.basic.BuffHeight = [int]$poptmp
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        else {
            [bool]$Config.basic.ScriptRead = 1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [int]$poptmp = [int]($Config.basic.WinHeight); $poptmp = ($poptmp + 10)
            [int]$Config.basic.WinHeight = [int]$poptmp
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [int]$poptmp = [int]($Config.basic.BuffHeight); $poptmp = ($poptmp + 10)
            [int]$Config.basic.BuffHeight = [int]$poptmp
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "102") {
        $blah = "Please enter the Complete path and file name to your text editor"
        $boop = "path-file for editor or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Editor = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "103") {
        if (($Config.basic.DBug) -eq 1) { $Config.basic.DBug = 0 }
        else { $Config.basic.DBug = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "104") {
        if (($Config.basic.WPosition) -eq 1) { $Config.basic.WPosition = 0 }
        else { $Config.basic.WPosition = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile

    }
    if ($pop -eq "105") {
        $blah = "Please enter The Console Window width. must be equal or LESS than BuffWidth"
        $boop = "Number of console Width or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -le $BuffWidth) {
                $Config.basic.WinWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Config.basic.BuffWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
                $Config.basic.WinWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "106") {
        $blah = "Please enter The Console Window height. Must be equal or LESS than BuffHeight"
        $boop = "Number of console height or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -le $BuffHeight) {
                $Config.basic.WinHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Config.basic.BuffHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
                $Config.basic.WinHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "107") {
        $blah = "Please enter The Console buffer width. Must be equal or GREATER than WinWidth"
        $boop = "Number of console buffer width or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -ge $WinWidth) {
                $Config.basic.BuffWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Config.basic.WinWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
                $Config.basic.BuffWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "108") {
        $blah = "Please enter The Console Window width. must be equal or GREATER than WinHeight"
        $boop = "Number of console buffer Height or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -ge $WinHeight) {
                $Config.basic.BuffHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Config.basic.WinHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
                $Config.basic.BuffHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "109") {
        if (($Config.basic.MenuAdds) -eq 1) { $Config.basic.MenuAdds = 0 }
        else { $Config.basic.MenuAdds = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "110") {
        $go1 = ($base + "\BinMenu.ini")
        $go2 = ($base + "\BinMenu.json")
        $goall = "$go1 $go2"
        Start-Process $Editor -ArgumentList $goall -Verb RunAs
        PrettyLine
    }
    if ($pop -eq "111") {
        SpinItems
        $qq = ($AddCount + 1)
        $AddItem = "AddItem-$qq"
        $test = @{ Name = ""; Command = ""; Argument = ""}
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config | Add-Member -Type NoteProperty -Name $AddItem -Value $test
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        SpinItems
    }
    if ($pop -eq "112") {
        SpinItems
        [int]$qq = $AddCount
        PrettyLine
        Say "Enter the Number of AddItem to remove."
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
    if ($pop -eq "113") {
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
            $boop = "[ENTER for No Change]"
            $Fight1 = ($Config.$AddItem).Name
            $Fight2 = ($Config.$AddItem).Command
            $Fight3 = ($Config.$AddItem).Argument
            if ($Fight3 -eq "") { $Fight3 = "[No Argument]"}
            FightOn
            PrettyLine
            if ($Fight1 -ne "") {
                $Config.$AddItem.Name = $Fight1
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight2 -ne "") {
                $Config.$AddItem.Command = $Fight2
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight3 -ne "") {
                $Config.$AddItem.Argument = $Fight3
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
        PrettyLine
    }
    if ($pop -eq "114") {
        PrettyLine; Say "Enter the Number of RunItem to Verify."; [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
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
                $Filetest = Test-Path -path $TestRun2
                if ($Filetest -eq $true) { $GTG2 = "YES" }
                else { $GTG2 = "NO" }
            }
            if ($GTG1 -eq "YES" -and $GTG2 -eq "YES") { $GoodToGo = "Verified" }
            PrettyLine
            Read-Host -Prompt "$GoodToGo [Enter to Continue]"
        }
    }
    if ($pop -eq "115") {
        PrettyLine
        Say "Enter the Number of AddItem to Execute."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        if (($q1)) {
            $AddItem = "AddItem-$q1"
            $TestRun1 = ($Config.$AddItem).Name
            $TestRun2 = ($Config.$AddItem).Command
            $TestRun3 = ($Config.$AddItem).Argument
            Say "Test Running Entry" $q1 $TestRun1
            if ($TestRun3 -ne "") { Start-Process -FilePath $TestRun2 -ArgumentList $TestRun3 }
            else { Start-Process -FilePath $TestRun2 }
        }
    }
    PrettyLine
    if ($pop -eq "X") { PrettyLine; Start-Process "pwsh.exe" -ArgumentList ($PSScriptRoot + "\BinSM.ps1"); return }
    if ($pop -eq "Q") { return }
    FlexWindow; PrettyLine
}
