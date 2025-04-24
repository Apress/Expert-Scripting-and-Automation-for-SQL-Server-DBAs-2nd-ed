$Password = 'Pa$$w0rd'

# Convert to SecureString
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

$params = @{
    Name     = "WinUser" 
    Identity = "POSHSQL\Pete" 
    Secret   = $SecurePassword 
    Path     = "SQLServer:\SQL\localhost\default"
}

New-SqlCredential   @params

