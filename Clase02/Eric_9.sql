select A.alu_nombre,C.cur_nombre,B.mat_nota,
case when B.mat_nota<10 then 'Malo'
when B.mat_nota>=10 and B.mat_nota<14 then 'Regular'
when B.mat_nota>=14 and B.mat_nota<18 then 'Bueno'
when B.mat_nota>=18 then 'Excelente' end Calificacion
 from EDUCA.dbo.ALUMNO A
 inner join educa.dbo.matricula B
 on A.alu_id=B.alu_id
 inner join EDUCA.dbo.CURSO C
 on B.cur_id=C.cur_id
 order by 1