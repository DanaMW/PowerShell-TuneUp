Import-Module CimCmdlets
$FileVersion = "0.1.30"
$ESC = [char]27
$host.ui.RawUI.WindowTitle = "System Information Version $FileVersion"
Clear-Host
if (!($WinHeight)) {
    [int]$WinHeight = 25
    [int]$BuffHeight = $Winheight
}
if (!($WinWidth)) {
    [int]$WinWidth = 60
    [int]$BuffWidth = $WinWidth
}
Function FlexWindow {
    $ErrorHold = "$ErrorActionPreference"
    $ErrorActionPreference = "SilentlyContinue"
    $pshost = Get-Host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    [int]$newsize.height = $BuffHeight
    [int]$newsize.width = $BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    [int]$newsize.height = $WinHeight
    [int]$newsize.width = $WinWidth
    $pswindow.windowsize = $newsize
    $ErrorActionPreference = "$ErrorHold"
}
FlexWindow
Get-CimInstance Win32_OperatingSystem | Format-List
Clear-Host
Say "Hang On Reading In PC Info..."
$ComputerSystem = (Get-CimInstance CIM_ComputerSystem)
$ComputerBIOS = (Get-CimInstance CIM_BIOSElement)
$ComputerOS = (Get-CimInstance CIM_OperatingSystem)
$ComputerCPU = (Get-CimInstance CIM_Processor)
$ComputerHDD1 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'")
$ComputerHDD2 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'D:'")
$ComputerNET = (Get-NetAdapter)
$NetTotal = $ComputerNET.count
$NetTotal = ($NetTotal * 4)
$Net1 = $ComputerNET[0] | Select-Object -Property Name, LinkSpeed, Status, InterfaceDescription
$Net2 = $ComputerNET[1] | Select-Object -Property Name, LinkSpeed, Status, InterfaceDescription
$Net3 = $ComputerNET[2] | Select-Object -Property Name, LinkSpeed, Status, InterfaceDescription
$Net4 = $ComputerNET[3] | Select-Object -Property Name, LinkSpeed, Status, InterfaceDescription
$tt = "$ESC[31m[$ESC[37m"
if (($Net1.name)) {
    $Con11 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net1.name)
    $Con12 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net1.InterfaceDescription)
    if ($Net1.Status -eq "Up") { $N1tmp = "Connected" }
    else { $N1tmp = "Disabled" }
    $Con13 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N1tmp)
    $Con14 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($Net1.LinkSpeed)
}
if (($Net2.name)) {
    $Con21 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net2.name)
    $Con22 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net2.InterfaceDescription)
    if ($Net2.Status -eq "Up") { $N2tmp = "Connected" }
    else { $N2tmp = "Disabled" }
    $Con23 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N2tmp)
    $Con24 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($Net2.LinkSpeed)
}
if (($Net3.name)) {
    $Con31 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net3.name)
    $Con32 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net3.InterfaceDescription)
    if ($Net3.Status -eq "Up") { $N3tmp = "Connected" }
    else { $N3tmp = "Disabled" }
    $Con33 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N3tmp)
    $Con34 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($Net3.LinkSpeed)
}
if (($Net4.name)) {
    $Con41 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net4.name)
    $Con42 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net4.InterfaceDescription)
    if ($Net4.Status -eq "Up") { $N4tmp = "Connected" }
    else { $N4tmp = "Disabled" }
    $Con43 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N4tmp)
    $Con44 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($Net4.LinkSpeed)
}
Clear-Host
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
$inf12 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.Size / 1GB) + " $ESC[37mGB"
$inf13 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD1.FreeSpace / $computerHDD1.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.FreeSpace / 1GB) + " $ESC[37mGB"
$inf14 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.Size / 1GB) + " $ESC[37mGB"
$inf15 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD2.FreeSpace / $computerHDD2.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.FreeSpace / 1GB) + " $ESC[37mGB"
$inf16 = "$tt" + "System RAM.$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory / 1GB) + " $ESC[37mGB"
$inf17 = "$tt" + "OS$ESC[31m][$ESC[37mSystem.$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.caption)
$inf18 = "$tt" + "OS$ESC[31m][$ESC[37mVersion$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.Version)
$inf19 = "$tt" + "User logged$ESC[31m]$ESC[37m: $ESC[36m" + ($computerSystem.UserName)
$inf20 = "$tt" + "Last Reboot$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.LastBootUpTime)
FlexWindow
while (1) {
    $Spin = 21
    if (($netTotal)) { $Spin = ($Spin + $NetTotal) }
    $WinHeight = ($Spin + 3)
    $BuffHeight = $WinHeight
    FlexWindow
    $l = 0
    $n = 00
    while ($l -lt 21) {
        [Console]::SetCursorPosition(0, $l)
        $tmp = '$' + 'inf' + "$n"
        Say -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
        $n++
        $l++
    }
    $p = 1
    $c = 1
    $n = 00
    while ($l -lt $Spin) {
        [Console]::SetCursorPosition(0, $l)
        $tmp = '$' + 'Con' + "$p" + "$c"
        Say -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
        $c++
        $n++
        $l++
        if ($c -eq 5) { $c = 1; $p++ }
    }
    [Console]::SetCursorPosition(0, 0)
    [Console]::SetCursorPosition(0, ($Spin + 1))
    $pop = Read-Host -Prompt "$ESC[31m[$ESC[37mEnter To Continue Q to QUIT X to Reload$ESC[31m]$ESC[37m"
    if ($pop -eq "Q") { break }
    if ($pop -eq "X") { Start-Process "pwsh.exe" -ArgumentList ($env:BASE + '/Get-SysInfo.ps1'); return }

}
