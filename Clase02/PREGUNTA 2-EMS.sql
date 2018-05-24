--### PREGUNTA 2 #####
select a.alu_nombre alumno,SUM(b.pag_importe) pagos from dbo.alumno a inner join dbo.PAGO b
on a.alu_id=b.alu_id
group by a.alu_nombre




--