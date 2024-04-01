CREATE DATABASE EJERCICIO12023;
go
use EJERCICIO12023
go
CREATE TABLE ALMACEN(
Nro Smallint not null primary key, 
Responsable varchar(50)
)

CREATE TABLE ARTICULO(
CodArt int not null primary key, 
descripcion varchar(60),
Precio decimal)

CREATE TABLE MATERIAL(
CodMat Smallint not null primary key, 
descripcion varchar(60))

CREATE TABLE PROVEEDOR(
CodProv Smallint not null primary key, 
Nombre varchar(50),
Domicilio varchar(60),
Ciudad varchar(60)
)

CREATE TABLE TIENE(
Nro Smallint not null, 
CodArt int not null,
constraint PKTiene primary key(Nro,CodArt),
CONSTRAINT FK1_Tiene FOREIGN KEY (Nro) REFERENCES ALMACEN (Nro),
CONSTRAINT FK2_Tiene FOREIGN KEY (CodArt) REFERENCES ARTICULO (CodArt)
)

CREATE TABLE COMPUESTO_POR(
CodArt int not null,
CodMat Smallint not null,
constraint PK_Compuesto_Por primary key(CodArt,CodMat),
CONSTRAINT FK1_Compuesto_Por FOREIGN KEY (CodArt) REFERENCES ARTICULO (CodArt),
CONSTRAINT FK2_Compuesto_Por FOREIGN KEY (CodMat) REFERENCES MATERIAL (CodMat)
)

CREATE TABLE PROVISTO_POR(
CodMat Smallint not null,
CodProv Smallint not null,
constraint PK_Provisto_Por primary key(CodMat,CodProv),
CONSTRAINT FK1_Provisto_Por FOREIGN KEY (CodMat) REFERENCES MATERIAL (CodMat),
CONSTRAINT FK2_Provisto_Por FOREIGN KEY (CodProv) REFERENCES PROVEEDOR (CodProv)
)


-- Inserción de datos en la tabla ALMACEN
INSERT INTO ALMACEN (Nro, Responsable) VALUES
(1, 'Martín perez'),
(2, 'María López'),
(3, 'Carlos Rodríguez'),
(4, 'Martín perez'),
(5, 'Martín perez'),
(6, 'Martín Gomez'),
(7, 'Martín Gomez');


-- Inserción de datos en la tabla ARTICULO
INSERT INTO ARTICULO (CodArt, Descripcion, Precio) VALUES
(1001, 'Artículo A', 9.99),
(1002, 'Artículo B', 15.50),
(1003, 'Artículo C', 7.25);

-- Inserción de datos en la tabla MATERIAL
INSERT INTO MATERIAL (CodMat, Descripcion) VALUES
(1, 'Material X'),
(2, 'Material Y'),
(3, 'Material Z');

-- Inserción de datos en la tabla PROVEEDOR
INSERT INTO PROVEEDOR (CodProv, Nombre, Domicilio, Ciudad) VALUES
(10, 'Proveedor 1', 'Calle 123', 'La Plata'),
(11, 'Proveedor 2', 'Calle 456', 'La Plata'),
(12, 'Proveedor 3', 'Calle 789', 'Rosario'),
(15, 'Proveedor 4', 'Calle 101', 'Rosario');

INSERT INTO PROVEEDOR (CodProv, Nombre, Domicilio, Ciudad) VALUES
(16, 'Proveedor 5 - Perez', 'Calle 101', 'Pergamino');



-- Inserción de datos en la tabla TIENE
INSERT INTO TIENE (Nro, CodArt) VALUES
(1, 1001),
(1, 1002),
(2, 1002),
(3, 1003);

-- Inserción de datos en la tabla COMPUESTO_POR
INSERT INTO COMPUESTO_POR (CodArt, CodMat) VALUES
(1001, 1),
(1001, 2),
(1002, 2),
(1002, 3),
(1003, 1),
(1003, 3);

INSERT INTO PROVISTO_POR (CodProv, CodMat) VALUES
(10, 1),
(10, 2),
(11, 1),
(11, 3),
(12, 2),
(12, 3),
(15, 1),
(15, 3);


