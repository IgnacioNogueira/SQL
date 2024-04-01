-- 1-8. Listar los artículos que cuesten más de $100 o que estén compuestos por el material 1.
use ejercicio5;

SELECT A.CodArt
FROM Articulo A INNER JOIN Compuesto_por C ON A.CodArt = C.CodArt
WHERE A.Precio>100 OR C.CodMat = '1'


-- OTRA FORMA con UNION


SELECT A.CodArt
FROM Articulo A INNER JOIN Compuesto_por C ON A.CodArt = C.CodArt
WHERE A.Precio>100
UNION
SELECT A.CodArt
FROM Articulo A JOIN Compuesto_por C ON A.CodArt = C.CodArt
WHERE C.CodMat = '1'