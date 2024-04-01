-----1. Listar los nombres de los proveedores de la ciudad de La Plata.
-----1. Adicional.... Listar los proveedores cuya localidad contenga la cadena �Fernando�
-----2. Listar los n�meros de art�culos cuyo precio sea inferior a $10.
--3. Listar los responsables de los almacenes.
-----4. Listar los c�digos de los materiales que provea el proveedor 10 y no los provea el
      --proveedor 15.
-----5. Listar los n�meros de almacenes que almacenan el art�culo A.
-----6. Listar los proveedores de Pergamino que se llamen P�rez.
-----7. Listar los almacenes que contienen los art�culos A y los art�culos B (ambos).
-----8. Listar los art�culos que cuesten m�s de $100 o que est�n compuestos por el material M1.
--9. Listar los materiales, c�digo y descripci�n, provistos por proveedores de la ciudad de Rosario.
--10. Listar el c�digo, descripci�n y precio de los art�culos que se almacenan en A1.
--11. Listar la descripci�n de los materiales que componen el art�culo B.
--12. Listar los nombres de los proveedores que proveen los materiales al almac�n que Mart�n G�mez tiene a su cargo.
--13. Listar c�digos y descripciones de los art�culos compuestos por al menos un material provisto por el proveedor L�pez.
--14. Hallar los c�digos y nombres de los proveedores que proveen al menos un material que se usa en alg�n art�culo 
    --cuyo precio es mayor a $100.
-----15. Listar los n�meros de almacenes que tienen todos los art�culos que incluyen el material con c�digo 123.
-- 16. Listar los proveedores de Capital Federal que sean �nicos proveedores de alg�n material.
--17. Listar el/los art�culo/s de mayor precio.
--18. Listar el/los art�culo/s de menor precio.
--19. Listar el promedio de precios de los art�culos en cada almac�n.
--20. Listar los almacenes que almacenan la mayor cantidad de art�culos.
-----21. Listar los art�culos compuestos por al menos 2 materiales.
--22. Listar los art�culos compuestos por exactamente 2 materiales.
--23. Listar los art�culos que est�n compuestos con hasta 2 materiales.
--24. Listar los art�culos compuestos por todos los materiales.
--25. Listar las ciudades donde existan proveedores que provean todos los materiales.

-----Adicionales
--1) - Listar los proveedores que fueron dados de alta en la d�cada de 90
--2) - Listar el/los �ltimos proveedores dados de alta
--3) - Listar los art�culos cuyo precio supera la media.
--4) - Listar todos los art�culos y los materiales por los que est�n compuestos, informando �null� en el campo �material� 
	 --para el caso de los art�culos que no est�n compuestos por ning�n material
