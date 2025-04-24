$params = @{
     SqlInstance = "localhost"
     Query = "
        CREATE SYMMETRIC KEY Inventory_Key
        WITH ALGORITHM = AES_128  
        ENCRYPTION BY CERTIFICATE Inventory
     "
     Database = "Inventory"
}

Invoke-DbaQuery @params

