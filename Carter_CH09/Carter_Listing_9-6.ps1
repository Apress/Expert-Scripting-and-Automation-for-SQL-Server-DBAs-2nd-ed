SqlLogin 'DBATeamLogin' {
            Ensure               = 'Present'
            Name                 = 'MyDomain\  DBATeam'
            LoginType          = 'WindowsGroup'
            ServerName       = 'localhost'
            InstanceName    = $SqlInstanceName
        }

        SqlRole 'DBATeamSysadmin' {
            Ensure                   = 'Present'
            ServerRoleName   = 'sysadmin'
            Members  ToInclude = 'MyDomain\DBATeam'
            ServerName           = 'localhost'
            InstanceName        = $SqlInstanceName
        }

