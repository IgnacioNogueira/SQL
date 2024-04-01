use Ejercicio12

/*p_EliminaSinstock(): Realizar un procedimiento que elimine los productos que no poseen stock*/

CREATE PROCEDURE p_EliminaSinstock()
AS
BEGIN
    DELETE FROM PRODUCTO
    WHERE CodProd IN (
        SELECT CodProd
        FROM STOCK
        WHERE Cantidad = 0
    )
END

/*p_ActualizaStock(): Para los casos que se presenten inconvenientes en los
datos, se necesita realizar un procedimiento que permita actualizar todos los
Stock_Actual de los productos, tomando los datos de la entidad Stock.

Para ello,
se utilizará como stock válido la última fecha en la cual se haya cargado el stock.*/

CREATE VIEW UltFecha_cargaStock 
AS
(
SELECT codProd,MAX(Fecha) AS UltFecha
FROM STOCK 
group by codProd
)

/*
ALTER PROCEDURE p_ActualizaStock
AS
BEGIN
select * from PRODUCTO
DECLARE @prodaAct int = (select distinct p.codProd from PRODUCTO p,STOCK s where p.StockActual <= 0 AND s.codProd = p.codProd)
DECLARE @cantProdStockProb int = (select count(*) from PRODUCTO where StockActual <= 0)
DECLARE @CondCant int

 while(@cantProdStockProb > 0)
 BEGIN
 set @CondCant = (select 1 from Stock s where s.codProd = @prodaAct AND s.Cantidad = 0)

	if(@CondCant = 0)  
	BEGIN
		update p 
		set p.StockActual = 10
		from PRODUCTO p

		update s 
		set s.Cantidad = 10 --lo dejo así porque sino tendría que hacer mucho quilombo
		from Stock s
	END
	else
	BEGIN
		UPDATE p
		set p.StockActual = s.Cantidad from PRODUCTO p,STOCK s,UltFecha_cargaStock ufs
		where p.CodProd = @prodaAct AND ufs.UltFecha = s.Fecha AND p.CodProd = ufs.codProd
	END
	set @cantProdStockProb = @cantProdStockProb -1
 END
 
END
*/



ALTER PROCEDURE p_ActualizaStock
AS
BEGIN
    DECLARE @prodaAct INT
    DECLARE @CondCant INT

    WHILE EXISTS (SELECT 1 FROM PRODUCTO WHERE StockActual <= 0)
    BEGIN
        SELECT TOP 1 @prodaAct = CodProd FROM PRODUCTO WHERE StockActual <= 0

        SET @CondCant = (SELECT CASE WHEN Cantidad = 0 THEN 1 ELSE 0 END FROM STOCK WHERE CodProd = @prodaAct)--este es el error?

        IF (@CondCant = 1)
        BEGIN
            UPDATE p
            SET p.StockActual = 10
            FROM PRODUCTO p
            WHERE p.CodProd = @prodaAct

            UPDATE s
            SET s.Cantidad = 10
            FROM STOCK s
            WHERE s.CodProd = @prodaAct
        END
        ELSE
        BEGIN
            UPDATE p
            SET p.StockActual = s.Cantidad
            FROM PRODUCTO p
            INNER JOIN STOCK s ON p.CodProd = s.CodProd
            WHERE p.CodProd = @prodaAct
                AND s.Fecha = (SELECT MAX(Fecha) FROM STOCK WHERE CodProd = @prodaAct)
        END
    END
END
/*

"Para un supermercado se tienen que actualizar el StockActual de la tabla "Productos" en base a la tabla "Stock" 
para que nuestro amigo henry, pueda tener un listado de los productos a comprar.
Para eso, el Store procedure a construir, deberá permitir actualizar todos los
StockActual de "Productos", tomando los datos de la entidad Stock.

Para ello,
se utilizará como stock válido la última fecha en la cual se haya cargado el stock. 
Si de casualidad el atributo Cantidad en la tabla Stock es igual a 0, se deberá incluir en el listado "Productos" el total de 10 unidades. 
En caso de que en Stock haya más de 1 unidad en su cantidad, nada más habría que actualizar en la tabla Producto (en su atributo StockActual),
la cantidad de unidades que haya en la tabla Stock"
*/

select * from STOCK
select * from PRODUCTO
exec p_ActualizaStock

/*p_DepuraProveedor(): Realizar un procedimiento que permita depurar todos los
proveedores de los cuales no se posea stock de ningún producto provisto desde
hace más de 1 año*/

-- Depurar los PROVEEDORES de los cuales NO haya provisto el PRODUCTO del que NO tengamos STOCK 
-- hace más de un año

