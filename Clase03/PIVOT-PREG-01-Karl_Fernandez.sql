
SELECT CompanyName, 
ISNULL ([1996],0)[1996],
ISNULL ([1997],0)[1997],
ISNULL ([1998],0)[1998]
FROM
(
SELECT CompanyName,Año,sum(Importe)Importe
FROM 
(SELECT a.*,(UnitPrice*Quantity)*(1-Discount) Importe,b.CustomerID,YEAR(b.OrderDate) Año,c.CompanyName
  FROM [Northwind].[dbo].[Order Details] a
  inner join 
  [Northwind].[dbo].[Orders] b
  on a.OrderID = b.OrderID
    INNER JOIN
  [Northwind].[dbo].[Customers] c
  ON B.CustomerID = C.CustomerID
  ) as C
  group by CompanyName,Año
  ) AS TablaDatos
  PIVOT
(
	sum(importe) --siempre va función agregada
	FOR año IN ([1996],[1997],[1998])
) AS PivotTable;
go