<#
.SYNOPSIS
        Put-Pause
        Created By: Dana Meli
        Created Date: May, 2019
        Last Modified Date: June 27, 2019

.DESCRIPTION
        This script is designed to replace Read-Host.
        It is similar except it has a definable timeout period.

.EXAMPLE
        Put-Pause -Prompt "Do It? (Y/N):"
        Put-Pause -Prompt "ESC[37mDo It? ESC[31m(ESC[37mYESC[31m/ESC[37mNESC[31m)ESC[37m:"

        Prompt can include ESC which will be replaced with [char]27 so you may include ANSI
        color sequences in the prompt string.

.EXAMPLE
        Put-Pause.ps1 -Default "N"

        Default is the key returned if there is no user input.

.EXAMPLE
        Put-Pause.ps1 -Max 60000

        Max is the timeout of the  prompt in milliseconds.

.EXAMPLE
        $ans = Put-Pause.ps1 -Echo 1

        Echo determines if the output is echoed of not.

.EXAMPLE

        Put-Pause.ps1 -Prompt "Clear Screen? (Y)es,(N)o:" -Max 5000 -Default "N" -Echo 0

.NOTES
        Still under development.

#>
Param([string]$Prompt, [int]$Max, [String]$Default, [bool]$Echo)
$FileVersion = "Version: 0.1.0"
$i = 0
$ESC = [char]27
$ans = ""
### ESC is replaced with char27 for color codes ###
if (!($max)) { $max = 5000 }
if (($Prompt)) {
    $Prompt = $Prompt.Replace("ESC", $ESC)
    Write-Host -NoNewLine ($Prompt + " ")
}
if (($Default)) { $ans = $Default }
while ($i -lt $max) {
    Start-Sleep -MilliSeconds 100
    if ($host.UI.RawUI.KeyAvailable) {
        $key = $host.UI.RawUI.ReadKey("NoEcho, IncludeKeyUp, IncludeKeyDown")
        if ($key.KeyDown -eq 1) {
            $ans = $Key.Character
            $i = $max
        }
    }
    $i = ($i + 100)
    if ($i -ge $max) {
        if (($ans)) {
            if (($Echo)) { Write-Host $ans }
            Return $ans
        }
        if (!($ans) -and ($Default)) {
            $ans = $Default
            if (($Echo)) { Write-Host $ans }
            Return $ans
        }
    }
}
