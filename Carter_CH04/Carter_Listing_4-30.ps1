$params = @{
    ConnectionString = "Server=localhost;Database=master;Trusted_Connection=True;"
    SessionName      = "system_health"
}

Read-SQLXEvent @params
