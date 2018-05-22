

--select * from edutec.dbo.matricula A
--where A.FecMatricula BETWEEN '27-11-2018' AND '06-12-2018' 
--ORDER BY  A.FecMatricula  DESC;

--select
--E.iddepartamento,
----e.idcargo,
--COUNT(*) emps
--from dbo.empleado e
--group by E.iddepartamento,
--e.idcargo;


--select
--E.iddepartamento,
--e.idcargo,
--COUNT(*) emps
--from dbo.empleado e
--group by cube(E.iddepartamento,e.idcargo)

----- group by rollup

--select
--E.iddepartamento,
--e.idcargo,
--COUNT(*) emps
--from dbo.empleado e
--group by rollup(E.iddepartamento,e.idcargo)


----- group by rollup

--select
--E.iddepartamento,
--e.idcargo,
--COUNT(*) emps
--from dbo.empleado e
--group by grouping sets (
--(E.iddepartamento,e.idcargo),
--()
--);

--select * from dbo.empleado
use RH
go

select
E.iddepartamento Dep,
e.idcargo Puesto,
SUM(e.sueldo)  as Planilla
--COUNT(*) emps
from dbo.empleado e
group by cube(e.idcargo,E.iddepartamento)