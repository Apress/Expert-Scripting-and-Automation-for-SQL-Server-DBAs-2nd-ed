Configuration WindowsConfig {
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node 'localhost' {
        
        File CreateCertificateBackupsFolder {
            Ensure = "Present" 
            Type = "Directory" 
            DestinationPath = "C:\CertificateBackups"
        }
        
        Registry OptimizeForBackgroundServices {
            Ensure      = "Present"  
            Key         = "HKEY_LOCAL_MACHINE:\SYSTEM  \CurrentControlSet\Control\PriorityControl"
            ValueName   = "Win32PrioritySeparation"
            ValueType   = 'Dword'
            ValueData   = 24  
        }

        Service SQLServerService
        {
            Name        = "MSSQLSERVER"
            StartupType = "Automatic"
            State       = "Running"
        }
    }
}

WindowsConfig

