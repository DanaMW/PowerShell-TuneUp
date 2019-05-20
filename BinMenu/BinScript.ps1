$FileVersion = "Version: 2.1.3"
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
[string]$ScriptName = "BinScript"
$menu = "$ESC[1;91m[$ESC[1;97mMake A Selection$ESC[1;91m]$ESC[1;97m"
$menuPrompt += $menu
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
While (1) {
    Clear-Host
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
    $ans = Read-Host -Prompt $menuprompt
    [Int32]$OutNumber = $null
    if ([Int32]::TryParse($ans, [ref]$OutNumber)) {
        FixLine
        $MaxYes = (Get-Content $Filetmp).count
        #$MaxYes = ($MaxYes / 3)
        #$MaxYes = [int][Math]::Ceiling($MaxYes)
        if ($OutNumber -gt 0 -and $OutNumber -le $MaxYes) {
            $OutNumber = ($OutNumber - 1)
            $Read = (Get-Content $Filetmp)[$OutNumber]
            $cmd1 = $Read
            $cmd2 = Read-Host "Enter Params For This Script"
            FixLine
            Start-Process pwsh.exe -ArgumentList $cmd1$cmd2 -Verb RunAs
            FixLine
        }
    }
    elseif ($ans -eq "Q") { $Filetest = Test-Path -path $Filetmp; if ($Filetest -eq $True) { Remove-Item –path $Filetmp }; Clear-Host; Return }
    else {
        FixLine
        [Console]::SetCursorPosition(0, $pp)
        Say -NoNewLine "Sorry, that is not an option. Feel free to try again."
        Start-Sleep -Milliseconds 500
        FixLine
        FlexWindow
    }
}
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $True) { Remove-Item -path $Filetmp }
