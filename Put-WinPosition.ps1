<#
.SYNOPSIS
    Put-WinPosition.ps1
    Created By: Dana Meli-Wischman
    Created Date: June, 2019

.DESCRIPTION
    Sets start coordinates (x,y) and window size (Width, Height) for target
    windows. Isolates buffer pre-allocation specifically to Windows Terminal hosts.

.PARAMETER WinName
    The exact or partial window title to position.

.PARAMETER WinX
    Position of the window in pixels from the left edge.

.PARAMETER WinY
    Position of the window in pixels from the top edge.

.PARAMETER Width
    Desired width of the window in pixels.

.PARAMETER Height
    Desired height of the window in pixels.
#>
[CmdletBinding()]
param(
      [Parameter(Position = 0, Mandatory = $true)]
      [ValidateNotNullOrEmpty()]
      [string]$WinName,

      [Parameter(Position = 1, Mandatory = $true)]
      [int]$WinX,

      [Parameter(Position = 2, Mandatory = $true)]
      [int]$WinY,

      [Parameter(Position = 3, Mandatory = $false)]
      [int]$Width,

      [Parameter(Position = 4, Mandatory = $false)]
      [int]$Height
)

$FileVersion = "0.1.1"
$FileDate = "10-01-2026"

if (-not ([System.Management.Automation.PSTypeName]'Win32NativeWindow').Type) {
      Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    using System.Text;

    public struct RECT {
        public int Left;
        public int Top;
        public int Right;
        public int Bottom;
    }

    public class Win32NativeWindow {
        public static readonly IntPtr HWND_TOP = new IntPtr(0);
        public const uint SWP_NOZORDER = 0x0004;
        public const uint SWP_SHOWWINDOW = 0x0040;

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

        [DllImport("user32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

        public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);

        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);

        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool IsWindowVisible(IntPtr hWnd);

        [DllImport("user32.dll")]
        public static extern IntPtr GetAncestor(IntPtr hWnd, uint flags);
        public const uint GA_ROOT = 2;
    }
"@
}

# Determine if the target session is Windows Terminal
$isWindowsTerminal = [bool]$env:WT_SESSION

# Search window handle
$hWnd = [IntPtr]::Zero

if ($isWindowsTerminal) {
      # Target top-level Cascadia window class directly for WT
      $hWnd = [Win32NativeWindow]::FindWindow("CASCADIA_HOSTING_WINDOW_CLASS", $null)
}

if ($hWnd -eq [IntPtr]::Zero) {
      $hWnd = [Win32NativeWindow]::FindWindow($null, $WinName)
}

if ($hWnd -eq [IntPtr]::Zero) {
      $foundHandle = [IntPtr]::Zero
      $enumProc = [Win32NativeWindow+EnumWindowsProc] {
            param($currentHandle, $lParam)

            if ([Win32NativeWindow]::IsWindowVisible($currentHandle)) {
                  $sbTitle = New-Object System.Text.StringBuilder 256
                  [void][Win32NativeWindow]::GetWindowText($currentHandle, $sbTitle, $sbTitle.Capacity)

                  $sbClass = New-Object System.Text.StringBuilder 256
                  [void][Win32NativeWindow]::GetClassName($currentHandle, $sbClass, $sbClass.Capacity)

                  if ($sbClass.ToString() -notin @("Windows.UI.Core.CoreWindow", "CamlIslandWindow")) {
                        if ($sbTitle.ToString() -like "*$WinName*") {
                              $script:foundHandle = [Win32NativeWindow]::GetAncestor($currentHandle, [Win32NativeWindow]::GA_ROOT)
                              return $false
                        }
                  }
            }
            return $true
      }

      [Win32NativeWindow]::EnumWindows($enumProc, [IntPtr]::Zero) | Out-Null
      $hWnd = $foundHandle
}

if ($hWnd -eq [IntPtr]::Zero) {
      Write-Error "Could not find window matching: '$WinName'"
      return
}

# Get current window metrics
$rcWindow = New-Object RECT
[void][Win32NativeWindow]::GetWindowRect($hWnd, [ref]$rcWindow)

