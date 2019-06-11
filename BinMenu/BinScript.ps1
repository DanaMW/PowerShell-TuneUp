$FileVersion = "Version: 2.1.11"
$host.ui.RawUI.WindowTitle = ("BinMenu Script Window " + $FileVersion)
$Base = $env:Base
if (!($Base)) { Set-Variable -Name Base -Value "D:\bin" -Scope Global }
if (!($Base)) { Say -ForeGroundColor RED "SET BASE environment variable in your Setup, profiles or in this Script. This shit uses that!"; break }
[string]$Filetmp = ($Base + "\BinTemp.del")
Set-Location $Base.substring(0, 3)
Set-Location $Base
$ESC = [char]27
Set-Location $Base.substring(0, 3)
Set-Location $Base
$ScriptName = "BinScript"
$menu = "$ESC[36m[$ESC[33mSelect A Number, $ESC[31m($ESC[97mR$ESC[31m)$ESC[33meload or $ESC[31m($ESC[97mQ$ESC[31m)$ESC[33muit$ESC[36m]$ESC[97m"
$menuPrompt += $menu
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
<# SET THE BELOW TO POSITION THE SCRIPT WINDOW #>
$PosTest = Test-Path -path ($Base + "\Put-WinPosition.ps1")
$POSX = 325
$POSY = 170
While (1) {
    if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $POSX -WinY $POSY > $null }
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
    $Reader = New-Object IO.StreamReader ($filetmp, [Text.Encoding]::UTF8, $true, 4MB)
    While ($i -le $Work) {
        $Line = $Reader.ReadLine()
        if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
        [Console]::SetCursorPosition($w, $l)
        Say -NoNewLine "$ESC[31m[$ESC[97m$Num$ESC[31m]$ESC[32m" $Line
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
    $ans = Read-Host -Prompt $menuprompt
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($ans, [ref]$OutNumber)) {
        FixLine
        $MaxYes = (Get-Content $Filetmp).count
        if ($OutNumber -gt 0 -and $OutNumber -le $MaxYes) {
            $OutNumber = ($OutNumber - 1)
            $Read = (Get-Content $Filetmp)[$OutNumber]
            $cmd1 = $Read
            $cmd2 = Read-Host "$ESC[31m[$ESC[97mEnter Any Parameters For Script$ESC[31m]$ESC[97m"
            FixLine
            Start-Process pwsh.exe -ArgumentList $cmd1$cmd2 -Verb RunAs
            FixLine
        }
    }
    elseif ($ans -eq "Q") { $Filetest = Test-Path -path $Filetmp; if (($Filetest)) { Remove-Item –path $Filetmp }; Clear-Host; Return }
    elseif ($ans -eq "R") { Start-Process "pwsh.exe" -ArgumentList ($Base + "\BinScript.ps1"); exit }
    else {
        FixLine
        [Console]::SetCursorPosition(0, $pp)
        Say -NoNewLine "Sorry, that is not an option. Feel free to try again."
        Start-Sleep -Milliseconds 500
        FixLine
        FlexWindow
        if (($PosTest)) { Put-WinPosition -WinName $host.ui.RawUI.WindowTitle -WinX $POSX -WinY $POSY > $null }
    }
}
$Filetest = Test-Path -path $Filetmp
if (($Filetest)) { Remove-Item -path $Filetmp }
