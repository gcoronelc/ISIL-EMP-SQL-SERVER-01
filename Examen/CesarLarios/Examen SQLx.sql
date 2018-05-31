---------------------------------------
--- PREGUNTA 01						---
---------------------------------------

USE	EDUCA
GO

ALTER PROCEDURE DBO.PROCESA_MATRICULA (@P_ICURSO INT,@P_IALUMNO INT,@P_NCUOTAS INT,
										@P_PAGO_MATRICULA MONEY OUT,@P_RESULTADO VARCHAR(100) OUT)
AS
DECLARE	@I_VALIDA	INT
DECLARE @C_CUOTA	MONEY

-- Inicializamos resultado como erróneo. Sólo cambiara si la matrícula es correcta.
SET	@P_RESULTADO = 'Matricula Erronea. ';

-- Se valida que el alumno exista
SET	@I_VALIDA = (SELECT	COUNT(1) FROM dbo.ALUMNO AS Al
					WHERE Al.alu_id = @P_IALUMNO)
IF @I_VALIDA = 0 
BEGIN
	SET	@P_RESULTADO = @P_RESULTADO + 'Alumno no existe.'
	RETURN (0)
END

-- Se valida que el curso exista
SET	@I_VALIDA = (SELECT	COUNT(1) FROM dbo.CURSO AS Cur 
					WHERE Cur.cur_id = @P_ICURSO)
IF @I_VALIDA = 0 
BEGIN
	SET	@P_RESULTADO = @P_RESULTADO + 'Curso no existe.'
	RETURN (0)
END

-- Se valida que el alumno no esté matriculado
SET	@I_VALIDA = (SELECT	COUNT(1) FROM DBO.MATRICULA AS Mat 
					WHERE Mat.alu_id = @P_IALUMNO AND Mat.cur_id = @P_ICURSO)
IF @I_VALIDA >= 1 
BEGIN
	SET	@P_RESULTADO = @P_RESULTADO + 'Alumno ya matriculado.'
	RETURN (0)
END

-- Se valida que el curso tenga vacantes disponibles
SET	@I_VALIDA = (SELECT	ISNULL(Cur.cur_vacantes,0) - ISNULL(Cur.cur_matriculados,0) FROM dbo.CURSO AS Cur 
					WHERE Cur.cur_id = @P_ICURSO)
IF @I_VALIDA <= 0 
BEGIN
	SET	@P_RESULTADO = @P_RESULTADO + 'Curso sin vacantes.'
	RETURN (0)
END

-- Verifica que el numero de cuotas sea como maximo 3.
IF @P_NCUOTAS > 3
BEGIN
	SET	@P_RESULTADO = @P_RESULTADO + 'Número de cuotas no válido.'
	RETURN (0)
END

-- Se calcula el monto a pagar por la matricula
IF	@P_NCUOTAS = 1
	 SET @C_CUOTA = (SELECT C.cur_precio FROM dbo.CURSO As C WHERE C.cur_id = @P_ICURSO)
ELSE 
	 SET @C_CUOTA = (SELECT ROUND(isnull(C.cur_precio,0)/2,0) FROM dbo.CURSO As C WHERE C.cur_id = @P_ICURSO)

-- Se procede con la Matricula
------------------------------
-- 1. Se inserta en la tabla de matricula
INSERT INTO dbo.MATRICULA (cur_id,alu_id,mat_fecha,mat_precio,mat_cuotas)
		VALUES (@P_ICURSO,@P_IALUMNO,GETDATE(),@C_CUOTA,@P_NCUOTAS)

-- 2. Se actualizan las vacantes del curso
UPDATE dbo.CURSO SET cur_matriculados = cur_matriculados + 1 WHERE  Cur_id = @P_ICURSO

-- 3. Se inserta en la tabla de pagos el pago de la matricula
INSERT INTO dbo.PAGO (cur_id,alu_id,pag_cuota,pag_fecha,pag_importe)
VALUES (@P_ICURSO,@P_IALUMNO,1,GETDATE(),@C_CUOTA)

-- 3. Se devuelve mensaje de error exitoso.
SET	@P_RESULTADO = 'Matricula Exitosa. Se debe pagar S/. ' + CAST(@C_CUOTA AS VARCHAR);
RETURN (1)

GO 

---------------------------------------
--- PREGUNTA 02						---
---------------------------------------

USE	EDUCA
GO

SELECT	A.alu_nombre As Alumno,C.cur_nombre As Curso,C.cur_precio As Precio,
		M.mat_cuotas As CuotasProg,MAX(ISNULL(P.pag_cuota,0)) As CuotasPag,
		SUM(ISNULL(P.Pag_importe,0)) As ImportePagado,C.cur_precio-SUM(ISNULL(P.Pag_importe,0)) As Saldo,
		MAX(ISNULL(M.mat_nota,0)) As Nota
FROM	dbo.MATRICULA As M
LEFT JOIN dbo.ALUMNO As A ON A.alu_id = M.alu_id
LEFT JOIN dbo.CURSO As C ON C.cur_id = M.cur_id
LEFT JOIN dbo.PAGO As P ON M.alu_id = P.alu_id AND M.cur_id = P.cur_id
GROUP BY A.alu_nombre,C.cur_nombre,C.cur_precio,M.mat_cuotas


