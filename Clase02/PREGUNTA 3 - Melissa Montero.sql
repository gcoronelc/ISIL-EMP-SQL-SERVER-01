Desarrolle una sentencia SELECT 
que muestre el nombre del curso y el importe de todos sus
pagos. Base de datos EDUCA.

select c.cur_nombre, sum(p.pag_importe)
from dbo.PAGO p
inner join dbo.CURSO c
on p.cur_id=c.cur_id
group by c.cur_nombre


