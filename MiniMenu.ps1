$FileVersion = "Version: 0.0.2"
$MenuOptions = @("One", "Two", "Three", "Four");
$MenuRuns = @("RunOne", "RunTwo", "RunThree", "RunFour");
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
#$MenuRuns[$Ans]
# Or use
#& MenuRuns[$Ans]
