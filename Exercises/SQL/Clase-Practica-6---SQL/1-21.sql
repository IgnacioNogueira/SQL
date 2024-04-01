-----21. Listar los artículos compuestos por al menos 2 materiales.

select cp1.CodArt
from Compuesto_Por cp1, Compuesto_Por cp2
where cp1.CodArt=cp2.CodArt and cp1.CodMat<>cp2.CodMat


