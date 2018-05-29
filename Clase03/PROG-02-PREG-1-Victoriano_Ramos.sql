
CREATE PROCEDURE dbo.sp_GenerarCiclo
AS
BEGIN

DECLARE
	@maxciclo DATE,
	@meses  INT,
	@anio  INT,
	@meseschar varchar(100);

select @maxciclo= MAX( FecTermino)  
from Ciclo;

SET @meses = DATEPART(MM,DATEADD(M,1,@maxciclo));
SET @anio = DATEPART(YEAR,DATEADD(M,1,@maxciclo));

WHILE @meses <= 12
BEGIN

	IF @meses < 10
		SET @meseschar = '0' + CAST ( @meses AS VARCHAR);
	ELSE
		SET @meseschar = CAST ( @meses AS VARCHAR);


	INSERT INTO Ciclo 
	VALUES ( 
	CAST ( @anio AS VARCHAR) +'-'+ @meseschar ,
	CAST ( LEFT ( CAST(@anio AS VARCHAR)+@meseschar+'01',8) AS DATETIME)  ,
	DATEADD(D,-1,DATEADD(M,1,CAST ( LEFT (CAST(@anio AS VARCHAR)+@meseschar+'01',8) AS DATETIME))) );


	SET @meses=@meses + 1 ;
	SET @maxciclo= DATEADD(M,1,@maxciclo);
END

END;
go

exec  dbo.sp_GenerarCiclo;
go

select *  
from Ciclo
ORDER BY 1 DESC;