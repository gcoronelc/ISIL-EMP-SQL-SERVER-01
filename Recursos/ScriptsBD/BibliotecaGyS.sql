USE Master
go

IF EXISTS( SELECT name FROM sysdatabases
	WHERE name = 'BibliotecaGyS' )
DROP DATABASE BibliotecaGyS
go

CREATE DATABASE BibliotecaGyS
go

USE BibliotecaGyS
go

CREATE TABLE USUARIO (
       usu_cod              char(6) NOT NULL,
       usu_pat              varchar(20) NOT NULL,
       usu_mat              varchar(20) NOT NULL,
       usu_nom              varchar(20) NOT NULL,
       usu_dir              varchar(60) NOT NULL,
       usu_tel              varchar(20) NULL,
       usu_hab              int NOT NULL,
       PRIMARY KEY (usu_cod)
)
go


CREATE TABLE TEMA (
       tem_cod              int NOT NULL,
       tem_des              varchar(40) NOT NULL,
       PRIMARY KEY (tem_cod)
)
go

CREATE TABLE PUBLICACION (
       pub_cod              int NOT NULL,
       pub_nom              varchar(100) NOT NULL,
       pub_aut              varchar(45) NOT NULL,
       tem_cod              int NOT NULL,
       pub_sum              varchar(350) NULL,
       PRIMARY KEY (pub_cod), 
       FOREIGN KEY (tem_cod)
                             REFERENCES TEMA
)
go

CREATE TABLE EJEMPLAR (
       eje_num              int NOT NULL,
       pub_cod              int NOT NULL,
       eje_edi              varchar(45) NULL,
       eje_num_edi          int NULL,
       eje_dis              char(1) NULL,
       PRIMARY KEY (eje_num, pub_cod), 
       FOREIGN KEY (pub_cod)
                             REFERENCES PUBLICACION
)
go

CREATE TABLE RECIBO (
       rec_num              int NOT NULL,
       rec_fec_emi          datetime NOT NULL,
       rec_mon              decimal(8,0) NOT NULL,
       PRIMARY KEY (rec_num)
)
go

CREATE TABLE PRESTAMO (
       pub_cod              int NOT NULL,
       pre_fec_sal          datetime NOT NULL,
       eje_num              int NOT NULL,
       usu_cod              char(6) NOT NULL,
       pre_fec_dev          datetime NULL,
       pre_fec_ent          datetime NULL,
       pre_mul_imp          decimal(8,0) NULL,
       pre_mul_pag          decimal(8,0) NULL,
       rec_num              int NULL,
       PRIMARY KEY (pub_cod, pre_fec_sal, eje_num), 
       FOREIGN KEY (rec_num)
                             REFERENCES RECIBO,
       FOREIGN KEY (usu_cod)
			        REFERENCES USUARIO,
       FOREIGN KEY (pub_cod)
                             REFERENCES PUBLICACION
)
go

CREATE TABLE RESERVACION (
       res_cod             int NOT NULL IDENTITY(1,1),
       pub_cod              int NOT NULL,
       usu_cod              char(6) NOT NULL,
       res_fec              datetime NOT NULL,
       pre_eje		char(1) NOT NULL,
       PRIMARY KEY (res_cod), 
       FOREIGN KEY (usu_cod)
                             REFERENCES USUARIO 
)
go

CREATE TABLE BIBLIOTECARIO (
       bib_cod              int NOT NULL,
       bib_nom              varchar(45) NOT NULL,
       bib_dir              varchar(60) NULL,
       bib_tel              varchar(20) NULL,
       bib_cla              varchar(10) NOT NULL,
       PRIMARY KEY (bib_cod)
)
go

SELECT name FROM sysobjects
	WHERE type = 'U'
go

/* CARGA DE LA DATA */
-- Carga datos a la tabla USUARIO

