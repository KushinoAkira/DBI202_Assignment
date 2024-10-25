--Truy vấn tất cả sản phẩm và loại sản phẩm
SELECT Product.ProductName, Categories.CatName, Product.UnitPrice, Product.UnitsInStock
FROM Product
JOIN Categories ON Product.CatID = Categories.CatID;

--Truy vấn thông tin đơn hàng của khách hàng cụ thể
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.OrderDate, OrderDetails.ProductID, OrderDetails.Quantity
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE Customers.CustomerID = 1;

--Tính tổng doanh thu từ các đơn hàng
SELECT SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalRevenue
FROM OrderDetails;

-- Truy vấn danh sách nhân viên cùng quản lý 
SELECT e.FirstName AS EmployeeFirstName, e.LastName AS EmployeeLastName, m.FirstName AS ManagerFirstName, m.LastName AS ManagerLastName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;

--Tìm sản phẩm bán chạy
SELECT TOP 1 Product.ProductName, SUM(OrderDetails.Quantity) AS TotalSold
FROM OrderDetails
JOIN Product ON OrderDetails.ProductID = Product.ProductID
GROUP BY Product.ProductName
ORDER BY TotalSold DESC;

--Truy vấn thông tin các đơn hàng chưa được vận chuyển
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.OrderDate, Shippers.CompanyName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
LEFT JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID 
WHERE Orders.ShippedDate IS NULL;



