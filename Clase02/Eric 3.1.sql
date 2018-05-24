select C.cur_nombre,SUM(z.importe) Ingreso,COUNT(*) Matriculados
from (select cur_id,alu_id,SUM(pag_importe)importe from Educa.dbo.pago C group by cur_id,alu_id)z
inner join EDUCA.dbo.CURSO C
on z.cur_id=C.cur_id
group by C.cur_nombre
