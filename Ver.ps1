$FileVersion = "Version: 0.1.7"
Clear-Host
if ($env:HOME -match "C:\\Users\\") {
    Say "Detected Windows Processing"
    Start-Sleep -S 1
    Clear-Host
    $VarFile = ($env:BASE + "\ver.tmp")
    $Filetest = Test-Path -path $VarFile
    if ($Filetest -eq $True) { Remove-Item –path $VarFile }
    [Console]::SetCursorPosition(0, 0)
    Say ""
    Say -ForegroundColor white "My Version Information $FileVersion"
    Say -ForegroundColor red "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
    Get-SmallVer;
    $computerOS = (Get-CimInstance CIM_OperatingSystem)
    Say ($computerOS.caption) ($computerOS.version)
    [Console]::SetCursorPosition(0, 5)
    systeminfo /fo csv | ConvertFrom-Csv | Select-Object OS*, System*, Hotfix* | Format-List | Out-File $VarFile
    (Get-Content $VarFile) | Where-Object { $_.trim() -ne "" } | set-content $VarFile
    $lines = (Get-content $VarFile).count
    $i = 0
    $j = 1
    $p = 5
    While ($j -le $lines) {
        $read = (Get-Content $VarFile)[$i]
        if ($read -eq "") { break }
        [Console]::SetCursorPosition(0, $p); Say -ForegroundColor darkcyan $read
        $i++; $j++; $p++
    }
    # [Console]::SetCursorPosition(0, 4); Say -ForegroundColor red "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"; [Console]::SetCursorPosition(0, 19);
    $Filetest = Test-Path -path $VarFile
    if ($Filetest -eq $True) { Remove-Item –path $VarFile }
    return
}
else {
    Say "Detected NOT windows, not going to run here yet sorry, Exiting"
    return
}