INSERT usuario		VALUES( '961002', 'BARRIONUEVO', 'CASTILLO', 'ABELARDO', 'LOS PINOS 234 - URB. SAN LUCAS - LOS OLIVOS', NULL, 1)
INSERT usuario		VALUES( '961003', 'ANTAYHUA', 'OSORIO', 'ANA ROSA', 'AV. ARICA 1312 - BREÑA', '4321234', 1)
INSERT usuario		VALUES( '961004', 'QUISPE', 'CUYUBAMBA', 'JUAN JOSE', 'AV. URUGUAY 546 - CERCADO - LIMA', '4303426', 1)
INSERT usuario		VALUES( '961005', 'ALTAMIRANO', 'CASTRILLON', 'MARIO', 'COSME BUENO 256 - URB. SAN JOSE - BELLAVISTA', '4518456', 1)
INSERT usuario		VALUES( '961006', 'LUQUE', 'OSORIO', 'ISRAEL', 'LUNA PIZARRO 1345 - LA VICTORIA', '4329865', 1)
INSERT usuario		VALUES( '961007', 'BARRIONUEVO', 'CASTILLO', 'JUANA ELOISA', 'AV. ARENALES 1234 - LINCE', NULL, 1)
INSERT usuario		VALUES( '961008', 'INFANTE', 'OROZCO', 'MANUEL', 'JR. SANTA CAROLINA 123 - URB. PALAO - SAN MARTIN', NULL, 1)
INSERT usuario		VALUES( '961009', 'GOMEZ', 'CASTILLO', 'ANTONIO', 'LOS PINOS 563 - URB. SAN LUCAS - LOS OLIVOS', '4523421', 1)
INSERT usuario		VALUES( '961010', 'ZAVALA', 'CASTRO', 'ARMANDO', 'AV. LIMA 1367 - SAN MARTIN', '4751234', 1)
INSERT usuario		VALUES( '962002', 'TINEO', 'ASCENCIO', 'MARIA ROSA', 'LOS ALAMOS 354 - URB. SAN JOAQUIN - CALLAO', '4513421', 1)
INSERT usuario		VALUES( '962003', 'CHUQUIN', 'JURADO', 'VILMA JULIANA', 'LAS CUCARDAS 1234 - URB. SANTA CECILIA - BELLAVISTA', NULL, 1)
INSERT usuario		VALUES( '962004', 'VILLANUEVA', 'TEXEIRA', 'ZOILA ANA', 'JR. JUNIN 3425 - SAN MARTIN', NULL, 1)
INSERT usuario		VALUES( '962005', 'HUAMAN', 'MERCEDES', 'ABEL', 'AV. MANCO CAPAC 1234 - LA VICTORIA', '4305678', 1)
INSERT usuario		VALUES( '962006', 'VICTORINO', 'DEL CASTILLO', 'JUAN', 'AV. LA PAZ 344 - MIRAFLORES', '5763341', 1)
INSERT usuario		VALUES( '962007', 'ANTAYHUA', 'LOPEZ', 'CESAR', 'AV. ALFONSO UGARTE 1348 - LIMA', '4328970', 1)
INSERT usuario		VALUES( '962008', 'LEON', 'SAAVEDRA', 'CESAR AUGUSTO', 'LOS CONSTRUCTORES 457 - LA MOLINA', NULL, 1)
INSERT usuario		VALUES( '971012', 'ALARCON', 'CASTILLEJO', 'ANTONIO JOSE', 'JR. CHIQUIAN 1222 - URB. EL RETABLO - COMAS', NULL, 1)
INSERT usuario		VALUES( '971013', 'DIEZ CANSECO', 'IBARGUEN', 'JULIO CESAR', 'LOS PINOS 234 - MIRAFLORES', NULL, 1)
INSERT usuario		VALUES( '971014', 'CABALLERO', 'OSORIO', 'MARIANA', 'ESTEBAN SALMON 231 - URB. INGENIERIA - SAN MARTIN', '4810098', 1)
INSERT usuario		VALUES( '971015', 'ZAMORANO', 'MENENDEZ', 'ISOLINA', 'AV. TUPAC AMARU 1345 - INDEPENDENCIA', NULL, 1)
INSERT usuario		VALUES( '971016', 'ZAMBRANO', 'ASTOCONDOR', 'ESTHER', 'AV. VENEZUELA 1108 - BREÑA', '4231868', 1)
INSERT usuario		VALUES( '971017', 'HUERTAS', 'MARCELO', 'ANA MARIA', 'JR. RECUAY 397 - BREÑA', NULL, 1)
INSERT usuario		VALUES( '971018', 'ARRIOLA', 'EVANS', 'MARCELA', 'LAS AMAZONAS S/N MZA. Z LOTE 2 - LOS OLIVOS', '4523489', 1)
INSERT usuario		VALUES( '971019', 'JIMENEZ', 'MAC ALLISTER', 'DIANA', 'JR. GENERAL VIDAL 348 - SAN ISIDRO', NULL, 1)
INSERT usuario		VALUES( '971020', 'APOLAYA', 'CASTRO', 'IVONNE', 'BARRIO OBRERO 1378 - LA VICTORIA', '4352378', 1)
INSERT usuario		VALUES( '971021', 'SOTELO', 'HUAMAN', 'JULIO', 'ALBERTO GRIEVE 1231 - URB. INGENIERIA - SAN MARTIN', '9983456', 1)
INSERT usuario		VALUES( '971022', 'CARHUANCHO', 'HUAMANI', 'MIGUEL', 'AV. DEL AIRE 1352 - URB. CORPAC - SAN BORJA', NULL, 1)
INSERT usuario		VALUES( '971023', 'QUINTANILLA', 'JURADO', 'WILLIAM', 'LOS INSURGENTES 1856 - URB. ZARATE - SAN JUAN', '5322183', 1)
INSERT usuario		VALUES( '971024', 'MEJIA', 'BARZOLA', 'WILMER', 'HEROES DEL CENEPA 342 - URB. LA ALBORADA - SURCO', NULL, 1)
INSERT usuario		VALUES( '971025', 'TUPAC YUPANQUI', 'NUGGENT', 'JOSE', 'JR. JUNIN 1734 - LA VICTORIA', NULL, 1)
INSERT usuario		VALUES( '971026', 'CASAVILCA', 'VIDAL', 'ABELINO', 'AV. DEL PARQUE NORTE 1965 - SAN BORJA', '5755689', 1)
INSERT usuario		VALUES( '971027', 'CHIPANA', 'PALOMINO', 'IGNACIO', 'JR. TAMBO DE BELEN 342 - LIMA', '4342378', 1)

