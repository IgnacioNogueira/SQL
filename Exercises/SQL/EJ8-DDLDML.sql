CREATE DATABASE Ejercicio8
USE Ejercicio8
GO

CREATE TABLE [dbo].[Frecuenta](
	[nombrePersona] [varchar](50) NOT NULL,
	[nombreBar] [varchar](50) NOT NULL,
);
CREATE TABLE [dbo].[Sirve2](
	[nombreBar] [varchar](50) NOT NULL,
	[nombreCerveza] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Sirve] PRIMARY KEY CLUSTERED 
(	[nombreBar] ASC,
	[nombreCerveza] ASC
));
CREATE TABLE [dbo].[Gusta](
	[nombreCerveza] [varchar](50) NOT NULL,
	[nombrePersona] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Gusta] PRIMARY KEY CLUSTERED 
(
	[nombreCerveza] ASC,
	[nombrePersona] ASC
));

INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Juan','Valinor');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Andrea','Valinor');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Mariano','Valinor');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Barbara','Duarte');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Barbara','Vita');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Barbara','Santa Birra');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Nicolas','Byra');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Nicolas','La Quintana');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Marcos','Jobs');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Marcos','La Birreria');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Francisco','La Birreria');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Francisco','Jobs');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Francisco','Vita');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Chloe','Vita');
INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES ('Zoe','La Ferneteria');

INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Juan','Quilmes');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Juan','Brahma');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Andrea','Stella');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Andrea','Andes');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Andrea','Quilmes');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Mariano','Stella');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Mariano','Andes');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Barbara','Brahma');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Barbara','Stella');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Bianca','Corona');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Chloe','Brahma');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Chloe','Stella');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Dominic','Corona');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Francisco','Sapporo');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Nicolas','Quilmes');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Nicolas','Stella');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Nicolas','Brahma');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Nicolas','Budweiser');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Marcos','Flensburger');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Marcos','Stella');
INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES ('Zoe','Corona');


INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Valinor','Stella');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Valinor','Quilmes');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Duarte','Brahma');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Duarte','Stella');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Santa Birra','Quilmes');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Byra','Quilmes');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Byra','Stella');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Byra','Brahma');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Byra','Andes');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('La Quintana','Andes');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('La Quintana','Budweiser');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Jobs','Budweiser');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Jobs','Flensburger');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Jobs','Stella');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('La Birreria','Flensburger');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Vita','Stella');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Vita','Brahma');
INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES ('Florida 165','Sapporo');
