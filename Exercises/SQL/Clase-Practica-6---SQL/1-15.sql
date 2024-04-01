--1-15 - Listar los números de almacenes que tienen todos los artículos que incluyen el material con código 1 (123).
Select *
from Almacen al
where not exists
				(select 1
				 from articulo a	 inner join compuesto_por cp on a.CodArt=cp.CodArt
				 where cp.CodMat=1 and not exists
								 (select 1
								  from tiene t
									where t.CodArt = a.CodArt and t.NroAlmacen=al.Nro
									)
				)


