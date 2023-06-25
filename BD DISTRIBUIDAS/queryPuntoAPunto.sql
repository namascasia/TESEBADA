EXEC sp_serveroption 'DESKTOP-BT5BO9U\SQLSERVER', 'DATA ACCESS', TRUE;
GO

-- modificar en el publicador
update [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind2.dbo.products set unitprice = 252 where productid = 2

-- verificar en el publicador y suscriptores
select unitprice from [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind2.dbo.products where productid =2
select unitprice from [DESKTOP-BT5BO9U\SQLSERVER].NWTranAct1.dbo.products where productid =2
select unitprice from [DESKTOP-BT5BO9U\SQLSERVER].NWTranAct2.dbo.products where productid =2

-- modificar en el suscriptor
 update [DESKTOP-BT5BO9U\SQLSERVER].NWTranAct1.dbo.products set unitprice = 7 where productid = 2
 update [DESKTOP-BT5BO9U\SQLSERVER].NWTranAct2.dbo.products set unitprice = 999 where productid = 2

-- verificar en el publicador y suscriptores 
select unitprice from [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind2.dbo.products where productid =2
select unitprice from [DESKTOP-BT5BO9U\SQLSERVER].NWTranAct1.dbo.products where productid =2
select unitprice from [DESKTOP-BT5BO9U\SQLSERVER].NWTranAct2.dbo.products where productid =2
