$parameters   = @{
	ServerInstance = ‘localhost\SCRIPTING2’
	TrustServerCertificate = $true
               Query               = “
		SELECT 
  @@SERVERNAME
, @@VERSION
“
}

Invoke-sqlcmd @parameters   | Format-List
