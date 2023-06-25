EXEC sp_serveroption 'DESKTOP-BT5BO9U\SQLSERVER', 'DATA ACCESS', true

select address from [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind.dbo.Customers where CustomerID = 'BOLID'

update [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind.dbo.Customers set address = 'CC C 44' where CustomerID = 'BLONP' 


select address from [DESKTOP-BT5BO9U\SQLSERVER].NorthwindTrans.dbo.Customers 
where CustomerID = 'BLONP' 

--Validar que cuando se actualiza un registro en el suscriptor, nunca llega al publicador.
-- Suscriptor
select address from [DESKTOP-BT5BO9U\SQLSERVER].NorthwindTrans.dbo.Customers 
where CustomerID = 'BOLID' 

-- Actualizar un cliente en el suscriptor
update [DESKTOP-BT5BO9U\SQLSERVER].Northwind.dbo.Customers set address = 'centro 555' where CustomerID = 'BOLID'

-- Publicador: revisar que no se realizo la actualización en el publicador
select address from [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind.dbo.Customers where CustomerID = 'BOLID' 

-- Hasta que se actualiza nuevamente el precio en el publicador, se actualiza en el suscriptor
update [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind.dbo.Customers set address = 'Av Obregon 12' where CustomerID = 'BOLID' 

