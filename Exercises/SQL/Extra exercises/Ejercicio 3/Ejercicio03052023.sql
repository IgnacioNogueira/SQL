/*
Dada la siguiente base de datos:
Producto (idProducto, nombre, descrip, estado, idProveedor )
Proveedor (idProveedor, nombre, respdCivil, cuit)
Dirección ( idDir, idPers, calle, nro, piso, dpto )
Cliente (idCliente, nombre, respIVA, CUIL)
Vendedor (idEmpleado, nombre, apellido, DNI)
Venta (nroFactura, idCliente, fecha, idVendedor )
Detalle_venta(nroFactura,nro,idProducto, cantidad,precioUnitario)
NOTA: El precio unitario es necesario para almacenar los valores al momento de la venta*/use Ejercicio3--1. Indique la cantidad de productos que tiene la empresaSELECT p.Id_producto, COUNT(*) as 'CantProd', p.nombre, p.descripcion
FROM Producto p
GROUP BY p.Id_producto, p.nombre, p.descripcion

--2. Indique la cantidad de productos en estado 'en stock' que tiene la empresa.
SELECT COUNT(*) AS cantidad_productos_en_stock
FROM Producto
WHERE estado = 'en stock';

-- 3. Indique los productos que nunca fueron vendidos.SELECT p.* FROM Producto p where not exists (select 1 from Detalle_ventadv where p.Id_producto = dv.Id_producto)--4. Indique la cantidad de unidades que fueron vendidas de cada producto.SELECT p.Id_producto, p.Nombre FROM Producto p where EXISTS (select 1 from Detalle_ventadv where p.Id_producto = dv.Id_producto)--5. Indique cual es la cantidad promedio --   de unidades vendidas de cada producto.CREATE VIEW cantUVendidas AS(SELECT Id_producto,AVG(cantidad) AS CantProm_VendidosFROM Detalle_ventagroup by Id_producto)SELECT p.Id_producto, p.Nombre,cuv.CantProm_Vendidos FROM Producto p INNER JOIN cantUVendidas cuv ON p.Id_producto = cuv.Id_producto-- 6. Indique quien es el vendedor con mas ventas realizadasCREATE VIEW VENTAS_X_VEND AS(
SELECT v.Id_vendedor,count(*) 
as CantVtas FROM Venta v
group by v.Id_vendedor
)SELECT vxv.Id_vendedor FROM VENTAS_X_VEND vxvwhere vxv.CantVtas = (SELECT MAX(CantVtas) FROM VENTAS_X_VEND)-- 6. Indique quien es el vendedor CON NOMBRE Y APELL con mas ventas realizadasSELECT v.* FROM Vendedor vINNER JOIN VENTAS_X_VEND vxv ON v.Id_vendedor = vxv.Id_vendedorwhere vxv.CantVtas = (SELECT MAX(CantVtas) FROM VENTAS_X_VEND)--7. Indique todos los productos de lo que se hayan vendido más de 15.000 unidades.SELECT dv.Id_producto FROM Detalle_venta dvgroup by dv.Id_producto HAVING SUM(dv.cantidad) > 15000/*-- 8. Indique quien es el vendedor con mayor volumen de ventas.ALTER VIEW MAYOR_VOL_VTAS AS(SELECT v.Nro_factura,COUNT(*) as Vol_fact FROM Venta vgroup by v.Nro_factura)SELECT v.* FROM Vendedor vINNER JOIN MAYOR_VOL_VTAS mvv ON v. = mvv.where vxv.CantVtas = (SELECT MAX(Vol_fact) FROM MAYOR_VOL_VTAS)SELECT  FROM MAYOR_VOL_VTAS mvvwhere mvv.Vol_fact = (SELECT MAX(Vol_fact) FROM MAYOR_VOL_VTAS)*/--8. Indique los clientes que le han comprado a todos los vendedores.-- Liste todos los clientes en los que no haya habido un vendedor al que no les hayan compradoSELECT c.*
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



