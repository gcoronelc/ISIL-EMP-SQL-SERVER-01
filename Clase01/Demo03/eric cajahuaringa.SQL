select * 
from EduTec.dbo.Matricula M 
where M.FecMatricula between 
cast('28-11-2018' as date) 
and cast('05-12-2018' as date)
