alter procedure dbo.sp_matricula
@codigoCurso int,
@CodigoAlumno int,
@nroCuotas int,
@importe money
as
BEGIN

declare @MSJ varchar(max);

--calculando la fecha
declare @fechaMatricula datetime;
set @fechaMatricula=GETDATE();

--1.VALIDANDO SI ALUMNO ESTA MATRICULADO
declare @flgMatriculado int;
set @flgMatriculado = (select case when COUNT(*)>0 then 1 else 0 end from EDUCA.dbo.Matricula where cur_id=@codigoCurso and alu_id=@CodigoAlumno)

iF(@flgMatriculado=1)
begin
	set @MSJ='ALUMNO YA ESTA MATRICULADO!!!'
	PRINT @MSJ
end;

--2.VALIDANDO QUE EXISTAN VACANTES EN EL CURSO A MATRICULARSE
declare @flgVacantes int;
set @flgVacantes = (select case when cur_vacantes>0 then 1 else 0 end from EDUCA.dbo.CURSO where cur_id=@codigoCurso)

iF(@flgMatriculado=1)
begin
	set @MSJ = 'NO EXISTEN VACANTES'
	PRINT @MSJ
end;

--3.VALIDANDO QUE LAS CUOTAS ESTEN ENTRE 1 Y 3
iF NOT(@nroCuotas>0 AND @nroCuotas<=3)
begin
	set @MSJ = 'ERROR EN EL INGRESO DE CUOTAS'
	PRINT @MSJ
end;


--4.VALIDANDO CUANDO LA CUOTA=1 SEA EL PRECIO TOTAL DEL CURSO
declare @flgPrecioIgual int;
set @flgPrecioIgual= (select case when cur_precio=@importe then 1 else 0 end from EDUCA.dbo.CURSO where cur_id=@codigoCurso)

declare @flgcuota1 int;
set @flgcuota1 = (select case when @flgPrecioIgual=1 and @nroCuotas=1 then 1 else 0 end)

iF (@flgcuota1=0)
begin
	set @MSJ = 'ERROR EN EL INGRESO DEL IMPORTE DE UNA CUOTA'
	PRINT @MSJ
end;


--4.VALIDANDO CUANDO LA CUOTA>1 SEA MAYOR O IGUAL AL 50% DEL PRECIO TOTAL DEL CURSO
declare @flgPrecio50 int;
set @flgPrecio50= (select case when (0.5*cur_precio)<=@importe then 1 else 0 end from EDUCA.dbo.CURSO where cur_id=@codigoCurso)

declare @flgcuota50 int;
set @flgcuota50 = (select case when (@flgPrecio50=1 and @nroCuotas>1 and @nroCuotas<=3) then 1 else 0 end)

iF (@flgcuota50=0)
begin
	set @MSJ = 'ERROR EL IMPORTE DEBE SER MAYOR AL 50% DEL PRECIO DEL CURSO'
	PRINT @MSJ
end;


--INSERTANDO CUANDO TODO ESTA OK
IF(@flgMatriculado=0 and @flgVacantes=1 AND ((@nroCuotas<=3 AND @flgcuota1=1)or(@nroCuotas>1 AND @nroCuotas<=3 AND @flgcuota50=1) ))
BEGIN

	BEGIN TRY
		--Insertanto en la tabla Matricula
		insert into EDUCA.dbo.Matricula
		values (@codigoCurso,@CodigoAlumno,@fechaMatricula,@importe,@nroCuotas,0)
		
		--Actualizando la cantidad de vacantes y matriculados
		update A
		set A.cur_vacantes = A.cur_vacantes-1,A.cur_matriculados=A.cur_matriculados+1
		from EDUCA.dbo.CURSO A
		where cur_id=@codigoCurso
		
		
	END TRY
	
	BEGIN CATCH
		select ERROR_NUMBER(),ERROR_MESSAGE()
	
	END CATCH;

END;

END;


--PROBAR:
--execute dbo.sp_matricula 1,3,1,1.00