/* PREGUNTA 03.1
*****************/

SELECT	RTRIM(LTRIM(C.cur_nombre)) As Curso,
		COUNT(DISTINCT M.alu_id) As [Cantidad Matriculados],
		SUM(IsNull(P.Pag_Importe,0)) As Ingreso
FROM	dbo.MATRICULA As M
LEFT JOIN dbo.PAGO As P ON P.alu_id = M.alu_id AND P.cur_id = M.cur_id
LEFT JOIN dbo.CURSO As C ON M.cur_id = C.cur_id
GROUP BY RTRIM(LTRIM(C.cur_nombre))
ORDER BY  1 DESC
