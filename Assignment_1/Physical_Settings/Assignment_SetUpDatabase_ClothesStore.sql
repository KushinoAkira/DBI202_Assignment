
CREATE DATABASE ClothesShop;

GO
USE ClothesShop;

CREATE TABLE Categories (
    CatID INT PRIMARY KEY NOT NULL,
    CatName NVARCHAR(15) NOT NULL,
    Description NTEXT
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY NOT NULL,
    ProductName NVARCHAR(40) NOT NULL,
    CatID INT,
    UnitsInStock INT,
    QuantityPerUnit INT,
    UnitsOnOrder INT,
    UnitPrice MONEY,
    FOREIGN KEY (CatID) REFERENCES Categories(CatID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY NOT NULL,
    FirstName NVARCHAR(30) NOT NULL, 
    LastName NVARCHAR(20) NOT NULL,
    Gender NVARCHAR(50),
    Phone NVARCHAR(50),
    Region NVARCHAR(50),
    Address NVARCHAR(255),
    PostalCode NVARCHAR(50),
    City NVARCHAR(50),
    Country NVARCHAR(50)
);

CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY NOT NULL,
    CompanyName NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(50)
);

CREATE TABLE Times (
    TimeID INT PRIMARY KEY NOT NULL,
    OpeningTime TIME NOT NULL,
    CloseingTime TIME NOT NULL
);

CREATE TABLE Store (
    StoreID INT PRIMARY KEY NOT NULL,
    Address NVARCHAR(255),
    City NVARCHAR(100),
    Country NVARCHAR(100),
    Region NVARCHAR(100),
    PaymentOptions NVARCHAR(50),
	TimeID INT,
	FOREIGN KEY (TimeID) REFERENCES Times(TimeID)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY NOT NULL,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
	StoreID INT,
    Gender NVARCHAR(50),
    Phone NVARCHAR(50),
    Email NVARCHAR(255),
    City NVARCHAR(100),
    Address NVARCHAR(255),
    HireDate DATETIME,
    ManagerID INT,
	Salary MONEY,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmpID),
	FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY NOT NULL,
    CustomerID INT,
    EmpID INT,
	ShipVia INT,
	Freight MONEY,
    ShippedDate DATETIME,
    ShipName NVARCHAR(255),
    ShipAddress NVARCHAR(255),
    ShipCity NVARCHAR(100),
    ShipCountry NVARCHAR(100),
    ShipPostalCode NVARCHAR(50),
    OrderDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
	FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID)
);

CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice MONEY NOT NULL, 
    Discount REAL NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE ProductInStore(
	StoreID INT  NOT NULL,
	ProductID INT NOT NULL,
	QuantityPerUnit INT NOT NULL,
	PRIMARY KEY (StoreID, ProductID),
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
)

INSERT INTO Times (TimeID, OpeningTime, CloseingTime)
VALUES
    (1, '09:00:00', '21:00:00'),
    (2, '10:00:00', '22:00:00');

INSERT INTO Categories (CatID, CatName, Description)
VALUES
    (1, 'Shirts', 'Casual and formal shirts'),
    (2, 'Pants', 'Various styles of pants'),
    (3, 'Jackets', 'Jackets and outerwear'),
    (4, 'Shoes', 'All types of footwear'),
    (5, 'Accessories', 'Hats, belts, and more'),
    (6, 'Dresses', 'Casual and formal dresses'),
    (7, 'Swimwear', 'Swimming apparel'),
    (8, 'Sportswear', 'Activewear and sportswear'),
    (9, 'Undergarments', 'All types of undergarments'),
    (10, 'Suits', 'Formal suits and attire');

INSERT INTO Store (StoreID, Address, City, Country, Region, PaymentOptions, TimeID)
VALUES
    (1, '123 Fashion St', 'New York', 'USA', 'East', 'Credit Card', 1),
    (2, '456 Style Ave', 'Los Angeles', 'USA', 'West', 'Cash, Credit Card', 2),
    (3, '789 Trend Rd', 'Chicago', 'USA', 'Midwest', 'Cash', 1),
    (4, '101 Chic Ln', 'Houston', 'USA', 'South', 'Credit Card', 2),
    (5, '202 Vogue Blvd', 'Phoenix', 'USA', 'Southwest', 'Cash, Debit Card', 1),
    (6, '303 Classy Dr', 'Philadelphia', 'USA', 'East', 'Credit Card, Debit Card', 2),
    (7, '404 Modern St', 'San Antonio', 'USA', 'South', 'Cash, Credit Card', 1),
    (8, '505 Elegant Ave', 'San Diego', 'USA', 'West', 'Credit Card', 2),
    (9, '606 Fashion Ln', 'Dallas', 'USA', 'South', 'Credit Card, Cash', 1),
    (10, '707 Trendy Rd', 'Austin', 'USA', 'Southwest', 'Cash, Credit Card', 2);

