Configuration WindowsConfig {
    param (        
        [string] $SqlInstanceName = 'MSSQLSERVER',
        
        [Parameter(Mandatory)]
        [ValidateSet('Developer', 'Standard', 'Enterprise')]
        [string] $Edition  
    )

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName SqlServerDsc

    if ($Edition -eq 'Developer') {
        $ProductKey = '22222-00000-00000-00000-00000'
    } elseif ($edition -eq 'Standard') {
        $ProductKey = '00000-00000-00000-00000-00000'
    } elseif ($edition -eq 'Enterprise') {
        $ProductKey = '00000-00000-00000-00000-00000'
    }

    $serviceName = if ($SqlInstanceName -eq 'MSSQLSERVER') {
        'MSSQLSERVER'
    } else {
        'MSSQL${0}' -f $SqlInstanceName
    }  

    Node 'localhost' {
        
        #OS Resources

        File CreateCertificateBackupsFolder {
            Ensure = "Present" 
            Type = "Directory" 
            DestinationPath = "C:\CertificateBackups"
        }
        
        Registry OptimizeForBackgroundServices {
            Ensure      = "Present"  
            Key         = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"
            ValueName   = "Win32PrioritySeparation"
            ValueData   = 24
            ValueType   = 'Dword'  
        }

        #Install SQL Server

        SqlSetup 'InstallInstance' {
               InstanceName        = $SqlInstanceName
               Features            = 'SQLENGINE'
               SourcePath          = 'C:\SQL Media'
               SQLSysAdminAccounts = @('Administrator')
               ProductKey          = $ProductKey
        }

        Service SQLServerService {
            Name        = $serviceName  
            StartupType = "Automatic"
            State       = "Running"
            DependsOn   = '[SqlSetup]InstallInstance'
        }
        
        #Security Resources

        SqlConfiguration 'xpCmdshell' {
            OptionName     = 'xp_cmdshell'
            OptionValue    = 0
            RestartService = $false
            ServerName     = 'localhost'
            InstanceName   = $SqlInstanceName
            DependsOn      = '[Service]SQLServerService'
        }

        SqlConfiguration 'OLEAutomation' {
            OptionName     = 'Ole Automation Procedures'
            OptionValue    = 0
            RestartService = $false
            ServerName     = 'localhost'
            InstanceName   = $SqlInstanceName
            DependsOn      = '[Service]SQLServerService'
        }

        SqlLogin 'BuiltinAdministrators' {
            Ensure       = 'Absent'
            Name         = 'BUILTIN\Administrators'
            LoginType    = 'WindowsGroup'
            ServerName   = 'localhost'
            InstanceName = $SqlInstanceName
            DependsOn    = '[Service]SQLServerService'
        }

        #Performance Resources

        SqlMaxDop 'Set_SqlMaxDop_ToAuto' {
            Ensure                  = 'Present'
            DynamicAlloc            = $true
            ServerName              = 'localhost'
            InstanceName            = $SqlInstanceName
            DependsOn               = '[Service]SQLServerService'
        }
        
        SqlMemory 'MinAndMaxMemory75Percent' {
            Ensure               = 'Present'
            DynamicAlloc         = $false
            MaxMemoryPercent     = 75
            MinMemoryPercent     = 75
            ServerName           = 'localhost'
            InstanceName         = $SqlInstanceName
            DependsOn            = '[Service]SQLServerService'
        }

        #Operational Resources

        SqlLogin 'DBATeamLogin' {
            Ensure               = 'Present'
            Name                 = 'MyDomain\DBATeam'
            LoginType            = 'WindowsGroup'
            ServerName           = 'localhost'
            InstanceName         = $SqlInstanceName
            DependsOn            = '[Service]SQLServerService'
        }

        SqlRole 'DBATeamSysadmin' {
            Ensure               = 'Present'
            ServerRoleName       = 'sysadmin'
            Members              = 'MyDomain\DBATeam'
            ServerName           = 'localhost'
            InstanceName         = $SqlInstanceName
            DependsOn    = '[SqlLogin]DBATeamLogin'
        }

        SqlScriptQuery 'CentralMgmtLinkedServer' {
            Id                   = 'CentralMgmtLinkedServer'
            ServerName           = 'localhost'
            InstanceName         = $SqlInstanceName

            GetQuery             = @'
                SELECT srvname
                FROM sys.sysservers
                WHERE srvname = 'CENTRALMGMT'
                FOR JSON AUTO
'@


            TestQuery            = @'
                IF (SELECT COUNT(srvname) FROM sys.sysservers WHERE srvname = 'CENTRALMGMT') = 0
                BEGIN
                    RAISERROR ('Did not find the CENTRALMGMT linked sever', 16, 1)
                END
                ELSE
                BEGIN
                    PRINT 'Found the CENTRALMGMT linked server'
                END
'@

            SetQuery             = @'
                USE master
                GO

                EXEC master.dbo.sp_addlinkedserver @server = 'CENTRALMGMT', @srvproduct='SQL Server'
                GO

                EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = 'CENTRALMGMT', @locallogin = NULL , @useself = 'True'
                GO
'@

            QueryTimeout         = 30
            DependsOn            = '[Service]SQLServerService'  
        }

    }
}
