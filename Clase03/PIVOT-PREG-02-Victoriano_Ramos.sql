SELECT * 
FROM (
  SELECT 
	cu.NomCurso NOMBRECURSO, 
	cp.PreCursoProg * cp.Matriculados MONTO,
	DATENAME(MONTH, FecInicio) MES
  FROM [EduTec].[dbo].[CursoProgramado] cp
  INNER JOIN [EduTec].[dbo].Curso cu
  on cp.IdCurso= cu.IdCurso
  INNER JOIN [EduTec].[dbo].Ciclo ci
  on cp.IdCiclo= ci.[IdCiclo]
  WHERE LEFT (cp.IdCiclo,4)=2017
) AS DATA 
PIVOT
(
	sum(MONTO)
	FOR Mes IN ([Enero] ,[Febrero],[Marzo],[Abril],[Mayo],[Junio],[Julio],[Agosto],[Septiembre],[Octubre],[Noviembre],[Diciembre])
) AS PivotTable;