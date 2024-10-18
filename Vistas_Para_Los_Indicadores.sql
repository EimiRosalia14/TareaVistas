use Northwind

--Amy Rosal�a P�rez Ram�rez, 2022-2113.

--Practica: Crear las vistas para los indicadores

-- 1- Ventas Totales por Per�odo (A�o y Mes)
CREATE VIEW DWH.View_Ventas_Totales_Por_Periodo AS
SELECT 
    YEAR(o.OrderDate) AS A�o,
    MONTH(o.OrderDate) AS Mes,
    SUM(od.UnitPrice * od.Quantity) AS TotalVentas
FROM 
    [Northwind].[dbo].[Orders] o
JOIN 
    [Northwind].[dbo].[Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    YEAR(o.OrderDate), MONTH(o.OrderDate);


-- 2- Ventas por Categor�a de Producto
CREATE VIEW DWH.View_Ventas_Por_Categoria_Producto AS
SELECT 
    C.CategoryName, 
    COUNT(DISTINCT P.ProductID) AS NumeroDeProductos,
    SUM(OD.Quantity * OD.UnitPrice) AS VentasTotales
FROM 
    Products P
JOIN 
    [Order Details] OD ON P.ProductID = OD.ProductID
JOIN 
    Categories C ON P.CategoryID = C.CategoryID
GROUP BY 
    C.CategoryName;


-- 3- Total de Ventas por Categor�a
CREATE VIEW DWH.View_Total_Ventas_Por_Categoria AS
SELECT 
    C.CategoryName, 
    SUM(OD.Quantity * OD.UnitPrice) AS VentasTotales
FROM 
    Products P
JOIN 
    [Order Details] OD ON P.ProductID = OD.ProductID
JOIN 
    Categories C ON P.CategoryID = C.CategoryID
GROUP BY 
    C.CategoryName;


-- 4- Ventas por Regi�n/Pa�s
CREATE VIEW DWH.View_Ventas_Por_Region_Pais AS
SELECT 
    O.ShipCountry AS Pa�s, 
    O.ShipRegion AS Regi�n, 
    SUM(OD.Quantity * OD.UnitPrice) AS VentasTotales
FROM 
    Orders O
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY 
    O.ShipCountry, O.ShipRegion;


-- 5- N�mero de Pedidos Procesados por Empleado
CREATE VIEW DWH.View_Numero_Pedidos_Procesados_Por_Empleado AS
SELECT 
    E.EmployeeID, 
    E.FirstName + ' ' + E.LastName AS Empleado, 
    COUNT(O.OrderID) AS NumeroDePedidos
FROM 
    Employees E
JOIN 
    Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY 
    E.EmployeeID, E.FirstName, E.LastName;


-- 6- Productividad de Empleados (Ventas por Empleado)
CREATE VIEW DWH.View_Productividad_Empleados AS
SELECT 
    E.EmployeeID, 
    E.FirstName + ' ' + E.LastName AS Empleado, 
    SUM(OD.Quantity * OD.UnitPrice) AS VentasTotales
FROM 
    Employees E
JOIN 
    Orders O ON E.EmployeeID = O.EmployeeID
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY 
    E.EmployeeID, E.FirstName, E.LastName;


-- 7- Clientes Atendidos por Empleado
CREATE VIEW DWH.View_Clientes_Atendidos_Por_Empleado AS
SELECT 
    E.EmployeeID, 
    E.FirstName + ' ' + E.LastName AS Empleado, 
    COUNT(DISTINCT O.CustomerID) AS NumeroDeClientes
FROM 
    Employees E
JOIN 
    Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY 
    E.EmployeeID, E.FirstName, E.LastName;


-- 8- Productos M�s Vendidos
CREATE VIEW DWH.View_Productos_Mas_Vendidos AS
SELECT 
    P.ProductID, 
    P.ProductName, 
    SUM(OD.Quantity) AS CantidadVendida
FROM 
    Products P
JOIN 
    [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY 
    P.ProductID, P.ProductName;


-- 9- Productos M�s Vendidos por Categor�a
CREATE VIEW DWH.View_Productos_Mas_Vendidos_Por_Categoria AS
SELECT 
    c.CategoryName,
    p.ProductName,
    SUM(od.Quantity) AS TotalVendidos
FROM 
    [Northwind].[dbo].[Categories] c
JOIN 
    [Northwind].[dbo].[Products] p ON c.CategoryID = p.CategoryID
JOIN 
    [Northwind].[dbo].[Order Details] od ON p.ProductID = od.ProductID
GROUP BY 
    c.CategoryName, p.ProductName


-- 10- Total de Ventas por Transportista
CREATE VIEW DWH.View_Total_Ventas_Por_Transportista AS
SELECT 
    S.ShipperID, 
    S.CompanyName AS Transportista, 
    SUM(OD.Quantity * OD.UnitPrice) AS VentasTotales
FROM 
    Shippers S
JOIN 
    Orders O ON S.ShipperID = O.ShipVia
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY 
    S.ShipperID, S.CompanyName;


-- 11- N�mero de �rdenes Enviadas por Transportista
CREATE VIEW DWH.View_Numero_Ordenes_Por_Transportista AS
SELECT 
    S.ShipperID, 
    S.CompanyName AS Transportista, 
    COUNT(O.OrderID) AS NumeroDeOrdenes
FROM 
    Shippers S
JOIN 
    Orders O ON S.ShipperID = O.ShipVia
GROUP BY 
    S.ShipperID, S.CompanyName;


-- 12- Total de Ventas por Cliente
CREATE VIEW DWH.View_Total_Ventas_Por_Cliente AS
SELECT 
    c.CompanyName AS Cliente,
    SUM(od.UnitPrice * od.Quantity) AS TotalVentas
FROM 
    [Northwind].[dbo].[Customers] c
JOIN 
    [Northwind].[dbo].[Orders] o ON c.CustomerID = o.CustomerID
JOIN 
    [Northwind].[dbo].[Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CompanyName;


-- 13- N�mero de �rdenes por Cliente
CREATE VIEW DWH.View_Numero_Ordenes_Por_Cliente AS
SELECT 
    c.CompanyName AS Cliente,
    COUNT(o.OrderID) AS NumeroDeOrdenes
FROM 
    [Northwind].[dbo].[Customers] c
JOIN 
    [Northwind].[dbo].[Orders] o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CompanyName;