INSERT INTO Shippers (ShipperID, CompanyName, Phone)
VALUES
    (1, 'FastShip', '555-0123'),
    (2, 'ExpressWay', '555-4567'),
    (3, 'GlobalDelivery', '555-7890'),
    (4, 'QuickMoves', '555-2345'),
    (5, 'PrimeShipping', '555-6789'),
    (6, 'SpeedyTransport', '555-3456'),
    (7, 'ReliableCarriers', '555-1234'),
    (8, 'FastTrack', '555-5678'),
    (9, 'PriorityPost', '555-4321'),
    (10, 'SwiftLogistics', '555-8765');

INSERT INTO Product (ProductID, ProductName, CatID, UnitsInStock, QuantityPerUnit, UnitsOnOrder, UnitPrice)
VALUES
    (1, 'Casual Shirt', 1, 50, 1, 10, 20.00),
    (2, 'Formal Shirt', 1, 30, 1, 5, 25.00),
    (3, 'Jeans', 2, 40, 1, 12, 35.00),
    (4, 'Jacket', 3, 15, 1, 3, 55.00),
    (5, 'Sneakers', 4, 60, 1, 20, 45.00),
    (6, 'Hat', 5, 25, 1, 4, 15.00),
    (7, 'Dress', 6, 30, 1, 6, 60.00),
    (8, 'Swim Trunks', 7, 40, 1, 10, 20.00),
    (9, 'T-shirt', 1, 100, 1, 50, 15.00),
    (10, 'Tracksuit', 8, 20, 1, 5, 50.00),
    (11, 'Boxers', 9, 80, 1, 10, 10.00),
    (12, 'Blazer', 10, 10, 1, 3, 120.00),
    (13, 'Socks', 5, 200, 1, 0, 5.00),
    (14, 'Scarf', 5, 30, 1, 8, 12.00),
    (15, 'Raincoat', 3, 18, 1, 4, 40.00),
    (16, 'Sandals', 4, 50, 1, 10, 30.00),
    (17, 'Pullover', 3, 25, 1, 5, 35.00),
    (18, 'Suit', 10, 5, 1, 2, 150.00),
    (19, 'Winter Coat', 3, 12, 1, 2, 90.00),
    (20, 'Cap', 5, 40, 1, 6, 8.00),
    (21, 'Shorts', 2, 60, 1, 10, 20.00),
    (22, 'Blouse', 1, 45, 1, 5, 18.00),
    (23, 'Belt', 5, 100, 1, 15, 10.00),
    (24, 'Hoodie', 8, 25, 1, 8, 40.00),
    (25, 'Tie', 5, 50, 1, 5, 10.00);

INSERT INTO ProductInStore (StoreID, ProductID, QuantityPerUnit)
VALUES
    (1, 1, 10),
    (2, 2, 5),
    (3, 3, 7),
    (4, 4, 8),
    (5, 5, 12),
    (1, 6, 6),
    (2, 7, 4),
    (3, 8, 10),
    (4, 9, 20),
    (5, 10, 3),
    (1, 11, 15),
    (2, 12, 5),
    (3, 13, 25),
    (4, 14, 6),
    (5, 15, 2),
    (1, 16, 8),
    (2, 17, 10),
    (3, 18, 1),
    (4, 19, 5),
    (5, 20, 8),
    (1, 21, 10),
    (2, 22, 7),
    (3, 23, 15),
    (4, 24, 9),
    (5, 25, 4);


