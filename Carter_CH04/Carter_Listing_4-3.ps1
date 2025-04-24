$Params = @{
    ServerInstance = "localhost"
    Query               = "SELECT name FROM sys.databases"
}

$Databases = Invoke-Sqlcmd @Params
