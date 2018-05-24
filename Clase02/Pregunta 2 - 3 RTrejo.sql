--Select * from dbo.ALUMNO

--select * from dbo.PAGO

--select * from dbo.CURSO

--- PREGUNTA 2:

Select a.alu_nombre, SUM(isnull(b.pag_importe,0)) Pago_Total 
									from 
										dbo.ALUMNO a
												left join 
															dbo.PAGO b
										on a.alu_id = b.alu_id
group by 		a.alu_nombre
order by 1								

--- PREGUNTA 3:

Select a.cur_nombre, SUM(isnull(b.pag_importe,0)) Pago_Total 
									from 
										dbo.CURSO a
												left join 
															dbo.PAGO b
										on a.cur_id = b.cur_id
group by 		a.cur_nombre
order by 1								
