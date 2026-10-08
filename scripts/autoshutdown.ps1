$ESP_IP = "192.168.1.x"
$WEBHOOK_URL = "https://discord.com/api/webhooks/*****/*****"
$MAX_RETRIES = 10
$WAIT_TIME = 5

while ($true) {
    $attempt = 0
    while (\(attempt -lt\)MAX_RETRIES) {
        \(ping = Test-Connection -ComputerName\)ESP_IP -Count 1 -Quiet
        
        if ($ping) {
            Write-Output "Ping successful."
            break
        } else {
            $attempt++
            Write-Output "Ping failed. Attempt \(attempt of\)MAX_RETRIES."
            if (\(attempt -lt\)MAX_RETRIES) {
                Start-Sleep -Seconds $WAIT_TIME
            }
        }
    }

    if (\(attempt -eq\)MAX_RETRIES) {
        Write-Output "All attempts failed. Shutting down..."
        
        $payload = @{
            content = "@everyone`nWindows Server is shutting down!!" # could be adjusted to @engineers
            embeds = $null
            attachments = @()
        } | ConvertTo-Json -Depth 3

        Invoke-RestMethod -Uri \(WEBHOOK_URL -Method Post -Body\)payload -ContentType "application/json"
        
        Stop-Computer -Force
    }

    Start-Sleep -Seconds 30
}
