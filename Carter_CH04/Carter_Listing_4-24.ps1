$params = @{
    Name     = "WinUser" 
    Path     = "SQLServer:\SQL\localhost\default"
}

Get-SqlCredential @params | Remove-SqlCredential
