$params = @{
    SqlInstance = "localhost"
    Database    = "AdventureWorks2022"
    User           = "PeteCarter"
    Role           = "db_owner"
}

Add-DbaDbRoleMember @params
