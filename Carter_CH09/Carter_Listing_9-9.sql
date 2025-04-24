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
