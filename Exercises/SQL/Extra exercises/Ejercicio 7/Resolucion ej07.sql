use Ejercicio07
SELECT auto, SUM(kmTotales) AS SUM_KIL
FROM Viaje

---- WHERE YEAR(FechaHoraInicio) = YEAR(GETDATE()) AND MONTH(FechaHoraInicio) = MONTH(GETDATE()) ----

GROUP BY auto;

)
Si querr�a obtener los de hace dos meses, tendr�a que hacer la sig modificaci�n en la vista

SELECT auto, SUM(kmTotales) AS SUM_KIL
FROM Viaje

WHERE FechaHoraInicio >= DATEADD(MONTH, -2, GETDATE()) 

GROUP BY auto;

)
-- que disponemos.
--meses

SELECT auto,AVG(esperaTotal) 'Tiempo de espera promedio' 
FROM VIAJE
where FechaHoraInicio >= DATEADD(MONTH, -2, GETDATE())
group by auto

-- 7. Indique los kil�metros realizados en viajes por cada auto.

SELECT auto, SUM(kmTotales) 
as 'kil�metros realizados en viajes' 
FROM Viaje
group by auto




-- 10. Indique la fecha inicial, el chofer y el cliente que hayan realizado el viaje m�s largo
-- de este a�o.
DROP VIEW ViajeMasLargo

CREATE VIEW ViajeMasLargo AS(
select chofer, cliente, sum(kmTotales) SUM_KILOM from VIAJE 
where YEAR(FechaHoraInicio) = YEAR(GETDATE())
group by chofer,cliente
)


SELECT v.FechaHoraInicio, v.chofer, v.cliente
FROM ViajeMasLargo vml,Viaje v
WHERE vml.chofer = v.chofer 
AND vml.cliente = v.cliente 
AND SUM_KILOM = (Select MAX(SUM_KILOM) from ViajeMasLargo )
