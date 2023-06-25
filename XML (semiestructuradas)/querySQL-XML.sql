--Tablas de northwind solicitadas 
select SupplierID, CompanyName, ContactName, ContactTitle, Address, PostalCode, Phone, Fax, Cityid
from suppliers-->Quitamos HomePage
go
select CategoryID, CategoryName
from categories-->Quitamos Picture y description
go
select * 
from products-->No quitamos nada
go
SELECT 
    (SELECT CATEGORYID, CATEGORYNAME
	 FROM CATEGORIES-->QUITAMOS PICTURE Y DESCRIPTION
     FOR XML PATH('CATEGORY'), ROOT('CATEGORIES'), TYPE),

    (SELECT *
     FROM PRODUCTS
     FOR XML PATH('PRODUCT'), ROOT('PRODUCTS'), TYPE),

    (SELECT SUPPLIERID, COMPANYNAME, CONTACTNAME, CONTACTTITLE, ADDRESS, POSTALCODE, PHONE, FAX, CITYID
	 FROM SUPPLIERS-->QUITAMOS HOMEPAGE
     FOR XML PATH('SUPPLIER'), ROOT('SUPPLIERS'), TYPE)

	FOR XML PATH('NORTHWIND')
