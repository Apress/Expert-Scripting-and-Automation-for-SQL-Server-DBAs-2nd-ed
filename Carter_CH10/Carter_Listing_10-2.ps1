$params = @{
    SqlInstance = "localhost"
    Database    = "Inventory"
    Query       = "
       CREATE TABLE dbo.MaintenanceTasks (
           MaintenanceTaskID INT            NOT NULL    PRIMARY KEY CLUSTERED,
           ServerID                   INT            NOT NULL    FOREIGN KEY REFERENCES Server(ServerID),
           InstanceID	             INT            NOT NULL    FOREIGN KEY REFERENCES Instance(InstanceID),
           Task                          NVARCHAR(32)   NOT NULL,
           LastExecDate            DATETIME           NULL,
           Schedule                    NVARCHAR(8)    NOT NULL,
           ScheduleMinutes       AS (CASE WHEN [Schedule]='Daily' THEN (1440) WHEN [Schedule]='Weekly' THEN (10080) ELSE [Schedule] END) PERSISTED,
           InProgress                 BIT              NOT NULL,
           LastExecStatus         NCHAR(7)  NOT NULL,
           TaskDisabled            BIT              NOT NULL
) ;

CREATE UNIQUE NONCLUSTERED INDEX ServerID_InstanceID
	ON dbo.MaintenanceTasks(ServerID, InstanceID, Task) ;
    "
}

Invoke-DbaQuery @params
