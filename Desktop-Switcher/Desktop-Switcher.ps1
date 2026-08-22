<#
.SYNOPSIS
    Desktop-Switcher - Advanced, robust wallpaper management script with integrated scheduling, logging, and history.
.DESCRIPTION
    Desktop-Switcher - Premium Persistent Wallpaper Engine
.PARAMETER ForceNewConfig
    [Switch] Forces the configuration wizard to execute immediately, overwriting any existing
    JSON settings and rebuilding the Windows Scheduled Task tracking schema.
.PARAMETER ViewConfig
    [Switch] Displays the parsed contents of the active configuration JSON profile directly
    to the console stream and immediately terminates script execution.
.PARAMETER LooseArgs
    [Positional/Remaining Array] Catcher's mitt designed to intercept raw, dashless string arguments
    passed from automated shell wrappers or shorthand typing inputs. Supported arguments include:

    'View' / 'ViewConfig' - Parses and prints the current JSON profile settings on-screen.
    'Disable'             - Suspends the background task schedule runner via Task Scheduler.
    'Enable'              - Re-activates the background task schedule runner via Task Scheduler.
    'Stop'                - Kills active explorer.exe threads to clear stuck loops and halts automation.
.EXAMPLE
    .\Desktop-Switcher.ps1 -ViewConfig
    Displays the tracking JSON file using standard formal switch parameters.
.EXAMPLE
    Desktop-Switcher View
    Displays active configuration variables using custom shorthand shell wrappers.
.EXAMPLE
    Desktop-Switcher Disable
    Instructs the script to connect to the local Task Scheduler engine and suspend the background timer.
.EXAMPLE
    Desktop-Switcher Stop
    Terminate the shell process to clear desktop states and enforces an immediate automation pause.
.NOTES
    Author:      Dana L. Meli-Wischman (DanaMW)
    Project:     StrangeScript Toolset
    Created:     June 28th, 2026
    Copyright:   ©2026 DanaMW All rights reserved.
#>

[CmdletBinding()]
param(
    [Switch]$ForceNewConfig,
    [Switch]$ViewConfig,

    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$LooseArgs
)

Add-Type -AssemblyName System.Windows.Forms

# --- Windows Multi-Monitor COM API ---
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

[ComImport]
[Guid("C2CF3110-460E-4fc1-B9D0-8A1C0C9CC4BD")]
public class WallpaperManager {}

