
-- 1- Adicionales - IV)- Listar todos los artículos y los materiales por los que están compuestos, informando “null” 
			-- en el campo “material” para el caso de los artículos que no están compuestos por ningún material


SELECT A.CodArt, c.codMat
FROM Articulo A LEFT JOIN Compuesto_por C ON A.CodArt = C.CodArt