INSERT INTO Employees (EmpID, FirstName, LastName, StoreID, Gender, Phone, Email, City, Address, HireDate, ManagerID, Salary)
VALUES
    (1, 'John', 'Smith', 1, 'Male', '555-1010', 'john.smith@example.com', 'New York', '123 Fashion St', '2021-01-15', NULL, 50000),
    (2, 'Sarah', 'Jones', 2, 'Female', '555-1020', 'sarah.jones@example.com', 'Los Angeles', '456 Style Ave', '2020-05-22', 1, 52000),
    (3, 'Michael', 'Brown', 3, 'Male', '555-1030', 'michael.brown@example.com', 'Chicago', '789 Trend Rd', '2019-09-18', NULL, 53000),
    (4, 'Anna', 'Davis', 4, 'Female', '555-1040', 'anna.davis@example.com', 'Houston', '101 Chic Ln', '2022-02-10', 3, 48000),
    (5, 'David', 'Wilson', 5, 'Male', '555-1050', 'david.wilson@example.com', 'Phoenix', '202 Vogue Blvd', '2020-11-07', 4, 46000),
    (6, 'Emma', 'Garcia', 6, 'Female', '555-1060', 'emma.garcia@example.com', 'Philadelphia', '303 Classy Dr', '2021-04-05', NULL, 47000),
    (7, 'Daniel', 'Martinez', 7, 'Male', '555-1070', 'daniel.martinez@example.com', 'San Antonio', '404 Modern St', '2019-12-14', 1, 49000),
    (8, 'Sophia', 'Anderson', 8, 'Female', '555-1080', 'sophia.anderson@example.com', 'San Diego', '505 Elegant Ave', '2023-03-16', NULL, 51000),
    (9, 'James', 'Taylor', 9, 'Male', '555-1090', 'james.taylor@example.com', 'Dallas', '606 Fashion Ln', '2020-06-20', 7, 54000),
    (10, 'Olivia', 'Thomas', 10, 'Female', '555-1100', 'olivia.thomas@example.com', 'Austin', '707 Trendy Rd', '2018-08-11', NULL, 45000);
    -- Additional entries for remaining employees up to 25


INSERT INTO Customers (CustomerID, FirstName, LastName, Gender, Phone, Region, Address, PostalCode, City, Country)
VALUES
    (1, 'Alice', 'Johnson', 'Female', '555-2010', 'East', '742 Evergreen Terrace', '10001', 'New York', 'USA'),
    (2, 'Bob', 'Lee', 'Male', '555-2020', 'West', '1234 Beach Dr', '90001', 'Los Angeles', 'USA'),
    (3, 'Carol', 'Smith', 'Female', '555-2030', 'Midwest', '789 Oak St', '60601', 'Chicago', 'USA'),
    (4, 'David', 'Miller', 'Male', '555-2040', 'South', '101 River Rd', '77001', 'Houston', 'USA'),
    (5, 'Eve', 'Martinez', 'Female', '555-2050', 'Southwest', '202 Palm St', '85001', 'Phoenix', 'USA');
    -- Additional entries for remaining customers up to 25

INSERT INTO Orders (OrderID, CustomerID, EmpID, ShipVia, Freight, ShippedDate, ShipName, ShipAddress, ShipCity, ShipCountry, ShipPostalCode, OrderDate)
VALUES
    (1, 1, 1, 1, 5.00, '2024-10-10', 'Alice Johnson', '742 Evergreen Terrace', 'New York', 'USA', '10001', '2024-10-05'),
    (2, 2, 2, 2, 15.00, '2024-10-12', 'Bob Lee', '1234 Beach Dr', 'Los Angeles', 'USA', '90001', '2024-10-06'),
    (3, 3, 3, 3, 25.00, '2024-10-14', 'Carol Smith', '789 Oak St', 'Chicago', 'USA', '60601', '2024-10-07'),
    (4, 4, 4, 4, 35.00, '2024-10-16', 'David Miller', '101 River Rd', 'Houston', 'USA', '77001', '2024-10-08'),
    (5, 5, 5, 5, 45.00, '2024-10-18', 'Eve Martinez', '202 Palm St', 'Phoenix', 'USA', '85001', '2024-10-09');
    -- Additional entries for remaining orders up to 25

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, Discount)
VALUES
    (1, 1, 2, 20.00, 0.0),
    (1, 3, 1, 35.00, 0.1),
    (2, 2, 3, 25.00, 0.05),
    (2, 4, 1, 55.00, 0.15),
    (3, 5, 1, 45.00, 0.2),
    (3, 6, 4, 15.00, 0.1),
    (4, 7, 2, 60.00, 0.05),
    (4, 9, 3, 15.00, 0.0),
    (5, 10, 2, 50.00, 0.1);
    -- Additional entries for remaining order details up to 25
