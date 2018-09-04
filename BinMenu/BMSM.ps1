while (1) {
    $FileVersion = "Version: 0.1.1"
    $host.ui.RawUI.WindowTitle = "BinMenu Settings Manager $FileVersion"
    Function Get-ScriptDir { Split-Path -parent $PSCommandPath }
    Function MyConfig {
        $MyConfig = "C:\bin\BinMenu.json"
        $MyConfig
    }
    $ConfigFile = MyConfig
    try { $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
    catch { Write-Error -Message "The Base configuration file is missing!" }
    if (!($Config)) { Write-Error -Message "The Base configuration file is missing!" }
    [int]$BuffHeight = 42
    [int]$BuffWidth = 100
    [int]$WinHeight = 42
    [int]$WinWidth = 100
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
    $ESC = [char]27
    [string]$NormalLine = "$ESC[91m#=================================================================================================#$ESC[97m"
    [string]$TitleLine = "$ESC[91m|$ESC[97m-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<$ESC[96m[$ESC[41m$ESC[97mBinMenu Settings Manager$ESC[40m$ESC[96m]$ESC[96m>$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[91m|$ESC[97m"
    [string]$LeftLine = "$ESC[31m|"
    [string]$RightLine = "$ESC[31m|"
    Function FuckOff {
        #param([string]$Fixer, [string]$blah, [string]$boop)
        PrettyLine
        Write-Host $blah
        [Console]::SetCursorPosition($w, ($pp + 1))
        $Global:Fixer = Read-Host -Prompt $boop
        PrettyLine
        $Fixer
    }
    Function PrettyLine {
        [Console]::SetCursorPosition($w, $pp)
        Write-Host "                                                                                                         "
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host "                                                                                                         "
        [Console]::SetCursorPosition($w, ($pp + 2))
        Write-Host "                                                                                                         "
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
    [int]$SpLine = $Config.basic.SpLine
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
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m100$ESC[91m]$ESC[36m.........$ESC[93mBase Folder$ESC[97m: $ESC[91m" $Base; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m101$ESC[91m]$ESC[36m.....$ESC[93mRead in Scripts$ESC[97m: $ESC[91m" $ScriptRead; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m102$ESC[91m]$ESC[36m......$ESC[93mDefined Editor$ESC[97m: $ESC[91m" $Editor; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m103$ESC[91m]$ESC[36m.....$ESC[93mUse Add Entries$ESC[97m: $ESC[91m" $MenuAdds; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m104$ESC[91m]$ESC[36m.........$ESC[93mSort Method$ESC[97m: $ESC[91m" $SortMethod; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m105$ESC[91m]$ESC[36m...............$ESC[93mDebug$ESC[97m: $ESC[91m" $DBug; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m106$ESC[91m]$ESC[36m....$ESC[93mScripts Per Line$ESC[97m: $ESC[91m" $SpLine; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m107$ESC[91m]$ESC[36m.$ESC[93mUse Win Positioning$ESC[97m: $ESC[91m" $WPosition; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m108$ESC[91m]$ESC[36m........$ESC[93mWindow Width$ESC[97m: $ESC[91m" $WinWidth; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m109$ESC[91m]$ESC[36m.......$ESC[93mWindow Height$ESC[97m: $ESC[91m" $WinHeight; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m110$ESC[91m]$ESC[36m........$ESC[93mBuffer Width$ESC[97m: $ESC[91m" $BuffWidth; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m111$ESC[91m]$ESC[36m.......$ESC[93mBuffer Height$ESC[97m: $ESC[91m" $BuffHeight; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[36m.$ESC[95mNumber of file Additions$ESC[97m: $ESC[95m" $AddCount; $l++
    [int]$o = 113
    [int]$i = 0
    while ($i -lt $AddCount) {
        $it1 = ($Config.AddItems[$i].name)
        $it2 = ($Config.AddItems[$i].Command)
        $it3 = ($Config.AddItems[$i].argument)
        [Console]::SetCursorPosition($w, $l); Write-Host "$ESC[91m[$ESC[97m$o$ESC[91m]$ESC[96m........\.......$ESC[93mName$ESC[97m: $ESC[91m" $It1; $l++
        [Console]::SetCursorPosition($w, $l); Write-Host "              $ESC[96m\...$ESC[93mCommand$ESC[97m: $ESC[91m" $It2
        if ($it3 -ne "") { $l++; [Console]::SetCursorPosition($w, $l); Write-Host "               $ESC[96m\.$ESC[93mArgument$ESC[97m: $ESC[91m" $It3 }
        $i++
        $o++
        $l++
    }
    [int]$pp = $l
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp); Write-Host $NormalLine; $pp++
    PrettyLine
    [int]$u = ($pp - 2)
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Write-host -NoNewline $LeftLine; $v++ }
    [int]$v = 3
    [int]$u = ($pp - 2)
    [int]$w = 98
    While ($v -le $u) { [Console]::SetCursorPosition($w, $v); Write-host -NoNewline $RightLine; $v++ }
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp); PrettyLine
    [Console]::SetCursorPosition($w, $pp);
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
        if (($Config.basic.MenuAdd) -eq 1) { $Config.basic.MenuAdd = 0 }
        else { $Config.basic.MenuAdd = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "104") {
        $blah = "Please enter the preferred script sort Method 0-Alpa,1-Random, 2-Length(of name)"
        $boop = "Number 0 1 or 2 or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.SortMethod = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "105") {
        if (($Config.basic.DBug) -eq 1) { $Config.basic.DBug = 0 }
        else { $Config.basic.DBug = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "106") {
        $blah = "Please enter the number of script listing per line when sorted horizonal"
        $boop = "Number or script names per line  or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.SPLine = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "107") {
        if (($Config.basic.WPosition) -eq 1) { $Config.basic.WPosition = 0 }
        else { $Config.basic.WPosition = 1 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "108") {
        $blah = "Please enter The Console Window width. must be equal or LESS than BuffWidth"
        $boop = "Number of console Width or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -le $BuffWidth) {
                $Config.basic.WinWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Global:Fixer = $BuffWidth
                $Config.basic.WinWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "109") {
        $blah = "Please enter The Console Window height. Must be equal or LESS than BuffHeight"
        $boop = "Number of console heigth or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -le $BuffHeight) {
                $Config.basic.WinHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Global:Fixer = $BuffHeight
                $Config.basic.WinHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "110") {
        $blah = "Please enter The Console buffer width. Must be equal or GREATER than WinWidth"
        $boop = "Number of console buffer width or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -ge $WinWidth) {
                $Config.basic.BuffWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Global:Fixer = ($WinWidth + 1)
                $Config.basic.BuffWidth = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "111") {
        $blah = "Please enter The Console Window width. must be equal or GREATER than WinHeight"
        $boop = "Number of console buffer Height or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            If ($Fixer -ge $WinHeight) {
                $Config.basic.BuffHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            else {
                $Global:Fixer = ($WinHeight + 1)
                $Config.basic.BuffHeight = $Fixer
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
    }
    if ($pop -eq "112") { return }
    if ($pop -eq "113") { return }
    if ($pop -eq "114") { return }
    if ($pop -eq "115") { return }
    if ($pop -eq "116") { return }
    if ($pop -eq "117") { return }
    if ($pop -eq "118") { return }
    if ($pop -eq "119") { return }
    if ($pop -eq "120") { return }
    if ($pop -eq "X") {
        PrettyLine
        Start-Process "pwsh.exe" -ArgumentList "C:\bin\BMSM.ps1"
        return
    }
    if ($pop -eq "Q") { return }
}
