Registry OptimizeForBackgroundServices {
            Ensure          = "Present"  
            Key               = "HHKEY_LOCAL_MACHINE:\SYSTEM\CurrentControlSet\Control\PriorityControl"
            ValueName   = "Win32PrioritySeparation"
            ValueType   = 'Dword'
            ValueData     = 24  
        }

