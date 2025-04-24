Set-Location SQLSERVER:\SQL\localhost\Default\Databases\AdventureWorks2022\Tables

dir | where{$_.name -like "*DatabaseLog*"}

Rename-Item -LiteralPath dbo.DatabaseLog -NewName DatabaseLogPS

dir | Where-Object {$_.name -like "*DatabaseLog*"}
