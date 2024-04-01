-- Creación de la base de datos
create database ejercicio1;
GO
--creación de las tablas
use ejercicio1;
create table Almacen (Nro int primary key, Responsable varchar(50))
create table Articulo (CodArt int primary key, Descripcion varchar(50), Precio decimal(12, 3))
create table Material (CodMat int primary key, Descripcion varchar(50))
create table Proveedor (CodProv int primary key, Nombre varchar(50), Domicilio varchar(50), Ciudad varchar(50), fecha_alta date)
create table Tiene (NroAlmacen int, CodArt int)
create table Compuesto_Por (CodArt int, CodMat int)
create table Provisto_Por (CodMat int, CodProv int)
GO
-- carga de datos
insert into Almacen values
(1, 'Juan Perez'),
(2, 'Jose Basualdo'),
(3, 'Rogelio Rodriguez'),
(4, 'Rogelio Funes Mori'),
(5, 'Jonathan Maidana'),
(6, 'Gabriel Mercado'),
(7, 'Leonel Vangioni'),
(8, 'Carlos Sanchez')
insert into Articulo values
(1, 'Sandwich JyQ', 60),
(2, 'Pancho', 60),
(3, 'Hamburguesa', 180),
(4, 'Hamburguesa completa', 250),
(5, 'Hamburguesa Premium', 350),
(6, 'Picada tradicional Chica', 450),
(7, 'Picada tradicional Mediana', 650),
(8, 'Picada tradicional Grande', 850),
(9, 'Picada Premium 10 personas', 1250)
insert into Material values
(1, 'Pan'),
(2, 'Jamon'),
(3, 'Queso'),
(4, 'Salchicha'),
(5, 'Pan Pancho'),
(6, 'Paty'),
(7, 'Lechuga'),
(8, 'Tomate'),
(9, 'Mortadela'),
(10, 'Fiambrín'),
(11, 'Pan de Campo'),
(12, 'Salame Tandilero'),
(13, 'Salchichón con Jamón'),
(14, 'Aceitunas con Morrón')
insert into Proveedor values
(1, 'Panadería Carlitos', 'Carlos Calvo 1212', 'CABA','01-01-1990'),
(2, 'Fiambres Perez', 'San Martin 121', 'Pergamino','01-01-1990'),
(3, 'Almacen San Pedrito', 'San Pedrito 1244', 'CABA','01-01-1992'),
(4, 'Carnicería Boedo', 'Av. Boedo 3232', 'CABA','01-01-1993'),
(5, 'Verdulería Platense', '5 3232', 'La Plata','01-01-1994'),
(6, 'Granja Porco Rex', 'Av 7 287', 'La Plata','01-01-1995'),
(7, 'Pollería KFC', 'Italia 954', 'San Fernando','01-01-1996'),
(8, 'Chacinados Los Pibes', 'María de Carmen 765', 'San Fernando del Valle de Catamarca','01-01-1997'),
(9, 'Picadas Picadiyi', 'Av Corrientes 1200', 'Corrientes Capital','01-01-1998'),
(10, 'Picadas La Matanza', 'Av Juan Manuel de Rosas', 'San Justo','01-01-1999'),
(11, 'Chacinados Ciudadela', 'Av Marite García 220', 'Ramos Mejía','01-01-1990'),
(12, 'Chacinados 43', 'La Plata 343', 'Ciudadela','01-01-2007'),
(13, 'Picadillos 44', 'Independencia 1343', 'Mar del Plata','01-01-2008'),
(14, 'Maxi Quiosco Rosita', 'Varela 343', 'San Justo','01-01-2009'),
(15, 'Maxi Mercado El Gallito', 'Santander 943', 'Ituzaingó','01-01-2010')

insert into Tiene values
--Juan Perez
(1, 1),
(1, 2),
--Jose Basualdo
(2, 1),
(2, 2),
(2, 3),
(2, 4),
--Rogelio Rodriguez
(3, 1),
(3, 2),
(3, 3),
(3, 4),
--Rogelio Funes Mori
(4, 1),
(4, 3),
(4, 5),
(4, 8),
--Jonathan Maidana
(5, 2),
(5, 7),
(5, 8),
(5, 9),
--Carlos Sanchez
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 8),
(8, 9)
insert into Compuesto_Por values
--Sandwich JyQ
(1, 1), (1, 2), (1, 3),
--Pancho
(2, 4), (2, 5),
--Hamburguesa
(3, 1), (3, 6),
--Hamburguesa completa
(4, 1), (4, 6), (4, 7), (4, 8),
--Picada Premium
(9,12)
insert into Provisto_Por values
--Pan
(1, 1), (1, 3), (1, 6),
--Jamon
(2, 2), (2, 3), (2, 4),(2, 6),
--Queso
(3, 2), (3, 3),(3, 6),
--Salchicha
(4, 3), (4, 4),(4, 6),
--Pan Pancho
(5, 1), (5, 3),(5, 6),
--Paty
(6, 3), (6, 4),(6, 6),
--Lechuga
(7, 3), (7, 5),(7, 6),
--Tomate
(8, 3), (8, 5), (8, 6),(8, 10),(8, 15),
-- Salchichón
(9, 6),(10, 6),(11, 6),(12, 6),(13, 6),(13, 10),
-- Aceitunas
(14, 10),(14, 6),(14, 15)





