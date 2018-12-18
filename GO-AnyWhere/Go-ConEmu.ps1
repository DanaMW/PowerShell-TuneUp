$FileVersion = "Version: 0.1.0"
$MyArgs = $args
Say "Go $FileVersion Setting your location to ConEmu"
Say "You Have two (2) ComEnu Repos. One forked on Github ... Opening"
Say "The Do the following [Go-ComEmu VS] to open the Visual Studios repo in a console."
if ($MyArgs -eq "VS") {
    Set-Location "D:\"
    Set-Location "D:\Development\VS"
}
Else {
    Set-Location "D:\"
    Set-Location "D:\Development\GitHub\ConEmu"
    Say ""
    Say "git fetch upstream"
    Say "git merge upstream/master"
    Say "git push origin"
    <#
    Start-Sleep -s 5
    git fetch upstream
    Start-Sleep -s 5
    git merge upstream/master
    Start-Sleep -s 5
    git push origin
    #>
}
