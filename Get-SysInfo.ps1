Import-Module CimCmdlets
$FileVersion = "Version: 0.1.19"
$ESC = [char]27
$host.ui.RawUI.WindowTitle = "System Information Version $FileVersion"
Function FlexWindow {
    if ($BWHeight -eq "") { $BWHeight = "50" }
    if ($BWWidth -eq "") { $BWWidth = "72" }
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    [int]$newsize.height = $BWHeight
    [int]$newsize.width = $BWWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    [int]$newsize.height = $BWHeight
    [int]$newsize.width = $BWWidth
    $pswindow.windowsize = $newsize
}
FlexWindow
function Convert-Size {
    [cmdletbinding()]
    param(
        [validateset("Bytes", "KB", "MB", "GB", "TB")]
        [string]$From,
        [validateset("Bytes", "KB", "MB", "GB", "TB")]
        [string]$To,
        [Parameter(Mandatory = $true)]
        [double]$Value,
        [int]$Precision = 0
    )
    switch ($From) {
        "Bytes" {$value = $Value }
        "KB" {$value = $Value * 1024 }
        "MB" {$value = $Value * 1024 * 1024}
        "GB" {$value = $Value * 1024 * 1024 * 1024}
        "TB" {$value = $Value * 1024 * 1024 * 1024 * 1024}
    }
    switch ($To) {
        "Bytes" {return $value}
        "KB" {$Value = $Value / 1KB}
        "MB" {$Value = $Value / 1MB}
        "GB" {$Value = $Value / 1GB}
        "TB" {$Value = $Value / 1TB}
    }
    return [Math]::Round($value, $Precision, [MidPointRounding]::AwayFromZero)
}
Get-CimInstance Win32_OperatingSystem | Format-List
Clear-Host
$ComputerSystem = (Get-CimInstance CIM_ComputerSystem)
$ComputerBIOS = (Get-CimInstance CIM_BIOSElement)
$ComputerOS = (Get-CimInstance CIM_OperatingSystem)
$ComputerCPU = (Get-CimInstance CIM_Processor)
$ComputerHDD1 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'")
$ComputerHDD2 = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'D:'")
$ComputerNET = (Get-CimInstance win32_networkadapter -Filter "NetEnabled = 'True'")
$NetTotal = $ComputerNET.count
$NetTotal = ($NetTotal * 4)
$Net1 = $ComputerNET[0] | Select-Object -Property Name, Speed, NetEnabled, AdapterType
$Net2 = $ComputerNET[1] | Select-Object -Property Name, Speed, NetEnabled, AdapterType
$Net3 = $ComputerNET[2] | Select-Object -Property Name, Speed, NetEnabled, AdapterType
$Net4 = $ComputerNET[3] | Select-Object -Property Name, Speed, NetEnabled, AdapterType
$tt = "$ESC[31m[$ESC[37m"
if ($null -ne ($Net1.name)) {
    $Con11 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net1.name)
    $Con12 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net1.AdapterType)
    if ($Net1.NetEnabled -eq "True") { $N1tmp = "Connected"}
    else { $N1tmp = "Disabled" }
    $Con13 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N1tmp)
    $N1btmp = (Convert-Size -From "Bytes" -To "MB" -Value $Net1.Speed)
    $Con14 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($N1btmp) + "$ESC[37mMB"
    #$Con14 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N0}" -f ($Net1.Speed / 1GB) + "$ESC[37mGB"
}
if ($null -ne ($Net2.name)) {
    $Con21 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net2.name)
    $Con22 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net2.AdapterType)
    if ($Net2.NetEnabled -eq "True") { $N2tmp = "Connected"}
    else { $N2tmp = "Disabled" }
    $Con23 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N2tmp)
    $N2btmp = (Convert-Size -From "Bytes" -To "MB" -Value $Net2.Speed)
    $Con24 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + ($N2btmp) + "$ESC[37mMB"
    #$Con24 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N0}" -f ($Net2.Speed / 1MB) + "$ESC[37mMB"
}
if ($null -ne ($Net3.name)) {
    $Con31 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net3.name)
    $Con32 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net3.AdapterType)
    if ($Net3.NetEnabled -eq "True") { $N3tmp = "Connected"}
    else { $N3tmp = "Disabled" }
    $Con33 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N3tmp)
    $Con34 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N0}" -f ($Net3.Speed / 1MB) + "$ESC[37mMB"
}
if ($null -ne ($Net4.name)) {
    $Con41 = "$tt" + "NetName$ESC[31m]$ESC[37m: $ESC[33m" + ($Net4.name)
    $Con42 = "$tt" + "Descrip$ESC[31m]$ESC[37m: $ESC[36m" + ($Net4.AdapterType)
    if ($Net4.NetEnabled -eq "True") { $N4tmp = "Connected"}
    else { $N4tmp = "Disabled" }
    $Con43 = "$tt" + "Status.$ESC[31m]$ESC[37m: $ESC[36m" + ($N4tmp)
    $Con44 = "$tt" + "Speed..$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N0}" -f ($Net4.Speed / 1MB) + "$ESC[37mMB"
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
$inf12 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.Size / 1GB) + "$ESC[37mGB"
$inf13 = "$tt" + "HDD$ESC[31m][$ESC[37mC:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD1.FreeSpace / $computerHDD1.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD1.FreeSpace / 1GB) + "$ESC[37mGB"
$inf14 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mCapacity$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.Size / 1GB) + "$ESC[37mGB"
$inf15 = "$tt" + "HDD$ESC[31m][$ESC[37mD:$ESC[31m][$ESC[37mSpace...$ESC[31m]$ESC[37m: $ESC[36m" + "{0:P2}" -f ($computerHDD2.FreeSpace / $computerHDD2.Size) + " $ESC[31m[$ESC[37mFree$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerHDD2.FreeSpace / 1GB) + "$ESC[37mGB"
$inf16 = "$tt" + "System RAM.$ESC[31m]$ESC[37m: $ESC[36m" + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory / 1GB) + "$ESC[37mGB"
$inf17 = "$tt" + "OS$ESC[31m][$ESC[37mSystem.$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.caption)
$inf18 = "$tt" + "OS$ESC[31m][$ESC[37mVersion$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.Version)
$inf19 = "$tt" + "User logged$ESC[31m]$ESC[37m: $ESC[36m" + ($computerSystem.UserName)
$inf20 = "$tt" + "Last Reboot$ESC[31m]$ESC[37m: $ESC[36m" + ($computerOS.LastBootUpTime)
while (1) {
    FlexWindow
    $Spin = 20
    if (($netTotal)) { $Spin = ($Spin + $NetTotal) }
    $l = 0
    $n = 00
    while ($l -lt 24) {
        [Console]::SetCursorPosition(0, $l)
        $tmp = '$' + 'inf' + "$n"
        Say -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
        $n++
        $l++
    }
    $p = 1
    $c = 1
    $n = 00
    $l = ($l - 3)
    if (($NetTotal)) { $spin = ($spin + $NetTotal) }
    while ($l -lt $Spin) {
        [Console]::SetCursorPosition(0, $l)
        $tmp = '$' + 'Con' + "$p" + "$c"
        Say -NoNewLine ($ExecutionContext.InvokeCommand.ExpandString($tmp))
        $c++
        $n++
        $l++
        if ($c -eq 5) { $c = 1; $p++ }
    }
    $ender = ($l - 6)
    [Console]::SetCursorPosition(0, 0)
    [Console]::SetCursorPosition(0, $ender)
    $pop = Read-Host -Prompt "$ESC[31m[$ESC[37mEnter To Continue Q to QUIT X to Reload$ESC[31m]$ESC[37m"
    if ($pop -eq "Q") { break }
    if ($pop -eq "X") { Start-Process "pwsh.exe" -ArgumentList ($env:BASE + "\Get-Sysinfo.ps1"); return }

}
