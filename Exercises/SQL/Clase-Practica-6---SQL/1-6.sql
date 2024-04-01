--1-6. Listar los proveedores de Pergamino que se llamen Pérez.
SELECT CodProv
FROM Proveedor
WHERE Ciudad = 'Pergamino' AND Nombre LIKE '%Perez'