
--17. Listar el/los artículo/s de mayor precio.
select * from Articulo a where precio = (select max(a.precio) from Articulo a)

--18. Listar el/los artículo/s de menor precio.
select * from Articulo a where precio = (select min(a.precio) from Articulo a)

--19. Listar el promedio de precios de los artículos en cada almacén.
select a.CodArt, avg(a.Precio) 'Promedio de precios' from Articulo a
group by a.CodArt

--20. Listar los almacenes que almacenan la mayor cantidad de artículos.

select a.Nro, count(distinct t.CodArt) 'cantidad articulos' from Almacen a inner join
Tiene t on a.Nro = t.NroAlmacen where t.NroAlmacen = 
(select max(t.codart) from Tiene t)


create view mayorCantArt2
AS
(
	SELECT t.NroAlmacen ,sum(t.CodArt) as 'cantArtxAlmacen' from Tiene t
	group by t.NroAlmacen
)

create view mayorCantArtTest
AS
(
	SELECT t.NroAlmacen ,count(t.CodArt) as 'cantArtxAlmacen' from Tiene t
	group by t.NroAlmacen
)

select mca2.NroAlmacen, mca2.cantArtxAlmacen from mayorCantArt2 mca2
where mca2.cantArtxAlmacen = (select max(mca2.cantArtxAlmacen) from mayorCantArt2 mca2)


SELECT distinct(t.NroAlmacen) from Tiene t -- tiene cargado 6 almacenes nomá 

-- o también así

select mcat.NroAlmacen, mcat.cantArtxAlmacen from mayorCantArtTest mcat
where mcat.cantArtxAlmacen = (select max(mcat.cantArtxAlmacen) from mayorCantArtTest mcat)

-- 21. Listar los artículos compuestos por al menos 2 materiales. (2 o más)

create view dosomásMat
as
(
select a1.CodArt from Compuesto_Por a1, Compuesto_Por a2 
where a1.CodArt = a2.CodArt and a1.CodMat <> a2.CodMat
)
--22. Listar los artículos compuestos por exactamente 2 materiales. -> dudoso 

select dom.CodArt - h2m.CodArt  from Hasta2Mat h2m, dosomásMat dom 

--23. Listar los artículos que estén compuestos con hasta 2 materiales.
create view hastadosMat
as
(
select a1.CodArt from Compuesto_Por a1, Compuesto_Por a2, Compuesto_Por a3
where a1.CodArt = a2.CodArt and a2.CodArt = a3.CodMat and  a1.CodMat <> a2.CodMat and a1.CodMat <> a3.CodMat and a2.CodMat <> a3.CodMat
)

--24. Listar los artículos compuestos por todos los materiales.
-- listar todos los articulos en donde no haya un material por el que no esté compuesto
--Para mi está bien, pero por algo lo tacharon

select a.CodArt from Articulo a where not exists(
select 1 from Material m where not exists(
select 1 from Compuesto_Por cp where cp.CodArt = a.CodArt and m.CodMat = cp.CodMat))

--25. Listar las ciudades donde existan proveedores que provean todos los materiales.
--Listar todas las ciudades en donde NO haya un material
-- que no sea provisto por un proveedor

select p.Ciudad from Proveedor p where not exists
(select 1 from Material m where not exists(
select 1 from Provisto_Por pp where p.CodProv = pp.CodProv and m.CodMat = pp.CodMat))


