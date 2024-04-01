--18. Listar el/los artículo/s de menor precio.

select *
from articulo
where precio = (
				select min(precio)
				from articulo
				)