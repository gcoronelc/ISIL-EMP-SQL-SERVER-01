select iddepartamento DEPARTAMENTO, 
idcargo PUESTO ,sum(sueldo) PLANILLA
from RH.dbo.empleado
group by  rollup (iddepartamento, idcargo);