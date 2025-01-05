-- Створення таблиць
CREATE TABLE dbo.Customer (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Email NVARCHAR(100)
);

CREATE TABLE dbo.Employee (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE dbo.Vehicle (
    VehicleID INT PRIMARY KEY,
    Model NVARCHAR(100),
    Year INT
);

CREATE TABLE dbo.ServiceAppointment (
    AppointmentID INT PRIMARY KEY,
    CustomerID INT,
    VehicleID INT,
    Status NVARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES dbo.Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES dbo.Vehicle(VehicleID)
);

-- Додавання версіонування для Customer
ALTER TABLE dbo.Customer ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
    CONSTRAINT DF_Customer_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
    CONSTRAINT DF_Customer_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo);

ALTER TABLE dbo.Customer
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Customer_History));

-- Додавання версіонування для Employee
ALTER TABLE dbo.Employee ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
    CONSTRAINT DF_Employee_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
    CONSTRAINT DF_Employee_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo);

ALTER TABLE dbo.Employee
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Employee_History));

-- Додавання версіонування для Vehicle
ALTER TABLE dbo.Vehicle ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
    CONSTRAINT DF_Vehicle_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
    CONSTRAINT DF_Vehicle_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo);

ALTER TABLE dbo.Vehicle
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Vehicle_History));

-- Додавання версіонування для ServiceAppointment
ALTER TABLE dbo.ServiceAppointment ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
    CONSTRAINT DF_ServiceAppointment_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
    CONSTRAINT DF_ServiceAppointment_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo);

ALTER TABLE dbo.ServiceAppointment
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ServiceAppointment_History));

-- Створення тестових даних для демонстрації
INSERT INTO dbo.Customer (CustomerID, Name, Email) 
VALUES (1, 'John Doe', 'john@example.com');

INSERT INTO dbo.Employee (EmployeeID, Name, Position, Salary)
VALUES (100, 'Jane Smith', 'Manager', 50000);

INSERT INTO dbo.Vehicle (VehicleID, Model, Year)
VALUES (500, 'Toyota Camry', 2020);

INSERT INTO dbo.ServiceAppointment (AppointmentID, CustomerID, VehicleID, Status)
VALUES (1000, 1, 500, 'Scheduled');

-- Внесення змін для створення історії
UPDATE dbo.Customer 
SET Email = 'john.doe@example.com' 
WHERE CustomerID = 1;

UPDATE dbo.Employee
SET Salary = 55000
WHERE EmployeeID = 100;

UPDATE dbo.Vehicle
SET Year = 2021
WHERE VehicleID = 500;

UPDATE dbo.ServiceAppointment
SET Status = 'In Progress'
WHERE AppointmentID = 1000;

-- Приклади запитів для отримання історичних даних

-- 1. Отримати всю історію змін клієнта
SELECT *
FROM dbo.Customer
FOR SYSTEM_TIME ALL
WHERE CustomerID = 1;

-- 2. Отримати історію змін зарплати співробітника
SELECT EmployeeID, Name, Salary, ValidFrom, ValidTo
FROM dbo.Employee
FOR SYSTEM_TIME ALL
WHERE EmployeeID = 100
ORDER BY ValidFrom;

-- 3. Подивитися стан даних автомобіля на конкретну дату
SELECT *
FROM dbo.Vehicle
FOR SYSTEM_TIME AS OF '2023-01-01'
WHERE VehicleID = 500;

-- 4. Історія змін статусу сервісного запису
SELECT AppointmentID, Status, ValidFrom, ValidTo
FROM dbo.ServiceAppointment
FOR SYSTEM_TIME ALL
WHERE AppointmentID = 1000;

-- 5. Комплексний запит: історія всіх змін по конкретному сервісному запису з даними клієнта та автомобіля
SELECT 
    sa.AppointmentID,
    sa.Status,
    c.Name AS CustomerName,
    c.Email AS CustomerEmail,
    v.Model AS VehicleModel,
    v.Year AS VehicleYear,
    sa.ValidFrom,
    sa.ValidTo
FROM dbo.ServiceAppointment FOR SYSTEM_TIME ALL sa
JOIN dbo.Customer FOR SYSTEM_TIME ALL c ON sa.CustomerID = c.CustomerID
JOIN dbo.Vehicle FOR SYSTEM_TIME ALL v ON sa.VehicleID = v.VehicleID
WHERE sa.AppointmentID = 1000
ORDER BY sa.ValidFrom;

-- 6. Запит для порівняння даних за різні періоди часу
DECLARE @CurrentTime DATETIME2 = SYSUTCDATETIME();
DECLARE @PastTime DATETIME2 = DATEADD(MONTH, -6, SYSUTCDATETIME());

SELECT 
    v.VehicleID,
    v.Model,
    v.Year AS CurrentYear,
    vHistory.Year AS PreviousYear,
    v.ValidFrom AS CurrentValidFrom,
    vHistory.ValidFrom AS PreviousValidFrom
FROM dbo.Vehicle FOR SYSTEM_TIME AS OF @CurrentTime v
JOIN dbo.Vehicle FOR SYSTEM_TIME AS OF @PastTime vHistory
    ON v.VehicleID = vHistory.VehicleID
WHERE v.Year != vHistory.Year;