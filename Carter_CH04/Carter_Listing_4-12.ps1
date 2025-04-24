$Params = @{
    ServerInstance  = "localhost"
    Query                = "SELECT name FROM sys.databases"
    Username          = "Pete"
    Password           = 'Pa$$w0rd'
}

Invoke-Sqlcmd @Params
