<#
.SYNOPSIS
        Get-Firefox
        Created By: Dana Meli
        Created Date: September, 2018
        Last Modified Date: September 01, 2018
.DESCRIPTION
        This script is designed To run Firefox either normally or by selecting a profile.
        It is designed to use an ini file created by it's companion script BinMenuRW.ps1.
.EXAMPLE
        Get-Firefox -Profile 1
        This will bring up a list of profiles that you can select from.
.EXAMPLE
        Get-Firefox
        Run without params starts FireFox normally.
.NOTES
        Still under development.
#>
Param([bool]$Profile)
$FileVersion = "Version: 0.0.2"
if (!($Profile)) {
    & "C:\Program Files\Firefox Developer Edition\Firefox.exe"
}
[int]$c = (Get-ChildItem -Path "C:\Users\Dana\AppData\Roaming\Mozilla\Firefox\Profiles").count
$Profs = (Get-ChildItem -Path "C:\Users\Dana\AppData\Roaming\Mozilla\Firefox\Profiles").name
$Profs = $Profs -split " "
$i = 0
while ($i -lt $c) {
    Write-Host "[$i]" $Profs[$i]
    $i++
}
$Pop = Read-Host -Prompt "[Pick A Profile Number]"
if (($pop)) { & "C:\Program Files\Firefox Developer Edition\Firefox.exe -P $Profs[$pop]" }
else { & "C:\Program Files\Firefox Developer Edition\Firefox.exe -P" }
