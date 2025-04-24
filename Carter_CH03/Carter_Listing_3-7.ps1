$command = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
$arguments = 'Start-DscConfiguration -Path "C:\Scripts\WindowsConfig" -Verbose -Wait'
$actions = (New-ScheduledTaskAction -Execute $command -Argument $arguments )
$trigger = New-ScheduledTaskTrigger -Once -At 00:00 -RepetitionInterval (New-TimeSpan -Minutes 30)
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$principal = New-ScheduledTaskPrincipal -UserId 'Administrator' -RunLevel Highest
$task = New-ScheduledTask -Action $actions -Trigger $trigger -Settings $settings

Register-ScheduledTask 'ApplyWindowsConfig' -InputObject $task
