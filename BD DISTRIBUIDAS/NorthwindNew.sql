use Northwind
GO
-- 1.- Actualizar el campo Region que son nulos en las 3 tablas Employees, Customers, Suppliers,
-- actualizarlo como region = 'SR ' + country
UPDATE Employees SET Region = 'SR' + Country
UPDATE Customers SET Region = 'SR' + Country
UPDATE Suppliers SET Region = 'SR' + Country
GO
-- 2.- Crear la tabla Countries ( CountyID , CountryName ) y llenarla con los datos del campo Country de las tablas Employees, Customers y Suppliers.
CREATE TABLE Countries (
	CountryId INT NOT NULL,
	CountryName NVARCHAR(15) null
)
GO
-->LLENAR COUNTRIES CON TABLAS DE EMPLOYEES, CUSTOMERS, SUPPLIERS
GO

CREATE OR ALTER PROC AGREGAR_COUNTRY @country NVARCHAR(15) AS
BEGIN
	
	IF NOT EXISTS (SELECT CountryName FROM Countries WHERE CountryName = @country)
	BEGIN
		DECLARE @id INT = 0
		SELECT @id = COUNT(*) + 1 FROM Countries

		INSERT Countries VALUES(@id, @country)
	END
END
GO
CREATE OR ALTER PROC RECORRER_CUSTOMERS AS
BEGIN
	DECLARE @customerid NCHAR(5), @country NVARCHAR(15)
	SELECT @customerid = MIN(customerid) FROM Customers
	SELECT @country = country FROM Customers WHERE CustomerID = @customerid

	WHILE @customerid IS NOT NULL
	BEGIN
		
		EXEC AGREGAR_COUNTRY @country


	END
END