[ComImport]
[Guid("B92B56A9-8B55-4E14-9A89-0199BBB6F93B")]
[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
public interface IDesktopWallpaper {
    void SetWallpaper([MarshalAs(UnmanagedType.LPWStr)] string monitorID, [MarshalAs(UnmanagedType.LPWStr)] string wallpaper);
    [return: MarshalAs(UnmanagedType.LPWStr)]
    string GetWallpaper([MarshalAs(UnmanagedType.LPWStr)] string monitorID);
    void GetMonitorDevicePathAt(uint monitorIndex, [MarshalAs(UnmanagedType.LPWStr)] out string monitorID);
    uint GetMonitorDevicePathCount();
    void GetMonitorRECT([MarshalAs(UnmanagedType.LPWStr)] string monitorID, out IntPtr displayRect);
    void SetPosition(int position);
    int GetPosition();
    void SetBackgroundColor(uint color);
    uint GetBackgroundColor();
    void SetSlideshow(IntPtr items);
    IntPtr GetSlideshow();
    void SetSlideshowOptions(uint options, uint slideshowTick);
    void GetSlideshowOptions(out uint options, out uint slideshowTick);
    void AdvanceSlideshow([MarshalAs(UnmanagedType.LPWStr)] string monitorID, int direction);
    void GetStatus(out int state);
    void Enable(bool enable);
}

public class WallpaperHelper {
    public static void SetMonitorWallpaper(string monitorID, string path, int style) {
        try {
            IDesktopWallpaper wallpaper = (IDesktopWallpaper)new WallpaperManager();
            wallpaper.SetPosition(style);
            wallpaper.SetWallpaper(monitorID, path);
            Marshal.ReleaseComObject(wallpaper);
        } catch {}
    }
    public static string GetMonitorID(uint index) {
        try {
            IDesktopWallpaper wallpaper = (IDesktopWallpaper)new WallpaperManager();
            string id;
            wallpaper.GetMonitorDevicePathAt(index, out id);
            Marshal.ReleaseComObject(wallpaper);
            return id;
        } catch {
            return null;
        }
    }
}
'@ -ErrorAction SilentlyContinue

# --- Safe Directory Anchoring & Global File Naming ---
$ScriptBaseName = [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)
if ([string]::IsNullOrEmpty($ScriptBaseName)) { $ScriptBaseName = "Desktop-Switcher" }

$ScriptDirectory = (Split-Path -Parent $PSCommandPath)
if ([string]::IsNullOrEmpty($ScriptDirectory)) { $ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition }
if ([string]::IsNullOrEmpty($ScriptDirectory)) { $ScriptDirectory = $PSScriptRoot }

Set-Location -Path $ScriptDirectory.substring(0, 3)
Set-Location -Path $ScriptDirectory
$ConfigFile = Join-Path $ScriptDirectory "$ScriptBaseName.json"

# --- File Versioning ---
$FileVersion = "0.0.30"
$FileDate = "08.20.2026"

# --- SYSTEM WIDE LOGGING ENGINE ---
function Write-Log {
    param (
        [string]$Message,
        [ValidateSet("Info", "Warning", "Error")] $Type = "Info"
    )
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogMessage = "[$Timestamp] [$Type] $Message"

    switch ($Type) {
        "Error" { Write-Host $LogMessage -ForegroundColor Red }
        "Warning" { Write-Host $LogMessage -ForegroundColor Yellow }
        "Info" { Write-Host $LogMessage -ForegroundColor Cyan }
    }

    if ($Script:Config -and $Script:Config.LogToFile) {
        try {
            $TargetLogPath = if ([System.IO.Path]::IsPathRooted($Script:Config.LogFilePath)) {
                $Script:Config.LogFilePath
            }
            else {
                Join-Path $ScriptDirectory $Script:Config.LogFilePath
            }
            $LogMessage | Out-File -FilePath $TargetLogPath -Append -Encoding utf8
        }
        catch {}
    }

    if ($Script:Config -and $Script:Config.LogToEventLog -and ($Type -eq "Error" -or $Type -eq "Warning")) {
        try {
            if (-not [System.Diagnostics.EventLog]::SourceExists("$ScriptBaseName")) {
                [System.Diagnostics.EventLog]::CreateEventSource("$ScriptBaseName", "Application")
            }
            $EntryType = switch ($Type) { "Error" { "Error" }; "Warning" { "Warning" }; default { "Information" } }
            Write-EventLog -LogName Application -Source "$ScriptBaseName" -EventId 1001 -EntryType $EntryType -Message $Message
        }
        catch {}
    }
}

# --- DEFAULT CONFIGURATION STRUCTURE ---
$DefaultConfig = @{
    LogToFile         = $true
    LogToEventLog     = $false
    LogFilePath       = "Desktop-Switcher.log"
    HistoryPercentage = 50  # Default to 50% of total image pool
    Monitors          = @(
        [PSCustomObject]@{
            ID         = "Monitor 1"
            Source     = "D:\Pictures\Desktop"
            Interval   = 60
            Style      = 10
            LastImage  = ""
            LastChange = (Get-Date).AddDays(-1)
        },
        [PSCustomObject]@{
            ID         = "Monitor 2"
            Source     = "D:\Pictures\Desktop"
            Interval   = 0
            Style      = 10
            LastImage  = ""
            LastChange = (Get-Date).AddDays(-1)
        }
    )
}

# --- CONFIGURATION MANAGEMENT ---
function Get-Config {
    try {
        if (Test-Path $ConfigFile) {
            $RawJson = Get-Content $ConfigFile -Raw
            return $RawJson | ConvertFrom-Json -Depth 5
        }
    }
    catch {
        Write-Log "Failed to load JSON configuration: $_" "Error"
    }
    return $DefaultConfig
}

function Save-Config {
    param($Data)
    try {
        $Data | ConvertTo-Json -Depth 5 | Set-Content -Path $ConfigFile -Force
    }
    catch {
        Write-Log "Critical Error saving configuration: $_" "Error"
    }
}

function Invoke-SafeAction {
    param([scriptblock]$Action, [string]$ActionName)
    try {
        & $Action
    }
    catch {
        $ErrMsg = "Action '$ActionName' failed: $($_.Exception.Message)"
        Write-Log $ErrMsg "Error"
        Start-Sleep -Seconds 2
    }
}

# --- EXTERNAL HISTORY FILE MANAGEMENT ---
function Get-HistoryFilePath {
    param([string]$MonitorID)
    $SafeName = $MonitorID -replace '[^\w]', '_'
    return Join-Path $ScriptDirectory "$SafeName-History.txt"
}

function Get-MonitorHistoryList {
    param([string]$MonitorID)
    $HistFile = Get-HistoryFilePath -MonitorID $MonitorID
    if (Test-Path $HistFile) {
        return @(Get-Content $HistFile -ErrorAction SilentlyContinue | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    }
    return @()
}

function Add-MonitorHistoryEntry {
    param([string]$MonitorID, [string]$ImagePath, [int]$TotalImages)
    $HistFile = Get-HistoryFilePath -MonitorID $MonitorID

    $History = [System.Collections.Generic.List[string]]::new()
    $Existing = Get-MonitorHistoryList -MonitorID $MonitorID
    foreach ($Item in $Existing) {
        [void]$History.Add($Item)
    }

    $History.Add($ImagePath)

    # Dynamic history cap based on configured percentage
    $Percent = if ($Script:Config -and $null -ne $Script:Config.HistoryPercentage) { [int]$Script:Config.HistoryPercentage } else { 50 }
    $MaxHistory = [Math]::Max(1, [Math]::Floor($TotalImages * ($Percent / 100)))

    while ($History.Count -gt $MaxHistory) {
        $History.RemoveAt(0)
    }

    $History | Set-Content -Path $HistFile -Encoding utf8 -Force
}

function Clear-MonitorHistoryFile {
    param([string]$MonitorID)
    $HistFile = Get-HistoryFilePath -MonitorID $MonitorID
    try {
        if (Test-Path $HistFile) {
            # Reset/truncate history file smoothly to avoid access lock issues
            Clear-Content -Path $HistFile -ErrorAction Stop
        }
    }
    catch {
        Remove-Item $HistFile -Force -ErrorAction SilentlyContinue
    }
}

function Clear-AllHistories {
    foreach ($Mon in $Script:Config.Monitors) {
        Clear-MonitorHistoryFile -MonitorID $Mon.ID
    }
    Write-Log "Cleared history files for all monitors." "Info"
}

# --- CORE ROTATION ENGINE WITH EXTERNAL HISTORY ---
function Process-WallpaperRotations {
    $IndexVal = 0
    foreach ($Mon in $Script:Config.Monitors) {
        try {
            if ($Mon.Interval -le 0) {
                $IndexVal++
                continue
            }

            $ForceInitial = [string]::IsNullOrEmpty($Mon.LastImage)
            $TimeElapsed = if ($Mon.LastChange) { (Get-Date) - [datetime]$Mon.LastChange } else { [timespan]::MaxValue }

            if ($ForceInitial -or ($TimeElapsed.TotalSeconds -ge $Mon.Interval)) {
                if (-not (Test-Path $Mon.Source)) {
                    Write-Log "Monitor source path not found: $($Mon.Source)" "Warning"
                    $IndexVal++
                    continue
                }

                $Images = Get-ChildItem -Path $Mon.Source -File -ErrorAction Stop | Where-Object { $_.Extension -match '\.(jpg|jpeg|png|bmp)$' }

                if ($Images) {
                    $HistoryList = Get-MonitorHistoryList -MonitorID $Mon.ID
                    $AvailableImages = $Images | Where-Object { $HistoryList -notcontains $_.FullName }

                    if (-not $AvailableImages) {
                        Clear-MonitorHistoryFile -MonitorID $Mon.ID
                        $AvailableImages = $Images
                    }

                    $Selected = ($AvailableImages | Get-Random).FullName

                    Add-MonitorHistoryEntry -MonitorID $Mon.ID -ImagePath $Selected -TotalImages $Images.Count

                    $Mon.LastImage = $Selected
                    $Mon.LastChange = Get-Date

                    $MonitorId = [WallpaperHelper]::GetMonitorID([uint32]$IndexVal)
                    if (-not [string]::IsNullOrEmpty($MonitorId)) {
                        [WallpaperHelper]::SetMonitorWallpaper($MonitorId, $Selected, [int]$Mon.Style)
                        Save-Config $Script:Config
                        Write-Log "Applied wallpaper to $($Mon.ID) -> $Selected" "Info"
                    }
                    else {
                        Write-Log "Could not find Windows display path for $($Mon.ID)" "Warning"
                    }
                }
                else {
                    Write-Log "No valid image files found in source: $($Mon.Source)" "Warning"
                }
            }
        }
        catch {
            Write-Log "Wallpaper update failed: $($_.Exception.Message)" "Error"
        }
        $IndexVal++
    }
}

# --- INITIALIZATION ---
$Config = Get-Config
$Script:Config = $Config

# Ensure history percentage property exists
if ($null -eq $Script:Config.HistoryPercentage) {
    $Script:Config | Add-Member -MemberType NoteProperty -Name "HistoryPercentage" -Value 50
    Save-Config $Script:Config
}

if (-not $Script:Config.Monitors) {
    $Script:Config | Add-Member -MemberType NoteProperty -Name "Monitors" -Value $DefaultConfig.Monitors
    Save-Config $Script:Config
}

if (-not (Test-Path $ConfigFile)) {
    Save-Config $Script:Config
}

$RunningName = [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Path)
if ([string]::IsNullOrEmpty($RunningName)) { $RunningName = $ScriptBaseName }
Write-Host "Running $RunningName $FileVersion ($FileDate)" -ForegroundColor Green
Write-Log "Running $RunningName $FileVersion ($FileDate) at $(Get-Date -Format 'HH:mm:ss')" "Info"

# Startup check with external history tracking
$InitIndex = 0
foreach ($Mon in $Script:Config.Monitors) {
    if ([string]::IsNullOrEmpty($Mon.LastImage) -and (Test-Path $Mon.Source)) {
        $Images = Get-ChildItem -Path $Mon.Source -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -match '\.(jpg|jpeg|png|bmp)$' }
        if ($Images) {
            $HistoryList = Get-MonitorHistoryList -MonitorID $Mon.ID
            $AvailableImages = $Images | Where-Object { $HistoryList -notcontains $_.FullName }
            if (-not $AvailableImages) {
                Clear-MonitorHistoryFile -MonitorID $Mon.ID
                $AvailableImages = $Images
            }
            $Selected = ($AvailableImages | Get-Random).FullName
            Add-MonitorHistoryEntry -MonitorID $Mon.ID -ImagePath $Selected -TotalImages $Images.Count
            $Mon.LastImage = $Selected
            $Mon.LastChange = Get-Date
            $MonitorId = [WallpaperHelper]::GetMonitorID([uint32]$InitIndex)
            if (-not [string]::IsNullOrEmpty($MonitorId)) {
                [WallpaperHelper]::SetMonitorWallpaper($MonitorId, $Selected, [int]$Mon.Style)
            }
        }
    }
    $InitIndex++
}
Save-Config $Script:Config

$Running = $true
$LastDisplaySecond = -1

function Force-RotateMonitor {
    param([int]$Index)
    $Mon = $Script:Config.Monitors[$Index]

    if (-not (Test-Path $Mon.Source)) {
        Write-Log "Source path not found: $($Mon.Source)" "Warning"
        return
    }
    $Images = Get-ChildItem -Path $Mon.Source -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -match '\.(jpg|jpeg|png|bmp)$' }
    if ($Images) {
        $HistoryList = Get-MonitorHistoryList -MonitorID $Mon.ID
        $AvailableImages = $Images | Where-Object { $HistoryList -notcontains $_.FullName }
        if (-not $AvailableImages) {
            Clear-MonitorHistoryFile -MonitorID $Mon.ID
            $AvailableImages = $Images
        }
        $Selected = ($AvailableImages | Get-Random).FullName

        Add-MonitorHistoryEntry -MonitorID $Mon.ID -ImagePath $Selected -TotalImages $Images.Count

        $Mon.LastImage = $Selected
        $Mon.LastChange = Get-Date

        $MonitorId = [WallpaperHelper]::GetMonitorID([uint32]$Index)
        if (-not [string]::IsNullOrEmpty($MonitorId)) {
            [WallpaperHelper]::SetMonitorWallpaper($MonitorId, $Selected, [int]$Mon.Style)
            Save-Config $Script:Config
            Write-Log "Manual force trigger for $($Mon.ID) -> $Selected" "Info"
        }
        else {
            Write-Log "Failed to retrieve Windows display path for $($Mon.ID)" "Error"
        }
    }
}

