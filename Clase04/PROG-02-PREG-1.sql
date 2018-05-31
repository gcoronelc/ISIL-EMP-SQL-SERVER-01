
DROP PROCEDURE dbo.sp_GenerarCiclo;
GO

CREATE PROCEDURE dbo.sp_GenerarCiclo
( @nuevoCiclo Varchar(10) OUT )
AS
BEGIN

DECLARE
	@ultimoCiclo varchar(10),
	@mes   INT,
	@anio  INT,
	@fechaInicio Date,
	@fechaFin Date,
	@ErrMsg varchar(1000),
	@ErrSeverity int;
	
BEGIN TRY

  BEGIN TRAN;

  select @ultimoCiclo = MAX( IdCiclo)  
  from Ciclo;

  SET @anio = LEFT(@ultimoCiclo, 4);
  SET @mes  = SUBSTRING(@ultimoCiclo,6,2);
  
  IF( @mes = 12 )
  BEGIN
	SET @anio = @anio + 1;
	SET @mes = 1;
  END
  ELSE 
  BEGIN
	SET @mes = @mes + 1;
  END;
  
  SET @nuevoCiclo = CAST( @anio AS VARCHAR ) + '-' 
	+ RIGHT( '00' + CAST( @mes AS VARCHAR ),2); 
  
  SET @fechaInicio = CAST( @anio AS VARCHAR ) 
	+ RIGHT( '00' + CAST( @mes AS VARCHAR ),2) + '01';
	
  SET @fechaFin = DATEADD(MONTH,1,@fechaInicio);
  
  SET @fechaFin = DATEADD(D,-1,@fechaFin);

  insert into Ciclo(idciclo, FecInicio, FecTermino)
  values ( @nuevoCiclo, @fechaInicio, @fechaFin);

  commit;

END TRY
BEGIN CATCH

  select @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
  rollback;
  raiserror(@ErrMsg,@ErrSeverity,1)  
	
END CATCH;
END;
GO




DECLARE @nuevoCiclo varchar(20);
execute dbo.sp_GenerarCiclo @nuevoCiclo OUT;
PRINT 'NUEVO CICLO: ' + @nuevoCiclo;
go


select *  
from Ciclo
ORDER BY 1 DESC;