-- Carga datos a la tabla BIBLIOTECARIO

INSERT bibliotecario	VALUES(  1, 'CERCADO SANCHEZ, ANTERO', 'AV. LARCO 345 - MIRAFLORES', '4756743', 'moroco' )
INSERT bibliotecario	VALUES(  2, 'LLATAS CASTRO, ERLY', 'AV. TIAHUANACO 764 - URB. MANGOMARCA - SAN JUAN', NULL, 'barbon' )
INSERT bibliotecario	VALUES(  3, 'TRUJILLO GAMARRA, CARLOS', 'AV. TUPAC AMARU 3467 - COMAS', '5753456', 'figura' )
INSERT bibliotecario	VALUES(  4, 'LOARTE CARLOS, LUIS', 'JR. ZEPITA 568 - SAN LUIS', '4713254', 'manco' )
INSERT bibliotecario	VALUES(  5, 'SILVA COLLAZOS, SUSY', 'URB. LOS CONDORES MZA B LOTE 19 - SAN JUAN', NULL, 'limon' )
INSERT bibliotecario	VALUES(  6, 'TORRES RAMOS, MIRTHA', 'JR. RIO DE JANEIRO 245 - JESUS MARIA', '4325487', 'tanque' )
INSERT bibliotecario	VALUES(  7, 'CRUZ EGOAVIL, MAGALY', 'JR. FRANCISCO BOLOGNESI 186 - EL AGUSTINO', NULL, 'tabla' )

-- Carga datos a la tabla TEMA

INSERT tema		VALUES(  1, 'ANALISIS Y DISEÑO DE SISTEMAS' )
INSERT tema		VALUES(  2, 'ADMINISTRADORES DE BASES DE DATOS' )
INSERT tema		VALUES(  3, 'LENGUAJES DE PROGRAMACION' )
INSERT tema		VALUES(  4, 'PROGRAMACION VISUAL' )
INSERT tema		VALUES(  5, 'PROCESADORES DE TEXTO' )
INSERT tema		VALUES(  6, 'SISTEMAS OPERATIVOS' )
INSERT tema		VALUES(  7, 'MICROPROCESADORES' )
INSERT tema		VALUES(  8, 'DICCIONARIOS' )
INSERT tema		VALUES(  9, 'DATA WAREHOUSING' )
INSERT tema		VALUES( 10, 'TEORIA DE BASE DE DATOS' )
INSERT tema		VALUES( 11, 'ECONOMIA' )
INSERT tema		VALUES( 12, 'MATEMATICAS' )
INSERT tema		VALUES( 13, 'ADMINISTRACION' )
INSERT tema		VALUES( 14, 'PROGRAMACION WEB' )
INSERT tema		VALUES( 15, 'XML' )
INSERT tema		VALUES( 16, 'INTERNET' )

