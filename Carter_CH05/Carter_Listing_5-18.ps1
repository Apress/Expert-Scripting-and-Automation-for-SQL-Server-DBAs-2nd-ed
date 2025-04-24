$params = @{
    SqlInstance = "localhost"
    Database    = "AdventureWorks2022"
    Login         = "Adam"
}

New-DbaDbUser @params
