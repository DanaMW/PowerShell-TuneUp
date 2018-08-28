$FileVersion = "Version: 0.1.5"
$host.ui.RawUI.WindowTitle = "Google $FileVersion"
if (!($args)) {
    Write-Host ""
    Write-Host "Nothing entered to search for, your fired."
    Write-Host "Waste of time complete."
    Write-Host "Simply type the search line GOOGLE [<something to search>]"
    Write-Host "-IMAGE -VIDEO -NEWS Can be added to the string."
    Write-Host "As either the very FIRST param or the very LAST"
    Write-Host "GOOGLE -IMAGE [<something to search>] or GOOGLE [<something to search>] -IMAGE"
    Write-Host ""
    return
}
[string]$Search = $args
[string]$Wander = "ALL"
[string]$Key1 = $args[0].trim()
[string]$Key1 = ($Key1).toupper()
[string]$Key2 = $args[-1].trim()
[string]$Key2 = ($Key2).toupper()
if ($Key1 -eq "-IMAGE") { [string]$Wander = "IMAGE" }
if ($Key2 -eq "-IMAGE") { [string]$Wander = "IMAGE" }
if ($Key1 -eq "-VIDEO") { [string]$Wander = "VIDEO" }
if ($Key2 -eq "-VIDEO") { [string]$Wander = "VIDEO" }
if ($Key1 -eq "-NEWS") { [string]$Wander = "NEWS" }
if ($Key2 -eq "-NEWS") { [string]$Wander = "NEWS" }
[string]$Search = $Search -replace "-IMAGE", ""
[string]$Search = $Search -replace "-VIDEO", ""
[string]$Search = $Search -replace "-NEWS", ""
Write-Host "Searching Catagory:" $Wander
Write-Host "Search String:" $Search
[string]$Search = $Search.trim(" ")
[string]$Search = ($Search -Replace "\s+", " ")
[string]$Search = ($Search -replace ' ', '+')
[string]$Search = $Search.trimstart("+")
[string]$Search = $Search.trimend("+")
if ($Wander -eq "IMAGE") {
    [string]$tmp1 = "https://www.google.com/search?q="
    [string]$tmp2 = "$Search"
    [string]$tmp3 = "&source=lnms&tbm=isch"
    [string]$Query = "$tmp1$tmp2$tmp3"
}
if ($Wander -eq "VIDEO") {
    [string]$tmp1 = "https://www.google.com/search?q="
    [string]$tmp2 = "$Search"
    [string]$tmp3 = "&tbm=vid"
    [string]$Query = "$tmp1$tmp2$tmp3"
}
if ($Wander -eq "NEWS") {
    [string]$tmp1 = "https://www.google.com/search?q="
    [string]$tmp2 = "$Search"
    [string]$tmp3 = "&tbm=nws"
    [string]$Query = "$tmp1$tmp2$tmp3"
}
if ($Wander -eq "ALL") {
    [string]$Query = "https://www.google.com/search?q=" + $Search
}
Function DBGoogle {
    Write-Host "Args: " $args
    Write-Host "Search: " $Search
    Write-Host "Wander: " $Wander
    Write-Host "Key1: " $Key1
    Write-Host "Key2: " $Key2
    Write-Host "Wander: " $Wander
    Write-Host "FileVersion: " $FileVersion
    Write-Host "Query: " $Query
    $pop = Read-Host -Prompt "[Enter To Continue]"
    if (!($pop)) { Write-Host "Error"}
}
#DBGoogle
if ($Query) { Start-Process $Query }
