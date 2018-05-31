/*
alumnos no registrados
6
8
9
10
11
*/
/*
5	Java Fundamentos
6	RODRIGUEZ ROJAS, RENZO ROBERT
1 nro cuota
800
*/
/*

*/
exec dbo.sp_generar_matricula 5,10,3,450
create procedure dbo.sp_generar_matricula
@CodigoCurso int,
@CodigoAlumno int,
@NroCuota int,
@ImporteaPagar money
as
begin

	declare @Error1 int, @Error2 int, @Error3 int, @Error4 int, @Error5 int
	set @Error1 = 0
	set @Error2 = 0
	set @Error3 = 0
	set @Error4 = 0
	set @Error5 = 0
	
	if (select COUNT(*) from matricula where alu_id = @CodigoAlumno and cur_id = @CodigoCurso )> 0
	begin
		set @Error1 = 1
	end

	declare @NroVacantesDisponibles int
	select @NroVacantesDisponibles  = (cur_vacantes  - cur_matriculados) from curso where cur_id = @CodigoCurso
	if @NroVacantesDisponibles = 0
	begin
		set @Error2 = 1
	end

	if @NroCuota not between 1 and 3
	begin
		set @Error3 = 1
	end

		declare @ImporteCurso money 
		select @ImporteCurso = cur_precio from curso where cur_id = @CodigoCurso

	print convert(varchar(max),@ImporteCurso)
	print convert(varchar(max),@ImporteaPagar)
	
	if @NroCuota = 1
	begin
		if  @ImporteCurso <> @ImporteaPagar
		begin
			set @Error4 = 1
		end
	end
	
		declare @ImpCursoal50 money
		set @ImpCursoal50 = (@ImporteCurso/2)
	
	if @NroCuota between 2 and 3
	begin
		if CEILING(@ImpCursoal50) <> @ImporteaPagar
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
			insert into matricula values (@CodigoCurso,@CodigoAlumno,GETDATE(),@ImporteCurso,@NroCuota,20)
			
			insert into pago values (@CodigoCurso,@CodigoAlumno,1,GETDATE(),@ImporteaPagar)
			print 'finalizo registro'
			
			print 'inicio actualizacion de matriculados'			
			update curso
			set cur_matriculados  =  cur_matriculados + 1
			where cur_id = @CodigoCurso
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
