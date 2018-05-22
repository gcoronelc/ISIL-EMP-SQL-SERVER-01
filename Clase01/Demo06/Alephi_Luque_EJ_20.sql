SELECT	RRHH.iddepartamento,RRHH.idcargo,
		SUM(ISNULL(RRHH.sueldo,0)+ISNULL(RRHH.comision,0)) As Planilla
FROM	RH.dbo.empleado As RRHH
GROUP BY GROUPING SETS (
(RRHH.iddepartamento),
(RRHH.idcargo),
()
)
ORDER BY 2,3