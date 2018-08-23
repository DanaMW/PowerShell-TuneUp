$FileVersion = "0.0.2"
$host.ui.RawUI.WindowTitle = "System Information Version " +  $FileVersion
<# #######[Set-ConWin]###[Window Resizer]############################## #>
$tmpWidth = 107
$tmpHeight = 45
if ($tmpWidth -eq "") { $tmpWidth = 107 }
if ($tmpHeight -eq "") { $tmpHeight = 45 }
$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.buffersize
$newsize.height = 2000
$tmp = ($tmpWidth * 2)
$newsize.width = $tmp
$pswindow.buffersize = $newsize
$newsize = ($pswindow.windowsize)
$newsize.height = $tmpHeight
$newsize.width = $tmpWidth
$pswindow.windowsize = $newsize
<# ################################################################ #>
