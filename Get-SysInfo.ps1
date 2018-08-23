$FileVersion = "0.1.6"
$ESC = [char]27
$nline = "$ESC[31m#=====================================================================#$ESC[37m"
$dline = "$ESC[31m| $ESC[37m| $ESC[31m#=============================================================$ESC[31m# $ESC[37m| $ESC[31m|"
$fline = "$ESC[31m| $ESC[37m#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-# $ESC[31m| $ESC[37m"
$tline = "$ESC[31m| $ESC[37m#=-=-=-=-=-=-=-=-=-=-=-<$ESC[36m[$ESC[37mSystem Information$ESC[36m]$ESC[31m$ESC[37m>=-=-=-=-=-=-=-=-=-=-=#$ESC[31m |$ESC[37m"
$sline = "$ESC[31m| $ESC[37m| $ESC[31m|                                                             $ESC[31m| $ESC[37m|$ESC[31m |$ESC[37m"
$host.ui.RawUI.WindowTitle = "System Information Version " + $FileVersion
<# #[Set-ConWin]#[Window Resizer]# #>
$tmpHeight = "46"
$tmpWidth = "72"
if ($tmpWidth -eq "") { $tmpWidth = "107" }
if ($tmpHeight -eq "") { $tmpHeight = "45" }
$pshost = (get-host)
$pswindow = ($pshost.ui.rawui)
$newsize = ($pswindow.buffersize)
$newsize.height = "2000"
$tmp = ($tmpWidth * 2)
$newsize.width = "$tmp"
$pswindow.buffersize = ($newsize)
$newsize = ($pswindow.windowsize)
$newsize.height = ($tmpHeight)
$newsize.width = ($tmpWidth)
$pswindow.windowsize = ($newsize)
$Base = "C:\bin\"
Get-CimInstance Win32_OperatingSystem | Format-List
Clear-Host
$computerSystem = (Get-CimInstance CIM_ComputerSystem)
$computerBIOS = (Get-CimInstance CIM_BIOSElement)
$computerOS = (Get-CimInstance CIM_OperatingSystem)
$computerCPU = (Get-CimInstance CIM_Processor)
$computerHDD1 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'")
$computerHDD2 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'D:'")
$Net1 = $(Get-NetAdapter)[0] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
$Net2 = $(Get-NetAdapter)[1] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
$Net3 = $(Get-NetAdapter)[2] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
$Net4 = $(Get-NetAdapter)[3] | Select-Object -Property name, InterfaceDescription, Status, LinkSpeed
$tt = "$ESC[31m[$ESC[37m"
$Con11 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net1.name)
$Con12 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($net1.InterfaceDescription)
if ($net1.Status -eq "Not Present") { $N1tmp = "Disabled"}
else { $N1tmp = ($net1.Status) }
$Con13 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N1tmp)
$Con14 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net1.LinkSpeed)
$Con21 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net2.name)
$Con22 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($net2.InterfaceDescription)
if ($net2.Status -eq "Not Present") { $N2tmp = "Disabled"}
else { $N2tmp = ($net2.Status) }
$Con23 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N2tmp)
$Con24 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net2.LinkSpeed)
$Con31 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net3.name)
$Con32 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($net3.InterfaceDescription)
if ($net3.Status -eq "Not Present") { $N3tmp = "Disabled"}
else { $N3tmp = ($net3.Status) }
$Con33 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N3tmp)
$Con34 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net3.LinkSpeed)
$Con41 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($net4.name)
$Con42 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net4.InterfaceDescription)
if ($net4.Status -eq "Not Present") { $N4tmp = "Disabled"}
else { $N4tmp = ($net4.Status) }
$Con43 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N4tmp)
$Con44 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($net4.LinkSpeed)
$inf0 = "$tt" + "System Information for$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Name
$inf1 = "$tt" + "Manufacturer$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Manufacturer
$inf2 = "$tt" + "Model$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Model
$inf3 = "$tt" + "Serial Number$ESC[31m]$ESC[37m: $ESC[36m" + $computerBIOS.SerialNumber
$inf4 = "$tt" + "CPU$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.Name
$inf5 = "$tt" + "CPU$ESC[31m][$ESC[37mClock Speed$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.maxClockSpeed + "$ESC[37mMHz"
$inf6 = "$tt" + "CPU$ESC[31m][$ESC[37mCores$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.numberOfCores
$inf7 = "$tt" + "CPU$ESC[31m][$ESC[37mLogical Processors$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.NumberOfLogicalProcessors
$inf8 = "$tt" + "CPU$ESC[31m][$ESC[37mDescription$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.description
$inf9 = "$tt" + "CPU$ESC[31m][$ESC[37mSocket$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.socketDesignation
$inf10 = "$tt" + "CPU$ESC[31m][$ESC[37mStatus$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.status
$inf11 = "$tt" + "CPU$ESC[31m][$ESC[37mManufacturer$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.manufacturer
$inf12 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.Size / 1GB) + "$ESC[37mGB"
$inf13 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD1.FreeSpace / $computerHDD1.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.FreeSpace / 1GB) + "$ESC[37mGB"
$inf14 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.Size / 1GB) + "$ESC[37mGB"
$inf15 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD2.FreeSpace / $computerHDD2.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.FreeSpace / 1GB) + "$ESC[37mGB"
$inf16 = "$tt" + "System RAM.$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory / 1GB) + "$ESC[37mGB"
$inf17 = "$tt" + "OS$ESC[31m][$ESC[37mSystem.$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.caption)
$inf18 = "$tt" + "OS$ESC[31m][$ESC[37mVersion$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.Version)
$inf19 = "$tt" + "User logged$ESC[31m]$ESC[37m: $ESC[36m" + ($computerSystem.UserName)
$inf20 = "$tt" + "Last Reboot$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.LastBootUpTime)
Write-Host $nline
$tline
$dline
$i = 0
while ($i -le 36) { Write-Host $sline ; $i++ }
$dline
$fline
$nline
$l = 3
$n = 00
while ($l -lt 24) {
    [Console]::SetCursorPosition(6, $l)
    $tmp = '$' + 'inf' + "$n"
    Write-Host -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
    $n++
    $l++
}
$p = 1
$c = 1
$n = 00
while ($l -lt 50) {
    [Console]::SetCursorPosition(6, $l)
    $tmp = '$' + 'Con' + "$p" + "$c"
    Write-Host -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
    $c++
    $n++
    $l++
    if ($c -eq 5) { $c = 1; $p++ }
}
[Console]::SetCursorPosition(0, 0)
Write-Host -NoNewLine $nline
[Console]::SetCursorPosition(0, 43)
$pop = Read-Host -Prompt "$ESC[31m[$ESC[37mEnter To Continue$ESC[31m]$ESC[37m"
if ($pop -eq "") { break }
