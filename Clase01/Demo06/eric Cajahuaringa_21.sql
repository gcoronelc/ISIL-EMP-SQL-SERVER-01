select e.iddepartamento departamento,e.idcargo puesto,sum(e.sueldo) planilla from RH.dbo.empleado e
group by grouping sets(
(e.iddepartamento,e.idcargo),(e.iddepartamento),
()
);