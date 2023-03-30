# B**asics of the standard SQL**

SQL (Structured Query Language) es un lenguaje estandarizado para acceder y manipular bases de datos.

A pesar de que es un lenguaje ANSI/ISO estandarizado, puede haber algunas diferencias en la sintaxis según el programa que usemos para gestionar la base de datos (similar a los lenguajes y sus dialectos). 

Algunos ejemplos de sistemas para bases de datos relacionales son: MS SQL Server, IBM DB2, Oracle, MySQL, Microsoft Access, PostgreSQL, SQLite.

## Tablas

Las bases de datos relacionales guardan la info en tablas. Cada tabla tiene un nombre para poder ubicarla y ver que objetos contiene. Compuesta por columnas (atributos) y filas (registros, tuplas). Las columnas tienen nombre y contienen un tipo de dato especificado por la estructura o el modelo de la base.

Para sacar información de la base de datos realizamos consultas o querys. Para hacer un repaso general de los conceptos básicos voy a usar la siguiente tabla a modo de ejemplo.

| VIN** | Brand | Model | Price | Production_year |
| --- | --- | --- | --- | --- |
| LJCPCBLCX14500264 | Ford | Focus | 8000.00 | 2005 |
| WPOZZZ79ZTS372128 | Ford | Fusion | 12500.00 | 2008 |
| JF1BR93D7BG498281 | Toyota | Avensis | 11300.00 | 1999 |
| KLATF08Y1VB363636 | Volkswagen | Golf | 3270.00 | 1992 |
| 1M8GDM9AXKP042788 | Volkswagen | Golf | 13000.00 | 2010 |
| 1HGCM82633A004352 | Volkswagen | Jetta | 6420.00 | 2003 |
| 1G1YZ23J9P5800003 | Fiat | Punto | 5700.00 | 1999 |
| GS723HDSAK2399002 | Opel | Corsa | null | 2007 |

***vehicle identification number* (VIN)

Suponiendo que la tabla “Car” ya se encuentra en nuestra base de datos, podemos seleccionar toda la tabla con el siguiente comando:

```sql
SELECT *
FROM Car;
```

Notas: No todos los sistemas requieren el “;” pero es una buena practica. No hay distinción entre mayúsculas y minúsculas.

Si queremos seleccionar columnas especificas:

```sql
SELECT 
  model,
  price
FROM Car;
```

Notas: las columnas se separan por “,”

### Operadores condicionales

Nuestra tabla de ejemplo es chica pero, si tuviésemos muchos registros y quisiéramos filtrar según condiciones:

```sql
SELECT *
FROM Car
WHERE Production_year = 1999;
```

Existen otros operadores condicionales

- `<` (menor que),
- `>` (mayor que),
- `<=` (menor o igual),
- `>=` (mayor o igual).
- `!=`o a veces`<>` (diferente a)

Tambien tenemos los operadores `AND`, `OR`, `BETWEEN`,`NOT`. Si, por ejemplo, queremos seleccionar ciertas columnas para aquellos años de producción entre 1995 y 2005:

```sql
SELECT
  VIN,
  Brand,
  Model
FROM Car
WHERE production_year between 1995 and 2005;
```

Notas: según el sistema puede incluir o no a los limites cuando uso between. 

Podemos usar paréntesis:

```sql
SELECT
  VIN,
  Brand,
  Model
FROM Car
WHERE (production_year < 1995 or production_year > 2005)
  and (price<4000 or price>10000);
```

Si usamos texto va entre “ ”

```sql
SELECT*
FROM car
WHERE brand = 'Ford';
```

Si no conocemos exactamente el texto que estoy buscando podemos usar el operador `LIKE` y  el símbolo“%”. 

```sql
SELECT
  VIN,
  Brand,
  Model
FROM Car
WHERE brand LIKE 'F%';
```

Esto selecciona las columnas VIN, brand y model para aquellos registros donde la marca empieza con F.

Notas: el símbolo “%” significa <cualquier numero (0 o mas) de caracteres desconocidos> en la posición ubicada (antes o después de la F, en el ejemplo).

```sql
SELECT
  VIN
FROM Car
WHERE model LIKE '%s'; 

-- "%s%" cualquier palabra que contenga una s.
```

Para casos similares también podemos usar el “_”. Busca una coincidencia para el texto y un caracter desconocido. 

 Si quiero todos los registros de la marca Volkswagen y no recuero si el nombre se escribe con w o con v, por ejemplo:

```sql
SELECT*
FROM Car
WHERE brand LIKE 'Volks_agen';
```

Para otros tipos de operadores --> [SQL Operators](https://www.w3schools.com/sql/sql_operators.asp)

### Cálculos con operadores

Suponiendo que los autos tienen un impuesto del 20% de su precio y quiero información acerca de aquellos cuyo impuesto total es mayor que $2000:

```sql
SELECT*
2
FROM Car
3
WHERE (price*0.2) > 2000;
```

### Valores nulos

Los registros pueden contener valores nulos. Para seleccionar aquellos registros que contienen o no valores nulos uso `IS NULL`
e `IS NOT NULL`.

```sql
SELECT*
FROM Car
WHERE price IS NULL;
```

Me devuelve aquellos registros con valores nulos.
