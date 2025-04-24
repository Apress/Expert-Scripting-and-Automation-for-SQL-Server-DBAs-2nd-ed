$params = @{
    SqlInstance = "localhost"
    Job = "DbaMaintenance"
    Schedule = "DailyEvery5Mins" 
    FrequencyType = "Daily" 
    FrequencyInterval = "Everyday" 
    FrequencySubdayType = "Minutes" 
    FrequencySubdayInterval = 5
}

New-DbaAgentSchedule @params -force

