-----9. Listar los materiales, c�digo y descripci�n, provistos por proveedores de la ciudad de La Plata.

select m.*
from material m inner join Provisto_Por pp on m.CodMat=pp.CodMat
	inner join proveedor p on p.CodProv=pp.CodProv
where p.ciudad ='La Plata' 
