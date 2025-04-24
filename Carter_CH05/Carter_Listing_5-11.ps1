$params = @{
    SqlInstance         = "localhost" 
    Login                  = "WIN-J38I01U06D7\Adam"
    DefaultDatabase = "AdventureWorks2022" 
}

New-DbaLogin @params
