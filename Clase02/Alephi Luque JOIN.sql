/* PREGUNTA 02
*****************/

SELECT	RTRIM(LTRIM(A.alu_nombre)) As Alumno,
		SUM(P.Pag_Importe) As Pagos
FROM	dbo.PAGO As P
LEFT JOIN dbo.ALUMNO As A
ON P.alu_id = A.alu_id
GROUP BY RTRIM(LTRIM(A.alu_nombre))
ORDER BY  1

/* PREGUNTA 03
*****************/

SELECT	RTRIM(LTRIM(C.cur_nombre)) As Curso,
		SUM(P.Pag_Importe) As Pagos
FROM	dbo.PAGO As P
LEFT JOIN dbo.CURSO As C
ON P.cur_id = C.cur_id
GROUP BY RTRIM(LTRIM(C.cur_nombre))
ORDER BY  1 DESC