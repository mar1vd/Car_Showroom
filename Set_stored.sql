-- Stored Procedure for Car Table
CREATE OR ALTER PROCEDURE dbo.sp_SetCar
    @car_id INT = NULL OUTPUT,
    @model NVARCHAR(100) = NULL,
    @brand NVARCHAR(100) = NULL,
    @year INT = NULL,
    @price DECIMAL(10, 2) = NULL,
    @color NVARCHAR(50) = NULL,
    @status NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @model IS NULL OR @brand IS NULL
        BEGIN
            PRINT 'Model and brand are required';
            RETURN;
        END

        IF @year IS NOT NULL AND (@year < 1900 OR @year > YEAR(GETDATE()) + 1)
        BEGIN
            PRINT 'Invalid year';
            RETURN;
        END

        IF @price IS NOT NULL AND @price < 0
        BEGIN
            PRINT 'Price cannot be negative';
            RETURN;
        END

        -- Insert or Update logic
        IF @car_id IS NULL
        BEGIN
            INSERT INTO Car (model, brand, year, price, color, status)
            VALUES (@model, @brand, @year, @price, @color, @status);
            
            SET @car_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Car
            SET 
                model = ISNULL(@model, model),
                brand = ISNULL(@brand, brand),
                year = ISNULL(@year, year),
                price = ISNULL(@price, price),
                color = ISNULL(@color, color),
                status = ISNULL(@status, status)
            WHERE car_id = @car_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetCar: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Car procedure
DECLARE @new_car_id INT;
EXEC dbo.sp_SetCar 
    @car_id = @new_car_id OUTPUT,
    @model = 'Model 3',
    @brand = 'Tesla',
    @year = 2024,
    @price = 45000.00,
    @color = 'Silver',
    @status = 'available';
PRINT 'New Car ID: ' + CAST(@new_car_id AS NVARCHAR(10));
GO

-- Stored Procedure for Customer Table
CREATE OR ALTER PROCEDURE dbo.sp_SetCustomer
    @customer_id INT = NULL OUTPUT,
    @first_name NVARCHAR(100) = NULL,
    @last_name NVARCHAR(100) = NULL,
    @phone NVARCHAR(20) = NULL,
    @email NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @first_name IS NULL OR @last_name IS NULL
        BEGIN
            PRINT 'First name and last name are required';
            RETURN;
        END

        IF @email IS NOT NULL AND @email NOT LIKE '%_@__%.__%'
        BEGIN
            PRINT 'Invalid email format';
            RETURN;
        END

        -- Insert or Update logic
        IF @customer_id IS NULL
        BEGIN
            INSERT INTO Customer (first_name, last_name, phone, email)
            VALUES (@first_name, @last_name, @phone, @email);
            
            SET @customer_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Customer
            SET 
                first_name = ISNULL(@first_name, first_name),
                last_name = ISNULL(@last_name, last_name),
                phone = ISNULL(@phone, phone),
                email = ISNULL(@email, email)
            WHERE customer_id = @customer_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetCustomer: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Customer procedure
DECLARE @new_customer_id INT;
EXEC dbo.sp_SetCustomer 
    @customer_id = @new_customer_id OUTPUT,
    @first_name = 'Mariia',
    @last_name = 'Shevchenko',
    @phone = '380991234567',
    @email = 'mariia@example.com';
PRINT 'New Customer ID: ' + CAST(@new_customer_id AS NVARCHAR(10));
GO

-- Stored Procedure for Employee Table
CREATE OR ALTER PROCEDURE dbo.sp_SetEmployee
    @employee_id INT = NULL OUTPUT,
    @first_name NVARCHAR(100) = NULL,
    @last_name NVARCHAR(100) = NULL,
    @position NVARCHAR(100) = NULL,
    @salary DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @first_name IS NULL OR @last_name IS NULL
        BEGIN
            PRINT 'First name and last name are required';
            RETURN;
        END

        IF @salary IS NOT NULL AND @salary < 0
        BEGIN
            PRINT 'Salary cannot be negative';
            RETURN;
        END

        -- Insert or Update logic
        IF @employee_id IS NULL
        BEGIN
            INSERT INTO Employee (first_name, last_name, position, salary)
            VALUES (@first_name, @last_name, @position, @salary);
            
            SET @employee_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Employee
            SET 
                first_name = ISNULL(@first_name, first_name),
                last_name = ISNULL(@last_name, last_name),
                position = ISNULL(@position, position),
                salary = ISNULL(@salary, salary)
            WHERE employee_id = @employee_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetEmployee: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Employee procedure
DECLARE @new_employee_id INT;
EXEC dbo.sp_SetEmployee 
    @employee_id = @new_employee_id OUTPUT,
    @first_name = 'Petro',
    @last_name = 'Kovalchuk',
    @position = 'Sales Representative',
    @salary = 45000.00;
