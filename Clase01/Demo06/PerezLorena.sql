

select * from edutec.dbo.matricula A
where A.FecMatricula BETWEEN '27-11-2018' AND '06-12-2018' 
ORDER BY  A.FecMatricula  DESC;

select
E.iddepartamento,
--e.idcargo,
COUNT(*) emps
from dbo.empleado e
group by E.iddepartamento,
e.idcargo;