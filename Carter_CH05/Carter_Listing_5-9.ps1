$query = "SELECT name, @@SERVERNAME AS SQLInstance FROM sys.databases"

"localhost", "localhost\poshscripting" | Invoke-DbaQuery -Query $query –AppendServerInstance
