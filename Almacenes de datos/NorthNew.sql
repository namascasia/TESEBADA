USE Northwind
GO
UPDATE Employees SET Region = 'SR ' + Country WHERE Region IS NULL
UPDATE Customers SET Region = 'SR ' + Country WHERE Region IS NULL
UPDATE Suppliers SET Region = 'SR ' + Country WHERE Region IS NULL
GO
-->CREAR TABLA AUXILIAR PARA METER TODOS LOS PAISES
CREATE TABLE AUX (
	Countryid int not null,
	CountryName nvarchar(15) null
)
GO 
-->LLENAR COUNTRIES CON TABLAS DE EMPLOYEES, CUSTOMERS, SUPPLIERS
INSERT INTO AUX SELECT Country FROM Suppliers 
INSERT INTO AUX SELECT Country FROM Employees 
INSERT INTO AUX SELECT Country FROM Customers 
SELECT * FROM AUX
delete aux
GO
-->ELIMINAMOS DUPLICADOS
CREATE OR ALTER PROC ELIMINARCOUNTRIES
AS 
BEGIN
	DECLARE @country NVARCHAR(50), @id INT
	select @id = MIN(Countryid) from AUX
	select @country = CountryName from AUX where Countryid = @id

	while @id is not null
	begin
		
		DELETE FROM AUX WHERE CountryName = @country and Countryid <> @id

		SELECT @id = MIN(Countryid) from AUX where Countryid > @id
		SELECT @country = CountryName from AUX where Countryid = @id
	end
END
GO
EXEC ELIMINARCOUNTRIES
GO
 /*ELIMINAMOS DUPLICADOS 
 WITH C AS
 (
  SELECT Countryid, CountryName,
  ROW_NUMBER() OVER (PARTITION BY 
                    CountryName
                    ORDER BY Countryid) AS DUPLICADO
  FROM AUX
 )
 DELETE FROM C 
 WHERE DUPLICADO > 1
 GO*/
--> PASAR LA TABLA CON LOS DATOS LISTOS A UNA QUE NO TENGA IDENTITY
CREATE TABLE Countries (
	Countryid int not null,
	CountryName nvarchar(15) null
)
GO
INSERT INTO Countries SELECT * FROM AUX
DROP TABLE AUX
GO
SELECT * FROM Countries
GO

--> REGIONES
-->CREAR TABLA AUXILIAR PARA METER TODAS LAS REGIONES
CREATE TABLE AUXReg(
	regionid INT NOT NULL IDENTITY, 
	regiondescription nvarchar(15) NULL,
	country NVARCHAR(15) NULL,
	countryid INT NULL
)
GO
INSERT INTO AUXReg(regiondescription,country)  SELECT region, country FROM Suppliers
INSERT INTO AUXREG(regiondescription,country)  SELECT region, country FROM Customers
INSERT INTO AUXReg(regiondescription,country)  SELECT region, country FROM Employees
DELETE FROM AUXReg WHERE regiondescription IS NULL
GO
CREATE OR ALTER PROC AGREGARCOUNTRY
AS 
BEGIN
	 
	DECLARE @country NVARCHAR(50), @id INT, @countryid INT, @region NVARCHAR(15)
	SELECT @id = MIN(regionid) FROM AUXReg
	SELECT @country = country FROM AUXreg WHERE regionid = @id;
	SELECT @region = regiondescription from AUXReg where regionid = @id

	while @id is not null
	begin
		
		SELECT @countryid = Countryid FROM Countries WHERE CountryName = @country
		
		UPDATE auxreg set countryid = @countryid WHERE regionid = @id
		DELETE FROM AUXReg WHERE regiondescription = @region and regionid <> @id
		SELECT @id = MIN(regionid) FROM auxreg WHERE regionid > @id
		SELECT @country = country FROM AUXreg WHERE regionid = @id
		SELECT @region = regiondescription from AUXReg where regionid = @id

	end
END
GO
Exec AGREGARCOUNTRY
GO
SELECT * FROM AUXReg
GO
-->PASAR LA TABLA CON LOS DATOS LISTOS A UNA QUE NO TENGA IDENTITY
CREATE TABLE Regiones (
	Regionid int not null,
	RegionDescription nvarchar(15) null,
	Countryid int not null
)
GO
INSERT INTO Regiones(Regionid, RegionDescription, Countryid) SELECT regionid, regiondescription, countryid FROM AUXReg
DROP TABLE AUXReg
GO
SELECT * FROM Regiones
GO

-->CITIES
CREATE TABLE AUXCity(
	cityid INT NOT NULL IDENTITY, 
	cityName nvarchar(15) NULL,
	region NVARCHAR(15) NULL,
	regionid INT NULL
)
GO
INSERT INTO AUXCity(cityName, region)  SELECT city, region FROM Suppliers
INSERT INTO AUXCity(cityName, region)  SELECT city, region FROM Customers
INSERT INTO AUXCity(cityName, region)  SELECT city, region FROM Employees
GO
CREATE OR ALTER PROC AGREGARCITY
AS 
BEGIN
	 
	DECLARE @region NVARCHAR(50), @id INT, @regionid INT, @city NVARCHAR(15)
	SELECT @id = MIN(cityid) FROM AUXCity
	SELECT @region = region FROM AUXCity WHERE cityid = @id;
	SELECT @city = cityName from AUXCity where cityid = @id

	while @id is not null
	begin
		
		SELECT @regionid = regionid FROM regiones WHERE RegionDescription = @region
		
		UPDATE AUXCity set regionid = @regionid WHERE cityid = @id
		DELETE FROM AUXCity WHERE cityName = @city and cityid <> @id

			SELECT @id = MIN(cityid) FROM AUXCity WHERE cityid > @id
	SELECT @region = region FROM AUXCity WHERE cityid = @id;
	SELECT @city = cityName from AUXCity where cityid = @id

	end
