$FileVersion = "Version: 0.0.6"
$host.ui.RawUI.WindowTitle = "Fix-Window $FileVersion"
$BuffWidth = "300"
$BuffHeight = "2000"
$WinWidth = "120"
$WinHeight = "45"
Function FlexWindow {
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = [int]$BuffHeight
    $newsize.width = [int]$BuffWidth
    $pswindow.buffersize = $newsize
    $newsize = $pswindow.windowsize
    $newsize.height = [int]$WinHeight
    $newsize.width = [int]$WinWidth
    $pswindow.windowsize = $newsize
}
FlexWindow
FlexWindow
