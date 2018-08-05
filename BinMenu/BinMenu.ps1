Clear-Host
#All the setup stuff
$Base = "C:\bin"
$Fileini = "$Base\" + "BinMenu.ini"
$Filetest = Test-Path -path $Fileini
if ($Filetest -ne $true) {
    Write-Host "The File $Fileini missing Check into this!"
    Write-Host "You fix this by running the BinMenuRW.ps1 file creator"
    break
}
$Filetmp = "$Base\" + "BinTemp.del"
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetxt }
Set-Location $Base
$ESC = [char]27
$NormalLine = "$ESC[31m#=====================================================================================================#$ESC[37m"
$FancyLine = "$ESC[31m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[37m"
$TitleLine = "$ESC[31m#======================================<$ESC[36m[ $ESC[37mMy Bin Folder Menu $ESC[36m]$ESC[31m>=======================================#$ESC[37m"
$SpacerLine = "$ESC[31m|                                                                                                     $ESC[31m|$ESC[37m"
$LineCount = 0
try {
    $Reader = New-Object IO.StreamReader $Fileini
    while ($null -ne $Reader.ReadLine()) { $LineCount++ }
}
Finally { $Reader.Close() }
#Setting up positioning
$temp = [int]($LineCount / 2)
$a = [int]($temp / 3 + 1)
$temp = [int]($a)
$b = [int]($temp * 2)
$c = [int]($LineCount - $a - $b)
$c++
$c++
$Row = @($a, $b, $c)
$Col = @(1, 34, 68)
$pa = ($a + 10)
#Draw the menu outline now.
Clear-Host
Write-Host $NormalLine
Write-Host $FancyLine
Write-Host $TitleLine
Write-Host $FancyLine
Write-Host $NormalLine
$i = 1
While ($i -le $a) { Write-Host $SpacerLine; $i++ }
#Fill in the users menu options.
#Start Reading Col 1
$l = 5
$c = 0
$w = 1
$i = 1
While ($i -le $Row[0]) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[31m[$ESC[37m$i$ESC[31m]$ESC[36m" $moo[1]
    $i++
    $c++
    $c++
    $L++
}
#Start Reading Col 2
$l = 5
$w = $Col[1]
While ($i -le $Row[1]) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[31m[$ESC[37m$i$ESC[31m]$ESC[36m" $moo[1]
    $i++
    $c++
    $c++
    $L++
}
#Start Reading Col 3
$l = 5
$w = $Col[2]
While ($i -le $Row[2]) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[31m[$ESC[37m$i$ESC[31m]$ESC[36m" $moo[1]
    $i++
    $c++
    $c++
    $l++
}
#Adding Built in menu
$l++
$l++
#$l = $pa
$w = [int]$Col[0]
[Console]::SetCursorPosition(0, $l)
Write-Host $NormalLine
Write-Host $SpacerLine
Write-Host $SpacerLine
Write-Host $SpacerLine
$d = @("A", "R", "Q", "W", "P", "C")
$f = @("Run any command directly", "Reload BinMenu", "Quit BinMenu", "Run BinMenuRW", "Run a PowerShell console", "Run VS Code (New IDE) ")
$w = [int]$Col[0]
$l++
$c = 0
while ($c -le 5) {
    [Console]::SetCursorPosition($w, $l)
    $tmp = $d[$c]
    Write-host -NoNewLine "$ESC[31m[$ESC[37m$tmp$ESC[31m]$ESC[36m" $f[$c]
    if ($c -eq 2) { $l = [int]($l - 2); $w = [int]$Col[1]; $c++; }
    else { $l++; $c++ }
}
[Console]::SetCursorPosition(0, $l)
$NormalLine
$l++
$FixLine
#Reading In PowerShell Scripts
Get-ChildItem -file $Base -Filter *.ps1| % { [string]$_ -Replace ".ps1", ""} | Sort-Object | Out-File $Filetmp
$w = 0
$i = 1
$c = 0
$doh = 0
$cmd = " - "
$roll = @(Get-Content -Path $Filetmp).Count
$tmp = ($roll / 8)
$i = 1
[Console]::SetCursorPosition($w, $l)
While ($i -le $tmp) { Write-Host $SpacerLine; $i++ }
$i = 1
$w = 1
while ($i -le $roll) {
    $LineR = [string](Get-Content $Filetmp)[$i]
    if ($c -le 6) {
        $UserScripts = [string]($UserScripts + $LineR + $cmd)
        $i++
        $c++
    }
    else {

        $UserScripts = [string]($UserScripts + $LineR)
        $i++
        $c = 0
        [Console]::SetCursorPosition($w, $l)
        Write-host -NoNewLine "$ESC[31m[$ESC[37mScripts$ESC[31m]$ESC[32m" $UserScripts
        $UserScripts = ""
        $doh++
        $l++

    }
}
$w = 0
$pa = ($pa + $doh)
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
#Draw Menu End
[Console]::SetCursorPosition($w, $pa)
Write-Host $NormalLine
$pa = ($pa + 1)
[Console]::SetCursorPosition($w, $pa)
#Now the Menu select functions.
$menu = @"
$ESC[36m[$ESC[31m Make a selection$ESC[36m ]$ESC[37m
"@
Function Invoke-Menu {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $True, HelpMessage = "I have no idea how to help you.")]
        [ValidateNotNullOrEmpty()]
        [string]$Menu,
        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [Alias("cls")]
        [switch]$ClearScreen
    )
    $menuPrompt += $menu
    FixLine
    Read-Host -Prompt $menuprompt
}
Function FixLine {
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa)
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, ($pa + 1))
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, ($pa + 2))
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, ($pa + 3))
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa)
    Write-Host -NoNewLine "                                                                                                       "
    [Console]::SetCursorPosition(0, $pa)
}
FixLine

#Function TheCommand {
#    [Parameter(Mandatory = $False, ParameterSetName = 'IntCom')]
#    [ValidateNotNullOrEmpty()]
#    $IntCom = $_
#    Write-Host $IntCom
#    $TC = (Select-String -Pattern $IntCom $Fileini)
#    $cmd = $TC -split "="
#    Start-Process $cmd[1] -Verb RunAs
#}
#TheCommand

Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "A" {
            FixLine
            $CMD1 = Read-Host "$ESC[31m[$ESC[37mExact Command Line $ESC[31m($ESC[37mEnter to Cancel$ESC[31m)]$ESC[37m"
            if ($CMD1 -ne '') {
                FixLine
                $CMD2 = Read-Host "$ESC[31m[$ESC[37mRun as ADMIN?$ESC[31m][($ESC[37mQ$ESC[31m)$ESC[37muit, $ESC[31m($ESC[37mY$ESC[31m)$ESC[37mes $ESC[31m($ESC[37mN$ESC[31m)$ESC[37mo$ESC[31m]$ESC[37m"
                FixLine
                if ($CMD2 -ne 'Q') {
                    if ($CMD2 -eq 'Y') { & "Start-Process" "$CMD1" "-Verb RunAs" }
                    if ($CMD2 -eq 'N') { & "$CMD" }
                    else { & "$CMD1" }
                }
            }
            FixLine
        }
        "R" { Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "W" { Start-Process "pwsh.exe" "c:\bin\BinMenuRW.ps1" -Verb RunAs; FixLine; return }
        "C" { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        "P" { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        "Q" { Clear-Host; Return }
        "1" { FixLine; $Line2 = (Select-String -Pattern "1B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "2" { FixLine; $Line2 = (Select-String -Pattern "2B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "3" { FixLine; $Line2 = (Select-String -Pattern "3B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "4" { FixLine; $Line2 = (Select-String -Pattern "4B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "5" { FixLine; $Line2 = (Select-String -Pattern "5B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "6" { FixLine; $Line2 = (Select-String -Pattern "6B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "7" { FixLine; $Line2 = (Select-String -Pattern "7B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "8" { FixLine; $Line2 = (Select-String -Pattern "8B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "9" { FixLine; $Line2 = (Select-String -Pattern "9B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "10" { FixLine; $Line2 = (Select-String -Pattern "10B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "11" { FixLine; $Line2 = (Select-String -Pattern "11B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "12" { FixLine; $Line2 = (Select-String -Pattern "12B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "13" { FixLine; $Line2 = (Select-String -Pattern "13B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "14" { FixLine; $Line2 = (Select-String -Pattern "14B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "15" { FixLine; $Line2 = (Select-String -Pattern "15B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "16" { FixLine; $Line2 = (Select-String -Pattern "16B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "17" { FixLine; $Line2 = (Select-String -Pattern "17B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "18" { FixLine; $Line2 = (Select-String -Pattern "18B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "19" { FixLine; $Line2 = (Select-String -Pattern "19B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "20" { FixLine; $Line2 = (Select-String -Pattern "20B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "21" { FixLine; $Line2 = (Select-String -Pattern "21B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "22" { FixLine; $Line2 = (Select-String -Pattern "22B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "23" { FixLine; $Line2 = (Select-String -Pattern "23B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "24" { FixLine; $Line2 = (Select-String -Pattern "24B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "25" { FixLine; $Line2 = (Select-String -Pattern "25B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "26" { FixLine; $Line2 = (Select-String -Pattern "26B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "27" { FixLine; $Line2 = (Select-String -Pattern "27B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "28" { FixLine; $Line2 = (Select-String -Pattern "28B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "29" { FixLine; $Line2 = (Select-String -Pattern "29B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "30" { FixLine; $Line2 = (Select-String -Pattern "30B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "31" { FixLine; $Line2 = (Select-String -Pattern "31B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "32" { FixLine; $Line2 = (Select-String -Pattern "32B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "33" { FixLine; $Line2 = (Select-String -Pattern "33B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "34" { FixLine; $Line2 = (Select-String -Pattern "34B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "35" { FixLine; $Line2 = (Select-String -Pattern "35B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "36" { FixLine; $Line2 = (Select-String -Pattern "36B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "37" { FixLine; $Line2 = (Select-String -Pattern "37B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "38" { FixLine; $Line2 = (Select-String -Pattern "38B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "39" { FixLine; $Line2 = (Select-String -Pattern "39B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "40" { FixLine; $Line2 = (Select-String -Pattern "40B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        Default {
            FixLine
            Write-Host -NoNewLine "Sorry, that is not an option. Feel free to try again." -ForgroundColor yellow
            Start-Sleep -milliseconds 1500
            FixLine
        }
    } #switch
} While ($True)

$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }

#[ $FileVersion = 0.1.6 ]
