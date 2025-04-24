SqlSetup 'InstallInstance' {
               InstanceName = 'DSCInstance'
               Features = 'SQLENGINE'
               SourcePath = 'C:\SQL Media'
               SQLSysAdminAccounts = @('Administrator')
               ProductKey = '22222-00000-00000-00000-00000'
 }
