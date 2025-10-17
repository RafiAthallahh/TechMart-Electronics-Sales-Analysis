USE ProductSalesDB;

SELECT * FROM Product_Sales_Reg;

-- KPI Queruy

-- 1. 
-- Total Revenue 
SELECT 
	SUM(TotalPrice) AS Total_Sales_Revenue
FROM Product_Sales_Reg; 

-- Total Revenue By Region
SELECT
    Region,
    SUM(TotalPrice) AS Total_Revenue
FROM Product_Sales_Reg
GROUP BY Region
ORDER BY Total_Revenue DESC;

-- Total Revenue By Region and Store Location
SELECT
    Region,
	StoreLocation,
    SUM(TotalPrice) AS Total_Revenue
FROM Product_Sales_Reg
GROUP BY Region,StoreLocation
ORDER BY Total_Revenue DESC;

--Time Sales
--Total Revenue By YEAR
SELECT 
	YEAR(OrderDate) AS SalesYear,
	SUM(TotalPrice) AS TotalSalesRevenue,
	SUM(Quantity) AS TotalQuantitySold
FROM Product_Sales_Reg
GROUP BY YEAR(OrderDate) 
ORDER BY SalesYear;

--Total Revenue By MONTH
SELECT 
	MONTH(OrderDate) AS SalesMonth,
	SUM(TotalPrice) AS TotalSalesRevenue,
	SUM(Quantity) AS TotalQuantitySold
FROM Product_Sales_Reg
GROUP BY MONTH(OrderDate)
ORDER BY TotalQuantitySold DESC;

--Total Revenue By Quartal
SELECT 
	YEAR(OrderDate) AS SalesYear,
	DATEPART(QUARTER,OrderDate) AS SalesQuarter, 
	SUM(TotalPrice) AS TotalSalesRevenue,
	SUM(Quantity) AS TotalQuantitySold
FROM Product_Sales_Reg
GROUP BY YEAR(OrderDate),DATEPART(QUARTER,OrderDate)
ORDER BY SalesYear,SalesQuarter;

-- ============================================================== -- 

-- 2. 
-- Average Order Value 
SELECT 
	AVG(TotalPrice)  AS AVG_Order_Value
FROM Product_Sales_Reg;

-- AOV By CustomerType
SELECT 
	CustomerType,
	AVG(TotalPrice) AS AOV_Cust
FROM Product_Sales_Reg
GROUP BY CustomerType

-- AOV By Promotion
SELECT 
	Promotion,
	AVG(TotalPrice) AS AOV_Promot
FROM Product_Sales_Reg
GROUP BY Promotion
ORDER BY AOV_Promot DESC;

-- ============================================================== -- 
-- Additional Insights

--Total Product SOLD 
SELECT 
	SUM(Quantity) AS Total_Product_Sold
FROM Product_Sales_Reg;

--Total Product SOLD by Category
SELECT 
	Product, SUM(Quantity) AS Total_Product_Sold_by_Category
FROM Product_Sales_Reg
GROUP BY Product

--Total Product SOLD by Region 
SELECT 
	Region, SUM(Quantity) AS Total_Product_Sold_by_Region
FROM Product_Sales_Reg
GROUP BY Region

--Total Product SOLD by SalesPerson
SELECT
	Salesperson, SUM(Quantity) AS Total_Product_Sold_by_Salesperson
FROM Product_Sales_Reg
GROUP BY Salesperson

-- Total Order
SELECT 
	COUNT(DISTINCT OrderID) AS Total_Orders 
FROM Product_Sales_Reg;

--Total Order by Product 
SELECT
	Product, COUNT(DISTINCT OrderID) AS Total_Orders_by_Product 
FROM Product_Sales_Reg
GROUP BY Product;

--Total Order by Region
SELECT 
	Region, COUNT(DISTINCT OrderID) AS Total_Orders_by_Region
FROM Product_Sales_Reg
GROUP BY Region;

--AVG Product Order
SELECT 
	SUM(Quantity)/COUNT(DISTINCT OrderID) AS AVG_OrderID
FROM Product_Sales_Reg;

-- ============================================================== -- 
-- 3. 
-- Total Returned Product 
SELECT
    Product,
    (SUM(CASE WHEN Returned = '1' THEN 1.0 ELSE 0.0 END) * 100 / COUNT(*)) AS ReturnRatePercentage,
	SUM(CASE WHEN Returned = '1' THEN 1 ELSE 0 END) AS TotalReturnedItems,
    COUNT(*) AS TotalOrders
FROM Product_Sales_Reg
GROUP BY Product
ORDER BY ReturnRatePercentage DESC;

SELECT
	SUM(CASE WHEN Returned = '1' THEN 1 ELSE 0 END) AS TotalReturnedItems
FROM Product_Sales_Reg

-- Total Return By Promotion
SELECT
    Promotion,
    (SUM(CASE WHEN Returned = '1' THEN 1.0 ELSE 0.0 END) * 100 / COUNT(*)) AS ReturnRatePercentage,
	SUM(CASE WHEN Returned = '1' THEN 1 ELSE 0 END) AS TotalReturnedItems,
    COUNT(*) AS TotalOrders
FROM Product_Sales_Reg
GROUP BY Promotion
ORDER BY ReturnRatePercentage DESC;


-- 4. 
-- Regional Trend Analysis 
SELECT 
	Region,
	SUM(TotalPrice) AS TotalSalesRevenue,
	SUM(Quantity) AS TotalQuantitySold,
	COUNT(*) AS TotalTransactions
FROM Product_Sales_Reg
GROUP BY Region
ORDER BY TotalSalesRevenue DESC;

--StoreLocation Trend Analysis 
SELECT 
	StoreLocation, 
	SUM(TotalPrice) AS TotalSalesRevenue,
	SUM(Quantity) AS TotalQuantitySold,
	COUNT(*) AS TotalTransactions
FROM Product_Sales_Reg
GROUP BY StoreLocation
ORDER BY TotalSalesRevenue DESC;

--Region StoreLocation Analysis Trend
SELECT 
	Region,
	StoreLocation,
	SUM(TotalPrice) AS TotalSalesRevenue,
	SUM(Quantity) AS TotalQuantitySold,
	COUNT(*) AS TotalTransactions
FROM Product_Sales_Reg
GROUP BY Region, StoreLocation
ORDER BY Region, TotalSalesRevenue DESC;


-- 5. 
-- Promotion Effectiveness
SELECT 
	Promotion,
	COUNT(*) AS TotalTransactions,
	SUM(TotalPrice) AS TotalSalesRevenue,
	SUM(Quantity) AS TotalQuantitySold,
	AVG(UnitPrice) AS AverageUnitPrice
FROM Product_Sales_Reg
GROUP BY Promotion
ORDER BY TotalSalesRevenue DESC;

-- Promotion By Product 
SELECT
    Product,
    Promotion,
    SUM(TotalPrice) AS TotalRevenue
FROM Product_Sales_Reg
GROUP BY Product, Promotion
ORDER BY Product, TotalRevenue DESC;