# Return a list of running processes and then filter by the name of the process
# The chosen filter string will match executables of both Powershell 7 (pwsh) and 5 (powershell)

$process = Get-Process | Where-Object  { $_.ProcessName -like "*p*w*sh*" }

# Print the filtered list of processes to the console

$process

