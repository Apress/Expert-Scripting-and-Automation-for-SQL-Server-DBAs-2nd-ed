$params = @{
    SqlInstance           = "localhost"
    Job                        = "DbaMaintenance"
    StepName             = "RebuildIndexes"
    OnSuccessAction = "QuitWithSuccess"
    OnFailAction       = "QuitWithFailure"
}

Set-DbaAgentJobStep @params
