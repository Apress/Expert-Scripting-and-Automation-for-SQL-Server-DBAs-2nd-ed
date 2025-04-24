$params = @{
    SqlInstance         = "localhost"
    Name                  = "SqlAgentProxy"
    ProxyCredential = "SQLAgentCredential"
    SubSystem          = @("PowerShell","CmdExec")
}

New-DbaAgentProxy @params
