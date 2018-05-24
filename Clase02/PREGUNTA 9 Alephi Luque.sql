SELECT	M.alu_id,A.alu_nombre,C.cur_nombre,M.mat_nota,
		CASE	WHEN M.mat_nota < 10 THEN 'Malo'
				WHEN M.mat_nota < 14 THEN 'Regular'
				WHEN M.mat_nota < 18 THEN 'Bueno'
				ELSE 'Excelente' END As Calificacion
FROM	EDUCA.dbo.MATRICULA AS M 
LEFT JOIN EDUCA.dbo.CURSO AS C ON M.cur_id = C.cur_id
LEFT JOIN EDUCA.dbo.ALUMNO AS A ON M.alu_id = A.alu_id