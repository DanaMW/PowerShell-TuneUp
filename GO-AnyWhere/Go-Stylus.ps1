$FileVersion = "Version: 0.1.0"
Say "Go $FileVersion Setting your location to Github\Stylus"
Set-Location "D:\"
Set-Location "D:\Development\GitHub\stylus"
Say ""
Say "git fetch upstream"
Say "git merge upstream/master"
Say "git push origin"
Say ""
Say "then:"
Say "npm install"
Say "npm run update"
Say "npm run zip"
Say ""
$ans = $null
$ans = Read-Host -Prompt "Do you want to run Git? [Enter is NO (Y)es]"
if ($ans -eq "Y") {
    Say "git fetch upstream" -Verbose
    git fetch upstream
    Start-Sleep -s 2
    Say "git merge upstream/master" -Verbose
    git merge upstream/master
    Start-Sleep -s 2
    Say "git push origin" -Verbose
    git push origin
}
$ans = $null
$ans = Read-Host -Prompt "Do you want to run NPM? [Enter is NO (Y)es]"
if ($ans -eq "Y") {
    Say "npm install" -Verbose
    npm install
    Start-Sleep -s 2
    Say "npm run update" -Verbose
    npm run update
    Start-Sleep -s 2
    Say "npm run zip" -Verbose
    npm run zip
}
