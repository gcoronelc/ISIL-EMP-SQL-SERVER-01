


select 
	e.*,
	e.sueldo + ISNULL( e.comision, 0 ) total
from RH.dbo.empleado e;