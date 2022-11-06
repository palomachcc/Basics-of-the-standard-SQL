--JOIN principio

--------NIVEL TACTICO
--1.
--Identificar para cada área: el año y el mes de ingreso(concatenados en formato YYYYMM), cantidad de estudiantes y monto total de las asignaturas. 
--Ordenar por mes del más actual al más antiguo y por cantidad de clientes de mayor a menor.

--quiero Nombre del area, fecha , cantidad de estudiantes y total

select
 area.Nombre as Nombre_area,
 CONVERT(nvarchar(6),Estudiantes.[Fecha Ingreso],112) AS YYYYMM,
 count(estudiantes.estudiantesid) as Cantidad_estudiantes,
 sum(Asignaturas.Costo) as total
from Estudiantes
                 inner join Staff on Estudiantes.Docente=Staff.DocentesID
				 inner join Asignaturas on Asignaturas.AsignaturasID=Staff.Asignatura
				 inner join Area on Asignaturas.Area=Area.AreaID 

--group by estudiantes.[Fecha Ingreso],area.Nombre     --si yo pongo fecha de ingreso, me esta tomando la diferencia por el dia de ingreso tambien , por eso hay dos fechas iguales para dsata ponele
group by CONVERT(nvarchar(6),Estudiantes.[Fecha Ingreso],112),Area.Nombre
order by YYYYMM desc, Cantidad_estudiantes desc;

--lo mismo q arriba pero escrito algo dif
select 
 convert(varchar(6),Estudiantes.[Fecha Ingreso],112) as Año_mes,
 area.Nombre,
 count(estudiantes.EstudiantesID) as cant_estudiantes,
 sum(Asignaturas.costo) as costo_total
from Estudiantes
	inner join staff on Estudiantes.Docente=staff.DocentesID
	inner join Asignaturas on Staff.Asignatura=Asignaturas.AsignaturasID
	inner join Area on Area.AreaID=Asignaturas.Area

group by Area.Nombre,convert(varchar(6),Estudiantes.[Fecha Ingreso],112)
order by Año_mes desc, cant_estudiantes desc;

--2.Se requiere saber el id del encargado, el nombre, el apellido y cuantos son los docentes que tiene asignados cada encargado

select*from Staff
select*from Encargado

select
 encargado.Encargado_ID,
 encargado.Nombre,
 count(staff.docentesID) as cant_docentes
from Encargado 
	left join Staff on staff.Encargado=Encargado.Encargado_ID --si pongo inner join, no cuenta aquellos que dan cero docentes
where tipo like '%docentes%'
group by Encargado.Encargado_ID, Encargado.Nombre

--Luego filtrar los encargados que tienen como resultado 0 ya que son los encargados que NO tienen asignado un docente. Renombrar el campo de la operación como Cant_Docentes
--una opcion es agregar having count(staff.docentesID)=0 al codigo de arriba 

select
 encargado.Encargado_ID,
 encargado.Nombre,
 count(staff.docentesID) as cant_docentes
from Encargado 
	left join Staff on staff.Encargado=Encargado.Encargado_ID --si pongo inner join, no cuenta aquellos que dan cero docentes
where tipo like '%docentes%'
group by Encargado.Encargado_ID, Encargado.Nombre
having count(staff.docentesID)=0

--otra opcion con null y sin contar, digamos donde no haya coincidencia con docentes asignados
select
 encargado.Encargado_ID,
 encargado.Nombre,
 staff.docentesID as Docente_asignado_ID
from Encargado 
	left join Staff on staff.Encargado=Encargado.Encargado_ID
where tipo like '%docentes%' and staff.docentesID is null


--cuantos encargados de docentes hay?

select
 count(Encargado_ID) as cant_encargado_docentes
from Encargado
where Tipo like '%docente%'

--en el inner join de arriba, me devuelve resultados donde hay coincidencia entonces me estoy pasando por alto un dato, aquel que tiene cantidad de docentes CERO



--TIPS
--podes reenombrar las tablas para que sea mas facil llamarlas, en este caso con t1 y t2
select 
   count (t1.DocentesID) as Cant_docentes,
   t2.Jornada
from staff t1
inner join asignaturas t2
on t1.Asignatura=t2.AsignaturasID   
where t2.nombre='desarrollo web'
group by t2.Jornada

--3.Se requiere saber todos los datos de asignaturas que no tienen un docente asignado.El modelo de la consulta debe partir desde la tabla docentes.

select
t2.*
from Staff t1
	right join Asignaturas t2 on t2.AsignaturasID=t1.Asignatura
where t1.DocentesID is null

--para entenderlo mejor... puede no haber docentes asignados, en ese caso devuelve null.

select
t2.*,
t1.DocentesID as docente_asignado
from Staff t1
	right join Asignaturas t2 on t2.AsignaturasID=t1.Asignatura


--4. Hay encargados de tutores y de docentes. Quiero datos de los encargados de tutores. Los tutores tienen asignadas asignturas (nombre y jornada). Quiero los datos para jornadas noche
--nombre del encargado, el documento, el numero de la camada(solo el numero) y la fecha de ingreso del tutor.

select
CONCAT(E.Nombre,' ', E.Apellido ) as Nombre_encargado,
E.Documento,
right(s.Camada,5) as n_camada,
S.DocentesID,
A.Jornada
from Encargado E
	left join Staff S on S.Encargado=E.Encargado_ID
	left join Asignaturas A on A.AsignaturasID=S.Asignatura
where E.Tipo like '%tutor%' and A.Jornada like '%noche%'

--Si en el segundo join pones INNER JOIN, no te va a devolver aquellos registros nulos del primer join tampoco aunque el join anterior diga LEFT JOIN

