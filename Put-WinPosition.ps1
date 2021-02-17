<#
  .SYNOPSIS
        Put-WinPosition.ps1
        Created By: Dana Meli
        Created Date: June, 2019
        Last Modified Date: June 03, 2019

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
        Name: Put-WinPosition
        Author: Dana Meli

  .EXAMPLE
        Put-WinPosition -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>
        Optionally
        Put-WinPosition -WinName <[String]> -WinX <[int]> -WinY <[int]> -Width <[int]> -Height <[int]>

        Set the coordinates of the window for the process you name.

#>
Param(
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
$FileVersion = "0.0.3"
if (!($WinName)) {
    Say "Usage: Put-WinPosition -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>"
    return
}
if (!($WinX)) {
    Say "Usage: Put-WinPosition -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>"
    return
}
if (!($WinY)) {
    Say "Usage: Put-WinPosition -WinName <[String] window title> -WinX <[int] position from left> -WinY <[int] position from top>"
    return
}
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
