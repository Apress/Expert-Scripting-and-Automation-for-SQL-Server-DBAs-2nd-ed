$GetDatabaseParams = @{
    SqlInstance = "localhost"
    Query       = "
                   SELECT name
                   FROM sys.databases
                   WHERE database_id > 4
                   "
}

$databases = Invoke-DbaQuery @GetDatabaseParams | Select-Object -ExpandProperty Name

$params = @{
    SqlInstance = "localhost"
    Query       = "
                  DECLARE @SQL NVARCHAR(MAX)

                  SET @SQL = (
                      SELECT 'ALTER INDEX '
                          + QUOTENAME(i.name)
                          + ' ON ' + s.name
                          + '.'
                          + QUOTENAME(OBJECT_NAME(i.object_id))
                          + ' REBUILD ; '
                      FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'DETAILED') ps
                      INNER JOIN sys.indexes i
                          ON ps.object_id = i.object_id
                          AND ps.index_id = i.index_id
                      INNER JOIN sys.objects o
                          ON ps.object_id = o.object_id
                      INNER JOIN sys.schemas s
                          ON o.schema_id = s.schema_id
                      WHERE index_level = 0
                          AND avg_fragmentation_in_percent > 25
                      FOR XML PATH('')
                  ) ;
                 EXEC(@SQL) ;
                 "
}

foreach ($database in $databases) {
    Invoke-DbaQuery @params -Database $database
}
