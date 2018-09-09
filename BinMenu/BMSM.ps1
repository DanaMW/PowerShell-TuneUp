while (1) {
    $FileVersion = "Version: 0.1.9"
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
    [int]$BuffHeight = 49
    [int]$BuffWidth = 90
    [int]$WinHeight = 49
    [int]$WinWidth = 90
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
    $Script:ESC = [char]27
    [string]$NormalLine = "$ESC[91m#=======================================================================================#$ESC[97m"
    [string]$TitleLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<$ESC[96m[$ESC[41m$ESC[97mBinMenu Settings Manager$ESC[40m$ESC[96m]$ESC[96m>$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-==$ESC[91m|$ESC[97m"
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
        [Console]::SetCursorPosition($w, $pp); Write-Host "                                                                                                         "
        [Console]::SetCursorPosition($w, ($pp + 1)); Write-Host "                                                                                                         "
        [Console]::SetCursorPosition($w, ($pp + 2)); Write-Host "                                                                                                         "
        [Console]::SetCursorPosition($w, $pp)
    }
    Clear-Host
    Write-Host $NormalLine
    Write-Host $TitleLine
    Write-Host $NormalLine
    [string]$Base = $Config.basic.Base
    [bool]$ScriptRead = $Config.basic.ScriptRead
    [string]$Editor = $Config.basic.Editor
    [bool]$MenuAdds = $Config.basic.MenuAdds
    [int]$SortMethod = $Config.basic.SortMethod
    [string]$SortDir = $Config.basic.SortDir
    [int]$SpLine = $Config.basic.SpLine
    [int]$ExtraLine = $Config.basic.ExtraLine
    [bool]$DBug = $Config.basic.DBug
    [bool]$WPosition = $Config.basic.WPosition
    [int]$WinWidth = $Config.basic.WinWidth
    [int]$WinHeight = $Config.basic.WinHeight
    [int]$BuffWidth = $Config.basic.BuffWidth
    [int]$BuffHeight = $Config.basic.BuffHeight
    [int]$AddCount = $Config.AddItems.count
    [int]$w = 1
    [int]$l = 3
    [int]$v = 3
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m100$ESC[91m]$ESC[36m.............$ESC[93mBase Folder$ESC[97m:$ESC[97m" $Base; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m101$ESC[91m]$ESC[36m.........$ESC[93mRead in Scripts$ESC[97m:$ESC[97m" $ScriptRead; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m102$ESC[91m]$ESC[36m..........$ESC[93mDefined Editor$ESC[97m:$ESC[97m" $Editor; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m103$ESC[91m]$ESC[36m.............$ESC[93mSort Method$ESC[97m:$ESC[97m" $SortMethod; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m104$ESC[91m]$ESC[36m..........$ESC[93mSort Direction$ESC[97m:$ESC[97m" $SortDir; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m105$ESC[91m]$ESC[36m...................$ESC[93mDebug$ESC[97m:$ESC[97m" $DBug; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m106$ESC[91m]$ESC[36m........$ESC[93mScripts Per Line$ESC[97m:$ESC[97m" $SpLine; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m107$ESC[91m]$ESC[36m$ESC[93mNum of Extra lines added$ESC[97m:$ESC[97m" $ExtraLine; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m108$ESC[91m]$ESC[36m.....$ESC[93mUse Win Positioning$ESC[97m:$ESC[97m" $WPosition; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m109$ESC[91m]$ESC[36m............$ESC[93mWindow Width$ESC[97m:$ESC[97m" $WinWidth; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m110$ESC[91m]$ESC[36m...........$ESC[93mWindow Height$ESC[97m:$ESC[97m" $WinHeight; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m111$ESC[91m]$ESC[36m............$ESC[93mBuffer Width$ESC[97m:$ESC[97m" $BuffWidth; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m112$ESC[91m]$ESC[36m...........$ESC[93mBuffer Height$ESC[97m:$ESC[97m" $BuffHeight; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m113$ESC[91m]$ESC[36m.........$ESC[93mUse Add Entries$ESC[97m:$ESC[97m" $MenuAdds; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m114$ESC[91m] $ESC[96mWill load $AddCount entries into your editor. There you can Add, Remove or alter."; $l++
    [int]$i = 0
    while ($i -lt $AddCount) {
        $it1 = ($Config.AddItems[$i].name)
        [Console]::SetCursorPosition($w, $l); Write-Host "    $ESC[93mName$ESC[97m:$ESC[97m" $It1; $l++
        $i++
    }
    [int]$pp = $l
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp); Write-Host $NormalLine; $pp++
    PrettyLine
    [int]$u = ($pp - 2)
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Write-host -NoNewline $LeftLine; $v++ }
    [int]$v = 3
    [int]$u = ($pp - 2)
    [int]$w = 88
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Write-host -NoNewline $RightLine; $v++ }
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp)
    PrettyLine
    [Console]::SetCursorPosition($w, $pp)
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
        if (($Config.basic.ScriptRead) -eq 1) { $Config.basic.ScriptRead = 0 }
        else { $Config.basic.ScriptRead = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
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
            $Config.basic.SortMethod = $Fixer
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
        $FixFile = "C:\bin\bmsm.1"
        $Difftxt = "C:\bin\bmsm.diff"
        $Filetest = Test-Path -path $FixFile
        if ($Filetest -eq "$true") { Clear-Content -Path $FixFile }
        $Filetest = Test-Path -path $Difftxt
        if ($Filetest -eq "$true") { Clear-Content -Path $Difftxt }
        $i = 0
        while ($i -lt $AddCount) {
            [string]$ItIs1 = ($Config.AddItems[$i].name)
            [string]$ItIs2 = ($Config.AddItems[$i].Command)
            [string]$ItIs3 = ($Config.AddItems[$i].argument)
            if ($ItIs3 -eq "") { [string]$ItIs3 = "[No Argument]" }
            (Add-Content $FixFile $ItIs1)
            (Add-Content $FixFile $ItIs2)
            (Add-Content $FixFile $ItIs3)
            $I++
        }
        & Start-Process "$editor" -ArgumentList "$FixFile" -Verb RunAs
        Read-Host -Prompt "Time to Edit The file, Hit Enter When Done"
        [int]$LCount = 0
        [int]$lCount = (Get-content $FixFile).count
        $LMath = ($LCount / 3)
        [int]$lc = 0
        [int]$wc = 0
        $HoldCount = $AddCount
        while ($wc -lt $HoldCount) {
            [string]$LLine1 = ""
            $Config.AddItems[$wc].Name = $LLine1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [string]$LLine2 = ""
            $Config.AddItems[$wc].Command = $LLine2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [string]$LLine3 = ""
            $Config.AddItems[$wc].Argument = $LLine3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            $wc++
        }
        [int]$LCount = 0
        [int]$lCount = (Get-content $FixFile).count
        [int]$lc = 0
        [int]$wc = 0
        while ($lc -lt $LCount) {
            [string]$LLine1 = (Get-Content $FixFile)[$lc]; $lc++
            $Config.AddItems[$wc].Name = $LLine1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [string]$LLine2 = (Get-Content $FixFile)[$lc]; $lc++
            $Config.AddItems[$wc].Command = $LLine2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            [string]$LLine3 = (Get-Content $FixFile)[$lc]; $lc++
            $Config.AddItems[$wc].Argument = $LLine3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
            $wc++
        }
        $wc = 0
        while ($wc -le $HoldCount) {
            [string]$Line = ($Config.AddItems[$wc].name)
            if ($Line -eq "") {
                $Config.AddItems[$wc].Name = $null
                $Config |ConvertTo-Json | Set-Content $ConfigFile
                $Config.AddItems[$wc].Command = $null
                $Config |ConvertTo-Json | Set-Content $ConfigFile
                $Config.AddItems[$wc].Argument = $null
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            $wc++
        }
        $Filetest = Test-Path -path $FixFile
        if ($Filetest -eq "$true") { Remove-Item -Path $FixFile }

    }
    if ($pop -eq "X") { PrettyLine; Start-Process "pwsh.exe" -ArgumentList "C:\bin\BMSM.ps1"; return }
    if ($pop -eq "Q") { return }
}
