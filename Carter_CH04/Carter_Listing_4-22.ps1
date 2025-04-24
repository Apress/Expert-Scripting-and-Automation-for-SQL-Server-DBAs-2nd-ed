using namespace Microsoft.SqlServer.Management.Smo

#Set Variables
$ServerInstance = "localhost"
$UserName = "Pete"
$Database = "WideWorldImporters"
$Role = "db_datareader"

#Create an SMO instance of our SQL Instance
$Server = [Server]::new($ServerInstance)

#Create an SMO instance of our Database
$Database = $Server.Databases[$Database]

#Create an SMO objecty to represent our user
$DbUser = $Database.Users[$UserName]

#Use the Create method to create the Database User
$DbUser.AddToRole($Role)

