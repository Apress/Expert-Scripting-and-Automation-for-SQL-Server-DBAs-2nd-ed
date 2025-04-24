SELECT 
	  ExecSessions.session_id                         '@SessionID'
	, ExecSessions.login_name                       'LoginName'
	, ExecSessions.host_name                         'HostName'
	, ExecSessions.status                                 'Status'
	, ExecRequests.command                          'Request/Command'
	, DB_NAME(ExecRequests.database_id) 'Request/Database/Name'
	, ExecRequests.last_wait_type                  'Request/LastWaitReason'
