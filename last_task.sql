CREATE OR ALTER PROCEDURE dbo.sp_SetOrder
    @order_id INT = NULL OUTPUT,
    @car_id INT = NULL,
    @customer_id INT = NULL,
    @order_date DATE = NULL,
    @price DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @car_id IS NULL OR @customer_id IS NULL OR @price IS NULL
        BEGIN
            PRINT 'Car ID, Customer ID, and Price are required';
            RETURN;
        END

        -- Check if car and customer exist
        IF NOT EXISTS (SELECT 1 FROM Car WHERE car_id = @car_id)
        BEGIN
            PRINT 'Invalid Car ID';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Customer WHERE customer_id = @customer_id)
        BEGIN
            PRINT 'Invalid Customer ID';
            RETURN;
        END

        -- Use current date if not provided
        SET @order_date = ISNULL(@order_date, GETDATE());

        -- Insert or Update logic
        IF @order_id IS NULL
        BEGIN
            INSERT INTO OrderDetails (car_id, customer_id, order_date, price)
            VALUES (@car_id, @customer_id, @order_date, @price);
            
            SET @order_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE OrderDetails
            SET 
                car_id = ISNULL(@car_id, car_id),
                customer_id = ISNULL(@customer_id, customer_id),
                order_date = ISNULL(@order_date, order_date),
                price = ISNULL(@price, price)
            WHERE order_id = @order_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetOrder: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Order procedure
DECLARE @new_order_id INT;
EXEC dbo.sp_SetOrder 
    @order_id = @new_order_id OUTPUT,
    @car_id = 1,
    @customer_id = 1,
    @order_date = '2024-01-20',
    @price = 20000.00;
PRINT 'New Order ID: ' + CAST(@new_order_id AS NVARCHAR(10));
GO
CREATE OR ALTER PROCEDURE dbo.sp_SetInvoice
    @invoice_id INT = NULL OUTPUT,
    @order_id INT = NULL,
    @invoice_date DATE = NULL,
    @total_amount DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @order_id IS NULL OR @total_amount IS NULL
        BEGIN
            PRINT 'Order ID and Total Amount are required';
            RETURN;
        END

        -- Check if order exists
        IF NOT EXISTS (SELECT 1 FROM OrderDetails WHERE order_id = @order_id)
        BEGIN
            PRINT 'Invalid Order ID';
            RETURN;
        END

        -- Use current date if not provided
        SET @invoice_date = ISNULL(@invoice_date, GETDATE());

        -- Insert or Update logic
        IF @invoice_id IS NULL
        BEGIN
            INSERT INTO Invoice (order_id, invoice_date, total_amount)
            VALUES (@order_id, @invoice_date, @total_amount);
            
            SET @invoice_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Invoice
            SET 
                order_id = ISNULL(@order_id, order_id),
                invoice_date = ISNULL(@invoice_date, invoice_date),
                total_amount = ISNULL(@total_amount, total_amount)
            WHERE invoice_id = @invoice_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetInvoice: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Invoice procedure
DECLARE @new_invoice_id INT;
EXEC dbo.sp_SetInvoice 
    @invoice_id = @new_invoice_id OUTPUT,
    @order_id = 1,
    @invoice_date = '2024-01-22',
    @total_amount = 20000.00;
PRINT 'New Invoice ID: ' + CAST(@new_invoice_id AS NVARCHAR(10));
GO
CREATE OR ALTER PROCEDURE dbo.sp_SetTestDrive
    @test_drive_id INT = NULL OUTPUT,
    @car_id INT = NULL,
    @customer_id INT = NULL,
    @test_drive_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @car_id IS NULL OR @customer_id IS NULL
        BEGIN
            PRINT 'Car ID and Customer ID are required';
            RETURN;
        END

        -- Check if car and customer exist
        IF NOT EXISTS (SELECT 1 FROM Car WHERE car_id = @car_id)
        BEGIN
            PRINT 'Invalid Car ID';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Customer WHERE customer_id = @customer_id)
        BEGIN
            PRINT 'Invalid Customer ID';
            RETURN;
        END

        -- Use current date if not provided
        SET @test_drive_date = ISNULL(@test_drive_date, GETDATE());

        -- Insert or Update logic
        IF @test_drive_id IS NULL
        BEGIN
            INSERT INTO TestDrive (car_id, customer_id, test_drive_date)
            VALUES (@car_id, @customer_id, @test_drive_date);
            
            SET @test_drive_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE TestDrive
            SET 
                car_id = ISNULL(@car_id, car_id),
                customer_id = ISNULL(@customer_id, customer_id),
                test_drive_date = ISNULL(@test_drive_date, test_drive_date)
            WHERE test_drive_id = @test_drive_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetTestDrive: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for TestDrive procedure
DECLARE @new_test_drive_id INT;
EXEC dbo.sp_SetTestDrive 
    @test_drive_id = @new_test_drive_id OUTPUT,
    @car_id = 1,
    @customer_id = 1,
    @test_drive_date = '2024-01-23';
PRINT 'New Test Drive ID: ' + CAST(@new_test_drive_id AS NVARCHAR(10));
GO
CREATE OR ALTER PROCEDURE dbo.sp_SetServiceAppointment
    @appointment_id INT = NULL OUTPUT,
    @car_id INT = NULL,
    @service_id INT = NULL,
    @appointment_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @car_id IS NULL OR @service_id IS NULL
        BEGIN
            PRINT 'Car ID and Service ID are required';
            RETURN;
        END

        -- Check if car and service exist
        IF NOT EXISTS (SELECT 1 FROM Car WHERE car_id = @car_id)
        BEGIN
            PRINT 'Invalid Car ID';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Service WHERE service_id = @service_id)
        BEGIN
            PRINT 'Invalid Service ID';
            RETURN;
        END

        -- Use current date if not provided
        SET @appointment_date = ISNULL(@appointment_date, GETDATE());

        -- Insert or Update logic
        IF @appointment_id IS NULL
        BEGIN
            INSERT INTO ServiceAppointment (car_id, service_id, appointment_date)
            VALUES (@car_id, @service_id, @appointment_date);
            
            SET @appointment_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE ServiceAppointment
            SET 
                car_id = ISNULL(@car_id, car_id),
                service_id = ISNULL(@service_id, service_id),
                appointment_date = ISNULL(@appointment_date, appointment_date)
            WHERE appointment_id = @appointment_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetServiceAppointment: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for ServiceAppointment procedure
DECLARE @new_appointment_id INT;
EXEC dbo.sp_SetServiceAppointment 
    @appointment_id = @new_appointment_id OUTPUT,
    @car_id = 1,
    @service_id = 1,
    @appointment_date = '2024-01-24';
PRINT 'New Service Appointment ID: ' + CAST(@new_appointment_id AS NVARCHAR(10));
GO