---5.	Análisis asignaturas sin docentes o tutores: 
---	Identificar el tipo de asignatura, la jornada, la cantidad de áreas únicas y la cantidad total de asignaturas que no tienen asignadas docentes o tutores.
 

--vamos primero con tipo de asginatura,jornada, area y docente/tutor asignado o null si no hay

select
a.*,
s.DocentesID
from Asignaturas a
	full outer join Staff s on s.Asignatura=a.AsignaturasID

--si te fijas ahi aparece todas las asignaturas, aquellas sin docente/tutor asignado te pone null
select
count(AsignaturasID)
from Asignaturas

--ahora cual es la cantidad de asignaturas sin docente/tutor asignado y cantidad de areas, segun si es curso o carrera ?

select
a.Tipo,
a.jornada,
count(distinct a.Area) as cant_areas, --distinct cuenta solamente datos diferentes
count(a.AsignaturasID) as cant_asignaturas
from Asignaturas a
	full outer join Staff s on s.Asignatura=a.AsignaturasID
where s.DocentesID is null
group by a.tipo,a.Jornada

--6.Identificar el nombre de la asignatura, el costo de la asignatura y el promedio del costo de las asignaturas por área. (los precios varian segun la jornada)
--	Una vez obtenido el dato, del promedio se debe visualizar solo las carreras que se encuentran por encima del promedio. 

select
Nombre,
avg(Costo) as promedio_costo,
Area
from asignaturas
group by Nombre,Area


--promedio costo por area
select
avg(Costo) as promedio_costo,
Area
from asignaturas
group by Area


--el resultado anterior es una TABLA, entonces la idea es que usemos un JOIN con esa tabla. Quiero el nombre de la asginatura, el costo y el costo promedio para todas aquellas que 
--estan por encima del promedio del area

select
A.Nombre,
A.Costo,
A.Area,
promedio_costo
from Asignaturas a
	inner join (
		select 
			avg(Costo) as promedio_costo,
			Area 
			from asignaturas 
			group by Area
		) P 
	on P.Area=A.Area
where A.Costo>P.promedio_costo

--5.	Análisis aumento de salario docentes: 
--	Identificar el nombre, documento, el área, la asignatura y el aumento del salario del docente, este ultimo calcularlo sacándole un porcentaje al costo
--de la asignatura, todos las áreas tienen un porcentaje distinto, Marketing-17%, Diseño-20%, Programacion-23%, Producto-13%, Data-15%, Herramientas 8%

select
S.DocentesID,
S.Documento,
A.*,
cast(Costo*0.17 as decimal(7,3)) AS AUMENTO --EL 17% ES SOLO PARA MARKETING
from Staff S
inner join Asignaturas A on S.Asignatura=A.AsignaturasID
where A.Area=2 --where asignaturas.Nombre like '%marketing%'
union
select
S.DocentesID,
S.Documento,
A.*,
cast(Costo*0.20 as decimal(7,3)) AS AUMENTO --EL 20% ES SOLO PARA DISEÑO
from Staff S
inner join Asignaturas A on S.Asignatura=A.AsignaturasID
where A.Area=1
union
select
S.DocentesID,
S.Documento,
A.*,
cast(Costo*0.23 as decimal(7,3)) AS AUMENTO --programacion
from Staff S
inner join Asignaturas A on S.Asignatura=A.AsignaturasID
where A.Area=3
union
select
S.DocentesID,
S.Documento,
A.*,
cast(Costo*0.13 as decimal(7,3)) AS AUMENTO --producto
from Staff S
inner join Asignaturas A on S.Asignatura=A.AsignaturasID
where A.Area=4
union
select
S.DocentesID,
S.Documento,
A.*,
cast(Costo*0.15 as decimal(7,3)) AS AUMENTO --data
from Staff S
inner join Asignaturas A on S.Asignatura=A.AsignaturasID
where A.Area=5
union
select
S.DocentesID,
S.Documento,
A.*,
cast(Costo*0.08 as decimal(7,3)) AS AUMENTO --herramientas
from Staff S
inner join Asignaturas A on S.Asignatura=A.AsignaturasID
where A.Area=6

--NOTA en un join se puede usar concat con registros de dos tablas diferentes

select
concat (t1.nombre,' ',t1.Apellido) as NombreCompleto,
t1.Documento,
datename (month,[Fecha Ingreso]) as MesIngresado,
DATEDIFF(MONTH,t1.[Fecha Ingreso],GETDATE()) AS mesesdetrabajo,
concat (t2.Nombre,' ',t2.Apellido) as NombreEncargado,
t2.Telefono as Tel_Encargado
from staff t1 inner join Encargado t2
on t1.Encargado=t2.Encargado_ID


select 
concat (t1.nombre,' ',t1.Apellido) as Nombre_docente,
t1.Documento,
datename (month,[Fecha Ingreso]) as MesIngresado,
DATEDIFF(MONTH,t1.[Fecha Ingreso],GETDATE()) AS mesesdetrabajo,
concat (t2.Nombre,' ',t2.Apellido) as Encargado,
t2.Telefono as Tel_Encargado,
t3.Nombre as Curso_Carrera,
t3.Jornada,
t4.nombre as Area
from staff t1 
  inner join Encargado t2 on t1.Encargado=t2.Encargado_ID
  inner join Asignaturas t3 on t1.asignatura=t3.AsignaturasID
  inner join Area t4 on t3.Area=t4.AreaID 
where DATEDIFF(MONTH,t1.[Fecha Ingreso],GETDATE())>25
order by mesesdetrabajo desc

