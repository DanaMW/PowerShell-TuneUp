Clear-Host
#All the setup stuff
$Base = "C:\bin"
$Fileini = "$Base\" + "BinMenu.ini"
$Filetest = Test-Path -path $Fileini
if ($Filetest -ne $true) {
    Write-Host "The File $Fileini missing Check this out!"
    break
}
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
#Fill in the menu options.
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
$w = 1
[Console]::SetCursorPosition(0, $l)
Write-Host $NormalLine
Write-Host $SpacerLine
Write-Host $SpacerLine
Write-Host $SpacerLine
$l++
[Console]::SetCursorPosition($w, $l)
Write-host -NoNewLine "$ESC[91m[$ESC[97mA$ESC[91m]$ESC[36m" "Run any command directly"
$l++
[Console]::SetCursorPosition($w, $l)
Write-host -NoNewLine "$ESC[91m[$ESC[97mR$ESC[91m]$ESC[36m" "Reload the menu"
$l++
[Console]::SetCursorPosition($w, $l)
Write-host -NoNewLine "$ESC[91m[$ESC[97mQ$ESC[91m]$ESC[36m" "Quit BinMenu"
$l = ($l - 2)
$w = $Col[1]
[Console]::SetCursorPosition($w, $l)
Write-host -NoNewLine "$ESC[91m[$ESC[97mW$ESC[91m]$ESC[36m" "Run the BinRW"
$l++
[Console]::SetCursorPosition($w, $l)
Write-host -NoNewLine "$ESC[91m[$ESC[97mP$ESC[91m]$ESC[36m" "Run a PowerShell Console"
$l++
[Console]::SetCursorPosition($w, $l)
Write-host -NoNewLine "$ESC[91m[$ESC[97mC$ESC[91m]$ESC[36m" "Run VS Code (NewIDE"

#Draw Menu End
[Console]::SetCursorPosition(0, ($pa - 1))
Write-Host $NormalLine
[Console]::SetCursorPosition(0, $pa)
$FixLine

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
    [Console]::SetCursorPosition(0, $pa)
    Write-Host -NoNewLine "                                                                                           "
    [Console]::SetCursorPosition(0, $pa)
}
Function TheCommand {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [string]$Cmd
    )
    Write-Host $_ $CMD
    $Line2 = (Select-String -Pattern "$Cmd" $Fileini)
    $cow = $line2 -split "="
    Start-Process $cow[1] -Verb RunAs
}

Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "A" {
            FixLine
            $CMD1 = Read-Host 'Exact Command Line [Enter to cancel]'
            if ($CMD1 -ne '') {
                FixLine
                $CMD2 = Read-Host 'Run As ADMIN? (Y for Yes anything else for NO)'
                FixLine
                if ($CMD2 -eq 'Y') { & Start-Process pwsh "$CMD1" -Verb RunAs }
                else { & "$CMD1" }
            }
            $FixLine
        }
        "R" { Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; $FixLine ; return }
        "W" { Start-Process "pwsh.exe" "c:\bin\BinMenuRW.ps1" -Verb RunAs; $FixLine; return }
        "C" { $FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs }
        "P" { $FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        "Q" { $FixLine; Return }
        "1" { $FixLine; $Line2 = (Select-String -Pattern "1B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "2" { $FixLine; $Line2 = (Select-String -Pattern "2B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "3" { $FixLine; $Line2 = (Select-String -Pattern "3B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "4" { $FixLine; $Line2 = (Select-String -Pattern "4B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "5" { $FixLine; $Line2 = (Select-String -Pattern "5B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "6" { $FixLine; $Line2 = (Select-String -Pattern "6B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "7" { $FixLine; $Line2 = (Select-String -Pattern "7B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "8" { $FixLine; $Line2 = (Select-String -Pattern "8B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "9" { $FixLine; $Line2 = (Select-String -Pattern "9B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "10" { $FixLine; $Line2 = (Select-String -Pattern "10B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "11" { $FixLine; $Line2 = (Select-String -Pattern "11B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "12" { $FixLine; $Line2 = (Select-String -Pattern "12B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "13" { $FixLine; $Line2 = (Select-String -Pattern "13B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "14" { $FixLine; $Line2 = (Select-String -Pattern "14B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "15" { $FixLine; $Line2 = (Select-String -Pattern "15B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "16" { $FixLine; $Line2 = (Select-String -Pattern "16B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "17" { $FixLine; $Line2 = (Select-String -Pattern "17B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "18" { $FixLine; $Line2 = (Select-String -Pattern "18B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "19" { $FixLine; $Line2 = (Select-String -Pattern "19B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "20" { $FixLine; $Line2 = (Select-String -Pattern "20B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "21" { $FixLine; $Line2 = (Select-String -Pattern "21B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "22" { $FixLine; $Line2 = (Select-String -Pattern "22B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "23" { $FixLine; $Line2 = (Select-String -Pattern "23B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        #"24" { $FixLine; TheCommand -Cmd $_ ; $FixLine }
        "24" { $FixLine; $Line2 = (Select-String -Pattern "24B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "25" { $FixLine; $Line2 = (Select-String -Pattern "25B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "26" { $FixLine; $Line2 = (Select-String -Pattern "26B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "27" { $FixLine; $Line2 = (Select-String -Pattern "27B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "28" { $FixLine; $Line2 = (Select-String -Pattern "28B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "29" { $FixLine; $Line2 = (Select-String -Pattern "29B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "30" { $FixLine; $Line2 = (Select-String -Pattern "30B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "31" { $FixLine; $Line2 = (Select-String -Pattern "31B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "32" { $FixLine; $Line2 = (Select-String -Pattern "32B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "33" { $FixLine; $Line2 = (Select-String -Pattern "33B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "34" { $FixLine; $Line2 = (Select-String -Pattern "34B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "35" { $FixLine; $Line2 = (Select-String -Pattern "35B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "36" { $FixLine; $Line2 = (Select-String -Pattern "36B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "37" { $FixLine; $Line2 = (Select-String -Pattern "37B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "38" { $FixLine; $Line2 = (Select-String -Pattern "38B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "39" { $FixLine; $Line2 = (Select-String -Pattern "39B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        "40" { $FixLine; $Line2 = (Select-String -Pattern "40B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; $FixLine }
        Default {
            $FixLine
            Write-Host -NoNewLine "Invalid Choice. Try again."
            Start-Sleep -milliseconds 1500
            $FixLine
        }
    } #switch
} While ($True)

#[ $FileVersion = 0.1.2 ]
