-- =============================================
-- Author:        [jahangir Alipournajmi]
-- Create date:   [2025-03-11]
-- Description:   This stored procedure loads data from CSV files into the bronze layer of a data warehouse.
--                It follows an ETL pattern where data from CRM and ERP systems is ingested into staging tables.
-- =============================================
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    BEGIN TRY
        -- Declare variables for tracking ingestion duration
        DECLARE @tstart_time datetime2 , @tend_time datetime2;
        SET @tstart_time = GETDATE();
        DECLARE @start_time datetime2 , @end_time datetime2;

        PRINT '******************************************************';
        PRINT 'Ingesting data into the bronze layer';
        PRINT '******************************************************';

        -- Loading CRM Tables
        PRINT '-------------------------------------------------------';
        PRINT 'Loading CRM tables';
        PRINT '-------------------------------------------------------';

        -- Ingesting Customer Info
        PRINT '>>> Truncating Table : bronze.crm_cust_info';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>>> Ingesting data into Table : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info 
        FROM 'D:\cs50\Projects\DataWarehouse-TSQL\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ' >> Ingestion duration : ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' millisecond';

        -- Ingesting Product Info
        PRINT '>>> Truncating Table : bronze.crm_prd_info';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>>> Ingesting data into Table : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'D:\cs50\Projects\DataWarehouse-TSQL\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ' >> Ingestion duration : ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' millisecond';

        -- Ingesting Sales Details
        PRINT '>>> Truncating Table : bronze.crm_sales_details';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>>> Ingesting data into Table : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\cs50\Projects\DataWarehouse-TSQL\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ' >> Ingestion duration : ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' millisecond';

        -- Loading ERP Tables
        PRINT '-------------------------------------------------------';
        PRINT 'Loading ERP tables';
        PRINT '-------------------------------------------------------';

        -- Ingesting ERP Customer Data
        PRINT '>>> Truncating Table : bronze.erp_CUST_AZ12';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_CUST_AZ12;
        PRINT '>>> Ingesting data into Table : bronze.erp_CUST_AZ12';
        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'D:\cs50\Projects\DataWarehouse-TSQL\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ' >> Ingestion duration : ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' millisecond';

        -- Ingesting ERP Location Data
        PRINT '>>> Truncating Table : bronze.erp_LOC_A101';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_LOC_A101;
        PRINT '>>> Ingesting data into Table : bronze.erp_LOC_A101';
        BULK INSERT bronze.erp_LOC_A101
        FROM 'D:\cs50\Projects\DataWarehouse-TSQL\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ' >> Ingestion duration : ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' millisecond';

        -- Ingesting ERP Product Category Data
        PRINT '>>> Truncating Table : bronze.erp_PX_CAT_G1V2';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
        PRINT '>>> Ingesting data into Table : bronze.erp_PX_CAT_G1V2';
        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'D:\cs50\Projects\DataWarehouse-TSQL\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ' >> Ingestion duration : ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' millisecond';
        
        -- Completion Message
        SET @tend_time = GETDATE();
        PRINT '==========================================================================';
        PRINT 'Ingestion into Bronze layer is completed';
        PRINT ' >> Total Ingestion duration : ' + CAST(DATEDIFF(millisecond, @tstart_time, @tend_time) AS NVARCHAR) + ' millisecond';
        PRINT '==========================================================================';
    END TRY
    BEGIN CATCH
        -- Error Handling
        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==========================================';
    END CATCH
END;
