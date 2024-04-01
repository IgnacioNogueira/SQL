/*
Dada la siguiente base de datos:
Producto (idProducto, nombre, descrip, estado, idProveedor )
Proveedor (idProveedor, nombre, respdCivil, cuit)
Direcci�n ( idDir, idPers, calle, nro, piso, dpto )
Cliente (idCliente, nombre, respIVA, CUIL)
Vendedor (idEmpleado, nombre, apellido, DNI)
Venta (nroFactura, idCliente, fecha, idVendedor )
Detalle_venta(nroFactura,nro,idProducto, cantidad,precioUnitario)
NOTA: El precio unitario es necesario para almacenar los valores al momento de la venta
FROM Producto p
GROUP BY p.Id_producto, p.nombre, p.descripcion

--2. Indique la cantidad de productos en estado 'en stock' que tiene la empresa.
SELECT COUNT(*) AS cantidad_productos_en_stock
FROM Producto
WHERE estado = 'en stock';

-- 3. Indique los productos que nunca fueron vendidos.
SELECT v.Id_vendedor,count(*) 
as CantVtas FROM Venta v
group by v.Id_vendedor
)
FROM Cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM Vendedor v
    WHERE NOT EXISTS (
        SELECT 1
        FROM Venta ve
        WHERE ve.Id_cliente = c.Id_cliente AND ve.Id_vendedor = v.Id_vendedor
    )
);

-- Listar Clientes que compraron en todas las Sucursales de Avellaneda

-- Listar los clientes en los que NO haya habido
-- una sucursal de Avellaneda
-- en las que no hayan comprado

SELECT c.* FROM Cliente c 
where not exists (
select 1 from Direccion d where d.Calle = 'Avellaneda' and not Exists(
select 1 from Venta v where c.Id_cliente = v.Id_cliente))


