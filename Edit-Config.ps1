<#
.SYNOPSIS
        Edit-Config
        Created By: Dana Meli
        Created Date: December, 2019
        Last Modified Date: December 28, 2019

.DESCRIPTION
        This script is designed to read and edit json configuration files for all PowerShell scripts.
        Also used as the settings manager for the json configuration files.

.EXAMPLE
        Edit-Config -Confile [string] -Count [string] -Read [string] -Write [string] -Section [string] -SValue [string] -BValue [bool]

.NOTES
        Still under development.

#>
[CmdLetBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Confile,
    [Parameter(Mandatory = $false)]
    [AllowEmptyString()]
    [string]$Count,
    [Parameter(Mandatory = $false)]
    [string]$Read,
    [Parameter(Mandatory = $false)]
    [string]$Write,
    [Parameter(Mandatory = $false)]
    [string]$Section,
    [Parameter(Mandatory = $false)]
    [string]$SValue,
    [Parameter(Mandatory = $false)]
    [bool]$BValue,
    [Parameter(Mandatory = $false)]
    [string]$Sub
)
$FileVersion = "0.0.4"
$Script:ConfigFile = $Confile
try { $Script:Config = Get-Content $Configfile -Raw | ConvertFrom-Json }
catch { Say -ForeGroundColor RED "Edit-Config $FileVersion - The file $Confile is missing!"; break }
if (($Count)) { $Feedback = ($Config.$Count).count }
if (($Read)) {
    if (($Sub)) { $Feedback = ($Config.$Read)[$Section].$Sub }
    else {
        #use [double] for dec nums (1.5)
        if ($section -is [int]) { $Feedback = ($Config.$Read)[$Section] }
        else { $Feedback = ($Config.$Read.$Section) }
    }
}
if (($Write)) {
    if (($SValue)) {
        if (($Sub)) {
            ($Config.$Write)[$Section].$Sub = [string]$SValue
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Read = $Write
            $Feedback = ($Config.$Read)[$Section].$Sub
        }
        else {
            $Config.$Write.$Section = [string]$SValue
            $Config | ConvertTo-Json | Set-Content $ConfigFile
            $Read = $Write
            $Feedback = ($Config.$Read.$Section)
        }
    }
    #
    # WORKING COMMAND FOR FINISH
    # Edit-Config -Conf 'D:\bin\Test.json' -Write AddItems -Section 0 -Sub Command -SValue "C:\Windows\Regedit.exe"
    #
    #if ($true -eq $BValue -or $false -eq $BValue) {
    #if (($Sub)) {
    #    ($Config.$Write)[$Section].$Sub = [bool]$BValue
    #    $Config | ConvertTo-Json | Set-Content $ConfigFile
    #    $Read = $Write
    #    $Feedback = ($Config.$Read)[$Section].$Sub
    #}
    #else {
    #$Config.$Write.$Section = [bool]$BValue
    #$Config | ConvertTo-Json | Set-Content $ConfigFile
    #$Read = $Write
    #$Feedback = ($Config.$Read.$Section)
    #}
    #}
}
return $Feedback
