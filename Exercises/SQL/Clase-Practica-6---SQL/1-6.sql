--1-6. Listar los proveedores de Pergamino que se llamen P�rez.
SELECT CodProv
FROM Proveedor
WHERE Ciudad = 'Pergamino' AND Nombre LIKE '%Perez'