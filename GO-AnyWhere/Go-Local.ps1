$FileVersion = "Version: 0.0.6"
$WhereTo = $args
$testpath = "D:\Development\GitHub\$Whereto"
$GoodGo = Test-Path -path $testpath
if ($goodgo -eq "$True") {
    Write-Host "Go $FileVersion Setting your location to Local $TestPath Repo"
    Set-Location $testpath[0] + $testpath[1] + $testpath[2]
    Set-Location $testpath
}
else {
    Write-Host "Go $FileVersion Setting your location to Local Only Repo"
    Set-Location "C:\"
    Set-Location "C:\Users\Dana\AppData\GitRepo\"
}
Write-Host "git fetch upstream"
Write-Host "git merge upstream/master"
Write-Host "git push origin"
Write-Host ""
