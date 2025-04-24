param(
    [string]       $InstanceName,
    [PSCredential] $SQLServiceAccountCredential,
    [PSCredential] $AgentServiceAccountCredential
)

# Initialize ConnectionString variable
$serverName = $env:computername
$connectionString = '{0}\{1}' -f $serverName, $InstanceName

#Install the instance
$params = @(
    '/INSTANCENAME="{0}"' -f $InstanceName
    '/SQLSVCACCOUNT="{0}"' -f $SQLServiceAccountCredential.Username 
    '/SQLSVCPASSWORD="{0}"' -f $SQLServiceAccountCredential.GetNetworkCredential().Password 
    '/AGTSVCACCOUNT="{0}"' -f $AgentServiceAccountCredential.Username
    '/AGTSVCPASSWORD="{0}"' -f$AgentServiceAccountCredential.GetNetworkCredential().Password
    '/CONFIGURATIONFILE="C:\SQL2022\Configuration2.ini"'
)

Start-Process -FilePath 'C:\SQLServerSetup\SETUP.EXE' -ArgumentList $params -Wait -NoNewWindow

# Configure OS settings
Start-Process -FilePath 'C:\Windows\System32\powercfg.exe' -ArgumentList '-setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' -Wait -NoNewWindow
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl\ -Name Win32PrioritySeparation -Value 24      

# Run smoke tests
Get-Service -DisplayName ('*{0}*' -f $InstanceName)
Invoke-SqlCmd -Serverinstance $connectionString -Query "SELECT @@SERVERNAME" -TrustServerCertificate
