Set-DbatoolsInsecureConnection -SessionOnly  

$params = @{
    SqlInstance = "localhost"
    Database    = "Inventory"
    Query       = "
       CREATE TABLE dbo.MaintenanceWindows (
           MaintenanceWindowID   INT      NOT NULL    PRIMARY KEY CLUSTERED,  
           ServerID                           INT      NOT NULL    FOREIGN KEY REFERENCES Server(ServerID),
           InstanceID                        INT      NOT NULL    FOREIGN KEY REFERENCES Instance(InstanceID),
           DayOfWeekNumber        INT        NOT NULL,
           StartTime                         TIME   NOT NULL,
           EndTime                          TIME   NOT NULL
       ) ;

       CREATE UNIQUE NONCLUSTERED INDEX ServerID_InstanceID_Day
	       ON dbo.MaintenanceWindows(ServerID, InstanceID, DayOfWeekNumber) ;
    "
}

Invoke-DbaQuery @params
