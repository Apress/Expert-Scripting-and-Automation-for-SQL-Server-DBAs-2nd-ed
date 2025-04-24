$UserName = 'Pete'
$Password = 'Pa$$w0rd'

# Convert to SecureString
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

#Create The psCredential object
$LoginCredential = [PSCredential]::new($UserName, $SecurePassword) 

$params = @{
    ServerInstance                                  = "localhost" 
    LoginPsCredential                            = $LoginCredential
    LoginType                                        = "SqlLogin" 
    DefaultDatabase                               = "WideWorldImporters" 
    Enable                                               = $true
    GrantConnectSql                              = $true
    MustChangePasswordAtNextLogin = $true
}

Add-SqlLogin @params

