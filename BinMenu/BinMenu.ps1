Clear-Host
#All the setup stuff
$Base = "C:\bin"
$Fileini = "$Base\" + "BinMenu.ini"
$Filetest = Test-Path -path $Fileini
if ($Filetest -ne $true) {
    Write-Host "The File $Fileini missing Check this out!"
    break
}
#$Filetmp = "$Base\" + "BinMenu.tmp"
#$Filetest = Test-Path -path $Filetmp
#if ($Filetest -eq $true) {
#    Write-Host "Removing File $Filetmp"
#    Remove-Item –path $Filetmp
#}
Set-Location $Base
$ESC = [char]27
$NormalLine = "$ESC[31m#=====================================================================================================#$ESC[97m"
$FancyLine = "$ESC[31m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[97m"
$TitleLine = "$ESC[31m#======================================<$ESC[36m[ $ESC[37mMy Bin Folder Menu $ESC[36m]$ESC[91m>=======================================#$ESC[97m"
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
#Start Reading Row 1
$l = 5
$c = 0
$w = 1
$i = 1
While ($i -le $Row[0]) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m" $moo[1]
    $i++
    $c++
    $c++
    $L++
}
#Start Reading Row 2
$l = 5
$w = $Col[1]
While ($i -le $Row[1]) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m" $moo[1]
    $i++
    $c++
    $c++
    $L++
}
#Start Reading Row 3
$l = 5
$w = $Col[2]
While ($i -le $Row[2]) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[91m[$ESC[97m$i$ESC[91m]$ESC[36m" $moo[1]
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
Write-Host -NoNewLine "                                                                                           "
[Console]::SetCursorPosition(0, $pa)

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
    [Console]::SetCursorPosition(0, $pa)
    Read-Host -Prompt $menuprompt
}

Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "A" {
            [Console]::SetCursorPosition(0, $pa);
            $CMD1 = Read-Host 'Exact Command Line [Enter to cancel]'
            if ($CMD1 -ne '') {
                [Console]::SetCursorPosition(0, $pa);
                $CMD2 = Read-Host 'Run As ADMIN? (Y for Yes anything else for NO)'
                [Console]::SetCursorPosition(0, $pa);
                if ($CMD2 -eq 'Y') { & Start-Process pwsh "$CMD1" -Verb RunAs }
                else { & "$CMD1" }
            }
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)

        }
        "R" {
            Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            return
        }
        "W" {
            Start-Process "pwsh.exe" "c:\bin\BinMenuRW.ps1" -Verb RunAs
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            return
        }
        "C" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs
        }
        "P" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            Start-Process "pwsh.exe" -Verb RunAs
        }
        "Q" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            Return
        }
        "1" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "1B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "2" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "2B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "3" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "3B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "4" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "4B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "5" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "5B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "6" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "6B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "7" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "7B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "8" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "8B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "9" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "9B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "10" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "10B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "11" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "11B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "12" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "12B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "13" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "13B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "14" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "14B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "15" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "15B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "16" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "16B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "17" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "17B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "18" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "18B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "19" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "19B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "20" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "20B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "21" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "21B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "22" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "22B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "23" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "23B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "24" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "24B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "25" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "25B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "26" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "26B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "27" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "27B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "28" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "28B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "29" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "29B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "30" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "30B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "31" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "31B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "32" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "32B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "33" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "33B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "34" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "34B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "35" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "35B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "36" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "36B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "37" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "37B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "38" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "38B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "39" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "39B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        "40" {
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            $Line2 = (Select-String -Pattern "40B" $Fileini)
            $cow = $line2 -split "="
            Start-Process $cow[1] -Verb RunAs
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
        }
        Default {
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "Invalid Choice. Try again."
            Start-Sleep -milliseconds 1500
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
            Write-Host -NoNewLine "                                                                                           "
            [Console]::SetCursorPosition(0, $pa)
        }
    } #switch
} While ($True)

#[ $FileVersion = 0.1.0 ]
