use Northwind
GO

create or alter view vw_cities as
select t.cityID, t. cityName, t.regionID, r.RegionDescription, 
r.countryid, c.countryname
from countries c
inner join regiones r on r.CountryID = c.CountryId
inner join cities t on t.RegionID = r.RegionID
go

create or alter view vw_Orders as
select o.OrderId, o.Orderdate,
dia = day(o.Orderdate), mes = datename(mm, o.OrderDate), año=year(o.OrderDate), 
o.freight, o.Employeeid, o.Customerid,

cteNombre=c.companyname,cteCity=cc.cityname, cteRegion=cc.RegionDescription, ctecountry=cc.countryname,

empNombre= e.firstname+' '+e.lastname, empaddress = e.Address, empcity= ce.cityname, empRegion= ce.RegionDescription, empCountry= ce.countryname

from Orders o
inner join customers c on c.CustomerID = o.CustomerID
inner join employees e on e.EmployeeID = o.EmployeeID

inner join vw_cities cc on cc.CityID = c.CityID
inner join vw_cities ce on ce.CityID = e.CityID
go

create or alter view vw_detalle as
select
d.orderid, d.productid, d.quantity, d.discount, 
total = d.UnitPrice * d.quantity
from [Order Details] d
go

create or alter view vw_Products as
select
p.productid, p.productname,
ProvNombre = s.companyname,
ProvCity = t.cityname, ProvRegion = t.regionDescription, ProvCountry = t.countryname
from products p
inner join Suppliers s on s.SupplierID = p.SupplierID
inner join vw_cities t on t.Cityid = s.Cityid
go

GO --> VISTA HECHOS 
SELECT f.SalesOrderLineNumber, f.SalesOrderLineNumber,
customer = c.FirstName + ' ' + c.LastName, 
producto = p.SpanishProductName,
Fecha = d.DayNumberOfMonth + '/' + d.MonthNumberOfYear,
--t.SalesTerritoryCountry, t.SalesTerritoryGroup, t.SalesTerritoryRegion,
t.SalesTerritoryKey,
PiezasVendidas = COUNT (f.OrderQuantity), ClientesAtendidos = COUNT(distinct f.CustomerKey), Total = SUM(ExtendedAmount), subtotal = SUM(SalesAmount)
FROM FactInternetSales f
inner join DimDate d on d.DateKey = f.OrderDateKey
inner join DimSalesTerritory t on t.SalesTerritoryKey = f.SalesTerritoryKey
inner join DimCustomer c on c.CustomerKey = f.CustomerKey
inner join DimProduct p on p.ProductKey = f.ProductKey
group by f.SalesOrderLineNumber, f.SalesOrderLineNumber, c.CustomerKey 
GO