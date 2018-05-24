select C.ciudad,COUNT(*) EMPLEADOS
from  RH.dbo.empleado A
inner join RH.dbo.departamento B
on A.iddepartamento=B.iddepartamento
inner join RH.dbo.ubicacion C
on B.idubicacion=C.idubicacion
group by C.ciudad