$params = @{
    SqlInstance        = "localhost"
    Name               = "Inventory"
    Collation          = "Latin1_General_CI_AS"
    Owner              = "sa"
    RecoveryModel      = "Full"
    PrimaryFileSize    = "2048" #Specified in MBs
    PrimaryFileGrowth  = "1024" #Specified in MBs
    PrimaryFileMaxSize = "4096" #Specified in MBs
}

New-DbaDatabase @params
