<# You can just run this in a console window PS-Core 6.X up
It is designed to paste into your script then you call to it
"FlexWindow" I call it like 3 or 4 times to complete
the window adjustment. Never gets it on the first call.
#>
$FileVersion = "0.0.9"
$host.ui.RawUI.WindowTitle = "Fix-Window $FileVersion"
if (!($WinHeight)) { $WinHeight = "45" }
if (!($WinWidth)) { $WinWidth = "120" }
#if (!($BuffHeight)) { $BuffHeight = "2000" }
#if (!($BuffWidth)) { $BuffWidth = "300" }
if (!($BuffHeight)) { $BuffHeight = $WinHeight }
if (!($BuffWidth)) { $BuffWidth = $WinWidth }
Function FlexWindow {
    $SaveError = "$ErrorActionPreference"
    $ErrorActionPreference = "SilentlyContinue"
    $pshost = Get-Host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
    <#  THESE ARE READ ONLY OPTIONS #>
    $height = (Get-Host).UI.RawUI.MaxWindowSize.Height
    $width = (Get-Host).UI.RawUI.MaxWindowSize.Width
    $ErrorActionPreference = "$SaveError"
}
FlexWindow
Say $height
Say $width
$host.ui.RawUI
