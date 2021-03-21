$MyArgs = "$args"
$Moo = "$MyArgs".split(" ")
$Method = $Moo[0]
$Url = $Moo[1]
$FileVersion = "0.0.5"
Say "Edit SiteHost $FileVersion"
if (!($MyArgs)) {
    Say -ForegroundColor red "No Arguments provided. Stop wasting my time man. Try this..."
    Say -ForegroundColor yellow "Edit-SiteHost Add/Remove/View <site_to_add/remove>"
    break
}
if ($Method -eq "View") {
    $hosts = 'C:\Windows\System32\drivers\etc\hosts';
    Say " "
    $ip_isView = Get-Content -Path $hosts | ForEach-Object { Say $_ }
    Say " "
}
if ($Method -eq "Add") {
    Say "Adding $Url to the host file as a BLOCK"
    $hosts = 'C:\Windows\System32\drivers\etc\hosts';
    $is_blocked = Get-Content -Path $hosts | Select-String -Pattern ([regex]::Escape($Url))
    If (-not $is_blocked) {
        $hoststr = "127.0.0.1 $Url"
        Add-Content -Path $hosts -Value $hoststr
    }
    Say "This system now blocking $Url"
}
if ($Method -eq "Remove") {
    Say "Removing $Url from the host file."
    # Function UnBlockSiteHosts ( [Parameter(Mandatory = $true)]$Url) {
    $hosts = 'C:\Windows\System32\drivers\etc\hosts'
    $is_blocked = Get-Content -Path $hosts | Select-String -Pattern ([regex]::Escape($Url))
    If ($is_blocked) {
        $newhosts = Get-Content -Path $hosts |
        Where-Object {
            $_ -notmatch ([regex]::Escape($Url))
        }
        Set-Content -Path $hosts -Value $newhosts
    }
    Say "No longer blocking $Url"
}
