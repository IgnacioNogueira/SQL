-- 1 - Adicionales - III)- Listar los art�culos cuyo precio supera la media.

SELECT a.CodArt, a.Descripcion
FROM Articulo a
WHERE a.precio > (SELECT AVG(precio)
FROM Articulo)