--5) - Listar todos los art�culos y materiales por los cuales est�n compuestos. Mostrar articulos sin materiales
     -- y Materiales que no componen ning�n art�culo



	 --9. Listar los materiales, c�digo y descripci�n, provistos por proveedores de la ciudad de Rosario.


	 select m.codmat, m.descripcion from material m 
	 inner join provisto_por pp on m.codmat = pp.codmat
	 inner join proveedor p on pp.codprov = p.codprov
	 where p.ciudad = 'Rosario'

	 --11. Listar la descripci�n de los materiales que componen el art�culo B.

	 select m.descripcion from material m
	 inner join compuesto_por cp on cp.codmat = m.codmat
	 inner join articulo a on cp.codart = a.codart
	 where a.codart = 'B'

	 --12. Listar los nombres de los proveedores que proveen 
	 --los materiales al almac�n que Mart�n G�mez tiene a su cargo.

	 -- proveedores - provisto por - compuesto_por - tiene - almacen

	 select p.nombre from proveedor p 
	 inner join provisto_por pp on p.codprov = pp.codprov
	 inner join compuesto_por cp on cp.codmat = pp.codmat
	 inner join tiene t on t.codart = cp.codart
	 inner join almacen a on a.nro = t.nro
	 where a.responsable = 'martincito'


	 --13. Listar c�digos y descripciones de los art�culos compuestos por al menos un material
	 -- provisto por el proveedor L�pez.

	 -- articulo - compuesto por - /00material00/ - provisto por - proveedor

	 select a.codArt, a.descripcion from articulo a
	 inner join compuesto_por cp on cp.codart = a.codart
	 inner join provisto_por pp on pp.codmat = cp.codmat
	 inner join proveedor p on p.codprov = pp.cod prov
	 where p.nombre = 'L�pez'

	 --14. Hallar los c�digos y nombres de los proveedores que proveen al menos un material que se usa en alg�n art�culo 
    --cuyo precio es mayor a $100.

	-- proveedor - provisto_por - compuesto_por - art 

	select p.codprov,p.nombre from proveedor p
	inner join provisto_por pp on p.codprov = pp.codprov
	inner join compuesto_por cp on pp.codmat = cp.codmat
	inner join articulo a on a.codart = cp.codart
	where a.precio > 100

	-----15. Listar los n�meros de almacenes que tienen todos los art�culos que incluyen el material con c�digo 123.
	-- listar los nro de ALMACENES que no haya ARTICULO que no TENGA el material con codigo 123
	-- almacen - articulo - //compuestopor// - tiene  

	create view art123 as
	(
		select cp.codArt from compuesto_por cp where cp.codmat = '123'	
	)

	select a.nro from almacen a where not exists(
	select 1 from art123 art where not exists (
	select 1 from tiene t where a.nro = t.nro and art.codart = t. codart))

	-- 16. Listar los proveedores de Capital Federal que sean �nicos proveedores de alg�n material.

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

	--17. Listar el/los art�culo/s de mayor precio.

	select * from articulo a 
	where precio = (select max(precio) from articulo)
	
	--19. Listar el promedio de precios de los art�culos en cada almac�n.

	select t.nro, isnull(avg(a.precio),0) from tiene t 
	inner join articulo a on t.codart = a.codart
	group by t.nro


	--20. Listar los almacenes que almacenan la mayor cantidad de art�culos.

	create view mayorCantiART
	as
	(
		select t.nro,count(*) cantArt from tiene t --basicamente cuenta los almacenes - si existe un almacen, es un articulo del mismo
		group by t.nro
	
	)


	select mca.nro from mayorCantiART mca
	where mca.cantArt = (select max(mca.cantArt) from mayorcantiArt mca)




	-----21. Listar los art�culos compuestos por al menos 2 materiales. (2 o m�s)

	create view dosomas 
	as
	(
	select cp.codArt from compuesto_por cp, compuesto_por cp2
	where cp.codart = cp2.codart and cp.codmat <> cp2.codmat
	
	)


	--23. Listar los art�culos que est�n compuestos con hasta 2 materiales. (m�s de 2)

	create view masdeDos
	as
	(
		select cp.codArt from compuesto_por cp, compuesto_por cp2, compuesto_por cp3
		where cp.codart = cp2.codart and cp.codart = cp3.codart and (cp.codmat <> cp2.codmat and cp.codmat <> cp3.codmat and cp2.codmat <> cp3.codmat )
	)

	--22. Listar los art�culos compuestos por exactamente 2 materiales.

	


	--24. Listar los art�culos compuestos por todos los materiales.

	-- listar todos los articulos en donde no haya material por el que no est� compuesto

	select a.codArt from articulo a where not exists(
		select 1 from material m where not exists(
			select 1 from compuesto_por cp where cp.codArt = a.codArt and m.codmat = cp.codmat))


	--25. Listar las ciudades donde existan proveedores que provean todos los materiales.

	-- listar todas las ciudades en donde no haya un material que no sea provisto por un proveedor

	select p.ciudad from proveedor p where not exists(
		select 1 from material m where not exists(
			select from 1 provisto_por pp pp.codmat = m.codmat and p.codprov = pp.codprov))

	--ADICIONALES:
	--1) - Listar los proveedores que fueron dados de alta en la d�cada de 90
	select p.codprov from proveedores p where p.fecha_alta between CONVERT(DATE,'01-01-1990',105) and CONVERT(DATE,'31-12-1999',105)


	--2) - Listar el/los �ltimos proveedores dados de alta

		SELECT Nombre
		FROM Proveedor
		WHERE fecha_alta = ALL (SELECT MIN(fecha_alta)
		FROM Proveedor)


			
	--3) - Listar los art�culos cuyo precio supera la media.


	select a.codArt from articulo a where a.precio > (select avg(a.precio) from articulo a)

	--4) - Listar todos los art�culos y los materiales por los que est�n compuestos, informando �null� en el campo �material� 
	 --para el caso de los art�culos que no est�n compuestos por ning�n material
	 -- listar todos los articulos y materiales por los no haya ningun material  por los que no est�n compuestos

	 create view articulosYmat as
	 (
	select a.codart from articulos a where not exists(
	select 1 from material where not exists( select 1 from compuesto_por cp where cp.codMat = m.codMat and cp.codArt = a.codArt))
	)




	--5) - Listar todos los art�culos y materiales por los cuales est�n compuestos. Mostrar articulos sin materiales
     -- y Materiales que no componen ning�n art�culo