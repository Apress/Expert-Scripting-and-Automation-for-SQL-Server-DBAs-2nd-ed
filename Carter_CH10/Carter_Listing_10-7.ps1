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
          AND Task = 'UpdateStatistics' 
    "
}

$ServerTasks = Invoke-DbaQuery @params


foreach ($Server in $ServerTasks) {
    $params = @{
        SqlInstance = $Server.ServerInstance
        Database    = "Master"
        Query       = "
            SELECT name FROM sys.databases
        "
    }
    $databases = Invoke-DbaQuery @params

    $params = @{
        SqlInstance = "localhost"
        Database    = "Inventory"
        Query       = "
            UPDATE dbo.MaintenanceTasks 
            SET InProgress = 1 
            WHERE ServerID = '" + $Server.ServerID + "' AND InstanceID = '" + $Server.InstanceID + "' AND Task = 'UpdateStats'  
        "
    }
    Invoke-DbaQuery @params  
    
   
    foreach ($database in $databases) {
        
        
        $params = @{
            SqlInstance = $Server.ServerInstance
            Database    = $database.name
            Query       = "
                EXEC sp_UpdateStatistics
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
            WHERE ServerID = '" + $Server.ServerID + "' AND InstanceID = '" + $Server.InstanceID + "' AND Task = 'UpdateStatistics';
        "
    }
    Invoke-DbaQuery @params
}
