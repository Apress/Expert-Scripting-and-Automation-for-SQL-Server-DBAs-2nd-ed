New-DbaAgentJobStep -SqlInstance localhost -Job DbaMaintenance -StepName CheckDB -ProxyName SQLAgentProxy -Command 'PowerShell "c:\scripts\CheckDB.ps1"' -Subsystem PowerShell -StepId 1 -OnSuccessAction GoToNextStep -OnFailAction GoToNextStep

New-DbaAgentJobStep -SqlInstance localhost -Job DbaMaintenance -StepName IndexRebuild -ProxyName SQLAgentProxy -Command 'PowerShell "c:\scripts\IndexRebuild.ps1"' -Subsystem PowerShell -StepId 2 -OnSuccessAction GoToNextStep -OnFailAction GoToNextStep 

