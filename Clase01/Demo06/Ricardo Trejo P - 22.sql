
--- Planilla por Departamento

select iddepartamento, SUM(e.sueldo) Planilla_x_Dpto from rh.dbo.empleado e
group by GROUPING sets (iddepartamento)

--- Planilla Total

select SUM(e.sueldo) Planilla_Total from rh.dbo.empleado e

--- Importe General

select iddepartamento, sum(e.sueldo+ISNULL(comision,0)) Importe_General from rh.dbo.empleado e
group by GROUPING sets (iddepartamento)
