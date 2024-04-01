CREATE DATABASE Ejercicio07;
go
use Ejercicio07
go
CREATE TABLE Auto
(
matricula  char(7) PRIMARY KEY,
modelo     varchar(20),
anio       integer
)

CREATE TABLE Chofer
(
NroLicencia  integer  PRIMARY KEY,
nombre       varchar(30),
apellido     varchar(30), 
fecha_ingreso date, 
telefono     varchar(15),      
)

CREATE TABLE Cliente
(
nroCliente   integer PRIMARY KEY,
calle        varchar(30),
nro          integer,
localidad    varchar(30),
)

CREATE TABLE Viaje
(
FechaHoraInicio  datetime,
FechaHoraFin     datetime,
chofer           integer,
cliente          integer,
auto             integer,
kmTotales        integer,
esperaTotal      integer,
costoEspera      integer,
costoKms         integer,
)



 
Datos:

INSERT INTO Auto VALUES (1000,'208',2020)
INSERT INTO Auto VALUES (1001,'Golf',2018)
INSERT INTO Auto VALUES (1002,'Focus',2022)

INSERT INTO Chofer VALUES (10,'Juan','Perez', CONVERT(DATE,'20/04/2019',103), null)
INSERT INTO Chofer VALUES (11,'Jorge','Gonzalez', CONVERT(DATE,'15/10/2020',103), null)
INSERT INTO Chofer VALUES (12,'Mario','Tala', '2021-03-22', null)

INSERT INTO Cliente VALUES (100,'Rivadavia',123,'CABA')
INSERT INTO Cliente VALUES (101,'Medrano',456,'CABA')
INSERT INTO Cliente VALUES (102,'Quintana',520,'Castelar')
INSERT INTO Cliente VALUES (103,'Directorio',856,'Haedo')

INSERT INTO Viaje VALUES ('2020-01-18 14:30:00','2020-01-18 17:20:00',10,100,1000,230,55,1200,9900)
INSERT INTO Viaje VALUES ('2020-01-22 09:15:00','2020-01-22 11:40:00',10,101,1001,88,0,0,7500)
INSERT INTO Viaje VALUES ('2020-01-23 09:15:00','2020-01-23 11:40:00',10,101,1002,88,0,0,7500)
INSERT INTO Viaje VALUES ('2020-01-24 09:15:00','2020-01-24 11:40:00',10,101,1003,88,0,0,7500)
INSERT INTO Viaje VALUES ('2023-05-18 09:15:00','2023-05-18 11:40:00',10,102,1001,30,0,0,6500)
INSERT INTO Viaje VALUES ('2023-05-18 19:00:00','2023-05-18 19:40:00',10,101,1000,30,0,0,4000)
INSERT INTO Viaje VALUES ('2023-05-19 09:15:00','2020-01-22 11:40:00',11,102,1002,20,0,0,3500)
INSERT INTO Viaje VALUES ('2023-05-20 09:15:00','2020-01-22 11:40:00',12,103,1002,40,0,0,4000)

