$UserName = 'Pete'
$SecurePassword = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force

$Credential = [PSCredential]::new($UserName, $SecurePassword)

$Params = @{
    SqlInstance   = "localhost"
    Query            = "SELECT name FROM sys.databases"
    sqlCredential = $Credential
}

Invoke-DbaQuery @Params