function Cycle-LogMode {
    if (-not $Script:Config.LogToFile -and -not $Script:Config.LogToEventLog) {
        $Script:Config.LogToFile = $true
    }
    elseif ($Script:Config.LogToFile -and -not $Script:Config.LogToEventLog) {
        $Script:Config.LogToFile = $false
        $Script:Config.LogToEventLog = $true
    }
    elseif ($Script:Config.LogToFile -and $Script:Config.LogToEventLog) {
        $Script:Config.LogToFile = $false
        $Script:Config.LogToEventLog = $false
    }
    else {
        $Script:Config.LogToFile = $true
        $Script:Config.LogToEventLog = $true
    }
    Save-Config $Script:Config
}

function Cycle-Styles {
    foreach ($Mon in $Script:Config.Monitors) {
        $Mon.Style = switch ($Mon.Style) { 10 { 6 }; 6 { 2 }; 2 { 0 }; 0 { 10 }; default { 10 } }
    }
    Save-Config $Script:Config
}

function Set-HistoryPercentage {
    $RawInput = Read-Host "Enter History Buffer Percentage (1-100)"

    # Strip everything except digits
    $CleanInput = $RawInput -replace '[^\d]', ''

    if (-not [string]::IsNullOrWhiteSpace($CleanInput)) {
        $Val = [int]$CleanInput
        if ($Val -ge 1 -and $Val -le 100) {
            $Script:Config.HistoryPercentage = $Val
            Save-Config $Script:Config
            Write-Log "History percentage buffer updated to ${Val}%" "Info"
        }
        else {
            Write-Log "Percentage must be between 1 and 100." "Warning"
        }
    }
    else {
        Write-Log "Invalid input for percentage." "Warning"
    }
}

