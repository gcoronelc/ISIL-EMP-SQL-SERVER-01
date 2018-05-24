

-- MODIFICANDO LA PREGUNTA 3.1
-- ==============================



  NOMBRE CURSO        CANTIDAD MATRICULADOS             INGRESO
========================================================================






SELECT * FROM EDUCA.DBO.MATRICULA;


SELECT C.cur_nombre, COUNT(DISTINCT M.alu_id) ALUMNOS, SUM(P.PAG_IMPORTE) INGRESOS
FROM EDUCA.dbo.CURSO C
JOIN EDUCA.dbo.MATRICULA M
ON C.cur_id = M.cur_id
LEFT JOIN EDUCA.dbo.PAGO P 
ON M.cur_id = P.cur_id AND M.alu_id = P.alu_id
GROUP BY C.cur_nombre;


















