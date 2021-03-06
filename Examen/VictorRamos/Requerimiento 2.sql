/*Desarrollar un procedimiento que permita obtener un reporte de todos los alumnos matriculados, 
el cual debe contemplar las siguientes 
columnas: 
▪ Nombre del alumno 
▪ Nombre del curso matriculado 
▪ Precio del curso 
▪ Cuotas programadas 
▪ Cuotas pagadas 
▪ Importe pagado 
▪ Saldo 
▪ Nota

INTEGRANTES:
1. VICTORIANO	RAMOS		LABORIO
2. KARL			FERNANDEZ	TORRES
*/

DROP PROCEDURE sp_ReporteMatricula;

create procedure sp_ReporteMatricula ( @p_fechainicio int , @p_fechafin int )
as
begin
DECLARE 
@ErrMsg varchar(1000),
@ErrSeverity varchar(1000);

begin try

SELECT 
A.alu_nombre Nombre,
C.cur_nombre Nombre_Curso,
C.cur_precio Precio_Curso,
B.mat_cuotas Cuotas_Programadas,
ISNULL(MAX(D.pag_cuota),0) Cuotas_Pagadas,
ISNULL(D.pag_importe,0) Importe_Pagado,
C.cur_precio - ISNULL(D.pag_importe,0) Saldo,
B.mat_nota Nota
FROM [EDUCA].[dbo].[ALUMNO] A
     INNER JOIN [EDUCA].[dbo].[MATRICULA] B
     ON A.alu_id=B.alu_id
                INNER JOIN [EDUCA].[dbo].[CURSO] C
                ON B.cur_id=C.cur_id 
                           LEFT JOIN [EDUCA].[dbo].[PAGO] D
                           ON A.alu_id=D.alu_id AND B.cur_id=D.cur_id
WHERE 
B.mat_fecha between CAST (LEFT(@p_fechainicio,8)   AS DATE)    AND CAST (LEFT(@p_fechafin,8)   AS DATE)                    
group by
A.alu_nombre,
C.cur_nombre,
C.cur_precio,
B.mat_cuotas,
D.pag_importe,
B.mat_nota
ORDER BY 1;
end try
    BEGIN CATCH
     select @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
     raiserror(@ErrMsg,@ErrSeverity,1)  
    END CATCH  

end;
GO


BEGIN
EXEC sp_ReporteMatricula 20180101,20180420;
END;