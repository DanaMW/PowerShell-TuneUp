<#
.SYNOPSIS
        Delay-StartUp
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 29, 2018
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
$FileVersion = "Version: 0.2.0"
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
[int]$tc = ($Config.RunItems.count)
[bool]$DBug = ($Config.basic.DBug)
Function DBFiles {
    Write-Host "Config: " $Config
    Write-Host "ConfigFile: " $ConfigFile
    Write-Host "StartDelay: " $StartDelay
    Write-Host "Delay: " $Delay
    Write-Host "Prevent: " $Prevent
    Write-Host "Base: " $Base
    Write-Host "TC: " $tc
    Write-Host "DBug: " $DBug
    Write-Host "Example: " ($Config.RunItems[0].name)
    Write-Host "Example: " ($Config.RunItems[0].runpath)
    Write-Host "Example: " ($Config.RunItems[0].Argument)
    Write-Host "Example: " ($Config.RunItems[0].HostOnly)
    Read-host -prompt "[Enter To Continue]"
}
if ($DBug -eq "$True") { DBFiles }
if ($Prevent -eq "$True") {
    Write-Host ""
    Write-Host "The script setting PREVENT is set to $Prevent."
    Write-Host "This indicates we need to exit."
    Write-Host "Set PREVENT to 0 to allow this to run."
    Read-Host -Prompt "[Enter to Continue to exit]"
    Write-Host ""
    break
}
if ($StartDelay -ne 0) {
    & Write-Output "Holding startup for $StartDelay seconds per your setting."
    Start-Sleep -s $StartDelay
}
& Write-Output ""
& Write-Output "#==================================#"
& Write-Output "|-<Running Delay-Startup Launcher>-|"
& Write-Output "#==================================#"

[int]$c = 0
[int]$a = 1
while ($c -lt $tc) {
    $Runname = ($Config.RunItems[$c].name)
    $RunHost = ($Config.RunItems[$c].hostonly)
    $RunPath = ($Config.RunItems[$c].runpath)
    $RunSplit = (Split-Path -parent $Config.RunItems[$c].runpath) + "\"
    $RunArg = ($Config.RunItems[$c].argument)
    #$Wonder = Get-Process $RunName -ErrorAction SilentlyContinue
    #if (($Wonder)) { [bool]$Know = $True }
    #else { [bool]$Know = $False }
    if (!($RunHost) -or $RunHost -eq $env:USERDOMAIN) {
        if ($c -ne 0) { Start-Sleep -s $Delay }
        & Write-Output " [$a] Starting $RunName"
        & Set-Location $RunSplit
        #if ($know = "$False") {
        if (($RunArg)) { & Start-Process -FilePath $RunPath -ArgumentList $RunArg }
        else { & Start-Process -FilePath $RunPath }
        #}
        & Set-Location $Base
        $a++
    }
    $c++
}
Write-Host "All Programs Loaded, Exiting"
Start-Sleep -s $Delay
Exit
return
