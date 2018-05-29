
begin
	print 'Hola';
end;
go


create function dbo.fn_suma( @n1 int, @n2 int )
returns int
as
begin
	declare @suma int;
	set @suma = @n1 + @n2;
	return @suma;
end;
go

select dbo.fn_suma( 12, 15 ) suma;
go

begin
	declare @suma int;
	set @suma = dbo.fn_suma( 12, 15 );
	print 'Suma: ' + cast(@suma as varchar);
end;
go


CREATE FUNCTION DBO.FN_EMPLEADOS( @P_DPTO INT )
RETURNS TABLE
AS
RETURN 
	SELECT *
	FROM DBO.EMPLEADO
	WHERE IDDEPARTAMENTO = @P_DPTO;
GO

SELECT * FROM DBO.FN_EMPLEADOS( 101 );
GO


ALTER FUNCTION DBO.FN_CATALOGO()
RETURNS @TABLA TABLE
(
	CODIGO INT,
	NOMBRE VARCHAR(50),
	PRECIO MONEY
)
AS
BEGIN
  INSERT INTO @TABLA VALUES( 1, 'TELEVISOR', 1500 );
  INSERT INTO @TABLA VALUES( 2, 'REFRIGERADORA', 1450 );
  INSERT INTO @TABLA VALUES( 3, 'LAVADORA', 1350 );	
  RETURN;
END;
GO

declare @rowcount int, @error int;
SELECT * FROM DBO.FN_CATALOGO();
select @rowcount = @@ROWCOUNT, @error = @@ERROR;
PRINT 'Error: ' + cast(@error as varchar);
PRINT 'Filas: ' + cast(@rowcount as varchar);
GO





