select count (asignaturasid) as cant_asignaturas
from asignaturas
where area='5'


select*from Asignaturas
where Area=5

select nombre, count (asignaturasid) as cant_asignaturas 
from Asignaturas
where area='5'
group by nombre

--Tiene que tener sentido lo que consulto
select nombre  
from Asignaturas
where area='5'
group by nombre

--lo siguiente no tiene mucho sentido, no se ejecuta porque si agrupas los registros por nombre, tenes mas de un ID para cada nombre...

select nombre, AsignaturasID 
from Asignaturas
where area='5'
group by nombre