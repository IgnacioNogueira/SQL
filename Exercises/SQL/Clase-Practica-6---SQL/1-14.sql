----14. Hallar los c�digos y nombres de los proveedores que proveen al menos un material que se usa en alg�n art�culo 
    --cuyo precio es mayor a $100.


select p.CodProv, p.Nombre
from proveedor p inner join Provisto_Por pp on p.CodProv=pp.CodProv
		inner join Compuesto_Por cp on cp.CodMat=pp.CodMat
		inner join articulo a on a.CodArt=cp.CodArt
where a.Precio>100
