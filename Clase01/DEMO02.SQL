
where (  )
and (  )

RH
===========================================
Consultar los empleados de contabilidad
y sistemas.


departamento = 'Conta' OR departamento = 'Sistemas'


SELECT * FROM RH.dbo.departamento;


SELECT *
FROM RH.dbo.empleado E
WHERE E.iddepartamento = 101
OR E.iddepartamento = 105;


SELECT *
FROM RH.dbo.empleado E
WHERE E.iddepartamento in (101,105);




