Configuration WindowsConfig {
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'SqlServerDsc'  

    Node 'localhost' {
        
        File CreateCertificateBackupsFolder {
            Ensure = "Present" 
            Type = "Directory" 
            DestinationPath = "C:\CertificateBackups"
        }
        
        Registry OptimizeForBackgroundServices {
            Ensure      = "Present"  
            Key         = " HKEY_LOCAL_MACHINE:  \SYSTEM\CurrentControlSet\Control\PriorityControl"
            ValueName   = "Win32PrioritySeparation"
            ValueData   = 24
            ValueType   = 'Dword'
        }

        SqlSetup 'InstallInstance' {
               InstanceName        = 'DSCInstance'
               Features            = 'SQLENGINE'
               SourcePath          = 'C:\SQL Media'
               SQLSysAdminAccounts = @('Administrator')
               ProductKey          = '22222-00000-00000-00000-00000'
        }

        Service SQLServerService
        {
            Name        = 'MSSQL$DSCInstance'  
            StartupType = 'Automatic'
            State       = 'Running'
            DependsOn    = '[SqlSetup]InstallInstance'
        }
    }
}

WindowsConfig
