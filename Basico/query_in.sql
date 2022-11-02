--vemos toda la tabla para ver de que trata
select*from Staff

--quiero que me devuelva solo esas columnas ahora
select Nombre,Apellido,Documento,Asignatura
from Staff

--filtro registros con cierta condicion USANDO " IN ": solo aquellos docentes que dan UX. RELACION CON OTRA TABLA

select Nombre,Apellido,Documento,Asignatura
from Staff
where Asignatura in ( SELECT AsignaturasID FROM Asignaturas where nombre like('%UX%'))

--fijate que devuelve lo que esta entre parentesis:
SELECT AsignaturasID 
FROM Asignaturas 
where nombre like('%UX%')
--de la tabla asignaturas, devolveme aquellos registros de la columna AsignaturadID que tengan UX en la columna nombre (hay varios con UX por eso pongo '%UX%')

select*from Asignaturas

--Se usa IN en vez de andar poniendo OR o AND