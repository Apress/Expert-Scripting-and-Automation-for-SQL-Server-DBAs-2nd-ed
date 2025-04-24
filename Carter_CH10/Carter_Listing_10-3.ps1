$params = @{
    SqlInstance = "localhost"
    Database    = "Inventory"
    Query       = 
    "
       CREATE VIEW dbo.MaintenanceSchedule
       AS
       SELECT 
             S.ServerName + '\' + I.InstanceName AS ServerInstance
           , MT.Task
           , MT.LastExecDate
           , CASE 
                 WHEN LastExecDate IS NULL   
                     THEN GETDATE() 
                 ELSE DATEADD(MINUTE,ScheduleMinutes,LastExecDate) 
             END AS NextExecDate
           , MT.InProgress
           , MT.TaskDisabled
           , MW.StartTime
           , MW.EndTime
           , S.ServerID
           , I.InstanceID
       FROM dbo.MaintenanceTasks MT
       INNER JOIN dbo.Server S
	       ON S.ServerID = MT.ServerID
       INNER JOIN dbo.Instance I
	       ON I.InstanceID = MT.InstanceID
       INNER JOIN dbo.MaintenanceWindows MW
	       ON MW.ServerID = s.ServerID
     	           AND MW.InstanceID = I.InstanceID
	           AND (SELECT DATEPART(dw,GETDATE())) = MW.DayOfWeekNumber    
    "
}

Invoke-DbaQuery @params
