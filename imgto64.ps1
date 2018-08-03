Param([String]$path)

[bool]$valid = ($path -ne "")
if ($valid) {
    [String[]]$elements = $path.split(".")
    [int]$max = $elements.Count -1
    [String]$ext = $elements[$max]
    [String]$uri = "data:image/$($ext);base64,"
    $elements[$max] = "txt"
    [String]$txtPath = $elements -join "."

    if (!(Test-Path $path)) {
        Write-Host ""
        Write-Host "Unable to find image file: $path"
        break
    }

    if ((Test-Path $txtPath)) {
        Write-Host ""
        Write-Host "Output file already exists: $txtPath, clearing file"
        Clear-Content $txtPath
    }
    else {
        Write-Host ""
        Write-Host "Creating output file: $txtPath"
    }
}
else { break }
Write-Host "Converting $path"
[String]$base64 = [convert]::ToBase64String((Get-Content $path -AsByteStream))
Write-Host "Writing $txtPath"
Write-Output ($uri + $base64) >> $txtPath
Write-Host "Done"

#Usage: imgto64 <complete path to file.name>
#[ FileVersion = 0.0.3 ]
