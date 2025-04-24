$params = @{
    SqlInstance = "localhost"
    Database    = "AdventureWorks2022"
    Login         = "Pete"
    User           = "PeteCarter"
}

New-DbaDbUser @params
