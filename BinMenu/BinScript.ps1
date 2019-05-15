$FileVersion = "Version: 2.1.0"
$host.ui.RawUI.WindowTitle = ("BinMenu Script Window" + $FileVersion)
$Base = $env:Base
if (!($Base)) { Set-Variable -Name Base -Value "D:\bin" -Scope Global }
if (!($Base)) { Say -ForeGroundColor RED "SET BASE environment variable in your Setup, profiles or in this Script. This shit uses that!"; break }
Set-Location $Base.substring(0, 3)
Set-Location $Base
[string]$ScriptName = "BinScript"
if (!($WinWidth)) {
    $WinWidth = 105
    $BuffWidth = $WinWidth
}
if (!($WinHeight)) {
    $WinHeight = 160
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
Clear-Host
[string]$Filetmp = ($Base + "\BinTemp.del")
Set-Location $Base.substring(0, 3)
Set-Location $Base
$ESC = [char]27
FlexWindow
[int]$pp = 0
[int]$LineCount = 0
[int]$LineCount = (Get-Content $Filetmp).count
$Work = $LineCount
$a = ($Work / 3)
$a = [int][Math]::Ceiling($a)
$PMenu = $a
[int]$b = ($a * 2)
[int]$c = ($Work - $b)
$Row = @($a, $b, $c)
$Col = @(1, 34, 69)
[int]$pp = $PMenu
[Console]::SetCursorPosition(0, $pp)
$WinHeight = ($pp + 4)
$BuffHeight = $WinHeight
FlexWindow
[Console]::SetCursorPosition(0, $pp)
Say $NormalLine
[int]$l = 0
[int]$c = 0
[int]$w = $col[0]
[int]$i = 1
[Int]$num = 1
FlexWindow
$Reader = New-Object IO.StreamReader ($filetmp, [Text.Encoding]::UTF8, $true, 4MB)
While ($i -le $Work) {
    $Line = $Reader.ReadLine()
    if (($read.EndOfStream)) { $i = $Work; $Reader.close() }
    [Console]::SetCursorPosition($w, $l); Say -NoNewLine "$ESC[1;91m[$ESC[1;97m$Num$ESC[1;91m]$ESC[1;92m" $Line
    if ($i -eq $Row[0]) { [int]$l = -1; [int]$w = $Col[1] }
    if ($i -eq $Row[1]) { [int]$l = -1; [int]$w = $Col[2] }
    $i++
    $c = ($c + 3)
    $L++
    $num++
}
$Reader.close()
[Console]::SetCursorPosition(0, $pp)
Read-Host
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $True) { Remove-Item –path $Filetmp }