END
GO
Exec AGREGARCITY
GO
SELECT * FROM AUXCity
GO
-->PASAR LA TABLA CON LOS DATOS LISTOS A UNA QUE NO TENGA IDENTITY
CREATE TABLE Cities (
	Cityid int not null,
	CityName nvarchar(15) null,
	Regionid int null
)
GO
INSERT INTO Cities(Cityid, CityName, Regionid) SELECT cityid, cityName, regionid FROM AUXCity
DROP TABLE AUXCity
GO
SELECT * FROM Cities
GO
-->CREACION Y MODIFICACION DE PK y FK
--TABLA DE COUNTRIES
ALTER TABLE COUNTRIES ADD CONSTRAINT PK_COUNTRY PRIMARY KEY (COUNTRYID)
--TABLA DE REGIONES
ALTER TABLE REGIONES ADD CONSTRAINT PK_REGIONES PRIMARY KEY (REGIONID)
ALTER TABLE REGIONES ADD CONSTRAINT FK_COUNTRY_REGION FOREIGN KEY (COUNTRYID) REFERENCES COUNTRIES (COUNTRYID)
--TABLA DE CITIES
ALTER TABLE CITIES ADD CONSTRAINT PK_CITY PRIMARY KEY (CITYID)
ALTER TABLE CITIES ADD CONSTRAINT FK_REGION_CITY FOREIGN KEY (REGIONID) REFERENCES REGIONES(REGIONID)
GO
--> SUPPLIERS
ALTER TABLE SUPPLIERS ADD Cityid int null -->Agregamos columna para cityid
GO
CREATE OR ALTER PROC AGREGARCITYID
AS 
BEGIN
	 
	DECLARE @Supplier NVARCHAR(50), @Supplierid INT, @cityid INT, @cityname NVARCHAR(15)
	SELECT @Supplierid = MIN(SupplierID) FROM Suppliers
	SELECT @cityname = City FROM Suppliers WHERE SupplierID = @Supplierid;

	while @Supplierid is not null
	begin
		
		SELECT @cityid = cityid FROM Cities WHERE CityName = @cityname
		
		UPDATE Suppliers set Cityid = @cityid WHERE SupplierID = @Supplierid

		SELECT @Supplierid = MIN(SupplierID) FROM Suppliers WHERE SupplierID > @Supplierid
		SELECT @cityname = City FROM Suppliers WHERE SupplierID = @Supplierid;
	end
END
GO
EXEC AGREGARCITYID
GO
select City, cityid from Suppliers
select * from Cities
GO
ALTER TABLE SUPPLIERS DROP COLUMN CITY, REGION, COUNTRY
select * from Suppliers
ALTER TABLE SUPPLIERS ADD CONSTRAINT FK_CITYID FOREIGN KEY (CITYID) REFERENCES CITIES (CITYID)
GO
--> CUSTOMERS
ALTER TABLE CUSTOMERS ADD Cityid int null -->Agregamos columna para cityid
GO
CREATE OR ALTER PROC AGREGARCITY_COSTUMERS
AS 
BEGIN
	 
	DECLARE @Customer NVARCHAR(50), @Customerid char (5), @cityid INT, @cityname NVARCHAR(15)
	SELECT @Customerid = MIN(CustomerID) FROM Customers
	SELECT @cityname = City FROM Customers WHERE CustomerID = @Customerid;
	
	while @Customerid is not null
	begin
		
		SELECT @cityid = cityid FROM Cities WHERE CityName = @cityname
		
		UPDATE Customers set Cityid = @cityid WHERE CustomerID = @Customerid

		SELECT @Customerid = MIN(CustomerID) FROM Customers WHERE CustomerID > @Customerid
		SELECT @cityname = City FROM Customers WHERE CustomerID = @Customerid;
	end
END
GO
EXEC AGREGARCITY_COSTUMERS
GO
Select * from Customers
DROP INDEX CITY ON CUSTOMERS
GO
DROP INDEX REGION ON CUSTOMERS
GO
ALTER TABLE CUSTOMERS DROP COLUMN REGION, CITY, COUNTRY
GO
select * from Customers
ALTER TABLE CUSTOMERS ADD CONSTRAINT FK_CITYCUSTOMER FOREIGN KEY (CITYID) REFERENCES CITIES (CITYID)
GO
select * from Cities
GO

--> EMPLOYEES
ALTER TABLE EMPLOYEES ADD Cityid int null -->Agregamos columna para cityid
GO
CREATE OR ALTER PROC AGREGARCITY_EMPLOYEES
AS 
BEGIN
	 
	DECLARE @employee NVARCHAR(50), @Employeeid int, @cityid INT, @cityname NVARCHAR(15)
	SELECT @Employeeid  = MIN(employeeID) FROM Employees
	SELECT @cityname = City FROM Employees WHERE EmployeeID = @Employeeid;
	
	while @Employeeid is not null
	begin
		
		SELECT @cityid = cityid FROM Cities WHERE CityName = @cityname
		
		UPDATE Employees set Cityid = @cityid WHERE employeeid = @Employeeid 

		SELECT @Employeeid  = MIN(employeeID) FROM Employees WHERE employeeid > @Employeeid
		SELECT @cityname = City FROM Employees WHERE EmployeeID = @Employeeid;
	end
END
GO
EXEC AGREGARCITY_EMPLOYEES
GO
Select * from Employees
ALTER TABLE employees DROP COLUMN CITY, REGION, COUNTRY -->NO ELIMINA LAS COLUMNAS
select * from employees
ALTER TABLE employees ADD CONSTRAINT FK_CITYEMPLOYEES FOREIGN KEY (CITYID) REFERENCES CITIES (CITYID)
