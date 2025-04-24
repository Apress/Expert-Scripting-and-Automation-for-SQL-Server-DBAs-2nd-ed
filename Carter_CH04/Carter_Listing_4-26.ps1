$DatabaseBackupFile = "\\PrimaryServer.poshsql.com\backups\WideWorldImporters.bak"  
$LogBackupFile = "\\PrimaryServer.poshsql.com\backups\WideWorldImporters.trn"
$AGPrimaryPath = "SQLSERVER:\SQL\PrimaryServer\default\AvailabilityGroups\WideWorldImportersAG"
$  AGSecondaryPath = "SQLSERVER:\SQL\SecondaryServer\default\AvailabilityGroups\WideWorldImportersAG"
$PrimaryServerInstance = "PrimaryServer"
$SecondaryServerInstance = "SecondaryServer"

#Backup the database and log on the Primary
$BackupCommonParams = @{
    Database       = "WideWorldImporters"
    ServerInstance = $PrimaryServerInstance
}

Backup-SqlDatabase @BackupCommonParams -BackupFile $DatabaseBackupFile 
Backup-SqlDatabase @BackupCommonParams -BackupFile $LogBackupFile -BackupAction Log

#Restore the database and log on the Secondary
$RestoreCommonParams = @{
    Database       = "WideWorldImporters"
    ServerInstance = $SecondaryServerInstance
}

Restore-SqlDatabase @RestoreCommonParams -BackupFile $DatabaseBackupFile -NoRecovery
Restore-SqlDatabase @RestoreCommonParams -BackupFile $LogBackupFile -RestoreAction Log -NoRecovery

#Add the database to the Availability Group  
Add-SqlAvailabilityDatabase -Path $AGPrimaryPath -Database "WideWorldImporters"
Add-SqlAvailabilityDatabase -Path $AGSecondaryPath -Database "WideWorldImporters"
