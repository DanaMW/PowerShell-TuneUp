$FileVersion = "Version: 0.1.0"
$WhereTo = $args
$testpath = "D:\Development\GitHub\$Whereto"
$GoodGo = Test-Path -path $testpath
if ($goodgo -eq "$True") {
    Say "Go $FileVersion Setting your location to Local $TestPath Repo"
    Set-Location $testpath[0] + $testpath[1] + $testpath[2]
    Set-Location $testpath
}
else {
    Say "Go $FileVersion Setting your location to Local Only Repo"
    Set-Location "C:\"
    Set-Location "C:\Users\Dana\AppData\GitRepo\"
}
Say "git fetch upstream"
Say "git merge upstream/master"
Say "git push origin"
Say ""
