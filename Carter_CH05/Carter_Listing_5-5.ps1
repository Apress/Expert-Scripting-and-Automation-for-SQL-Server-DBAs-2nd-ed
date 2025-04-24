$Variables = @{
    "Fragmentation" = "25"
    "PageSpace"     = "70"
}

$Params = @{
    SqlInstance = "localhost"
    Query          = "SELECT name FROM sys.databases"
}

$Databases = Invoke-DbaQuery @Params

foreach ($Database in $Databases) {
    $Params = @{
        SqlInstance     = "localhost"
        Database         = $Database.name
        File                  = "c:\scripts\IndexRebuild.sql"
        SqlParameters = $Variables
    }
    Invoke-DbaQuery @Params
}
