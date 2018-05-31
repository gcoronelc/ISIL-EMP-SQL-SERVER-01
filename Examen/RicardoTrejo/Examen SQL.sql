

/* 1. Parte I */

create procedure dbo.Sp_RegMatricula

@Cod_Curso int,
@Cod_Alumno int,
@Num_Cuotas int,
@Pag_Importe money
as

begin

	declare @Error1 int, @Error2 int, @Error3 int, @Error4 int, @Error5 int
		set @Error1 = 0
		set @Error2 = 0
		set @Error3 = 0
		set @Error4 = 0
		set @Error5 = 0
	
	if (select COUNT(*) from matricula where alu_id = @Cod_Alumno and cur_id = @Cod_Curso )> 0
	begin
		set @Error1 = 1
	end

	declare @NroVacantesDisponibles int
	select @NroVacantesDisponibles  = (cur_vacantes  - cur_matriculados) from curso where cur_id = @Cod_Curso
	if @NroVacantesDisponibles = 0
	begin
		set @Error2 = 1
	end

	if @Num_Cuotas not between 1 and 3
	begin
		set @Error3 = 1
	end

		declare @ImporteCurso money 
		select @ImporteCurso = cur_precio from curso where cur_id = @Cod_Curso

	print convert(varchar(max),@ImporteCurso)
	print convert(varchar(max),@Pag_Importe)
	
	if @Num_Cuotas = 1
	begin
		if  @ImporteCurso <> @Pag_Importe
		begin
			set @Error4 = 1
		end
	end
	
		declare @ImpCursoal50 money
		set @ImpCursoal50 = (@ImporteCurso/2)
	
	if @Num_Cuotas between 2 and 3
	begin
		if CEILING(@ImpCursoal50) <> @Pag_Importe
		begin
			set @Error5 = 1
		end
	end
	print convert(varchar(max),@Error1)
	print convert(varchar(max),@Error2)
	print convert(varchar(max),@Error3)
	print convert(varchar(max),@Error4)
	print convert(varchar(max),@Error5)
	
	if @Error1 = 0 and @Error2 = 0 and @Error3 = 0 and @Error4  = 0 and @Error5 = 0
	begin
		
		begin try
			
			print 'realizo registro'
			insert into matricula values (@Cod_Curso,@Cod_Alumno,GETDATE(),@ImporteCurso,@Num_Cuotas,20)
			
			insert into pago values (@Cod_Curso,@Cod_Alumno,1,GETDATE(),@Pag_Importe)
			print 'finalizo registro'
			
			print 'inicio actualizacion de matriculados'			
			update curso
			set cur_matriculados  =  cur_matriculados + 1
			where cur_id = @Cod_Curso
			print 'finalizo actualizacion de matriculados'			
		end try
		begin catch
			select ERROR_MESSAGE()
		end catch
		
	end
	else
	begin
		declare @Mensaje varchar(max)
		set @Mensaje =
		 		 (case when @Error1 = 1 then 'Alumno ya se encuentra matriculado'
			     when @Error2 = 1 then 'No hay vacantes disponibles'
			     when @Error3 = 1 then 'Nro cuotas no valida'
			     when @Error4 = 1 then 'Importe a pagar no corresponde al 100% del curso'
			     when @Error5 = 1 then 'Importe a pagar no corresponde al 50% del curso' end)

		select @Mensaje
	end
	
end

/* 2. Parte II */



create procedure sp_Rep_Matriculados ( @p_fechainicio int , @p_fechafin int )
as
begin

SELECT 
A.alu_nombre Nombre,
C.cur_nombre Nombre_Curso,
C.cur_precio Precio_Curso,
B.mat_cuotas Cuotas_Programadas,
ISNULL(MAX(D.pag_cuota),0) Cuotas_Pagadas,
ISNULL(D.pag_importe,0) Importe_Pagado,
C.cur_precio - ISNULL(D.pag_importe,0) Saldo,
B.mat_nota Nota
FROM [EDUCA].[dbo].[ALUMNO] A
     INNER JOIN [EDUCA].[dbo].[MATRICULA] B
     ON A.alu_id=B.alu_id
                INNER JOIN [EDUCA].[dbo].[CURSO] C
                ON B.cur_id=C.cur_id 
                           LEFT JOIN [EDUCA].[dbo].[PAGO] D
                           ON A.alu_id=D.alu_id AND B.cur_id=D.cur_id
WHERE 
B.mat_fecha between CAST (LEFT(@p_fechainicio,8)   AS DATE)    AND CAST (LEFT(@p_fechafin,8)   AS DATE)                    
group by
A.alu_nombre,
C.cur_nombre,
C.cur_precio,
B.mat_cuotas,
D.pag_importe,
B.mat_nota
ORDER BY 1;


end
GO


BEGIN
EXEC sp_Rep_Matriculados 20180201,20180520;
END;