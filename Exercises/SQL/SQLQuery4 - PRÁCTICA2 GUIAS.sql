--Indique la cantidad de productos que tiene la empresa

SELECT count(*) as 'cant_productos' from Producto p

-- indique la cantidad de productos en estado 'stock' que tiene la empresa

SELECT count(*) as 'cant_productos' from Producto p WHERE p.Estado = 'stock'

-- INDIQUE LA CANTIDAD DE PRODUCTOS QUE FUERON VENDIDOS

select P.Id_producto FROM Producto p where not exists (select 1 from Detalle_venta hv where hv.Id_producto = P.Id_producto)

SELECT hdv.* FROM Producto p inner join Detalle_venta dv on p.Id_producto = p.Id_producto group by p.Id_producto

-- 6
CREATE VIEW ventas_x_vendedor
AS
SELECT vta.Id_vendedor, count(*) as 'CantVentas'
FROM venta vta
GROUP BY vta.Id_vendedor;


