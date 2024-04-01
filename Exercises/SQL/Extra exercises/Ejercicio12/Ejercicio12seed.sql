/*Dado el siguiente esquema de relación:
Producto (CodProd, Descripcion, CodProv, StockActual)
Stock (Nro, Fecha, CodProd, Cantidad)
Proveedor (CodProv, RazonSocial, FechaInicio)*/

CREATE DATABASE Ejercicio12
go
use Ejercicio12
go


drop table PROVEEDOR
drop table PRODUCTO
drop table stock

CREATE TABLE PROVEEDOR(
CodProv int not null primary key,
RazonSocial varchar(50),
FechaInicio date
)

INSERT INTO PROVEEDOR (CodProv, RazonSocial, FechaInicio)
VALUES (1, 'Proveedor A', '2021-01-01'),
(2, 'Proveedor B', '2020-05-10'),
(3, 'Proveedor C', '2019-09-15');

select * from PROVEEDOR

CREATE TABLE PRODUCTO(
CodProd int not null primary key,
Descripcion varchar(50),
CodProv int not null,
CONSTRAINT FKProducto foreign key(CodProv)
references Proveedor(CodProv),
StockActual smallint
)

INSERT INTO PRODUCTO (CodProd, Descripcion, CodProv, StockActual)
VALUES (1, 'Producto A', 1, 50),
(2, 'Producto B', 2, 20),
(3, 'Producto C', 1, 100),
(4, 'Producto D', 3, 10);


CREATE TABLE STOCK(
Nro int,
Fecha date,
codProd int,
CONSTRAINT PKSTOCK primary key(Nro,Fecha,CodProd),
CONSTRAINT FKSTOCK foreign key(codProd) references Producto(CodProd),
Cantidad int
)

INSERT INTO STOCK (Nro, Fecha, CodProd, Cantidad)
VALUES (1, '2021-05-01', 1, 10),
(2, '2021-05-01', 2, 5),
(3, '2021-05-02', 1, 20),
(4, '2021-05-02', 3, 15),
(5, '2021-05-03', 2, 8);


delete from PROVEEDOR
-- Insertar proveedores
INSERT INTO PROVEEDOR (CodProv, RazonSocial, FechaInicio)
VALUES (1, 'Proveedor A', '2022-01-01'),
       (2, 'Proveedor B', '2021-05-10'),
       (3, 'Proveedor C', '2020-11-15');

-- Insertar productos
INSERT INTO PRODUCTO (CodProd, Descripcion, CodProv, StockActual)
VALUES (1, 'Producto 1', 1, 10),
       (2, 'Producto 2', 1, 5),
       (3, 'Producto 3', 2, 0),
       (4, 'Producto 4', 2, 0),
       (5, 'Producto 5', 3, 3),
       (6, 'Producto 6', 3, 0);

-- Insertar stocks
INSERT INTO STOCK (Nro, Fecha, codProd, Cantidad)
VALUES (1, '2022-05-01', 1, 5),
       (2, '2022-06-15', 1, 3),
       (3, '2022-02-28', 2, 0),
       (4, '2022-03-10', 2, 0),
       (5, '2021-12-20', 3, 0),
       (6, '2021-11-05', 3, 0),
       (7, '2021-08-10', 4, 0),
       (8, '2021-09-25', 4, 0),
       (9, '2022-01-05', 5, 2),
       (10, '2022-02-20', 5, 1),
       (11, '2022-01-10', 6, 0),
       (12, '2021-10-15', 6, 0);
