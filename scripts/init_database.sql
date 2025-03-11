/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse_TSQL' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse_TSQLL' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse_TSQL' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse_TSQL')
BEGIN
    ALTER DATABASE DataWarehouse_TSQL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse_TSQL;
END;
GO

-- Create the 'DataWarehouse_TSQL' database
CREATE DATABASE DataWarehouse_TSQL;
GO

USE DataWarehouse_TSQL;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
