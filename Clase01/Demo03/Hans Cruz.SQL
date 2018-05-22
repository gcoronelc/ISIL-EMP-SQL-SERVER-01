
select * from EduTec..Matricula m
where FecMatricula   between 
cast('2018-11-28' AS DATE) 
and cast('2018-12-04' as DATE)
order by FecMatricula;
