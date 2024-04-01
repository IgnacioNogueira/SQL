-- 1- Listar los proveedores que fueron dados de alta en la década de 90

SELECT *
FROM Proveedor
WHERE fecha_alta BETWEEN CONVERT(DATE,'01-01-1990',105) and CONVERT(DATE,'31-12-1999',105)