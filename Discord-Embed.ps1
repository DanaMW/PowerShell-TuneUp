FileVersion = Version: 0.0.4
param([string]$MyArgs)
if ($myargs -eq "") {
    $hookUrl = 'https://discordapp.com/api/webhooks/471880135226949633/vTOjAukMsQlrXmRD-lY_3KiQdZi602GZksE7qnywDXLHi3qOefMWkf6GhT_AFGulH6nb'
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
