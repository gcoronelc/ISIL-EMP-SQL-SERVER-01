SELECT	
	CAST(SUBSTRING(CONVERT(VARCHAR,M.FecMatricula,112),5,2) AS INT)/4+1 as Trimestre,
	COUNT(M.IdAlumno) As Matriculados,
	SUM(CASE WHEN M.Promedio >= 13 THEN 1 ELSE 0 END) As Aprobados, 
	SUM(CASE WHEN M.Promedio < 13 THEN 1 ELSE 0 END) As Desaprobados
FROM	EDUTEC.dbo.Matricula AS M
WHERE	CONVERT(VARCHAR,M.FecMatricula,112) BETWEEN '20120101' AND '20121231' 
GROUP BY CAST(SUBSTRING(CONVERT(VARCHAR,M.FecMatricula,112),5,2) AS INT)/4+1
ORDER BY 1;



-- CTE

WITH V1 AS (
	SELECT 
		DATEPART(QQ, FecMatricula ) TRIMESTRE,
		Promedio
	FROM EDUTEC.dbo.Matricula 
	WHERE YEAR(FecMatricula) = 2012)
SELECT 
	TRIMESTRE,
	COUNT(*) As Matriculados,
	SUM(CASE WHEN Promedio >= 13 THEN 1 ELSE 0 END) As Aprobados, 
	SUM(CASE WHEN Promedio < 13 THEN 1 ELSE 0 END) As Desaprobados
FROM V1
GROUP BY TRIMESTRE;







