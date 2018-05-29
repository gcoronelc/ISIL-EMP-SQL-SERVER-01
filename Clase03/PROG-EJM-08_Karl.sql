DROP PROCEDURE dbo.usp_precio

USE EDUCA;
GO

CREATE  PROCEDURE  dbo.usp_precio  
(  @p_idcurso  int,  @p_precio  money  OUT  ) 
AS
BEGIN
	SELECT  @p_precio  =  cur_precio FROM dbo.CURSO
	WHERE cur_id = @p_idcurso; 
END;
GO

BEGIN
 DECLARE @precio money;
 EXEC dbo.usp_precio 4, @precio OUT; 
 PRINT ( 'PRECIO: '+ cast(@precio as char));
END;
GO


