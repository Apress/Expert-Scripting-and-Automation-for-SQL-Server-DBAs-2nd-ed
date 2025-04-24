using namespace Microsoft.SqlServer.Management.Smo

#Set variables
$ServerInstance = "localhost"
$LoginName = "Pete"
$Role = "dbcreator"

#Create an SMO instance of our SQL Instance
$Server = [Server]::new($ServerInstance)

#Traverse the instance for find the role
$ServerRole = $Server. Roles[$Role]

#Add the Login to the server role
$ServerRole.AddMember($LoginName)

