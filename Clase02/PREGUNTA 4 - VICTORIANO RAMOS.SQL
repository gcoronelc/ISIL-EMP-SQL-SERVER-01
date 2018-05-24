SELECT  empleado.nombre empleados ,jefe.nombre jefe
 FROM dbo.empleado jefe
LEFT JOIN dbo.empleado empleado
ON jefe.jefe= empleado.idempleado
WHERE empleado.nombre IS NOT NULL
GO