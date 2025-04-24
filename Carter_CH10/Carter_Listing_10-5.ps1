$params = @{
    SqlInstance = "localhost"
    Database    = "Inventory"
    Query       = "
       SELECT 
	       ServerInstance
	      ,Task
	      ,LastExecDate
          ,NextExecDate
	      ,InProgress
	      ,TaskDisabled
	      ,StartTime
	      ,EndTime
          ,ServerID
          ,InstanceID
      FROM dbo.MaintenanceSchedule ms
      WHERE InProgress = 0
	      AND TaskDisabled = 0
	      AND GETDATE() >= NextExecDate
	      AND CAST(GETDATE() AS TIME) BETWEEN StartTime AND EndTime
          AND Task = 'FullBackup' 
    "
}

$ServerTasks = Invoke-DbaQuery @params


foreach ($Server in $ServerTasks) {
    $params = @{
        SqlInstance = $Server.ServerInstance  
        Database    = "Master"
        Query       = "
            SELECT name FROM sys.databases WHERE database_id > 4
        "
    }
    $databases = Invoke-DbaQuery @params

    $params = @{
        SqlInstance = "localhost"
        Database    = "Inventory"
        Query       = "
            UPDATE dbo.MaintenanceTasks 
            SET InProgress = 1 
            WHERE ServerID = '" + $Server.ServerID + "' AND InstanceID = '" + $Server.InstanceID + "' AND Task = 'FullBackup'
        "
    }
    Invoke-DbaQuery @params  
    
    foreach ($database in $databases) {
        $params = @{
            SqlInstance = $Server.ServerInstance
            Database    = "Master"
            Query       = "
                BACKUP DATABASE " + $database.name + " TO DISK = 'C:\Backups\" + $database.name + ".bak'
            "
        }
        Invoke-DbaQuery @params
    }

    $params = @{
        SqlInstance = "localhost"
        Database    = "Inventory"
        Query       = "
            UPDATE dbo.MaintenanceTasks 
            SET InProgress = 0, LastExecDate = GETDATE(), LastExecStatus = 'Success'
            WHERE ServerID = '" + $Server.ServerID + "' AND InstanceID = '" + $Server.InstanceID + "' AND Task = 'FullBackup';
        "
    }
    Invoke-DbaQuery @params
}
