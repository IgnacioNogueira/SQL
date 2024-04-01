-- Indique la cantidad de productos que fueron vendidos

select p.Id_producto from producto p
where not exists (Select 1 from Detalle_venta dv where p.Id_producto = dv.Id_producto)

-- Indique la cantidad de unidades que fueron vendidas de c/prod

select p.Id_producto, sum(cantidad) 'Cantidad' from Producto p
inner join Detalle_venta dv on p.Id_producto = dv.Id_producto
group by p.Id_producto

-- Indique cual es la cantidad promedio de unidades vendidas de cada producto
select p.Id_producto, avg(cantidad) promedio from Producto p
inner join Detalle_venta dv on p.Id_producto = dv.Id_producto
group by p.Id_producto


-- Indique quien es el vendedor con más ventas realizadas

select v.Id_vendedor, v.Apellido,v.Nombre from Vendedor v
inner join Detalle_venta dv on dv.Cantidad


create view ventasXvend
as
(
	select v.Id_vendedor,count(*) as 'cantVentas' from Venta v
	group by v.Id_vendedor

)

select vxv.Id_vendedor, vxv.cantVentas from ventasXvend vxv
where vxv.cantVentas = (select max(cantVentas) from ventasXvend)

create view masVeinteUnidades
as
(
	select dv.i from detalle_venta dv
)

-- Indique todos los productos de los que se haya vendido más de 20 unidades

select dv.Id_producto,  p.Nombre, sum(dv.cantidad) 'Cantidad'
from Detalle_venta dv
inner join Producto p on p.Id_producto = dv.Id_producto
group by dv.Id_producto,p.Nombre
having sum(dv.Cantidad) > 20
 
-- 8. Indique los clientes que le han comprado a todos los vendedores


select v.Id_cliente, v.Id_vendedor from venta v
order by v.Id_cliente, v.Id_vendedor

--
--Indique todos los clientes en los que no haya vendedor en los que no le haya comprado
select c.Id_cliente from cliente c
where not exists( select 1 from Vendedor v where not exists 
(select 1 from Venta ven where ven.Id_vendedor = v.Id_vendedor and c.Id_cliente = ven.Id_cliente))

--

select v.Id_cliente,count(distinct v.Id_vendedor) 'cantidad compras' from venta v
group by v.Id_cliente
having count(distinct v.Id_vendedor) = (select count(*) from Vendedor)

