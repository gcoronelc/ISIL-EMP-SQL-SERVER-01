select cu.cur_nombre , COUNT( distinct  ma.alu_id ) CANTIDAD_MATRICULADOS, 
iSnULL(SUM(pg.pag_importe),0) IMPORTE_PAGOS

from  dbo.curso cu
INNER JOIN dbo.MATRICULA ma
ON cu.cur_id = ma.cur_id
LEFT JOIN dbo.pago pg
ON  ma.cur_id = pg.cur_id
and ma.alu_id = pg.alu_id
GROUP BY cu.cur_nombre 