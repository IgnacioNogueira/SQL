-----1. Listar los nombres de los proveedores de la ciudad de La Plata.
-----1. Adicional.... Listar los proveedores cuya localidad contenga la cadena “Fernando”
-----2. Listar los números de artículos cuyo precio sea inferior a $10.
--3. Listar los responsables de los almacenes.
-----4. Listar los códigos de los materiales que provea el proveedor 10 y no los provea el
      --proveedor 15.
-----5. Listar los números de almacenes que almacenan el artículo A.
-----6. Listar los proveedores de Pergamino que se llamen Pérez.
-----7. Listar los almacenes que contienen los artículos A y los artículos B (ambos).
-----8. Listar los artículos que cuesten más de $100 o que estén compuestos por el material M1.
--9. Listar los materiales, código y descripción, provistos por proveedores de la ciudad de Rosario.
--10. Listar el código, descripción y precio de los artículos que se almacenan en A1.
--11. Listar la descripción de los materiales que componen el artículo B.
--12. Listar los nombres de los proveedores que proveen los materiales al almacén que Martín Gómez tiene a su cargo.
--13. Listar códigos y descripciones de los artículos compuestos por al menos un material provisto por el proveedor López.
--14. Hallar los códigos y nombres de los proveedores que proveen al menos un material que se usa en algún artículo 
    --cuyo precio es mayor a $100.
-----15. Listar los números de almacenes que tienen todos los artículos que incluyen el material con código 123.
-- 16. Listar los proveedores de Capital Federal que sean únicos proveedores de algún material.
--17. Listar el/los artículo/s de mayor precio.
--18. Listar el/los artículo/s de menor precio.
--19. Listar el promedio de precios de los artículos en cada almacén.
--20. Listar los almacenes que almacenan la mayor cantidad de artículos.
-----21. Listar los artículos compuestos por al menos 2 materiales.
--22. Listar los artículos compuestos por exactamente 2 materiales.
--23. Listar los artículos que estén compuestos con hasta 2 materiales.
--24. Listar los artículos compuestos por todos los materiales.
--25. Listar las ciudades donde existan proveedores que provean todos los materiales.

-----Adicionales
--1) - Listar los proveedores que fueron dados de alta en la década de 90
--2) - Listar el/los últimos proveedores dados de alta
--3) - Listar los artículos cuyo precio supera la media.
--4) - Listar todos los artículos y los materiales por los que están compuestos, informando “null” en el campo “material” 
	 --para el caso de los artículos que no están compuestos por ningún material
