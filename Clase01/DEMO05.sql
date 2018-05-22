
-- FORMA CLASICA

select 
	e.iddepartamento,
	e.idcargo,
	COUNT(*) emps
from RH.dbo.empleado e
group by e.iddepartamento, e.idcargo
union
select t.iddepartamento, null, t.emps
from (select 
			e.iddepartamento,
			COUNT(*) emps
		from RH.dbo.empleado e
		group by e.iddepartamento) t
union
select null, null, t.emps
from (select 
			COUNT(*) emps
		from RH.dbo.empleado e) t;
		
-- GROUP BY CUBE

select 
	e.iddepartamento,
	e.idcargo,
	COUNT(*) emps
from RH.dbo.empleado e
group by CUBE(e.iddepartamento, e.idcargo);


-- GROUP BY ROLLUP

select 
	e.iddepartamento,
	e.idcargo,
	COUNT(*) emps
from RH.dbo.empleado e
group by ROLLUP(e.iddepartamento, e.idcargo);



-- GROUP BY GROUPING SETS

select 
	e.iddepartamento,
	e.idcargo,
	COUNT(*) emps
from RH.dbo.empleado e
group by GROUPING SETS(
	(e.iddepartamento, e.idcargo),
	(e.iddepartamento),
	()
);



	