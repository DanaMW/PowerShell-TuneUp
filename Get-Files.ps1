<#
.SYNOPSIS
        Get-Files
        Created By: Dana Meli-Wischman
        Created Date: August, 2018
        Last Modified Date: September 22, 2021
.DESCRIPTION
        This returns an output list of given files names in the given folder.
        The list is formatted and sorted.
.EXAMPLE
        Get-Files [-Folder] [<CompletePathToFolder>]\[<File spec like *.exe>]
.NOTES
        Still under development.
#>
$Folder = "$args"
$FileVersion = "0.2.0"
$ESC = [char]27
if ($Folder -eq "DIR") {
    $Folder = "."
    Say "Get-Files $FileVersion Listing $Folder.ToUpper()"
    Say ""
    Try { Get-ChildItem -Path $Folder -Name -Directory | Sort-Object | ForEach-Object { Say $("$ESC[91m[$ESC[97m" + $_ + "$ESC[91m]") } }
    Catch { Say ""; Say -ForegroundColor RED "Folder" $Folder.ToUpper() "was not found. Maybe add a '*'"; return }
    Finally { Say "" }
    Say ""
    return
}
if ($Folder -eq "") { $Folder = "." }
Say "Get-Files $FileVersion Listing" $Folder.ToUpper()
try { Get-ChildItem -Path $Folder -Name -Directory -ErrorAction Stop | Sort-Object | ForEach-Object { Say $("$ESC[91m[$ESC[97m" + $_ + "$ESC[91m]") } }
Catch { Say ""; Say -ForegroundColor RED "Folder" $Folder.ToUpper() "was not found. Maybe add a '*'"; return }
Finally { Say "" }
Try {
    Get-ChildItem -Path $Folder -Name -File -ErrorAction Stop | Sort-Object | ForEach-Object {
        if ($_.substring(0, 1) -eq ".") { Say $("$ESC[92m" + $_) }
        elseif ($_.split(".")[-1] -eq "TXT") { Say -ForeGroundColor Yellow $_ }
        elseif ($_.split(".")[-1] -eq "INFO") { Say -ForeGroundColor Yellow $_ }
        elseif ($_.split(".")[-1] -eq "CSS") { Say -ForeGroundColor Cyan $_ }
        elseif ($_.split(".")[-1] -eq "PS1") { Say -ForeGroundColor RED $_ }
        elseif ($_.split(".")[-1] -eq "MP3") { Say -ForeGroundColor BLUE $_ }
        elseif ($_.split(".")[-1] -eq "EXE") { Say -ForeGroundColor WHITE $_ }
        elseif ($_.split(".")[-1] -eq "JPG") { Say -ForeGroundColor Green $_ }
        elseif ($_.split(".")[-1] -eq "PNG") { Say -ForeGroundColor Green $_ }
        elseif ($_.split(".")[-1] -eq "ZIP") { Say -ForeGroundColor Magenta $_ }
        else { Say $("$ESC[96m" + $_) }
    }
}
Catch { Say ""; Say -ForegroundColor RED "Folder" $Folder.ToUpper() "was not found. Maybe add a '*'"; return }
Finally { Say "" }
