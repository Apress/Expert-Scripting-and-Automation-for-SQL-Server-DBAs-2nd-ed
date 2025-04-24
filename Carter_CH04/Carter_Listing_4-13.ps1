$UserName = 'Pete'
$SecurePassword = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force

$Credential = [PSCredential]::new($UserName, $SecurePassword)  

$Params = @{
    ServerInstance  = "localhost"
    Query                = "SELECT name FROM sys.databases"
    Credential         = $Credential
}

Invoke-Sqlcmd @Params
