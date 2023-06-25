EXEC sp_addlinkedserver @server = N'esparza\SQL2008', @srvproduct = N'SQL Server' ;
EXEC sp_serveroption 'esparza\SQL2008', 'DATA ACCESS', TRUE ;

update northwindM.dbo.employees set lastname = 'Pedro' 
where employeeid = 1

select lastname from northwindM.dbo.employees 
where employeeid = 1

select lastname from northwindIns.dbo.employees 
where employeeid = 1
