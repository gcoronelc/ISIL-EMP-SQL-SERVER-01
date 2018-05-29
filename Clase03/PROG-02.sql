
BEGIN TRY
	DECLARE @TOTAL INT;
	SET @TOTAL = 20;
	SELECT  @TOTAL/0
END TRY 
BEGIN CATCH
	SELECT
		ERROR_NUMBER()  AS  Numero_de_Error, 
		ERROR_SEVERITY()  AS  Gravedad_del_Error, 
		ERROR_STATE()  AS  Estado_del_Error, 
		ERROR_PROCEDURE()  AS  Procedimiento_del_Error, 
		ERROR_LINE()  AS  Linea_de_Error, 
		ERROR_MESSAGE()  AS  Mensaje_de_Error;
END  CATCH; 
GO


BEGIN TRY
	SELECT  *  FROM  TablaNoExiste; 
END TRY
BEGIN CATCH
	SELECT  
	ERROR_NUMBER()  AS  ErrorNumber,
	ERROR_MESSAGE()  AS  ErrorMessage;
END CATCH;
GO


CREATE PROCEDURE usp_ProcEjemplo AS
SELECT  *  FROM  TablaNoExiste;
GO

BEGIN TRY
	EXECUTE  usp_ProcEjemplo; END TRY
BEGIN CATCH
	SELECT  
		ERROR_NUMBER()  AS  ErrorNumber,
		ERROR_MESSAGE()  AS  ErrorMessage;
END CATCH;
GO



select * from Ciclo;


