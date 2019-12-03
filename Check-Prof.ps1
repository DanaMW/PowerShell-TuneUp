$FileVersion = "Version: 0.0.9"
$txtfile = ($env:BASE + "\check-prof.ini")
$Filetest = Test-Path -path $txtfile
if ($Filetest -eq $true) { Clear-Content -Path $txtfile }
#Save below 2 line very useful amd both working
#$Profile | Format-List -Force | Out-String -Stream| % {New-Variable "prof$i" $_ ; $i++}
$Profile | Format-List -Force | Out-String | ForEach-Object { $carrydata = $_ }
$carrydata | Format-List | Out-file $txtfile
$i = 3
Remove-Empty $txtfile
$reader = [System.IO.File]::OpenText($txtfile)
try {
    $line1 = $reader.ReadLine()
    if ($null -eq $line1) { break }
    $line2 = $reader.ReadLine()
    if ($null -eq $line2) { break }
    $line3 = $reader.ReadLine()
    if ($null -eq $line3) { break }
    $line4 = $reader.ReadLine()
    if ($null -eq $line4) { break }
    $reader.Close()
}
finally { $reader.Close() }
$writer = [System.IO.file]::CreateText($txtfile)
try {
    $moo = $line1 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline($cow[0])
    $writer.Writeline($cow[1])
    if ($null -eq $cow) { break }
    $moo = $line2 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline($cow[0])
    $writer.Writeline($cow[1])
    if ($null -eq $cow) { break }
    $moo = $line3 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline($cow[0])
    $writer.Writeline($cow[1])
    if ($null -eq $cow) { break }
    $moo = $line4 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline($cow[0])
    $writer.Writeline($cow[1])
    if ($null -eq $cow) { break }
    $writer.Close()
}
finally { $writer.Close() }
Clear-Host
WC "~white~System Profiles information $FileVersion~"
Say ""
WC "~darkyellow~The Main Profile For Your Account is~~white~:~"
WC "~white~=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=~"
WC "~yellow~$Profile~"
Say ""
WC "~darkyellow~The other possible profile files are~~white~:~"
WC "~white~=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=~"
$l = 11
$i = 0
while ($i -le 7) {
    $Line = (Get-Content $txtfile)[$i]
    $Moo = $line
    $i++; $l++
    $Line = (Get-Content $txtfile)[$i]
    $Cow = $line
    WC "~darkcyan~[~~white~$Moo~~darkcyan~]~~white~:~ ~yellow~$Cow~"
    $i++; $l++;
}
$l++; $l++
$Filetest = Test-Path -path $txtfile
if ($Filetest -eq $true) { Remove-Item -Path $txtfile }
Say ""
$tmp = WCP "~DARKCYAN~[~~darkyellow~Tap Enter to Exit~~DARKCYAN~]~~WHITE~:~ "
Read-Host -Prompt $tmP
