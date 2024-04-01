--1.4. Listar los códigos de los materiales que provea el proveedor 3 y no los provea el proveedor 5.


-- NOT IN
SELECT CodMat
FROM Provisto_por
WHERE CodProv = 3 AND CodMat NOT IN (SELECT CodMat
FROM Provisto_por
WHERE CodProv = 5)

--
--NOT EXISTS
SELECT CodMat
FROM Provisto_por pp
WHERE CodProv = 3 AND NOT EXISTS (SELECT 1
FROM Provisto_por pp2
WHERE CodProv = 5 and pp.CodMat=pp2.CodMat)


--OTRA FORMA CON EXCEPT
SELECT CodMat
FROM Provisto_por
WHERE CodProv = 3
EXCEPT
SELECT CodMat
FROM Provisto_por
WHERE CodProv = 5


-- OTRA FORMA USANDO ALL
SELECT CodMat
FROM Provisto_por
WHERE CodProv = 3 AND CodMat <> ALL (
SELECT CodMat
FROM Provisto_por
WHERE CodProv = 5)