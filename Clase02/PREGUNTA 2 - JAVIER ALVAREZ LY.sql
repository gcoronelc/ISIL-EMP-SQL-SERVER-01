SELECT B.alu_nombre AS CURSO, SUM(A.pag_importe) IMPORTE
FROM dbo.PAGO A
INNER JOIN dbo.ALUMNO B
ON A.alu_id=B.alu_id
GROUP BY B.alu_nombre