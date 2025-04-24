$Password = 'Pa$$w0rd'

# Convert to SecureString
[securestring]$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

$params = @{
    SqlInstance          = "localhost" 
    Login                   = "Adam"
    SecurePassword  = $SecurePassword
    DefaultDatabase = "AdventureWorks2022" 
    SID                      = "0xC8105F39AEDBF947ACA0FA99544EBF33"
}

New-DbaLogin @params –Force
