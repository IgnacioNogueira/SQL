--18. Listar el/los art�culo/s de menor precio.

select *
from articulo
where precio = (
				select min(precio)
				from articulo
				)