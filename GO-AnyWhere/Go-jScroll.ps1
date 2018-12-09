$FileVersion = "Version: 0.0.7"
Write-Host "Go $FileVersion Setting your location to jScrollPane"
Set-Location "D:\"
Set-Location "D:\Development\GitHub\jScrollPane"
Write-Host ""
Write-Host "git fetch upstream"
Write-Host "git merge upstream/master"
Write-Host "git push origin"
Write-Host ""
Write-Host "then:"
Write-Host "npm install"
Write-Host "npm run build"
Write-Host ""
$ans = $null
$ans = Read-Host -Prompt "Do you want to run Git? [Enter is NO (Y)es]"
if ($ans -eq "Y") {
    Write-Host "git fetch upstream" -Verbose
    git fetch upstream
    Start-Sleep -s 2
    Write-Host "git merge upstream/master" -Verbose
    git merge upstream/master
    Start-Sleep -s 2
    Write-Host "git push origin" -Verbose
    git push origin
}
$ans = $null
$ans = Read-Host -Prompt "Do you want to run NPM? [Enter is NO (Y)es]"
if ($ans -eq "Y") {
    Write-Host "npm install" -Verbose
    npm install
    Start-Sleep -s 2
    Write-Host "npm run build" -Verbose
    npm run build
}
