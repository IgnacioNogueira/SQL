-- ejercicio 1: clave primaria compuesta por los 4 campos - foranea a banco, moneda, persona

--Redactar las sentencias que permitan agregar las restricciones de integridad referencial permitiendo 
--la actualizacion automatica para el caso de actualizar o eliminar un banco o moneda.
--Demostrar el correcto funcionamiento de las restricciones creadas
--Redactar las sentencias que permitan eliminar las restricciones creadas en el paso anterior.

-- cascade: si lo borras, te borra los datos asociados a la tabla

alter table cuenta add constraint fk_banco_idBanco foreign key (idBanco) references Banco(id) on delete cascade on update cascade; --//generame la constraint que referencia el id de banco en cuenta. Si se borra o actualiza en banco, que también lo haga en cuenta en cascada
alter table cuenta add constraint fk_banco_idMoneda foreign key (idBanco) references Moneda(id) on delete cascade on update cascade;
alter table cuenta add constraint fk_banco_idPersona foreign key (idBanco) references Persona(id) on delete cascade on update cascade;

-- Ejercicio 2: Listar los bancos que solamente operan todas las monedas que no son el PESO URUGUAYO.
-- Utilizar una vista para todas las monedas.
-- COCIENTE ( Listar los bancos en los que solamente no hayan operado todas las monedas que no sean el peso uruguayo)

--BIEN
select b.* from Banco b
where not exists( select 1 from moneda m where m.id <> 'UR' and not exists( 
select 1 from Opera o where o.idBanco = b.id and m.id = o.idMoneda and b.pais <> 'Uruguay')
)

-- MAL 

select * from Moneda

create view TodasMenospUru
as
select * FROM Banco b where not exists(select 1 from Moneda m where m.id <> 'UY' and not exists (select 1 from Opera o where o.idMoneda = m.id and o.idBanco = b.id))

select * from TodasMenospUru tmpu where tmpu.id not in(select idBanco from opera o where o.idMoneda = 'UY')

-- 4- Crear una funcion que devuelva el valor oro de una moneda. La misma debe recibir como parametro el 
-- codigo de la moneda y devolver el valor -1 para el caso en que la moneda no exista.
-- Escribir la sentencia que prueba el correcto funcionamiento.


alter function f_valor_oro2 (@codigoMon char(2))
returns decimal (18,3)

BEGIN

declare @aux decimal(18,3);

if((select count(*) from moneda m where m.id = @codigoMon) = 0)
	set @aux = -1;
else
	PRINT('se pudo encontrar el valor')
	select @aux = m.valorOro from Moneda m where m.id = @codigoMon;
	-- también se puede hacer: SET @aux = (select m.valorOro from Moneda m where m.id = @codigoMon;)

	return @aux;

END


select dbo.f_valor_oro2 ('AR') as valorOro


-- asi no se hace ¿?
create function valorOro_moneda(@codigoMon char(2))
as
returns decimal (18,3)
BEGIN
	
	declare @aux decimal(18,3);

	if(@codigoMon is not null)
		return @codigoMon;
	else
		return @codigoMon = -1
END




--Ejercicio 5:
--Crear una funcion que retorne el pasaporte y el nombre de las personas que tienen cuenta en todos los bancos.
--Crear una función en la que no exista pasaporte y nombre de las personas en las que no tengan cuenta en todos los bancos
--Escribir la sentencia que prueba el correcto funcionamiento.

alter FUNCTION pasaporteNombrePer() returns table as
return (
	select p.pasaporte, p.nombre from Persona p where not exists(select * from Banco b where not exists(select * from Cuenta c where c.idPersona = p.pasaporte and c.idBanco = b.id) )
)

select * from pasaporteNombrePer


--6- Crear un SP que muestre por pantalla a las personas que tienen mas de 3 cuentas en dolares en bancos extranjeros. 
-- 
--Escribir la sentencia que prueba el correcto funcionamiento.

create procedure personasMás3cuentasUSSbe as

begin

select p.* from persona p where p.pasaporte in
(
	select p.pasaporte from persona p
	inner join cuenta c on p.pasaporte = c.idPersona inner join banco b on b.id = c.idBanco
	where c.idMoneda = 'US' and b.pais <> 'Argentina'
	group by p.pasaporte
	having count(*) >2  --como no tengo cant en cuentas, cuento las tuplas // sacar comentario para que funque

)
end

exec personasMás3cuentasUSSbe

--7- Crear un SP que reciba por parametro un pasaporte y muestre las cuentas asociadas a la misma. Si el pasaporte no existe, mostrar un mensaje de error.
-- Escribir la sentencia que prueba el correcto funcionamiento.

-- Crear una vista donde muestre pasaporte y muestre las cuentas asociadas a la misma. Si el pasaporte no existe, mostrar un mensaje de error.

create or alter view cuentas_pasaporte as
select isnull(count(p.pasaporte),0) from persona p where not exists (select 1 from banco b where not exists(select 1 from cuenta c where p.pasaporte = c.idPersona and b.id = c.idBanco ))


create procedure PasapCuentas (@pasaporte char(15)) as
BEGIN

	declare @aux integer;

	select @aux = count(*) from persona p where p.pasaporte = @pasaporte 

	if(@aux>0)
		select c.* from cuenta c where c.idPersona = @pasaporte
	else
		print('NO EXISTE EL PASAPORTE RECIBIDO POR PARAMETRO')

END

execute PasapCuentas 16


-- 9-
-- Crear un Trigger que actualice el id de moneda en las tablas opera y cuenta para cuando un codigo de moneda 
-- sea actualizado en la tabla moneda.
-- Escribir la sentencia que prueba el correcto funcionamiento.

CREATE TRIGGER T_UPDATE_MONEDA ON MONEDA FOR UPDATE 
AS
BEGIN
	declare @idMonedaViejo char(2);
	declare @idMonedaNuevo char(2);

	SELECT @idMonedaViejo = d.id from deleted d;
	SELECT @idMonedaNuevo = i.id from inserted i;

	update opera set idMoneda = @idMonedaNuevo where idMoneda = @idMonedaViejo;
	update cuenta set idMoneda = @idMonedaNuevo where idMoneda = @idMonedaViejo;



END

update moneda set id = 'UR' where id = 'UY'


select * from moneda
select * from opera
select * from cuenta





--///// Ya todo hecho PUNTO 1

alter table cuenta add constraint fk_banco_idBanco foreign key (idBanco) references Banco(id) on delete cascade on update cascade;
alter table cuenta add constraint fk_banco_idMoneda foreign key (idMoneda) references Moneda(id) on delete cascade on update cascade;
alter table cuenta add constraint fk_banco_idPersona foreign key (idPersona) references Persona(pasaporte) on delete cascade on update cascade;

alter table opera add constraint fk_opera_idBanco foreign key (idBanco) references Banco(id) on delete cascade on update cascade;
alter table opera add constraint fk_opera_idMoneda foreign key (idMoneda) references Moneda(id) on delete cascade on update cascade;



alter table cuenta drop constraint fk_banco_idBanco;
alter table cuenta drop constraint fk_banco_idMoneda;
alter table cuenta drop constraint fk_banco_idPersona;

alter table opera drop constraint fk_opera_idBanco;
alter table opera drop constraint fk_opera_idMoneda;
