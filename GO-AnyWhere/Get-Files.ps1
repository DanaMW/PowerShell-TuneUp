<#
.SYNOPSIS
        Get-Files
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: November 12, 2018
.DESCRIPTION
        This returns an output list of given files names in the given folder.
        The list is formatted and sorted.
.EXAMPLE
        Get-Files [-Folder] [<CompletePathToFolder>]\[<File spec like *.exe>]
.NOTES
        Still under development.
#>
param([string]$Folder)
$FileVersion = "Version: 0.1.2"
$ESC = [char]27
if ($Folder -eq "DIR") {
    $Folder = "."
    Write-Host "Get-Files $FileVersion Listing $Folder"
    Write-Host ""
    Get-ChildItem -Path $Folder -Name -Directory | Sort-Object | ForEach-Object {Write-Host $("$ESC[91m[$ESC[97m" + $_ + "$ESC[91m]")}
    Write-Host ""
    return
}
if ($Folder -eq "") { $Folder = "." }
Write-Host "Get-Files $FileVersion Listing $Folder"
Write-Host ""
Get-ChildItem -Path $Folder -Name -Directory | Sort-Object | ForEach-Object {Write-Host $("$ESC[91m[$ESC[97m" + $_ + "$ESC[91m]")}
Get-ChildItem -Path $Folder -Name -File | Sort-Object | ForEach-Object {
    if ($_.substring(0, 1) -eq ".") { Write-Host $("$ESC[92m" + $_) }
    else {Write-Host $("$ESC[96m" + $_)}
}
Write-Host ""
