$FileVersion = "0.0.3"
$MenuOptions = @("PowerShell Core", "Total Commander", "VS Code", "MusicBee");
$MenuRuns = @("$env:ShellSpec", "tc.ps1", "Code.exe", "D:\bin\Musicbee\MusicBee.exe");
[int]$Count = $MenuOptions.count
$Count--
[int]$i = 0
while ($i -le $Count) {
    Say [$i] $MenuOptions[$i]
    $i++
}
$Ans = read-Host -Prompt "Select a Menu Option or (Q)uit"
if ($Ans -eq "Q" -or $Ans -eq "") { break }
Say $MenuRuns[$Ans]
# Use
# $MenuRuns[$Ans]
# Or use
try {
    & $MenuRuns[$Ans]
}
catch { break }
break