-- Carga datos a la tabla PUBLICACION

INSERT publicacion	VALUES(  1, 'ANALISIS Y DISEÑO DE SISTEMAS', 'KENDALL, KENNETH E. - KENDALL, JULIE E.', 1, NULL )
INSERT publicacion	VALUES(  2, 'DBASE III PLUS - HERRAMIENTAS PODEROSAS', 'KRUMM, ROB', 2, NULL )
INSERT publicacion	VALUES(  3, 'FOXPRO 2.5 PARA DOS Y WINDOWS', 'GARCIA-BADELL, JOSE JAVIER', 2, NULL )
INSERT publicacion	VALUES(  4, 'PROGRAMACION EN FOXPRO', 'PALMER, SCOTT D.', 2, NULL )
INSERT publicacion	VALUES(  5, 'LIBRERIAS EN CLIPPER 5.01', 'MARIN - QUIROS - TORRES', 2, NULL )
INSERT publicacion	VALUES(  6, 'COMO USAR FOXPRO', 'CORONEL C., GUSTAVO - MATSUKAWA M., SERGIO', 2, NULL )
INSERT publicacion	VALUES(  7, 'SISTEMAS DE INFORMACION', 'MARTIN, JAMES', 1, NULL )
INSERT publicacion	VALUES(  8, 'TECNICAS AVANZADAS EN C', 'SOBELMAN, GERALD E.', 3, NULL )
INSERT publicacion	VALUES(  9, 'MICROSOFT FOXPRO - UPDATE', 'MICROSOFT CORPORATION', 2, NULL )
INSERT publicacion	VALUES( 10, 'CLIPPER 5 - REFERENCIA RAPIDA', 'MARIN - QUIROS - TORRES', 2, NULL )
INSERT publicacion	VALUES( 11, 'CA-CLIPPER 5.2', 'MARTIN CABALLERO, LUIS y JUAN', 2, NULL )
INSERT publicacion	VALUES( 12, 'CLIPPER 5.01', 'RAMALHO, JOSE ANTONIO', 2, NULL )
INSERT publicacion	VALUES( 13, 'CLIPPER 5.2 AVANZADO', 'RAMALHO, JOSE A.', 2, NULL )
INSERT publicacion	VALUES( 14, 'ENCICLOPEDIA DE MICROSOFT VISUAL BASIC', 'JAVIER CEBALLOS, FCO.', 4, NULL )
INSERT publicacion	VALUES( 15, 'MICROSOFT WORD 7 PASO A PASO', 'CATAPULT, INC.', 5, NULL )
INSERT publicacion	VALUES( 16, 'WORD FOR WINDOWS VERSION 6', 'BONILLA, RICARDO - GARCIA, HERNAN', 5, NULL )
INSERT publicacion	VALUES( 17, 'MICROSOFT MS DOS - MANUAL DEL USUARIO', 'MICROSOFT', 6, NULL )
INSERT publicacion	VALUES( 18, 'CONOZCA SU PC', 'MATSUKAWA MAEDA, SERGIO', 6, NULL )
INSERT publicacion	VALUES( 19, 'EL LIBRO DEL MS DOS', 'VAN WOLVERTON', 6, NULL )
INSERT publicacion	VALUES( 20, 'APLIQUE SQL', 'GROFF, JAMES R. - WEINBERG, PAUL N.', 2, NULL )
INSERT publicacion	VALUES( 21, 'MANUAL DEL MICROPROCESADOR 80386', 'PAPPAS, CHRIS - MURRAY, WILLIAM', 7, NULL )
INSERT publicacion	VALUES( 22, 'MICROSOFT FOXPRO PARA WINDOWS 2.5', 'CATAPULT, INC.', 2, NULL )
INSERT publicacion	VALUES( 23, 'DICCIONARIO PARA USUARIOS DE COMPUTADORAS', 'PFAFFENBERGER, BRYAN', 8, NULL )
INSERT publicacion	VALUES( 24, 'DATA WAREHOUSING', 'HARJINDER - PRAKASH', 9, NULL )
INSERT publicacion	VALUES( 25, 'PROGRAMMING FOXPRO 2.5', 'LISKIN, MIRIAM', 2, NULL )
INSERT publicacion	VALUES( 26, 'TECNICAS DE BASES DE DATOS', 'ATRE SHAKUNTALA', 10, NULL )
INSERT publicacion	VALUES( 27, 'IMPLEMENTING A DATABASE DESIGN ON MS SQL SERVER 6.5', 'MICROSOFT', 2, NULL )
INSERT publicacion	VALUES( 28, 'MICROSOFT SQL SERVER - ADMINISTRATOR COMPANION', 'MICROSOFT', 2, NULL )
INSERT publicacion	VALUES( 29, 'ORACLE - INTRODUCCION A PL/SQL V.2.0', 'ORACLE CORPORATION', 2, NULL )
INSERT publicacion	VALUES( 30, 'MACROECONOMIA', 'DORNBUSCH, RUDIGER', 11, NULL )
INSERT publicacion	VALUES( 31, 'ECONOMIA INTERNACIONAL', 'SALVATORE, DOMINICK', 11, NULL )
INSERT publicacion	VALUES( 32, 'INVESTIGACION OPERATIVA - APLICACIONES A LA ECONOMIA', 'ESPINOSA, H', 12, NULL )
INSERT publicacion	VALUES( 33, 'MATEMATICA BASICA', 'VENERO, ARMANDO', 12, NULL )
INSERT publicacion	VALUES( 34, 'VECTORES Y MATRICES', 'FIGUEROA GARCIA, RICARDO', 12, NULL )
INSERT publicacion	VALUES( 35, 'EL CALCULO CON GEOMETRIA ANALITICA', 'LEITHOD, LOUIS', 12, NULL )
INSERT publicacion	VALUES( 36, 'REINGENIERIA', 'HAMMER, MICHAEL - CHAMPY, JAMES', 13, NULL )
INSERT publicacion	VALUES( 37, 'ESTADISTICA PARA ADMINISTRACION Y ECONOMIA', 'STEVENSON, WILLIAM', 12, NULL )
INSERT publicacion	VALUES( 38, 'INTRODUCCION A LA ECONOMIA', 'ROSSETTI, JOSE PASCHOAL', 11, NULL )
INSERT publicacion	VALUES( 39, 'QUE ES EL CONTROL TOTAL DE CALIDAD?', 'ISHIKAWA, KAORU', 13, NULL )
INSERT publicacion	VALUES( 40, 'ANALISIS Y DISEÑO ORIENTADO A OBJETOS', 'MARTIN, JAMES - ODELL, JAMES', 1, NULL )
INSERT publicacion	VALUES( 41, 'SISTEMAS OPERATIVOS - DISEÑO E IMPLEMENTACION', 'DEITEL', 6, NULL )
INSERT publicacion	VALUES( 42, 'DISEÑO CONCEPTUAL DE DATOS', 'BATTINI CERI', 10, NULL )
INSERT publicacion	VALUES( 43, 'LOS MICROPROCESADORES INTEL AVANZADOS', 'BERRY, BARRY B.', 7, NULL )

