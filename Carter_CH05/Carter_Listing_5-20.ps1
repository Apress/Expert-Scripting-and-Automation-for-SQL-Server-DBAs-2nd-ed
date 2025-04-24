$user = Get-DbaDbUser -SqlInstance localhost -Database AdventureWorks2022 | Where-Object name -eq "Pete"

$params = @{
   Login = $user.Login
   Database = 'WideWorldImporters'
   SqlInstance = 'Localhost'
}
New-DbaDbUser @params 
