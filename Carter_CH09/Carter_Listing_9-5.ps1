SqlMemory 'MinAndMaxMemory75Percent' {
            Ensure               = 'Present'
            DynamicAlloc         = $false
            MaxMemoryPercent     = 75
            MinMemoryPercent     = 75
            ServerName           = 'localhost'
            InstanceName         = $SqlInstanceName
        } 

