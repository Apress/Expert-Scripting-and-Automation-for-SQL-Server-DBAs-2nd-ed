param(
    [Parameter(Mandatory=$true)]
    [string]       $InstanceName,
    [PSCredential] $SQLServiceAccountCredential = (Get-Credential -Message 'Enter the SQL service account credential'),
    [PSCredential] $AgentServiceAccountCredential = (Get-Credential -Message 'Enter the SQL Server Agent service account credential')
)

# Initialize ConnectionString variable
Write-Host 'Initialise variables...'
$serverName = $env:computername
$connectionString = '{0}\{1}' -f $serverName, $InstanceName
Write-Host 'Initialise variables complete'

#Install the instance
Write-Host 'Install the instance...'
$params = @(
    '/INSTANCENAME="{0}"' -f $InstanceName
    '/SQLSVCACCOUNT="{0}"' -f $SQLServiceAccountCredential.Username 
    '/SQLSVCPASSWORD="{0}"' -f $SQLServiceAccountCredential.GetNetworkCredential().Password 
    '/AGTSVCACCOUNT="{0}"' -f $AgentServiceAccountCredential.Username
    '/AGTSVCPASSWORD="{0}"' -f$AgentServiceAccountCredential.GetNetworkCredential().Password
    '/CONFIGURATIONFILE="C:\SQL2022\Configuration2.ini"'
)

Start-Process -FilePath 'C:\SQLServerSetup\SETUP.EXE' -ArgumentList $params -Wait -NoNewWindow
Write-Host 'Instance installation complete'

# Configure OS settings
Write-Host 'Configure OS settings...'
Start-Process -FilePath 'C:\Windows\System32\powercfg.exe' -ArgumentList '-setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' -Wait -NoNewWindow
Write-Host 'High Performance power plan configured'

Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl\ -Name Win32PrioritySeparation -Value 24      
Write-Host 'Optimise for background services configured'

# Run smoke tests
Write-Host 'Run smoke tests...'
Get-Service -DisplayName ('*{0}*' -f $InstanceName)
Write-Host 'Service running check complete'

Invoke-SqlCmd -Serverinstance $connectionString -Query "SELECT @@SERVERNAME" -TrustServerCertificate
Write-Host 'Instance accessibility check complete'
