-- Pregunta 2
select al.alu_nombre , SUM(pg.pag_importe) IMPORTE_PAGOS
from  dbo.ALUMNO al
INNER JOIN dbo.pago pg
ON al.alu_id = pg.alu_id
GROUP BY al.alu_nombre
