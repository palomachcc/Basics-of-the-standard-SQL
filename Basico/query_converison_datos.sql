----convertir datos

select 
[Fecha Ingreso],
CONVERT(nvarchar(6),[Fecha Ingreso],112) AS YYYYMM
from Estudiantes

--style:112	 yyyymmdd


select
CAST(25.65 AS varchar);