<#
.SYNOPSIS
        Put-Pause
        Created By: Dana Meli-Wischman
        Created Date: May, 2019
        Last Modified Date: March 28, 2020

.DESCRIPTION
        This script is designed to replace Read-Host.
        It is similar except it has a definable timeout period and can define color prompts.

.EXAMPLE
        Color prompts are usable if you also have the function WCP {} in your profile.
        Put-Pause.ps1 -Prompt "~white~Clear the Screen?~ ~cyan~(~~white~Y~~cyan~/~~white~N~~cyan~)~~white~:~ " -Default "Y"

.EXAMPLE
        Put-Pause.ps1 -Default "N"

        -Default is the key returned if there is no user input.
        -Default is $Null if you use -Echo 0

.EXAMPLE
        Put-Pause.ps1 -Max 60000

        -Max is the timeout of the wait in milliseconds.
        -Max defaults to 5000 if blank

.EXAMPLE
        Put-Pause.ps1 -Max 0

        If -Max is 0 (zero) it sets -Echo 1 and
        waits for a keypress with NO timeout.
        -Default has no effect.

.EXAMPLE
        $ans = Put-Pause.ps1 -Echo 1

        -Echo determines if the output is echoed to the screen (1) or not (0).
        -Echo is automatically set to 1 if you use -Max 0

.EXAMPLE

        Put-Pause.ps1 -Prompt "Clear Screen? (Y)es,(N)o:" -Max 5000 -Default "N" -Echo 0
        $ans = Put-Pause.ps1 -Prompt "Clear Screen? (Y)es,(N)o:" -Max 5000 -Default "N" -Echo 0

.NOTES
        Still under development.

#>
Param([string]$Prompt, [int]$Max, [String]$Default, [bool]$Echo)
$FileVersion = "0.2.3"
$PKB = ""
if (!$PSBoundParameters.ContainsKey('Max')) { [int]$Max = 5000 }
else {
    if ($Max -le 0) { [int]$Max = 0 }
    if ($Max -eq 0) {
        [int]$Max = 0
        [bool]$Echo = 1
        [int]$i = -1
    }
}
if ((!$i)) { [int]$i = 0 }
if (($Prompt)) {
    if ($Prompt -match "~") { WCP $Prompt }
    else { Write-Host -NoNewLine $Prompt }
}
$Host.UI.RawUI.FlushInputBuffer()
while ($i -lt $max) {
    if ($Max -eq 0) { $i = -1 }
    else { Start-Sleep -MilliSeconds 100 }
    if ($host.UI.RawUI.KeyAvailable) {
        $key = $host.UI.RawUI.ReadKey("NoEcho, IncludeKeyUp, IncludeKeyDown")
        if ($key.KeyDown -eq 1) {
            $PKB = $Key.Character
            $i = $max
        }
    }
    if ($Max -gt 0) { $i = ($i + 100) }
    if ($i -ge $max) {
        if (($PKB)) {
            #if (($Echo)) { Write-Host $PKB }
            if (($Echo)) { Write-Host "$PKB".ToUpper() }
            Return $PKB
        }
        if (!($PKB)) {
            if (($Default)) { $PKB = $Default }
            #if (($Echo)) { Write-Host $PKB }
            if (($Echo)) { Write-Host "$PKB".ToUpper() }
            Return $PKB
        }
    }
}
