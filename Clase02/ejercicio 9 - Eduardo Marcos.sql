select a.alu_nombre,
	case 
	when b.mat_nota<10 then '1. [0 - 10 >'
	when b.mat_nota<14 then '2. [10 - 14 >'
	when b.mat_nota<18 then '3. [14 - 18 >'
	else '4. [18-20]' end NOTA,
	case 
	when b.mat_nota<10 then 'Malo'
	when b.mat_nota<14 then 'Regular'
	when b.mat_nota<18 then 'Bueno'
	else 'Excelente' end Calificacion
from dbo.ALUMNO a inner join dbo.MATRICULA b
on a.alu_id=b.alu_id