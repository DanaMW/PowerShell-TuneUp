param([string]$MyArgs)
$FileVersion = "Version: 0.0.6"
$TheArgs = "$myargs $args"
$hookUrl = 'https://discordapp.com/api/webhooks/YourWebHookURLHere'
$title0 = $Env:USERDOMAIN
$title = $title0.substring(0, 1).toupper() + $title0.substring(1).tolower()
if ($MyArgs -eq "") {
    $content = @"
{
 "embeds": [{
   "title": "System Information $FileVersion From: $title",
   "description": "Error: No value was included as a parameter",
   "color": 16711680
 }]
}
"@
    Invoke-RestMethod -Uri $hookUrl -Method Post -Body $content -ContentType 'application/json'
    return
}
else {
    $content = @"
{
 "embeds": [{
   "title": "System Information $FileVersion From: $title",
   "description": "$TheArgs",
   "color": 16711680
 }]
}
"@
    Invoke-RestMethod -Uri $hookUrl -Method Post -Body $content -ContentType 'application/json'
    return
}
