$FileVersion = "3.0.30"
$host.ui.RawUI.WindowTitle = ("BinMenu Script Window " + $FileVersion)
$Base = $env:Base
if (!($Base)) { Set-Variable -Name Base -Value "D:\bin" -Scope Global }
if (!($Base)) { Say -ForeGroundColor RED "SET Base environment variable in your Setup, profiles or in this Script. This shit uses that!"; break }
$ScriptBase = ($Base + "\BinMenu")
Function MyConfig {
    $MyConfig = ($ScriptBase + "\BinMenu.json")
    $MyConfig
}
[string]$ConfigFile = MyConfig
Say "Reading from config files."
try { $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "The Base configuration file is missing!"; break }
if (!($Config)) {
    Say -ForeGroundColor RED "The BinMenu.json configuration file is missing!"
    Say -ForeGroundColor RED "You need to create or edit BinMenu.json in Base directory"
    break
}
[string]$Filetmp = ($ScriptBase + "\BinTemp.del")
$Filetest = Test-Path -Path $Filetmp
if (!($Filetest)) {
    Say -ForegroundColor RED "Error: This script must be called from BinMenu E menu option."
    Read-Host -Prompt "Hit a key to exit: "
    return
}
Set-Location $ScriptBase.substring(0, 3)
Set-Location $ScriptBase
[int]$POSX = ($Config.Setup.WinSX)
if (!($POSX)) { $POSX = 1 }
[int]$POSY = ($Config.Setup.WinSY)
if (!($POSY)) { $POSY = 1 }
if (!($WinWidth)) {
    $WinWidth = 166
    $BuffWidth = $WinWidth
}
if (!($WinHeight)) {
    $WinHeight = 100
    $BuffHeight = $WinHeight
}
Function FlexWindow {
    $SaveError = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"
    $pshost = Get-Host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    [int]$newsize.height = $BuffHeight
    [int]$newsize.width = $BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    [int]$newsize.height = $WinHeight
    [int]$newsize.width = $WinWidth
    $pswindow.windowsize = $newsize
    $ErrorActionPreference = $SaveError
}
FlexWindow
Function FixLine {
    Say "                                                                                                       "
    [Console]::SetCursorPosition(0, $pp); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, 0); Say ""
    [Console]::SetCursorPosition(0, ($pp + 1)); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, 0); Say ""
    [Console]::SetCursorPosition(0, ($pp + 2)); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, $pp); Say "                                                                                                       "
    [Console]::SetCursorPosition(0, $pp)
}
$PosTest = Test-Path -Path ($Base + "\Put-WinPosition.ps1")
While (1) {
    if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $POSX -WinY $POSY | Out-Null }
    Clear-Host
    FlexWindow
    [int]$pp = 0
    [int]$LineCount = 0
    [int]$LineCount = (Get-Content $Filetmp).count
    [int]$Work = $LineCount
    $tmp = ($Work / 5)
    $tmp = [int][Math]::Ceiling($tmp)
    [int]$PMenu = $tmp
    [int]$a = $tmp
    [int]$b = ($tmp + $a)
    [int]$c = ($tmp + $b)
    [int]$d = ($tmp + $c)
    [int]$e = $work
    [int]$e = ($work - $d)
    $Row = @($a, $b, $c, $d, $e)
    $Col = @(1, 34, 67, 100, 133)
    [int]$pp = ($PMenu)
    [Console]::SetCursorPosition(0, $pp)
    $WinHeight = ($pp + 4)
    $BuffHeight = $WinHeight
    FlexWindow
    [Console]::SetCursorPosition(0, $pp)
    Say $NormalLine
    [int]$l = 0
    [int]$w = $col[0]
    [int]$i = 1
    [Int]$num = 1
    FlexWindow
    $header = "Base.ps1 Edit.ps1 Find.ps1 Get.ps1 Go.ps1 Out.ps1 Put.ps1 Remove.ps1 Repair.ps1 Run.ps1 Test.ps1 Update.ps1 Write.ps1"
    $Reader = New-Object IO.StreamReader ($filetmp, [Text.Encoding]::UTF8, $true, 4MB)
    While ($i -le $Work) {
        $Line = $Reader.ReadLine()
        if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
        [Console]::SetCursorPosition($w, $l)
        if ($Num -le 9) {
            if ($header -match $line) {
                $footer = ("$footer" + "$num" + " ")
                WC "~DARKRED~[~~cyan~ $Num~~DARKRED~]~ ~cyan~$Line~"
            }
            else { WC "~DARKRED~[~~WHITE~ $Num~~DARKRED~]~ ~GREEN~$Line~" }
        }
        else {
            if ($header -match $line) {
                $footer = ("$footer" + "$num" + " ")
                WC "~DARKRED~[~~cyan~$Num~~DARKRED~]~ ~cyan~$Line~"
            }
            else { WC "~DARKRED~[~~WHITE~$Num~~DARKRED~]~ ~GREEN~$Line~" }
        }
        if ($i -eq $Row[0]) { [int]$l = -1; [int]$w = $Col[1] }
        if ($i -eq $Row[1]) { [int]$l = -1; [int]$w = $Col[2] }
        if ($i -eq $Row[2]) { [int]$l = -1; [int]$w = $Col[3] }
        if ($i -eq $Row[3]) { [int]$l = -1; [int]$w = $Col[4] }
        $i++
        $L++
        $num++
    }
    $Reader.close()
    [Console]::SetCursorPosition(0, $pp)
    WC "~white~#>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<#"
    $ans = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~Select A Number~DARKRED~(~~WHITE~##~~DARKRED~) (~~WHITE~R~~DARKRED~)~~DARKYELLOW~eload or ~~DARKRED~(~~WHITE~Q~~DARKRED~)~~DARKYELLOW~uit~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $menuPrompt)
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($ans, [ref]$OutNumber)) {
        FixLine
        $MaxYes = (Get-Content $Filetmp).count
        if ($OutNumber -gt 0 -and $OutNumber -le $MaxYes) {
            $OutNumber = ($OutNumber - 1)
            $Read = (Get-Content $Filetmp)[$OutNumber]
            $cmd1 = ($Base + "\" + $Read)
            $OutNumber = ($OutNumber + 1)
            if ($footer -notmatch $outnumber) {
                WC "~white~#>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<#"
                $cmd2 = $($MenuPrompt = WCP "~DARKCYAN~[~~DARKYELLOW~Enter Any Parameters For Script~~DARKCYAN~]~~WHITE~: "; Read-Host -Prompt $menuPrompt)
            }
            [string]$FileRun = ($ScriptBase + "\BSTempRun.ps1")
            $Filetest = Test-Path -Path $FileRun
            if (($Filetest)) { Remove-Item $FileRun -Force }
            Write-Output "pwsh.exe $cmd1 $cmd2" > $FileRun
            Write-Output 'Put-Pause -Prompt "~darkcyan~[~~darkyellow~Press any key to return to  menu~~darkcyan~]~white~:~ " -Max 0 -Echo 1' >> $FileRun
            FixLine
            Start-Process pwsh.exe -ArgumentList $FileRun -Verb RunAs -Wait
            FixLine
            $Filetest = Test-Path -Path $FileRun
            if (($Filetest)) { Remove-Item $FileRun -Force }
            Set-Location $ScriptBase.substring(0, 3)
            Set-Location $ScriptBase
        }
    }
    elseif ($ans -eq "Q") {
        $Filetest = Test-Path -Path $Filetmp
        if (($Filetest)) {
            Remove-Item $Filetmp
            Clear-Host
            Return
        }
    }
    elseif ($ans -eq "R") {
        Clear-Host
        Start-Process "pwsh.exe" -ArgumentList ($ScriptBase + "\BinScript.ps1")
        return
    }
    else {
        FixLine
        [Console]::SetCursorPosition(0, $pp)
        Say -NoNewLine "Sorry, that is not an option. Feel free to try again."
        Start-Sleep -Milliseconds 500
        FixLine
        FlexWindow
        if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $POSX -WinY $POSY | Out-Null }
    }
}
$Filetest = Test-Path -Path $Filetmp
if (($Filetest)) { Remove-Item -Path $Filetmp }
