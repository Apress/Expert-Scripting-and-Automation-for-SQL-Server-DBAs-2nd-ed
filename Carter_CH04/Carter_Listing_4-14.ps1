$params = @{
    ServerInstance     = "localhost" 
    LoginName          = "Pete" 
    LoginType           = "SqlLogin" 
    DefaultDatabase  = "WideWorldImporters" 
    Enable                  = $true
    GrantConnectSql = $true
}

Add-SqlLogin @params
