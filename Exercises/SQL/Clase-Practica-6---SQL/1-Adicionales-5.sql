-- 1- Adicionales-6-  Listar todos los artículos y materiales por los cuales están compuestos. Mostrar articulos sin 
		-- materiales y Materiales que no componen ningún artículo

select a.CodArt, a.Descripcion, m.CodMat as material_compuesto, m.Descripcion
from articulo a left join Compuesto_Por cp on a.CodArt=cp.CodArt 
	 full join material m on m.CodMat=cp.CodMat


-- OTRA FORMA CON DOS FULL OUTER


select a.CodArt, a.Descripcion, m.CodMat as material_compuesto, m.Descripcion
from articulo a full outer join Compuesto_Por cp on a.CodArt=cp.CodArt 
	 full outer join material m on m.CodMat=cp.CodMat