PRINT 'New Employee ID: ' + CAST(@new_employee_id AS NVARCHAR(10));
GO

-- Stored Procedure for Service Table
CREATE OR ALTER PROCEDURE dbo.sp_SetService
    @service_id INT = NULL OUTPUT,
    @service_name NVARCHAR(100) = NULL,
    @price DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @service_name IS NULL
        BEGIN
            PRINT 'Service name is required';
            RETURN;
        END

        IF @price IS NOT NULL AND @price < 0
        BEGIN
            PRINT 'Price cannot be negative';
            RETURN;
        END

        -- Insert or Update logic
        IF @service_id IS NULL
        BEGIN
            INSERT INTO Service (service_name, price)
            VALUES (@service_name, @price);
            
            SET @service_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Service
            SET 
                service_name = ISNULL(@service_name, service_name),
                price = ISNULL(@price, price)
            WHERE service_id = @service_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetService: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Service procedure
DECLARE @new_service_id INT;
EXEC dbo.sp_SetService 
    @service_id = @new_service_id OUTPUT,
    @service_name = 'Engine Diagnostic',
    @price = 75.00;
PRINT 'New Service ID: ' + CAST(@new_service_id AS NVARCHAR(10));
GO

-- Stored Procedure for OrderDetails Table
CREATE OR ALTER PROCEDURE dbo.sp_SetOrderDetails
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

        IF @price IS NOT NULL AND @price < 0
        BEGIN
            PRINT 'Price cannot be negative';
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
        PRINT 'Error in sp_SetOrderDetails: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for OrderDetails procedure
DECLARE @new_order_id INT;
EXEC dbo.sp_SetOrderDetails 
    @order_id = @new_order_id OUTPUT,
    @car_id = 4,
    @customer_id = 4,
    @order_date = '2024-01-15',
    @price = 35000.00;
PRINT 'New Order ID: ' + CAST(@new_order_id AS NVARCHAR(10));
GO

-- Stored Procedure for Supplier Table
CREATE OR ALTER PROCEDURE dbo.sp_SetSupplier
    @supplier_id INT = NULL OUTPUT,
    @name NVARCHAR(100) = NULL,
    @contact_person NVARCHAR(100) = NULL,
    @phone NVARCHAR(20) = NULL,
    @email NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @name IS NULL
        BEGIN
            PRINT 'Supplier name is required';
            RETURN;
        END

        IF @email IS NOT NULL AND @email NOT LIKE '%_@__%.__%'
        BEGIN
            PRINT 'Invalid email format';
            RETURN;
        END

        -- Insert or Update logic
        IF @supplier_id IS NULL
        BEGIN
            INSERT INTO Supplier (name, contact_person, phone, email)
            VALUES (@name, @contact_person, @phone, @email);
            
            SET @supplier_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Supplier
            SET 
                name = ISNULL(@name, name),
                contact_person = ISNULL(@contact_person, contact_person),
                phone = ISNULL(@phone, phone),
                email = ISNULL(@email, email)
            WHERE supplier_id = @supplier_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetSupplier: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Supplier procedure
DECLARE @new_supplier_id INT;
EXEC dbo.sp_SetSupplier 
    @supplier_id = @new_supplier_id OUTPUT,
    @name = 'EuroAuto Parts',
    @contact_person = 'Iryna Kovalenko',
    @phone = '380441234567',
    @email = 'info@euroauto.com';
PRINT 'New Supplier ID: ' + CAST(@new_supplier_id AS NVARCHAR(10));
GO

-- Stored Procedure for Invoice Table
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
        IF @order_id IS NULL
        BEGIN
            PRINT 'Order ID is required';
            RETURN;
        END

        -- Check if order exists
        IF NOT EXISTS (SELECT 1 FROM OrderDetails WHERE order_id = @order_id)
        BEGIN
            PRINT 'Invalid Order ID';
            RETURN;
        END

        IF @total_amount IS NOT NULL AND @total_amount < 0
        BEGIN
            PRINT 'Total amount cannot be negative';
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
    @order_id = 4,
    @invoice_date = '2024-01-16',
    @total_amount = 35000.00;
PRINT 'New Invoice ID: ' + CAST(@new_invoice_id AS NVARCHAR(10));
GO
		
		-- Stored Procedure for Payment Table
