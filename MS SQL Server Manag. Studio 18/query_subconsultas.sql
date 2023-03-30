--EJEMPLOS con group y order by. AVG, funciones con datos FECHA


--quiero saber cual es el costo promedio de cada asignatura (porque varian segun horario
select Nombre,tipo,AVG(Costo) as costo_promedio
from Asignaturas
group by Nombre,Tipo
order by costo_promedio desc

--quiero saber cual es el costo promedio de cada jornada

select Jornada,tipo, AVG(Costo) as costo_promedio
from Asignaturas
group by Jornada,tipo
order by Jornada desc

--quiero saber la edad de los estudiantes

Select Nombre,datediff (year,[Fecha de Nacimiento],GETDATE()) as edad
from Estudiantes
where datediff (year,[Fecha de Nacimiento],GETDATE())>18


--que asignaturas tienen algo de UX?
SELECT AsignaturasID,Nombre
FROM Asignaturas
WHERE Nombre like '%UX%'

--quiero saber que docentes dan UX.
--fijate que lo que esta entre parentesis es una columna, tiene varios datos, son ejemplos donde usas el IN
select Apellido,Documento,Asignatura
from Staff
where Asignatura in ( 
	SELECT AsignaturasID 
	FROM Asignaturas 
	where nombre like('%UX%')
	)

--quiero el 25% de aumento para las asignaturas del área de marketing de la jornada mañana. Para traer toda la tabla pongo " select*, ". 
-- resultado con tres decimales
select*,(Costo*1.25 ) as Costo_porcentaje, CAST( Costo*1.25 AS DECIMAL(10, 3)) as Costo_aumento
from Asignaturas
where area like 2 and Jornada like 'manana'

