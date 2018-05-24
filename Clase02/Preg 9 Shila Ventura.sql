--select *from rh.dbo.empleado

--Select *from EDUCA.dbo.MATRICULA
--Select *from EDUCA.dbo.ALUMNO


Select a.alu_nombre [Nombre Alumno], 
		case 
			when b.mat_nota <= 10 then 'Malo'
			when b.mat_nota <= 14 then 'Regular'
			when b.mat_nota <= 18 then 'Bueno'
			when b.mat_nota <= 20 then 'Excelente'
		else 'Extraordinario'
		end Calificacion
from EDUCA.dbo.ALUMNO a
inner join EDUCA.dbo.MATRICULA b
on a.alu_id = b.alu_id


