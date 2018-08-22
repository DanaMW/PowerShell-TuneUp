$FileVersion = 0.0.2
$ESC = [char]27
$nline = "$ESC[31m#=======================================================================================#$ESC[37m"
$dline = "$ESC[31m| $ESC[37m| $ESC[31m#===============================================================================$ESC[31m# $ESC[37m| $ESC[31m|"
$fline = "$ESC[31m| $ESC[37m#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-# $ESC[31m| $ESC[37m"
$tline = "$ESC[31m| $ESC[37m#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<$ESC[36m[$ESC[37mSystem Information$ESC[36m]$ESC[31m$ESC[37m>=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#$ESC[31m |$ESC[37m"
$sline = "$ESC[31m| $ESC[37m| $ESC[31m|                                                                               $ESC[31m| $ESC[37m|$ESC[31m |$ESC[37m"
$host.ui.RawUI.WindowTitle = "System Information v." + $FileVersion
Get-CimInstance Win32_OperatingSystem | Format-List
Clear-Host
$computerSystem = (Get-CimInstance CIM_ComputerSystem)
$computerBIOS = (Get-CimInstance CIM_BIOSElement)
$computerOS = (Get-CimInstance CIM_OperatingSystem)
$computerCPU = (Get-CimInstance CIM_Processor)
$computerHDD1 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'")
$computerHDD2 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'D:'")
$tt = "$ESC[31m[$ESC[37m"
$inf0 = "$tt" + "System Information for$ESC[36m]$ESC[37m: $ESC[36m" + $computerSystem.Name
$inf1 = "$tt" + "Manufacturer$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Manufacturer
$inf2 = "$tt" + "Model$ESC[31m]$ESC[37m: $ESC[36m" + $computerSystem.Model
$inf3 = "$tt" + "Serial Number$ESC[31m]$ESC[37m: $ESC[36m" + $computerBIOS.SerialNumber
$inf4 = "$tt" + "CPU$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.Name
$inf5 = "$tt" + "CPU$ESC[31m][$ESC[37mClock Speed$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.maxClockSpeed
$inf6 = "$tt" + "CPU$ESC[31m][$ESC[37mCores$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.numberOfCores
$inf7 = "$tt" + "CPU$ESC[31m][$ESC[37mDescription$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.description
$inf8 = "$tt" + "CPU$ESC[31m][$ESC[37mLogical Processors$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.NumberOfLogicalProcessors
$inf9 = "$tt" + "CPU$ESC[31m][$ESC[37mSocket$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.socketDesignation
$inf10 = "$tt" + "CPU$ESC[31m][$ESC[37mStatus$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.status
$inf11 = "$tt" + "CPU$ESC[31m][$ESC[37mManufacturer$ESC[31m]$ESC[37m: $ESC[36m" + $computerCPU.manufacturer
$inf12 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.Size / 1GB) + "$ESC[37mGB"
$inf13 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mSpace$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD1.FreeSpace / $computerHDD1.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.FreeSpace / 1GB) + "$ESC[37mGB"
$inf14 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.Size / 1GB) + "$ESC[37mGB"
$inf15 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mSpace$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD2.FreeSpace / $computerHDD2.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.FreeSpace / 1GB) + "$ESC[37mGB"
$inf16 = "$tt" + "System RAM$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory / 1GB) + "$ESC[37mGB"
$inf17 = "$tt" + "Operating System$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.caption) + "$ESC[37m, $ESC[31m[$ESC[37mVersion$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.Version)
$inf18 = "$tt" + "User logged In$ESC[31m]$ESC[37m: $ESC[36m" + ($computerSystem.UserName)
$inf19 = "$tt" + "Last Reboot$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.LastBootUpTime)
#Clear-Host
Write-Host $nline
$tline
#$fline
$dline
$i = 0
while ($i -le 19) { Write-Host $sline ; $i++ }
$dline
$fline
$nline
$l = 3
$n = 00
while ($l -lt 23) {
    [Console]::SetCursorPosition(6, $l)
    $tmp = '$' + 'inf' + "$n"
    Write-Host -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
    $n++
    $l++
}
[Console]::SetCursorPosition(0, 26)
$pop = Read-Host -Prompt  "$ESC[31m[$ESC[37mEnter To Continue$ESC[31m]$ESC[37m"
if ($pop -eq "") { break }
