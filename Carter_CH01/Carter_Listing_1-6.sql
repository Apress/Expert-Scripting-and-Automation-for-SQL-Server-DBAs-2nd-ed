SELECT 
	  ExecSessions.session_id
	, ExecSessions.login_name
	, ExecSessions.host_name
	, ExecSessions.status
	, ExecRequests.command
	, DB_NAME(ExecRequests.database_id) AS DatabaseName
	, ExecRequests.last_wait_type
FROM sys.dm_exec_sessions ExecSessions
INNER JOIN sys.dm_exec_requests ExecRequests
	ON ExecSessions.session_id = ExecRequests.session_id
WHERE ExecSessions.is_user_process = 1
FOR XML RAW