INSERT publicacion	VALUES( 44, 'DESARROLLO DE APLICACIONES C/S CON ERWIN 3, SQL SERVER 7 Y VISUAL BASIC 6', 'CORONEL CASTILLO, GUSTAVO', 4, NULL )
INSERT publicacion	VALUES( 45, 'DESARROLLO DE APLICACIONES CON PHP4 Y MYSQL', 'BUSTAMANTE GUTIERREZ, CESAR', 14, NULL )
INSERT publicacion	VALUES( 46, 'JAVA - GUIA DE DESARROLLO', 'JAWORSKI, JAMIE', 3, NULL )
INSERT publicacion	VALUES( 47, 'OXFORD ADVANCED LEARNER''S DICTIONARY', 'OXFORD UNIVERSITY PRESS', 8, NULL )
INSERT publicacion	VALUES( 48, 'ORACLE 9i - GUIA DE APRENDIZAJE', 'ABBEY - COREY - ABRAMSIN', 2, NULL )
INSERT publicacion	VALUES( 49, 'IMPLEMENTING A DATABASE ON MS SQL SERVER 7 - MOC 833', 'MICROSOFT', 2, NULL )
INSERT publicacion	VALUES( 50, 'DESIGNING & IMPLEMENTING DATA WAREHOUSE USING MS SQL SERVER 7 - MOC 1502', 'MICROSOFT', 9, NULL )
INSERT publicacion	VALUES( 51, 'DESIGNING & IMPLEMENTING OLAP SOLUTION USING MS SQL SERVER - MOC 2574', 'MICROSOFT', 9, NULL )
INSERT publicacion	VALUES( 52, 'CREACION DE SITIOS WEB CON MS SQL SERVER 7', 'BYRNE, JEFFRY', 14, NULL )
INSERT publicacion	VALUES( 53, 'PROGRAMACION DE MS SQL SERVER 2000 CON XML', 'MALCOLM, GRAEME', 15, NULL )
INSERT publicacion	VALUES( 54, 'APRENDIENDO MS SQL SERVER 2000 EN 21 DIAS', 'WAYMIRE, RICHARD - SAWTELL, RICK', 2, NULL )
INSERT publicacion	VALUES( 55, 'MS VISUAL BASIC 6 - MANUAL DEL PROGRAMADOR', 'MICROSOFT PRESS', 4, NULL )
INSERT publicacion	VALUES( 56, 'MS VISUAL INTERDEV 6 - MANUAL DEL PROGRAMADOR', 'MICROSOFT PRESS', 14, NULL )
INSERT publicacion	VALUES( 57, 'FOUNDATIONS OF POWERBUILDER PROGRAMMING', 'SMITH, BRIAN - SCHAAD, GORDON', 4, NULL )
INSERT publicacion	VALUES( 58, 'DESARROLLO DE SOLUCIONES XML', 'STURM, JACK', 15, NULL )
INSERT publicacion	VALUES( 59, 'IIS 4.0 MCSE STUDY GUIDE', 'DILLON, JEFF - LINTHICUM, STEVEN', 16, NULL )
INSERT publicacion	VALUES( 60, 'ECOMMERCE - FORMULACION DE UNA ESTRATEGIA', 'PLANT, ROBERT', 16, NULL )

