$FileVersion = "Version: 0.0.2"
Say ""
Say "My Version Information $FileVersion"
Say "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
$computerOS = (Get-CimInstance CIM_OperatingSystem)
Say -NoNewline ($computerOS.caption) ($computerOS.version)
[System.Environment]::OSVersion.Version | Format-table
systeminfo /fo csv | ConvertFrom-Csv | Select-Object OS*, System*, Hotfix* | Format-List
