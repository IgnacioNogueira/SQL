/* Listar a todos los alumnos que asisten a escuelas 
donde no sirven alimentos y almuerzan en otro establecimiento*/

-- Alumno escuela alimento almueza en escuela
-- Listar a los alumnos tales que NO ALMUERZAN en la escuela
-- y NO le sirven alimento en la escuela que asisten

use Ejercicio3

select distinct a.* from Alumno a,Almuerza_En ae
where a.CodEscuela <> ae.CodEscuela and a.DNI = ae.DniAlumno
and a.CodEscuela NOT in(SELECT CodEscuela FROM Almuerza_En)


-- listar todos los que alumnos que no tienen más de dos hermanos

SELECT a.*
FROM Alumno a
WHERE a.DNI NOT IN (
    SELECT DniAlumno
    FROM HERMANO_DE
    GROUP BY DniAlumno
    HAVING COUNT(*) > 2
);


/*Mostrar todas las escuelas que sirven alimentos
a todos sus alumnos que no tienen más de dos hermanos

ESCUELA ALIMENTO(ALMUERZA_EN) ALUMNO HERMANOS

-- Listar todas las escuelas en
donde no haya alimento
que no sirvan a sus alumnos que NO tienen más 
de dos hermanos

*/


SELECT e.*
FROM ESCUELA e
WHERE NOT EXISTS (
    SELECT 1
    FROM Alimento al, Almuerza_En ae  
    WHERE e.CodEscuela = ae.CodEscuela AND al.IdAlimento = ae.IdAlimento
	and ae.DniAlumno IN (
       SELECT 1
		FROM Alumno a
		WHERE a.DNI NOT IN (
				SELECT DniAlumno
				FROM HERMANO_DE
				GROUP BY DniAlumno
				HAVING COUNT(*) > 2
							)
))


