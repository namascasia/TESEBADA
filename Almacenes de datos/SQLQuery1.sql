EXEC sp_addlinkedserver @server = N'DESKTOP-BT5BO9U'
EXEC sp_serveroption 'DESKTOP-BT5BO9U\SQLSERVER', 'DATA ACCESS', true

go
create database NWTranAct1
go
use NWTranAct1
select *  into products from [DESKTOP-BT5BO9U\SQLSERVER].Northwind.dbo.products
go
alter table products add constraint pk_p primary key ( productid ) 
go
create database NWTranAct2
go
use NWTranAct2
select *  into products from [DESKTOP-BT5BO9U\SQLSERVER].Northwind.dbo.products
go
alter table products add constraint pk_p primary key ( productid ) 

use Northwind
go
CREATE TABLE Products2 (
 ProductID int not null,
 ProductName nvarchar (40) not null,
 SupplierID int null,
 CategoryID int null,
 QuantityPerUnit nvarchar (20) null,
 UnitPrice money null,
 UnitsInStock smallint null,
 UnitsOnOrder smallint null,
 ReorderLevel smallint null,
 Discontinued bit not null
)
go
alter table Products2 add constraint pk_p primary key (ProductID)
go
insert Products2 select * from Products
