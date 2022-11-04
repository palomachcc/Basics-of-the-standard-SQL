---JOIN

--supongamos que quiero ver el nombre del alumno y el nombre del docente que le toca

select*from Estudiantes
select*from Staff

select 
	concat (estudiantes.nombre,' ',estudiantes.Apellido) as Estudiante,
	concat (Staff.nombre,' ',Staff.Apellido) as Docente
from Estudiantes
inner join Staff 
on Estudiantes.Docente=Staff.DocentesID

--cuantos alumnos tiene cada docente? devolviendo la lista con el nombre del docente, no con el ID

select 
	
	concat (Staff.nombre,' ',Staff.Apellido) as Docente,
	count (Estudiantes.EstudiantesID) as cantidad_Estudiantes
	
from Staff
inner join Estudiantes 
on staff.DocentesID=Estudiantes.Docente 
group by concat (Staff.nombre,' ',Staff.Apellido)


--fijate que hay docentes que no tienen ningun alumno asignado si notas la cantidad de la consulta anterior(286) y la cantidad de DocentesID(300).
--con FULL OUTER JOIN te devuelve los resultados nulos tambien
select 
	
	concat (Staff.nombre,' ',Staff.Apellido) as Docente,
	count (Estudiantes.EstudiantesID) as cantidad_Estudiantes
	
from Staff
full outer join Estudiantes 
on staff.DocentesID=Estudiantes.Docente 
group by concat (Staff.nombre,' ',Staff.Apellido)


---LEFT JOIN me devuelve todo lo de la izquierda y nulo del lado derecho si es que no hay coincidencxia
select 
	
	concat (Staff.nombre,' ',Staff.Apellido) as Docente,
	count (Estudiantes.EstudiantesID) as cantidad_Estudiantes
	
from Staff
left join Estudiantes 
on staff.DocentesID=Estudiantes.Docente 
group by concat (Staff.nombre,' ',Staff.Apellido)


--RIGHT JOIN me va a devolver todos los datos de la derecha, de la izquierda los que conincidan y sino null
select 
	
	concat (Staff.nombre,' ',Staff.Apellido) as Docente,
	count (Estudiantes.EstudiantesID) as cantidad_Estudiantes
	
from Staff
right join Estudiantes 
on staff.DocentesID=Estudiantes.Docente 
group by concat (Staff.nombre,' ',Staff.Apellido)