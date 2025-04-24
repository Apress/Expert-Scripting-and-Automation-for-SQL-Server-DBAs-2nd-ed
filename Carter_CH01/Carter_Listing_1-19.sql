SELECT 
	  ExecSessions.session_id '@SessionID'
	, ExecSessions.login_name 'LoginName'
	, ExecSessions.host_name 'HostName'
	, ExecSessions.status 'Status'
	, ExecRequests.command 'Request/Command'
	, DB_NAME(ExecRequests.database_id) 'Request/Database/Name'
	, ExecRequests.last_wait_type 'Request/LastWaitReason'
FROM sys.dm_exec_sessions ExecSessions
INNER JOIN sys.dm_exec_requests ExecRequests
	ON ExecSessions.session_id = ExecRequests.session_id
WHERE ExecSessions.is_user_process = 1
FOR XML PATH('UserSession'), ROOT('Sessions')
