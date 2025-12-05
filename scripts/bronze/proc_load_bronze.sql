use Datawarehouse;
go

CREATE OR ALTER PROCEDURE bronze.load_bronze 
as
BEGIN
	DECLARE @BATCHSTARTTIME DATETIME,@BATCHENDTIME DATETIME;
	BEGIN TRY
		SET @BATCHSTARTTIME=GETDATE();
		TRUNCATE TABLE [bronze].[crm_cust_info];
		BULK INSERT [bronze].[crm_cust_info]
		FROM 'C:\Users\ttimmannapatgar\Downloads\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			 FIRSTROW=2,
			 FIELDTERMINATOR=',',
			 TABLOCK
		);

		TRUNCATE TABLE [bronze].[crm_prd_info];
		BULK INSERT [bronze].[crm_prd_info]
		FROM 'C:\Users\ttimmannapatgar\Downloads\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		TRUNCATE TABLE [bronze].[crm_sales_details];
		BULK INSERT [bronze].[crm_sales_details]
		FROM 'C:\Users\ttimmannapatgar\Downloads\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

	
		TRUNCATE TABLE [bronze].[erp_cust_az12];
		BULK INSERT [bronze].[erp_cust_az12]
		FROM 'C:\Users\ttimmannapatgar\Downloads\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);


		TRUNCATE TABLE [bronze].[erp_loc_a101];
		BULK INSERT [bronze].[erp_loc_a101]
		FROM 'C:\Users\ttimmannapatgar\Downloads\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);



		TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];
		BULK INSERT [bronze].[erp_px_cat_g1v2]
		FROM 'C:\Users\ttimmannapatgar\Downloads\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @BATCHENDTIME=GETDATE();
		PRINT '>>LOAD DURATION:'+CAST(DATEDIFF(SECOND,@BATCHSTARTTIME,@BATCHENDTIME) as nvarchar)+'seconds';
	END TRY
	BEGIN CATCH
		PRINT 'ERROR MESSAGE'+ ERROR_MESSAGE()
		PRINT 'ERROR LINE'+ CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'ERROR CODE'+ CAST(ERROR_STATE() AS NVARCHAR)
	END CATCH
END

--use this execute
EXEC bronze.load_bronze
