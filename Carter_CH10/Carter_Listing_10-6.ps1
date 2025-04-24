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
          AND Task = 'RemoveOldBackups' 
    "
}

$ServerTasks = Invoke-DbaQuery @params


foreach ($Server in $ServerTasks) {

    $params = @{
        SqlInstance = "localhost"
        Database    = "Inventory"
        Query       = "
            UPDATE dbo.MaintenanceTasks 
            SET InProgress = 1 
            WHERE ServerID = '" + $Server.ServerID + "' AND InstanceID = '" + $Server.InstanceID + "' AND Task = 'RemoveOldBackups'
        "
    }
    Invoke-DbaQuery @params
    
   
    foreach ($database in $databases) {  
                
        $limit = (Get-Date).AddDays(-3)
        $path = "\\" + $Server.ServerInstance.split('\')[0] + "\Backups\" 

        Get-ChildItem -Path $path | Where-Object { $_.CreationTime -lt $limit } | Remove-Item
    }

    $params = @{
        SqlInstance = "localhost"
        Database    = "Inventory"
        Query       = "
            UPDATE dbo.MaintenanceTasks 
            SET InProgress = 0, LastExecDate = GETDATE(), LastExecStatus = 'Success'
            WHERE ServerID = '" + $Server.ServerID + "' AND InstanceID = '" + $Server.InstanceID + "' AND Task = 'RemoveOldBackups';
        "
    }
    Invoke-DbaQuery @params
}
