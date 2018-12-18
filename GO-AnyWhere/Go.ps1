$FileVersion = "Version: 0.1.0"
if ($args) {
    [string]$Catch1 = $args[0]
    [string]$Catch2 = $args[1]
}
if (!($Catch1)) {
    Say "GO $FileVersion"
    Say "Pick One, try again. GO-PLACE or GO PLACE"
    Say "With Repos Use GO-GITHUB REPO or GO LOCAL REPO"
    Get-Files -Folder "$env:BASE\Go-*"
    return
}
if ($Catch1 -eq "..") {
    Say "GO $FileVersion"
    Say "Go $Catch1 Setting you up one Directory"
    Set-Location $Catch1
    return
}
if ($Catch1 -eq "ROOT") {
    $Catch2 = $Catch2 + ":\"
    Say "GO $FileVersion"
    Say "Go $Catch1 : Setting you to Root of $Catch2"
    Set-Location "$Catch2"
    return
}
else {
    $Where = "go-$Catch1"
    $Where = $Where.trim()
    $Where = "$env:BASE\$where.ps1"
    $Filetest = Test-Path -path $where
    if ($Filetest -eq $true) {
        & $where $Catch2
        return
    }
    else { Set-Location $Catch1 }

}
