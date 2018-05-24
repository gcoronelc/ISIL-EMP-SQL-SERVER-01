SELECT

al.alu_nombre , cu.cur_nombre, 
CASE 
WHEN ma.mat_nota  <10  THEN 'Malo'
WHEN ma.mat_nota  <14  THEN 'Regular'
WHEN ma.mat_nota  <18  THEN 'Bueno'
WHEN ma.mat_nota  <=20  THEN 'Excelente'
END CALIFICACION
 FROM dbo.MATRICULA ma
 INNER JOIN dbo.CURSO cu
 ON  ma.cur_id = cu.cur_id
INNER JOIN dbo.ALUMNO al
ON ma.alu_id = al.alu_id
ORDER BY 1