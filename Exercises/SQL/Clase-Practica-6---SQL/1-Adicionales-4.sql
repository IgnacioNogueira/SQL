
-- 1- Adicionales - IV)- Listar todos los art�culos y los materiales por los que est�n compuestos, informando �null� 
			-- en el campo �material� para el caso de los art�culos que no est�n compuestos por ning�n material


SELECT A.CodArt, c.codMat
FROM Articulo A LEFT JOIN Compuesto_por C ON A.CodArt = C.CodArt
