-- Creating a table to store information about cars
CREATE TABLE Car (
    car_id INT PRIMARY KEY IDENTITY(1,1),
    model VARCHAR(100),
    brand VARCHAR(100),
    year INT,
    price DECIMAL(10, 2),
    color VARCHAR(50),
    status VARCHAR(50) -- available, sold, under inspection, etc.
);

-- Creating a table to store information about customers
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- Creating a table to store information about orders
CREATE TABLE OrderDetails (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    car_id INT,
    customer_id INT,
    order_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Creating a table for employees of the car dealership
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);

-- Creating a table to store information about inspections
CREATE TABLE Inspection (
    inspection_id INT PRIMARY KEY IDENTITY(1,1),
    car_id INT,
    employee_id INT,
    inspection_date DATE,
    inspection_notes TEXT,
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Creating a table to store information about suppliers
CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- Creating a table to store invoice information
CREATE TABLE Invoice (
    invoice_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    invoice_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES OrderDetails(order_id)
);

-- Creating a table to store payment information
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    invoice_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id)
);

-- Creating a table to store vehicle types
CREATE TABLE VehicleType (
    vehicle_type_id INT IDENTITY PRIMARY KEY,
    type_name NVARCHAR(50) NOT NULL
);

-- Creating a table to store services offered by the dealership
CREATE TABLE Service (
    service_id INT PRIMARY KEY IDENTITY(1,1),
    service_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Creating a table to store service appointments
CREATE TABLE ServiceAppointment (
    appointment_id INT PRIMARY KEY IDENTITY(1,1),
    car_id INT,
    service_id INT,
    appointment_date DATE,
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

-- Creating a table to store warranty information
CREATE TABLE Warranty (
    warranty_id INT PRIMARY KEY IDENTITY(1,1),
    car_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (car_id) REFERENCES Car(car_id)
);

-- Creating a table to store customer feedback
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    feedback_text TEXT,
    feedback_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Creating a table to store marketing campaigns
CREATE TABLE MarketingCampaign (
    campaign_id INT PRIMARY KEY IDENTITY(1,1),
    campaign_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

-- Creating a table to store test drive information
CREATE TABLE TestDrive (
    test_drive_id INT PRIMARY KEY IDENTITY(1,1),
    car_id INT,
    customer_id INT,
    test_drive_date DATE,
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
