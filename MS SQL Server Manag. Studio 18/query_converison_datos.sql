----convertir datos-------


--sintaxis para CONVERT: CONVERT(data_type(length), expression, style)
select 
[Fecha Ingreso],
CONVERT(nvarchar(6),[Fecha Ingreso],112) AS YYYYMM
from Estudiantes

--style:112	 yyyymmdd





--sintaxis para CAST: CAST(expression AS datatype(length))

select
CAST(25.65 AS varchar);


select
cast(Costo*0.17 as decimal(7,3)) AS AUMENTO
from asignaturas