while ($Running) {
    Process-WallpaperRotations

    $CurrentSecond = [Math]::Floor((Get-Date).Second)
    if ($CurrentSecond -ne $LastDisplaySecond) {
        $LastDisplaySecond = $CurrentSecond
        Clear-Host

        # Header Box Frame
        Write-Host " ╔═════════════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
        Write-Host " ║" -NoNewline -ForegroundColor Magenta
        Write-Host "                    Desktop-Switcher V$FileVersion                    " -NoNewline -ForegroundColor Green
        Write-Host "  ║" -ForegroundColor Magenta
        Write-Host " ╚═════════════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
        Write-Host ""

        # Monitor Readouts
        foreach ($Mon in $Script:Config.Monitors) {
            $StyleText = switch ($Mon.Style) { 10 { "Fill" }; 6 { "Fit" }; 2 { "Stretch" }; 0 { "Center" }; default { "Fill" } }

            if ($Mon.Interval -le 0) {
                $TimeDisplay = "Off"
            }
            else {
                $TimeRemaining = [Math]::Max(0, ($Mon.Interval - ((Get-Date) - [datetime]$Mon.LastChange).TotalSeconds))
                $TimeDisplay = "$([math]::Round($TimeRemaining))s"
            }

            $CurrentFile = if ([string]::IsNullOrEmpty($Mon.LastImage)) { "None" } else { [System.IO.Path]::GetFileName($Mon.LastImage) }

            # Format/pad string to maintain uniform line length
            if ($CurrentFile.Length -gt 24) { $CurrentFile = $CurrentFile.Substring(0, 21) + "..." }
            $PaddedFile = $CurrentFile.PadRight(24)

            Write-Host "  [" -NoNewline -ForegroundColor Yellow
            Write-Host "$($Mon.ID)" -NoNewline -ForegroundColor Cyan
            Write-Host "]" -NoNewline -ForegroundColor yellow
            Write-Host " File: " -NoNewline -ForegroundColor DarkGray
            Write-Host "$PaddedFile" -NoNewline -ForegroundColor Green
            Write-Host " | " -NoNewline -ForegroundColor Magenta
            Write-Host "Next: " -NoNewline -ForegroundColor DarkGray
            Write-Host "[" -NoNewline -ForegroundColor Yellow;
            Write-Host "$TimeDisplay" -NoNewline -ForegroundColor Green
            Write-Host "]" -NoNewline -ForegroundColor Yellow
            Write-Host " |" -NoNewline -ForegroundColor Magenta
            Write-Host " Style: " -NoNewline -ForegroundColor DarkGray
            Write-Host "$StyleText" -ForegroundColor Green
        }

        $LogModeText = if ($Script:Config.LogToFile -and $Script:Config.LogToEventLog) { "File & EventLog" } elseif ($Script:Config.LogToFile) { "File Only" } elseif ($Script:Config.LogToEventLog) { "EventLog Only" } else { "Disabled" }
        $LogDisplayPath = if ([string]::IsNullOrEmpty($Script:Config.LogFilePath)) { "None" } else { $Script:Config.LogFilePath }
        $HistPctDisplay = if ($Script:Config.HistoryPercentage) { "$($Script:Config.HistoryPercentage)%" } else { "50%" }

        # System Status Block
        Write-Host ""
        Write-Host " ───────────────────────────────────────────────────────────────────────" -ForegroundColor Magenta
        Write-Host "  SYSTEM STATUS" -ForegroundColor Cyan
        Write-Host " ───────────────────────────────────────────────────────────────────────" -ForegroundColor Magenta

        Write-Host "  Log Target  : " -NoNewline -ForegroundColor DarkGray
        Write-Host "$LogModeText" -ForegroundColor Green

        Write-Host "  Log Path    : " -NoNewline -ForegroundColor DarkGray
        Write-Host "$LogDisplayPath" -ForegroundColor Green

        Write-Host "  History Cap : " -NoNewline -ForegroundColor DarkGray
        Write-Host "$HistPctDisplay" -ForegroundColor Green

        # Action Menu Columns
        Write-Host " ───────────────────────────────────────────────────────────────────────" -ForegroundColor Magenta
        Write-Host "  MONITOR CONTROLS                 ENGINE & LOGGING" -ForegroundColor DarkCyan
        Write-Host "  --------------------------------  ----------------------------" -ForegroundColor Magenta

        Write-Host "  [" -NoNewline -ForegroundColor Yellow; Write-Host "1" -NoNewline -ForegroundColor red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Force Next (M1)" -NoNewline -ForegroundColor White; Write-Host "               [" -NoNewline -ForegroundColor Yellow; Write-Host "7" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Cycle Log Mode" -ForegroundColor White
        Write-Host "  [" -NoNewline -ForegroundColor Yellow; Write-Host "2" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Set Source (M1)" -NoNewline -ForegroundColor White; Write-Host "               [" -NoNewline -ForegroundColor Yellow; Write-Host "8" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Alter Log Path" -ForegroundColor White
        Write-Host "  [" -NoNewline -ForegroundColor Yellow; Write-Host "3" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Set Interval (M1)" -NoNewline -ForegroundColor White; Write-Host "             [" -NoNewline -ForegroundColor Yellow; Write-Host "9" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Cycle Fit Style" -ForegroundColor White
        Write-Host "                                    [" -NoNewline -ForegroundColor Yellow; Write-Host "H" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Set History %" -ForegroundColor White
        Write-Host "  [" -NoNewline -ForegroundColor Yellow; Write-Host "4" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Force Next (M2)" -NoNewline -ForegroundColor White; Write-Host "               [" -NoNewline -ForegroundColor Yellow; Write-Host "C" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Clear History Files" -ForegroundColor White
        Write-Host "  [" -NoNewline -ForegroundColor Yellow; Write-Host "5" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Set Source (M2)               " -NoNewline -ForegroundColor White; Write-Host "SYSTEM" -ForegroundColor DarkCyan
        Write-Host "  [" -NoNewline -ForegroundColor Yellow; Write-Host "6" -NoNewline -ForegroundColor Red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Set Interval (M2)" -NoNewline -ForegroundColor White; Write-Host "             ----------------------------" -ForegroundColor Magenta
        Write-Host "                                    [" -NoNewline -ForegroundColor Yellow; Write-Host "Q" -NoNewline -ForegroundColor red; Write-Host "] " -NoNewline -ForegroundColor Yellow; Write-Host "Terminate Engine" -ForegroundColor White

        Write-Host " ═══════════════════════════════════════════════════════════════════════" -ForegroundColor Magenta
        Write-Host -NoNewline "  Fire In The Hole " -ForegroundColor Cyan; Write-Host ">: " -NoNewline -ForegroundColor Yellow
    }

    if ([Console]::KeyAvailable) {
        $Key = [Console]::ReadKey($true).KeyChar
        switch ($Key) {
            '1' { Invoke-SafeAction { Force-RotateMonitor 0 } "ForceRotateM1" }
            '2' { Invoke-SafeAction { $Script:Config.Monitors[0].Source = Read-Host "Path M1"; Save-Config $Script:Config } "SetM1Source" }
            '3' { Invoke-SafeAction { $Script:Config.Monitors[0].Interval = [int](Read-Host "Secs M1 (0 to turn Off)"); Save-Config $Script:Config } "SetM1Interval" }
            '4' { Invoke-SafeAction { Force-RotateMonitor 1 } "ForceRotateM2" }
            '5' { Invoke-SafeAction { $Script:Config.Monitors[1].Source = Read-Host "Path M2"; Save-Config $Script:Config } "SetM2Source" }
            '6' { Invoke-SafeAction { $Script:Config.Monitors[1].Interval = [int](Read-Host "Secs M2 (0 to turn Off)"); Save-Config $Script:Config } "SetM2Interval" }
            '7' { Invoke-SafeAction { Cycle-LogMode } "CycleLogMode" }
            '8' { Invoke-SafeAction { $Script:Config.LogFilePath = Read-Host "New Log Path"; Save-Config $Script:Config } "SetLogPath" }
            '9' { Invoke-SafeAction { Cycle-Styles } "CycleStyles" }
            'h' { Invoke-SafeAction { Set-HistoryPercentage } "SetHistoryPercentage" }
            'H' { Invoke-SafeAction { Set-HistoryPercentage } "SetHistoryPercentage" }
            'c' { Invoke-SafeAction { Clear-AllHistories } "ClearAllHistories" }
            'C' { Invoke-SafeAction { Clear-AllHistories } "ClearAllHistories" }

            'q' { $Running = $false }
            'Q' { $Running = $false }
        }
    }
    Start-Sleep -Milliseconds 100
}

Clear-Host
