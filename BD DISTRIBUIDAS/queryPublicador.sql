EXEC sp_addlinkedserver @server = N'REGASADA', @srvproduct = N'SQL Server' ;
EXEC sp_serveroption 'REGASADA', 'DATA ACCESS', TRUE ;

update [LAPTOP-P59U9Q17\INSTANCIANORTH].Northwind.dbo.employees set lastname = 'aaaaaaa' 
where employeeid = 1 --Publicador

select lastname  from [LAPTOP-P59U9Q17\INSTANCIANORTH].[NorthWind].[dbo].employees
where employeeid = 1 --Publicador

select lastname  from [REGASADA].[NothwindIns].[dbo].Employees
where employeeid = 1 --Suscriptor

update [REGASADA].[NothwindIns].dbo.Employees set lastname = 'aaaaaaa' 
where employeeid = 1 --Suscriptor

