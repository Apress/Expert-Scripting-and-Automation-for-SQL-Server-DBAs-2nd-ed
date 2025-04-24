$SecurePassword = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force

$params = @{
    SqlInstance         = "localhost"
    Name                  = "SqlAgentCredential"
    Identity               = "Pete"
    SecurePassword  = $SecurePassword
}

New-DbaCredential @params
