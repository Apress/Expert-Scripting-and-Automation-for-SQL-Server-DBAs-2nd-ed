$Password = $SecurePassword = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force

$params = @{
    SqlInstance    = "localhost"
    Database       = "Inventory"
    SecurePassword = $Password
    Path           = "c:\Keys\"
}

Backup-DbaDbMasterKey @params
