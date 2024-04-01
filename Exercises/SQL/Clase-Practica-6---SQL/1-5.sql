-- 1-5. Listar los números de almacenes que almacenan el artículo A (1).


select * 
from almacen a inner join tiene t on a.Nro=t.NroAlmacen
where t.CodArt=1