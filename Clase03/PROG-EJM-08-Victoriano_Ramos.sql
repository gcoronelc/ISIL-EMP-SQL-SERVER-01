CREATE PROCEDURE dbo.usp_precio ( @p_idcurso int, @p_precio money OUT )
as
begin

select @p_precio= [cur_precio]
FROM dbo.Curso
WHERE cur_id= @p_idcurso;

end;
go


BEGIN

declare @precio money;
exec dbo.usp_precio 3, @precio OUT;
PRINT  'PRECIO: ' + CAST(@PRECIO AS VARCHAR) ;

END;
GO