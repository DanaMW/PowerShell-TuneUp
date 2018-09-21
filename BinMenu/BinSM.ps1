while (1) {
    $FileVersion = "Version: 0.2.8"
    $host.ui.RawUI.WindowTitle = "BinMenu Settings Manager $FileVersion"
    Function Get-ScriptDir { Split-Path -parent $PSCommandPath }
    Function MyConfig {
        $Script:MyConfig = "C:\bin\BinMenu.json"
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
        $Sc = 15
        $Script:AddCount = 0
        While ($si -lt $sc) {
            $name = "name$si"
            $Spin = ($Config.AddItems.$name)
            if ($null -ne $Spin) { $Script:AddCount++; $si++ }
            else { $si = 15 }
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
    $newsize.height = 40
    $newsize.width = 90
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = 40
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
    Function Stop {
        $Stop = Read-Host -Prompt "[Enter]"
        $Stop
    }
    Function Show {
        $Show = Write-Host $Show
        $Show
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
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m115$ESC[91m]$ESC[36m................$ESC[91mADD Entry$ESC[97m:$ESC[97m [$ESC[91mAdd New Item$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m114$ESC[91m]$ESC[36m.............$ESC[91mEdit the INI$ESC[97m:$ESC[97m [$ESC[91mEdit BinMenu.ini$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m116$ESC[91m]$ESC[36m.............$ESC[91mDELETE Entry$ESC[97m:$ESC[97m [$ESC[91mDelete Existing Item$ESC[97m]$ESC[40m"; $l++
    [int]$i = 1
    [int]$a = 117
    [int]$w = 1
    if ($MenuAdds -eq "$True") {
        while ($i -le $AddCount) {
            [string]$name = "name$i"
            $it1 = ($Config.AddItems.$name)
            if ($i -ge 10) { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m$a$ESC[91m]$ESC[36m............$ESC[93mEntry $i Name$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]$ESC[40m" ; $l++ }
            else { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m$a$ESC[91m]$ESC[36m.............$ESC[93mEntry $i Name$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m]$ESC[40m"; $l++ }
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
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config.AddItems | Add-Member -Type NoteProperty -Name  "Name$qq" -Value ""
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Config.AddItems | Add-Member -Type NoteProperty -Name "Command$qq" -Value ""
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Config.AddItems | Add-Member -Type NoteProperty -Name "Argument$qq" -Value "[No Argument]"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        SpinItems
    }
    if ($pop -eq "116") {
        SpinItems
        [int]$qq = $AddCount
        PrettyLine
        Write-Host "Enter the Number of AddEntry to remove."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter for $qq]"
        PrettyLine
        if ($q1 -eq "") { $q1 = $qq }
        $Config =  Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config.AddItems = $Config.AddItems | Select-Object -Property * -ExcludeProperty "Name$q1"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Config.AddItems = $Config.AddItems | Select-Object -Property * -ExcludeProperty "Command$q1"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Config.AddItems = $Config.AddItems | Select-Object -Property * -ExcludeProperty "Argument$q1"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $si = ($q1 + 1)
        $Sc = 15
        While ($si -lt $sc) {
            #read
            [string]$name = "name$si"
            $Readit1 = ($Config.AddItems.$name)
            if ($null -eq $Readit1) { $si = 16 }
            if  ($si -lt "16") {
                [string]$command = "command$si"
                $Readit2 = ($Config.AddItems.$command)
                [string]$argument = "argument$si"
                $Readit3 = ($Config.AddItems.$argument)
            }
            #Write
            if  ($si -lt "16") {
                $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
                $Config.AddItems | Add-Member -Type NoteProperty -Name  "Name$q1" -Value $ReadIt1
                $Config | ConvertTo-Json | Set-Content $ConfigFile
                $Config.AddItems | Add-Member -Type NoteProperty -Name "Command$q1" -Value $readit2
                $Config | ConvertTo-Json | Set-Content $ConfigFile
                $Config.AddItems | Add-Member -Type NoteProperty -Name "Argument$q1" -Value $readit3
                $Config | ConvertTo-Json | Set-Content $ConfigFile
            }
            if  ($si -lt "16") {
            #delete
                $Config =  Get-Content $ConfigFile | Out-String | ConvertFrom-Json
                $Config.AddItems = $Config.AddItems | Select-Object -Property * -ExcludeProperty "Name$si"
                $Config | ConvertTo-Json | Set-Content $ConfigFile
                $Config.AddItems = $Config.AddItems | Select-Object -Property * -ExcludeProperty "Command$si"
                $Config | ConvertTo-Json | Set-Content $ConfigFile
                $Config.AddItems = $Config.AddItems | Select-Object -Property * -ExcludeProperty "Argument$si"
                $Config | ConvertTo-Json | Set-Content $ConfigFile
                $si++
                $q1++
            }
        }
        SpinItems
    }
    if ($pop -eq "117") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        [string]$name = "name$i"
        $Fight1 = ($Config.AddItems.name1)
        $Fight2 = ($Config.AddItems.command1)
        $Fight3 = ($Config.AddItems.argument1)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        PrettyLine
        if ($Fight1 -ne "") {
            $Config.AddItems.name1 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command1 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument1 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "118") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name2)
        $Fight2 = ($Config.AddItems.command2)
        $Fight3 = ($Config.AddItems.argument2)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name2 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command2 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument2 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "119") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name3)
        $Fight2 = ($Config.AddItems.command3)
        $Fight3 = ($Config.AddItems.argument3)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name3 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command3 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument3 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "120") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name4)
        $Fight2 = ($Config.AddItems.command4)
        $Fight3 = ($Config.AddItems.argument4)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name4 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command4 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument4 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "121") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name5)
        $Fight2 = ($Config.AddItems.command5)
        $Fight3 = ($Config.AddItems.argument5)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name5 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command5 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument5 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "122") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name6)
        $Fight2 = ($Config.AddItems.command6)
        $Fight3 = ($Config.AddItems.$argument6)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name6 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command6 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument6 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "123") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name7)
        $Fight2 = ($Config.AddItems.command7)
        $Fight3 = ($Config.AddItems.argument7)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name7 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command7 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument7 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "124") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name8)
        $Fight2 = ($Config.AddItems.command8)
        $Fight3 = ($Config.AddItems.argument8)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name8 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command8 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument8 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "125") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name9)
        $Fight2 = ($Config.AddItems.command9)
        $Fight3 = ($Config.AddItems.argument9)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name9 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command9 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument9 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "126") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name10)
        $Fight2 = ($Config.AddItems.command10)
        $Fight3 = ($Config.AddItems.argument10)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name10 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command10 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument10 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "127") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name11)
        $Fight2 = ($Config.AddItems.command11)
        $Fight3 = ($Config.AddItems.argument11)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name11 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command11 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument11 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "128") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name12)
        $Fight2 = ($Config.AddItems.command12)
        $Fight3 = ($Config.AddItems.argument12)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        PrettytLine
        if ($Fight1 -ne "") {
            $Config.AddItems.name12 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command12 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument12 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        PrettyLine
    }
    if ($pop -eq "129") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name13)
        $Fight2 = ($Config.AddItems.command13)
        $Fight3 = ($Config.AddItems.argument13)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name13 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command13 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument13 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "130") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name14)
        $Fight2 = ($Config.AddItems.command14)
        $Fight3 = ($Config.AddItems.argument14)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name14 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command14 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument14 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "131") {
        $rich1 = "Please enter the NAME or Title of the program for this entry."
        $rich2 = "Please enter COMPLETE PATH and FILENAME for this entry."
        $rich3 = "Please enter any ARGUMENTS you need for this entry."
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.AddItems.name15)
        $Fight2 = ($Config.AddItems.command15)
        $Fight3 = ($Config.AddItems.argument15)
        if ($Fight3 -eq "") { $Fight3 = "[No Arguement]"}
        FightOn
        if ($Fight1 -ne "") {
            $Config.AddItems.name15 = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.AddItems.command15 = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.AddItems.argument15 = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "X") { PrettyLine; Start-Process "pwsh.exe" -ArgumentList "C:\bin\BinSM.ps1"; return }
    if ($pop -eq "Q") { return }
}
