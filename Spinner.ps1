$FileVersion = "Version: 0.0.1"
$X = $host.ui.rawui.CursorPosition.X;
$Y = $host.ui.rawui.CursorPosition.Y;
$PShost = Get-Host
$PSWin = $PShost.ui.rawui
$PSWin.CursorSize = 0
$i = 0;
$a = "-";
$b = "/";
$c = "-";
$d = "\";
$e = "|";
while (1) {
    [Console]::SetCursorPosition($X, $Y); Say $a
    [Console]::SetCursorPosition($X, $Y); Say $b
    [Console]::SetCursorPosition($X, $Y); Say $c
    [Console]::SetCursorPosition($X, $Y); Say $d
    [Console]::SetCursorPosition($X, $Y); Say $e
    if ($host.UI.RawUI.KeyAvailable) {
        $key = $host.UI.RawUI.ReadKey("NoEcho, IncludeKeyUp, IncludeKeyDown")
        if ($key.KeyDown -eq 1) {
            [Console]::SetCursorPosition($X, $Y); Say " "
            return
        }
    }
}
$PShost = Get-Host
$PSWin = $PShost.ui.rawui
$PSWin.CursorSize = 25
[Console]::SetCursorPosition($X, $Y); Say " "
