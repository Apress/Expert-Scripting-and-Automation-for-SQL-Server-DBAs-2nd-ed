$Password = $SecurePassword = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force

$params = @{
    SqlInstance        = "localhost"
    Database           = "Inventory"
    EncryptionPassword = $Password
    DecryptionPassword = $Password
    Path               = "C:\Keys\"
}

Backup-DbaDbCertificate @params
