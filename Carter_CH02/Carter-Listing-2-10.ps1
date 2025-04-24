# Populate a new variable with the details all SQL Server services
$services = Get-Service | Where-Object { $_.Name -like "*SQL*" -and $_.Status -eq "Stopped" }

# Start each service

foreach ($name in $services) {
    Start-Service $name
}

