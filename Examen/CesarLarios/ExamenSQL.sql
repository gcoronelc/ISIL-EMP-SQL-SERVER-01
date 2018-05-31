
/*************************************PREGUNTA 1*****************************************/

CREATE procedure dbo.vista_Matricula
@cur_id int,
@alu_id int,
@pag_cuota int,
@pag_importe money,
@mensaje varchar(250) out
as
begin
begin TRY
 
 if(
 (select count(*) from dbo.MATRICULA where cur_id = @cur_id and alu_id = @alu_id) = 0
 and 
 (select cur_vacantes - cur_matriculados as vacantes from dbo.CURSO where cur_id = @cur_id) > 0 
 and
  (	 (@pag_cuota = 1 and
	 (select cur_precio from dbo.CURSO where cur_id = @cur_id) = @pag_importe) or
	 (@pag_cuota in (2,3) and
	 round((select cur_precio from dbo.CURSO where cur_id = @cur_id)/2,0) = @pag_importe)
   )
 )
  set @mensaje = 'Alumno Matriculado'
 else
  set @mensaje = 'Alumno no se pudo matricular'

 insert into dbo.MATRICULA 
 values(@cur_id,@alu_id,GETDATE(),@pag_importe,@pag_cuota,null)
 
end try
begin catch
	set @mensaje = 'Alumno no se pudo matricular'
end catch 
print @mensaje;
end;


declare @mensaje varchar(250)
exec dbo.vista_Matricula 1,5,2,500,@mensaje




/*************************************PREGUNTA 2*****************************************/


create procedure dbo.vista_AlumnosMatriculados
as
--try
begin
 select b.alu_nombre NOMBRE_ALUMNO,c.cur_nombre NOMBRE_CURSO,
c.cur_precio PRECIO_CURSO,a.mat_cuotas CUOTAS_PROGRAMADAS,
isnull(d.cantidad,0) CUOTAS_PAGASAS,
isnull(d.importe,0) IMPORTE_PAGADO,
c.cur_precio - isnull(d.importe,0) SALDO,
ISNULL(a.mat_nota,0) NOTA from 
dbo.MATRICULA a
left join
dbo.ALUMNO b
on a.alu_id = b.alu_id
left join
dbo.CURSO c
on a.cur_id = c.cur_id
left join
(select cur_id,alu_id,COUNT(*) cantidad,SUM(pag_importe) importe from dbo.PAGO group by cur_id,alu_id) d
on a.alu_id = d.alu_id and c.cur_id = d.cur_id
order by a.cur_id,a.alu_id

end;


EXEC dbo.vista_AlumnosMatriculados