<#
.SYNOPSIS
        Convert-Script
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: September 02, 2018
.DESCRIPTION
        This script places quotes on each side of a css file for use in tampermonkey.
        Along with a couple other things required to make it work.
.EXAMPLE
        Script-Convert -File [<complete path to a css file>] -OutFile {<File to write>}
.NOTES
        You will need to edit The header, and remove a bracket in quotes at the bottom.
        If you dont specify a outfile it creates it next to the original.
#>
param([string]$File, [string]$OutFile)
$FileVersion = "Version: 0.1.5"
if ($File -eq "") {
    Say ""
    Say "You fucked up and didnt include -File [<FileToRead>]"
    Say "Take your hand off your dick, try again and type right."
    return
}
else {
    $InFile = $File
    $Filetest = Test-Path -path $InFile
    if ($Filetest -ne $true) {
        Say ""
        Say "You fucked up, The file you specified $InFile is not there."
        Say "Put the drugs down and try again."
        return
    }
}
if ($OutFile -eq "") {
    $tmp1 = $(Get-Item $File ).DirectoryName
    $tmp2 = $(Get-Item $File ).Basename
    $OutFile = "$tmp1" + "\" + "$tmp2"
    $OutFile = $OutFile -Replace ".user", ""
    $OutFile = "$OutFile" + ".user.js"
}
$Filetest = Test-Path -path $OutFile
if ($Filetest -eq $true) { Remove-Item -th $OutFile }
Say "Convert-Script $FileVersion is begining"
Say "Reading File: $File and Writing File: $OutFile"
$HU0 = [string]"// "
$HU1 = [string]"// ==UserScript=="
$HU2 = Get-ChildItem $File | Get-Content | Select-String -pattern "@name"
$HU3 = Get-ChildItem $File | Get-Content | Select-String -pattern "@namespace"
$HU4 = Get-ChildItem $File | Get-Content | Select-String -pattern "@Version"
$HU5 = Get-ChildItem $File | Get-Content | Select-String -pattern "@description"
$HU6 = Get-ChildItem $File | Get-Content | Select-String -pattern "@author"
$HU7 = [string]"// ==/UserScript=="
$HU2 = [string]$($HU2 -replace "\* @", "@")
$HU3 = [string]$($HU3 -replace "\* @", "@")
$HU4 = [string]$($HU4 -replace "\* @", "@")
$HU3 = [string]$($HU5 -replace "\* @", "@")
$HU6 = [string]$($HU6 -replace "\* @", "@")
$HU2 = [string]$($HU0 + $HU2)
$HU3 = [string]$($HU0 + $HU3)
$HU4 = [string]$($HU0 + $HU4)
$HU5 = [string]$($HU0 + $HU5)
$HU6 = [string]$($HU0 + $HU6)
<# Upper String #>
$HU8 = [string]"(function() {var css = '';"
$HU9 = [string]"css += ["
<# Lower String #>
$HU10 = [string]"].join('\n');"
$HU11 = [string]"if (typeof GM_addStyle != 'undefined') {"
$HU12 = [string]"    GM_addStyle(css);"
$HU13 = [string]"}"
$HU14 = [string]"else if (typeof PRO_addStyle != 'undefined') {"
$HU15 = [string]"PRO_addStyle(css);"
$HU16 = [string]"}"
$HU17 = [string]"else if (typeof addStyle != 'undefined') {"
$HU18 = [string]"    addStyle(css);"
$HU19 = [string]"}"
$HU20 = [string]"else {"
$HU21 = [string]"     var node = document.createElement('style');"
$HU22 = [string]"    node.type = 'text/css';"
$HU23 = [string]"    node.appendChild(document.createTextNode(css));"
$HU24 = [string]"    var heads = document.getElementsByTagName('head');"
$HU25 = [string]"    if (heads.length > 0) {"
$HU26 = [string]"        heads[0].appendChild(node);"
$HU27 = [string]"    }"
$HU28 = [string]"    else {"
$HU29 = [string]"        // no head yet, stick it whereever"
$HU30 = [string]"      document.documentElement.appendChild(node);"
$HU31 = [string]"     }"
$HU32 = [string]"}"
$HU33 = [string]"})();"
[int]$Lines = 0
[int]$lines = (Get-content $File).count
[int]$rc = 0
#[int]$wc = 0
#Read-Host -Prompt "$HU1 $HU2"
#[$wc]; $wc++
(Add-Content $OutFile $HU1)
$line = (Get-content $File)[$rc]; $rc++
(Add-Content $OutFile $HU2)
$line = (Get-content $File)[$rc]; $rc++
(Add-Content $OutFile $HU3)
$line = (Get-content $File)[$rc]; $rc++
(Add-Content $OutFile $HU4)
$line = (Get-content $File)[$rc]; $rc++
(Add-Content $OutFile $HU5)
$line = (Get-content $File)[$rc]; $rc++
(Add-Content $OutFile $HU6)
$line = (Get-content $File)[$rc]; $rc++
(Add-Content $OutFile $HU7)
$line = (Get-content $File)[$rc]; $rc++
(Add-Content $OutFile $HU8)
(Add-Content $OutFile $HU9)
#[int]$c = 8
while ($rc -le $lines) {
    $line = (Get-content $File)[$rc]
    if ($null -eq $line) { break }
    if ($Line -match "@") {
        $rc++
    }
    else {
        $Line = $Line -replace '"', "'"
        $Line = $('"' + "$Line" + '",')
        (Add-Content $OutFile $Line)
        $rc++
    }
}
(Add-Content $OutFile $HU10)
(Add-Content $OutFile $HU11)
(Add-Content $OutFile $HU12)
(Add-Content $OutFile $HU13)
(Add-Content $OutFile $HU14)
(Add-Content $OutFile $HU15)
(Add-Content $OutFile $HU16)
(Add-Content $OutFile $HU17)
(Add-Content $OutFile $HU18)
(Add-Content $OutFile $HU19)
(Add-Content $OutFile $HU20)
(Add-Content $OutFile $HU21)
(Add-Content $OutFile $HU22)
(Add-Content $OutFile $HU23)
(Add-Content $OutFile $HU24)
(Add-Content $OutFile $HU25)
(Add-Content $OutFile $HU26)
(Add-Content $OutFile $HU27)
(Add-Content $OutFile $HU28)
(Add-Content $OutFile $HU29)
(Add-Content $OutFile $HU30)
(Add-Content $OutFile $HU31)
(Add-Content $OutFile $HU32)
(Add-Content $OutFile $HU33)
