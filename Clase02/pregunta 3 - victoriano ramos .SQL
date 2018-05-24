select cu.cur_nombre , SUM(pg.pag_importe) 
from  dbo.curso cu
INNER JOIN dbo.pago pg
ON cu.cur_id = pg.cur_id
GROUP BY cu.cur_nombre 

