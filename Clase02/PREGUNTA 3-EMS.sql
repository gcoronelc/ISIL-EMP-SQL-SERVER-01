--### PREGUNTA 3 ####
SELECT A.cur_nombre,SUM(B.pag_importe) PAGOS FROM dbo.CURSO A INNER JOIN dbo.PAGO B
ON A.cur_id=B.cur_id
GROUP BY A.cur_nombre
