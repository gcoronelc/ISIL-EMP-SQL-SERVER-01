 
 select h.iddepartamento as departamento, h.idcargo as puesto ,SUM(h.sueldo) as planilla from RH..empleado h
 group by cube (h.idcargo,h.iddepartamento)
 order by h.iddepartamento asc