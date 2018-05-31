exec  SP_REPORTE_MATRICULADOS
alter PROCEDURE DBO.SP_REPORTE_MATRICULADOS
AS
BEGIN

Select A.cur_id, A.alu_id, Max(isnull(pag_cuota,0)) pag_cuota, SUM(isnull(pag_importe,0)) pag_importe
	Into #PagoTotal
from MATRICULA A 
full join PAGO  B 
On A.alu_id = B.alu_id and a.cur_id =  B.cur_id
group by a.cur_id, a.alu_id  

Select 
	D.alu_nombre  [Nombre Alumno],
	B.cur_nombre  [Nombre Curso], 
	B.cur_precio  [Precio Curso], 
	A.mat_cuotas  [Cuotas Programadas],
	C.pag_cuota   [Cuotas Pagadas],
	C.pag_importe [Importe Pago],
	b.cur_precio,
	(B.cur_precio - C.pag_importe) [Saldo],
	A.mat_nota    [Nota]
from 
	MATRICULA A
inner join 
	CURSO B
on A.cur_id	= B.cur_id	
inner join 
	#PagoTotal C --PAGO C	
on B.cur_id = C.cur_id and A.alu_id = C.alu_id
inner join 
	ALUMNO D
on A.alu_id = D.alu_id	
Where B.cur_matriculados <> 0
order by 1

END