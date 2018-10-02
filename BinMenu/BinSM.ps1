while (1) {
    $FileVersion = "Version: 1.0.6"
    $host.ui.RawUI.WindowTitle = "BinMenu Settings Manager $FileVersion"
    Function Get-ScriptDir { Split-Path -parent $PSCommandPath }
    Function MyConfig {
        $Script:MyConfig = $(Get-ScriptDir) + "\BinMenu.json"
        $MyConfig
    }
    $Script:ConfigFile = MyConfig
    try {
        $Script:Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
    }
    catch {
        Write-Error -Message "The Base configuration file is missing!"
    }
    if (!($Config)) {
        Write-Error -Message "The Base configuration file is missing!"
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
        $Script:AddCount
    }
    SpinItems
    [string]$Base = ($Config.basic.Base)
    [bool]$ScriptRead = ($Config.basic.ScriptRead)
    [string]$Editor = ($Config.basic.Editor)
    [bool]$MenuAdds = ($Config.basic.MenuAdds)
    [int]$SortMethod = ($Config.basic.SortMethod)
    [string]$SortDir = ($Config.basic.SortDir)
    [int]$SpLine = ($Config.basic.SpLine)
    [int]$ExtraLine = ($Config.basic.ExtraLine)
    [bool]$DBug = ($Config.basic.DBug)
    [bool]$WPosition = ($Config.basic.WPosition)
    [int]$BuffHeight = ($Config.basic.BuffHeight)
    [int]$BuffWidth = ($Config.basic.BuffWidth)
    [int]$WinHeight = ($Config.basic.WinHeight)
    [int]$WinWidth = ($Config.basic.WinWidth)
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = 44
    $newsize.width = 90
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = 44
    $newsize.width = 90
    $pswindow.windowsize = $newsize
    $Script:ESC = [char]27
    [string]$NormalLine = "$ESC[91m#=======================================================================================#$ESC[97m"
    [string]$TitleLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<$ESC[96m[$ESC[41m$ESC[97mBinMenu Settings Manager$ESC[40m$ESC[96m]$ESC[96m>$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-$ESC[91m|$ESC[97m"
    [string]$LeftLine = "$ESC[31m|"
    [string]$RightLine = "$ESC[31m|"
    Function FuckOff {
        PrettyLine
        Write-Host $blah
        [Console]::SetCursorPosition($w, ($pp + 1))
        $Script:Fixer = Read-Host -Prompt $boop
        PrettyLine
        $Fixer
    }
    Function PrettyLine {
        [Console]::SetCursorPosition($w, $pp); Write-Host -NoNewLine ""
        [Console]::SetCursorPosition(0, 0); Write-Host -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 1)); Write-Host -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Write-Host -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 2)); Write-Host -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Write-Host -NoNewLine ""
        [Console]::SetCursorPosition($w, ($pp + 3)); Write-Host -NoNewLine "                                                                                         "
        [Console]::SetCursorPosition(0, 0); Write-Host -NoNewLine ""
        [Console]::SetCursorPosition($w, $pp)
    }
    Function FightOn {
        PrettyLine
        Write-Host $Rich1
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host "Current Value: $Fight1"
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight1 = Read-Host -Prompt $boop
        PrettyLine
        Write-Host $Rich2
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host "Current Value: $Fight2"
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight2 = Read-Host -Prompt $boop
        PrettyLine
        Write-Host $Rich3
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host "Current Value: $Fight3"
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight3 = Read-Host -Prompt $boop
        PrettyLine
        if ($Fight3 -eq "") { $Fight3 = "[No Argument]" }
        PrettyLine
        $Fight1
        $Fight2
        $Fight3
    }
    Clear-Host
    Write-Host $NormalLine
    Write-Host $TitleLine
    Write-Host $NormalLine
    [int]$w = "1"
    [int]$l = "3"
    [int]$v = "3"
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m100$ESC[91m]$ESC[36m..............$ESC[93mBase Folder$ESC[97m:$ESC[97m [$ESC[92m$Base$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m101$ESC[91m]$ESC[36m..........$ESC[93mRead in Scripts$ESC[97m:$ESC[97m [$ESC[92m$ScriptRead$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m102$ESC[91m]$ESC[36m...........$ESC[93mDefined Editor$ESC[97m:$ESC[97m [$ESC[92m$Editor$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m103$ESC[91m]$ESC[36m..............$ESC[93mSort Method$ESC[97m:$ESC[97m [$ESC[92m$SortMethod$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m104$ESC[91m]$ESC[36m...........$ESC[93mSort Direction$ESC[97m:$ESC[97m [$ESC[92m$SortDir$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m105$ESC[91m]$ESC[36m....................$ESC[93mDebug$ESC[97m:$ESC[97m [$ESC[92m$DBug$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m106$ESC[91m]$ESC[36m.........$ESC[93mScripts Per Line$ESC[97m:$ESC[97m [$ESC[92m$SpLine$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m107$ESC[91m]$ESC[36m.$ESC[93mNum of Extra lines added$ESC[97m:$ESC[97m [$ESC[92m$ExtraLine$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m108$ESC[91m]$ESC[36m......$ESC[93mUse Win Positioning$ESC[97m:$ESC[97m [$ESC[92m$WPosition$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m109$ESC[91m]$ESC[36m.............$ESC[93mWindow Width$ESC[97m:$ESC[97m [$ESC[92m$WinWidth$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m110$ESC[91m]$ESC[36m............$ESC[93mWindow Height$ESC[97m:$ESC[97m [$ESC[92m$WinHeight$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m111$ESC[91m]$ESC[36m.............$ESC[93mBuffer Width$ESC[97m:$ESC[97m [$ESC[92m$BuffWidth$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m112$ESC[91m]$ESC[36m............$ESC[93mBuffer Height$ESC[97m:$ESC[97m [$ESC[92m$BuffHeight$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m113$ESC[91m]$ESC[36m..........$ESC[93mUse Add Entries$ESC[97m:$ESC[97m [$ESC[92m$MenuAdds$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[96mNumber of Program Adds in JSON$ESC[97m: $ESC[97m[$ESC[96m" $AddCount "$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m114$ESC[91m]$ESC[36m.............$ESC[91mEdit the INI$ESC[97m:$ESC[97m [$ESC[91mEdit BinMenu.ini Directly$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m115$ESC[91m]$ESC[36m................$ESC[91mADD Entry$ESC[97m:$ESC[97m [$ESC[91mAdd New Item$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m116$ESC[91m]$ESC[36m.............$ESC[91mDELETE Entry$ESC[97m:$ESC[97m [$ESC[91mDelete Existing Item$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m117$ESC[91m]$ESC[36m...............$ESC[91mEdit Entry$ESC[97m:$ESC[97m [$ESC[91mEdit Run Entry$ESC[97m]$ESC[40m"; $l++
    [int]$i = 1
    [int]$w = 1
    if ($MenuAdds -eq "$True") {
        while ($i -le $AddCount) {
            $AddItem = "AddItem-$i"
            $it1 = ($Config.$AddItem).name
            if ($i -ge 10) { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m................Name$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]$ESC[40m" ; $l++ }
            else { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m.................Name$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]$ESC[40m"; $l++ }
            $i++
            $a++
        }
    }
    [int]$pp = $l; [int]$w = 0
    [Console]::SetCursorPosition($w, $pp); Write-Host $NormalLine; $pp++
    PrettyLine; [int]$u = ($pp - 2)
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Write-host -NoNewline $LeftLine; $v++ }
    [int]$v = 3; [int]$u = ($pp - 2); [int]$w = 88
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Write-host -NoNewline $RightLine; $v++ }
    [int]$w = 0; [Console]::SetCursorPosition($w, $pp); PrettyLine; [Console]::SetCursorPosition($w, $pp)
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
        $blah = "Please enter the preferred script sort Method 0-Alpa,1-Random, 2-Length(of name)"
        $boop = "Number 0 1 or 2 or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            if ($Fixer -gt 3) { $Fixer = 3 }
            [int]$Config.basic.SortMethod = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "104") {
        if (($Config.basic.SortDir) -eq "VERT") { $Config.basic.SortDir = "HORZ" }
        else { $Config.basic.SortDir = "VERT" }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "105") {
        if (($Config.basic.DBug) -eq 1) { $Config.basic.DBug = 0 }
        else { $Config.basic.DBug = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "106") {
        $blah = "Please enter the number of script listing per line when sorted horizonal"
        $boop = "Number or script names per line or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.SpLine = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "107") {
        $blah = "Please enter the number of lines added to the SCRIPT menu."
        $boop = "Number or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.ExtraLine = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "108") {
        if (($Config.basic.WPosition) -eq 1) { $Config.basic.WPosition = 0 }
        else { $Config.basic.WPosition = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile

    }

    if ($pop -eq "109") {
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
    if ($pop -eq "110") {
        $blah = "Please enter The Console Window height. Must be equal or LESS than BuffHeight"
        $boop = "Number of console heigth or ENTER to cancel"
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
    if ($pop -eq "111") {
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
    if ($pop -eq "112") {
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
    if ($pop -eq "113") {
        if (($Config.basic.MenuAdds) -eq 1) { $Config.basic.MenuAdds = 0 }
        else { $Config.basic.MenuAdds = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "114") {
        $go = ("$base" + "BinMenu.ini")
        Start-Process $Editor -ArgumentList $go -Verb RunAs
        PrettyLine
    }
    if ($pop -eq "115") {
        SpinItems
        $qq = ($AddCount + 1)
        $AddItem = "AddItem-$qq"
        $test = @{ Name = ""; Command = ""; Argument = ""}
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config | Add-Member -Type NoteProperty -Name $AddItem -Value $test
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        SpinItems
    }
    if ($pop -eq "116") {
        SpinItems
        [int]$qq = $AddCount
        PrettyLine
        Write-Host "Enter the Number of AddItem to remove."
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
    if ($pop -eq "117") {
        PrettyLine
        Write-Host "Enter the Number of AddItem to Edit."
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
    if ($pop -eq "X") { PrettyLine; Start-Process "pwsh.exe" -ArgumentList "C:\bin\BinSM.ps1"; return }
    if ($pop -eq "Q") { return }
}
