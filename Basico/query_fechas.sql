---FECHAS--- https://learn.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver16#GetDateandTimeParts


--DATENAME ( datepart , date )
--This function returns a character string representing the specified datepart of the specified date.

select
[Fecha Ingreso],
datename (month,[Fecha Ingreso]) as MesIngresado  -- datepart: month   date: [Fecha Ingreso]
from staff

--DATEDIFF ( datepart, startdate, enddate )
--Me devuelve la diferencia entre dos fechas

select
[Fecha Ingreso],
datediff(month,[Fecha Ingreso],GETDATE()) as meses_trabajando
from Staff