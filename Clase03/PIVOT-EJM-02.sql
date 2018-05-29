
create table dbo.Ejemplos(
	CodPersona smallint identity(1,1) primary key,
	Persona nvarchar(35),
	Mes nvarchar(10),
	Monto decimal(5,2)
)
go

insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Jameson','Enero',125.2)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Cesar','Febrero',35.5)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Jorge','Enero',30.1)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Cesar','Marzo',55.8)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Jorge','Abril',25.0)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Jameson','Abril',30.1)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Jameson','Enero',55.8)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Jorge','Febrero',25.0)
insert into dbo.Ejemplos(Persona, Mes, Monto) values ('Cesar','Enero',55.8)
go

select * from dbo.Ejemplos
go

SELECT 
	Persona,  
	isnull([Enero],0)[Enero],
	isnull([Febrero],0)[Febrero],
	isnull([Marzo],0)[Marzo],
	isnull([Abril],0)[Abril]
FROM
(
	SELECT Persona, Mes, Monto 
	FROM dbo.Ejemplos
) AS TablaDatos
PIVOT
(
	--sumamos el valor a mostrar
	sum(Monto)
	FOR Mes IN ([Enero],[Febrero],[Marzo],[Abril])
) AS PivotTable;
go



