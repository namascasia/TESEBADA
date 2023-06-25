use AdventureWorksDW2008R2
GO-->VISTA TERRITORIOS
CREATE OR ALTER VIEW VW_TERRITORY AS
SELECT 
SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup
from DimSalesTerritory

go-->VISTA PRODUCTOS
CREATE OR ALTER VIEW VW_PRODUCTS AS
SELECT 
d.ProductKey, s.SpanishProductSubcategoryName, d.SpanishProductName, c.SpanishProductCategoryName, d.Status
FROM DimProduct d
inner join DimProductSubcategory s on s.ProductSubcategoryKey = d.ProductSubcategoryKey
inner join DimProductCategory c on c.ProductCategoryKey  = s.ProductCategoryKey

go-->VISTA CUSTOMERS
CREATE OR ALTER VIEW VW_CUSTOMERS AS
SELECT 
c.CustomerKey, Nombre = c.FirstName + ' ' + c.LastName, c.AddressLine1, g.GeographyKey, 
t.SalesTerritoryCountry, t.SalesTerritoryRegion, t.SalesTerritoryGroup
FROM DimCustomer c
inner join DimGeography g on c.GeographyKey = g.GeographyKey
inner join DimSalesTerritory t on t.SalesTerritoryKey = g.SalesTerritoryKey

GO -->FACTINTERNETSALES
Create OR alter view vw_InternetSales
as
select 
SalesOrderNumber, SalesOrderLineNumber,
OrderDateKey, SalesTerritoryKey,  ProductKey, CustomerKey,
ExtendedAmount, SalesAmount, OrderQuantity
from FactInternetSales 
Go -->FECHA 
CREATE OR ALTER VIEW VW_TIEMPO AS
SELECT
DateKey, DIA = DayNumberOfMonth, MES = MonthNumberOfYear, AÑO = CalendarYear
FROM DimDate
GO