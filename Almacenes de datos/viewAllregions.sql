CREATE VIEW AllRegions 
AS
SELECT ReportingDate, 
SUM([Quantity]) as SumQty, AVG([Quantity]) as AvgQty,
SUM([Amount]) AS SumAmt, AVG([Amount]) AS AvgAmt,
'All Regions' as [Region]
FROM dbo.vTimeSeries 
GROUP BY ReportingDate
go
CREATE OR ALTER VIEW [T1000 Pacific Region] AS
SELECT ReportingDate, ModelRegion, Quantity, Amount
FROM dbo.vTimeSeries
WHERE (ModelRegion = N'T1000 Pacific')
go
