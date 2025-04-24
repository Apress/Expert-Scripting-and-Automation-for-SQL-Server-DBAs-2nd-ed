using namespace Microsoft.SqlServer.Management.Smo

#Set Variables
$ServerInstance = "localhost"
$LoginName = "Pete"
$UserName = "Pete"
$Database = "WideWorldImporters"

#Create an SMO instance of our SQL Instance
$Server = [Server]::new($ServerInstance)

#Create an SMO instance of our Database
$Database = $Server.Databases[$Database]

#Create an SMO objecty to represent our new user and map the appropriate Login
$DbUser = [Microsoft.SqlServer.Management.Smo.User]::New($Database, $UserName)
$DbUser.Login  = $LoginName

#Use the Create method to create the Database User
$DbUser.Create()


