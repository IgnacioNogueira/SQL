-----1. Listar los nombres de los proveedores de la ciudad de La Plata.
select p.Nombre,p.Ciudad from Proveedor p where p.Ciudad like '%La Plata%'
-----1. Adicional.... Listar los proveedores cuya localidad contenga la cadena �Carlos�

select p.nombre from proveedor p where p.domicilio like '%Carlos%'

-----4. Listar los c�digos de los materiales que provea el proveedor 10 y no los provea el
--proveedor 15.



select pp.codMat from provisto_por pp where pp.CodProv = 10 and pp.codProv <> 15

-----8. Listar los art�culos que cuesten m�s de $100 o que est�n compuestos por el material M1.

select a.codArt from articulo a
inner join compuesto_por cp on a.codArt = cp.codArt
where a.precio < 100 and cp.codMat = 1

--9. Listar los materiales, c�digo y descripci�n, provistos por proveedores de la ciudad BS AS.

select m.codMat,m.descripcion from material m
inner join provisto_por pp on m.codMat = pp.codMat
inner join proveedor p on pp.CodProv = p.CodProv
where p.Ciudad = 'CABA'

--10. Listar el c�digo, descripci�n y precio de los art�culos que se almacenan en A1.

SELECT distinct A.CodArt, a.descripcion,a.Precio 
FROM ARTICULO a
inner join tiene t on a.codArt = t.CodArt
inner join almacen alm on t.codArt = alm.nro
where alm.nro = 1

--11. Listar la descripci�n de los materiales que componen el art�culo Pancho.

select distinct m.descripcion from material m
inner join compuesto_por cp on m.codMat = cp.codMat
Inner join articulo a on cp.codArt = a.codArt
where a.descripcion = 'Pancho'

--12. Listar los nombres de los proveedores que proveen los materiales al almac�n que Mart�n G�mez tiene a su cargo.


select distinct p.nombre from proveedor p
inner join provisto_por pp on p.codProv = pp.codProv
inner join material m on pp.codMat = m.codMat
inner join compuesto_por cp on m.codMat = cp.codMat
inner join tiene t on cp.codArt = t.codArt
inner join almacen a on t.nroAlmacen = a.Nro
where a.responsable like '%Juan Perez%'

--13. Listar c�digos y descripciones de los art�culos compuestos por al menos un material provisto por el proveedor Carnicer�a Boedo.

select distinct a.codArt, a.descripcion from Articulo a
inner join compuesto_por cp on a.codArt = cp.codArt
inner join material m on m.codMat = cp.codMat
inner join provisto_por pp on m.codMat = pp.codMat
inner join proveedor p on pp.codProv = p.CodProv
where p.nombre = 'Carnicer�a Boedo'


-----15. Listar los n�meros de almacenes que tienen todos los art�culos que incluyen el material con c�digo 123.

--Listar los nros de almacecnes en el que no haya material con codigo 123 que no tenga en todos los articulos


create view matCodigo
as
(
	select cp.CodArt from Compuesto_Por cp
	where cp.CodMat = '123'
)

select a.nro as 'Almac�n', a.Responsable from almacen a 
where not exists(select 1 from matCodigo mc where not exists(
select 1 from Tiene t where t.NroAlmacen = a.nro and mc.CodArt = t.CodArt ))

-- 16. Listar los proveedores de Capital Federal que sean
-- �nicos proveedores de alg�n material.

alter view algunMat
as
(
SELECT PP.codmat, COUNT(*) 'CANT'
 FROM PROVISTO_POR PP
 GROUP BY PP.codmat
 HAVING COUNT(*) >= 1

)



select distinct p.CodProv,p.Nombre from Proveedor p 
inner join Provisto_Por pp on p.CodProv = pp.CodProv
inner join algunMat am on pp.CodMat = am.codMat
where p.Ciudad = 'CABA'


