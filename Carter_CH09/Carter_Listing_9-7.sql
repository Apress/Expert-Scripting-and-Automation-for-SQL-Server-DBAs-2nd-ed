SELECT srvname
FROM sys.sysservers
WHERE srvname = 'CENTRALMGMT'
FOR JSON AUTO
