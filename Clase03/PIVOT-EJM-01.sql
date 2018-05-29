create table dbo.Ventas(
	anio int,
	mes int,
	importe decimal(10,2),
	primary key( anio, mes )
)
go

-- 2016
insert into dbo.Ventas values (2016, 1, 450.0);
insert into dbo.Ventas values (2016, 2, 550.0);
insert into dbo.Ventas values (2016, 3, 689.0);
insert into dbo.Ventas values (2016, 4, 754.0);

-- 2017
insert into dbo.Ventas values (2017, 1, 823.0);
insert into dbo.Ventas values (2017, 2, 965.0);
insert into dbo.Ventas values (2017, 3, 823.0);
insert into dbo.Ventas values (2017, 4, 963.0);

-- 2018
insert into dbo.Ventas values (2018, 1, 578.0);
insert into dbo.Ventas values (2018, 2, 654.0);
insert into dbo.Ventas values (2018, 3, 356.0);
insert into dbo.Ventas values (2018, 4, 684.0);


select * from dbo.ventas
go

SELECT *
FROM
(
	SELECT anio, mes, importe 
	FROM dbo.Ventas
) AS TablaDatos
PIVOT
(
	sum(importe)
	FOR Mes IN ([1],[2],[3],[4])
) AS PivotTable;
go



--pivot dinámico
declare @query varchar(4000)
declare @Columns varchar(2000)
--obtenemos las columnas de la pivot
select 
@Columns=STUFF((select Distinct'],[' 
+ mes from dbo.Ejemplos 
order by  '],['+ mes for XML PATH('') ),1,2,'')+']'
set @query='Select * from
(
SELECT Persona, Mes, Monto
FROM dbo.Ejemplos
)t
PIVOT
(
--sumamos el valor a mostrar
sum(Monto)
--ponemos el nombre de la variable
--de columnas
FOR Mes IN ('+@Columns+')
) AS PivotTable;
'
execute (@Query)
