$params = @{
    ServerInstance = "localhost" 
    LoginName      = "*Pete*"
    Wildcard       = $true
    LoginType      = "SqlLogin" 
}

Get-SqlLogin @params | Remove-SqlLogin
