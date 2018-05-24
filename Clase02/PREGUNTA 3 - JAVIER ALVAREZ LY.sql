SELECT B.cur_nombre AS CURSO, SUM(A.pag_importe) IMPORTE
FROM dbo.PAGO A
INNER JOIN dbo.CURSO B
ON A.cur_id=B.cur_id
GROUP BY B.cur_nombre

-- 5110


