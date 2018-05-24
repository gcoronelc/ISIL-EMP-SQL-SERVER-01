select A.nombre,sum(B.sueldo ) PLANILLA
from RH.dbo.departamento A
inner join RH.dbo.empleado B
on A.iddepartamento=B.iddepartamento
group by A.nombre