--1-7 Listar los almacenes que contienen los artículos A (1) y los artículos B (2) (ambos).


-- CON IN
SELECT NroAlmacen
FROM Tiene
WHERE CodArt = 1 AND NroAlmacen IN	(SELECT NroAlmacen
										FROM Tiene
										WHERE CodArt = 2)

-- OTRA FORMA CON INTERSECT
SELECT NroAlmacen
FROM Tiene
WHERE CodArt = 1
INTERSECT
SELECT NroAlmacen
FROM Tiene
WHERE CodArt = 2


-- CON EXISTS
SELECT t.NroAlmacen
FROM Tiene t
WHERE t.CodArt = 1 and EXISTS
				(SELECT 1
				FROM Tiene t2
				WHERE t2.CodArt = 2 and t2.NroAlmacen=t.NroAlmacen)