/*
REQUERIMIENTO 1:
INTEGRANTES:
- VICTORIANO RAMOS LABORIO
- KARL FERNANDEZ TORRES
*/

DROP PROCEDURE sp_RegistrarMatricula;

CREATE PROCEDURE sp_RegistrarMatricula( @p_codigocurso int , @p_codalumno int, @p_ncuotas int , @p_importe decimal)
AS
BEGIN
DECLARE 
@Message varchar (1000)='',
@v_vacanteslibres int=0,
@v_mnt_precio decimal=0,
@v_preciocurso decimal=0,
@v_estadomatriculado int=0,
@ErrMsg varchar(1000),
@ErrSeverity varchar(1000);



select  @v_vacanteslibres=(cur_vacantes - cur_matriculados) , @v_preciocurso=cur_precio 
from dbo.CURSO where cur_id = @p_codigocurso ;
		
	IF (select count(*) from dbo.MATRICULA where cur_id = @p_codigocurso and alu_id = @p_codalumno  ) > 0
	begin
	    set @v_estadomatriculado=1;
		set @Message ='El alumno ya se encuentra matriculado en el curso'
	end

	
   IF @v_vacanteslibres > 0 and  @p_ncuotas  in ( 1,2,3 ) and @v_estadomatriculado=0
   begin
   
   IF @p_ncuotas= 1 and @v_preciocurso = @p_importe
   begin
   BEGIN TRY
      INSERT INTO MATRICULA VALUES ( @p_codigocurso,@p_codalumno,GETDATE(),@v_preciocurso,@p_ncuotas,'');
      INSERT INTO PAGO VALUES   (@p_codigocurso,@p_codalumno,@p_ncuotas,GETDATE(),@v_preciocurso);
      set @Message = 'Alumno Matriculado';
   END TRY
   
   BEGIN CATCH
     select @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
     raiserror(@ErrMsg,@ErrSeverity,1)  
   END CATCH  
   end
   
   ELSE
   begin
      SET @v_mnt_precio= round(@v_preciocurso*(0.5),0);
      IF @p_importe = @v_mnt_precio
      begin
         BEGIN TRY
          INSERT INTO MATRICULA VALUES ( @p_codigocurso,@p_codalumno,GETDATE(),@v_preciocurso,@p_ncuotas,'');
          INSERT INTO PAGO VALUES   (@p_codigocurso,@p_codalumno,1,GETDATE(),@v_mnt_precio);
         END TRY
   
        BEGIN CATCH
         select @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
          raiserror(@ErrMsg,@ErrSeverity,1)  
   END CATCH  
   
      set @Message = 'Alumno Matriculado';
      end
      ELSE
      		set @Message ='Importe de pago es incorrecto';
   
   end
   end
   
   ELSE
   begin
   IF @v_vacanteslibres =0 
   set @Message ='No hay vacante disponible en el curso';
    IF @p_ncuotas not in ( 1,2,3 )
   set @Message ='Numero de cuotas incorrecto';
   
   end

PRINT   @Message; 

END;

GO

BEGIN
exec sp_RegistrarMatricula 4, 7,3,600;
END;



