<#
.SYNOPSIS
        ImageTo64.ps1
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 12, 2018
.DESCRIPTION
        You feed this an image file and it returns to you Base64 ready to use in a script.
.EXAMPLE
        ImageTo64 -Path [<FullPathToImageFile>] -OutFile [<OptionalFullPathForTextFileOut>]
.NOTES
        Still under development.
#>
Param([String]$path, [String]$OutFile)
[bool]$valid = ($path -ne "")
if ($valid) {
    [String[]]$elements = $path.split(".")
    [int]$max = $elements.Count - 1
    [String]$ext = $elements[$max]
    [String]$uri = "data:image/$($ext);base64,"
    if ($OutFile -eq "") {
        $elements[$max] = "txt"
        [String]$txtPath = $elements -join "."
    }
    else { [String]$txtPath = $OutFile}
    if (!(Test-Path $path)) {
        Say ""
        Say "Unable to find image file: $path"
        break
    }
    $FileVersion = "Version: 0.1.0"
    $host.ui.RawUI.WindowTitle = "ImageTo64 $FileVersion"
    if ((Test-Path $txtPath)) {
        Say ""
        Say "Output file already exists: $txtPath, clearing file"
        Clear-Content $txtPath
    }
    else {
        Say ""
        Say "Creating output file: $txtPath"
    }
}
else { break }
Say "Converting $path"
[String]$base64 = [convert]::ToBase64String((Get-Content $path -AsByteStream))
Say "Writing $txtPath"
Write-Output ($uri + $base64) >> $txtPath
Say "Done"
