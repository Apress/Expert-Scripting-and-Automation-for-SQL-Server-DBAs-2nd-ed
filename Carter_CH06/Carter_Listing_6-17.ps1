Configuration WindowsConfig {
    param (
        [string] $SqlInstanceName = 'MSSQLSERVER',
        [Parameter(Mandatory)]
        [ValidateSet('Developer', 'Standard', 'Enterprise')]
        [string] $Edition  
    )

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'SqlServerDsc'  

    if ($Edition -eq 'Developer') {
        $ProductKey = '22222-00000-00000-00000-00000'
    } elseif ($edition -eq 'Standard') {
        $ProductKey = '00000-00000-00000-00000-00000'
    } elseif ($edition -eq 'Enterprise') {
        $ProductKey = '00000-00000-00000-00000-00000'
    }

    Node 'localhost' {
        
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

        SqlSetup 'InstallInstance' {
               InstanceName        = $SqlInstanceName
               Features            = 'SQLENGINE'
               SourcePath          = 'C:\SQL Media'
               SQLSysAdminAccounts = @('Administrator')
               ProductKey          = $ProductKey
        }

        Service SQLServerService
        {
            Name        = ‘MSSQL${0}’ -f $SqlInstanceName  
            StartupType = 'Automatic'
            State       = 'Running'
            DependsOn    = '[SqlSetup]InstallInstance'
        }
    }
}
