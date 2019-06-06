Param([string]$Prompt, [int]$max, [String]$Default)
$FileVersion = "Version: 0.0.4"
$i = 0
if (!($max)) { $max = 5000 }
if (($Prompt)) { Say -NoNewLine ($Prompt + " ") }
if (($Default)) { $ans = $Default }
while ($i -lt $max) {
    Start-Sleep -MilliSeconds 100
    if ($host.UI.RawUI.KeyAvailable) {
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")
        if ($key.KeyDown -eq 1) {
            $ans = $Key.Character
            $i = $max
        }
    }
    $i = ($i + 100)
    if ($i -ge $max) {
        if (($ans)) { $ans }
        if (!($ans) -and ($Default)) {
            $ans = $Default
            $ans
        }
    }
}
