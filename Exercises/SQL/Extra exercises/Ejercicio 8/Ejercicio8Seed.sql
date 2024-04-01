CREATE TABLE Persona(
DNI int not null primary key,
nombre varchar(60))

CREATE TABLE Bar(
CodBar smallint not null primary key,
nombre varchar(50))

CREATE TABLE Cerveza (
IdCerv smallint not null PRIMARY KEY,
nombre VARCHAR(50)
);

CREATE TABLE Frecuenta(
persona int not null,
bar smallint not null,
CONSTRAINT PKFrecuenta primary key (persona,bar),
CONSTRAINT FK1Frecuenta FOREIGN KEY (persona) references Persona (DNI),
CONSTRAINT FK2Frecuenta FOREIGN KEY (bar) references Bar (CodBar)
)

CREATE TABLE Sirve(
bar smallint not null,
cerveza smallint not null
CONSTRAINT PKSirve primary key (bar,cerveza),
CONSTRAINT FK1Sirve FOREIGN KEY (bar) references Bar (CodBar),
CONSTRAINT FK2Sirve FOREIGN KEY (cerveza) references Cerveza (idCerv)
)

CREATE TABLE Gusta(
persona int not null,
cerveza smallint not null,
CONSTRAINT PKGusta primary key (persona,cerveza),
CONSTRAINT FK1Gusta FOREIGN KEY (persona) references Persona(DNI),
CONSTRAINT FK2Gusta FOREIGN KEY (cerveza) references Cerveza(IdCerv)
)


INSERT INTO Persona (DNI, nombre)
VALUES (1, 'Juan'), (2, 'Maria'), (3, 'Pedro'), (4, 'Lucia');

INSERT INTO Bar (CodBar, nombre)
VALUES (1, 'Bar 1'), (2, 'Bar 2'), (3, 'Bar 3');

INSERT INTO Cerveza (idCerv, nombre)
VALUES (1, 'Cerveza 1'), (2, 'Cerveza 2'), (3, 'Cerveza 3'), (4, 'Cerveza 4');

INSERT INTO Frecuenta (persona, bar)
VALUES (1, 2), (1, 3), (2, 1), (3, 2), (4, 3);

INSERT INTO Sirve (bar, cerveza)
VALUES (1, 2), (1, 3), (2, 1), (2, 4), (3, 1), (3, 3);

INSERT INTO Gusta (persona, cerveza)
VALUES (1, 2), (1, 3), (2, 1), (2, 4), (3, 1), (3, 3);
