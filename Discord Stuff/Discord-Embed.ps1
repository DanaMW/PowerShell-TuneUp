param([string]$MyArgs)
$FileVersion = "Version: 0.0.8"
$Space = "       "
$TheArgs = "$myargs $args"
$hookUrl = 'WebHook URL'
$title0 = $Env:USERDOMAIN
$title = $title0.substring(0, 1).ToUpper() + $title0.substring(1).ToLower()
if ($MyArgs -eq "") {
    $content = @"
{
 "embeds": [{
  "title": "Server Message From: $title",
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
   "title": "Server Message From: $title",
   "description": "$TheArgs",
   "color": 16711680
 }]
}
"@
    Invoke-RestMethod -Uri $hookUrl -Method Post -Body $content -ContentType 'application/json'
    return
}
#$thumbnailObject = [PSCustomObject]@{
#    url = "https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png"
#}
#"thumbnail": "$thumbnailObject"
