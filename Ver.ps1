<#
.SYNOPSIS
    Ver
    Created By: Dana Meli
    Created Date: December, 2019
    Last Modified Date: March 18, 2021

.DESCRIPTION
    My idea of a Windows version script.

.EXAMPLE
    VER

.NOTES
    Still under development.

#>
$FileVersion = "0.2.1"
Clear-Host
if ($env:HOME -match "C:\\Users\\") {
    Say "Detected Windows. Processing..."
    Start-Sleep -S 1
    Clear-Host
    $VarFile = ($env:BASE + "\ver.tmp")
    $Filetest = Test-Path -Path $VarFile
    if ($Filetest -eq $True) { Remove-Item –Path $VarFile }
    [Console]::SetCursorPosition(0, 0)
    Say ""
    Say -ForegroundColor white "My Version Information $FileVersion"
    Say -ForegroundColor red "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
    Get-SmallVer;
    $computerOS = (Get-CimInstance CIM_OperatingSystem)
    $TC1 = ($computerOS.caption)
    $TC2 = ($computerOS.version)
    WC "~darkcyan~[~~darkyellow~$TC1 $TC2~~darkcyan~]~"
    [Console]::SetCursorPosition(0, 5)
    systeminfo /fo csv | ConvertFrom-Csv | Select-Object OS*, System*, Hotfix* | Format-List | Out-File $VarFile
    (Get-Content $VarFile) | Where-Object { $_.trim() -ne "" } | Set-Content $VarFile
    $lines = (Get-Content $VarFile).count
    $i = 0
    $j = 1
    $p = 5
    While ($j -le $lines) {
        $read = (Get-Content $VarFile)[$i]
        if ($read -eq "") { break }
        [Console]::SetCursorPosition(0, $p); Say -ForegroundColor darkcyan $read
        $i++; $j++; $p++
    }
    $Filetest = Test-Path -Path $VarFile
    if ($Filetest -eq $True) { Remove-Item –Path $VarFile }
    return
}
else {
    Say "Did not detect Windows. Working on the linux version right this second. Exiting"
    return
}