--5) - Listar todos los artículos y materiales por los cuales están compuestos. Mostrar articulos sin materiales
     -- y Materiales que no componen ningún artículo



	 --9. Listar los materiales, código y descripción, provistos por proveedores de la ciudad de Rosario.


	 select m.codmat, m.descripcion from material m 
	 inner join provisto_por pp on m.codmat = pp.codmat
	 inner join proveedor p on pp.codprov = p.codprov
	 where p.ciudad = 'Rosario'

	 --11. Listar la descripción de los materiales que componen el artículo B.

	 select m.descripcion from material m
	 inner join compuesto_por cp on cp.codmat = m.codmat
	 inner join articulo a on cp.codart = a.codart
	 where a.codart = 'B'

	 --12. Listar los nombres de los proveedores que proveen 
	 --los materiales al almacén que Martín Gómez tiene a su cargo.

	 -- proveedores - provisto por - compuesto_por - tiene - almacen

	 select p.nombre from proveedor p 
	 inner join provisto_por pp on p.codprov = pp.codprov
	 inner join compuesto_por cp on cp.codmat = pp.codmat
	 inner join tiene t on t.codart = cp.codart
	 inner join almacen a on a.nro = t.nro
	 where a.responsable = 'martincito'


	 --13. Listar códigos y descripciones de los artículos compuestos por al menos un material
	 -- provisto por el proveedor López.

	 -- articulo - compuesto por - /00material00/ - provisto por - proveedor

	 select a.codArt, a.descripcion from articulo a
	 inner join compuesto_por cp on cp.codart = a.codart
	 inner join provisto_por pp on pp.codmat = cp.codmat
	 inner join proveedor p on p.codprov = pp.cod prov
	 where p.nombre = 'López'

	 --14. Hallar los códigos y nombres de los proveedores que proveen al menos un material que se usa en algún artículo 
    --cuyo precio es mayor a $100.

	-- proveedor - provisto_por - compuesto_por - art 

	select p.codprov,p.nombre from proveedor p
	inner join provisto_por pp on p.codprov = pp.codprov
	inner join compuesto_por cp on pp.codmat = cp.codmat
	inner join articulo a on a.codart = cp.codart
	where a.precio > 100

	-----15. Listar los números de almacenes que tienen todos los artículos que incluyen el material con código 123.
	-- listar los nro de ALMACENES que no haya ARTICULO que no TENGA el material con codigo 123
	-- almacen - articulo - //compuestopor// - tiene  

	create view art123 as
	(
		select cp.codArt from compuesto_por cp where cp.codmat = '123'	
	)

	select a.nro from almacen a where not exists(
	select 1 from art123 art where not exists (
	select 1 from tiene t where a.nro = t.nro and art.codart = t. codart))

	-- 16. Listar los proveedores de Capital Federal que sean únicos proveedores de algún material.

	create view materiales_un_proveedor
	as(

	select pp.codmat, count(*) cant from provisto_por pp
	group by pp.codmat
	having count(*) = 1

	)

	select p.codprov from proveedor p
	inner join provisto_por pp on p.codprov = pp.codprov
	inner join materiales_un_proveedor mup on pp.codmat = mup.codmat
	where p.ciudad = 'CABA'

	--17. Listar el/los artículo/s de mayor precio.

	select * from articulo a 
	where precio = (select max(precio) from articulo)
	
	--19. Listar el promedio de precios de los artículos en cada almacén.

	select t.nro, isnull(avg(a.precio),0) from tiene t 
	inner join articulo a on t.codart = a.codart
	group by t.nro


	--20. Listar los almacenes que almacenan la mayor cantidad de artículos.

	create view mayorCantiART
	as
	(
		select t.nro,count(*) cantArt from tiene t --basicamente cuenta los almacenes - si existe un almacen, es un articulo del mismo
		group by t.nro
	
	)


	select mca.nro from mayorCantiART mca
	where mca.cantArt = (select max(mca.cantArt) from mayorcantiArt mca)




	-----21. Listar los artículos compuestos por al menos 2 materiales. (2 o más)

	create view dosomas 
	as
	(
	select cp.codArt from compuesto_por cp, compuesto_por cp2
	where cp.codart = cp2.codart and cp.codmat <> cp2.codmat
	
	)


	--23. Listar los artículos que estén compuestos con hasta 2 materiales. (más de 2)

	create view masdeDos
	as
	(
		select cp.codArt from compuesto_por cp, compuesto_por cp2, compuesto_por cp3
		where cp.codart = cp2.codart and cp.codart = cp3.codart and (cp.codmat <> cp2.codmat and cp.codmat <> cp3.codmat and cp2.codmat <> cp3.codmat )
	)

	--22. Listar los artículos compuestos por exactamente 2 materiales.

	


	--24. Listar los artículos compuestos por todos los materiales.

	-- listar todos los articulos en donde no haya material por el que no está compuesto

	select a.codArt from articulo a where not exists(
		select 1 from material m where not exists(
			select 1 from compuesto_por cp where cp.codArt = a.codArt and m.codmat = cp.codmat))


	--25. Listar las ciudades donde existan proveedores que provean todos los materiales.

	-- listar todas las ciudades en donde no haya un material que no sea provisto por un proveedor

	select p.ciudad from proveedor p where not exists(
		select 1 from material m where not exists(
			select from 1 provisto_por pp pp.codmat = m.codmat and p.codprov = pp.codprov))

	--ADICIONALES:
	--1) - Listar los proveedores que fueron dados de alta en la década de 90
	select p.codprov from proveedores p where p.fecha_alta between CONVERT(DATE,'01-01-1990',105) and CONVERT(DATE,'31-12-1999',105)


	--2) - Listar el/los últimos proveedores dados de alta

		SELECT Nombre
		FROM Proveedor
		WHERE fecha_alta = ALL (SELECT MIN(fecha_alta)
		FROM Proveedor)


			
	--3) - Listar los artículos cuyo precio supera la media.


	select a.codArt from articulo a where a.precio > (select avg(a.precio) from articulo a)

	--4) - Listar todos los artículos y los materiales por los que están compuestos, informando “null” en el campo “material” 
	 --para el caso de los artículos que no están compuestos por ningún material
	 -- listar todos los articulos y materiales por los no haya ningun material  por los que no estén compuestos

	 create view articulosYmat as
	 (
	select a.codart from articulos a where not exists(
	select 1 from material where not exists( select 1 from compuesto_por cp where cp.codMat = m.codMat and cp.codArt = a.codArt))
	)




	--5) - Listar todos los artículos y materiales por los cuales están compuestos. Mostrar articulos sin materiales
     -- y Materiales que no componen ningún artículo