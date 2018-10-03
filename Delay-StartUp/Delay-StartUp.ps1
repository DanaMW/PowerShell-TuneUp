<#
.SYNOPSIS
        Delay-StartUp
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: October 02, 2018
.DESCRIPTION
        This is just a way to delay the startup of programs in your startups.
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script c:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
        Command Line: pwsh.exe -File C:\bin\Delay-StartUp.ps1
.EXAMPLE
        You look up your startups in the task manager and as you add them here you disable them there.
        You would place a shortcut for this script in c:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
        Command Line: pwsh.exe -File C:\bin\Delay-StartUp.ps1
.NOTES
        Still under development.
#>
$FileVersion = "Version: 1.0.3"
$host.ui.RawUI.WindowTitle = "Delay-StartUp $FileVersion on $env:USERDOMAIN"
Function MyConfig {
    $MyConfig = (Split-Path -parent $PSCommandPath) + "\" + (Split-Path -leaf $PSCommandPath)
    $MyConfig = ($MyConfig -replace ".ps1", ".json")
    $MyConfig
}
$ConfigFile = MyConfig
try {
    $Config = Get-Content "$ConfigFile" -Raw | ConvertFrom-Json
}
catch {
    Write-Error -Message "The Base configuration file is missing!" -Stop
}
if (!($Config)) {
    Write-Error -Message "The Base configuration file is missing!" -Stop
}
[int]$StartDelay = ($Config.basic.StartDelay)
[int]$Delay = ($Config.basic.Delay)
[bool]$Prevent = ($Config.basic.Prevent)
[string]$Base = ($Config.basic.Base)
if ($base.substring(($Base.length - 1)) -ne "\") { [string]$base = $base + "\" }
[bool]$DBug = ($Config.basic.DBug)
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
}
Function DBFiles {
    Write-Host "Config: " $Config
    Write-Host "ConfigFile: " $ConfigFile
    Write-Host "StartDelay: " $StartDelay
    Write-Host "Delay: " $Delay
    Write-Host "Prevent: " $Prevent
    Write-Host "Base: " $Base
    Write-Host "AddCount: " $AddCount
    Write-Host "DBug: " $DBug
    $RunItem = "RunItem-1"
    Write-Host "Example: " ($Config.$RunItem).name
    Write-Host "Example: " ($Config.$RunItem).runpath
    Write-Host "Example: " ($Config.$RunItem).Argument
    Write-Host "Example: " ($Config.$RunItem).HostOnly
    Read-host -prompt "[Enter To Continue]"
}
if ($DBug -eq "$True") { DBFiles }
if ($Prevent -eq "$True") {
    Clear-Host
    Write-Host ""
    Write-Host "The script setting PREVENT is set to $Prevent."
    Write-Host "This indicates we need to exit."
    Write-Host "Set PREVENT to 0 to allow this to run."
    Read-Host -Prompt "[Enter to Continue to exit]"
    Write-Host ""
    break
}
if ($StartDelay -ne "0") {
    Clear-Host
    [Console]::SetCursorPosition(0, 1); & Write-OutPut "You have StartDelay Set."
    [Console]::SetCursorPosition(0, 2); & Write-Output "Holding startup for $StartDelay"
    [int]$c = $StartDelay
    while ($c -gt 0) {
        #[Console]::SetCursorPosition(0, 3); & Write-Output "                                               "
        #[Console]::SetCursorPosition(0, 4); & Write-Output "                                               "
        [Console]::SetCursorPosition(20, 2); & Write-Output "      "
        [Console]::SetCursorPosition(20, 2); & Write-Output $c
        Start-Sleep -s 1
        $c = ($c - 1)
        [Console]::SetCursorPosition(0, 5); & Write-Output "                                               "
    }
}
[Console]::SetCursorPosition(20, 2); & Write-Output "      "
[Console]::SetCursorPosition(20, 2); & Write-Output "Done!"
#[Console]::SetCursorPosition(0, 6); & Write-Output ""
[Console]::SetCursorPosition(0, 3); & Write-Output "#==================================#"
[Console]::SetCursorPosition(0, 4); & Write-Output "|-<Running Delay-Startup Launcher>-|"
[Console]::SetCursorPosition(0, 5); & Write-Output "#==================================#"
#[Console]::SetCursorPosition(0, 9)
[int]$c = 1
[int]$a = 1
$tt = SpinItems
[Console]::SetCursorPosition(0, 6)
while ($c -lt $AddCount) {
    $RunItem = "RunItem-$c"
    $Runname = ($Config.$RunItem).name
    $RunHost = ($Config.$RunItem).hostonly
    $RunPath = ($Config.$RunItem).runpath
    $RunSplit = (Split-Path -parent $RunPath)
    $RunSplit = ($RunSplit + "\")
    $RunArg = ($Config.$RunItem).argument
    if ($RunHost -eq "ALL" -or $RunHost -eq $env:USERDOMAIN) {
        & Write-Output " [$a] Starting $RunName [$RunHost]"
        & Set-Location $RunSplit
        if (($RunArg)) { & Start-Process -FilePath $RunPath -ArgumentList $RunArg }
        else { & Start-Process -FilePath $RunPath }
        & Set-Location $Base
        if ($c -ne 0) { Start-Sleep -s $Delay }
        $a++
    }
    $c++
}
if ($tt -ne "") { $tt = "" }
Write-Host "All Programs Loaded, Exiting."
Start-Sleep -s 3
Exit
