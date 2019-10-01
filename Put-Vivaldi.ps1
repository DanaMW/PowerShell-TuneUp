<#

#>
$FileVersion = "Version: 0.0.6"
Say -ForegroundColor Gray "Put-Vivaldi" $FileVersion
Say -ForegroundColor Red "#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#"
Say -ForegroundColor Red -NoNewline "|"
Say -ForegroundColor White -NoNewline " Script to copy over your Vivaldi mods "
Say -ForegroundColor Red "|"
Say -ForegroundColor Red "#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#"
Say ""
$Success1 = [bool]0
$Success2 = [bool]0
$ModFile = "D:\Development\GitHub\DanaMW.github.io\scripts\extra\CustomVivaldi.css"
$VPath = "C:\Users\Dana\AppData\Local\Vivaldi\Application\"
$Edit1 = Get-ChildItem -Path $VPath -filter "browser.html" -recurse -Name -Force
$Edit2 = Get-ChildItem -Path $VPath -filter "common.css" -recurse -Name -Force
if (($edit1)) {
    $Success1 = [bool]1
    Say ($VPAth + $Edit1)
    $Temp1 = ($VPAth + $Edit1)
    $TempW1 = ($VPAth + $Edit1 + ".tmp")
    $i = 0
    $lines = (Get-Content $Temp1).count
    while ($i -le $Lines) {
        [string]$Read = (Get-content $Temp1)[$i]
        if ($null -eq $Read) { $i = $Lines }
        if ($Read -match '    <link rel="stylesheet" href="style/CustomVivaldi.css" />') {
            Say "Browser.html is already patched."
            $Success1 = [bool]0
        }
        else {
            if ($Read -match '<link rel="stylesheet" href="style/common.css" />' -and ($Success1)) {
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
    Say ($VPAth + $Edit2)
    $Temp2 = ($VPAth + $Edit2)
    $Copy2 = split-path $temp2 -Parent
    $Copy2 = ($Copy2 + "\")
    Copy-Item $ModFile -Destination $Copy2 -Force
    $Read2 = (Get-content $Temp2)[0]
    if ($Read2 -ne '@Import url("CustomVivaldi.css");') {
        @('@Import url("CustomVivaldi.css");') + (Get-Content $Temp2) | Set-Content $Temp2
    }
    if ($Read2 -eq '@Import url("CustomVivaldi.css");') {
        Say "Common.css is already patched."
        $Success2 = [bool]0
    }
}
else { Say "Could not find common.css" }
if (($Success1)) { Say "Successfully patched Browser.html" }
else { Say -ForegroundColor RED  "Failed to patch Browser.html" }
if (($Success2)) { Say "Successfully patched common.css" }
else { Say -ForegroundColor RED  "Failed to patch common.css" }
if (($Success1) -and ($Success2)) { Say "All Done, Completed Both patches" }
else { Say -ForegroundColor Red "Something failed" }
