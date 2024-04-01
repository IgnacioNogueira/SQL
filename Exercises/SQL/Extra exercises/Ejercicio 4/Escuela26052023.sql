/*
ALUMNO(dni, apellido, nombre, escuela)
HERMANO_DE(dniAlum, dniHno)
ESCUELA (cod, nombre, direccion)
ALIMENTO(id, descripcion, marca)
ALMUERZA_EN(dniAlum, idAlimento, codEscuela)
*/

use ESCUELA

--a) Listar a todos los alumnos que asisten a escuelas donde no
-- sirven alimentos y almuerzan en otro establecimiento

--Listar todos los alumnos en donde NO haya escuela a la que NO asistan
-- que NO sirvan alimentos y no almuerzan en la escuela

select distinct A.*
from Alumno A
join Almuerza_En AE on A.DNI = AE.DniAlumno
where A.CodEscuela <> AE.CodEscuela
and A.CodEscuela not in (
select CodEscuela
from almuerza_en
);

select a.* from alumno a where not exists(
select 1 from Escuela e where not exists(select 1 from Alimento ali INNER JOIN
Almuerza_En ae ON ali.IdAlimento = ae.idAlimento where ae.codEscuela = e.CodEscuela))


-- b) Mostrar todas las escuelas que sirven alimentos--    a todos sus alumnos que no tienen más de dos hermanos-- Listas todas las escuelas en las que NO haya alimentos que no sirvan -- para todos los alumnos tales que NO -- tengan más de dos hermanosselect distinct CodEscuela
from almuerza_en
where CodEscuela not in (
select distinct E1.CodEscuela
from Alumno E1
where not exists(
select 1
from Almuerza_En E2
join Alumno A on A.DNI = E2.DniAlumno
where DNI not in (
select DniAlumno
from Hermano_De
group by DniAlumno
having count(1) > 2
)
and E1.DNI = E2.DniAlumno
and E1.CodEscuela = E2.CodEscuela
)
);SELECT e.*
FROM ESCUELA e
WHERE NOT EXISTS (
    SELECT 1
    FROM ALUMNO a
    LEFT JOIN HERMANO_DE h ON a.DNI = h.DniAlumno
    WHERE a.CodEscuela = e.CodEscuela
    GROUP BY a.dni
    HAVING COUNT(h.DniAlumno) > 2
)
AND EXISTS (
    SELECT 1
    FROM ALUMNO a
    JOIN ALMUERZA_EN ae ON a.dni = ae.DniAlumno
    WHERE a.CodEscuela = e.CodEscuela
)