CREATE OR ALTER PROCEDURE dbo.sp_SetPayment
    @payment_id INT = NULL OUTPUT,
    @invoice_id INT = NULL,
    @payment_date DATE = NULL,
    @amount DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @invoice_id IS NULL
        BEGIN
            PRINT 'Invoice ID is required';
            RETURN;
        END

        -- Check if invoice exists
        IF NOT EXISTS (SELECT 1 FROM Invoice WHERE invoice_id = @invoice_id)
        BEGIN
            PRINT 'Invalid Invoice ID';
            RETURN;
        END

        IF @amount IS NOT NULL AND @amount < 0
        BEGIN
            PRINT 'Payment amount cannot be negative';
            RETURN;
        END

        -- Use current date if not provided
        SET @payment_date = ISNULL(@payment_date, GETDATE());

        -- Insert or Update logic
        IF @payment_id IS NULL
        BEGIN
            INSERT INTO Payment (invoice_id, payment_date, amount)
            VALUES (@invoice_id, @payment_date, @amount);
            
            SET @payment_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Payment
            SET 
                invoice_id = ISNULL(@invoice_id, invoice_id),
                payment_date = ISNULL(@payment_date, payment_date),
                amount = ISNULL(@amount, amount)
            WHERE payment_id = @payment_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetPayment: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Payment procedure
DECLARE @new_payment_id INT;
EXEC dbo.sp_SetPayment 
    @payment_id = @new_payment_id OUTPUT,
    @invoice_id = 3,
    @payment_date = '2024-01-17',
    @amount = 35000.00;
PRINT 'New Payment ID: ' + CAST(@new_payment_id AS NVARCHAR(10));
GO
-- Stored Procedure for Inspection Table
CREATE OR ALTER PROCEDURE dbo.sp_SetInspection
    @inspection_id INT = NULL OUTPUT,
    @car_id INT = NULL,
    @employee_id INT = NULL,
    @inspection_date DATE = NULL,
    @inspection_notes NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @car_id IS NULL OR @employee_id IS NULL
        BEGIN
            PRINT 'Car ID and Employee ID are required';
            RETURN;
        END

        -- Check if car and employee exist
        IF NOT EXISTS (SELECT 1 FROM Car WHERE car_id = @car_id)
        BEGIN
            PRINT 'Invalid Car ID';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM Employee WHERE employee_id = @employee_id)
        BEGIN
            PRINT 'Invalid Employee ID';
            RETURN;
        END

        -- Use current date if not provided
        SET @inspection_date = ISNULL(@inspection_date, GETDATE());

        -- Insert or Update logic
        IF @inspection_id IS NULL
        BEGIN
            INSERT INTO Inspection (car_id, employee_id, inspection_date, inspection_notes)
            VALUES (@car_id, @employee_id, @inspection_date, @inspection_notes);
            
            SET @inspection_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Inspection
            SET 
                car_id = ISNULL(@car_id, car_id),
                employee_id = ISNULL(@employee_id, employee_id),
                inspection_date = ISNULL(@inspection_date, inspection_date),
                inspection_notes = ISNULL(@inspection_notes, inspection_notes)
            WHERE inspection_id = @inspection_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetInspection: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Inspection procedure
DECLARE @new_inspection_id INT;
EXEC dbo.sp_SetInspection 
    @inspection_id = @new_inspection_id OUTPUT,
    @car_id = 1,
    @employee_id = 1,
    @inspection_date = '2024-01-15',
    @inspection_notes = 'Routine maintenance check';
PRINT 'New Inspection ID: ' + CAST(@new_inspection_id AS NVARCHAR(10));
GO

-- Stored Procedure for VehicleType Table
CREATE OR ALTER PROCEDURE dbo.sp_SetVehicleType
    @vehicle_type_id INT = NULL OUTPUT,
    @type_name NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @type_name IS NULL
        BEGIN
            PRINT 'Vehicle type name is required';
            RETURN;
        END

        -- Insert or Update logic
        IF @vehicle_type_id IS NULL
        BEGIN
            INSERT INTO VehicleType (type_name)
            VALUES (@type_name);
            
            SET @vehicle_type_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE VehicleType
            SET 
                type_name = ISNULL(@type_name, type_name)
            WHERE vehicle_type_id = @vehicle_type_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetVehicleType: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for VehicleType procedure
DECLARE @new_vehicle_type_id INT;
EXEC dbo.sp_SetVehicleType 
    @vehicle_type_id = @new_vehicle_type_id OUTPUT,
    @type_name = 'Sedan';
PRINT 'New Vehicle Type ID: ' + CAST(@new_vehicle_type_id AS NVARCHAR(10));
GO

-- Stored Procedure for ServiceAppointment Table
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
    @appointment_date = '2024-02-01';
PRINT 'New Service Appointment ID: ' + CAST(@new_appointment_id AS NVARCHAR(10));
GO

