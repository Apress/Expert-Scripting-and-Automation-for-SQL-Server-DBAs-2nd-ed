$params = @{
    ServerInstance     = "localhost" 
    LoginName          = "POSHSQL\Pete"
    LoginType           = "WindowsUser" 
    DefaultDatabase  = "WideWorldImporters" 
    Enable                  = $true
    GrantConnectSql = $true
}

Add-SqlLogin @param
