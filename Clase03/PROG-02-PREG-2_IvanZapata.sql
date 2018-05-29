exec sp_requerimiento2 'A0050','C010','2018-12'

create procedure dbo.sp_requerimiento2 
@CodigoAlumno varchar(max),
@CodigoCurso varchar(max),
@CodigoCiclo varchar(max)
as
begin

	declare @Message  varchar(max)
	set @Message  = ''

	declare @IdCursoProg varchar(max)
	
	if (select COUNT(*) from dbo.cursoprogramado where IdCurso = @CodigoCurso and IdCiclo = @CodigoCiclo and activo = 1 and vacantes > 0 ) = 0
	begin
		set @Message =@Message+  ' Caida 1er y 4to Filtro'
	end
	else
	begin
			set @IdCursoProg = (select  IdCursoProg from dbo.cursoprogramado where IdCurso = @CodigoCurso and IdCiclo = @CodigoCiclo and activo = 1 and vacantes > 0)
	end

		
	if(select COUNT(*) from dbo.alumno where IdAlumno = @CodigoAlumno ) = 0
	begin
		set @Message =@Message+  'Caida 2do Filtro'
	end
	
	declare @FlagValidacion3 int
	set @FlagValidacion3 = 0
	
	if (	
		select 
		COUNT(*)
		from cursoprogramado a inner join matricula b on a.IdCursoProg =  b.IdCursoProg
		where a.IdCurso = @CodigoCurso and
			  a.IdCiclo = @CodigoCiclo and
			  b.IdAlumno = @CodigoAlumno and
			  a.activo = 1
		) > 0
	begin
		set @Message =@Message+  'Caida 3er Filtro'
	end
	
	if (LTRIM(rtrim(@Message))) <> ''
	begin
		print 'Error Message: '+ @Message
	end
	else
	begin
			begin try
				insert into matricula values (convert(int,@IdCursoProg),@CodigoAlumno,GETDATE(),null,null,null,0,null)
				
				update cursoprogramado
				set Vacantes = Vacantes - 1,
					Matriculados = Matriculados + 1
				where IdCursoProg = convert(int,@IdCursoProg) and
					  IdCurso = @CodigoCurso and
					  IdCiclo = @CodigoCiclo
				
			end try
			begin catch
				select ERROR_NUMBER() as ErrorNumber,
					   ERROR_MESSAGE() as ErrorMessage
			end catch;
	end	
end





