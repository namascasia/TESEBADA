EXEC sp_serveroption 'REGASADA', 'DATA ACCESS', TRUE;
GO

-- modificar en el publicador
update [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind.dbo.products set unitprice = 252 where productid = 2

-- verificar en el publicador y suscriptores
select unitprice from [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind.dbo.products where productid =2
select unitprice from [REGASADA].NWTranAct1.dbo.products2 where productid =2
select unitprice from [REGASADA].NWTranAct2.dbo.products2 where productid =2

-- modificar en el suscriptor
 update [REGASADA].NWTranAct2.dbo.products2 set unitprice = 7 where productid = 2

-- verificar en el publicador y suscriptores 
select unitprice from [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind2.dbo.products where productid =2
select unitprice from [REGASADA].NWTranAct1.dbo.products2 where productid =2
select unitprice from [REGASADA].NWTranAct2.dbo.products2 where productid =2
