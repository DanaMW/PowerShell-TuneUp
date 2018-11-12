$FileVersion = "Version: 0.0.6"
Write-Host "Go $FileVersion Setting your location to Stylus"
Set-Location "D:\"
Set-Location "D:\Development\GitHub\stylus"
Write-Host ""
Write-Host ""
Write-Host "delete the last two closing curly brackets and add:"
Write-Host '},'
Write-Host '"applications": {'
Write-Host '    "gecko": {'
Write-Host '        "id": " {7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}"'
Write-Host '    }'
Write-Host '  }'
Write-Host '}'
Write-Host ""
Write-Host ""
Write-Host "git fetch upstream"
Write-Host "git merge upstream/master"
Write-Host "git push origin"
Write-Host ""
Write-Host "then:"
Write-Host "npm install"
Write-Host "npm run update"
Write-Host "npm run zip"
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
