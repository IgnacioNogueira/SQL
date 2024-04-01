/*Dado el siguiente esquema de relación:
Medición(fecha,hora,métrica,temperatura,presión,humedad,nivel)
Nivel (código, descripción)*/CREATE DATABASE Ejercicio13gouse Ejercicio13goCREATE TABLE Nivel(codigo int not null primary key,descripcion varchar(50))CREATE TABLE Medicion(fecha date,hora float,metrica float,CONSTRAINT PKMedicion primary key(fecha,hora,metrica),temperatura float,presion float,humedad float,nivel int,CONSTRAINT FKMedicion foreign key(nivel) REFERENCES Nivel(codigo))

-- Valores para la tabla Nivel
INSERT INTO Nivel (codigo, descripcion) VALUES
(1, 'Nivel 1'),
(2, 'Nivel 2'),
(3, 'Nivel 3');

-- Valores para la tabla Medicion
INSERT INTO Medicion (fecha, hora, metrica, temperatura, presion, humedad, nivel) VALUES
('2023-05-15', 12.5, 1.2, 25.5, 1013.2, 60.2, 1),
('2023-05-15', 13.0, 1.5, 26.1, 1014.5, 58.9, 2),
('2023-05-16', 9.8, 0.9, 24.3, 1012.7, 62.8, 1),
('2023-05-16', 10.2, 1.1, 25.8, 1014.1, 59.7, 2),
('2023-05-17', 11.6, 1.4, 26.5, 1013.9, 57.4, 3),
('2023-05-17', 12.0, 1.7, 27.2, 1015.3, 55.6, 1),
('2023-05-18', 14.3, 1.3, 25.7, 1014.2, 59.1, 2),
('2023-05-18', 14.8, 1.6, 26.8, 1015.7, 56.9, 3),
('2023-05-19', 10.5, 1.9, 27.9, 1016.4, 54.3, 1),
('2023-05-19', 11.0, 2.2, 28.5, 1017.1, 52.8, 2),
('2023-05-20', 13.7, 2.0, 27.6, 1015.8, 55.9, 3),
('2023-05-20', 14.2, 2.3, 28.9, 1017.4, 53.7, 1);

