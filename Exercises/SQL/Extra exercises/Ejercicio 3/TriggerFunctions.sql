-- Triggers
/*Ejemplo 1:
El siguiente Trigger incrementa en 1 la cantidad de ventas del vendedor que corresrnnda, cada vez que se hace una
Venta y se inserta un registro en la tabla VENTAS.*/
use Ejercicio3

CREATE TRIGGER INC_CANT_VTAS_VDOR
ON VENTA FOR INSERT
AS
UPDATE VENDEDOR
SET CantVtas = CantVtas + 1 /* no existe, pero lo pongo igual*/
WHERE Id_vendedor IN(SELECT i.Id_vendedor FROM inserted i )

/*Ejemplo 2:
Cada vez que se elimina un Producto, 
se guarda una copia de la fila eliminada en la tabla Producto_Eliminado que
tiene exactamente la misma estructura que la tabla*/

CREATE TRIGGER GUARD_COPIA_TABLA_ELIM 
ON Producto FOR DELETE
AS INSERT INTO Producto_Eliminado pe
where in (SELECT * FROM DELETED )

/*Ejemplo 3:
Cada vez que se intenta eliminar un Cliente, 
se acciona un Trigger antes que cancela la eliminación de la fila y
simplemente hace una marca de borrado lógico en la fila y 
guarda también la fecha del borrado.*/

CREATE TRIGGER BORRADO_LOGICO_INSTEAD_CANC 
ON Cliente INSTEAD OF DELETE
AS UPDATE Cliente
SET eliminado = 1, fecha_elim = GETDATE()
WHERE Id_cliente in (select Id_cliente from deleted)

/*
Ejemplo 4:
Cada vez que se modifica la tabla Cliente, se guarda la fila Vieja
(sin el cambio) y la fila Nueva (con el cambio) en una
tabla de Log.*/

CREATE TRIGGER FILA_VYN_TL
ON CLIENTE FOR UPDATE AS
BEGIN
INSERT INTO CLIENTE_LOG
SELECT  getdate(), d.Id_cliente as 'viejo' FROM DELETED d

INSERT INTO CLIENTE_LOG
SELECT  getdate(), i.Id_cliente as 'nuevo' FROM inserted i
END


-- FUNCIONES
/*Ejemplo 2: Función con valores de tabla de varias instrucciones
como parámetro un país y devuelve todos los clientes de ese país*/

CREATE FUNCTION CLIENTES_PAIS (@Pais varchar(40))
RETURN @clientes TABLE
(--datos de cliente
)
as
BEGIN
SELECT * FROM Cliente c
where c.pais = @Pais

END

CREATE TABLE CLIENTE_PAISX2(@Pais varchar(50))
RETURN TABLE AS
(SELECT * FROM Cliente c WHERE @Pais = c.pais )