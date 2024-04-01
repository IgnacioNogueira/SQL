use EJERCICIO12023

-- 1. Listar los nombres de los proveedores de la ciudad de La Plata.--

Select p.Nombre from PROVEEDOR p where p.Ciudad = 'La Plata'

-- 2. Listar los números de artículos cuyo precio sea inferior a $10. --

SELECT a.CodArt FROM ARTICULO a where a.Precio < 10

-- 3. Listar los responsables de los almacenes. --

SELECT a.Responsable from ALMACEN a

-- 4. Listar los códigos de los materiales que provea el proveedor 10 y no los provea el proveedor 15. --

SELECT p.CodMat FROM PROVISTO_POR p where p.CodProv = 10 and p.CodMat NOT IN (SELECT CodMat FROM PROVISTO_POR p where CodProv = 15) 

-- 5. Listar los números de almacenes que almacenan el artículo 1001.

SELECT t.Nro FROM TIENE t where t.CodArt = 1001

-- 6. Listar los proveedores de Pergamino que se llamen Pérez. -- 

select p.CodProv, p.Nombre from PROVEEDOR p where p.Ciudad = 'Pergamino' and p.Nombre LIKE '%Perez' --para buscarlo al final del string

-- 7. Listar los almacenes que contienen los artículos A y los artículos B (ambos). --
--PAJA--

-- 8. Listar los artículos que cuesten más de $10 o que estén compuestos por el Material 1. --
select * from Articulo a INNER JOIN COMPUESTO_POR c ON a.CodArt = c.CodArt
Where a.Precio > 10 OR C.CodMat = 1

-- 9. Listar los materiales, código y descripción, provistos por proveedores de la ciudad de Rosario. --

select m.CodMat,m.descripcion,p.Nombre, p.Ciudad from MATERIAL m
RIGHT JOIN PROVISTO_POR pp ON m.CodMat = pp.CodMat
RIGHT JOIN PROVEEDOR p ON p.CodProv = pp.CodProv where p.Ciudad = 'Rosario'


-- más óptimo:

/*
En esta consulta, utilizamos INNER JOIN para unir las tablas en lugar de RIGHT JOIN. Esto se debe a que INNER JOIN solo devuelve las filas que tienen coincidencias en todas las tablas unidas, lo que asegura que solo obtendremos los materiales provistos por proveedores de la ciudad de Rosario.

Además, hemos reorganizado el orden de las uniones para unir primero las tablas PROVISTO_POR y MATERIAL, y luego unir la tabla PROVEEDOR. Esto se debe a que generalmente es más eficiente unir primero las tablas que tienen una relación directa y luego agregar las uniones adicionales.
*/

SELECT m.CodMat, m.descripcion, p.Nombre, p.Ciudad
FROM PROVISTO_POR pp
INNER JOIN MATERIAL m ON m.CodMat = pp.CodMat
INNER JOIN PROVEEDOR p ON p.CodProv = pp.CodProv
WHERE p.Ciudad = 'Rosario';

-- 10. Listar el código, descripción y precio de los artículos que se almacenan en 1. --

SELECT a.Nro,a.Responsable, art.CodArt, art.descripcion, art.Precio FROM ALMACEN a 
INNER JOIN TIENE t ON a.Nro = t.Nro
INNER JOIN ARTICULO art ON t.CodArt = art.CodArt
where a.Nro = 1

-- 11. Listar la descripción de los materiales que componen el artículo 1001. --

-- material compuesto por art

Select m.CodMat,m.descripcion from MATERIAL m 
INNER JOIN COMPUESTO_POR cp ON m.CodMat = cp.CodMat 
INNER JOIN ARTICULO a ON cp.CodArt = a.CodArt
where a.CodArt = 1001 


-- 12. Listar los nombres de los proveedores que
-- proveen los materiales al almacén que
-- Martín Gómez tiene a su cargo.

-- PROVEEDOR PROVISTO POR MATERIAL TIENE ALMACEN

SELECT p.Nombre FROM PROVEEDOR p 
INNER JOIN PROVISTO_POR pp ON p.CodProv = pp.CodProv
INNER JOIN MATERIAL m ON m.CodMat = pp.CodMat
INNER JOIN COMPUESTO_POR cp ON cp.CodMat = m.CodMat
INNER JOIN TIENE t ON t.CodArt = cp.CodArt
INNER JOIN ALMACEN a ON a.Nro = t.Nro
where a.Responsable = 'María López'


SELECT p.Nombre FROM PROVEEDOR p 
INNER JOIN PROVISTO_POR pp ON p.CodProv = pp.CodProv
INNER JOIN MATERIAL m ON m.CodMat = pp.CodMat
INNER JOIN COMPUESTO_POR cp ON cp.CodMat = m.CodMat
INNER JOIN TIENE t ON t.CodArt = cp.CodArt
INNER JOIN ALMACEN a ON a.Nro = t.Nro
where a.Responsable = 'Jose Basualdo'


-- 13. Listar códigos y descripciones de los artículos compuestos por al menos un material provisto por el proveedor 1

-- ARTICULO COMPUESTO_POR PROVISTO POR PROVEEDOR

