param([string]$MyArgs)
$FileVersion = "Version: 0.0.8"
$Space = "       "
if ($myargs -eq "") {
    $hookUrl = 'WebHook URL'
    $title0 = $Env:USERDOMAIN
    $title = $title0.substring(0, 1).toupper() + $title0.substring(1).tolower()
    $content = @"
Server Message $title
No value was included as a parameter.
$Space
"@
    $payload = [PSCustomObject]@{
        content = $content
    }
    Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'
    return
}
$TheArgs = "$myargs $args"
$hookUrl = 'WebHook URL'
$title0 = $Env:USERDOMAIN
$title = $title0.substring(0, 1).toupper() + $title0.substring(1).tolower()

$content = @"
Server Message From: $title
$theArgs
$Space
"@

$payload = [PSCustomObject]@{
    content = $content
}
#Say $payload
Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'

#$thumbnailObject = [PSCustomObject]@{
#    url = "https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png"
#}
#"thumbnail": "$thumbnailObject"
