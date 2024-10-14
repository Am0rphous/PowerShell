# Network


## Find best server based on latency
````powershell
$servers = @(
    "us.api.security.microsoft.com",
    "eu.api.security.microsoft.com",
    "uk.api.security.microsoft.com",
    "au.api.security.microsoft.com",
    "swa.api.security.microsoft.com",
    "ina.api.security.microsoft.com"
)

foreach ($server in $servers) {
    Write-Host "Pinging $server..."
    $pingResult = Test-Connection -ComputerName $server -Count 4 -ErrorAction SilentlyContinue
    if ($pingResult) {
        $avgResponseTime = ($pingResult | Measure-Object ResponseTime -Average).Average
        Write-Host "$server - Average Response Time: $avgResponseTime ms"
    } else {
        Write-Host "$server - Ping failed"
    }
    Write-Host ""
}
````
