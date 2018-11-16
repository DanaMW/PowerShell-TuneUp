$FileVersion = "Version: 0.0.7"
$host.ui.RawUI.WindowTitle = "Fix-Window $FileVersion"
if (!($BuffHeight)) { $BuffHeight = "2000" }
if (!($BuffWidth)) { $BuffWidth = "300" }
if (!($WinHeight)) { $WinHeight = "45" }
if (!($WinWidth)) { $WinWidth = "120" }
if (!($MaxWinHeight)) { $MaxWinHeight = "50" }
if (!($MaxWinWidth)) { $MaxWinWidth = "150" }
if (!($MaxpWinHeight)) { $MaxpWinHeight = "60" }
if (!($MaxpWinWidth)) { $MaxpWinWidth = "160" }
Function FlexWindow {
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    #
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    #
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
    #
    $newsize = $pswindow.maxwindowsize
    $newsize.height = [int]$MaxWinHeight
    $newsize.width = [int]$MaxWinWidth
    $pswindow.maxwindowsize = $newsize
    #
    $newsize = $pswindow.maxphysicalwindowsize
    $newsize.height = [int]$MaxpWinHeight
    $newsize.width = [int]$MaxpWinWidth
    $pswindow.maxphysicalwindowsize = $newsize
}
FlexWindow
FlexWindow
$host.ui.RawUI
