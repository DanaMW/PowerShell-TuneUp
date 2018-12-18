$FileVersion = "Version: 0.1.0"
if ($args) {
    [string]$Catch = $args[0]
    $Where = "go-$Catch"
    $Where = $Where.trim()
    $Where = "$env:BASE\$where.ps1"
    $Filetest = Test-Path -path $where
    if ($Filetest -eq $true) {
        & $where
        return
    }
}
else {
    Say "Go $FileVersion Setting your location to Local Github Repo"
    Set-Location "D:\"
    Set-Location "D:\Development\GitHub\"
}
Say "git fetch upstream"
Say "git merge upstream/master"
Say "git push origin"
Say ""
