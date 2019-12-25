<#
.SYNOPSIS
        Edit-Config
        Created By: Dana Meli
        Created Date: December, 2019
        Last Modified Date: December 25, 2019

.DESCRIPTION
        This script is designed to read and edit json configuration files for all PowerShell scripts.
        Also used as the settings manager for the json configuration files.

.EXAMPLE
        Edit-Config -Confile [string] -Read [string] -Write [string] -Section [string] -SValue [string] -BValue [bool]

.NOTES
        Still under development.

#>
param([string]$Confile, [string]$Read, [string]$Write, [string]$Section, [string]$SValue, [bool]$BValue)
$FileVersion = "Version: 0.0.2"
$Script:ConfigFile = $Confile
try { $Script:Config = Get-Content $Configfile -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "Edit-Config $FileVersion - The file $Confile is missing!"; break }
if (($Read)) { $Feedback = ($Config.$Read.$Section) }
if (($Write)) {
    if (($SValue)) {
        $Config.$Write.$Section = [string]$SValue
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Read = $Write
        $Feedback = ($Config.$Read.$Section)
    }
    if ($true -eq $BValue -or $false -eq $BValue) {
        $Config.$Write.$Section = [bool]$BValue
        $Config | ConvertTo-Json | Set-Content $ConfigFile
        $Read = $Write
        $Feedback = ($Config.$Read.$Section)
    }
}
return $Feedback
