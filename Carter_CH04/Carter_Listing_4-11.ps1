$Params = @{
    ServerInstance  = "localhost"
    Query                = "SELECT name FROM sys.databases"
}

Invoke-Sqlcmd @Params | Out-File -FilePath "c:\scripts\DatabasesOut.txt"
