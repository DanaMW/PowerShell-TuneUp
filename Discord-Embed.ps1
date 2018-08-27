param([string]$MyArgs)
$FileVersion = "Version: 0.0.4"
if ($myargs -eq "") {
    $hookUrl = 'https://discordapp.com/api/webhooks/Your Webhook Url here'
    $title0 = $Env:USERDOMAIN
    $title = $title0.substring(0, 1).toupper() + $title0.substring(1).tolower()

    $content = @"
{
 "embeds": [{
   "title": "$FileVersion System Information From: $title",
   "description": "Error: No value was included as a parameter",
   "color": 16711680
 }]
}
"@
    Invoke-RestMethod -Uri $hookUrl -Method Post -Body $content
    return
}