-- Stored Procedure for Warranty Table
CREATE OR ALTER PROCEDURE dbo.sp_SetWarranty
    @warranty_id INT = NULL OUTPUT,
    @car_id INT = NULL,
    @start_date DATE = NULL,
    @end_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @car_id IS NULL
        BEGIN
            PRINT 'Car ID is required';
            RETURN;
        END

        -- Check if car exists
        IF NOT EXISTS (SELECT 1 FROM Car WHERE car_id = @car_id)
        BEGIN
            PRINT 'Invalid Car ID';
            RETURN;
        END

        -- Validate date range
        IF @start_date IS NOT NULL AND @end_date IS NOT NULL AND @start_date > @end_date
        BEGIN
            PRINT 'Start date must be before or equal to end date';
            RETURN;
        END

        -- Insert or Update logic
        IF @warranty_id IS NULL
        BEGIN
            INSERT INTO Warranty (car_id, start_date, end_date)
            VALUES (@car_id, @start_date, @end_date);
            
            SET @warranty_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Warranty
            SET 
                car_id = ISNULL(@car_id, car_id),
                start_date = ISNULL(@start_date, start_date),
                end_date = ISNULL(@end_date, end_date)
            WHERE warranty_id = @warranty_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetWarranty: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Warranty procedure
DECLARE @new_warranty_id INT;
EXEC dbo.sp_SetWarranty 
    @warranty_id = @new_warranty_id OUTPUT,
    @car_id = 1,
    @start_date = '2024-01-01',
    @end_date = '2026-01-01';
PRINT 'New Warranty ID: ' + CAST(@new_warranty_id AS NVARCHAR(10));
GO

-- Stored Procedure for Feedback Table
CREATE OR ALTER PROCEDURE dbo.sp_SetFeedback
    @feedback_id INT = NULL OUTPUT,
    @customer_id INT = NULL,
    @feedback_text NVARCHAR(MAX) = NULL,
    @feedback_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Input validation
        IF @customer_id IS NULL
        BEGIN
            PRINT 'Customer ID is required';
            RETURN;
        END

        -- Check if customer exists
        IF NOT EXISTS (SELECT 1 FROM Customer WHERE customer_id = @customer_id)
        BEGIN
            PRINT 'Invalid Customer ID';
            RETURN;
        END

        -- Use current date if not provided
        SET @feedback_date = ISNULL(@feedback_date, GETDATE());

        -- Insert or Update logic
        IF @feedback_id IS NULL
        BEGIN
            INSERT INTO Feedback (customer_id, feedback_text, feedback_date)
            VALUES (@customer_id, @feedback_text, @feedback_date);
            
            SET @feedback_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE Feedback
            SET 
                customer_id = ISNULL(@customer_id, customer_id),
                feedback_text = ISNULL(@feedback_text, feedback_text),
                feedback_date = ISNULL(@feedback_date, feedback_date)
            WHERE feedback_id = @feedback_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetFeedback: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for Feedback procedure
DECLARE @new_feedback_id INT;
EXEC dbo.sp_SetFeedback 
    @feedback_id = @new_feedback_id OUTPUT,
    @customer_id = 1,
    @feedback_text = 'Great service and friendly staff!',
    @feedback_date = '2024-01-15';
PRINT 'New Feedback ID: ' + CAST(@new_feedback_id AS NVARCHAR(10));
GO

-- Stored Procedure for MarketingCampaign Table
CREATE OR ALTER PROCEDURE dbo.sp_SetMarketingCampaign
    @campaign_id INT = NULL OUTPUT,
    @campaign_name NVARCHAR(100) = NULL,
    @start_date DATE = NULL,
    @end_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Input validation
        IF @campaign_name IS NULL
        BEGIN
            PRINT 'Campaign name is required';
            RETURN;
        END

        -- Validate date range
        IF @start_date IS NOT NULL AND @end_date IS NOT NULL AND @start_date > @end_date
        BEGIN
            PRINT 'Start date must be before or equal to end date';
            RETURN;
        END

        -- Insert or Update logic
        IF @campaign_id IS NULL
        BEGIN
            INSERT INTO MarketingCampaign (campaign_name, start_date, end_date)
            VALUES (@campaign_name, @start_date, @end_date);
            
            SET @campaign_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE MarketingCampaign
            SET 
                campaign_name = ISNULL(@campaign_name, campaign_name),
                start_date = ISNULL(@start_date, start_date),
                end_date = ISNULL(@end_date, end_date)
            WHERE campaign_id = @campaign_id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error in sp_SetMarketingCampaign: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Example call for MarketingCampaign procedure
DECLARE @new_campaign_id INT;
EXEC dbo.sp_SetMarketingCampaign 
    @campaign_id = @new_campaign_id OUTPUT,
    @campaign_name = 'Winter Sale 2024',
    @start_date = '2024-01-15',
    @end_date = '2024-02-15';
PRINT 'New Marketing Campaign ID: ' + CAST(@new_campaign_id AS NVARCHAR(10));
GO

-- Stored Procedure for TestDrive Table
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
    @test_drive_date = '2024-01-20';
PRINT 'New Test Drive ID: ' + CAST(@new_test_drive_id AS NVARCHAR(10));

GO
