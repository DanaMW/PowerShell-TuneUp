while (1) {
    $FileVersion = "Version: 0.0.5"
    $host.ui.RawUI.WindowTitle = "Delay-StartUp Settings Manager $FileVersion"
    Function Get-ScriptDir { Split-Path -parent $PSCommandPath }
    Function MyConfig {
        $Script:MyConfig = "C:\bin\Delay-StartUp.json"
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
    [int]$StartDelay = ($Config.basic.StartDelay)
    [int]$Delay = ($Config.basic.Delay)
    [bool]$Prevent = ($Config.basic.Prevent)
    [bool]$DBug = ($Config.basic.DBug)
    [int]$AddCount = ($Config.RunItems.count)
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
    Function Stop {
        $Stop = Read-Host -Prompt "[Enter]"
        $Stop
    }
    Function Show {
        $Show = Write-Host $Show
        $Show
    }
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
    [int]$l = 0
    [int]$w = 0
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine $NormalLine; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine $TitleLine; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine $NormalLine; $l++
    [int]$w = 1
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m1$ESC[91m]$ESC[36m.............$ESC[93mBase Folder$ESC[97m:$ESC[97m [$Base]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m2$ESC[91m]$ESC[36m....$ESC[93mStartUp delay (Secs)$ESC[97m:$ESC[97m [$StartDelay]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m3$ESC[91m]$ESC[36m..$ESC[93mDelay between programs$ESC[97m:$ESC[97m [$Delay]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m4$ESC[91m]$ESC[36m....$ESC[93mPrevent from running$ESC[97m:$ESC[97m [$Prevent]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m5$ESC[91m]$ESC[36m...................$ESC[93mDebug$ESC[97m:$ESC[97m [$DBug]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[96mNum of Program Adds in JSON$ESC[97m:$ESC[97m [$ESC[96m" $AddCount "$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m6$ESC[91m]$ESC[36m...........$ESC[91mADD New Entry$ESC[97m:$ESC[97m [$ESC[91mAdd New$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m7$ESC[91m]$ESC[36m...$ESC[91mDELETE Existing Entry$ESC[97m:$ESC[97m [$ESC[91mDelete Existing$ESC[97m]"; $l++
    [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m8$ESC[91m]$ESC[36m.....$ESC[91mEdit Existing Entry$ESC[97m:$ESC[97m [$ESC[91mEdit Entry$ESC[97m]"; $l++
    [int]$v = 3
    [int]$i = 0
    #[int]$a = 8
    [int]$w = 1
    while ($i -lt $AddCount) {
        $it1 = ($Config.RunItems[$i].name)
        if ($i -lt "10") { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m $ESC[91m]$ESC[36m.......$ESC[93mAdd Entry $i Name$ESC[97m:$ESC[97m [$it1]" ; $l++ }
        if ($i -ge "10") { [Console]::SetCursorPosition($w, $l); Write-Host -NoNewLine "$ESC[91m[$ESC[97m $ESC[91m]$ESC[36m......$ESC[93mAdd Entry $i Name$ESC[97m:$ESC[97m [$it1]"; $l++ }
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
    [int]$w = 0
    [Console]::SetCursorPosition($w, $pp)
    PrettyLine
    [Console]::SetCursorPosition($w, $pp)
    $pop = Read-Host -Prompt "$ESC[91m[$ESC[97mNum $ESC[96mto Edit, $ESC[97mX $ESC[96mReload, $ESC[97mQ $ESC[96mQuit$ESC[91m]$ESC[97m"
    if ($pop -eq "1") {
        $blah = "Please enter the folder to set as BASE."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Base = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "2") {
        $blah = "Please enter the seconds to delay start."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.StartDelay = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "3") {
        $blah = "Please enter the seconds to delay between each."
        $boop = "Folder path or ENTER to cancel"
        FuckOff
        if ($Fixer -ne "") {
            $Config.basic.Delay = $Fixer
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
    }
    if ($pop -eq "4") {
        if (($Config.basic.Prevent) -eq 0) { $Config.basic.Prevent = 1 }
        else { $Config.basic.Prevent = 0 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "5") {
`
            if (($Config.basic.DBug) -eq 0) { $Config.basic.DBug = 1 }
        else { $Config.basic.DBug = 0 }
        $Config |ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "6") {
        #$BlankAdd1 = @{}
        #$BlankAdd2 = @{}
        #$BlankAdd3 = @{}
        #$BlankAdd4 = @{}
        #[array]$BlankAdd1 = @{Name = ""}
        #[array]$BlankAdd2 = @{HostOnly = ""}
        #[array]$BlankAdd3 = @{RunPath = ""}
        #[array]$BlankAdd4 = @{Argument = ""}
        #$BlankAdd = @{"Name" = ""; "HostOnly" = ""; "RunPath" = ""; "Argument" = ""}
        #$qq = ($AddCount + 1)
        #$Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        #(Convertfrom-Json $blockcvalue)dd-member -Name "BlockC" -value (Convertfrom-Json $blockcvalue) -MemberType NoteProperty
        #$Config.RunItems | Add-Member -Name "Name" -value ( Convertfrom-Json -InPutObject $blankAdd1 ) -MemberType NoteProperty -PassThru
        #$Config | ConvertTo-Json | Set-Content $ConfigFile
        #$Config.RunItems | Add-Member -Name "HostOnly" -value ( Convertfrom-Json -InputObject $blankAdd2 ) -MemberType NoteProperty -PassThru
        #$Config | ConvertTo-Json | Set-Content $ConfigFile
        #$Config.RunItems | Add-Member -Name "RunPath" -value ( Convertfrom-Json -InputObject $blankAdd3 ) -MemberType NoteProperty -PassThru
        #$Config | ConvertTo-Json | Set-Content $ConfigFile
        #$Config.RunItems | Add-Member -Name "Argument" -value ( Convertfrom-Json -InputObject $blankAdd4 ) -MemberType NoteProperty -PassThru
        #$Config | ConvertTo-Json | Set-Content $ConfigFile
    }
    if ($pop -eq "7") {
        <#
        [int]$qq = $AddCount
        PrettyLine
        Write-Host "Enter the Number of RunItem to Edit."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter for $qq]"
        PrettyLine
        if ($q1 -eq "") { $q1 = $qq }
        $Config = Get-Content $ConfigFile | Out-String | ConvertFrom-Json
        $Config.RunItems = $Config.RunItems | Select-Object -Property * -ExcludeProperty "Name"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Config.RunItems = $Config.RunItems | Select-Object -Property * -ExcludeProperty "HostOnly"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Config.RunItems = $Config.RunItems | Select-Object -Property * -ExcludeProperty "Argument"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Config.RunItems = $Config.RunItems | Select-Object -Property * -ExcludeProperty "Argument"
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $si++
        $q1++
        #>
    }
    if ($pop -eq "8") {
        PrettyLine
        Write-Host "Enter the Number of RunItem to Edit."
        [Console]::SetCursorPosition($w, ($pp + 1))
        [int]$q1 = Read-Host -Prompt "Enter NUMBER of entry or [Enter to Cancel]"
        PrettyLine
        $Fight1 = ($Config.RunItems[$q1].Name)
        $Fight2 = ($Config.RunItems[$q1].HostOnly)
        $Fight3 = ($Config.RunItems[$q1].RunPath)
        $Fight4 = ($Config.RunItems[$q1].Argument)
        $rich1A = "Please enter the NAME or Title of the program for this entry."
        $rich1B = "Current Value: $Fight1"
        $rich2A = "Please enter the HOSTNAME that this will run on."
        $rich2B = "Current Value: $Fight2"
        $Rich3A = "Please enter the COMPLETE PATH and FILENAME for this entry"
        $Rich3B = "Current Value: $Fight3"
        $rich4A = "Please enter any ARGUMENTS you need for this entry."
        $rich4B = "Current Value: $Fight4"
        $boop = "[ENTER for No Change]"
        $Fight1 = ($Config.RunItems[$q1].Name)
        $Fight2 = ($Config.RunItems[$q1].HostOnly)
        $Fight3 = ($Config.RunItems[$q1].RunPath)
        $Fight4 = ($Config.RunItems[$q1].Argument)
        FightOn
        if ($Fight1 -ne "") {
            $Config.RunItems[$q1].Name = $Fight1
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight2 -ne "") {
            $Config.RunItems[$q1].HostOnly = $Fight2
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight3 -ne "") {
            $Config.RunItems[$q1].RunPath = $Fight3
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        if ($Fight4 -ne "") {
            $Config.RunItems[$q1].RunPath = $Fight4
            $Config |ConvertTo-Json | Set-Content $ConfigFile
        }
        PrettyLine
    }
    if ($pop -eq "X") { PrettyLine; Start-Process "pwsh.exe" -ArgumentList "C:\bin\DelaySM.ps1"; return }
    if ($pop -eq "Q") { return }
    PrettyLine
}
