-----25. Listar las ciudades donde existan proveedores que provean todos los materiales.

select *
from proveedor p
where not exists (
					select 1
					from material m
						where not exists (
											select 1
											from provisto_por pp
											where pp.CodMat=m.CodMat and pp.CodProv=p.CodProv))