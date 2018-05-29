SELECT 
	CompanyName, 
	isnull([1996],0)[1996],
	isnull([1997],0)[1997],
	isnull([1998],0)[1998]
FROM (
	SELECT 
		C.CompanyName, 
		year(O.OrderDate) ANIO, 
		round(( OD.Quantity*OD.UnitPrice)*(1 - OD.Discount),3) MONTO 
	FROM Customers C 
	INNER JOIN Orders  O
	ON C.CustomerID= O.CustomerID
	INNER JOIN [Order Details] OD
	ON O.OrderID= OD.OrderID
) AS DATA
PIVOT (
	SUM(MONTO)
	FOR ANIO IN ([1996] ,[1997],[1998])
)AS PivotTable;
