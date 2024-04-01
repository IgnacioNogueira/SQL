use Ejercicio13

/*1. p_CrearEntidades(): Realizar un procedimiento que permita crear las tablas
de nuestro modelo relacional.*/

CREATE PROCEDURE p_CrearEntidades
AS
BEGIN
CREATE TABLE Nivel(codigo int not null primary key,descripcion varchar(50))DROP TABLE MedicionCREATE TABLE Medicion(fecha date,hora TIME,metrica float,CONSTRAINT PKMedicion primary key(fecha,hora,metrica),temperatura float,presion float,humedad float,nivel int,CONSTRAINT FKMedicion foreign key(nivel) REFERENCES Nivel(codigo))


/*
2. f_ultimamedicion(Métrica): Realizar una función que devuelva la fecha y hora
de la última medición realizada en una métrica específica, la cual será enviada
por parámetro. La sintaxis de la función deberá respetar lo siguiente:
Fecha/hora = f_ultimamedicion(@vMetrica float))
Ejemplificar el uso de la función.
*/

CREATE FUNCTION f_ultimamedicion(@vMetrica float)
returns DATETIME
AS
BEGIN
	DECLARE @FechaHora DATETIME

	IF(@vMetrica > 0)
		BEGIN
			 SELECT TOP 1 @fechaHora =  CAST(fecha AS DATETIME) + CAST(hora AS DATETIME)
			 FROM Medicion
			 WHERE metrica = @vMetrica
			 ORDER BY fecha DESC, hora DESC;

		END
	ELSE
	BEGIN
		RAISERROR('La metrica enviada por parametro es incorrecta',10,1)
		SET @FechaHora = NULL;
	END

	RETURN @FechaHora
END

CREATE FUNCTION f_ultimamedicion (@vMetrica FLOAT)
RETURNS DATETIME
AS
BEGIN
    DECLARE @FechaHora DATETIME;

    IF (@vMetrica > 0)
    BEGIN
        SELECT TOP 1 @FechaHora = CAST(fecha AS DATETIME) + CAST(hora AS DATETIME)
        FROM Medicion
        WHERE metrica = @vMetrica
        ORDER BY fecha DESC, hora DESC;
    END
    ELSE
    BEGIN
        SET @FechaHora = NULL; --SE UTILIZA EN VEZ DEL RAISERROR PORQUE SINO GENERA EFECTOS SECUNDARIOS MEDIOS FALOPA
    END;

    RETURN @FechaHora;
END;

/*3. v_Listado: Realizar una vista que permita listar las métricas en las cuales se
hayan realizado, en la última semana, mediciones para todos los niveles
existentes. El resultado del listado deberá mostrar, el nombre de la métrica que
respete la condición enunciada, el máximo nivel de temperatura de la última
semana y la cantidad de mediciones realizadas también en la última semana.*/

CREATE VIEW v_Listado
AS
SELECT m.metrica AS [Nombre de la Métrica],
       MAX(m.temperatura) AS [Máximo Nivel de Temperatura],
       COUNT(*) AS [Cantidad de Mediciones]
FROM Medicion m
WHERE m.fecha >= DATEADD(WEEK, -1, GETDATE())
GROUP BY m.metrica;