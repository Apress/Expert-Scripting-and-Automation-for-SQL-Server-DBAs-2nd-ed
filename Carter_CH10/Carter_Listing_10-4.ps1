$params = @{
    SqlInstance = "localhost"
    Database = "Inventory"
    Query       = "
                    --Insert Server/Instance Details
                    INSERT INTO dbo.Server (
	           ServerName
                        ,ClusterFlag
                        ,WindowsVersion
                        ,SQLVersion
                        ,ServerCores
                        ,ServerRAM
                        ,VirtualFlag
                        ,ApplicationOwner
                        ,ApplicationOwnerEMail)
                    VALUES (
	                     'SQL2022-STANDAL'
	                    ,0
	                    ,'Windows Server 2022 Standard'
	                    ,'SQL Server 2022 Developer Edition'
	                    ,4
	                    ,16
	                    ,1
	                    ,'Peter Carter'
	                    ,'pete@ExpertScripting.com'
                    )
                    GO

                    INSERT INTO dbo.ServiceAccount
                               (ServiceAccountName)
                         VALUES
                               ('SQLServiceAccount')
                    GO

                    INSERT INTO dbo.Instance (
                         InstanceName
                        ,ServerID
                        ,Port
                        ,IPAddress
                        ,SQLServiceAccountID
                        ,AuthenticationMode
                        ,InstanceClassification
                        ,InstanceCores
                        ,InstanceRAM
                        ,SQLServerAgentAccountID
                    )
                    VALUES (
	                     'Expert'
                        ,1
                        ,1434
                        ,'127.0.0.1'
                        ,1
                        ,0
                        ,1
                        ,2
                        ,6
                        ,1
                    ),
                    (
	                    'Scripting'
                        ,1
                        ,1435
                        ,'127.0.0.1'
                        ,1
                        ,0
                        ,1
                        ,2
                        ,6
                        ,1
                    )
                    GO

                    --Insert Maintenance Details
                    INSERT INTO dbo.MaintenanceWindows (
	           MaintenanceWindowID
                        ,ServerID
                        ,InstanceID
                        ,DayOfWeekNumber
                        ,StartTime
                        ,EndTime
                    )
                    VALUES (
	                     1
                        ,1
                        ,1
                        ,1
                        ,'00:01'
                        ,'05:00'
                    ),
                    (
	                     2
                        ,1
                        ,1
                        ,2
                        ,'00:01'
                        ,'05:00'
                    ),
                    (
	                     3
                        ,1
                        ,1
                        ,7
                        ,'06:01'
                        ,'18:00'
                    ),
                    (
	                     4
                        ,1
                        ,2
                        ,6
                        ,'00:01'
                        ,'05:00'
                    ),
                    (
	                     5
                        ,1
                        ,2
                        ,7
                        ,'06:01'
                        ,'18:00'
                    )
                    GO

                    INSERT INTO [dbo].[MaintenanceTasks] (
	           [MaintenanceTaskID]
                        ,[ServerID]
                        ,[InstanceID]
                        ,[Task]
                        ,[LastExecDate]
                        ,[Schedule]
                        ,[InProgress]
                        ,[LastExecStatus]
                        ,[TaskDisabled]
                    )
                    VALUES (
	                     1
                        ,1
                        ,1
                        ,'FullBackup'
                        ,'1900-01-01'
                        ,'Daily'
                        ,0
                        ,'Not Run'
                        ,0
                    ),
                    (
	                     2
                        ,1
                        ,1
                        ,'RemoveOldBackups'
                        ,'1900-01-01'
                        ,'Daily'
                        ,0
                        ,'Not Run'
                        ,0
                    ),
                    (
	                     3
                        ,1
                        ,1
                        ,'UpdateStats'
                        ,'1900-01-01'
                        ,'Daily'
                        ,0
                        ,'Not Run'
                        ,0
                    ),
                    (
	                     4
                        ,1
                        ,2
                        ,'FullBackup'
                        ,'1900-01-01'
                        ,'Daily'
                        ,0
                        ,'Not Run'
                        ,0
                    ),
                    (
	                     5
                        ,1
                        ,2
                        ,'RemoveOldBackups'
                        ,'1900-01-01'
                        ,'Daily'
                        ,0
                        ,'Not Run'
                        ,1
                    ),
                    (
	                     6
                        ,1
                        ,2
                        ,'UpdateStats'
                        ,'1900-01-01'
                        ,'Daily'
                        ,0
                        ,'Not Run'
                        ,1
                    )
    "
}

Invoke-DbaQuery @params
