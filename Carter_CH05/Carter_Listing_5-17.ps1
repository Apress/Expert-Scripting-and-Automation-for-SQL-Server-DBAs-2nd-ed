$params = @{
    SqlInstance = "localhost"
    Login          = "SalesApp"
}

Remove-DbaLogin @params
