-- 1-5. Listar los n�meros de almacenes que almacenan el art�culo A (1).


select * 
from almacen a inner join tiene t on a.Nro=t.NroAlmacen
where t.CodArt=1