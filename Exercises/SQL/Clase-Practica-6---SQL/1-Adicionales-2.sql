--5- Adicionales - II)- Listar el/los �ltimos proveedores dados de alta

SELECT Nombre
FROM Proveedor
WHERE fecha_alta = ALL (SELECT MIN(fecha_alta)
FROM Proveedor)