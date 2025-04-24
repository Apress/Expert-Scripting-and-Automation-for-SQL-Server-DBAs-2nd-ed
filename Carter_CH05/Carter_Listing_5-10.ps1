$Params = @{
    SqlInstance  = "localhost"
    Query                = "SELECT name FROM sys.databases"
}

Invoke-DbaQuery @Params | ConvertTo-Csv | Out-File   -FilePath "c:\scripts\DatabasesOut.csv"

