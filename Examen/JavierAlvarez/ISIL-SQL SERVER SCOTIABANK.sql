USE [EDUCA]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[REGISTRO_MATRICULA] 
(	@p_cur_id INT, 
	@p_alu_id VARCHAR, 
	@p_mat_cuotas INT, 
	@p_pag_importe MONEY)
AS
BEGIN		

DECLARE	
@VALIDA_M AS INT,
@VALIDA_V AS INT,
@MSG_ERROR NVARCHAR(100)

SET @VALIDA_M=(SELECT COUNT(*) FROM dbo.MATRICULA WHERE alu_id=@p_alu_id AND CUR_ID=@p_cur_id);
SET @VALIDA_V=(SELECT cur_vacantes-cur_matriculados AS CUPOS FROM DBO.CURSO WHERE cur_id=@p_cur_id);

IF @p_mat_cuotas>3
BEGIN
PRINT 'MAXIMO SE PUEDE PAGAR EN 3 CUOTAS'
END

IF @p_mat_cuotas>1  AND @p_pag_importe<(SELECT (cur_precio/2) FROM dbo.CURSO WHERE cur_id=@p_cur_id)
BEGIN
PRINT 'LA PRIMERA CUOTA DEBE SER '
END

IF @VALIDA_M>=1
BEGIN
PRINT 'EL ALUMNO YA SE ENCUNTRA MATRICULADO EN EL CURSO'
END

IF @VALIDA_V=0
BEGIN
PRINT 'NO HAY CUPOS PARA EL CURSO'
END


INSERT INTO dbo.MATRICULA
VALUES(
@p_cur_id,
@p_alu_id,
GETDATE(),
(SELECT cur_precio FROM dbo.CURSO WHERE cur_id=@p_cur_id),
@p_mat_cuotas,
NULL)

INSERT INTO dbo.PAGO
VALUES(
@p_cur_id,
@p_alu_id,
1,
GETDATE(),
@p_pag_importe
)

END;




-- pregunta 2
CREATE PROCEDURE dbo.sp_ReporteMatriculados
AS



select a.alu_nombre AS NOMBRE_ALUMNO,  c.cur_nombre AS NOMBRE_CURSO, c.cur_precio AS PRECIO_CURSO, m.mat_cuotas AS CUOTAS_PROGRAMADAS, ISNULL(max(p.pag_cuota),0) AS CUOTAS_PAGADAS, 
ISNULL(sum(p.pag_importe),0) as IMPORTE_PAGADO, (c.cur_precio-ISNULL(sum(p.pag_importe),0)) AS SALDO, M.mat_nota
from dbo.MATRICULA m
left join dbo.ALUMNO a
on m.alu_id=a.alu_id
left join PAGO p
on m.alu_id=p.alu_id and m.cur_id=p.cur_id
left join CURSO c
on m.cur_id=c.cur_id
GROUP BY a.alu_nombre,  c.cur_nombre, c.cur_precio, m.mat_cuotas, M.mat_nota
order by 1