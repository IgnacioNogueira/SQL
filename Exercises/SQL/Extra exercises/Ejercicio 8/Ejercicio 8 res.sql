/*
Usar el SQL para hallar las personas que:
2. No frecuentan ningún bar que sirva alguna cerveza que les guste.
3. Frecuentan solamente los bares que sirven todas las cervezas que les gustan.
4. Frecuentan solamente los bares que no sirven ninguna de las cervezas que no les
gusta.
*/

use Ejercicio8

-- 1. Frecuentan solamente bares que sirven alguna cerveza que les guste.
-- Listar PERSONAS tales NO haya CERVEZA que NO SIRVAN y NO les GUSTE en los BARES que FRECUENTAN
SELECT * FROM Persona p
		where not exists(
					select 1 from Cerveza c, Sirve s,Gusta g
							where c.idCerv = s.cerveza 
							  AND g.cerveza = c.idCerv
							  AND g.persona = p.DNI
							  AND exists( select 1 from Bar b, Frecuenta f
											where b.CodBar = s.bar 
											AND f.persona = p.DNI
											AND f.bar = b.CodBar
						))



--Revisar: Listar PERSONAS tales NO haya BAR que NO FRECUENTEN y NO SIRVAN CERVEZAS que NO les GUSTEn

SELECT * FROM Persona p
		where not exists(
					select 1 from Bar b where not exists(
													     select 1 from Frecuenta f, Sirve s, Gusta g
														 where f.persona = p.DNI 
														   AND s.bar = b.CodBar
														   AND s.cerveza <> g.cerveza
														   AND g.persona <> p.DNI))




