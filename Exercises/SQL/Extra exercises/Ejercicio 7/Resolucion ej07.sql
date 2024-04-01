use Ejercicio07-- 1. Indique cuales son los autos con mayor cantidad de kilómetros realizados en el último mes.-- auto viajeCREATE VIEW CantKilometrosViaje As (SELECT auto, SUM(kmTotales) SUM_KIL FROM Viaje WHERE FechaHoraInicio >= GETDATE()-30GROUP BY auto)/* // Si querría obtener los del mes actual, tendría que hacer la sig modificación en la vista:CREATE VIEW CantKilometrosViaje AS(
SELECT auto, SUM(kmTotales) AS SUM_KIL
FROM Viaje

---- WHERE YEAR(FechaHoraInicio) = YEAR(GETDATE()) AND MONTH(FechaHoraInicio) = MONTH(GETDATE()) ----

GROUP BY auto;

)
Si querría obtener los de hace dos meses, tendría que hacer la sig modificación en la vista
CREATE VIEW CantKilometrosViaje AS
SELECT auto, SUM(kmTotales) AS SUM_KIL
FROM Viaje

WHERE FechaHoraInicio >= DATEADD(MONTH, -2, GETDATE()) 

GROUP BY auto;

)*/select * from CantKilometrosViaje where SUM_KIL  = (select MAX(SUM_KIL) from CantKilometrosViaje)-- 2. Indique los clientes que más viajes hayan realizado con el mismo chofer.-- cliente viaje CREATE VIEW clienteConMasViajes AS(SELECT chofer,cliente,COUNT(*) CANT_VIAJES FROM ViajeGROUP BY chofer,cliente)SELECT * FROM clienteConMasViajes cmvwhere CANT_VIAJES = (SELECT MAX(CANT_VIAJES) FROM clienteConMasViajes)-- 3. Indique el o los clientes con mayor cantidad de viajes en este año.CREATE VIEW clienteConMasViajesEsteAño AS(SELECT cliente,COUNT(*) CANT_VIAJES FROM Viajewhere YEAR(FechaHoraInicio) = YEAR(GETDATE())GROUP BY cliente)SELECT * FROM clienteConMasViajesEsteAño cmvywhere CANT_VIAJES = (select max(CANT_VIAJES) from  clienteConMasViajesEsteAño)-- 4. Obtenga nombre y apellido de los choferes que no manejaron todos los vehículos
-- que disponemos.-- CHOFER VIAJE AUTO-- Liste nombre y apellido de los CHOFERES en donde exista AUTO que DISPONGAMOS-- y NO haya manejadoSELECT c.nombre,c.apellido FROM Chofer cWHERE EXISTS (SELECT 1 FROM AUTO aWHERE NOT EXISTS( SELECT 1 FROM Viaje vwhere v.chofer = c.NroLicencia and v.auto = a.matricula ))-- 5. Obtenga el nombre y apellido de los clientes que hayan viajado en todos nuestros autos.-- Liste los nombres y apellidos (nro) de los CLIENTES en los que NO haya un AUTO en el que no hayan VIAJADO (Viaje)SELECT c.nroCliente FROM Cliente c WHERE NOT EXISTS(SELECT * FROM Auto aWHERE NOT EXISTS(SELECT * FROM Viaje v WHEREv.cliente = c.nroCliente ANDv.auto = a.matricula))--6. Queremos conocer el tiempo de espera promedio de los viajes de los últimos 2
--meses

SELECT auto,AVG(esperaTotal) 'Tiempo de espera promedio' 
FROM VIAJE
where FechaHoraInicio >= DATEADD(MONTH, -2, GETDATE())
group by auto

-- 7. Indique los kilómetros realizados en viajes por cada auto.

SELECT auto, SUM(kmTotales) 
as 'kilómetros realizados en viajes' 
FROM Viaje
group by auto




-- 10. Indique la fecha inicial, el chofer y el cliente que hayan realizado el viaje más largo
-- de este año.
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

