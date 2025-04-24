$params = @{
    SqlInstance  = "localhost"
    Query        = "
USE msdb
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name='SQLMaintenance', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@owner_login_name='SQL2022-STANDAL\Administrator', @job_id = @jobId OUTPUT
SELECT @jobId
GO

EXEC msdb.dbo.sp_add_jobserver @job_name='SQLMaintenance', @server_name = 'SQL2022-STANDALONE'
GO

USE msdb
GO

EXEC msdb.dbo.sp_add_jobstep @job_name='SQLMaintenance', @step_name='FullBackups', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem='PowerShell', 
		@command='powershell ""C:\scripts\FullBackups.ps1""'
GO

USE msdb
GO

EXEC msdb.dbo.sp_add_jobstep @job_name='SQLMaintenance', @step_name='RemoveOldBackups', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem='PowerShell', 
		@command='powershell ""C:\scripts\RemoveOldBackups.ps1""'
GO

USE msdb
GO

EXEC msdb.dbo.sp_add_jobstep @job_name='SQLMaintenance', @step_name='UpdateStatistics', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem='PowerShell', 
		@command='powershell ""C:\scripts\UpdateStatistics.ps1""'
GO
USE msdb
GO
EXEC msdb.dbo.sp_update_job @job_name='SQLMaintenance', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@owner_login_name='SQL2022-STANDAL\Administrator'
GO

USE msdb
GO

DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name='SQLMaintenance', @name='MaitenanceSchedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20241020, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
GO
            "
    }
Invoke-DbaQuery @params
