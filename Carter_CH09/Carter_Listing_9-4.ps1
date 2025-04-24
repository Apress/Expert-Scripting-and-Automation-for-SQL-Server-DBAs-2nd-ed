SqlMaxDop 'DynamicSqlMaxDop' {
            Ensure                  = 'Present'
            DynamicAlloc            = $true
            ServerName              = 'localhost'
            InstanceName            = $SqlInstanceName
        } 

