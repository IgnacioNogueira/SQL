/*4-
Crear una funcion que devuelva el valor oro de una moneda.
La misma debe recibir como parametro el 
codigo de la moneda y devolver el valor -1 para el caso en que la moneda
no exista.
Escribir la sentencia que prueba el correcto funcionamiento
*/

CREATE FUNCTION VAL_ORO_MON(@codMon varchar(30)) RETURNS DECIMAL(18,3)
AS(
BEGIN
DECLARE @RET decimal(18,3)
set @RET = select m.cod from MONEDA m where codMon = m.cod;

if(@RET is null)
set @RET = -1

return @RET
END)

/*5-
Crear una funcion que retorne el pasaporte y el nombre
de las personas que tienen cuenta en todos los bancos.
Personas -> tal que no exista banco -> en la que no tenga cuenta
Escribir la sentencia que prueba el correcto funcionamiento.
*/

CREATE FUNCTION PERS_INFO_CTA_BCO() 
RETURNS TABLE as
RETURN(SELECT p.pas,p.nombre FROM PERSONA p
			where not exists(select 1 from BANCO b where 
			 not exists( select 1 from Cuenta c where c.cta = p.cta
			and p.codBanco = b.id ))


/*6-
Crear un SP que muestre por pantalla a las personas que
tienen mas de 2 cuentas en dolares en bancos extranjeros. 
Escribir la sentencia que prueba el correcto funcionamiento.*/

-- Listar PERSONAS en el que NO haya BANCO extranjero en el que NO tenga más de 2 CUENTAS en dolares


CREATE PROCEDURE CLI_BCO_EXT_MAS2
AS
BEGIN
    SELECT p.*
    FROM PERSONA p
    WHERE NOT EXISTS (
        SELECT 1
        FROM BANCO b
        JOIN CUENTA c ON b.sucursal = c.sucursal
        WHERE p.dni = c.dniPersona
            AND b.pais <> 'Argentina'
            AND b.moneda = 'US'
        GROUP BY p.dni
        HAVING COUNT(*) > 2
    )
END

/*7- 
Crear un SP que reciba por parametro un pasaporte y muestre
las cuentas asociadas a la misma. Si el pasaporte no existe, mostrar un mensaje de error.
Escribir la sentencia que prueba el correcto funcionamiento.*/

CREATE PROCEDURE ObtenerCuentasPorPasaporte (@Pasaporte VARCHAR(15))
AS
BEGIN
    -- Verificar si el pasaporte existe
    IF EXISTS(SELECT 1 FROM Persona WHERE Pasaporte = @Pasaporte)
    BEGIN
        -- Obtener las cuentas asociadas al pasaporte
        SELECT c.*
        FROM Cuenta c
        INNER JOIN Persona p ON c.DniPersona = p.DNI
        WHERE p.Pasaporte = @Pasaporte
    END
    ELSE
    BEGIN
        -- Mostrar mensaje de error si el pasaporte no existe
        PRINT 'El pasaporte especificado no existe.'
    END
END

EXEC ObtenerCuentasPorPasaporte @Pasaporte = 'ABCD1234'

/*
8-
Crear un Trigger que realice el respaldo de los datos de un Banco cuando
el mismo es eliminado. El trigger no debe 
permitir que se eliminen bancos que operan con la moneda "PESO ARGENTINO"
Se debe crear una tabla "banco_respaldo"
Escribir las sentencias que prueban el correcto funcionamiento.
*/

CREATE TABLE banco_respaldo
(
	idBco smallint not null primary key,
	nombreBco varchar(20),
	moneda float
)

CREATE TRIGGER RESP_BCO_PESO_ARG
ON BANCO
INSTEAD OF DELETE
AS
(
	BEGIN

	if not exists(select * from deleted where moneda = 'AR')
	BEGIN
		INSERT INTO banco_respaldo SELECT * FROM deleted
		DELETE FROM BANCO WHERE ID IN (SELECT id FROM deleted)  
	END
	ELSE
	PRINT('No puede eliminar bancos que manejen moneda argentina')

	END
)


/*9-
Crear un Trigger que actualice el 
id de moneda en las tablas opera
y cuenta para cuando un codigo de moneda 
sea actualizado en la tabla moneda.
Escribir la sentencia que prueba el correcto funcionamiento.
*/

CREATE TRIGGER ACT_IDMONEDA_OPYCTA
ON MONEDA FOR UPDATE
AS
BEGIN
--OPERA Y CUENTA
DECLARE @idMonedaVieja varchar(2)
DECLARE @idMonedaNueva varchar(2)

SET @idMonedaVieja = SELECT id from deleted 
SET @idMonedaNueva = SELECT id from inserted

UPDATE Opera set idMoneda = @idMonedaNueva where idMoneda = @idMonedaViejo 
UPDATE Cuenta set idMoneda = @idMonedaNueva where idMoneda = @idMonedaViejo

END