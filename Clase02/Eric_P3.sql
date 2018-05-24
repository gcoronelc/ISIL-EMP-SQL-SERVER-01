select A.cur_nombre,SUM(B.pag_importe) IMPORTE_PAGOS 
from EDUCA.dbo.CURSO A
inner join EDUCA.dbo.PAGO B
on A.cur_id=B.cur_id
group by A.cur_nombre
