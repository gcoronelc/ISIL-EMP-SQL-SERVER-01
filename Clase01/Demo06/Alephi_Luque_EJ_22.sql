SELECT	RRHH.iddepartamento,
		SUM(ISNULL(RRHH.sueldo,0)+ISNULL(RRHH.comision,0)) As Planilla
FROM	RH.dbo.empleado As RRHH
GROUP BY GROUPING SETS (
(RRHH.iddepartamento),
()
)