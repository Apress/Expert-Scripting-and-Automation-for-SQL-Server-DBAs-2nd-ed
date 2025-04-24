param(
    [string]       $InstanceName,
    [PSCredential] $SQLServiceAccountCredential,
    [PSCredential] $AgentServiceAccountCredential
)

$params = @(
    '/INSTANCENAME="{0}"' -f $InstanceName
    '/SQLSVCACCOUNT="{0}"' -f $SQLServiceAccountCredential.Username 
    '/SQLSVCPASSWORD="{0}"' -f $SQLServiceAccountCredential.GetNetworkCredential().Password 
    '/AGTSVCACCOUNT="{0}"' -f $AgentServiceAccountCredential.Username
    '/AGTSVCPASSWORD="{0}"' -f$AgentServiceAccountCredential.GetNetworkCredential().Password
    '/CONFIGURATIONFILE="C:\SQL2022\Configuration2.ini"'
)

Start-Process -FilePath 'C:\SQLServerSetup\SETUP.EXE' -ArgumentList $params -Wait -NoNewWindow

