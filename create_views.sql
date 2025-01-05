-- View to show all available cars with their type and price
CREATE VIEW AvailableCars AS
SELECT c.car_id, c.model, c.brand, c.year, c.price, c.color, c.status, vt.type_name AS vehicle_type
FROM Car c
JOIN VehicleType vt ON c.car_id = vt.vehicle_type_id
WHERE c.status = 'available';

Go

-- View to show details of all orders including customer and car information
CREATE VIEW OrderDetailsView AS
SELECT o.order_id, c.first_name AS customer_first_name, c.last_name AS customer_last_name, car.model AS car_model, car.brand AS car_brand, o.order_date, o.price
FROM OrderDetails o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Car car ON o.car_id = car.car_id;

Go

-- View to display all invoices along with their associated payments
CREATE VIEW InvoicePaymentDetails AS
SELECT i.invoice_id, i.order_id, i.invoice_date, i.total_amount, p.payment_date, p.amount AS payment_amount
FROM Invoice i
LEFT JOIN Payment p ON i.invoice_id = p.invoice_id;

Go

-- View to show all service appointments with car and service details
CREATE VIEW ServiceAppointmentsView AS
SELECT sa.appointment_id, car.model AS car_model, car.brand AS car_brand, s.service_name, sa.appointment_date, e.first_name AS employee_first_name, e.last_name AS employee_last_name
FROM ServiceAppointment sa
JOIN Car car ON sa.car_id = car.car_id
JOIN Service s ON sa.service_id = s.service_id
LEFT JOIN Employee e ON sa.appointment_id = e.employee_id;

Go

-- View to show all customer feedback along with their car purchase details
CREATE VIEW CustomerFeedbackView AS
SELECT f.feedback_id, cu.first_name AS customer_first_name, cu.last_name AS customer_last_name, car.model AS car_model, car.brand AS car_brand, f.feedback_text, f.feedback_date
FROM Feedback f
JOIN Customer cu ON f.customer_id = cu.customer_id
LEFT JOIN OrderDetails o ON cu.customer_id = o.customer_id
LEFT JOIN Car car ON o.car_id = car.car_id;

Go

-- View to display all cars scheduled for test drives along with customer information
CREATE VIEW TestDriveSchedule AS
SELECT td.test_drive_id, car.model AS car_model, car.brand AS car_brand, cu.first_name AS customer_first_name, cu.last_name AS customer_last_name, td.test_drive_date
FROM TestDrive td
JOIN Car car ON td.car_id = car.car_id
JOIN Customer cu ON td.customer_id = cu.customer_id;

Go

-- View to show employees and the inspections they have conducted
CREATE VIEW EmployeeInspections AS
SELECT e.employee_id, e.first_name, e.last_name, e.position, i.inspection_date, car.model AS car_model, car.brand AS car_brand, i.inspection_notes
FROM Employee e
JOIN Inspection i ON e.employee_id = i.employee_id
JOIN Car car ON i.car_id = car.car_id;

Go

-- View to display all employees and their positions
CREATE VIEW EmployeeDetails AS
SELECT employee_id, first_name, last_name, position, salary
FROM Employee;

Go

-- View to show all suppliers with their contact information
CREATE VIEW SupplierContactInfo AS
SELECT supplier_id, name AS supplier_name, contact_person, phone, email
FROM Supplier;

Go

-- View to show cars and their corresponding warranties
CREATE VIEW CarWarrantyDetails AS
SELECT car.car_id, car.model, car.brand, w.start_date AS warranty_start, w.end_date AS warranty_end
FROM Car car
JOIN Warranty w ON car.car_id = w.car_id;

Go

-- View to show all marketing campaigns and their dates
CREATE VIEW CampaignDetails AS
SELECT campaign_id, campaign_name, start_date, end_date
FROM MarketingCampaign;

Go

-- View to show all payments associated with invoices
CREATE VIEW PaymentsPerInvoice AS
SELECT payment_id, invoice_id, payment_date, amount
FROM Payment;

Go

-- View to display all services offered with their prices
CREATE VIEW ServiceDetails AS
SELECT service_id, service_name, price
FROM Service;

Go

-- View to show vehicle types
CREATE VIEW VehicleTypeList AS
SELECT vehicle_type_id, type_name
FROM VehicleType;

Go