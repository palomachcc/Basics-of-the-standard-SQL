select count (asignaturasid) as cant_asignaturas
from asignaturas
where area='5'


select*from Asignaturas
where Area=5

select nombre, count (asignaturasid) as cant_asignaturas 
from Asignaturas
where area='5'
group by nombre