SELECT a.CodArt, a.descripcion
FROM ARTICULO a
INNER JOIN COMPUESTO_POR cp ON a.CodArt = cp.CodArt
INNER JOIN MATERIAL m ON cp.CodMat = m.CodMat
INNER JOIN PROVISTO_POR pp ON m.CodMat = pp.CodMat
INNER JOIN PROVEEDOR p ON pp.CodProv = p.CodProv
WHERE p.Nombre = '%1';


-- 14. Hallar los códigos y nombres de los proveedores que proveen al menos un material que se usa en algún artículo cuyo precio es mayor a $10.

-- PROVEEDOR PROVISTO POR MATERIAL COMPUESTO POR ARTICULO

SELECT p.CodProv,p.Nombre FROM PROVEEDOR p
where EXISTS(
select 1 from PROVISTO_POR pp 
INNER JOIN MATERIAL m ON pp.CodMat = m.CodMat
INNER JOIN COMPUESTO_POR cp ON cp.CodMat = m.CodMat
INNER JOIN ARTICULO a ON a.CodArt = cp.CodArt
where a.Precio > 10 AND pp.CodProv = p.CodProv)


-- 15. Listar los números de almacenes que tienen todos los artículos que incluyen el
-- material con código 123.

-- LISTAR TODOS LOS NROS DE ALMACENES EN DONDE NO HAYA UN ARTICULO QUE NO TENGA EL MATERIAL CON EL CÓDIGO 123

-- ALMACEN TIENE ARTICULO COMPUESTO_POR MATERIAL

-- 1:
create view matCodigo
as
(
	select cp.CodArt from Compuesto_Por cp
	where cp.CodMat = '123'
)

select a.nro as 'Almacén', a.Responsable from almacen a 
where not exists(select 1 from matCodigo mc where not exists(
select 1 from Tiene t where t.Nro = a.nro and mc.CodArt = t.CodArt ))

-- 2:

SELECT a.Nro from ALMACEN a where not exists(
SELECT * FROM ARTICULO ar inner join COMPUESTO_POR cp on ar.CodArt = cp.CodArt 
where not exists (select * from MATERIAL m
where m.CodMat = '123')


SELECT a.Nro from ALMACEN a where not exists(
SELECT * FROM ARTICULO ar inner join COMPUESTO_POR cp on ar.CodArt = cp.CodArt 
where not exists (select * from MATERIAL m
where m.CodMat = '6')

-- 16. Listar los proveedores de Capital Federal que sean únicos proveedores de algún material.

-- PROVEEDORES PROVISTO POR MATERIAL

--1:

CREATE VIEW AlgunMat as(
SELECT pp.CodMat,COUNT(*) 'CANT'
FROM PROVISTO_POR pp
group by pp.CodMat 
having COUNT(*) >= 1
)


SELECT p.CodProv, p.Nombre FROM PROVEEDOR p
INNER JOIN PROVISTO_POR pp ON p.CodProv = pp.CodProv
INNER JOIN AlgunMat am ON am.CodMat = pp.CodMat
where p.Ciudad = 'Capital Federal'

--2:

SELECT p.CodProv, p.Nombre FROM PROVEEDOR p
INNER JOIN PROVISTO_POR pp ON p.CodProv = pp.CodProv
INNER JOIN MATERIAL m ON pp.CodMat = m.CodMat
WHERE p.Ciudad = 'Capital Federal'
GROUP BY p.CodProv, p.Nombre
HAVING COUNT(DISTINCT pp.CodMat) = 1

-- 17. Listar el/los artículo/s de mayor precio.CREATE VIEW mayorPrecio as(SELECT MAX(a.precio) precio FROM ARTICULO a)select * from ARTICULO a INNER JOIN mayorPrecio mp ON a.Precio = mp.precio-- 18. Listar el/los artículo/s de menor precio.CREATE VIEW menorPrecio as(select MIN(a.precio) precio from ARTICULO a)select * from ARTICULO a INNER JOIN menorPrecio mp ON a.Precio = mp.precio-- 19. Listar el promedio de precios de los artículos en cada almacén. select am.Nro as 'Almacen', avg(a.Precio) 'Promedio precios'
 from articulo a 
 INNER JOIN tiene t on t.CodArt = a.CodArt
 INNER JOIN ALMACEN am ON am.Nro = t.Nro
 group by am.Nro

SELECT t.Nro, AVG(Precio)
FROM Tiene t, Articulo a
WHERE t. CodArt = a. CodArt
GROUP BY t.Nro

 --20. Listar los almacenes que almacenan la mayor cantidad de artículos.
-- ALMACEN TIENE

CREATE VIEW mayorCantidadArt AS(
select t.Nro, COUNT(t.CodArt) Cantidad from TIENE t 
GROUP BY t.Nro
)

SELECT mca.Nro as 'Almacen' FROM mayorCantidadArt mca
WHERE mca.Cantidad = (SELECT MAX(mca2.Cantidad)
FROM mayorCantidadArt mca2)

-----21. Listar los artículos compuestos por al menos 2 materiales.

-- ARTICULOS COMPUESTO_POR MATERIALES


Select * from ARTICULO a where EXISTS( 
select COUNT(CP.CodMat) Cant_Mat from COMPUESTO_POR cp
group by cp.CodArt HAVING COUNT(CP.CodMat) >= 2)

SELECT CodArt, count(*) MATERIALES
from COMPUESTO_POR
GROUP BY CodArt
HAVING count(*) >= 2