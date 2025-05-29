
CREATE DATABASE EnterpriseDB;
GO

USE EnterpriseDB;
GO


CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100)
);
GO


CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    HireDate DATE NOT NULL,
    Email NVARCHAR(100),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO


CREATE TABLE Projects (
    ProjectID INT IDENTITY(1,1) PRIMARY KEY,
    ProjectName NVARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL
);
GO


CREATE TABLE EmployeeProjects (
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,
    AssignedDate DATE NOT NULL,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
GO


CREATE TABLE PerformanceReviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    ReviewDate DATE NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments NVARCHAR(500),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
GO


CREATE TABLE SalaryHistory (
    SalaryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Salary DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
GO


CREATE TABLE TimeOffRequests (
    RequestID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Reason NVARCHAR(250),
    Status NVARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'Approved', 'Denied')),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
GO


"SAMPLE DATA"

INSERT INTO Departments (DepartmentName, Location) VALUES
('Engineering', 'New York'),
('Marketing', 'Chicago'),
('Human Resources', 'Boston');
GO


INSERT INTO Employees (FirstName, LastName, DepartmentID, HireDate, Email) VALUES
('Alice', 'Johnson', 1, '2019-06-01', 'alice.johnson@example.com'),
('Bob', 'Smith', 2, '2020-01-15', 'bob.smith@example.com'),
('Carol', 'Davis', 1, '2021-03-12', 'carol.davis@example.com'),
('David', 'Wilson', 3, '2018-11-20', 'david.wilson@example.com');
GO


INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES
('Website Redesign', '2023-01-10', '2023-06-30'),
('Mobile App Development', '2023-03-01', NULL),
('Social Media Campaign', '2023-02-15', '2023-04-15');
GO


INSERT INTO EmployeeProjects (EmployeeID, ProjectID, AssignedDate) VALUES
(1, 1, '2023-01-15'),
(3, 1, '2023-02-01'),
(2, 3, '2023-02-16'),
(1, 2, '2023-03-05');
GO


INSERT INTO PerformanceReviews (EmployeeID, ReviewDate, Rating, Comments) VALUES
(1, '2023-06-30', 5, 'Excellent performance.'),
(2, '2023-06-30', 4, 'Good work, needs slight improvement in communication.'),
(3, '2023-06-30', 3, 'Meets expectations.'),
(4, '2023-06-30', 4, 'Strong team player.');
GO


INSERT INTO SalaryHistory (EmployeeID, StartDate, EndDate, Salary) VALUES
(1, '2019-06-01', '2022-12-31', 75000.00),
(1, '2023-01-01', NULL, 85000.00),
(2, '2020-01-15', NULL, 60000.00),
(3, '2021-03-12', NULL, 70000.00),
(4, '2018-11-20', NULL, 65000.00);
GO


INSERT INTO TimeOffRequests (EmployeeID, StartDate, EndDate, Reason, Status) VALUES
(1, '2023-07-10', '2023-07-15', 'Family vacation', 'Approved'),
(2, '2023-08-01', '2023-08-05', 'Medical leave', 'Pending'),
(3, '2023-09-12', '2023-09-14', 'Personal', 'Denied');
GO
