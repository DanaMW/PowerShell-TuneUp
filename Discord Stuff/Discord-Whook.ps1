param([string]$MyArgs)
$FileVersion = "Version: 0.0.4"
if ($myargs -eq "") {
    $hookUrl = 'https://discordapp.com/api/webhooks/YourWebhookUrl'
    $title0 = $Env:USERDOMAIN
    $title = $title0.substring(0, 1).toupper() + $title0.substring(1).tolower()
    $content = @"
System Information From: $title
No value was included as a parameter.
Webhook: WzErO
"@
    $payload = [PSCustomObject]@{
        content = $content
    }
    Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'
    return
}
$TheArgs = "$myargs $args"
$hookUrl = 'https://discordapp.com/api/webhooks/471880135226949633/YourWebhookUrl'
$title0 = $Env:USERDOMAIN
$title = $title0.substring(0, 1).toupper() + $title0.substring(1).tolower()

$content = @"
System Information From: $title
$theArgs
"@

$payload = [PSCustomObject]@{
    content = $content
}
Write-Host $payload
Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'
