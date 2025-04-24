$Password = 'Pa$$w0rd'

# Convert to SecureString
 $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

$params = @{
    SqlInstance         = "localhost" 
    Login                  = "Adam"
    SecurePassword  = $SecurePassword
    DefaultDatabase  = "AdventureWorks2022" 
}

New-DbaLogin @params -PasswordPolicyEnforced –PasswordExpirationEnabled

