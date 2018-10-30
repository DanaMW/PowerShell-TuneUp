$FileVersion = "Version: 0.0.5"
Write-Host "Go $FileVersion Setting your location to ConEmu"
Set-Location "C:\"
Set-Location "C:\Users\Dana\AppData\GitRepo\ConEmu"
Write-Host ""
Start-Sleep -s 5
Write-Host "git fetch upstream" -Verbose
git fetch upstream
Start-Sleep -s 5
Write-Host "git merge upstream/master" -Verbose
git merge upstream/master
Start-Sleep -s 5
Write-Host "git push origin" -Verbose
git push origin
