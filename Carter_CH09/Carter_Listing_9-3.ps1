SqlLogin 'AuthenticatedUsers' {
            Ensure       = 'Absent'
            Name         = 'NT AUTHORITY\Authenticated Users'  
            LoginType    = 'WindowsGroup'
            ServerName   = 'localhost'
            InstanceName = $SqlInstanceName
        }
