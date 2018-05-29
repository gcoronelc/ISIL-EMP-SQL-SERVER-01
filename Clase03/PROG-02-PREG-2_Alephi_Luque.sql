USE	EduTec;
GO

CREATE PROCEDURE DBO.usp_Genera_Matricula 
		(@p_IdAlumno as Char(5),
		@p_IdCursoProgramado as Int,
		@p_Mensaje as Varchar(30) OUT)
AS
BEGIN
DECLARE	@ivalAlumno	as int
DECLARE	@ivalCurso	as int
DECLARE	@ivalMatricula as int
DECLARE	@ivalVacantes as int

SET	@ivalAlumno	= (SELECT COUNT(1) FROM	dbo.Alumno 
					WHERE IdAlumno = @p_IdAlumno);

IF @ivalAlumno < 1
	SET	@p_Mensaje = 'Alumno no existe'	
ELSE
	BEGIN
	SET	@ivalCurso = (SELECT COUNT(1)	FROM dbo.CursoProgramado 
					WHERE Activo = 1 and IdCursoProg = @p_IdCursoProgramado)
	IF	@ivalCurso < 1 
		SET	@p_Mensaje = 'El curso programado no existe'
	ELSE
		BEGIN
		SET	@ivalMatricula = (SELECT COUNT(1) FROM dbo.Matricula
					WHERE IdCursoProg = @p_IdCursoProgramado AND
							IdAlumno = @p_IdAlumno)
		IF	@ivalMatricula > 1
			SET	@p_Mensaje = 'El alumno ya esta matriculado en el curso'
		ELSE
			BEGIN
				SET	@ivalVacantes = (SELECT COUNT(1) FROM dbo.CursoProgramado
									WHERE IdCursoProg = @p_IdCursoProgramado AND
											Vacantes > 0)
				IF	@ivalVacantes < 1 
					SET	@p_Mensaje = 'El curso ya no tiene vacantes'
				ELSE
					BEGIN
						INSERT INTO dbo.Matricula (IdCursoProg,IdAlumno,FecMatricula)
							VALUES (@p_IdCursoProgramado,@p_IdAlumno,GETDATE());
						
						UPDATE	dbo.CursoProgramado
						SET	Vacantes = Vacantes - 1,Matriculados=Matriculados+1
						WHERE IdCursoProg = @p_IdCursoProgramado;
						
						SET	@p_Mensaje = 'Matricula exitosa';			
					
					END
			END
		END
	END
END;