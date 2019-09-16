
<#
.SYNOPSIS
        Get-Files
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: September 15, 2019
.DESCRIPTION
        This returns an output list of given files names in the given folder.
        The list is formatted and sorted.
.EXAMPLE
        Get-Files [-Folder] [<CompletePathToFolder>]\[<File spec like *.exe>] /W (wide)
.NOTES
        Still under development.
#>
$Folder = "$args"
$FileVersion = "Version: 0.1.6"
$ESC = [char]27
if ($Folder -match "/W") {
    [bool]$Wide = "True"
    $Folder = $Folder -replace "/W", ""
}
#say "Folder: $Folder"
#Say "Wide: $Wide"
#Read-Host
if ($Folder -eq "DIR") {
    if ($Wide -eq 1) {
        $Folder = "."
        Say "Get-Files" $FileVersion "Listing" $Folder.ToUpper()
        Say ""
        Try {
            Get-ChildItem -Path $Folder -Name -Directory | Sort-Object | ForEach-Object {
                Say -NoNewLine $(" $ESC[91m[$ESC[97m" + $_ + "$ESC[91m] ")
            }
        }
        Catch { Say ""; Say -ForegroundColor RED "Folder" $Folder.ToUpper() "was not found. Maybe add a '*'"; return }
        Finally { Say "" }
        Say ""
        return
    }
    else {
        $Folder = "."
        Say "Get-Files" $FileVersion "Listing" $Folder.ToUpper()
        Say ""
        Try { Get-ChildItem -Path $Folder -Name -Directory | Sort-Object | ForEach-Object { Say $("$ESC[91m[$ESC[97m" + $_ + "$ESC[91m]") } }
        Catch { Say ""; Say -ForegroundColor RED "Folder" $Folder.ToUpper() "was not found. Maybe add a '*'"; return }
        Finally { Say "" }
        Say ""
        return
    }
}
if ($Folder -eq "") { $Folder = "." }
Say "Get-Files" $FileVersion "Listing" $Folder.ToUpper()
if ($Wide -eq 1) {
    $i = 0
    $Stack1 = @()
    try {
        Get-ChildItem -Path $Folder -Name -Directory -ErrorAction Stop | Sort-Object | ForEach-Object {
            $i++; $Stack1 += $("$ESC[91m[$ESC[97m" + $_ + "$ESC[91m]")
            if ($i -eq 5) {
                [int]$move = (43 - $Stack1[0].length); Say -NoNewline ($Stack1[0] + $(" " * $move)); $move = 0
                [int]$move = (43 - $Stack1[1].length); Say -NoNewline ($Stack1[1] + $(" " * $move)); $move = 0
                [int]$move = (43 - $Stack1[2].length); Say -NoNewline ($Stack1[2] + $(" " * $move)); $move = 0
                [int]$move = (43 - $Stack1[3].length); Say -NoNewline ($Stack1[3] + $(" " * $move)); $move = 0
                [int]$move = (43 - $Stack1[4].length); Say ($Stack1[4] + $(" " * $move)); $move = 0
                $i = 0
                $Stack1 = @()
            }
        }
    }
    Catch { Say ""; Say -ForegroundColor RED "Folder" $Folder.ToUpper() "was not found. Maybe add a '*'"; return }
    Finally { Say "" }
    $i = 0
    $Stack2 = @()
    Try {
        Get-ChildItem -Path $Folder -Name -File -ErrorAction Stop | Sort-Object | ForEach-Object {
            if ($_.substring(0, 1) -eq ".") { $i++; $Stack2 += ("$ESC[1;92m" + $_) }
            elseif ($_.split(".")[-1] -eq "TXT") { $i++; $Stack2 += ("$ESC[1;33m" + $_) }
            elseif ($_.split(".")[-1] -eq "INFO") { $i++; $Stack2 += ("$ESC[1;33m" + $_) }
            elseif ($_.split(".")[-1] -eq "CSS") { $i++; $Stack2 += ("$ESC[1;36m" + $_) }
            elseif ($_.split(".")[-1] -eq "PS1") { $i++; $Stack2 += ("$ESC[1;31m" + $_) }
            elseif ($_.split(".")[-1] -eq "MP3") { $i++; $Stack2 += ("$ESC[1;34m" + $_) }
            elseif ($_.split(".")[-1] -eq "EXE") { $i++; $Stack2 += ("$ESC[1;37m" + $_) }
            elseif ($_.split(".")[-1] -eq "JPG") { $i++; $Stack2 += ("$ESC[1;32m" + $_) }
            elseif ($_.split(".")[-1] -eq "PNG") { $i++; $Stack2 += ("$ESC[1;32m" + $_) }
            elseif ($_.split(".")[-1] -eq "ZIP") { $i++; $Stack2 += ("$ESC[1;35m" + $_) }
            else { $i++; $Stack2 += ("$ESC[1;97m" + $_) }
            if ($i -eq 5) {
                [int]$move = (35 - $Stack2[0].length); Say -NoNewline ($Stack2[0] + $(" " * $move)); $move = 0
                [int]$move = (35 - $Stack2[1].length); Say -NoNewline ($Stack2[1] + $(" " * $move)); $move = 0
                [int]$move = (35 - $Stack2[2].length); Say -NoNewline ($Stack2[2] + $(" " * $move)); $move = 0
                [int]$move = (35 - $Stack2[3].length); Say -NoNewline ($Stack2[3] + $(" " * $move)); $move = 0
                [int]$move = (35 - $Stack2[4].length); Say ($Stack2[4] + $(" " * $move)); $move = 0
                $i = 0
                $Stack2 = @()
            }
        }
    }
    Catch { Say ""; Say -ForegroundColor RED "Folder" $Folder.ToUpper() "was not found. Maybe add a '*'"; return }
    Finally { Say "" }
}
else {
    try { Get-ChildItem -Path $Folder -Name -Directory -Hidden -ReadOnly -System -ErrorAction Stop | Sort-Object | ForEach-Object { Say $("$ESC[91m[$ESC[97m" + $_ + "$ESC[91m]") } }
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
}
