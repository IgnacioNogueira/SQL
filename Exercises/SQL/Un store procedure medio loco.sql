-- Crear un store procedure que actualice el id de clientes y los pase a estado aprobado si la fecha es mayor a 15 días, sino poner un desaprobado

CREATE PROCEDURE nuevoIdCliente (@nuevoId BigInt, @estado varchar(50) OUTPUT,@fecha int)
AS
(
	set @nuevoId = (select c.id from cliente c)
	BEGIN
		if(@fecha > 15)
		Begin
			update Cliente set @nuevoId = @nuevoId + 1; 
			set @estado = 'Aprobado'
		end

		else
		begin
			set @estado = 'Desaprobado'
		end

		insert into cliente (id,estado,fecha)
		values(@nuevoId,@estado,@fecha)

	END
)

declare @fechaDias int = 15;
declare @nuevo int;
declare @estado2 varchar(200);



exec nuevoIdCliente @nuevo,@estado2 output, @fechaDias
 

