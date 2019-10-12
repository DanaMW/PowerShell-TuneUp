$FileVersion = "Version: 0.0.8"
$txtfile = ($env:BASE + "\check-prof.ini")
$Filetest = Test-Path -path $txtfile
if ($Filetest -eq $true) {
    Say 'The File $txtfile exists, clearing file.'
    Clear-Content -Path $txtfile
}
#Save below 2 line very useful amd both working
#$Profile | Format-List -Force | Out-String -Stream| % {New-Variable "prof$i" $_ ; $i++}
$Profile | Format-List -Force | Out-String | ForEach-Object { $carrydata = $_ }
$carrydata | Format-List | Out-file $txtfile
$i = 3
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
    $line5 = $reader.ReadLine()
    if ($null -eq $line5) { break }
    $line6 = $reader.ReadLine()
    if ($null -eq $line6) { break }
    $reader.Close()
}
finally { $reader.Close() }
$writer = [System.IO.file]::CreateText($txtfile)
try {
    $moo = $line3 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline("[1A]=" + $cow[0])
    $writer.Writeline("[1B]=" + $cow[1])
    if ($null -eq $cow) { break }
    $moo = $line4 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline("[2A]=" + $cow[0])
    $writer.Writeline("[2B]=" + $cow[1])
    if ($null -eq $cow) { break }
    $moo = $line5 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline("[3A]=" + $cow[0])
    $writer.Writeline("[3B]=" + $cow[1])
    if ($null -eq $cow) { break }
    $moo = $line6 -replace "\s", ""
    $cow = $moo -split ":", 2
    $writer.Writeline("[4A]=" + $cow[0])
    $writer.Writeline("[4B]=" + $cow[1])
    if ($null -eq $cow) { break }
    $writer.Close()
}
finally { $writer.Close() }
Clear-Host
Say "System Profiles information $FileVersion"
Say ""
Say "The Main Profile For Your Account is:"
Say "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
Say $Profile
Say ""
Say "The other possible profile files are:"
Say "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
Say ""
$l = 11
$i = 0
while ($i -le 7) {
    $Line = (Get-Content $txtfile)[$i]
    $Moo = $line -split "="
    $i++; $l++
    $Line = (Get-Content $txtfile)[$i]
    $Cow = $line -split "="
    Say "["$Moo[1]"]: "$Cow[1]
    $i++; $l++; Say ""
}
$l++; $l++
Say ""
$Filetest = Test-Path -path $txtfile
if ($Filetest -eq $true) { Remove-Item -Path $txtfile }
$tmp = WCP "~DARKCYAN~[~~WHITE~Tap Enter to Exit~~DARKCYAN~]~~WHITE~:~ "
Read-Host -Prompt $tmP
