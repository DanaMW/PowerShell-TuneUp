$FileVersion = "Version: 0.1.2"
if ($args) {
    if ($null -ne $args[0]) { $filename = $args[0] }
    if ($null -ne $args[1]) { $SDrive = $args[1] }
}
if (!($filename)) {
    Say "Search $FileVersion"
    Say "Remember this can be done SEARCH <FileName> <SearchFolder>"
    Say ""
    $ans = $null
    $ans = Read-Host -Prompt "Enter JUST the file name to search for. [Enter will exit]"
    if ($ans) { $filename = ($ans -replace "*", "")  }
    else { return }
}
if (!($SDrive)) {
    $ans = $null
    $ans = Read-Host -Prompt "Enter the Drive-Directry-Path to search in. [Enter will exit]"
    if ($ans) { $SDrive = $ans }
    else { return }
}
$Filetmp = $SDrive
$Filetest = Test-Path -path $Filetmp
if ($Filetest -ne $true) {
    Say ""
    Say -ForeGroundColor RED "Search is not able to find the folder" $SDrive.ToUpper()
    Say ""
    Return
}
if ($SDrive[-1..-1] -ne "\") { $SDrive = $SDrive + "\" }
Say ""
Say "Searching for" $filename.ToUpper() "in" $SDrive.ToUpper()
Say ""
$i = 0
Get-ChildItem -Path $SDrive -recurse -filter "*${filename}*" -Name -Force | foreach-object {
    $i++
    Say -NoNewLine -ForeGroundColor WHITE ((Split-Path -Parent $_) + "\")
    $Workit = (Split-Path -Leaf $_)
    Say -NoNewLine -ForeGroundColor YELLOW ($Workit -Split $filename)[0]
    Say -NoNewLine -ForeGroundColor RED $filename.ToUpper()
    Say -ForeGroundColor YELLOW ($Workit -Split $filename)[1]
}
Say ""
Say "Search found $i matches"
Say ""
