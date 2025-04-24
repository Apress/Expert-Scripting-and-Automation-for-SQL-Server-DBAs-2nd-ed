$Params = @{
    ServerInstance   = "localhost"
    Query                 = "SELECT name FROM sys.databases WHERE db_id = 1"
    OutputSqlErrors = $false
}

$Databases = Invoke-Sqlcmd @Params

$Params = @{
    ServerInstance   = "localhost"
    Query                 = "SELECT name FROM sys.databases WHERE db_id = 1"
    OutputSqlErrors = $true
}

$Databases = Invoke-Sqlcmd @Params
