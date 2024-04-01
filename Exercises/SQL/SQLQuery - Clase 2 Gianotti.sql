Use [Clase 2 - SQL];

create Table Alumno 
(Legajo int PRIMARY KEY,
nom varchar(30),
ape varchar(30),
email varchar(40),
telefono char(15)
)

create Table Materia
(
	cod_mat integer PRIMARY KEY,
	nom_mat varchar(45),
	anio_carrera integer
)

create Table Cursa
(
	legajo integer FOREIGN KEY REFERENCES Alumno(Legajo),
	cod_mat integer FOREIGN KEY REFERENCES Materia(cod_mat),
	PRIMARY KEY(legajo,cod_mat)
)

GO

-- carga de datos

INSERT INTO Materia VALUES(100,'Analisis matemático 1',1)
INSERT INTO Materia VALUES(101,'Algebra 1',1)
INSERT INTO Materia VALUES(201,'Fisica 1',2)
INSERT INTO Materia VALUES(202,'Algebra 2',2)
INSERT INTO Materia VALUES(301,'Base de datos',3)
INSERT INTO Materia VALUES(302,'Probabilidad y estadística',3)


select * from Materia

INSERT INTO Alumno Values
(10,'Maria','Suarez',null,null),
(11,'Pablo','Perez',null,null),
(12,'Laura','Almagro',null,null),
(13,'Jorge','Gonzales',null,null)

SELECT * FROM Alumno

INSERT INTO Cursa VALUES
(13,202),
(13,301),
(13,302),
(11,100),
(11,101),
(12,101),
(12,201),
(12,301),
(13,202),
(13,301),
(13,302)

-- Listar los legajos y apellidos de los alumnos
-- que cursan todas las materias de tercer año

--SE DEDUCE TAMBIÉN: LISTAR TODOS LOS ALUMNOS TALES QUE NO EXISTA UNA MATERIA DE 3ER AÑIO QUE NO CURSEN

select a.Legajo, a.ape from Alumno a where not exists (select m.cod_mat from Materia m where m.anio_carrera = 3 AND NOT EXISTS( SELECT * FROM Cursa c  where c.legajo = a.legajo and c.cod_mat = m.cod_mat))

-- listar todos los alumnos que no cursen ninguna materia (OJOOOO NO ES COCIENTE)

--1era
select *
from Alumno a where not exists( select * from cursa c where c.legajo = a.Legajo)

--2da forma

select * from Alumno a where legajo not in(select legajo from Cursa c)

-- 3era

SELECT legajo from Alumno except select legajo from cursa  


-- Listar los clientes que compraron en todas las sucursales de avellanda 

--select c.nombre,c.ape from clientes c where not exists( select * from sucursal s where  not in(select cantCompra from compras)


--PARCIAL SUSHI
-- Listar los usuarios que han realizado pedidos en todos los comercios de categorio sushi del partido de Morón entre el 01/01/2020 y el 01/07/2021
-- Cociente

-- LISTAR TODOS LOS USUARIOS QUE NO EXISTE UN COMERCIO DE SUSHI DE MORÓN QUE NO HAYAN REALIZADO PEDIDOS ENTRE 01/01/2020 Y 01/07/2021

select * from Usuario u where NOT EXISTS(SELECT * FROM SushiMoron s WHERE
											NOT EXISTS(SELECT * FROM Pedido pe WHERE pe.idUsuario = u.id AND
																					 pe.idComercio = s.id AND
																					 pe.fecha >= '01-01-2020' AND pe.fecha <='01-07-2021'))
CREATE VIEW SushiMoron AS
(
	SELECT id FROM Comercio co, Categoria ca, Partido pa 
	where co.idPartido = pa.id  
	AND co.idCategoria = ca.id 
	AND ca.desc = 'Sushi' 
	AND pa.nombre = 'Moron'
)

---------------------------------------------- listo clase 2










	

)

