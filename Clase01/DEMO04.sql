Salario maximo por departamento.


select 
	e.iddepartamento,
	MAX(e.sueldo) salario
from RH.dbo.empleado e
group by e.iddepartamento;


select 
	e.iddepartamento,
	MAX(e.sueldo) salario
from RH.dbo.empleado e
group by e.iddepartamento
having MAX(e.sueldo) > 20000;



select 
	e.iddepartamento,
	E.idcargo,
	AVG(e.sueldo) PROMEDIO
from RH.dbo.empleado e
group by e.iddepartamento, E.idcargo;


select 
	e.iddepartamento,
	E.idcargo,
	AVG(e.sueldo) PROMEDIO
from RH.dbo.empleado e
group by CUBE( e.iddepartamento, E.idcargo);


select 
	e.iddepartamento,
	E.idcargo,
	AVG(e.sueldo) PROMEDIO
from RH.dbo.empleado e
group by ROLLUP( e.iddepartamento, E.idcargo);



select 
	e.iddepartamento,
	E.idcargo,
	AVG(e.sueldo) PROMEDIO
from RH.dbo.empleado e
group by GROUPING SETS ( 
(e.iddepartamento, E.idcargo),
(e.iddepartamento),
()
);