-- Carga datos a la tabla EJEMPLAR

INSERT ejemplar	VALUES( 1, 1, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'N' )
INSERT ejemplar	VALUES( 2, 1, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 3, 1, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'N' )
INSERT ejemplar	VALUES( 1, 2, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1, 3, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1, 4, 'ANAYA MULTIMEDIA', 1, 'N' )
INSERT ejemplar	VALUES( 1, 5, 'RA-MA', 1, 'S' )
INSERT ejemplar	VALUES( 2, 5, 'RA-MA', 1, 'S' )
INSERT ejemplar	VALUES( 1, 6, 'GESTION & SISTEMAS', 2, 'N' )
INSERT ejemplar	VALUES( 2, 6, 'GESTION & SISTEMAS', 2, 'S' )
INSERT ejemplar	VALUES( 3, 6, 'GESTION & SISTEMAS', 2, 'S' )
INSERT ejemplar	VALUES( 1, 7, 'EL ATENEO', 1, 'S' )
INSERT ejemplar	VALUES( 1, 8, 'ANAYA MULTIMEDIA', 1, 'N' )
INSERT ejemplar	VALUES( 2, 8, 'ANAYA MULTIMEDIA', 1, 'N' )
INSERT ejemplar	VALUES( 3, 8, 'ANAYA MULTIMEDIA', 1, 'S' )
INSERT ejemplar	VALUES( 1, 9, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,10, 'RA-MA', 1, 'S' )
INSERT ejemplar	VALUES( 2,10, 'RA-MA', 1, 'S' )
INSERT ejemplar	VALUES( 1,11, 'RPH PUBLICACIONES', 1, 'S' )
INSERT ejemplar	VALUES( 1,12, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 2,12, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1,13, 'MC GRAW - HILL', 2, 'N' )
INSERT ejemplar	VALUES( 2,13, 'MC GRAW - HILL', 2, 'N' )
INSERT ejemplar	VALUES( 1,14, 'RA-MA', 1, 'N' )
INSERT ejemplar	VALUES( 2,14, 'RA-MA', 1, 'N' )
INSERT ejemplar	VALUES( 3,14, 'RA-MA', 1, 'N' )
INSERT ejemplar	VALUES( 1,15, 'MICROSOFT PRESS', 1, 'S' )
INSERT ejemplar	VALUES( 2,15, 'MICROSOFT PRESS', 1, 'S' )
INSERT ejemplar	VALUES( 1,16, 'FUNDATEC COSTA RICA', 1, 'S' )
INSERT ejemplar	VALUES( 2,16, 'FUNDATEC COSTA RICA', 1, 'S' )
INSERT ejemplar	VALUES( 1,17, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 2,17, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,18, 'GESTION & SISTEMAS', 3, 'N' )
INSERT ejemplar	VALUES( 2,18, 'GESTION & SISTEMAS', 3, 'S' )
INSERT ejemplar	VALUES( 3,18, 'GESTION & SISTEMAS', 3, 'S' )
INSERT ejemplar	VALUES( 1,19, 'ANAYA MULTIMEDIA', 5, 'S' )
INSERT ejemplar	VALUES( 2,19, 'ANAYA MULTIMEDIA', 5, 'S' )
INSERT ejemplar	VALUES( 3,19, 'ANAYA MULTIMEDIA', 5, 'S' )
INSERT ejemplar	VALUES( 1,20, 'MC GRAW - HILL', 1, 'N' )
INSERT ejemplar	VALUES( 2,20, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1,21, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1,22, 'MICROSOFT PRESS', 1, 'S' )
INSERT ejemplar	VALUES( 2,22, 'MICROSOFT PRESS', 1, 'S' )
INSERT ejemplar	VALUES( 1,23, 'PRENTICE HALL HISPANOAMERICANA S.A.', 3, 'S' )
INSERT ejemplar	VALUES( 1,24, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'N' )
INSERT ejemplar	VALUES( 1,25, 'ZIFF DAVIS PRESS', 1, 'N' )
INSERT ejemplar	VALUES( 1,26, 'TRILLAS', 1, 'S' )
INSERT ejemplar	VALUES( 1,27, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,28, 'MICROSFOT CORPORATION', 1, 'N' )
INSERT ejemplar	VALUES( 1,29, 'ORACLE CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,30, 'MC GRAW - HILL', 6, 'S' )
INSERT ejemplar	VALUES( 2,30, 'MC GRAW - HILL', 6, 'N' )
INSERT ejemplar	VALUES( 1,31, 'MC GRAW - HILL', 3, 'N' )
INSERT ejemplar	VALUES( 2,31, 'MC GRAW - HILL', 3, 'S' )
INSERT ejemplar	VALUES( 1,32, 'EDITORIAL PAX', 6, 'S' )
INSERT ejemplar	VALUES( 1,33, 'EDITORIAL SAN MARCOS', 1, 'S' )
INSERT ejemplar	VALUES( 2,33, 'EDITORIAL SAN MARCOS', 1, 'S' )
INSERT ejemplar	VALUES( 3,33, 'EDITORIAL SAN MARCOS', 1, 'S' )
INSERT ejemplar	VALUES( 1,34, 'IMPRESIONES GRAFICAS AMERICA', 2, 'S' )
INSERT ejemplar	VALUES( 2,34, 'IMPRESIONES GRAFICAS AMERICA', 2, 'S' )
INSERT ejemplar	VALUES( 3,34, 'IMPRESIONES GRAFICAS AMERICA', 2, 'S' )
INSERT ejemplar	VALUES( 1,35, 'HARLA S.A. de C.V.', 2, 'S' )
INSERT ejemplar	VALUES( 2,35, 'HARLA S.A. de C.V.', 2, 'N' )
INSERT ejemplar	VALUES( 3,35, 'HARLA S.A. de C.V.', 2, 'N' )
INSERT ejemplar	VALUES( 1,36, 'MORGAN', 1, 'N' )
INSERT ejemplar	VALUES( 2,36, 'MORGAN', 1, 'S' )
INSERT ejemplar	VALUES( 1,37, 'HARLA S.A. de C.V.', 1, 'S' )
INSERT ejemplar	VALUES( 2,37, 'HARLA S.A. de C.V.', 1, 'S' )
INSERT ejemplar	VALUES( 1,38, 'JOSE PASCHOAL ROSSETTI', 7, 'S' )
INSERT ejemplar	VALUES( 2,38, 'JOSE PASCHOAL ROSSETTI', 7, 'S' )
INSERT ejemplar	VALUES( 3,38, 'JOSE PASCHOAL ROSSETTI', 7, 'S' )
INSERT ejemplar	VALUES( 1,39, 'GRUPO EDITORIAL NORMA', 1, 'N' )
INSERT ejemplar	VALUES( 2,39, 'GRUPO EDITORIAL NORMA', 1, 'S' )
INSERT ejemplar	VALUES( 1,40, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'N' )
INSERT ejemplar	VALUES( 2,40, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 3,40, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'N' )
INSERT ejemplar	VALUES( 1,41, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 1,42, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 2,42, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 3,42, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1,43, 'MEGABYTE', 1, 'S' )

INSERT ejemplar	VALUES( 1,44, 'GRAPPERU DESARROLLO', 1, 'S' )
INSERT ejemplar	VALUES( 2,44, 'GRAPPERU DESARROLLO', 1, 'S' )
INSERT ejemplar	VALUES( 3,44, 'GRAPPERU DESARROLLO', 1, 'S' )
INSERT ejemplar	VALUES( 1,45, 'GRAPPERU DESARROLLO', 1, 'S' )
INSERT ejemplar	VALUES( 2,45, 'GRAPPERU DESARROLLO', 1, 'S' )
INSERT ejemplar	VALUES( 1,46, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 2,46, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 1,47, 'OXFORD UNIVERSITY', 1, 'S' )
INSERT ejemplar	VALUES( 1,48, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 2,48, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1,49, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,50, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,51, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,52, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 1,53, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1,54, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 2,54, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 1,55, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,56, 'MICROSOFT CORPORATION', 1, 'S' )
INSERT ejemplar	VALUES( 1,57, 'IDG BOOKS', 1, 'S' )
INSERT ejemplar	VALUES( 2,57, 'IDG BOOKS', 1, 'S' )
INSERT ejemplar	VALUES( 1,58, 'MC GRAW - HILL', 1, 'S' )
INSERT ejemplar	VALUES( 1,59, 'IDG BOOKS', 1, 'S' )
INSERT ejemplar	VALUES( 1,60, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )
INSERT ejemplar	VALUES( 2,60, 'PRENTICE HALL HISPANOAMERICANA S.A.', 1, 'S' )

-- Carga datos a la tabla PRESTAMO

INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(8,1,'971027',getdate()-57,getdate()-54,getdate()-54)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(20,1,'971019',getdate()-57,getdate()-54,getdate()-54)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(4,1,'971012',getdate()-55,getdate()-52,getdate()-52)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(51,1,'961002',getdate()-55,getdate()-52,getdate()-52)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(14,2,'971022',getdate()-55,getdate()-52,getdate()-52)

INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(1,1,'961005',getdate()-49,getdate()-46,getdate()-46)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(56,1,'961005',getdate()-49,getdate()-46,getdate()-46)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(18,1,'961002',getdate()-49,getdate()-46,getdate()-46)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(30,2,'971019',getdate()-45,getdate()-42,getdate()-42)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(36,1,'971017',getdate()-45,getdate()-42,getdate()-42)

INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(1,3,'962004',getdate()-39,getdate()-36,getdate()-36)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(54,1,'961008',getdate()-39,getdate()-36,getdate()-36)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(44,2,'962002',getdate()-39,getdate()-36,getdate()-36)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(6,1,'961008',getdate()-35,getdate()-32,getdate()-32)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(13,1,'962002',getdate()-35,getdate()-32,getdate()-32)

INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(8,2,'971026',getdate()-31,getdate()-29,getdate()-29)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(40,1,'971020',getdate()-31,getdate()-29,getdate()-29)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(31,1,'971015',getdate()-31,getdate()-29,getdate()-29)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(14,3,'971024',getdate()-25,getdate()-22,getdate()-22)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(25,1,'971023',getdate()-25,getdate()-22,getdate()-22)

INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(49,1,'962004',getdate()-21,getdate()-18,getdate()-18)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(13,2,'962004',getdate()-21,getdate()-18,getdate()-18)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(14,1,'971014',getdate()-21,getdate()-18,getdate()-18)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(45,1,'971012',getdate()-17,getdate()-14,getdate()-14)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(48,1,'962007',getdate()-17,getdate()-14,getdate()-14)

INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(24,1,'971022',getdate()-13,getdate()-10,getdate()-10)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(40,3,'971017',getdate()-13,getdate()-10,getdate()-10)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(35,3,'961004',getdate()-10,getdate()-7,getdate()-7)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(39,1,'971019',getdate()-10,getdate()-7,getdate()-7)
INSERT prestamo(pub_cod, eje_num, usu_cod, pre_fec_sal, pre_fec_dev, pre_fec_ent)
	VALUES(35,2,'971024',getdate()-10,getdate()-7,getdate()-7)


