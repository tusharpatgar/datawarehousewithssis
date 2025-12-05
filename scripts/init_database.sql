IF EXISTS(select 1 from sys.Databases where name='Datawarehouse')
	BEGIN
		DROP DATABASE Datawarehouse;
	END

use master;
GO 

Create database Datawarehouse;
GO

use Datawarehouse;
Go

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
