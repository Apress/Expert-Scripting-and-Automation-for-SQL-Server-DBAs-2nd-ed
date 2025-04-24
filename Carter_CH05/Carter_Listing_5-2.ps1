$Params = @{
    SqlInstance   = "localhost"
    Query            = "SELECT name FROM sys.databases"
}

Invoke-dbaquery @Params
