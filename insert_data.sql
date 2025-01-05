-- Populating the Car table with data
INSERT INTO Car (model, brand, year, price, color, status) VALUES
('Model S', 'Tesla', 2023, 79999.99, 'Black', 'available'),
('Civic', 'Honda', 2020, 20000.00, 'White', 'sold'),
('Mustang', 'Ford', 2022, 55000.00, 'Red', 'under inspection'),
('A4', 'Audi', 2021, 35000.00, 'Blue', 'available'),
('X5', 'BMW', 2019, 45000.00, 'Gray', 'available');

-- Populating the Customer table with data
INSERT INTO Customer (first_name, last_name, phone, email) VALUES
('Oleksandr', 'Ivanenko', '380661234567', 'ivanenko@gmail.com'),
('Natalia', 'Petrenko', '380671234567', 'petrenko@gmail.com'),
('Viktor', 'Sydorenko', '380681234567', 'sydorenko@gmail.com'),
('Olena', 'Kovalenko', '380631234567', 'kovalenko@gmail.com');

-- Populating the OrderDetails table with data
INSERT INTO OrderDetails (car_id, customer_id, order_date, price) VALUES
(1, 1, '2023-09-15', 79999.99), -- Tesla Model S for Oleksandr Ivanenko
(2, 2, '2023-08-20', 20000.00), -- Honda Civic for Natalia Petrenko
(3, 3, '2023-07-10', 55000.00); -- Ford Mustang for Viktor Sydorenko

-- Populating the Employee table with data
INSERT INTO Employee (first_name, last_name, position, salary) VALUES
('Oleh', 'Semenov', 'Mechanic', 40000.00),
('Anna', 'Tarasova', 'Sales Manager', 50000.00),
('Ihor', 'Vasylienko', 'Technician', 35000.00);

-- Populating the Inspection table with data
INSERT INTO Inspection (car_id, employee_id, inspection_date, inspection_notes) VALUES
(1, 1, '2023-09-10', 'Oil changed, brakes checked'),
(3, 2, '2023-10-01', 'Full diagnostics performed'),
(2, 3, '2023-07-30', 'Inspection before sale');

-- Populating the Supplier table with data
INSERT INTO Supplier (name, contact_person, phone, email) VALUES
('AutoSupplies Inc.', 'John Doe', '380661234568', 'johndoe@autosupplies.com'),
('PartsWorld', 'Jane Smith', '380671234569', 'janesmith@partsworld.com');

-- Populating the Invoice table with data
INSERT INTO Invoice (order_id, invoice_date, total_amount) VALUES
(1, '2023-09-16', 79999.99), -- Invoice for Oleksandr's Tesla
(2, '2023-08-21', 20000.00); -- Invoice for Natalia's Honda

-- Populating the Payment table with data
INSERT INTO Payment (invoice_id, payment_date, amount) VALUES
(1, '2023-09-17', 79999.99), -- Payment for Oleksandr's invoice
(2, '2023-08-22', 20000.00); -- Payment for Natalia's invoice

-- Populating the VehicleType table with data
INSERT INTO VehicleType (type_name) VALUES
('Sedan'),
('SUV'),
('Truck'),
('Coupe'),
('Convertible');

-- Populating the Service table with data
INSERT INTO Service (service_name, price) VALUES
('Oil Change', 50.00),
('Tire Rotation', 30.00),
('Brake Inspection', 40.00);

-- Populating the ServiceAppointment table with data
INSERT INTO ServiceAppointment (car_id, service_id, appointment_date) VALUES
(1, 1, '2023-09-20'), -- Oil change for Tesla
(3, 2, '2023-10-05'); -- Tire rotation for Mustang

-- Populating the Warranty table with data
INSERT INTO Warranty (car_id, start_date, end_date) VALUES
(1, '2023-09-15', '2025-09-15'), -- Warranty for Tesla
(3, '2023-07-10', '2025-07-10'); -- Warranty for Mustang

-- Populating the Feedback table with data
INSERT INTO Feedback (customer_id, feedback_text, feedback_date) VALUES
(1, 'Great service!', '2023-09-18'),
(2, 'Very satisfied with my purchase.', '2023-08-22');

-- Populating the MarketingCampaign table with data
INSERT INTO MarketingCampaign (campaign_name, start_date, end_date) VALUES
('End of Year Sale', '2023-12-01', '2023-12-31'),
('Spring Special', '2024-03-01', '2024-03-31');

-- Populating the TestDrive table with data
INSERT INTO TestDrive (car_id, customer_id, test_drive_date) VALUES
(1, 1, '2023-09-14'), -- Test drive for Oleksandr in Tesla
(2, 2, '2023-08-19'); -- Test drive for Natalia in Honda
