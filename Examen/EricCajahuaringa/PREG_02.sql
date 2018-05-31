CREATE PROCEDURE DBO.SP_REGISTRO_MATRICULADOS
---(@ALU_ID INT OUT)
AS
   BEGIN
  
     SELECT ALUMNO = A.ALU_NOMBRE , CURSO_MATRICULADO = C.CUR_NOMBRE, PRECIO_CURSO = B.MAT_PRECIO, 
        CUOTA_PROGRAMADA = B.MAT_CUOTAS, CUOTA_PAGADA = MAX(PAG_CUOTA), SUM(D.pag_importe) AS IMPORTE_PAGADO,  SALDO = B.MAT_PRECIO - SUM(D.pag_importe), NOTA = B.mat_nota  FROM dbo.ALUMNO A 
        INNER JOIN DBO.MATRICULA B ON A.alu_id = B.alu_id
          INNER JOIN dbo.CURSO C ON B.cur_id = C.cur_id  
           INNER JOIN dbo.PAGO D ON C.cur_id  = D.cur_id AND B.alu_id = D.alu_id
             --WHERE A.alu_id = @ALU_ID
            GROUP BY A.ALU_NOMBRE, C.CUR_NOMBRE, B.MAT_PRECIO, B.MAT_CUOTAS , B.mat_nota 
       
       END;
       GO
       
EXEC DBO.SP_REGISTRO_MATRICULADOS 




     
   

