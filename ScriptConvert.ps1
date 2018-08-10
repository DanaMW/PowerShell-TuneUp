<#
.SYNOPSIS
        ScripConvert
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: August 10, 2018
.DESCRIPTION
        This script places quotes on each sode of a css file for use in tampermonkey.
.EXAMPLE
        AddQuotes -File [<complete path to a file>] -OutFile {<File to write>}
.NOTES
        Still under development.
#>
#FileVersion = 0.1.0
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
$HU8 = '(function() {var css = "";'
$HU9 = 'css += ['
$HU10 = ']'
$HU11 = '})();'
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
    $c - 8
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
}
finally {
    $Writer.WriteLine([string]"$HU10")
    $Writer.WriteLine([string]"$HU11")
    $Writer.close()
    $Reader.close()
}
