if ($null -ne $args[0]) { $infile = $args[0] }
if ($null -ne $args[1]) { $OutFile = $args[1] }
$fileVersion = "0.2.1"
if (!($infile)) {
    Say "You fucked up and didnt include -File [<FileToRead>]"
    Say "Take your hand off your dick, try again and type right."
    $ans = Read-Host -Prompt "Enter the complete path to the CSS file to convert to Java"
    if (($ans)) { $infile = $ans }
    else {
        Say "Loser..."
        return
    }
}
$filetest = Test-Path -Path $InFile
if ($filetest -ne $true) {
    Say "Ok I am done messing with you."
    Say "You fucked up, The file you specified $InFile.ToUpper() is not there."
    Say "Put the drugs down and get out."
    return
}
if (!($OutFile)) {
    $tmp1 = $(Get-Item $infile ).DirectoryName
    $tmp2 = $(Get-Item $infile ).Basename
    $OutFile = ($tmp1 + "\" + $tmp2)
    $OutFile = ($OutFile -Replace ".user", "")
    $OutFile = ($OutFile + ".user.js")
    Say "Auto setting the outfile to $Outfile"
}
$filetest = Test-Path -Path $OutFile
if ($filetest -eq $true) { Remove-Item -Path $OutFile }
Say "Convert-Script $fileVersion is begining"
Say "Reading File: $infile"
$HU1 = [string]"// ==UserScript=="
[int]$Lines = 0
[int]$lines = (Get-Content $infile).count
[int]$rc = 0
$done = 0
While ($rc -le $lines) {
    $doit = 1
    [string]$read = (Get-Content $infile)[$rc]
    if ($null -eq $read) { $doit = 0 }
    [string]$read = $read.replace("*", "")
    if ($read -match 'url') { $doit = 0 }
    if ($read -match 'url-prefix') { $doit = 0 }
    if ($read -match 'domain') { $doit = 0 }
    if ($read -match 'media-document') { $doit = 0 }
    if ($read -match '@-moz') { $doit = 0 }
    if ($read -match '@name') {
        [string]$read = $read.TrimStart()
        #[string]$read = $read -replace "     ", ""
        [string]$fill = "//  $read"
        (Add-Content $OutFile $fill)
        $fill = $null
        $doit = 0
    }
    if ($read -match '@namespace') {
        [string]$read = $read.TrimStart()
        [string]$read = $read -replace "user.css", ""
        [string]$read = ($read + "user.js")
        [string]$fill = "//  $read"
        if ($read -notmatch ".css") {
            (Add-Content $OutFile $fill)
        }
        $fill = $null
        $doit = 0
    }
    if ($read -match '@version') {
        [string]$read = $read.TrimStart()
        [string]$read = $read -replace "     ", ""
        [string]$fill = "//  $read"
        (Add-Content $OutFile $fill)
        $fill = $null
        $doit = 0
    }
    if ($read -match '@author') {
        [string]$read = $read.TrimStart()
        #[string]$read = $read -replace "     ", ""
        [string]$fill = "//  $read"
        (Add-Content $OutFile $fill)
        $fill = $null
        $doit = 0
    }
    if ($read -match '@homepage') {
        [string]$read = $read.TrimStart()
        [string]$read = $read -replace "     ", ""
        [string]$fill = "//  $read"
        (Add-Content $OutFile $fill)
        $fill = $null
        $doit = 0
    }
    if ($read -match 'UserStyle') {
        (Add-Content $OutFile $HU1)
        $doit = 0
    }
    if ($doit -eq 1) {
        if ($done -eq 0) {
            $done = 1
            (Add-Content $OutFile "(function() {var css = '';")
            (Add-Content $OutFile "css += [")
        }
        $read = $read -replace '"', "'"
        $read = $('"' + "$read" + '",')
        (Add-Content $OutFile $read)
    }
    $rc++
}
Say "Writing File:" $outfile
$read = $null
(Add-Content $OutFile "].join('\n');")
(Add-Content $OutFile "if (typeof GM_addStyle != 'undefined') {")
(Add-Content $OutFile "    GM_addStyle(css);")
(Add-Content $OutFile "}")
(Add-Content $OutFile "else if (typeof PRO_addStyle != 'undefined') {")
(Add-Content $OutFile "PRO_addStyle(css);")
(Add-Content $OutFile "}")
(Add-Content $OutFile "else if (typeof addStyle != 'undefined') {")
(Add-Content $OutFile "    addStyle(css);")
(Add-Content $OutFile "}")
(Add-Content $OutFile "else {")
(Add-Content $OutFile "     var node = document.createElement('style');")
(Add-Content $OutFile "    node.type = 'text/css';")
(Add-Content $OutFile "    node.appendChild(document.createTextNode(css));")
(Add-Content $OutFile "    var heads = document.getElementsByTagName('head');")
(Add-Content $OutFile "    if (heads.length > 0) {")
(Add-Content $OutFile "        heads[0].appendChild(node);")
(Add-Content $OutFile "    }")
(Add-Content $OutFile "    else {")
(Add-Content $OutFile "        // no head yet, stick it whereever")
(Add-Content $OutFile "      document.documentElement.appendChild(node);")
(Add-Content $OutFile "     }")
(Add-Content $OutFile "}")
(Add-Content $OutFile "})();")
