-- ejercicio 1: clave primaria compuesta por los 4 campos - foranea a banco, moneda, persona

--Redactar las sentencias que permitan agregar las restricciones de integridad referencial permitiendo 
--la actualizacion automatica para el caso de actualizar o eliminar un banco o moneda.
--Demostrar el correcto funcionamiento de las restricciones creadas
--Redactar las sentencias que permitan eliminar las restricciones creadas en el paso anterior.

-- cascade: si lo borras, te borra los datos asociados a la tabla

alter table cuenta add constraint fk_banco_idBanco foreign key (idBanco) references Banco(id) on delete cascade on update cascade; --//generame la constraint que referencia el id de banco en cuenta. Si se borra o actualiza en banco, que también lo haga en cuenta en cascada
alter table cuenta add constraint fk_banco_idMoneda foreign key (idBanco) references Moneda(id) on delete cascade on update cascade;
alter table cuenta add constraint fk_banco_idPersona foreign key (idBanco) references Persona(id) on delete cascade on update cascade;



-- 2-
-- Listar los bancos que solamente operan todas las monedas que no son el PESO URUGUAYO.
-- Utilizar una vista para todas las monedas.


-- listar todos los bancos en donde no haya moneda uruguayo que no haya sido operada

-- COCIENTE ( Listar los bancos en los que solamente no hayan operado todas las monedas que no sean el peso uruguayo)

create view monedasVistaUru
as(
select b.* from Banco b where not exists(
select 1 from Moneda m where m.descripcion = 'Peso uruguayo' and not exists(
select 1 from opera o where o.idMoneda = m.id and b.id = o.idBanco))
)

select * from monedasVistaUru mvu where mvu.id not in(select idBanco from opera o where o.idMoneda = 'UY')

-- 4- Crear una funcion que devuelva el valor oro de una moneda. La misma debe recibir como parametro el 
-- codigo de la moneda y devolver el valor -1 para el caso en que la moneda no exista.
-- Escribir la sentencia que prueba el correcto funcionamiento.


alter function valorOroMoneda (@codMon char(2))

returns decimal(18,3)

BEGIN
	declare @aux decimal(18,3);

	if((select count(*) from Moneda m where m.id = @codMon) = 0)
		set @aux = -1;
	else
		print('SE ENCONTRÓ EL VALOR')
		set @aux = (select m.valorOro from Moneda m where m.id = @codMon);

		return @aux;

END


--Ejercicio 5:
--Crear una funcion que retorne el pasaporte y el nombre de las personas que tienen cuenta en todos los bancos.
--Crear una función en la que no exista pasaporte y nombre de las personas
--en las que no tengan cuenta en todos los bancos
--Escribir la sentencia que prueba el correcto funcionamiento.

create function pasapNombrePerso() returns table as
return(select p.pasaporte,p.nombre from Persona p where not exists(select 1 from Banco b where not exists( select 1 from Cuenta c where c.idBanco = b.id and c.idPersona = p.pasaporte  ))

select * from pasapNombrePerso

--6- Crear un SP que muestre por pantalla a las personas 
--que tienen mas de 3 cuentas en dolares en bancos extranjeros. 
-- 
--Escribir la sentencia que prueba el correcto funcionamiento.
-- LISTAR TODAS LAS PERSONAS QUE NO HAYA BANCO EXTRANJERO EN DONDE NO TENGA MÁS DE 3 CUENTAS EN DOLARES

--Primero que faltan datos, segundo que falta el contar cosas . ta mal
SELECT p.* FROM PERSONA p
where not exists( select 1 from Banco b where b.pais = 'Argentina'
and not exists(select 1 from cuenta c where c.idBanco = b.id and p.pasaporte = c.idPersona))

create Procedure printPersoDolares
as
	BEGIN

	select p.* from Persona p where p.pasaporte in(

	select p.pasaporte from Persona p 
	inner join cuenta c on p.pasaporte = c.idPersona 
	inner join banco b on b.id = c.idBanco 
	where b.pais <> 'Argentina' and c.idMoneda = 'US'
	group by p.pasaporte
	having count(*) >2
	
	)


	END

exec printPersoDolares


-- 7- Crear un SP que reciba por parametro un pasaporte y muestre las cuentas asociadas a la misma. 
-- Si el pasaporte no existe, mostrar un mensaje de error.
-- Escribir la sentencia que prueba el correcto funcionamiento.

-- Crear una vista donde muestre pasaporte y muestre las cuentas asociadas a la misma. Si el pasaporte no existe, mostrar un mensaje de error.




alter procedure cuentasAsociadasPasap(@pasaporte char(15)) as

	BEGIN
	
	declare @auxPas integer;
	select @auxPas= count(*) from Persona p where p.pasaporte = @pasaporte;


	if(@auxPas > 0)
		select c.* from Cuenta c where c.idPersona = @pasaporte;
	else
		print('NO EXISTE EL PASAPORTE')

	END

exec cuentasAsociadasPasap 2



alter procedure PasapCuentas (@pasaporte char(15)) as
BEGIN

	declare @aux integer;

	select @aux = count(*) from persona p where p.pasaporte = @pasaporte 

	if(@aux>0)
		select c.* from cuenta c where c.idPersona = @pasaporte
	else
		print('NO EXISTE EL PASAPORTE RECIBIDO POR PARAMETRO')

END

execute PasapCuentas 2

-- 9-
-- Crear un Trigger que actualice el id de moneda 
--en las tablas opera y cuenta para cuando un codigo de moneda 
-- sea actualizado en la tabla moneda.
-- Escribir la sentencia que prueba el correcto funcionamiento.

create trigger actualizarIdMoneda on moneda for update
as
begin

declare @idMonedaViejo char(2);
declare @idMonedaNuevo char(2);

select @idMonedaViejo = d.id from deleted d;
select @idMonedaNuevo = i.id from inserted i;

update opera set idMoneda = @idMonedaNuevo where idMoneda = @idMonedaViejo;
update cuenta set idMoneda = @idMonedaNuevo where idMoneda = @idMonedaViejo;

end


update moneda set id = 'EU' WHERE id = 'ARG'
update moneda set id = 'UR' where id = 'UY'

