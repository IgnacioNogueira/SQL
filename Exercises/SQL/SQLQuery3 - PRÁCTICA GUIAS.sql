CREATE TABLE TablaPrueba(DNI int primary key, Domicilio varchar(25))
CREATE TABLE ALUMNO(Legajo int not null primary key, NyA varchar(100) Null, fechaIng Date, fechaNac Date, Mail varchar(200))
CREATE TABLE PROFESOR(Legajo int not null primary key, NyA varchar(100) Null, fechaIng Date, fechaNac Date, Mail varchar(200))
CREATE TABLE Curso(LegajoAlumno int not null, LegajoProfesor int not null, CONSTRAINT PKCURSO primary key(LegajoAlumno, LegajoProfesor), CONSTRAINT FKALUMNO foreign key(LegajoAlumno) REFERENCES ALUMNO(Legajo), CONSTRAINT FKPROFESOR FOREIGN KEY(LegajoProfesor) REFERENCES Profesor(Legajo))

ALTER TABLE ALUMNO ADD teléfono int 
alter table ALUMNO drop column teléfono

insert into ALUMNO values
(500,'Pepito test','24-08-1998','15-10-1980',null)

SELECT a.* FROM ARTICULO as a WHERE a.Precio < 100

SELECT pp.CodMat FROM Provisto_Por pp WHERE pp.CodProv = 3 AND pp.CodProv <> 5

SELECT t.NroAlmacen FROM Tiene t WHERE t.CodArt = 1

SELECT p.CodProv FROM Proveedor P WHERE P.Nombre LIKE '%Perez%' and P.Ciudad = 'Pergamino'

SELECT t.NroAlmacen FROM Tiene t WHERE t.CodArt = 1 INTERSECT (SELECT t.NroAlmacen FROM Tiene t WHERE t.CodArt = 2)

SELECT ar.CodArt FROM Articulo ar WHERE ar.Precio > 100 UNION (SELECT cp.CodArt FROM Compuesto_Por cp WHERE cp.CodMat = 1)


SELECT p.CodProv,p.Nombre FROM Proveedor p WHERE p.fecha_alta = '1990' order by p.Nombre desc

--2 LISTAR EL/LOS PROVEEDORES DADOS DE ALTA EN LA FECHA MÁS RECIENTE: (bien)

SELECT p.* FROM Proveedor p WHERE p.CodProv  not In (SELECT p1.CodProv FROM Proveedor p1, Proveedor p2 WHERE p1.fecha_alta < p2.fecha_alta)

--3 LISTAR LOS ARTICULOS CUYO PRECIO SUPERA LA MEDIA

SELECT ar.* FROM Articulo ar where ar.CodArt not in(SELECT avg(ar1.CodArt) FROM Articulo ar1, Articulo ar2 where ar1.Precio < ar2.Precio) 

--4 LISTAR TODOS LOS CÓDIGOS DE LOS ARTICULOS, DESCRIPCIÓN Y LOS CÓDIGOS DE MATERIALES POR LOS QUE ESTÁN COMPUESTOS, INFORMANDO "9999" en el código "material" para el caso de los artículos que no están compuestos por ningún material



SELECT ar.* FROM Articulo ar WHERE ar.CodArt not IN(SELECT DISTINCT a1.CodArt FROM Articulo a1, Articulo a2 where a1.Precio > a2.Precio)

--9 - Ejercicio guía 1
SELECT DISTINCT m.CodMat,m.Descripcion from Material m
						   inner join Proveedor p on p.Ciudad = 'La Plata'

						   /*
SELECT cp.CodArt FROM Compuesto_Por cp 
							inner join Compuesto_Por cp2 on cp2.CodMat

							*/