--18. Listar el/los art�culo/s de menor precio.

 CREATE VIEW MENORPRECIO AS
 SELECT MIN(precio) precio
 FROM ARTICULO

 SELECT A.descripcion
 FROM ARTICULO A 
 INNER JOIN MENORPRECIO MNP ON A.precio = MNP.precio


 create view mayorprecio as
 (
 select min(precio) 'Precio' from Articulo
 )

 select a.CodArt,a.Descripcion from Articulo a
 inner join mayorprecio mp on a.Precio = mp.Precio
 group by a.CodArt,a.Descripcion

 --19. Listar el promedio de precios de los art�culos en cada almac�n.

 select avg(a.Precio) 'Promedio precios' from articulo a 
 inner join tiene t on t.CodArt = a.CodArt
 group by t.NroAlmacen

 --20. Listar los almacenes que almacenan la mayor cantidad de art�culos.


 CREATE VIEW ALMACEN_ARTICULOS as
 SELECT T.NroAlmacen, count(*)CANT_ARTICULOS
 FROM TIENE T
 GROUP BY T.NroAlmacen


 SELECT AA.NroAlmacen
 FROM ALMACEN_ARTICULOS AA
 WHERE AA.CANT_ARTICULOS = (SELECT MAX(AA2.CANT_ARTICULOS)
					       FROM ALMACEN_ARTICULOS AA2)

-----21. Listar los art�culos compuestos por al menos 2 materiales.

SELECT A.CodArt FROM ARTICULO A 
INNER JOIN Compuesto_Por CP ON A.CodArt = CP.CodArt
INNER JOIN Compuesto_Por CP2 ON A.CodArt = CP2.CodArt
AND CP.CodMat <> CP2.CodMat
GROUP BY A.CodArt,A.Descripcion

SELECT DISTINCT CP.CodArt FROM Compuesto_Por CP,Compuesto_Por CP2
WHERE CP.CodArt = CP2.CodArt AND CP.CodMat <> CP2.CodMat

--23. Listar los art�culos que est�n compuestos con hasta 2 materiales. (m�s de 2)

SELECT DISTINCT CP.CodArt FROM Compuesto_Por CP, Compuesto_Por CP2, Compuesto_Por CP3
WHERE CP.CodArt = CP2.CodArt AND CP.CodArt = CP3.CodArt AND CP.CodMat <> CP2.CodMat AND CP.CodMat <> CP3.CodMat AND CP2.CodMat <> CP3.CodMat

-- Exactamente dos

SELECT dm.CodArt FROM dosom�sMat dm
except 
select hdm.CodArt from Hasta2Mat hdm

-- �

SELECT A.codart, A.descripcion
 FROM ARTICULO A
 INNER JOIN COMPUESTO_POR CP1 ON A.codart = CP1.codart 
 INNER JOIN COMPUESTO_POR CP2 ON A.codart = CP2.codart AND CP1.codmat <> CP2.codmat
 EXCEPT
 SELECT A.codart, A.descripcion
 FROM ARTICULO A
 INNER JOIN COMPUESTO_POR CP1 ON A.codart = CP1.codart 
 INNER JOIN COMPUESTO_POR CP2 ON A.codart = CP2.codart AND CP1.codmat <> CP2.codmat
 INNER JOIN COMPUESTO_POR CP3 ON A.codart = CP3.codart AND CP1.codmat <> CP2.codmat AND CP1.codmat <> CP3.codmat AND CP2.codmat <> CP3.codmat

 --24. Listar los art�culos compuestos por todos los materiales.

 -- listar todos los los articulos en el que no haya material por el que no est� compuesto

 
 select a.CodArt from Articulo a 
 where not exists( select 1 from Material m where not exists(
 select 1 from Compuesto_Por cp where cp.CodArt = a.CodArt and m.CodMat = cp.CodMat
 ))

 --25. Listar las ciudades donde existan proveedores que provean todos los materiales.

 -- listar las ciudades donde no haya material que no sea provisto por algun proveedor

 select p.Ciudad from Proveedor p 
 where not exists( select 1 from material m where not exists( 
 select 1 from Provisto_Por pp where p.CodProv = pp.CodProv and m.CodMat =pp.CodMat))

