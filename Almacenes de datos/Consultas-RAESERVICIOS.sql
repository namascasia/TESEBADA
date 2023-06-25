-->1
Select g.nombre, v.nomven,
'ALL' =sum(r.MONTOINVERSION),
'2005' = sum(case when year(r.FECHA) = 2005 then r.MONTOINVERSION end),
'2006' = sum(case when year(r.FECHA) = 2006 then r.MONTOINVERSION end),
'2007' = sum(case when year(r.FECHA) = 2007 then r.MONTOINVERSION end),
'2008' = sum(case when year(r.FECHA) = 2008 then r.MONTOINVERSION end),
'2009' = sum(case when year(r.FECHA) = 2009 then r.MONTOINVERSION end),
'2010' = sum(case when year(r.FECHA) = 2010 then r.MONTOINVERSION end)
From RAESERVICIOS r
Inner join ventanillas v on r.ventanilla = v.ventanilla
Inner join grupos g on v.grupo = g.grupo
Group by g.nombre, v.nomven 
-->2
SELECT CONVERT(VARCHAR(4),YEAR(R.FECHA)) AS 'A�O', 
SUM (CASE WHEN G.NOMBRE = 'FOSIN' THEN R.MONTOINVERSION END )AS 'FOSIN',
SUM (CASE WHEN G.NOMBRE = 'URGE' THEN R.MONTOINVERSION END )AS 'URGE'
FROM GRUPOS G
INNER JOIN VENTANILLAS V ON V.GRUPO = G.GRUPO
INNER JOIN RAESERVICIOS R ON R.VENTANILLA = V.VENTANILLA
GROUP BY YEAR(R.FECHA),G.NOMBRE
UNION
SELECT
'ALL', 
SUM (CASE WHEN G.NOMBRE = 'FOSIN' THEN R.MONTOINVERSION END )AS 'FOSIN',
SUM (CASE WHEN G.NOMBRE = 'URGE' THEN R.MONTOINVERSION END )AS 'URGE'
FROM GRUPOS G
INNER JOIN VENTANILLAS V ON V.GRUPO = G.GRUPO
INNER JOIN RAESERVICIOS R ON R.VENTANILLA = V.VENTANILLA
-->3
SELECT 
'GESTION EMPRESARIAL' = SUM (CASE WHEN SB.FAMILIA = 1 THEN
EMPLEOSGENERAR END)
FROM SERVICIOS S
INNER JOIN SUBFAMILIAS SB ON SB.SUBFAMILIA = S.SUBFAMILIA
INNER JOIN FAMILIAS F ON F.FAMILIA = SB.FAMILIA
INNER JOIN RAESERVICIOS R ON R.SERVICIO = S.SERVICIO
GROUP BY MONTH (R.Fecha)
-->4
SELECT ' ALL' AS [Nombre de Usuario],
'All'= sum (r.EMPLEOSGENERAR),
'2005'= sum(case when year(r.FECHA) =2005 then r.EMPLEOSGENERAR end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.EMPLEOSGENERAR end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.EMPLEOSGENERAR end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.EMPLEOSGENERAR end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.EMPLEOSGENERAR end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.EMPLEOSGENERAR end )
from RAESERVICIOS r
INNER JOIN USUARIOS U ON U.USUARIO = R.USUARIO
UNION
SELECT U.NOMBRE,
'All'= sum (r.EMPLEOSGENERAR),
'2005'= sum(case when year(r.FECHA) =2005 then r.EMPLEOSGENERAR end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.EMPLEOSGENERAR end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.EMPLEOSGENERAR end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.EMPLEOSGENERAR end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.EMPLEOSGENERAR end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.EMPLEOSGENERAR end )
from RAESERVICIOS r
INNER JOIN USUARIOS U ON U.USUARIO = R.USUARIO
GROUP BY U.NOMBRE
ORDER BY 1 ASC
-->5
SELECT
V.NOMVEN,
SUM(RS.EMPLEOSGENERAR) AS 'ALL',
SUM(CASE WHEN MONTH(RS.FECHA) = 1 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '1',
SUM(CASE WHEN MONTH(RS.FECHA) = 2 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '2',
SUM(CASE WHEN MONTH(RS.FECHA) = 3 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '3',
SUM(CASE WHEN MONTH(RS.FECHA) = 4 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '4',
SUM(CASE WHEN MONTH(RS.FECHA) = 5 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '5',
SUM(CASE WHEN MONTH(RS.FECHA) = 6 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '6',
SUM(CASE WHEN MONTH(RS.FECHA) = 7 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '7',
SUM(CASE WHEN MONTH(RS.FECHA) = 8 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '8',
SUM(CASE WHEN MONTH(RS.FECHA) = 9 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '9',
SUM(CASE WHEN MONTH(RS.FECHA) = 10 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '10',
SUM(CASE WHEN MONTH(RS.FECHA) = 11 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '11',
SUM(CASE WHEN MONTH(RS.FECHA) = 12 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '12'
FROM RAESERVICIOS RS
RIGHT JOIN VENTANILLAS V ON V.VENTANILLA = RS.VENTANILLA
GROUP BY V.NOMVEN
UNION
SELECT 
'ALL',
SUM(RS.EMPLEOSGENERAR) AS 'ALL',
SUM(CASE WHEN MONTH(RS.FECHA) = 1 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '1',
SUM(CASE WHEN MONTH(RS.FECHA) = 2 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '2',
SUM(CASE WHEN MONTH(RS.FECHA) = 3 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '3',
SUM(CASE WHEN MONTH(RS.FECHA) = 4 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '4',
SUM(CASE WHEN MONTH(RS.FECHA) = 5 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '5',
SUM(CASE WHEN MONTH(RS.FECHA) = 6 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '6',
SUM(CASE WHEN MONTH(RS.FECHA) = 7 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '7',
SUM(CASE WHEN MONTH(RS.FECHA) = 8 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '8',
SUM(CASE WHEN MONTH(RS.FECHA) = 9 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '9',
SUM(CASE WHEN MONTH(RS.FECHA) = 10 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '10',
SUM(CASE WHEN MONTH(RS.FECHA) = 11 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '11',
SUM(CASE WHEN MONTH(RS.FECHA) = 12 THEN RS.EMPLEOSGENERAR ELSE NULL END) AS '12'
FROM RAESERVICIOS RS
-->6
select 'ALL' as [Mes],
'ALL'= sum (r.EMPLEOSGENERAR),
'2005'= sum(case when year(r.FECHA) =2005 then r.EMPLEOSGENERAR end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.EMPLEOSGENERAR end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.EMPLEOSGENERAR end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.EMPLEOSGENERAR end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.EMPLEOSGENERAR end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.EMPLEOSGENERAR end )
from raeservicios r
union
select cast(month(r.FECHA) as varchar),
'ALL'= sum (r.EMPLEOSGENERAR),
'2005'= sum(case when year(r.FECHA) =2005 then r.EMPLEOSGENERAR end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.EMPLEOSGENERAR end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.EMPLEOSGENERAR end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.EMPLEOSGENERAR end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.EMPLEOSGENERAR end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.EMPLEOSGENERAR end )
from raeservicios r
group by month(r.FECHA)
ORDER BY 1 ASC
-->7
SELECT G.NOMBRE as [NOMBRE DE GRUPO] ,
'MONTO DE INVERSION' = SUM(CASE MONTOINVERSION WHEN MONTOINVERSION THEN
MONTOINVERSION ELSE 0 END) ,
'EMPLEOS A GENERAR' = SUM(CASE EMPLEOSGENERAR WHEN EMPLEOSGENERAR THEN
EMPLEOSGENERAR ELSE 0 END),
'EMPLEOS TEMPORALES' = SUM(CASE EMPLEOSTEMP WHEN EMPLEOSTEMP THEN EMPLEOSTEMP ELSE 0
END),
'MONTO FINAL' = SUM(CASE MONTOFINAL WHEN MONTOFINAL THEN MONTOFINAL ELSE 0 END)
FROM RAESERVICIOS R
INNER JOIN VENTANILLAS V ON V.VENTANILLA = R.VENTANILLA
INNER JOIN GRUPOS G ON G.GRUPO = V.GRUPO
GROUP BY G.NOMBRE
ORDER BY 1 ASC
-->8
SELECT 'MontoInversion',
' All'= sum (r.MONTOINVERSION),
'2005'= sum(case when year(r.FECHA) =2005 then r.MONTOINVERSION end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.MONTOINVERSION end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.MONTOINVERSION end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.MONTOINVERSION end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.MONTOINVERSION end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.MONTOINVERSION end )
from RAESERVICIOS r
union
SELECT 'EmpleosGenerar',
' All'= sum (r.EMPLEOSGENERAR),
'2005'= sum(case when year(r.FECHA) =2005 then r.EMPLEOSGENERAR end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.EMPLEOSGENERAR end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.EMPLEOSGENERAR end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.EMPLEOSGENERAR end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.EMPLEOSGENERAR end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.EMPLEOSGENERAR end )
from RAESERVICIOS r
union
SELECT 'EmpleosTemp',
' All'= sum (r.EMPLEOSTEMP),
'2005'= sum(case when year(r.FECHA) =2005 then r.EMPLEOSTEMP end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.EMPLEOSTEMP end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.EMPLEOSTEMP end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.EMPLEOSTEMP end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.EMPLEOSTEMP end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.EMPLEOSTEMP end )
from RAESERVICIOS r
union
SELECT 'MontoFinal',
' All' = sum(r.MONTOFINAL),
'2005'= sum(case when year(r.FECHA) =2005 then r.MONTOFINAL end ),
'2006'= sum(case when year(r.FECHA) =2006 then r.MONTOFINAL end ) ,
'2007'= sum(case when year(r.FECHA) =2007 then r.MONTOFINAL end ) ,
'2008'= sum(case when year(r.FECHA) =2008 then r.MONTOFINAL end ) ,
'2009'= sum(case when year(r.FECHA) =2009 then r.MONTOFINAL end ) ,
'2010'= sum(case when year(r.FECHA) =2010 then r.MONTOFINAL end )
from RAESERVICIOS r
-->9
SELECT 'ALL',
'MONTOINVERSION' = SUM(CASE MONTOINVERSION WHEN MONTOINVERSION THEN MONTOINVERSION
ELSE 0 END),
'EMPLEOSGENERAR' = SUM(CASE EMPLEOSGENERAR WHEN EMPLEOSGENERAR THEN EMPLEOSGENERAR
ELSE 0 END),
'EMPLEOSTEMP' = SUM(CASE EMPLEOSTEMP WHEN EMPLEOSTEMP THEN EMPLEOSTEMP ELSE 0 END),
'MONTOFINAL' = SUM(CASE MONTOFINAL WHEN MONTOFINAL THEN MONTOFINAL ELSE 0 END)
FROM RAESERVICIOS R
INNER JOIN SERVICIOS SE ON SE.SERVICIO = R.SERVICIO
INNER JOIN SUBFAMILIAS S ON S.SUBFAMILIA = SE.SUBFAMILIA
INNER JOIN FAMILIAS F ON F.FAMILIA = S.FAMILIA
UNION
SELECT F.NOMBRE,
'MONTOINVERSION' = SUM(CASE MONTOINVERSION WHEN MONTOINVERSION THEN MONTOINVERSION
ELSE 0 END),
'EMPLEOSGENERAR' = SUM(CASE EMPLEOSGENERAR WHEN EMPLEOSGENERAR THEN EMPLEOSGENERAR
ELSE 0 END),
'EMPLEOSTEMP' = SUM(CASE EMPLEOSTEMP WHEN EMPLEOSTEMP THEN EMPLEOSTEMP ELSE 0 END),
'MONTOFINAL' = SUM(CASE MONTOFINAL WHEN MONTOFINAL THEN MONTOFINAL ELSE 0 END)
FROM RAESERVICIOS R
INNER JOIN SERVICIOS SE ON SE.SERVICIO = R.SERVICIO
INNER JOIN SUBFAMILIAS S ON S.SUBFAMILIA = SE.SUBFAMILIA
INNER JOIN FAMILIAS F ON F.FAMILIA = S.FAMILIA
GROUP BY F.NOMBRE
ORDER BY 1 ASC
-->10
SELECT
CONVERT(NVARCHAR(4),YEAR(R.FECHA)) AS 'A�O',
SUM(CASE WHEN MONTH(R.FECHA) = 1 THEN R.EMPLEOSGENERAR ELSE NULL END) AS '1',
SUM(CASE WHEN MONTH(R.FECHA) = 2 THEN R.EMPLEOSGENERAR ELSE NULL END) AS '2',
SUM(CASE WHEN MONTH(R.FECHA) = 3 THEN R.EMPLEOSGENERAR ELSE NULL END) AS '3'
FROM RAESERVICIOS R
GROUP BY YEAR(R.FECHA)
UNION
SELECT 
'ALL',
SUM(CASE WHEN MONTH(R.FECHA) = 1 THEN R.EMPLEOSGENERAR ELSE NULL END) AS '1',
SUM(CASE WHEN MONTH(R.FECHA) = 2 THEN R.EMPLEOSGENERAR ELSE NULL END) AS '2',
SUM(CASE WHEN MONTH(R.FECHA) = 3 THEN R.EMPLEOSGENERAR ELSE NULL END) AS '3'
FROM RAESERVICIOS R