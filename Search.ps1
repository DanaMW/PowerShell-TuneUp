param([string]$sname, [string]$sdrive)
$FileVersion = "0.1.6"
if (!($sname)) {
    Say "Search $FileVersion"
    Say "Remember this can be done SEARCH <FileName> <SearchFolder>"
    Say ""
    $ans = $null
    $ans = Read-Host -Prompt "Enter JUST the file name to search for. [Enter will exit]"
    if ($ans) { $sname = $ans }
    else { return }
}
if (!($sdrive)) {
    Say "Search $FileVersion"
    Say "Remember this can be done SEARCH -SNAME <FileName> -SDRIVE <SearchFolder>"
    Say ""
    $ans = $null
    $ans = Read-Host -Prompt "Enter the Drive-Directory-Path to search in. [Enter will exit]"
    if ($ans) { $sdrive = $ans }
    else { return }
}
$sdrive = $sdrive.replace("*", "")
#$sname = $sname.replace("*", "")
$sname = $sname.TrimStart("*")
$sname = $sname.TrimEnd("*")
$Filetmp = $sdrive
$Filetest = Test-Path -path $Filetmp
if ($Filetest -ne $true) {
    Say ""
    Say -ForeGroundColor RED "Search is not able to find the folder" $sdrive.ToUpper()
    Say ""
    Return
}
if ($sdrive[-1..-1] -ne "\") { $sdrive = $sdrive + "\" }
Say ""
Say "Searching for" $sname.ToUpper() "in" $sdrive.ToUpper()
Say ""
$sw = [Diagnostics.Stopwatch]::StartNew()
$i = 0
Get-ChildItem -Path $sdrive  -filter "*${sname}*" -recurse -Name -Force | foreach-object {
    $i++
    #$sname = $sname.replace("*", " ")
    Say -NoNewLine -ForeGroundColor WHITE ((Split-Path -Parent $_) + "\")
    $Workit = (Split-Path -Leaf $_)
    if ($Workit -match "-") { $sname = $sname.replace("*", "-") }
    elseif ($Workit -match "_") { $sname = $sname.replace("*", "_") }
    elseif ($Workit -match ".") { $sname = $sname.replace("*", ".") }
    elseif ($Workit -match " ") { $sname = $sname.replace("*", " ") }
    Say -NoNewLine -ForeGroundColor YELLOW ($Workit -Split $sname)[0]
    Say -NoNewLine -ForeGroundColor RED $sname.ToUpper()
    Say -ForeGroundColor YELLOW ($Workit -Split $sname)[1]
}
$sw.Stop()
Say ""
Say "Search found $i matches"
Say "Search took" $sw.Elapsed
Say ""
