$Variables = "Fragmentation=25", "PageSpace=70"

$Params = @{
    ServerInstance = "localhost"
    Query               = "SELECT name FROM sys.databases"
}

$Databases = Invoke-Sqlcmd @Params

foreach ($Database in $Databases) {
    $Params = @{
        ServerInstance = "localhost"
        Database          = $Database.name
        InputFile          = "c:\scripts\IndexRebuild.sql"
        Variable           = $Variables
    }
    Invoke-Sqlcmd @Params
}
