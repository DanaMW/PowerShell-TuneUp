<#

#>
$FileVersion = "Version: 0.0.11"
Say -ForegroundColor Gray "Put-Vivaldi $FileVersion"
Say -ForegroundColor Red "#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#"
Say -ForegroundColor Red -NoNewline "|"
Say -ForegroundColor White -NoNewline " Script to copy over your Vivaldi mods "
Say -ForegroundColor Red "|"
Say -ForegroundColor Red "#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#"
Say ""
<# Test and if needed run as admin #>
<#
Function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal] $identity
if (!($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))) {
    Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\Put-Vivaldi.ps1") -Verb RunAs
    return
}
#>
$Success1 = [bool]0
$Success2 = [bool]0
if ($env:HOME -match "C:\\Users\\") {
    $ModFile = "D:\Development\GitHub\DanaMW.github.io\scripts\extra\CustomVivaldi.css"
    if ("C:\Program Files\Vivaldi\Application") {
        $VPath = "C:\Program Files\Vivaldi\Application"
        Say "Discovered Windows ALL Users..."
    }
    elseif ("c:\Program Files\Vivaldi\Application\") {
        #Change the User name to yours please.
        $VPath = "C:\Users\Dana\AppData\Local\vivaldi\Application\"
        Say "Discovered Windows User Dana..."
    }
    Say "Using $VPath to do the deed."
}
elseif ($env:HOME -match "/home/dana" -or $env:HOME -match "/root") {
    $ModFile = "/home/dana/Development/GitHub/DanaMW.github.io/scripts/extra/CustomVivaldi.css"
    $VPath = "/opt/vivaldi-snapshot/resources/vivaldi/"
    Say "Discovered Linux..."
}
else {
    Say "I did not locate any usable Vivaldi application folder."
    return
}
$Edit1 = Get-ChildItem -Path $VPath -filter "browser.html" -recurse -Name -Force
$Edit2 = Get-ChildItem -Path $VPath -filter "common.css" -recurse -Name -Force
if (($edit1)) {
    $Success1 = [bool]1
    Say ($VPAth + "\" + $Edit1)
    $Temp1 = ($VPAth + "\" + $Edit1)
    $TempW1 = ($VPAth + "\" + $Edit1 + ".tmp")
    $i = 0
    $lines = (Get-Content $Temp1).count
    while ($i -le $Lines) {
        [string]$Read = (Get-content $Temp1)[$i]
        if ($null -eq $Read) { $i = $Lines }
        if ($Read -match '<link rel="stylesheet" href="style/CustomVivaldi.css" />') {
            $Success1 = [bool]2
        }
        else {
            if ($Read -match '<link rel="stylesheet" href="style/common.css" />' -and $Success1 -eq 1) {
                Add-Content $TempW1 '    <link rel="stylesheet" href="style/CustomVivaldi.css" />'
            }
        }
        Add-Content $TempW1 $Read
        $i++
    }
    Copy-Item $TempW1 -Destination $Temp1 -Force
    Start-Sleep -S 1
    Remove-Item $TempW1
}
else { Say "Could not find browser.html" }
$Success2 = [bool]0
if (($edit2)) {
    $Success2 = [bool]1
    $Temp2 = ($VPAth + "\" + $Edit2)
    Say $Temp2
    $Copy2 = split-path $temp2 -Parent
    if ($HOME -match 'C:\\Users\\') { $Copy2 = ($Copy2 + "\") }
    if ($env:HOME -match "/home/dana" -or $env:HOME -match "/root") { $Copy2 = ($Copy2 + "/") }
    Say "Copying your ModFile into ViValdi."
    Copy-Item $ModFile -Destination $Copy2 -Force
    $Read2 = (Get-content $Temp2)[0]
    if ($Read2 -ne '@Import url("CustomVivaldi.css");') {
        @('@Import url("CustomVivaldi.css");') + (Get-Content $Temp2) | Set-Content $Temp2
    }
    if ($Read2 -eq '@Import url("CustomVivaldi.css");') {
        $Success2 = [bool]2
    }
}
else { Say "Could not find common.css" }
if ($Success1 -eq 1) { Say "Successfully patched Browser.html." }
elseif ($Success1 -eq 2) { Say "Browser.html is already patched." }
else { Say -ForegroundColor RED  "Failed to patch Browser.html." }
if ($Success2 -eq 1) { Say "Successfully patched common.css." }
elseif ($Success2 -eq 2) { Say "common.css is already patched." }
else { Say -ForegroundColor RED  "Failed to patch common.css." }
if ($Success1 -eq 0 -or $Success2 -eq 0) { Say -ForegroundColor Red "Something failed" }
elseif ($Success1 -eq 1 -and $Success2 -eq 1) { Say "All Done, Completed Both patches and copy." }
elseif ($Success1 -eq 2 -and $Success2 -eq 2) { Say "All Done, Both previously patched." }
else { Say "All Done, Check results." }
