while (1) {
    $FileVersion = "Version: 1.0.5"
    $host.ui.RawUI.WindowTitle = "Delay-StartUp Settings Manager $FileVersion"
    Function Get-ScriptDir { Split-Path -parent $PSCommandPath }
    Function MyConfig {
        $Script:MyConfig = $(Get-ScriptDir) + "\Delay-StartUp.json"
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
    [string]$Base = ($Config.basic.Base)
    if ($base.substring(($Base.length - 1)) -ne "\") { [string]$base = $base + "\" }
    [int]$StartDelay = ($Config.basic.StartDelay)
    [int]$Delay = ($Config.basic.Delay)
    [bool]$Prevent = ($Config.basic.Prevent)
    [bool]$DBug = ($Config.basic.DBug)
    $Script:ESC = [char]27
    [string]$NormalLine = "$ESC[91m#=======================================================================================#$ESC[97m"
    [string]$TitleLine = "$ESC[91m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=<$ESC[96m[$ESC[41m$ESC[97mDelay-StartUp Settings Manager$ESC[40m$ESC[96m]$ESC[96m>$ESC[97m-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[91m|$ESC[97m"
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
        [Console]::SetCursorPosition($w, $pp); Write-Host -NoNewLine "                                                             "
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
        Write-Host $Rich1A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host $rich1B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight1 = Read-Host -Prompt $boop
        PrettyLine
        Write-Host $Rich2A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host $rich2B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight2 = Read-Host -Prompt $boop
        PrettyLine
        Write-Host $Rich3A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host $rich3B
        [Console]::SetCursorPosition($w, ($pp + 2))
        $Script:Fight3 = Read-Host -Prompt $boop
        PrettyLine
        Write-Host $Rich4A
        [Console]::SetCursorPosition($w, ($pp + 1))
        Write-Host $rich4B
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
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine $NormalLine; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine $TitleLine; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine $NormalLine; $l++
    [int]$w = 1
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m100$ESC[91m]$ESC[36m.................$ESC[93mBase Folder$ESC[97m:$ESC[97m [$ESC[92m$Base$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m101$ESC[91m]$ESC[36m........$ESC[93mStartUp delay (Secs)$ESC[97m:$ESC[97m [$ESC[92m$StartDelay$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m102$ESC[91m]$ESC[36m......$ESC[93mDelay between programs$ESC[97m:$ESC[97m [$ESC[92m$Delay$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m103$ESC[91m]$ESC[36m........$ESC[93mPrevent from running$ESC[97m:$ESC[97m [$ESC[92m$Prevent$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m104$ESC[91m]$ESC[36m.......................$ESC[93mDebug$ESC[97m:$ESC[97m [$ESC[92m$DBug$ESC[97m]$ESC[40m"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[36m......$ESC[96mNum of Program Adds in JSON$ESC[97m:$ESC[97m [$ESC[96m" $AddCount "$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m105$ESC[91m]$ESC[36m...................$ESC[91mADD Entry$ESC[97m:$ESC[97m [$ESC[91mAdd A New Delayed Start Entry$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m106$ESC[91m]$ESC[36m................$ESC[91mDELETE Entry$ESC[97m:$ESC[97m [$ESC[91mDelete Existing Delayed Start Entry$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m107$ESC[91m]$ESC[36m..................$ESC[91mEdit Entry$ESC[97m:$ESC[97m [$ESC[91mEdit One Of The Current Entries$ESC[97m]"; $l++
    [int]$v = 3
    [int]$i = 1
    #[int]$a = 8
    [int]$w = 1
    while ($i -le $AddCount) {
        $RunItem = "RunItem-$i"
        $it1 = ($Config.$RunItem).name
        $it2 = ($Config.$RunItem).HostOnly
        if ($i -lt "10") { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m....................$ESC[93mName$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m][$ESC[94m$it2$ESC[97m]$ESC[40m" ; $l++ }
        if ($i -ge "10") { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[93mEntry $ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m...................$ESC[93mName$ESC[97m:$ESC[97m [$ESC[94m$it1$ESC[97m][$ESC[94m$it2$ESC[97m]$ESC[40m" ; $l++ }
        $i++
        $a++
    }
    $w = 0
    [int]$pp = $l
    [Console]::SetCursorPosition($w, $pp); Write-Host $NormalLine
    $pp++
    PrettyLine
    [int]$u = ($pp - 1)
    While ($v -le $u) {
        [Console]::SetCursorPosition($w, $v)
        Write-host -NoNewline $LeftLine
        $v++
    }
    [int]$v = 3
    [int]$u = ($pp - 2)
    [int]$w = 88
    While ($v -le $u) {
        [Console]::SetCursorPosition($w, $v)
        Write-host -NoNewline $RightLine; $v++
    }
    [int]$pp = ($l + 1)
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp)
    PrettyLine
    [Console]::SetCursorPosition($w, $pp)
    $pop = Read-Host -Prompt "$ESC[91m[$ESC[97mNum $ESC[96mto Edit, $ESC[97mX $ESC[96mReload, $ESC[97mQ $ESC[96mQuit$ESC[91m]$ESC[97m"
    if ($pop -eq "100") {
        $blah = "Please enter the folder to set as BASE."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Base = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "101") {
        $blah = "Please enter the seconds to delay start."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.StartDelay = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "102") {
        $blah = "Please enter the seconds to delay between each."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Delay = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "103") {
        if (($Config.basic.Prevent) -eq 0) { $Config.basic.Prevent = 1 }
        else { $Config.basic.Prevent = 0 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "104") {
`
            if (($Config.basic.DBug) -eq 0) { $Config.basic.DBug = 1 }
        else { $Config.basic.DBug = 0 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "105") {
        SpinItems
        $qq = ($AddCount + 1)
        $RunItem = "RunItem-$qq"
        $test = @{Name = ""; HostOnly = ""; RunPath = ""; Argument = ""}
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config | Add-Member -Type NoteProperty -Name $RunItem -Value $test
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        SpinItems
    }
    if ($pop -eq "106") {
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
    if ($pop -eq "107") {
        PrettyLine
        Write-Host "Enter the Number of RunItem to Edit."
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
            $boop = "[ENTER for No Change]"
            FightOn
            if ($Fight1 -ne "") {
                $Config.$RunItem.Name = $Fight1
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight2 -ne "") {
                $Config.$RunItem.HostOnly = $Fight2
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight3 -ne "") {
                $Config.$RunItem.RunPath = $Fight3
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
            if ($Fight4 -ne "") {
                $Config.$RunItem.RunPath = $Fight4
                $Config |ConvertTo-Json | Set-Content $ConfigFile
            }
        }
        PrettyLine
    }
    if ($pop -eq "X") { PrettyLine; Start-Process "pwsh.exe" -ArgumentList "C:\bin\DelaySM.ps1"; return }
    if ($pop -eq "Q") { return }
    PrettyLine
}
