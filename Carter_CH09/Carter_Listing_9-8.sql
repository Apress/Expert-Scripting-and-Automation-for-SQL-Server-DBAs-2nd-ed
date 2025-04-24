IF (SELECT COUNT(srvname) FROM sys.sysservers WHERE srvname = 'CENTRALMGMT') = 0
BEGIN
    RAISERROR ('Did not find the CENTRALMGMT linked sever', 16, 1)
END
ELSE
BEGIN
    PRINT 'Found the CENTRALMGMT linked server'
END
