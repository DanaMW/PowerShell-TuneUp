<#
.SYNOPSIS
        BinMenu
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 24, 2018
.DESCRIPTION
        This script is designed to create a menu of all exe files in subfolders off a set base.
        It is designed to use an ini file created by it's companion script BinMenuRW.ps1.
.EXAMPLE
        BinMenu.ps1 -Base [<PathToAFolder>]
.NOTES
        Still under development.
#>
param([string]$Base)
$FileVersion = "0.5.5"
Function Get-ScriptDir {
    Split-Path -parent $PSCommandPath
}
<# #[Set-ConWin]#[Window Resizer]# #>
$tmpHeight = 37
$tmpWidth = 104
if ($tmpWidth -eq "") { $tmpWidth = 107 }
if ($tmpHeight -eq "") { $tmpHeight = 45 }
$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.buffersize
$newsize.height = 2000
$tmp = ($tmpWidth * 2)
$newsize.width = $tmp
$pswindow.buffersize = $newsize
$newsize = $pswindow.windowsize
$newsize.height = $tmpHeight
$newsize.width = $tmpWidth
$pswindow.windowsize = $newsize
Clear-Host
<# Set The BASE folder here or the script will use current by default #>
$Base = "C:\bin"
if ($Base -eq "") { $Base = Get-ScriptDir }
$tmp = $base.lenght
if ($($base.substring($tmp)) -ne "\") { $base = $base + "\" }
$Fileini = "$Base" + "BinMenu.ini"
$Filetmp = "$Base" + "\BinTemp.del"
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
Set-Location $Base
<# Toggle this to $False if you DONT want to read in ps1 scripts, $True is you do. #>
$IAmWho = $env:USERDOMAIN
$Editor = "C:\Bin\NPP\NotePad++.exe"
$ScriptRead = $True
$ESC = [char]27
$host.ui.RawUI.WindowTitle = "BinMenu v.$FileVersion on $IAmWho"
$Filetest = Test-Path -path $Fileini
if ($Filetest -ne $true) {
    Write-Host "The File $Fileini is missing. Can not continue without it."
    Write-Host "We are going to run the INI creator function now"
    Read-Host -Prompt "[Enter to continue]"
    $NoINI = $true
    My-Maker
}
Clear-Host
$NormalLine = "$ESC[31m#=====================================================================================================#$ESC[97m"
$FancyLine = "$ESC[31m|$ESC[97m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[97m"
$TitleLine = "$ESC[31m#======================================<$ESC[96m[$ESC[41m $ESC[97mMy Bin Folder Menu $ESC[40m$ESC[96m]$ESC[31m>=======================================#$ESC[97m"
$SpacerLine = "$ESC[31m|                                                                                                     $ESC[31m|$ESC[97m"
$ProgramLine = "$ESC[31m#$ESC[96m[$ESC[33mProgram Menu$ESC[96m]$ESC[31m=======================================================================================#$ESC[97m"
$Menu1Line = "$ESC[31m#$ESC[96m[$ESC[33mBuilt-in Menu$ESC[96m]$ESC[31m======================================================================================#$ESC[97m"
$ScriptLine = "$ESC[31m#$ESC[96m[$ESC[33mScripts List$ESC[96m]$ESC[31m=======================================================================================#$ESC[97m"
$LineCount = 0
try {
    $Reader = New-Object IO.StreamReader $Fileini
    while ($null -ne $Reader.ReadLine()) { $LineCount++ }
}
Finally { $Reader.Close() }
<# Setting up positioning #>
$temp = [int]($LineCount / 2)
$a = ($temp / 3)
$a = [int][Math]::Ceiling($a)
$temp = [int]($a)
$b = [int]($temp * 2)
$c = [int]($LineCount / 2)
$Row = @($a, $b, $c)
$Col = @(1, 34, 68)
$pa = ($a + 5)
Write-host "Linecount" $linecount
Write-host "A" $a
Write-host "Temp" $temp
Write-host "B" $b
Write-host "C" $c
Write-host "Row" $row
<# Draw the menu outline now. #>
Clear-Host
Write-Host $NormalLine
Write-Host $FancyLine
Write-Host $TitleLine
Write-Host $FancyLine
Write-Host $ProgramLine
$i = 1
While ($i -le $a) { Write-Host $SpacerLine; $i++ }
<# Fill in the users menu options from file. #>
$l = 5
$c = 0
$w = 1
$i = 1
$work = [int]($linecount / 2)
While ($i -le $work) {
    $Line = (Get-Content $Fileini)[$c]
    $moo = $line -split "="
    [Console]::SetCursorPosition($w, $l)
    Write-host -NoNewLine "$ESC[31m[$ESC[97m$i$ESC[31m]$ESC[96m" $moo[1]
    if ($i -eq $Row[0]) {$l = [int]4; $w = [int]$Col[1]  }
    if ($i -eq $Row[1]) {$l = [int]4; $w = [int]$Col[2]  }
    $i++
    $c++
    $c++
    $L++
}
<# Adding Built in menu options #>
[Console]::SetCursorPosition(0, $pa)
Write-Host $Menu1Line
Write-Host $SpacerLine
Write-Host $SpacerLine
Write-Host $SpacerLine
if ($ScriptRead -eq $true) { Write-Host $ScriptLine }
else { Write-Host $NormalLine }
$pa = $($pa + 5)
[Console]::SetCursorPosition(0, $pa)
$l = $($pa - 4)
$d = @("A", "B", "C", "D", "E", "F", "G", "H", "Q")
$f = @("Run an EXE directly", "Reload BinMenu", "Run INI Maker", "Run a PowerShell console", "Edit BinMenu.ini", "Run VS Code (New IDE)", "Run a PS1 script", "System Information", "Quit BinMenu")
$w = [int]$Col[0]
$c = 0
while ($c -le 8) {
    [Console]::SetCursorPosition($w, $l)
    $tmp = $d[$c]
    Write-host -NoNewLine "$ESC[31m[$ESC[97m$tmp$ESC[31m]$ESC[95m" $f[$c]
    if ($c -eq 2) { $l = [int]($l - 3); $w = [int]$Col[1] }
    if ($c -eq 5) { $l = [int]($l - 3); $w = [int]$Col[2] }
    $l++
    $c++
}
[Console]::SetCursorPosition(0, $pa)
<# Reading In PowerShell Scripts IF $ScriptRead is $true #>
if ($scriptRead -eq $true) {
    $cmd1 = "$ESC[92m[$ESC[97m"
    $cmd3 = "$ESC[92m]"
    Get-ChildItem -file $Base -Filter *.ps1| ForEach-Object { [string]$_ -Replace ".ps1", ""} | Sort-Object | ForEach-Object { ($cmd1 + $_ + $cmd3) } |  Out-File $Filetmp
    $roll = @(Get-Content -Path $Filetmp).Count
    $tmp = ($roll / 8)
    $tmp = [int][Math]::Ceiling($tmp)
    $w = 0
    $l = $pa
    $i = 1
    [Console]::SetCursorPosition($w, $l)
    While ($i -le $tmp) { Write-Host $SpacerLine; $i++ }
    $pa = ($pa + $tmp)
    $i = 0
    $w = 1
    $c = 0
    $t = 1
    [Console]::SetCursorPosition($w, $pa)
    while ($i -lt $roll) {
        while ($t -le $tmp) {
            $t++
            $c = 1
            $UserScripts = ""
            while ($c -le 8) {
                $LineR = [string](Get-Content $Filetmp)[$i]
                $i++
                $UserScripts = ($UserScripts + $LineR)
                $c++
            }
            [Console]::SetCursorPosition($w, $l)
            Write-host -NoNewLine "$ESC[31m[$ESC[92mPS1$ESC[31m]$ESC[92m" $UserScripts
            $l++
        }
    }
}
<# Here i do the cleanup and reorder math #>
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
$w = 0
<# Then we draw the last line on the Menu id $ScriptRead is $True #>
if ($ScriptRead -eq $true) {
    [Console]::SetCursorPosition(0, $pa)
    Write-Host $NormalLine
    $pa++
}
$FixLine
<# All done fucking around now we just line up the tasks and work #>
<# Now we do the Menu trigger, sorta functions and all the triggers #>
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
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
<# Here We do the Administrator overlay #>
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    [Console]::SetCursorPosition(78, 1)
    Write-host -NoNewLine "$ESC[96m[$ESC[33mAdministrator$ESC[96m]$ESC[31m"
    [Console]::SetCursorPosition(0, $pa)
}
<# Version Add Area #>
$FV = ("Version: " + $FileVersion)
[Console]::SetCursorPosition(10, 1)
Write-host -NoNewLine "$ESC[96m[$ESC[33m$FV$ESC[36m]$ESC[31m"
[Console]::SetCursorPosition(0, $pa)
Fixline
$menu = "$ESC[31m[$ESC[97mMake A Selection$ESC[31m]$ESC[97m"
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
Function MyMaker {
    Clear-Host
    <# Setting up INI File.#>
    $Filetest = Test-Path -path $FileINI
    if ($Filetest -eq $true) { Remove-Item –path $FileINI }
    $FileTXT = ("$Base" + "BinMenu.txt")
    $Filetest = Test-Path -path $FileTXT
    if ($Filetest -eq $true) { Remove-Item –path $FileTXT }
    $FileCSv = ("$Base" + "BinMenu.csv")
    $Filetest = Test-Path -path $FileCSV
    if ($Filetest -eq $true) { Remove-Item –path $FileCSV }
    <# Reads in all valid (runable exe ) entries from your base folder. #>
    Write-host $fileVersion "Reading in directory" $Base
    Get-ChildItem -Path "$Base" -Recurse -Include *.exe | Select-Object `
    @{ n = 'Foldername'; e = { ($_.PSPath -split '[\\]')[3] } } ,
    Name,
    FullName ` | Export-Csv -path $FileTXT -NoTypeInformation
    Write-host "Writing raw files info, Reread and sorting file names, Exporting all file names"
    Import-Csv -Path $FileTXT | Sort-Object -Property "Foldername" | Export-Csv -NoTypeInformation $FileCSV
    $writer = [System.IO.file]::CreateText($FileINI)
    $i = 1
    try {
        Import-Csv $Filecsv | Foreach-Object {
            $tmpname = [Regex]::Escape($_.fullname)
            if ($tmpname -match "git" -and $tmpname -ne "c:\\bin\\git\\bin\\bash\.exe") { return }
            if ($tmpname -match "wscc" -and $tmpname -ne "C:\\bin\\wscc\\wscc\.exe") { return }
            $tmpname = $_.name -replace "\\", ""
            if ($tmpname -eq "Totalcmd64.exe") { $tmpname = "Total Commander.exe" }
            $NameFix = $tmpname
            $NameFix = $NameFix.tolower()
            $NameFix = $NameFix.substring(0, 1).toupper() + $NameFix.substring(1)
            $Decidep = "Add to BinMenu [" + $_.fullname + "][" + $NameFix + "(Y N)[Enter is No]"
            $Decide = Read-Host -Prompt $Decidep
            if ($Decide -eq "Y") {
                $NameFix = $NameFix.replace(".exe", "")
                Write-Host "Adding to Menu: " $NameFix
                $Writer.WriteLine("[" + $i + "A]=" + $NameFix)
                $Writer.WriteLine("[" + $i + "B]=" + $_.fullname)
                $i++
                return
            }
            else { return }
        }
    }
    finally { $writer.close() }
    Write-Host "Done Writing EXE files to the Menu ini."
    Write-Host ""
    $Filetest = Test-Path -path $FileTXT
    if ($Filetest -eq $true) { Remove-Item –path $FileTXT }
    $Filetest = Test-Path -path $FileCSV
    if ($Filetest -eq $true) { Remove-Item –path $FileCSV }
}
if ($NoINI) {
    $NoINI = $false
    MyMaker
}
Function MySysInf {
    $FileVersion = "0.1.6"
    $ESC = [char]27
    $nline = "$ESC[31m#=====================================================================#$ESC[37m"
    $dline = "$ESC[31m| $ESC[37m| $ESC[31m#=============================================================$ESC[31m# $ESC[37m| $ESC[31m|"
    $fline = "$ESC[31m| $ESC[37m#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-# $ESC[31m| $ESC[37m"
    $tline = "$ESC[31m| $ESC[37m#=-=-=-=-=-=-=-=-=-=-=-<$ESC[36m[$ESC[37mSystem Information$ESC[36m]$ESC[31m$ESC[37m>=-=-=-=-=-=-=-=-=-=-=#$ESC[31m |$ESC[37m"
    $sline = "$ESC[31m| $ESC[37m| $ESC[31m|                                                             $ESC[31m| $ESC[37m|$ESC[31m |$ESC[37m"
    $host.ui.RawUI.WindowTitle = "System Information Version " + $FileVersion
    <# #[Set-ConWin]#[Window Resizer]# #>
    $tmpHeight = "46"
    $tmpWidth = "72"
    if ($tmpWidth -eq "") { $tmpWidth = "107" }
    if ($tmpHeight -eq "") { $tmpHeight = "45" }
    $pshost = (get-host)
    $pswindow = ($pshost.ui.rawui)
    $newsize = ($pswindow.buffersize)
    $newsize.height = "2000"
    $tmp = ($tmpWidth * 2)
    $newsize.width = "$tmp"
    $pswindow.buffersize = ($newsize)
    $newsize = ($pswindow.windowsize)
    $newsize.height = ($tmpHeight)
    $newsize.width = ($tmpWidth)
    $pswindow.windowsize = ($newsize)
    $Base = "C:\bin\"
    Get-CimInstance Win32_OperatingSystem | Format-List
    Clear-Host
    $computerSystem = (Get-CimInstance CIM_ComputerSystem)
    $computerBIOS = (Get-CimInstance CIM_BIOSElement)
    $computerOS = (Get-CimInstance CIM_OperatingSystem)
    $computerCPU = (Get-CimInstance CIM_Processor)
    $computerHDD1 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'")
    $computerHDD2 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'D:'")
    $Net1 = $(Get-NetAdapter)[0] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
    $Net2 = $(Get-NetAdapter)[1] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
    $Net3 = $(Get-NetAdapter)[2] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
    $Net4 = $(Get-NetAdapter)[3] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
    $tt = "$ESC[31m[$ESC[37m"
    $Con11 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net1.name)
    $Con12 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($net1.InterfaceDescription)
    if ($net1.Status -eq "Not Present") { $N1tmp = "Disabled"}
    else { $N1tmp = ($net1.Status) }
    $Con13 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N1tmp)
    $Con14 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net1.LinkSpeed)
    $Con21 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net2.name)
    $Con22 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($net2.InterfaceDescription)
    if ($net2.Status -eq "Not Present") { $N2tmp = "Disabled"}
    else { $N2tmp = ($net2.Status) }
    $Con23 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N2tmp)
    $Con24 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net2.LinkSpeed)
    $Con31 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net3.name)
    $Con32 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($net3.InterfaceDescription)
    if ($net3.Status -eq "Not Present") { $N3tmp = "Disabled"}
    else { $N3tmp = ($net3.Status) }
    $Con33 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N3tmp)
    $Con34 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net3.LinkSpeed)
    $Con41 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($net4.name)
    $Con42 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net4.InterfaceDescription)
    if ($net4.Status -eq "Not Present") { $N4tmp = "Disabled"}
    else { $N4tmp = ($net4.Status) }
    $Con43 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N4tmp)
    $Con44 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net4.LinkSpeed)
    $inf0 = "$tt" + "System Information for$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Name
    $inf1 = "$tt" + "Manufacturer$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Manufacturer
    $inf2 = "$tt" + "Model$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Model
    $inf3 = "$tt" + "Serial Number$ESC[31m]$ESC[37m: $ESC[36m" + $computerBIOS.SerialNumber
    $inf4 = "$tt" + "CPU$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.Name
    $inf5 = "$tt" + "CPU$ESC[31m][$ESC[37mClock Speed$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.maxClockSpeed + "$ESC[37mMHz"
    $inf6 = "$tt" + "CPU$ESC[31m][$ESC[37mCores$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.numberOfCores
    $inf7 = "$tt" + "CPU$ESC[31m][$ESC[37mLogical Processors$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.NumberOfLogicalProcessors
    $inf8 = "$tt" + "CPU$ESC[31m][$ESC[37mDescription$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.description
    $inf9 = "$tt" + "CPU$ESC[31m][$ESC[37mSocket$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.socketDesignation
    $inf10 = "$tt" + "CPU$ESC[31m][$ESC[37mStatus$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.status
    $inf11 = "$tt" + "CPU$ESC[31m][$ESC[37mManufacturer$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.manufacturer
    $inf12 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.Size / 1GB) + "$ESC[37mGB"
    $inf13 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD1.FreeSpace / $computerHDD1.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.FreeSpace / 1GB) + "$ESC[37mGB"
    $inf14 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.Size / 1GB) + "$ESC[37mGB"
    $inf15 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD2.FreeSpace / $computerHDD2.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.FreeSpace / 1GB) + "$ESC[37mGB"
    $inf16 = "$tt" + "System RAM.$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory / 1GB) + "$ESC[37mGB"
    $inf17 = "$tt" + "OS$ESC[31m][$ESC[37mSystem.$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.caption)
    $inf18 = "$tt" + "OS$ESC[31m][$ESC[37mVersion$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.Version)
    $inf19 = "$tt" + "User logged$ESC[31m]$ESC[37m: $ESC[36m" + ($computerSystem.UserName)
    $inf20 = "$tt" + "Last Reboot$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.LastBootUpTime)
    Write-Host $nline
    $tline
    $dline
    $i = 0
    while ($i -le 36) { Write-Host $sline ; $i++ }
    $dline
    $fline
    $nline
    $l = 3
    $n = 00
    while ($l -lt 24) {
        [Console]::SetCursorPosition(6, $l)
        $tmp = '$' + 'inf' + "$n"
        Write-Host -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
        $n++
        $l++
    }
    $p = 1
    $c = 1
    $n = 00
    while ($l -lt 50) {
        [Console]::SetCursorPosition(6, $l)
        $tmp = '$' + 'Con' + "$p" + "$c"
        Write-Host -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
        $c++
        $n++
        $l++
        if ($c -eq 5) { $c = 1; $p++ }
    }
    [Console]::SetCursorPosition(0, 0)
    Write-Host -NoNewLine $nline
    [Console]::SetCursorPosition(0, 43)
    $pop = Read-Host -Prompt "$ESC[31m[$ESC[37mEnter To Continue$ESC[31m]$ESC[37m"
}
Function TheCommand {
    Param([string]$IntCom)
    if ($IntCom -eq "") {
        Write-Error "Error In Sent Param " + $IntCom
        Write-Error $_
        return
    }
    $moo = (Select-String -Pattern $IntCom $Fileini)
    $cow = $moo -split "="
    Start-Process $cow[1] -Verb RunAs
}
Do {
    #Switch
    Switch (Invoke-Menu -menu $menu -clear) {
        "A" { FixLine; Start-Process $editor -ArgumentList $FileINI -Verb RunAs; FixLine }
        "B" { Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "C" { FixLine; MyMaker; Clear-Host; Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs; Clear-Host; return }
        "D" { FixLine; Start-Process "pwsh.exe" -Verb RunAs }
        "E" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mExact Command Line $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                if ($cmd -match "ps1") {
                    FixLine
                    $temp = $cmd -split ' '
                    $cmd = $cmd.trimstart($temp[0])
                    $cmd1 = $temp[0] -replace '.ps1', ''
                    $tmp = ".ps1"
                    $cmd1 = $($cmd1 + $tmp)
                    Start-Process "pwsh.exe" -Argumentlist "$cmd1 $cmd" -Verb RunAs
                    FixLine
                }
                else { Start-Process "$cmd" -Verb RunAs }
                FixLine
            }
            FixLine
        }
        "F" { FixLine; Start-Process "C:\Program Files\Microsoft VS Code\Code.exe" -Verb RunAs; FixLine }
        "G" {
            FixLine
            $cmd = Read-Host -Prompt "$ESC[31m[$ESC[97mWhat script to run? $ESC[31m($ESC[97mEnter to Cancel$ESC[31m)]$ESC[97m"
            if ($cmd -ne '') {
                FixLine
                $temp = $cmd -split ' '
                $cmd = $cmd.trimstart($temp[0])
                $cmd1 = $temp[0] -replace '.ps1', ''
                $tmp = ".ps1"
                $cmd1 = $($cmd1 + $tmp)
                Start-Process "pwsh.exe" -Argumentlist "$cmd1 $cmd" -Verb RunAs
                FixLine
            }
            FixLine
        }
        "H" {
            FixLine
            MySysInf
            Clear-Host
            Start-Process "pwsh.exe" "c:\bin\BinMenu.ps1" -Verb RunAs
            Clear-Host
            return
        }
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
        "41" { FixLine; $Line2 = (Select-String -Pattern "41B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "42" { FixLine; $Line2 = (Select-String -Pattern "42B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "43" { FixLine; $Line2 = (Select-String -Pattern "43B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "44" { FixLine; $Line2 = (Select-String -Pattern "44B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "45" { FixLine; $Line2 = (Select-String -Pattern "45B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "46" { FixLine; $Line2 = (Select-String -Pattern "46B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "47" { FixLine; $Line2 = (Select-String -Pattern "47B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "48" { FixLine; $Line2 = (Select-String -Pattern "48B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "49" { FixLine; $Line2 = (Select-String -Pattern "49B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        "50" { FixLine; $Line2 = (Select-String -Pattern "50B" $Fileini); $cow = $line2 -split "="; Start-Process $cow[1] -Verb RunAs; FixLine }
        Default {
            FixLine
            Write-Host -NoNewLine "Sorry, that is not an option. Feel free to try again."
            Start-Sleep -milliseconds 1500
            FixLine
        }
    } #switch
} While ($True)
$Filetest = Test-Path -path $Filetmp
if ($Filetest -eq $true) { Remove-Item –path $Filetmp }