if (-not $PSBoundParameters.ContainsKey('Width')) { $Width = $rcWindow.Right - $rcWindow.Left }
if (-not $PSBoundParameters.ContainsKey('Height')) { $Height = $rcWindow.Bottom - $rcWindow.Top }

# Execute buffer adjustment ONLY on Windows Terminal sessions to prevent cursor overflow
if ($isWindowsTerminal) {
      try {
            $rawUI = $Host.UI.RawUI
            $currentBuffer = $rawUI.BufferSize

            # Estimate character bounds (standard 8x16 px rendering)
            $targetCols = [Math]::Max($currentBuffer.Width, [int]($Width / 8))
            $targetRows = [Math]::Max($currentBuffer.Height, [int]($Height / 16))

            $rawUI.BufferSize = New-Object System.Management.Automation.Host.Size($targetCols, $targetRows)
      }
      catch {
            # Catch non-fatal host bounds restrictions in WT
      }
}

# Apply Win32 position and size
$flags = [Win32NativeWindow]::SWP_NOZORDER -bor [Win32NativeWindow]::SWP_SHOWWINDOW
[void][Win32NativeWindow]::SetWindowPos($hWnd, [Win32NativeWindow]::HWND_TOP, $WinX, $WinY, $Width, $Height, $flags)


<#
  .SYNOPSIS
        Put-WinPosition.ps1
        Created By: Dana Meli-Wischman
        Created Date: June, 2019

  .DESCRIPTION
        Sets the start coordinates (x,y) of a named window and optionally
        window size (Width,height) a named process window.

  .PARAMETER WinName
        The window title of the window you want to reposition

  .PARAMETER WinX
        Set the position of the window in pixels from the left.

  .PARAMETER WinY
        Set the position of the window in pixels from the top.

  .PARAMETER Width
        Set the right position of the window in pixels from X.

  .PARAMETER Height
        Set the bottom position of the window in pixels from Y.

  .NOTES
        Name: Put-WinPosition.ps1
        Author: Dana L. Meli-Wischman

  .EXAMPLE
        Put-WinPosition.ps1 -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>
        Optionally
        Put-WinPosition.ps1 -WinName <[String]> -WinX <[int]> -WinY <[int]> -Width <[int]> -Height <[int]>

        Set the coordinates of the window for the process you name.

#>
<#
param(
      [Parameter(Position = 0, mandatory = $true)]
      [String]$WinName,
      [Parameter(Position = 1, mandatory = $true)]
      [int]$WinX,
      [Parameter(Position = 2, mandatory = $true)]
      [int]$WinY,
      [Parameter(Position = 3, mandatory = $false)]
      [int]$Width,
      [Parameter(Position = 4, mandatory = $false)]
      [int]$height)
if (!($WinName)) {
      Say "Usage: Put-WinPosition.ps1 -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>"
      return
}
if (!($WinX)) {
      Say "Usage: Put-WinPosition.ps1 -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>"
      return
}
if (!($WinY)) {
      Say "Usage: Put-WinPosition.ps1 -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>"
      return
}
$FileVersion = "0.0.5"
$FileDate = "09-20-2026"
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public class Win32 {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public extern static bool MoveWindow(IntPtr handle, int x, int y, int width, int height, bool redraw);
  }
  public struct RECT
  {
    public int Left;        // x position of upper-left corner
    public int Top;         // y position of upper-left corner
    public int Right;       // x position of lower-right corner
    public int Bottom;      // y position of lower-right corner
  }
"@
$rcWindow = New-Object RECT
$h = (Get-Process | Where-Object { $_.MainWindowTitle -eq $WinName }).MainWindowHandle
[Win32]::GetWindowRect($h, [ref]$rcWindow)
if (!($Width)) { $Width = ($rcWindow.Right - $rcWindow.Left) }
if (!($Height)) { $Height = ($rcWindow.Bottom - $rcWindow.Top) }
[Win32]::MoveWindow($h, $WinX, $WinY, $Width, $Height, $true )
#>
