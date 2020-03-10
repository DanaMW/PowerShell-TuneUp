$FileVersion = "Version: 0.0.2"
$MenuOptions = @("PowerShell Core", "Total Commander", "VS Code", "MusicBee");
$MenuRuns = @("$env:ShellSpec", "tc.ps1", "Code.exe", "D:\bin\Musicbee\MusicBee.exe");
[int]$Count = $MenuOptions.count
$Count--
[int]$i = 0
while ($i -le $Count) {
    Say [$i] $MenuOptions[$i]
    $i++
}
$Ans = read-Host -Prompt "Menu Option, (Q)uit"
if ($Ans -eq "Q" -or $Ans -eq "") { break }
Say $MenuRuns[$Ans]
# Use
# $MenuRuns[$Ans]
# Or use
& $MenuRuns[$Ans]
