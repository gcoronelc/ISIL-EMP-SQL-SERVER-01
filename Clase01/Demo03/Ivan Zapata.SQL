
select *
from EduTec.dbo.Matricula
where  CONVERT(VARCHAR(24),FecMatricula,112)  
between  '20181129' and '20181205'
order by FecMatricula;

