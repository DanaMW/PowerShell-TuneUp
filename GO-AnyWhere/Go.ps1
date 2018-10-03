$FileVersion = "Version: 0.0.5"
$Catch1 = $args[0]
$Catch2 = $args[1]
if (!($Catch1)) {
    Write-Host "GO $FileVersion"
    Write-Host "Pick One, try again. GO-PLACE or GO PLACE"
    Write-Host "With Repos Use GO-GITHUB REPO or GO LOCAL REPO"
    Get-Files -Folder "C:\bin\Go-*"
    return
}
if ($Catch1 -eq "..") {
    Write-Host "GO $FileVersion"
    Write-Host "Go $Catch : Setting you up one Directory"
    Set-Location $Catch1
    return
}
if ($Catch1 -eq "ROOT") {
    $Catch2 = $Catch2 + ":\"
    Write-Host "GO $FileVersion"
    Write-Host "Go $Catch1 : Setting you to Root of $Catch2"
    Set-Location "$Catch2"
    return
}
else {
    #find the file
    $Where = "go-$Catch1"
    $Where = ($PSScriptRoot + "\" + $where.trim() + ".ps1")
    $Filetest = Test-Path -path $where
    if ($Filetest -eq $true) {
        & $where $Catch2
        return
    }
    else { & Set-Location $Catch1 }

}
