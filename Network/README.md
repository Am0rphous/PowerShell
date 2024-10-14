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
Expected results:
````
Pinging us.api.security.microsoft.com...
us.api.security.microsoft.com - Average Response Time: 106 ms

Pinging eu.api.security.microsoft.com...
eu.api.security.microsoft.com - Average Response Time: 24.75 ms

Pinging uk.api.security.microsoft.com...
uk.api.security.microsoft.com - Average Response Time: 31.75 ms

Pinging au.api.security.microsoft.com...
au.api.security.microsoft.com - Average Response Time: 255 ms

Pinging swa.api.security.microsoft.com...
swa.api.security.microsoft.com - Average Response Time: 28.25 ms

Pinging ina.api.security.microsoft.com...
````
