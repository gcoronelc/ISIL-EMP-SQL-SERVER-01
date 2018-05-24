SELECT A.ALU_NOMBRE,mat_nota,
CASE WHEN mat_nota < 10 THEN 'MALO'
	WHEN mat_nota < 14 THEN 'REGULAR'
	WHEN mat_nota < 18 THEN 'BUENO'
	WHEN mat_nota <= 20 THEN 'EXCELNTE'
	END CALIFICACION

FROM dbo.ALUMNO A
INNER JOIN 
dbo.MATRICULA
B
ON A.alu_id = B.alu_id
INNER JOIN 
dbo.CURSO C
ON B.cur_id = C.cur_id