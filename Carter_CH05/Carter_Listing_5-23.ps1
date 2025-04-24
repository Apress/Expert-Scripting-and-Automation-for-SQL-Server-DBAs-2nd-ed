$params = @{
    SqlInstance = "localhost"
    Database    = "AdventureWorks2022"
    User           = "PeteCarter"
}

Remove-DbaDbUser @params
