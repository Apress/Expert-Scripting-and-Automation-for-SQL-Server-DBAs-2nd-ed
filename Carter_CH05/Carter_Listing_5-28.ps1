$commonParams = @{
    SqlInstance           = "localhost"
    Job                        = "DbaMaintenance"
    Subsystem            = "PowerShell"
    ProxyName          = "SQLAgentProxy"
    OnSuccessAction = "GoToNextStep"
    OnFailAction       = "GoToNextStep"
}
$steps = @(
    @{ StepName = 'CheckDB';          Command = 'powershell "C:\scripts\CheckDB.ps1"';            StepID = 1 }
    @{ StepName = 'RebuildIndexes'; Command = 'powershell "C:\scripts\RebuildIndexes.ps1"';   StepID = 2 }
)
foreach ($step in $steps) {
    New-DbaAgentJobStep @step @commonParams 
}