CREATE VIEW CantStock_haceMasDeUnAño
AS
(
	SELECT s.codProd,COUNT(*) as CantProductos FROM STOCK s
    where s.Fecha < DATEADD(YEAR,-1,GETDATE()) --stocks que no han sido provistos desde hace más de 1 año
	group by s.codProd
	having count(*) = 0
	          
)

select * from PROVEEDOR

CREATE PROC p_DepuraProveedor
AS
BEGIN

  DELETE FROM PROVEEDOR
    WHERE CodProv NOT IN (
        SELECT DISTINCT p.CodProv
        FROM PRODUCTO p, CantStock_haceMasDeUnAño csma where p.CodProd = csma.codProd
    )
END

/*
p_InsertStock(nro,fecha,prod,cantidad): Realizar un procedimiento que permita
agregar stocks de productos. Al realizar la inserción se deberá validar que:

	a. El producto debe ser un producto existente
	b. La cantidad de stock del producto debe ser cualquier número entero
	mayor a cero.
	c. El número de stock será un valor correlativo que se irá agregando por
	cada nuevo stock de producto.

*/


ALTER PROCEDURE p_InsertStock(@nro int,@fecha date,@prod int,@cantidad int)
AS
BEGIN

DECLARE @ProdBusq int = (SELECT p.CodProd from Producto p
						  WHERE @prod = p.CodProd)

DECLARE @NuevoProd int = (select MAX(s.Nro) from Stock s) + @nro --para mi el enunciado está mal, pero qué le vamo a hacer

	IF(@ProdBusq is not null) 
		BEGIN
			IF(@cantidad > 0)
				BEGIN
					INSERT INTO STOCK(Nro, Fecha, CodProd, Cantidad) VALUES(@NuevoProd,@fecha,@ProdBusq, @cantidad)
				END
			ELSE
				BEGIN
					RAISERROR('Revise que la cantidad ingresada sea mayor a 0',10,2);
				END
		END
	ELSE
		BEGIN
			RAISERROR('Producto no existente, error',10,1);
		END
END

DECLARE @NroStock int = 1
DECLARE @fechaStock date = '18/06/2023'
DECLARE @prodStock int = 4
DECLARE @cantidadStock int = 5

SELECT s.* FROM STOCK s

EXEC p_InsertStock 1,'2023-06-18',5, 5

/*5 - tg_CrearStock: Realizar un trigger que permita automáticamente agregar un
registro en la entidad Stock, cada vez que se inserte un nuevo producto. El stock
inicial a tomar, será el valor del campo Stock_Actual.*/

CREATE TRIGGER tg_CrearStock
ON PRODUCTO
AFTER INSERT
AS
BEGIN
    INSERT INTO STOCK (Nro, Fecha, codProd, Cantidad)
    SELECT (SELECT ISNULL(MAX(Nro), 0) + 1 FROM STOCK), GETDATE(), CodProd, StockActual
    FROM inserted;

END;

insert into PRODUCTO(CodProd, Descripcion, CodProv, StockActual) values (7, 'Producto 7', 3, 6);

select * from PRODUCTO

select * from stock

/*p_ListaSinStock(): Crear un procedimiento que permita listar los productos que
no posean stock en este momento y que no haya ingresado ninguno en este
último mes. De estos productos, listar el código y nombre del producto, razón
social del proveedor y stock que se tenía al mes anterior.*/select p.* from producto pwhere p.CodProd IN( SELECT 1 FROM STOCK s where s.codProd = p.CodProd) CREATE VIEW PROD_SIN_STOCK_ultmesAS(SELECT p.CodProd FROM PRODUCTO p, Stock sWHERE p.CodProd = s.codProdAND MONTH(s.Fecha) < DATEADD(MONTH,-1,GETDATE())AND s.Cantidad = 0group by p.CodProd)/*SELECT *FROM STOCKSELECT *FROM PRODUCTODELETE FROM STOCK where Nro = 17DELETE FROM PRODUCTO where CodProd = 8disable TRIGGER tg_CrearStock ON PRODUCTOINSERT INTO STOCK (Nro, Fecha, codProd, Cantidad) VALUES(17,'2023-05-18',8,0)INSERT INTO PRODUCTO (CodProd, Descripcion, CodProv, StockActual) VALUES(8,'Producto 8',3,0)*/CREATE PROCEDURE p_ListaSinStock() --////////////////////REVISARRRRRASBEGINSELECT distinct p.CodProd,p.Descripcion,pr.RazonSocial as 'RS proveedor',s.Cantidad,s.Fecha FROM PRODUCTO p, PROVEEDOR pr, PROD_SIN_STOCK_ultmes pssum, STOCK swhere p.CodProv = pr.CodProv and pssum.CodProd = p.CodProdAND MONTH(s.Fecha) < DATEADD(MONTH,-1,GETDATE())END

