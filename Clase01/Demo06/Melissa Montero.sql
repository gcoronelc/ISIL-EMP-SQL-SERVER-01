select * 
from EduTec.dbo.Matricula m
where FecMatricula between '28-11-2018' and '05-12-2018'
order by m.FecMatricula desc;