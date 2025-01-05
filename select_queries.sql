-- Selecting all cars available for sale
SELECT * FROM Car WHERE status = 'available';

-- Selecting all customers
SELECT * FROM Customer;

-- Selecting all orders and their corresponding customers
SELECT o.order_id, c.first_name, c.last_name, o.order_date, o.price
FROM OrderDetails o
JOIN Customer c ON o.customer_id = c.customer_id;

-- Selecting all inspections with details
SELECT i.inspection_id, c.model, e.first_name, e.last_name, i.inspection_date, i.inspection_notes
FROM Inspection i
JOIN Car c ON i.car_id = c.car_id
JOIN Employee e ON i.employee_id = e.employee_id;

-- Selecting all invoices with corresponding orders
SELECT i.invoice_id, o.order_id, i.invoice_date, i.total_amount
FROM Invoice i
JOIN OrderDetails o ON i.order_id = o.order_id;

-- Selecting all payments made
SELECT p.payment_id, i.invoice_id, p.payment_date, p.amount
FROM Payment p
JOIN Invoice i ON p.invoice_id = i.invoice_id;

-- Selecting all services offered by the dealership
SELECT * FROM Service;

-- Selecting all service appointments
SELECT sa.appointment_id, c.model, s.service_name, sa.appointment_date
FROM ServiceAppointment sa
JOIN Car c ON sa.car_id = c.car_id
JOIN Service s ON sa.service_id = s.service_id;

-- Selecting warranties for cars
SELECT w.warranty_id, c.model, w.start_date, w.end_date
FROM Warranty w
JOIN Car c ON w.car_id = c.car_id;

-- Selecting feedback from customers
SELECT f.feedback_id, c.first_name, c.last_name, f.feedback_text, f.feedback_date
FROM Feedback f
JOIN Customer c ON f.customer_id = c.customer_id;

-- Selecting all marketing campaigns
SELECT * FROM MarketingCampaign;

-- Selecting all test drives scheduled
SELECT t.test_drive_id, c.model, cu.first_name, cu.last_name, t.test_drive_date
FROM TestDrive t
JOIN Car c ON t.car_id = c.car_id
JOIN Customer cu ON t.customer_id = cu.customer_id;

-- Selecting all employees
SELECT * FROM Employee;

-- Selecting all suppliers
SELECT * FROM Supplier;
