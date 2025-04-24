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

                EXEC master.dbo.sp_addlinkedserver 
                   @server = 'CENTRALMGMT', 
                   @srvproduct='SQL Server'
                GO

                EXEC master.dbo.sp_addlinkedsrvlogin 
                    @rmtsrvname = 'CENTRALMGMT', 
                    @locallogin = NULL , @useself = 'True'
                GO
'@

            QueryTimeout         = 30
        } 
