<#
.SYNOPSIS
        Convert-Script
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 12, 2018
.DESCRIPTION
        This script places quotes on each side of a css file for use in tampermonkey.
        Along with a couple other things required to make it work.
.EXAMPLE
        Script-Convert -File [<complete path to a css file>] -OutFile {<File to write>}
.NOTES
        You will need to edit The header, and remove a bracket in quotes at the bottom.
        If you dont specify a outfile it creates it next to the original.
#>
#FileVersion = 0.1.5
param([string]$File, [string]$OutFile)
if ($File -eq "") {
    Write-Host ""
    Write-Host "You fucked up and didnt include -File [<FileToRead>]"
    Write-Host "Take your hand off your dick, try again and type right."
    return
}
else {
    $InFile = $File
    $Filetest = Test-Path -path $InFile
    if ($Filetest -ne $true) {
        Write-Host ""
        Write-Host "You fucked up, The file you specified $InFile is not there."
        Write-Host "Put the drugs down and try again."
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

$HU0 = "// "
$HU1 = "// ==UserScript=="
$HU2 = Get-ChildItem $File | Get-Content | Select-String -pattern "@name"
$HU3 = Get-ChildItem $File | Get-Content | Select-String -pattern "@namespace"
$HU4 = Get-ChildItem $File | Get-Content | Select-String -pattern "@Version"
$HU5 = Get-ChildItem $File | Get-Content | Select-String -pattern "@description"
$HU6 = Get-ChildItem $File | Get-Content | Select-String -pattern "@author"
$HU7 = "// ==/UserScript=="

$HU2 = $($HU2 -replace "\* @", "@")
$HU3 = $($HU3 -replace "\* @", "@")
$HU4 = $($HU4 -replace "\* @", "@")
$HU3 = $($HU5 -replace "\* @", "@")
$HU6 = $($HU6 -replace "\* @", "@")

$HU2 = $($HU0 + $HU2)
$HU3 = $($HU0 + $HU3)
$HU4 = $($HU0 + $HU4)
$HU5 = $($HU0 + $HU5)
$HU6 = $($HU0 + $HU6)
<# Upper String #>
$HU8 = "(function() {var css = '';"
$HU9 = "css += ["
<# Lower String #>
$HU10 = "].join('\n');"
$HU11 = "if (typeof GM_addStyle != 'undefined') {"
$HU12 = "    GM_addStyle(css);"
$HU13 = "}"
$HU14 = "else if (typeof PRO_addStyle != 'undefined') {"
$HU15 = "PRO_addStyle(css);"
$HU16 = "}"
$HU17 = "else if (typeof addStyle != 'undefined') {"
$HU18 = "    addStyle(css);"
$HU19 = "}"
$HU20 = "else {"
$HU21 = "     var node = document.createElement('style');"
$HU22 = "    node.type = 'text/css';"
$HU23 = "    node.appendChild(document.createTextNode(css));"
$HU24 = "    var heads = document.getElementsByTagName('head');"
$HU25 = "    if (heads.length > 0) {"
$HU26 = "        heads[0].appendChild(node);"
$HU27 = "    }"
$HU28 = "    else {"
$HU29 = "        // no head yet, stick it whereever"
$HU30 = "      document.documentElement.appendChild(node);"
$HU31 = "     }"
$HU32 = "}"
$HU33 = "})();"
$Lines = 0
try {
    $Counter = New-Object IO.StreamReader $File
    while ($null -ne $Counter.ReadLine()) { $Lines++ }
}
Finally { $Counter.Close() }
$c = 0
$reader = [System.IO.File]::OpenText($File)
$writer = [System.IO.file]::CreateText($OutFile)
try {
    $Writer.WriteLine([string]"$HU1")
    $line = $reader.ReadLine()
    $Writer.WriteLine([string]"$HU2")
    $line = $reader.ReadLine()
    $Writer.WriteLine([string]"$HU3")
    $line = $reader.ReadLine()
    $Writer.WriteLine([string]"$HU4")
    $line = $reader.ReadLine()
    $Writer.WriteLine([string]"$HU5")
    $line = $reader.ReadLine()
    $Writer.WriteLine([string]"$HU6")
    $line = $reader.ReadLine()
    $Writer.WriteLine([string]"$HU7")
    $line = $reader.ReadLine()
    $Writer.WriteLine([string]"$HU8")
    $Writer.WriteLine([string]"$HU9")
    $c = 8
    while ($c -le $lines) {
        $line = $reader.ReadLine()
        if ($null -eq $line) { break }
        if ($Line -match "@") {
            $c++
        }
        else {
            $Line = $Line -replace '"', "'"
            $Line = $('"' + "$Line" + '",')
            $Writer.WriteLine([string]"$Line")
            $c++
        }
    }
    $Writer.WriteLine([string]"$HU10")
    $Writer.WriteLine([string]"$HU11")
    $Writer.WriteLine([string]"$HU12")
    $Writer.WriteLine([string]"$HU13")
    $Writer.WriteLine([string]"$HU14")
    $Writer.WriteLine([string]"$HU15")
    $Writer.WriteLine([string]"$HU16")
    $Writer.WriteLine([string]"$HU17")
    $Writer.WriteLine([string]"$HU18")
    $Writer.WriteLine([string]"$HU19")
    $Writer.WriteLine([string]"$HU20")
    $Writer.WriteLine([string]"$HU21")
    $Writer.WriteLine([string]"$HU22")
    $Writer.WriteLine([string]"$HU23")
    $Writer.WriteLine([string]"$HU24")
    $Writer.WriteLine([string]"$HU25")
    $Writer.WriteLine([string]"$HU26")
    $Writer.WriteLine([string]"$HU27")
    $Writer.WriteLine([string]"$HU28")
    $Writer.WriteLine([string]"$HU29")
    $Writer.WriteLine([string]"$HU30")
    $Writer.WriteLine([string]"$HU31")
    $Writer.WriteLine([string]"$HU32")
    $Writer.WriteLine([string]"$HU33")
}
finally {
    $Writer.close()
    $Reader.close()
}
