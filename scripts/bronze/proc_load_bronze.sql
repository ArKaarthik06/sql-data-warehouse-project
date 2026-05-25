CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

    SET NOCOUNT ON;

    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @table_start DATETIME,
        @table_end DATETIME,
        @row_count INT;

    BEGIN TRY

        SET @start_time = GETDATE();

        PRINT '=============================================';
        PRINT '      BRONZE LAYER LOADING STARTED';
        PRINT 'Start Time: ' + CAST(@start_time AS NVARCHAR);
        PRINT '=============================================';


        -------------------------------------------------
        -- LOAD CRM CUSTOMER INFO
        -------------------------------------------------

        SET @table_start = GETDATE();

        PRINT ' ';
        PRINT 'Loading Table: bronze.crm_cust_info';

        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\kaart\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @table_end = GETDATE();

        SELECT @row_count = COUNT(*)
        FROM bronze.crm_cust_info;

        PRINT 'Rows Loaded: ' + CAST(@row_count AS NVARCHAR);

        PRINT 'Load Time: ' +
              CAST(DATEDIFF(MILLISECOND, @table_start, @table_end) AS NVARCHAR)
              + ' ms';


        -------------------------------------------------
        -- LOAD CRM PRODUCT INFO
        -------------------------------------------------

        SET @table_start = GETDATE();

        PRINT ' ';
        PRINT 'Loading Table: bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\kaart\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @table_end = GETDATE();

        SELECT @row_count = COUNT(*)
        FROM bronze.crm_prd_info;

        PRINT 'Rows Loaded: ' + CAST(@row_count AS NVARCHAR);

        PRINT 'Load Time: ' +
              CAST(DATEDIFF(MILLISECOND, @table_start, @table_end) AS NVARCHAR)
              + ' ms';


        -------------------------------------------------
        -- LOAD CRM SALES DETAILS
        -------------------------------------------------

        SET @table_start = GETDATE();

        PRINT ' ';
        PRINT 'Loading Table: bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\kaart\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @table_end = GETDATE();

        SELECT @row_count = COUNT(*)
        FROM bronze.crm_sales_details;

        PRINT 'Rows Loaded: ' + CAST(@row_count AS NVARCHAR);

        PRINT 'Load Time: ' +
              CAST(DATEDIFF(MILLISECOND, @table_start, @table_end) AS NVARCHAR)
              + ' ms';


        -------------------------------------------------
        -- LOAD ERP CUSTOMER AZ12
        -------------------------------------------------

        SET @table_start = GETDATE();

        PRINT ' ';
        PRINT 'Loading Table: bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\kaart\Downloads\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @table_end = GETDATE();

        SELECT @row_count = COUNT(*)
        FROM bronze.erp_cust_az12;

        PRINT 'Rows Loaded: ' + CAST(@row_count AS NVARCHAR);

        PRINT 'Load Time: ' +
              CAST(DATEDIFF(MILLISECOND, @table_start, @table_end) AS NVARCHAR)
              + ' ms';


        -------------------------------------------------
        -- LOAD ERP LOCATION A101
        -------------------------------------------------

        SET @table_start = GETDATE();

        PRINT ' ';
        PRINT 'Loading Table: bronze.erp_loc_a101';

        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\kaart\Downloads\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @table_end = GETDATE();

        SELECT @row_count = COUNT(*)
        FROM bronze.erp_loc_a101;

        PRINT 'Rows Loaded: ' + CAST(@row_count AS NVARCHAR);

        PRINT 'Load Time: ' +
              CAST(DATEDIFF(MILLISECOND, @table_start, @table_end) AS NVARCHAR)
              + ' ms';


        -------------------------------------------------
        -- LOAD ERP PRODUCT CATEGORY
        -------------------------------------------------

        SET @table_start = GETDATE();

        PRINT ' ';
        PRINT 'Loading Table: bronze.erp_px_cat_g1v2';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\kaart\Downloads\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @table_end = GETDATE();

        SELECT @row_count = COUNT(*)
        FROM bronze.erp_px_cat_g1v2;

        PRINT 'Rows Loaded: ' + CAST(@row_count AS NVARCHAR);

        PRINT 'Load Time: ' +
              CAST(DATEDIFF(MILLISECOND, @table_start, @table_end) AS NVARCHAR)
              + ' ms';


        -------------------------------------------------
        -- TOTAL EXECUTION SUMMARY
        -------------------------------------------------

        SET @end_time = GETDATE();

        PRINT ' ';
        PRINT '=============================================';
        PRINT '      BRONZE LAYER LOADING COMPLETED';
        PRINT 'End Time: ' + CAST(@end_time AS NVARCHAR);

        PRINT 'Total Load Time: ' +
              CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
              + ' seconds';

        PRINT '=============================================';

    END TRY

    BEGIN CATCH

        PRINT ' ';
        PRINT '=============================================';
        PRINT 'ERROR OCCURRED DURING BRONZE LOAD';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);
        PRINT '=============================================';

    END CATCH

END;
GO
