$FileVersion = "Version 0.0.4"
$txtfile = 'C:\bin\check-prof.ini'
$ESC = [char]27
$Filetest = Test-Path -path $txtfile
if ($Filetest -eq $true) {
    Write-Host 'The File $txtfile exists, clearing file.'
    Clear-Content -Path $txtfile
}
#Save below 2 line very useful amd both working
#$Profile | Format-List -Force | Out-String -Stream| % {New-Variable "prof$i" $_ ; $i++}
$Profile | Format-List -Force | Out-String| ForEach-Object {$carrydata = $_}
$carrydata | Format-List | Out-file $txtfile
<# Fixing the File before we move on #>
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
Write-Host "$ESC[31m#=====================================================================================#$ESC[37m"
Write-Host "$ESC[31m|$ESC[37m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[37m"
Write-Host "$ESC[31m#=======================<$ESC[36m[ $ESC[37mSystem Profiles files information $ESC[36m]$ESC[31m>=======================#$ESC[37m"
Write-Host "$ESC[31m|$ESC[37m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[37m"
Write-Host "$ESC[31m#=====================================================================================#$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m|                                                                                     $ESC[31m|$ESC[37m"
Write-Host "$ESC[31m#=====================================================================================#$ESC[37m"
Write-Host "$ESC[31m|$ESC[37m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$ESC[31m|$ESC[37m"
Write-Host "$ESC[31m#=====================================================================================#$ESC[37m"
[Console]::SetCursorPosition(1, 5)
Write-Host -NoNewLine "$ESC[31m[$ESC[36mThe Main Frofile For Your Account is$ESC[31m]$ESC[37m:"
[Console]::SetCursorPosition(1, 6)
Write-Host -NoNewLine "$ESC[37m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
[Console]::SetCursorPosition(1, 7)
Write-Host -NoNewLine "$ESC[31m[$ESC[37m"$Profile "$ESC[31m]"
[Console]::SetCursorPosition(1, 9)
Write-Host -NoNewLine "$ESC[31m[$ESC[36mThe other possible profiles are$ESC[31m]$ESC[37m:"
[Console]::SetCursorPosition(1, 10)
Write-Host -NoNewLine "$ESC[37m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
$l = 11
$i = 0
while ($i -le 7) {
    $Line = (Get-Content $txtfile)[$i]
    $Moo = $line -split "="
    [Console]::SetCursorPosition(1, $l)
    Write-Host -NoNewLine "$ESC[31m[$ESC[36m"$Moo[1] "$ESC[31m]"
    $i++
    $l++
    $Line = (Get-Content $txtfile)[$i]
    $Moo = $line -split "="
    [Console]::SetCursorPosition(1, $l)
    Write-Host -NoNewLine "$ESC[31m[$ESC[37m"$Moo[1] "$ESC[31m]"
    $i++
    $l++
}
$l++
$l++
[Console]::SetCursorPosition(0, $l)
[Console]::SetCursorPosition(0, $l)
Write-Host ""
$Filetest = Test-Path -path $txtfile
if ($Filetest -eq $true) { Remove-Item -Path $txtfile }
