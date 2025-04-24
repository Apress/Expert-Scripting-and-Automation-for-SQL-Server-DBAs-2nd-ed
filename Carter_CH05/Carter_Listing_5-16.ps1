$params = @{
    SqlInstance = "localhost"
    Login          = "AppLogin"
    NewLogin   = "SalesApp"
}

Rename-DbaLogin @params
