SELECT B.cur_nombre AS CURSO, SUM(A.pag_importe) IMPORTE
FROM dbo.PAGO A
INNER JOIN dbo.CURSO B
ON A.cur_id=B.cur_id
GROUP BY B.cur_nombre -- 5110

SELECT C.cur_nombre AS CURSO, COUNT(M.alu_id) AS CANT_MATRI, SUM(P.pag_importe) AS INGRESO
FROM dbo.MATRICULA M
INNER JOIN dbo.PAGO P
ON M.alu_id=P.alu_id AND M.cur_id=P.cur_id
INNER JOIN dbo.CURSO C
ON M.cur_id=C.cur_id
GROUP BY C.cur_nombre -- 


SELECT * FROM dbo.PAGO
SELECT * FROM dbo.MATRICULA